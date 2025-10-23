Return-Path: <linux-kernel+bounces-866773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EC67C009BD
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 13:01:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 40BB9359BA6
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 11:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 271832C0274;
	Thu, 23 Oct 2025 11:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Khbqm+8S"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0DA30C354
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 11:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761217300; cv=none; b=e7MWZdX4gBlmaKo9ePY+kIjZNqk4cJcQ+N6KgVA/R+EV3lkEgvWmP3T3aT4sxMFuolchTIIP6rBKaZ5LyEnqQASRU/e6VyF1BdcF+5ZNhrN9cwbzUIgRmZCwufsEtWyIHDm/JXPjqC3TEK+eUkAaaWbbIUCUBQt60S4EHoUc8ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761217300; c=relaxed/simple;
	bh=acORxjDGKnORTx6j/7QmmdQ6i6FPsWUKCG5ztHHl6+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TI5891ZtCMfKSYvo8MaSgMnQjd3+4Gujt6RTPVHtSsKdpCTeBXz+foj3HxxyT1T8jjaYnzjtSX17zngyfSBjmhOmKjLCOfNmNJM+VqY+UBuegBSEBsozl/D/a8waYHzBB+G8vQnv55wl8bNaTOkYZdZXAw4nSTzmPLojR2DovH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Khbqm+8S; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-427015003eeso631199f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 04:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761217297; x=1761822097; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q6U9a2Cy7mjvoZRssEb49g74q+K1a1YNWMrOof4a154=;
        b=Khbqm+8S8Fk6eJsngpqEsoGwd/6TaRKYz3qrk78hEmlHPLUQcFMB5pKFM+1xoIAWuj
         QYS9WYxuRxvFM1P1L97e/oBJe9D3zClbY/kscDF4ZUxysOjRGxierRSbxpG3enMygAoD
         UgIXh4GnhklYDe+SoMco8IVMciFRikkZM2gDIEmA0PmQukVPwdQLfJrJ/Q+OFu5ME2Qt
         OsAn6/RFQGsCfJ/r29L+RqU3bk7OclWGH2n62lu8ik7jLsG1QTtQqUI6r0qV0ctGukuB
         GXgcKDDPx/GFEQ3tSjl3wQjTArdng3rZFxAyuwlZ194EHJ+E2JXKLriq7ZWf2p5ytwqC
         +RSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761217297; x=1761822097;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q6U9a2Cy7mjvoZRssEb49g74q+K1a1YNWMrOof4a154=;
        b=P6DepTZvJj1k+f52s7tTDB1Mx0Fl8pOhrro/2/OYYNAdUouymtmfAl03o1nQIyXnHy
         7lN8XYWq32QBPvhe+7X2oENgavjCmUUswKRapv5LtVKggqMRChrqiAvki4N3N0ji0XAq
         l9mBi7EnXhcDrdSyiWYs0d8lnPZutCXhOKUxXvXcGTfz0CeN822ExWFgUSBM54OqBXfb
         F/XprJGPfA68xoCoi/3CUAdqBd3UDmV3+zg0Gd6Vpob06xhxv9jwbxIAtOnTykesKziy
         DXyehs6wnbKguvlvwIKnBkX9V0Jm9bGHEHrXOqPoY/a2DiFk7WHgejSxSG94tPDXai2I
         mX7w==
X-Forwarded-Encrypted: i=1; AJvYcCW296g4CSVIqHTw/EM24WWbZVxCWRJXqlSFlfJFxeIatfAI623OD64uktIErXS0dc4GfAkhOh0jrAsktEw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJFJB8Kjc5Dz6VteNwCFU558o9Qe/iOodxHOCTtRacKoP4ZrEb
	5aFJtiZsCqC3H4ClWV9Xyr1klOn7GXZqOC8zocm1Y4/DHWV5PZX22IjW
X-Gm-Gg: ASbGncs4sNbriSDyWQ6YzohtEhjJYvjzmVX8JWJJaP5UAZEFEsfEQbhqLw1sH6drqDE
	LboPI5QZIdFCyQs37qJbElICf3LHzNsVICgXki/lzHukGTDsZqt3Dc8GFaRxGV9HwX9VQwkbbYJ
	ZNgVx1n5YNlDC4loqqf7eFruIx2pZVDHrFtjAMEMgskd9wZ0FH12nHSq0zK3T384eT4QsNdyrj3
	qUANXE3Jrzy1YKlQ5K2bUHJTIg+ajtr0J7OU5XUQZO5HRkkaUNAfvcCz+u1w2TbzDtkDhG9m+LS
	W94/dRNROjo+cMRE6k04/yrBTohiqmPQSOnfPoF/wLBD1b4OFGIwuvKT4qyAVb3OhbvrtMTz5oN
	NrmARWcHToMIQjkFm1/diprHtytFV3EkVcHxARJRK11bq3VQZSBMkOWEeUNa0A715RC03uKY/aa
	nE21D2lQZ8VsymolE=
X-Google-Smtp-Source: AGHT+IEapGdsnbsARzHgqMt7pwyPik5jNaiTQ3NpmdvCWaP+cQHwZuOZPDEe5IzRDcAqcGtZcpPuiQ==
X-Received: by 2002:a5d:5f82:0:b0:40f:288e:9968 with SMTP id ffacd0b85a97d-42704db9eb7mr16255793f8f.51.1761217296901;
        Thu, 23 Oct 2025 04:01:36 -0700 (PDT)
Received: from shift.. ([86.124.201.90])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429898adf78sm3596420f8f.32.2025.10.23.04.01.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 04:01:36 -0700 (PDT)
From: Cezar Chiru <chiru.cezar.89@gmail.com>
To: andi.shyti@kernel.org,
	wsa+renesas@sang-engineering.com
Cc: linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Cezar Chiru <chiru.cezar.89@gmail.com>
Subject: [PATCH v1 2/2] i2c: pcf8584: Make pcf_doAddress() function void
Date: Thu, 23 Oct 2025 14:01:17 +0300
Message-ID: <20251023110118.7940-3-chiru.cezar.89@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251023110118.7940-1-chiru.cezar.89@gmail.com>
References: <20251023110118.7940-1-chiru.cezar.89@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change pcf_doAddress() function's type from int to void as it is always
returns 0. This way there is no need for extra assignment and extra checks
when the function is called.
Remove assignment of pcf_doAddress() and replace it with a simple function
call.

Signed-off-by: Cezar Chiru <chiru.cezar.89@gmail.com>
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


