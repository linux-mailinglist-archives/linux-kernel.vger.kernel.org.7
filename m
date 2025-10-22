Return-Path: <linux-kernel+bounces-865353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CC1EBFCDDE
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 17:27:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D3751A06B98
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 15:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F255C34F24E;
	Wed, 22 Oct 2025 15:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BxMajb65"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D96934D4CC;
	Wed, 22 Oct 2025 15:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761146814; cv=none; b=fsdSbNO8WLMRz79CVapoNlDyKHKPtrdXtpOUywoPh2VYpDbQUg1ElB9ZWzKjN2HoGdltvLCFZN/3lM8lFYGMlWAkMxF9ESAwqadVu4S4rhdbkoupdrkKLmyKAsLf1w07w/E7Qv8lRA0xkjYOur1Hc6AtEncYou3JQRGAuwUYyeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761146814; c=relaxed/simple;
	bh=TQDSJ49yoXijtCkOpzPqesHfY4ISOmwA71jp+Dpmr6k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pGoM6cuCUXkILaeo0m6gmzclZGZI9xCUkVE8x6COtt/flY0UKO0bZKDyHqj77LYAsxIFBp+D59Np/B7JlfSnG8xt2wIATlBz0R/eC77h5a2zfVmF2o6Y1aGh1GwA+UK+rVepRJd2l8qaMrt1d5tBiHNL0dIg4PRV30BVsjubKpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BxMajb65; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED8A4C4CEE7;
	Wed, 22 Oct 2025 15:26:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761146813;
	bh=TQDSJ49yoXijtCkOpzPqesHfY4ISOmwA71jp+Dpmr6k=;
	h=From:To:Cc:Subject:Date:From;
	b=BxMajb65gmYB6uhV+/QAoPrbCDQfUf1Wt03S4olQlg9MnA/asCDJTYtO+eKCwKQhM
	 dBTLu5+d492sOMgFNEGfBpD67FxpdXzFHyCIqUT1FlXEJ7/H23N1LK8yT39lTCCVJU
	 YE8gLb7wlyFsLFHa6ta2dS8Qqa96olidD3OziZvXp+Xlp51xdaKdG+fxihuyDyFQDk
	 VXsChlBSelgO87rscBK5IlPh/z+bUFGPhWk6B9m4SifF4H6K6FH4kvAcYXHKft158l
	 X/5ovBui6oIbhEb2+YFIdgNKxgAsHu/gXQYKu1aXyfyF4/87h+WKKDLGdlywyCJKcP
	 h6qUxEI8gO3DQ==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vBajr-000000006JB-2FxQ;
	Wed, 22 Oct 2025 17:26:59 +0200
From: Johan Hovold <johan@kernel.org>
To: Johan Hovold <johan@kernel.org>
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/8] USB: serial: fix TIOCMBIS and TIOCMBIC
Date: Wed, 22 Oct 2025 17:26:32 +0200
Message-ID: <20251022152640.24212-1-johan@kernel.org>
X-Mailer: git-send-email 2.49.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Asserting or deasserting a modem control line using TIOCMBIS or TIOCMBIC
should not deassert any lines that are not in the mask, but two drivers
got this wrong.

Included are also some related cleanups.

Johan


Johan Hovold (8):
  USB: serial: belkin_sa: fix TIOCMBIS and TIOCMBIC
  USB: serial: kobil_sct: fix TIOCMBIS and TIOCMBIC
  USB: serial: belkin_sa: clean up tiocmset()
  USB: serial: kobil_sct: clean up tiocmset()
  USB: serial: kobil_sct: clean up device type checks
  USB: serial: kobil_sct: add control request helpers
  USB: serial: kobil_sct: clean up set_termios()
  USB: serial: kobil_sct: drop unnecessary initialisations

 drivers/usb/serial/belkin_sa.c |  42 +++----
 drivers/usb/serial/kobil_sct.c | 210 ++++++++++++---------------------
 2 files changed, 95 insertions(+), 157 deletions(-)

-- 
2.49.1


