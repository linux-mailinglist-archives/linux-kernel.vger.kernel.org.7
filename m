Return-Path: <linux-kernel+bounces-885181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DBD7BC32351
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 18:03:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A18018C4267
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 17:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97D46339B42;
	Tue,  4 Nov 2025 17:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=starlabs-systems.20230601.gappssmtp.com header.i=@starlabs-systems.20230601.gappssmtp.com header.b="svoLgLHE"
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF44B23D294
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 17:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762275765; cv=none; b=Bh3a9REtsBMSWS/GFe1r7QfJrZQw8lxf55qbMK10/5do+XgYPZcXX5aU4sziTwhvQ+OgBYKRYJC8Jm8eALJi2oqdqxUk+K1s58SMun4nOasAGwzc5/L4zGvp/yofkn5tNw9rv+Pt4hKYk4BH7pTqAOKa805yQBFnhpGuxONwzbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762275765; c=relaxed/simple;
	bh=MzPVupqWefpcnRVfT1d4ZuvyvgSPKq9D9NFR17u2LNo=;
	h=MIME-Version:from:Date:Message-ID:Subject:To:Content-Type; b=b8TSc3Xy7X42yZKlDy0hdaYDSloUj8LBzj5H5M2+e9esxiYrTOZj6/4chAXU+D72IITFU/vYJrMLOawSQsNv/pDjkI9rLzW8dJMeRXAdgD1SabIGazpYjVskgmgpFbeHU8v2FRkCDSZzh6zHNUoaXv2bOV20cAIlVWm9y2DPugA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=starlabs.systems; spf=pass smtp.mailfrom=starlabs.systems; dkim=pass (2048-bit key) header.d=starlabs-systems.20230601.gappssmtp.com header.i=@starlabs-systems.20230601.gappssmtp.com header.b=svoLgLHE; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=starlabs.systems
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starlabs.systems
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-71d71bcab69so58953707b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 09:02:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=starlabs-systems.20230601.gappssmtp.com; s=20230601; t=1762275760; x=1762880560; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1swu1IewYCbikdsLGSbLmVIWwJe/h8V6mXFPSOZrFB0=;
        b=svoLgLHEiV/4RWrjlsPCpwpY38EJz0qiplB/qhqOtyUt6nB+YyuzUr2Ew0a6+QV2Vw
         w0Q5At6GD5i7M2ozBoF/dIOYNREqxWXKoG1GppIqfmDsbrdbwWw1P0YCSTFaNHNlAfFF
         pjfmCB/6ZApBq8+0W0g9lES9KembE3fX9IeEl0s6I/W3Wj+e2YNzB6rLicCU35fj4HIp
         odRKNIWuqzq10+2Lk9C1pSqwukPIjDSjUabSCzZi+HLs0GtQhxFcuh+g3H/aM63hWB0J
         egyx0swK55eY7OzrqqSrIHcK6DmpKI6MN7YK2dXWvQ0ewGaedx3ewxNUC99UQgYEnPuM
         f3qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762275760; x=1762880560;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1swu1IewYCbikdsLGSbLmVIWwJe/h8V6mXFPSOZrFB0=;
        b=cQywApHXcKtSs5yNx79K4Nzfi8LWysdZvptiHfKnU0TzXiDIDzPxKJ+tKXuUHoYAtZ
         rpy2bcZytKRiArGHab4SbzF/Tzb4DABoRIT5ueYjZ3NAXZo4aWGYaRgAa/QcqufZHDYJ
         t1KXnuBZVy4mCZi7alZ4h2ZLKum7W8lpBrtc8KLxFddx9GCwCV5pReoOpsDRVfanbjlN
         d6qzTtT304PPVIdcMsvPY22WGAioTAMDygpFPcIe99tgZ3Ww5qZzK/zWYNjKT5Lc/0I7
         +OpxgXBKVgi2z4M9aL6kqobmc4sKVu4F3Ot6qKmy3m1zFqZKmddPEQI+2Qs+NV+TmSUz
         6Xpw==
X-Gm-Message-State: AOJu0YyjUXGe1pO5ehccrlPOCdXPb6sGUq0xkH7bEdRYi0tKV7UpRgii
	RnLdppBDOfRePGJJIH9lwLFlfS6MHGF4BLH9Qe8ifPhjFbI46YEqaCsbqGlpETVp+bTlpbfu05/
	2bb8/Yi3ATMmen0ALNrT2iI7Ke76EEc+22q9RiCJ/clTkLtQrRhmJvw==
