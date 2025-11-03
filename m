Return-Path: <linux-kernel+bounces-883064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DBDD4C2C65F
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 15:25:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 593871897AC1
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 14:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0D73226D02;
	Mon,  3 Nov 2025 14:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GpHfzqJq"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53BD23B62C
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 14:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762179928; cv=none; b=Oy1PuAvufNxOWuBycGg2MyHhv5RqchG8XtgfCPfecAdgUsxwnckWLxnXM+lOuBtYgLhhL7Wf2Yitb/QQ3KMHhTq+Cjk8nwSh+01gBLorf31/0y4WpV0yBFuhL9pH4szeVwH/8ze4gJ6C0MaNdKTgIthz08R8ixsfzhfH4SAHBXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762179928; c=relaxed/simple;
	bh=xWMYardQHnIaK12l1ryDr3bjsr+pXFGz+yDLvCdz8aM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X7mFrzJLHMyutxQqewIkq+iftiUDSGtkklB5ICuzza0KasR/uECTYc4hG9MsgvU7NP3LUcIuBmH5FRijRIJik3GaP8EhpQMmZh2zNsp5RSeoo9rssyfi6fMHUXgmhzadp7kGGWdswAfgyjZPtcnk2BEb7M+5CaPek4TI0GG7FK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GpHfzqJq; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-47728f914a4so22565465e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 06:25:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762179925; x=1762784725; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=l0eHvLoiid9wDCxuP//NlqPdvxc5VD66YHxv5DH3KtE=;
        b=GpHfzqJqfv+4NhnDs7wBZ3N21ZMxK313TY7qWEo+iIpRbnsiAo4d8gmzCAeM4Nn2Tm
         NQOZoEJJRTpyHVJovzK8apqm/5SDXqtYLQ4o54YRBpQjdKd2NWzdoCMNUI9O9ejzohyf
         xBrbA86jKMk7p9NP8PdgJOfpqF8ioxtw8Bx6nkk/YBKGCJLmZiY0kR/AezvUsjBb4mZM
         q0aOcOOeldLJ5ibkrw6iYda69aoxjG5bVhQk84ToPmYC6SMas9g5Firr6NKw4ujGCyMr
         lmj67toayoNq3ptMAKxLBeBAWGkkHWXIvSRF32gV7H8AAolEX6UpK+Q+Zx+U9X18vWsL
         vTVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762179925; x=1762784725;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l0eHvLoiid9wDCxuP//NlqPdvxc5VD66YHxv5DH3KtE=;
        b=El2TRUmnK/7xiE29hxctc7qkuwGPeHO0s8dTA84/P+0gLrAiXwl1DNKAPKiIVqODlD
         TGR34wbzv+kDpu77MaAfd2nSfuXFMUTnOgCMprKNShG/mCBIJWZxOwivyyEE7tfR/rJE
         02fzbnMYb/G2a0ZgUFxRm1tKopLBUODkHc2JF8CVnA5zmt2Dg9imiA6Q+Z3H+jR9rmse
         mddogbF9uIHTQXlsezQC7h7k2iIo2WKVY4nIRYKI3CikxYtN9tQZAATjzdyQYviNHTcG
         hoLAvSnfbmFS8/hoT0EIXjHz60sZ6vn4C8rfFCUR4Tn1D9lBwDrIpQHYQudKEqGz+mNK
         CCGQ==
X-Forwarded-Encrypted: i=1; AJvYcCX7Im/1HjQQc+bf7sFlclWT4o7ZxxEQqOIHIk96AwkKDjqiZXKMkHHPpEV72naaL/lJLo3aJmOVNhh/KMs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcNmZLoWvEDFq1Qb/iZw8HaA7rM/+c2NNeqTAFsYdtsLju2pPV
	GTmxyK6mfjuixpvZIXAtoE9VG3piTokIEsncS0uFVsmB/+m7vNVw25QaXcWoUlkB
X-Gm-Gg: ASbGncsPq1fsxLZxpKiBcYev6JGp0+PFo4MbaNp/CAKD+kbkCiQr6k9uWmrthVJeg7k
	BDrkwRkyNPQxu3JHXzUY5aQAQgZGifPrLMKIpsrANTrDzH3+YhdZd9T9te3UDWiZP0k5D8fHiim
	HciG2YsDxDDVfRb1Ez7WLXcqp5J6sbtBGWN6U82et+AWr6rdfGs05PzzW1Y4bZPqfcv4VysUksl
	iOONiHNUh7Ve6EJjWoASCyTj8N+HZmuYsevjnAdmIcxaiViKmVXDBLo5RBhGHYbuam/L/uIPFVa
	8sg32uoSJm7i2brTWFapCp8LoHKBVAxys28Cd17ykYM5UdSsue8mMzzd8tEZAA+hTIUqMOqtCue
	39HBi8aMTKsBZ9ALqv9hy5OzDhdkbJ6it32PHzIDo6qAJNQAz/6ZR/HrsCPOjylKCEkNwOf4dew
	WfTRGraQPbCB1xZaL2HpM=
X-Google-Smtp-Source: AGHT+IFVmp7tFVYPy3tim/ILb0m6yD7bQL1F/KHtlrW8xr0PngQ0veSe7mMWCHVQNprA0UG970M3NQ==
X-Received: by 2002:a05:600c:c178:b0:46d:9d28:fb5e with SMTP id 5b1f17b1804b1-4773a7384c3mr92009525e9.5.1762179924825;
        Mon, 03 Nov 2025 06:25:24 -0800 (PST)
Received: from snakeroot ([109.175.243.91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4773c3a77b1sm160531325e9.17.2025.11.03.06.25.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 06:25:24 -0800 (PST)
From: Stuart Hayhurst <stuart.a.hayhurst@gmail.com>
To: jikos@kernel.org
Cc: Stuart Hayhurst <stuart.a.hayhurst@gmail.com>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel test robot <lkp@intel.com>,
	Julia Lawall <julia.lawall@inria.fr>
Subject: [PATCH] HID: corsair-void: Use %pe for printing PTR_ERR
Date: Mon,  3 Nov 2025 14:21:13 +0000
Message-ID: <20251103142120.29446-2-stuart.a.hayhurst@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use %pe to print a PTR_ERR to silence a cocci warning

Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Julia Lawall <julia.lawall@inria.fr>
Closes: https://lore.kernel.org/r/202510300342.WtPn2jF3-lkp@intel.com/
Signed-off-by: Stuart Hayhurst <stuart.a.hayhurst@gmail.com>
---
 drivers/hid/hid-corsair-void.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-corsair-void.c b/drivers/hid/hid-corsair-void.c
index fee134a7eba3..5e9a5b8f7f16 100644
--- a/drivers/hid/hid-corsair-void.c
+++ b/drivers/hid/hid-corsair-void.c
@@ -553,9 +553,8 @@ static void corsair_void_add_battery(struct corsair_void_drvdata *drvdata)
 
 	if (IS_ERR(new_supply)) {
 		hid_err(drvdata->hid_dev,
-			"failed to register battery '%s' (reason: %ld)\n",
-			drvdata->battery_desc.name,
-			PTR_ERR(new_supply));
+			"failed to register battery '%s' (reason: %pe)\n",
+			drvdata->battery_desc.name, new_supply);
 		return;
 	}
 
-- 
2.51.0


