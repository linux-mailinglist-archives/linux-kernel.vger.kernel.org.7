Return-Path: <linux-kernel+bounces-723294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88F29AFE577
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 12:16:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60A6A1C46122
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 10:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8096289352;
	Wed,  9 Jul 2025 10:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PXW+BKoX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D79B280A58;
	Wed,  9 Jul 2025 10:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752056015; cv=none; b=A7N2LgZKf0mHp1ywSWIbsw9t9tvTeg0TaOB5K1WCJRD7dP63oMx4Suxk2X0YEFHx4wV70XfPoyZjKWns6RaXacyQgBi7iTNVmBjZWVAlECZNALlMlZnSgzB23WENGkAJ+noNMA+Y3+VBCRiKdnu8Uv6inVWqWwgIzLlQVkcMIi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752056015; c=relaxed/simple;
	bh=gSFyCuV58GsmRO+dPDzRtN8p+D7dzXVCpOlR9aR5aHM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=nI6V28B/OESzID9hbgCu0R9WkOK7j0f4/qK+UFzxxOeGWUkVi9udrEYkE92jVMWIizrAb2m8KkjF80BBAVSHxeiUCiVNfzLr1IWOJlk7hdp6aemtrH6MJextlGfkVbRYYHbZeKh3tUiUwzxL1EcXLCHaH/uVm1KGXID9iUgYPW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PXW+BKoX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8E07C4CEEF;
	Wed,  9 Jul 2025 10:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752056014;
	bh=gSFyCuV58GsmRO+dPDzRtN8p+D7dzXVCpOlR9aR5aHM=;
	h=Date:From:To:Cc:Subject:From;
	b=PXW+BKoXey0l2zzwjHx88cK6czPXxsM/VgsTgWGwTlOnQJdoaCZeVn2ob0vVRGuGp
	 b0ePuqQNJErNp33d3CtbbukNY5BMYZeWSZLVJtBF0OMsfRFfXJXQ21Gk3rMKJcZOY/
	 Ze86CPBfU9oXZvBaBTlkVuxA4kR98OtcUJUjeHALJ/NyrlbTUj083TojDZOhtAuwZx
	 6rJn75Vw6Jb1CIxWmCrR46or0fHSWEHTQZH0v2tQ/VMU1USR7H9yzvEOCCfykBD5iy
	 Zoe5yH0hJ+Tu/npl0z5tJxos1f7xBM5fBF5lkZk0cahOKLZe/07t1x2jGRmL9g+X5p
	 093UoYLybD9Xw==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1uZRnr-0000000026W-2iC7;
	Wed, 09 Jul 2025 12:13:27 +0200
Date: Wed, 9 Jul 2025 12:13:27 +0200
From: Johan Hovold <johan@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] USB serial device id for 6.16-rc6
Message-ID: <aG5Axw9ZRN5_NNDq@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit e04c78d86a9699d136910cfc0bdcf01087e3267e:

  Linux 6.16-rc2 (2025-06-15 13:49:41 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial.git tags/usb-serial-6.16-rc6

for you to fetch changes up to 08f49cdb71f3759368fded4dbc9dde35a404ec2b:

  USB: serial: option: add Foxconn T99W640 (2025-06-24 10:45:43 +0200)

----------------------------------------------------------------
USB serial device id for 6.16-rc6

Here's a new modem device id.

Everything has been in linux-next with no reported issues.

----------------------------------------------------------------
Slark Xiao (1):
      USB: serial: option: add Foxconn T99W640

 drivers/usb/serial/option.c | 2 ++
 1 file changed, 2 insertions(+)

