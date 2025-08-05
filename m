Return-Path: <linux-kernel+bounces-756413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB9DEB1B3B1
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 14:45:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CBDC3B2A89
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 12:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5C972727E9;
	Tue,  5 Aug 2025 12:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FcWHeihb"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8DA2238177;
	Tue,  5 Aug 2025 12:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754397919; cv=none; b=Jk5BvJN1M9JRf+09Ai5Y3Q6VKsnyerflYsRNh1OymyXrbG5Nsyz76r+XZLO4stjRVBxXXNlANpRU6nk+VrE1AFUNIA0DdHg7CKOWn/whR30UcpCfJn63gprp65SRdwAVEDA3xZ/r1TjoSzzhi0+fYXx2Hf6Z1crR148MG/dZmo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754397919; c=relaxed/simple;
	bh=e+vs1AT/beY5T9AuLVlwe4vxBTJYnrQKvREfLoo6FIU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RGF2bUI642XZovpuszk9tI0vOUvrU65xHTxl1z4Vmigjpr0y3gTNplLzj/bcTPIRAvgfDVTGSl5SCvyOkvcS2upfW2pYxYQtsb0A8jozkO/4JooWN8QOAjrqfw4YrUzLdAHbBwqWDzW5EFqPSpkGJXMnBWZrajypV5F68abDxcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FcWHeihb; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-76bdea88e12so3478686b3a.0;
        Tue, 05 Aug 2025 05:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754397916; x=1755002716; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gvYEaUEO7YS0BxQMrrWqSPL4xjTl7ZEeTQgnTHed89U=;
        b=FcWHeihb8J99CxvW0Qwq0jWQyT4m3VAN2CdhAHxY6TwMAbbvyZk+/5wj2jXg/tk/yL
         4aLJta++gN70C9YSkpxa51FhKnQ4qkSM0xPujGKkUgD8GMbgRoFMDFo6++Qy/AiOGmgr
         cHa3Sc2e1GXupnyUKf8IfM255nRZIZpxLWjghL+rYB0+v2VXxRLAZaK49K2a3+wFGIVt
         mQTYwnJ6UINFrDpGtALcJsikDR9VGqvvIFzd+J75Za6d1ASROOhnKxsZ3oZj4XUJ+/r0
         qDiPVVOljmHS8BJsvoh8XIgAj2JyqBRlo0R2xn6r82U9D4jz2H4Ffp40m4Vp+zH4Cpfu
         TpSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754397916; x=1755002716;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gvYEaUEO7YS0BxQMrrWqSPL4xjTl7ZEeTQgnTHed89U=;
        b=GVhnLf6qaOrXyfcktlQ72gF4OhZnwTervFOdeZVJO/8MBERCaTkwCuieSPUG8mmf5l
         ZMUrFAMlZlBV9JQFyHyR1Olcz2QN+h32ZY+fcdJC5lLobf800FfxBcq6VcezEiQwIbvb
         BkDw5p6sx8Kv2aDE7C6XOfstVgG2RPL0zVef+KDqy45mCx49ODsyGix8qjs+kws/flIA
         A9Axxs4ObAA1gdUugli4srWQVEzR8TYydZ0258xV5u5wpRmceWeerc0n9n0slE3naIGo
         1OztXKBWzBHKA6bzHoUGAsOq2WxnhQo5HlG0nZPGIl8xLxRa7x3O0x1p8+Y6LsCBYyPI
         LlUQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBMHpyudUnyWBkDjeYLh02y2vzamJVG00eC7tIKFcoa9Xd0Z3FDWs+zF/4LlqR5yrOtmUHXqdTLbtM@vger.kernel.org, AJvYcCUIq9toF6iIwGlgQRaXqjb4tl6WyHM2FNLxtcDGprG02HYnbnx4EmfYtNHKmzma/LpLB55YFKZhLrPh@vger.kernel.org, AJvYcCW06qiIYbqToWxa6+0nfIPrKl7/tHg8uR7rNd2WGvOcKM003Npm+NC/qwZwV3Bm52DdC5/1UzWCpEIJuHnm@vger.kernel.org
