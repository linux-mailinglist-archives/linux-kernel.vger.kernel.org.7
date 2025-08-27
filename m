Return-Path: <linux-kernel+bounces-788959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8269BB38E8F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 00:41:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42E047C2684
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 22:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8309330F932;
	Wed, 27 Aug 2025 22:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QloNTmS2"
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7900879F2;
	Wed, 27 Aug 2025 22:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756334500; cv=none; b=OnNA0keNa8Pemr4uvwr6m2Q58a3XjN6i2fixc2wJwKilC8H33DBpyUThkKV6Ychz9mK1Mp4457yMdLX4VcxE74yvMF1IJXhJhPRdwY9WaoAL1cM5vV2qKuFf4SQIwBVow6knw7wn5eJKYGQU7pFzzNTWsc0+WVdBMzn1stG9aZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756334500; c=relaxed/simple;
	bh=xje/Tj/QyytIHVYuO8fdsSFzK/Z5DRaY97Umr4ljYD0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B8ju190VOBgqdkIiNo+0beUZaAagCHV69yDK6Mf5yw+WcmwrFO6ANOlE1ETJFoaQ6z1gevVgHkCrkGLsEJgUN5yqTGWFNTjEgmol+QlS/ymPe1GUC2DZ19oSw05Gp52Ro6gMD/GeOR6odbVzyxtuVl2Yqks/lYNN68XoldIhjao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QloNTmS2; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-71d603acc23so2245667b3.1;
        Wed, 27 Aug 2025 15:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756334498; x=1756939298; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bwnIzEcsjxwswI8a8iYSrbpZwwwfHA2WNu+GDjy1LKY=;
        b=QloNTmS2KejOPjivoH+bYQ0Z5aSIaVJ44/ZqtYeP/GNrz7uOMwZCYLa6WTtfebxZsp
         zaH/BkxQkfJwP52vxcHTmGhha7mfcXF9bVoRqEE4Q531tuqududsA3QNmPMMnQNH1KHZ
         JSh/lcOVZjvX17gykfflFXtSiV0QBrdU7qfPefJOjubMb5sOc36E5NTuAFGAkuJ1ygnb
         FEa8xuybgIDrRSIP0xD+VQKDB6pMf3B2RqK/9BxGAzGCnu2Pw+2JqZ/QrjnuKNXh2p+j
         gu5IP6Q+P9BW2/Ju4NbP6rBTJhd4o6OZ0nhiHqr7Ufmt6UoOtEGOOIuyEjdZ3rn2Jn1P
         BLHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756334498; x=1756939298;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bwnIzEcsjxwswI8a8iYSrbpZwwwfHA2WNu+GDjy1LKY=;
        b=R4uapSdgcSBRDltfkeP/7LXRDAgd4KFILNITFoeY6QWTqGkt6/O8avMS9qYWFkmeIz
         YM71pk5wJ2LevV+pkASsmE17aUdeZcj8ig7Pq2Tk+xGXc5+YY/kd85b5zyoc4mwOLCwg
         G05xWa4LgnAkWP6FHTtf3H8EYp2uzSAuC7zU+8k70rVu6bvRLpcbsfkm8YnRUrw/HcYu
         iInv6mzA+RYL1P7S6nPUOrTOxdDBBDuRlfN5qltEteWCHdOoSam79r+Hkj19SCD49AUg
         wJsIYJAls4+FUha/OulY8618/sAhotTNDCdeUN/HTSb17w8RH2K7+1mjU2p1cVRtbOJt
         QzrQ==
X-Forwarded-Encrypted: i=1; AJvYcCUD8JXXqz/iOBZF5b0SA5ezaVToVBNmsskIYaGaw/0INu5Fu+SpdlE8QwkP+wCiL584fX0bhd5mFHHa@vger.kernel.org, AJvYcCX6p4T9FjJSf8DyXuVS79PZ7e1ZkVBHg8l3g3xJLLJ3ocmjw9Em6gUBzvw+OomLh90tHtqRNbIms6cZd7U=@vger.kernel.org, AJvYcCXg4hYO8LXsjnRPgkZzfZwlA4uSmwFLu8hq3DDJwocyEPFAq31c8SVvHtcONPi+PkWSzr7vpbUUViNXmBzE@vger.kernel.org
X-Gm-Message-State: AOJu0YwDh/mKb4llX/o6SNp6kRLet9pJ6CsniubVMgQiiKnx/V+pZUpY
	FBWBixsW/3H+1+rc7rFILjnP74k6cVJNH3CzchpQbjDdBHfrFfuDAdFQ7WWLG1ff
