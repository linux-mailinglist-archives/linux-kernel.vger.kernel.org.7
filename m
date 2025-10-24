Return-Path: <linux-kernel+bounces-868362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E85AC050A4
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 10:28:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A794150483D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 08:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57A49304BA0;
	Fri, 24 Oct 2025 08:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fus1PpdN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A003A3043DE;
	Fri, 24 Oct 2025 08:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761294417; cv=none; b=OeAPBTd0S34s5iHaiVJPuClHF8hKrsD8RU7T9MiqBTr9hl8qSmT/GuMrYJiMvdgc6/QHiPw7JVAHRS0aO9TuDvI0D4eH2GQwQAUFBfFS36hb7Cg/3XaMnU8LZQgbAAD26zluCeOQE79QNxuKvx/e6/g14UK4nH4PaYHGeib446Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761294417; c=relaxed/simple;
	bh=qEbBaSMUHf9ryHfO5wzH4XT4Jj7yN+vQaFLeTaGDy7A=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=bmHZXRshY+M7OfdCuhhYplh3FlW9UY5VS0o5TrAzQSkApPZ5lkB4sAKm7bP4EytCLWVqCpkGtEsQvQ8hptiUBQtqHf1O+KUmvz36jSnyDXT8foWGuu4x7r+qt+Vg2zvmvsCIFUxmTmyds5NABxy4ij1uFTJs74aSgjGvJGVqRwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fus1PpdN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F9CEC4CEF1;
	Fri, 24 Oct 2025 08:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761294417;
	bh=qEbBaSMUHf9ryHfO5wzH4XT4Jj7yN+vQaFLeTaGDy7A=;
	h=Date:From:To:Cc:Subject:From;
	b=fus1PpdNAScVNUsY+X+4spwrsbuEdHwOzgy7WjJuuvVwmP6LQJdimWBwPhEBzueCa
	 ODmDj9yghG/FFzw01T+m0g0XV4TRVaHBObZCNl2j8vwTS6bqfSZV2YZ1NkbByIF2R0
	 RZ6o/Ebs8NinKCKN/SXyUPyGEXoCsmmbS+1w0Zud8w9HHB4SpB9vtQ30SUAwfEi1S9
	 s8n/DgnKH6YXB7oxqji1wbY1Rqa8LqmPcVYjT+ctzzu6DNYWleEe58Eqqd9bpwOXG3
	 TacBz1OfoNNy0sHotfcv/cK3a3MSNbtdlvSHahN5EZhSrssBBXJ3pBoJ8OEBMy9nYs
	 NXs60pNFMqkjw==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vCD8a-000000001FD-0lcY;
	Fri, 24 Oct 2025 10:27:04 +0200
Date: Fri, 24 Oct 2025 10:27:04 +0200
From: Johan Hovold <johan@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] USB serial device ids for 6.18-rc3
Message-ID: <aPs4WBYBNtIKi2dz@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 3a8660878839faadb4f1a6dd72c3179c1df56787:

  Linux 6.18-rc1 (2025-10-12 13:42:36 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial.git tags/usb-serial-6.18-rc3

for you to fetch changes up to 622865c73ae30f254abdf182f4b66cccbe3e0f10:

  USB: serial: option: add Telit FN920C04 ECM compositions (2025-10-23 14:11:41 +0200)

----------------------------------------------------------------
USB serial device ids for 6.18-rc3

Here are some new modem device ids.

All have been in linux-next with no reported issues.

----------------------------------------------------------------
LI Qingwu (1):
      USB: serial: option: add Telit FN920C04 ECM compositions

Reinhard Speyerer (1):
      USB: serial: option: add Quectel RG255C

Renjun Wang (1):
      USB: serial: option: add UNISOC UIS7720

 drivers/usb/serial/option.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

