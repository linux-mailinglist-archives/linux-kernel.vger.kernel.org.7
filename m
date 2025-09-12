Return-Path: <linux-kernel+bounces-813416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52289B54511
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 10:20:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C03704624B2
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 08:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F2972D5945;
	Fri, 12 Sep 2025 08:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i0vKrKkC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0DC26AA93;
	Fri, 12 Sep 2025 08:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757665196; cv=none; b=sjUWfX/FqIJKoCpY161pRt8NVK6PzpnymPWkzRj+vnoPcZNXqBYRJTo6ujkSWUh/uLzj+i1IZhfSOxV7htNJhi5/0s4ysHoSywg63Qyuy7IlCJoAmXahtS4jw39oPGqWconnCJsGdd/CAKXdA09Uxym1R3tcddKtbEPgdj3n41M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757665196; c=relaxed/simple;
	bh=+o5/jKDt/wxFKiLq+kYjcGmS+HaZr90aJYo/LWD5vo0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=aNWdKrRk6ZkbpG6f3lyAqGRjQ5HWHBf3nNuIQQeo+Hu+RKjxrFrA0iaqH2wm/yPAraoTlV/wsrO2dVIFYbUkwps0rKVg8+WpguOhuJaHDUzLf1FJLTV6vKuWMio5pQsI3/0iMbA1PaCLQt7zfUb0MJOailRy85idyN14v44yW3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i0vKrKkC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24808C4CEF4;
	Fri, 12 Sep 2025 08:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757665196;
	bh=+o5/jKDt/wxFKiLq+kYjcGmS+HaZr90aJYo/LWD5vo0=;
	h=Date:From:To:Cc:Subject:From;
	b=i0vKrKkC1cy0bebeYqOn3vYMMcNKEtIjBvqSL82jhey28e7WcqY5EnWasY5igZMZM
	 W5vFWzVSnQlMJfjBBHFO3/G6eL8XWB/eGY42/QjzjW1urTy3gNkYWnuweRbxTl0vZ8
	 nW1feGRmRNIBWMAcvK1fp5EHCBGy6frDlcI8q4NKJNkosEZP0AqzO3oZ24xL57gZpH
	 oKNtKzNXnSgg1s7ioux75WB/8VgO8+bLCv9SBGLCFIk/SrSrg3Yj6TeayESZkf+DLR
	 /OatWvV1WVfdGbiNEpRkQM/xHTB3QTx0IuruuULgbv5dCzpmeESQXDt7KjMWw9Lq6S
	 InFRoufHImW1g==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1uwz0Z-000000002RA-34TW;
	Fri, 12 Sep 2025 10:19:51 +0200
Date: Fri, 12 Sep 2025 10:19:51 +0200
From: Johan Hovold <johan@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] USB serial device ids for 6.17-rc6
Message-ID: <aMPXpwvBXg4ETste@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 1b237f190eb3d36f52dffe07a40b5eb210280e00:

  Linux 6.17-rc3 (2025-08-24 12:04:12 -0400)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial.git tags/usb-serial-6.17-rc6

for you to fetch changes up to a5a261bea9bf8444300d1067b4a73bedee5b5227:

  USB: serial: option: add Telit Cinterion LE910C4-WWX new compositions (2025-08-26 11:58:32 +0200)

----------------------------------------------------------------
USB serial device ids for 6.17-rc6

Here are some new modem device ids.

Everything has been in linux-next with no reported issues.

----------------------------------------------------------------
Fabio Porcedda (2):
      USB: serial: option: add Telit Cinterion FN990A w/audio compositions
      USB: serial: option: add Telit Cinterion LE910C4-WWX new compositions

 drivers/usb/serial/option.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