X-Gm-Gg: ASbGncvQWrVUQXZosb5FXOWBrlBTv95dQ9hY4nKKR09ZwFFCQ6AlVAmt+UY/J6ey/3F
	QtPZcTDHAyi6dkNbqjNfVjgwGvre0/02TuGofayl4f+tz3YDLpujAdKiRwXHYNmVzBKNM1/WQFP
	3mvbfm3p0m7YXoOiGYutk/6XPbnDzi3AmaTY7oV7m0XVa9+EGYqIzgX9lJbsTsHuElU5/2DY5r1
	h1yd9rfh2ibOq6HctgzTJYJYFY/IUM5Bed5dtufxOKizG2YzID9H781N2kdPw==
X-Google-Smtp-Source: AGHT+IFu5xWGolYVGEvsapdgHWBmKEvh/L6nUtcHvwxXkXWzfeUDeNLE6GBiE2YksVbOFA0BdSd1+FDrlj5P8vfa+f4=
X-Received: by 2002:a05:690e:164c:b0:629:acb6:d8a with SMTP id
 956f58d0204a3-63fd34c4ed5mr149758d50.26.1762275760139; Tue, 04 Nov 2025
 09:02:40 -0800 (PST)
Received: from 239600423368 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 4 Nov 2025 12:02:39 -0500
Received: from 239600423368 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 4 Nov 2025 12:02:39 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
from: Sean Rhodes <sean@starlabs.systems>
Date: Tue, 4 Nov 2025 12:02:39 -0500
X-Gm-Features: AWmQ_bmUXtIcjvu3hDD2CxDQXMRY9CP1oiMXn22Jfdvd6U_1FxjxLljnr0gEBC0
Message-ID: <CABtds-071dHPwOBYFxpGT7E9grcS0PGdK2PTYmcdWVF7sX-hkg@mail.gmail.com>
Subject: [PATCH] drivers/misc: rtsx_usb: add UHS/MMC capability flags
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From a7d64a86c728c8c749229272a22b95b772086911 Mon Sep 17 00:00:00 2001
From: Sean Rhodes <sean@starlabs.systems>
Date: Tue, 4 Nov 2025 15:51:10 +0000
Subject: [PATCH 2/5] drivers/misc: rtsx_usb: add UHS/MMC capability flags

Introduce per-device flags for SDR50, DDR50 and MMC DDR support and fill
them during probe for the RTS5139/RTS5140/RTS5179 variants so the card
host drivers can gate their caps in follow-up changes.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ricky Wu <ricky_wu@realtek.com>
Cc: Desnes Nunes <desnesn@redhat.com>
Cc: Christian Heusel <christian@heusel.eu>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Sean Rhodes <sean@starlabs.systems>
---
 drivers/misc/cardreader/rtsx_usb.c | 10 ++++++++++
 include/linux/rtsx_usb.h           |  3 +++
 2 files changed, 13 insertions(+)

diff --git a/drivers/misc/cardreader/rtsx_usb.c
b/drivers/misc/cardreader/rtsx_usb.c
index 1830e9ed2521..f65acf4d1164 100644
--- a/drivers/misc/cardreader/rtsx_usb.c
+++ b/drivers/misc/cardreader/rtsx_usb.c
@@ -653,12 +653,22 @@ static int rtsx_usb_probe(struct usb_interface *intf,
 	mutex_init(&ucr->dev_mutex);

 	ucr->pusb_intf = intf;
+	ucr->supports_sdr50 = false;
+	ucr->supports_ddr50 = false;
+	ucr->supports_mmc_ddr = false;

 	/* initialize */
 	ret = rtsx_usb_init_chip(ucr);
 	if (ret)
 		goto out_init_fail;

+	if ((ucr->product_id == 0x0139 && ucr->package == LQFP48) ||
+	    ucr->product_id == 0x0140 || ucr->is_rts5179) {
+		ucr->supports_sdr50 = true;
+		ucr->supports_ddr50 = true;
+		ucr->supports_mmc_ddr = true;
+	}
+
 	/* initialize USB SG transfer timer */
 	timer_setup(&ucr->sg_timer, rtsx_usb_sg_timed_out, 0);

diff --git a/include/linux/rtsx_usb.h b/include/linux/rtsx_usb.h
index 276b509c03e3..54c6ea82bf43 100644
--- a/include/linux/rtsx_usb.h
+++ b/include/linux/rtsx_usb.h
@@ -48,6 +48,9 @@ struct rtsx_ucr {
 	int			package;
 	u8			ic_version;
 	bool			is_rts5179;
+	bool			supports_sdr50;
+	bool			supports_ddr50;
+	bool			supports_mmc_ddr;

 	unsigned int		cur_clk;

-- 
2.51.0

