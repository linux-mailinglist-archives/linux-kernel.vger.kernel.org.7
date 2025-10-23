Return-Path: <linux-kernel+bounces-866890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC9A2C00F2F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 14:02:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBF771A07C53
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 12:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7B9E3101A8;
	Thu, 23 Oct 2025 12:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PE4BuMq9"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B60E30FC2E
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 12:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761220892; cv=none; b=qi5u91+o3s2yJvsC23ToW67u+slulyaExRXPaM4WPXV1nIKiZnCZP+UaPjKMlRjxW9ZQS7iE3FtjYRC7LY54TYJ38KwFpDtif2MXEGH+NV8TILX73qDVChpO4MMa7U/AHOlvv0+mjJUru8Wm+l+uT4DJ82lWPRSCGmAdUjrMcBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761220892; c=relaxed/simple;
	bh=vBh36brn/2ohhCsvBwa7uMXZhe6qtOYwOG6xdeMELnU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ECZKNw9B5BZEuw1pJCDXD/3JXn28eSxAUTUjWaBZR85Vj14SfJDQlLTDFHyReCPXPzrOYO9y14vbTidzD+5ssnALDUiLG5AVcV/t/25cWdbRI8PUsFosallmZdtIDiZ7xXX+QJ6OP82uFxeEsaKE7r/+EyYTUqFoz2q9HJj22AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PE4BuMq9; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-471066cfc2aso6990565e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 05:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761220889; x=1761825689; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jK/cyofPdzUjDgLppGWfFBjWYkuNfB9Yg6RkdFYdOoo=;
        b=PE4BuMq9iac4IiiymQJGPRooLFnf770uUx9Z7BAKrKIEJLqZJN81Zrcw1EAkINsYwT
         /kC55hMXXn9sK3jCIVHqMHHxPRvgV1gismsxo8A/LJtvMsR4C27H13tLnE2qSLM8IpOI
         NmjTF9vY0A/7odVf6BE4g7tVQ3/F6Dafo8La3e8cmt+kZxNC2h8reB32qBSiWKfrK+3v
         DPRUszOVy33KrTbUkAILoveGQbwKZ1HiSsCCe0YHZmLlcH02cqJw/C9S8ABEjxv/09hR
         hfKJgJ5eTP2MUZ3oaih9ZHsAxCG0N9Xnt3YtovZ81uLL85wXK1BL1xKyV8HsXETqvxZl
         O4JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761220889; x=1761825689;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jK/cyofPdzUjDgLppGWfFBjWYkuNfB9Yg6RkdFYdOoo=;
        b=X6P2hu38sBA8WPxwCwHg62t0fq7XgK5STPHDwTCmNVPOwgHYqihfUrtFA2G//NMQCF
         Oa1gBx/9jje8iAMpAOp8NJ0f1fI1SozL8Ccdop4X6K/GjzAJFu/tndtJqgxfxMK9G41d
         FySq+c6HeR0sS3OjAxi8kfFahZ8cdn65dmCFHIZ36RIKJ7B17U1dZn+NR5Qrs4rfwD2p
         Vp8wyn8ByRvzI/4aOuDLcS/KEwgZBC9U9J4LBDbVAwcN7j821qgiwMaLn2qWQrW3JgsH
         /PeSGntXUWvGMUrgxdN+5k/PhyyUsAa54ZLrxZg1xNFuym/cVp9q266VeARtMX4myAhd
         FMfw==
X-Forwarded-Encrypted: i=1; AJvYcCVrGY2qMIKCXeUtwwhSGJCCwCRijlJeB/Y6NGUHJuYVY4IUApg48sWzSz+zuoHpNBo4e6d1P+MQsVDGVAw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6DX870sANmgl84lFPnTXDISZfe+uAzaqMLvzMiuvBJY3EvmkP
	RWH2aJ6N7hEjRtWDDxhSlPWl9MWt0GLsXlj9zj4sjHIyinAUJR0nUBKY
