Return-Path: <linux-kernel+bounces-812567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1521CB539D6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 19:02:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4FBC3BAB41
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 17:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0831435FC27;
	Thu, 11 Sep 2025 17:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KwgNdkGX"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA89350833
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 17:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757610141; cv=none; b=XlOoZioQrmW5+g21kyEJWbxZShHJY2NodEDw2aFrZyFYxNYqYvLzuyjDhlCU+2WmL7KiyO1Molk9A8bl62sCj2BmaLGKJAvFu99rr07JKS4Y62XimZq3wXKLbgJsY1qhklbaMmkQJNgJVUrjkInxO0KHWUdJzOnP+7DO7uP3RVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757610141; c=relaxed/simple;
	bh=zJg6XHeseMqyVJBkLEj26VisHJUB1RXdwSibXem5MNs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Re6MZXtLViVkpplNow/qij/gJZsBkZFIuBk0HYRro78bpYAZcy7W/bcm8TBnl3EDPabMj9WjVOCuUG93Z5RxI5PpygCtg1SF6krlm0W73Tv97ILMXUWb44VzEKudN2PLjUFHOIBcWF0IfC980txSTeGliLB75MgMEO5AYsRZX9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KwgNdkGX; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-622b4b14a75so1913264a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 10:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757610138; x=1758214938; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FJk0hVL26JapxqBeuQwzrSE0cPApYyqFtLP73ac9uj4=;
        b=KwgNdkGXUWRaQ6bHaRpjg2s0MH3Lbt5Q7M3uM4+OW/FshYbUCyuz+0kBxfr8ElXL45
         61X9aGMj6E7K4MMN4xP4bVNFmg0H30qQGPUZl+BZoYVlPPwU3VcUIO9KRVu2SemzUzV6
         ErxYkGtcFiE4AWdW0tqeYvn+lowQU4VpqSjJ8QK0Wc2eF0T5EXJokX3pg8zjcx6cgxc0
         keXbhmsy4bfOu4pr8a9LK6Z0Kf7JmI4v+TrkOV0O8Nvb5MwLe8oN87pREp3sWwmbqMrS
         xorQhk/25uWBoHf0kWB2roWWDwlWEx2S6VF+Ql8ptM1vlhjyPxMbVLQwZQ3xfqygFfju
         ACEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757610138; x=1758214938;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FJk0hVL26JapxqBeuQwzrSE0cPApYyqFtLP73ac9uj4=;
        b=pMea/MjbticXHKoJvxqsrYI1UI2xG9pn82Xf9arl7628UAaCji7ufb8MP8mgT1duoP
         guVRlpGRvJQgEsm0VEH9Tna8B38UcF70ZiKwHhL83t5XKcKcCWUYgM79kAPEc2gINwiR
         unOpYQ0fzxMszQVc/xIZmTS/OJQVfpPnGZYGqeNAepjQ0lIFB/qyKE8dswzBRpvnVPzR
         K7iGMztw9EusyahaNN1KHKhV8MAptdp2MgsZiLH/WdLS08jvoYXJXWMSFkn3u9clLw/w
         W1NtIBNQxx0CIxmB9GISfpIoNQaphl96hYrC8UOAfCfE5bKCbOLn/NS2OkEFbuuEyV51
         F6Ww==
X-Forwarded-Encrypted: i=1; AJvYcCVtYJjLJ8vw/AcfZ4bIfWZanULPWwQTcesep3NAFyxrrRO3np6XBqwWNqG2RQHE40BxU37xxvEFp0+EYMI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsJRwgOHg72LTYskIHuB/1QtbGkQzH0lzB/Lp/EcnEcEH1rR1H
	VC2Nj/Hd15wbCINISsmKLaXD/MxUjwb+6xykGNxlpPvO97LUnA7Kifg=