X-Gm-Message-State: AOJu0YyXH/wHg6WryqB4vRPWJIR36mKBtzUGDtb2CNJhB1emHfD/Vj0N
	kGoaknLF5wFLTmWR2fx3LmAGRmmgew0mX40oZZaGuJAKLXqD8mAmY+oFUZozKw==
X-Gm-Gg: ASbGncuGjW8EycCAkjlMtm3qkV7iCUwB+AybrzFZTUXWM6SYqBjt6kDmSqlHdk2T7yl
	El0pbap0TW6TCGGha9593ucq2MT6j3nnHrwW8O00liu4Hvd6ynPUMqVRawkXeAxfY6PODBVvpmA
	F7HYnGELWcOKmEFOu/LWNOIw/yVbbFH8WKUbGU/zb8NDIMslcd9rGaYIiRI3RNKMk0qCMmot0yX
	uh3tWLJQr2PjnTYRbxsG4LD9WwbQwDcXH7P43gczx/SfQEJmPx4j36UNEnU0LXYeyUajote6onv
	8NVOLtaDihbZCy2bNsCdk/h+DxQZwDIM/uJtM1SVoJ2y4rMnVW8I3KyR/ijVuy59mf/csPzQE6N
	9X4vQ/b9UTUV7ds5RFtoiydZ9CN50wK9CgbLGRJi8UekQ1FDwamP8ftifns2n9W3yvIjemoEEEL
	ucLfw2VzkA+eK7yiM=
X-Google-Smtp-Source: AGHT+IF5lZrQFVNgpcgc89u8bQcdg6q8Akvsd6T/nwRN+y5ihkKL+BxCDi578NgbVezvHW3aL+9THA==
X-Received: by 2002:a05:6a20:1583:b0:234:80f6:2b3a with SMTP id adf61e73a8af0-23df8f93bc1mr20211126637.4.1754397915917;
        Tue, 05 Aug 2025 05:45:15 -0700 (PDT)
Received: from CNTWS00427A.itotolink.net (111-242-118-39.dynamic-ip.hinet.net. [111.242.118.39])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bccfcf523sm12959863b3a.90.2025.08.05.05.45.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 05:45:15 -0700 (PDT)
From: ChiShih Tsai <tomtsai764@gmail.com>
To: linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Cc: jdelvare@suse.com,
	linux@roeck-us.net,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	corbet@lwn.net,
	t630619@gmail.com,
	ChiShih Tsai <tomtsai764@gmail.com>
Subject: [PATCH v2 1/2] dt-bindings: hwmon: adm1275: add sq24905c support
Date: Tue,  5 Aug 2025 20:44:48 +0800
Message-ID: <20250805124449.15187-2-tomtsai764@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250805124449.15187-1-tomtsai764@gmail.com>
References: <20250805124449.15187-1-tomtsai764@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for sq24905c Hot-Swap Controller and Digital Power Monitor.

Signed-off-by: ChiShih Tsai <tomtsai764@gmail.com>
---
 Documentation/devicetree/bindings/hwmon/adi,adm1275.yaml | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/hwmon/adi,adm1275.yaml b/Documentation/devicetree/bindings/hwmon/adi,adm1275.yaml
index ddb72857c846..d6a7517f2a50 100644
--- a/Documentation/devicetree/bindings/hwmon/adi,adm1275.yaml
+++ b/Documentation/devicetree/bindings/hwmon/adi,adm1275.yaml
@@ -18,6 +18,13 @@ description: |
   Datasheets:
     https://www.analog.com/en/products/adm1294.html
 
+  The SQ24905C is also a Hot-swap controller compatibility to the ADM1278,
+  the PMBUS_MFR_MODEL is MC09C
+
+  Datasheets:
+    https://www.silergy.com/
+    download/downloadFile?id=5669&type=product&ftype=note
+
 properties:
   compatible:
     enum:
@@ -30,6 +37,7 @@ properties:
       - adi,adm1281
       - adi,adm1293
       - adi,adm1294
+      - silergy,mc09c
 
   reg:
     maxItems: 1
@@ -96,6 +104,7 @@ allOf:
               - adi,adm1281
               - adi,adm1293
               - adi,adm1294
+              - silergy,mc09c
     then:
       properties:
         adi,volt-curr-sample-average:
-- 
2.43.0