X-Gm-Gg: ASbGncvLKMMCWB+5rmVIW/6WGxTgrFQ9c4N91zH7pnUkv7FG4jouTQKY0tX0gyuBT4V
	vWvcjL3wRNjDvCPMZjkOwwTuCXR4ztMF1RrfSAenkSX2+oNGuM87mQfD9O7ij7t5LG0DMzz3/kb
	l6E+129TArRu0KFXQYmA/dfNHqk895kzJb7fBVdAGwt2/ddW+J3m5vPSOnkalWuCnsFIWB8UZ66
	+k5BKZE2qqbuShY7OjjWpdBbSHjjd0QZHzrrgYbXWWbTd2TNU9ot7HDnralT4q/LSQ3Wcz/tQZy
	yXZPBodtArAU4c+s+tBd4mW6WV+cIypjDnO6QC2C98kSaCwyTynRPjsgv7+q/hqWa4PU4TW1v6X
	1RBBjHpAoETB9OQ5PziMrx7GElfgq44gTJqCjgF4AxV1G7YEQ4Mos6DB9FvtaiKqiOw32XbbKAA
	V40sbr5sOsmbQOO7Y=
X-Google-Smtp-Source: AGHT+IEcN8gKps1aDA2FDOlBdcaY4AnKVsS7T8mKA0uOegdRhW4g58Dhfx121HCKO/EhvjpXPHXBkA==
X-Received: by 2002:a05:600c:3b24:b0:46e:1abc:1811 with SMTP id 5b1f17b1804b1-47117912b6amr169488155e9.27.1761220888066;
        Thu, 23 Oct 2025 05:01:28 -0700 (PDT)
Received: from shift.. ([86.124.201.90])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475c43900e1sm109604435e9.17.2025.10.23.05.01.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 05:01:27 -0700 (PDT)
From: Cezar Chiru <chiru.cezar.89@gmail.com>
To: andi.shyti@kernel.org,
	wsa+renesas@sang-engineering.com
Cc: linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Cezar Chiru <chiru.cezar.89@gmail.com>
Subject: [PATCH v9 2/3] i2c: pcf8584: Make pcf_doAddress() function void
Date: Thu, 23 Oct 2025 15:00:42 +0300
Message-ID: <20251023120043.8661-3-chiru.cezar.89@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251023120043.8661-1-chiru.cezar.89@gmail.com>
References: <20251023120043.8661-1-chiru.cezar.89@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change pcf_doAddress() function's type from int to void as it always
returns 0. This way there is no need for extra assignment and extra checks
when the function is called.
Remove assignment of pcf_doAddress() and replace it with a simple function
call.

Signed-off-by: Cezar Chiru <chiru.cezar.89@gmail.com>
Suggested-by: Andi Shyti <andi.shyti@kernel.org>
---
 drivers/i2c/algos/i2c-algo-pcf.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/algos/i2c-algo-pcf.c b/drivers/i2c/algos/i2c-algo-pcf.c
index 06b9fd355bff..6352314e48ed 100644
--- a/drivers/i2c/algos/i2c-algo-pcf.c
+++ b/drivers/i2c/algos/i2c-algo-pcf.c
@@ -253,7 +253,7 @@ static int pcf_readbytes(struct i2c_adapter *i2c_adap, char *buf,
 }
 
 
-static int pcf_doAddress(struct i2c_algo_pcf_data *adap,
+static void pcf_doAddress(struct i2c_algo_pcf_data *adap,
 			 struct i2c_msg *msg)
 {
 	unsigned char addr = i2c_8bit_addr_from_msg(msg);
@@ -261,8 +261,6 @@ static int pcf_doAddress(struct i2c_algo_pcf_data *adap,
 	if (msg->flags & I2C_M_REV_DIR_ADDR)
 		addr ^= 1;
 	i2c_outb(adap, addr);
-
-	return 0;
 }
 
 static int pcf_xfer(struct i2c_adapter *i2c_adap,
@@ -288,7 +286,7 @@ static int pcf_xfer(struct i2c_adapter *i2c_adap,
 		int ret;
 
 		pmsg = &msgs[i];
-		ret = pcf_doAddress(adap, pmsg);
+		pcf_doAddress(adap, pmsg);
 
 		/* Send START */
 		if (i == 0)
-- 
2.43.0