X-Gm-Gg: ASbGnctQSst/6Y0si7lFD0Ga0w72rTu3dJrtXM6wjBQyZ3jscizUtyBAorFIGS2S85u
	2YSC/UM9olZGlDzOwvn4zrfTm4SmeJ00l9A541V/FFMyuWXVJ6Cz4VkmJSbRvKJrJvTztyTOK+L
	av6u+ZmW+CbnBSTT27fADhbsomf5HKZUKcHAhTXa1LkDwsZjnfhhYkFZskObUiQW1MtBkmkMHkL
	wpMAu/ZULiqD/cfW/LKdhashErkh+TM4rNBCjef8v7k7AJKOCCLvPshkdSvOdVj6LCf7PlN7f7f
	DIrGUTRcr4U4B1F9U2SMCGFoA5viD3mXgJ7e7wSNZN91QeDWUMp8wp4ZOzHHBA/wYo9geAbzHE3
	qfhHi3j0=
X-Google-Smtp-Source: AGHT+IF9UJ2ARUR7A8B6XNc6QMN3mvK5jpN9iLvo0i3AcDqTamn1m2AhceL5wiWxGIe2i74P63M4zg==
X-Received: by 2002:a05:690c:7281:b0:70e:142d:9c6e with SMTP id 00721157ae682-71fdc3cce2amr232126437b3.32.1756334498443;
        Wed, 27 Aug 2025 15:41:38 -0700 (PDT)
Received: from raspberrypi ([2600:1700:90:4c80::d])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7212005f70dsm18240287b3.40.2025.08.27.15.41.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 15:41:38 -0700 (PDT)
Date: Wed, 27 Aug 2025 17:41:36 -0500
From: Grant Peltier <grantpeltier93@gmail.com>
To: linux@roeck-us.net
Cc: grant.peltier.jg@renesas.com, robh@kernel.org, conor+dt@kernel.org,
	linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] hwmon: (pmbus/isl68137) add support for Renesas
 RAA228244 and RAA228246
Message-ID: <70bb08e291bd57722b1b0edf732cd0017714ef07.1756331945.git.grantpeltier93@gmail.com>
References: <cover.1756331945.git.grantpeltier93@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1756331945.git.grantpeltier93@gmail.com>

The RAA228244 and RAA228246 are both recently released digital dual-output
multiphase PWM controllers.

Signed-off-by: Grant Peltier <grantpeltier93@gmail.com>
---
 drivers/hwmon/pmbus/isl68137.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/hwmon/pmbus/isl68137.c b/drivers/hwmon/pmbus/isl68137.c
index c52c55d2e7f4..f27e2512f1ac 100644
--- a/drivers/hwmon/pmbus/isl68137.c
+++ b/drivers/hwmon/pmbus/isl68137.c
@@ -61,6 +61,8 @@ enum chips {
 	raa228004,
 	raa228006,
 	raa228228,
+	raa228244,
+	raa228246,
 	raa229001,
 	raa229004,
 	raa229621,
@@ -464,6 +466,8 @@ static const struct i2c_device_id raa_dmpvr_id[] = {
 	{"raa228004", raa_dmpvr2_hv},
 	{"raa228006", raa_dmpvr2_hv},
 	{"raa228228", raa_dmpvr2_2rail_nontc},
+	{"raa228244", raa_dmpvr2_2rail_nontc},
+	{"raa228246", raa_dmpvr2_2rail_nontc},
 	{"raa229001", raa_dmpvr2_2rail},
 	{"raa229004", raa_dmpvr2_2rail},
 	{"raa229621", raa_dmpvr2_2rail},
@@ -512,6 +516,8 @@ static const struct of_device_id isl68137_of_match[] = {
 	{ .compatible = "renesas,raa228004", .data = (void *)raa_dmpvr2_hv },
 	{ .compatible = "renesas,raa228006", .data = (void *)raa_dmpvr2_hv },
 	{ .compatible = "renesas,raa228228", .data = (void *)raa_dmpvr2_2rail_nontc },
+	{ .compatible = "renesas,raa228244", .data = (void *)raa_dmpvr2_2rail_nontc },
+	{ .compatible = "renesas,raa228246", .data = (void *)raa_dmpvr2_2rail_nontc },
 	{ .compatible = "renesas,raa229001", .data = (void *)raa_dmpvr2_2rail },
 	{ .compatible = "renesas,raa229004", .data = (void *)raa_dmpvr2_2rail },
 	{ .compatible = "renesas,raa229621", .data = (void *)raa_dmpvr2_2rail },
-- 
2.39.5