X-Gm-Gg: ASbGncsclRHESAsFcAyKoE2oFR6py0JZZo+H0RElU/nTLYYiedCmcE7UffUmk4m4rze
	PGRGKcUxW1sXvPX7U98ZCV3Bkg33M5eL06XnRm24blwjTiaX/4mzelYZOmgfQktwfPhnV4czi/i
	mMXj4ClEUYCjqWEP24Tr8MyfRQbcJx5xJgseda7FDA0MvlAbsRbz5dxBuoXmTV2COYfzhw7KU3W
	Oe/+AjDBTDb/pBk8t+86ijz26BwtW8+vTvq/lhOX1t59Wl8j06y96YF52gCvd5riAP2S38XALaG
	X+TnHPxvvt8icmGNf9Y9CHxoI3BDT5kivmZhJXGQQiPfMIdt0VwmIF3Qe/A5u5v7Q/OnLd99vux
	JybgyLl4c4IiPtSF78BHIHsUQmt5GjJAm2xT6R+4ebwF9muxk0oYwc+gN/5IxcIR2YqC4vMWuMp
	Zvc6W0cykUrMjMci74ukPh0s6Um0qCay4=
X-Google-Smtp-Source: AGHT+IHx2KcsYmCWeBeWcnkZxEbDJE1L/17SMXH4yrK85mCe32s1OPDe2bxpZe+SNwy+ZLdoE3wGEg==
X-Received: by 2002:a17:907:3f92:b0:b07:a76e:db6e with SMTP id a640c23a62f3a-b07a76edcecmr394044366b.21.1757610137790;
        Thu, 11 Sep 2025 10:02:17 -0700 (PDT)
Received: from [192.168.1.17] (host-79-12-163-148.retail.telecomitalia.it. [79.12.163.148])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b30da43esm166632966b.14.2025.09.11.10.02.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 10:02:17 -0700 (PDT)
From: Anna Maniscalco <anna.maniscalco2000@gmail.com>
Date: Thu, 11 Sep 2025 19:01:04 +0200
Subject: [PATCH 1/2] drm/msm/registers: Sync GPU registers from mesa
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250911-preemption_aware_hangcheck-v1-1-974819876819@gmail.com>
References: <20250911-preemption_aware_hangcheck-v1-0-974819876819@gmail.com>
In-Reply-To: <20250911-preemption_aware_hangcheck-v1-0-974819876819@gmail.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>, 
 Konrad Dybcio <konradybcio@kernel.org>, Dmitry Baryshkov <lumag@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jessica.zhang@oss.qualcomm.com>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Anna Maniscalco <anna.maniscalco2000@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757610134; l=980;
 i=anna.maniscalco2000@gmail.com; s=20240815; h=from:subject:message-id;
 bh=zJg6XHeseMqyVJBkLEj26VisHJUB1RXdwSibXem5MNs=;
 b=6yDKz4TF8Fm0al2rGgmBcFOPLrGluHEtzD0SQuvnW97plvnBs59JWWYiRVtR2tY23untSlWyE
 w3opJ7KenRxCmtic1o7RGJPWob1R6omI5Jfn4+0zw1wZKsTDtm+q/1+
X-Developer-Key: i=anna.maniscalco2000@gmail.com; a=ed25519;
 pk=0zicFb38tVla+iHRo4kWpOMsmtUrpGBEa7LkFF81lyY=

In particular bring in `CP_ALWAYS_ON_CONTEXT`

Signed-off-by: Anna Maniscalco <anna.maniscalco2000@gmail.com>
---
 drivers/gpu/drm/msm/registers/adreno/a6xx.xml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/msm/registers/adreno/a6xx.xml b/drivers/gpu/drm/msm/registers/adreno/a6xx.xml
index 9459b603821711a1a7ed44f0f1a567cf989b749b..6ea5479670970cc610ca25e71aa41af5f328f560 100644
--- a/drivers/gpu/drm/msm/registers/adreno/a6xx.xml
+++ b/drivers/gpu/drm/msm/registers/adreno/a6xx.xml
@@ -254,6 +254,7 @@ by a particular renderpass/blit.
 		<bitfield name="CONTEXT" low="4" high="5"/>
 	</bitset>
 	<reg64 offset="0x0980" name="CP_ALWAYS_ON_COUNTER"/>
+	<reg64 offset="0x0982" name="CP_ALWAYS_ON_CONTEXT"/>
 	<reg32 offset="0x098D" name="CP_AHB_CNTL"/>
 	<reg32 offset="0x0A00" name="CP_APERTURE_CNTL_HOST" variants="A6XX"/>
 	<reg32 offset="0x0A00" name="CP_APERTURE_CNTL_HOST" type="a7xx_aperture_cntl" variants="A7XX-"/>

-- 
2.51.0


