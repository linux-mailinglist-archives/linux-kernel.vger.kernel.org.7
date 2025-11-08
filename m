Return-Path: <linux-kernel+bounces-891490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BEC5C42C3B
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 12:48:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 26B3934A5F8
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 11:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A81FB1D95A3;
	Sat,  8 Nov 2025 11:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D9VmHVR7"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9556E1D5CC7
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 11:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762602499; cv=none; b=WXWPPgsVZ/bHmBI4f+hEh8E4Z/jN7a3qtJps09h/oQ9wLEbWBiVmbNPoX1uSg2QdgNZDZdQn6bdVC2Y705ku+zRI+i8gaXgjJyqQ5EOTzWBLX9/YcBt5ZneD0wP2Dng56N4yn+Oa1aj1HMtRR2fo+12L8Anwz9pKgzJNjW+lIGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762602499; c=relaxed/simple;
	bh=5cdTnkkVED9/2W3bxFBK7nQFcUSBpM8zbejc4QhIme4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NiN42S9h1boel8tqFUiJQB6gQqSRf7MlNUMd2mOdDTl7v5Q9D9Jyjw3SkFhIjSZpQXUexd9+y+ugOw4oqWgo5o3ZTPN7IRvlCnh8Vf50t+E8rC7DabCugfh0Bd6g5YxJPK8drTvrGCS/6v8bPE+Wc6c2ZNl0iU75hTRQk8xXzjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D9VmHVR7; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-47774d3536dso2277205e9.0
        for <linux-kernel@vger.kernel.org>; Sat, 08 Nov 2025 03:48:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762602496; x=1763207296; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TWQxduQP/C2sgZ0tZge6y0YoRp0qJh93EXdH14IqjbM=;
        b=D9VmHVR7/4RGo1PqM68bkpT3d+lBJegKTUNIEpOGPf8AyAYKlziy1hfkrR3TE2Cu9i
         l1zf6PoHhtUGKPbhELbJ7A30QeK6ZV9u0RnFGNnlSLnCodNhiFxuFooW7AAqIhmueKTQ
         HVxQ0phI0z/n5zPVGw9HN9XHZzxal6GrhugvV9bl1u3yb2mIEqpabFdZb44fLfh9Rr8/
         OhIMqGsw3J+01TWsTw1R32Sr/90xy3P2ULRm3oma5gDLAPpfjljDvj7+zp1lPouwqx5G
         BgBj8Vb8M2hBVCWqYPASlr7Hpmdh854PdFVutxSJ51whJPAhI93dbzzmDCtcOQXsfO9Z
         y4sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762602496; x=1763207296;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TWQxduQP/C2sgZ0tZge6y0YoRp0qJh93EXdH14IqjbM=;
        b=cN4HiuUEufutPwtvwf/nv1Ly+5w4QXf4K83MBaCNSbm0OfbPFITWa/+TLOx7ofXwY/
         HuMnB4KhLhaXoAE5mub6LIbdOwnds5R8tiCJ9dWO4sxgovI+h+/KFdtnDWHo25NUCymA
         zDWDE/LxI4Vqon+DzDEDnadbpb1Y8+ivOaGxG4DmM0MO6XszDDCGxkSLju3xD+h0ls4q
         C1VjEvLRkmJv9x3dhePRmuB29yhwj486NiyxvyK4IEgVgadiQP8+au3y0m7V6ikHTxNT
         G4O2hnOTLAb0oMMiX3/LO2La4+fz6FjXnLOE/kF1qXPaZtDwc/OprqkVFvIEvpRFpASu
         EYHA==
X-Forwarded-Encrypted: i=1; AJvYcCWuO5Wt+NWEGwQUacQ9Y86WAZK7Ch1oC/2TkOFzdcZ71X6h06Qtf6GmNIzpDXDeQEInUhD3xViiSKGz4eg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYwynS2QjMaL4ny4IzLemhIDCzxabyLO80hxAGaXgKNS3pY26M
	ohhcUMCTMsN80zT8BKj8MGngiw5Mrz7CyVQsVECw4Pd3bhDfJ2M4dUti
X-Gm-Gg: ASbGncsvX32WclQ+e5w5YtPyPeqf7PeH2jtn1oe73/NhKyiXS3ti5Vhdkre5fnlDq6I
	+opVT521k0OsbkwJ9ihIDEmF/F+U2YZ2fjoq1RVxgsciSVlbPFZwCLPJEpcqap1J9Wg33BJWijm
	z6XYJnosWvwbqlyBgiMNrYYvSQJtTEZzx9y26n4vxzPHf2RQBJJ8LI15ni+6+9LBhaajGS00A/L
	Qn/OVd3Ya1bFudiUlxyYK82L1lqxbVNj4rElzTrnmCPc8njD3S/jt3jOHHQ7sILSCFfN5SvLBq0
	W36rtHd5Ypk65KGQtx7pEwKnw6YqyR9tf1hSzRBPMT2MinX42JoEIIPhtsj2vkyOVpqrzrcfbN1
	fXhMfu3hrPh0etylYpCNVEYcg+V11yK5tZUcsEVVGS9Ymm+T6w0aYvpCfrDLYaHQ07Ve1zd7rHE
	VMc0D5SqJzgehrZxVZS2LYpNfhenfVLa/BarnsUOenJ87JI2ce
X-Google-Smtp-Source: AGHT+IHgxO1mIr8DQpSXmsqzg3ZZ+VysGIJ7PpFEGvZJqatwD9Nv+m3blSWxKLvi/w/mZvDvXnK+2g==
X-Received: by 2002:a05:600c:6b06:b0:477:14ba:28da with SMTP id 5b1f17b1804b1-4776dc5daa2mr33610405e9.5.1762602495708;
        Sat, 08 Nov 2025 03:48:15 -0800 (PST)
Received: from cachyos-x8664 (202.red-80-28-106.staticip.rima-tde.net. [80.28.106.202])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4776bcd521fsm123410945e9.6.2025.11.08.03.48.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 03:48:15 -0800 (PST)
From: Marcos Vega <marcosmola2@gmail.com>
To: ilpo.jarvinen@linux.intel.com
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Marcos Vega <marcosmola2@gmail.com>
Subject: [PATCH v4] platform/x86: hp-wmi: Moved Omen MAX 16-ah0xx board name
Date: Sat,  8 Nov 2025 12:47:41 +0100
Message-ID: <20251108114739.9255-3-marcosmola2@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <63905a5b-1dc5-e0d1-6c8d-e590c7e7c7f5@linux.intel.com>
References: <63905a5b-1dc5-e0d1-6c8d-e590c7e7c7f5@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixed placement of board 8D41 so its categorized adequately in victus_s_thermal_profile_boards.

Signed-off-by: Marcos Vega <marcosmola2@gmail.com>
---
Thank you for all the tips on proper kernel writing, I'll try to do it properly and learn for my next patch.

v4:
- Added trailing comma


 drivers/platform/x86/hp/hp-wmi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/platform/x86/hp/hp-wmi.c b/drivers/platform/x86/hp/hp-wmi.c
index e10c75d91f24..ad9d9f97960f 100644
--- a/drivers/platform/x86/hp/hp-wmi.c
+++ b/drivers/platform/x86/hp/hp-wmi.c
@@ -96,6 +96,7 @@ static const char * const victus_thermal_profile_boards[] = {
 static const char * const victus_s_thermal_profile_boards[] = {
 	"8BBE", "8BD4", "8BD5",
 	"8C78", "8C99", "8C9C",
+	"8D41",
 };
 
 enum hp_wmi_radio {
-- 
2.51.2


