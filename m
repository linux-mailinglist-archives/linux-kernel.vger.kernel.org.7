Return-Path: <linux-kernel+bounces-817494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65D41B582D8
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 19:09:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBE892A25E4
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 17:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AEA41B0F23;
	Mon, 15 Sep 2025 17:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gtxXbx+7"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2E71A295
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 17:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757956109; cv=none; b=jb9ynyI5uac8UcDc/TaDZcPj05J+9SEYxCfUJ2dRdgy5h9pgsevkncPg5FoeflagXyn42HPlT8JI1Uvl1SY8ru9SI9CyBMWk/5BoFO+qHnER4T+oC4IXpHdFgiaefZNQFf+434YKis10NXXtoCeeXRxExKb6in0bAS1sVNVLqcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757956109; c=relaxed/simple;
	bh=6/3PflTmrV9uSqqc+QMoNPcCJMQr4fm8X+Go430Uko4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lafDaJE2yEEYyP2/i9eWi1u5662kbaAp8JENf/w4YZ/twA7/Fa2V/CyjfSGEUlelwMXZF9kcdJo/R/YN4EVZREmHxzo62WyfUkxihTYMp2wItuhdRjPG4ddGShO8HF6stiE74IyIpbYHMVMuIgUSdkia/ogDhNvbK8rEbPBvzag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gtxXbx+7; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3d3ff4a4d6fso3037858f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 10:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757956106; x=1758560906; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QKNfUY78UaSDAPVosHrpMbpy+iAC7g79ni69WixhiFc=;
        b=gtxXbx+74NAL1mRQyYbHL8sy1BmDXBgvn1GT24jfIVcF9NjgaHVRYjDjG2QOXGYSB4
         RSxA1VSmhycFBaNiMxxu4o+J54LiiKO9OIAABQ81IzfoR/8afyOB4HaqHEYDM2pNkNP/
         E+Z9Ee4KRtCOh8vyj2e1kYKZMnqIAcSrVCd7m2jHgzkS6v3W46SpEN7HquyQPs3vIZhk
         AHlTvQDCKXZHocPgaaEpc53UFffadM95FZGAeEBwXpbdZyX/jnLRlsU6OqBKgLRt11K1
         UA10w9ZU2ob5azk9aaHZxpp/aoaK6cMwUmI/usP+47wFSubgXFb6wEON1MhlTwsUhpQw
         lrRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757956106; x=1758560906;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QKNfUY78UaSDAPVosHrpMbpy+iAC7g79ni69WixhiFc=;
        b=Nwr8udtdGZ0R8GwtT2jIfW+3u4F82ANV0fNa/6mJz6v1SugyQI7Dkvt1+G54gn2BYg
         81W33C07bwTPiIgHxv5oGOOaOysZ56E++/QrRByTT4Ie+gaNaa6XwUPMEBecUvkIOvqU
         OqfP40qVSAjaYVBRaZuligWrvJ+RsF157WDS0cVrbPUyGuYGGB77UK2Vdqub8VtTleDo
         BGPjXXG0Jcnwa+QV6SP93OGV/+c3rXSvAb7g7EFaUvw7x7trROZBFz3QoP4FGP5V91v6
         wkrc4azEtgoYjWnpONHYbiUkqjHQbkwZJ++ctTzYx7Tt7dKqqiqdrPT2QEDqTuQrRKna
         Q1gQ==
X-Forwarded-Encrypted: i=1; AJvYcCXGL1x45QRTzDmMi3shjozG++Y/jrxFqKOxNBY8V9Aq1KU7r4LyRYwcIGkf6shSTqJUfmcxmmiX5etdaK0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoiaDGRb/YDGYVBJhgfG3b/BZxbNrH6np3E1Cq/hfVbLzWXoQx
	42i87Lrz8O4eaLnTP8cDvJP8l95OpOXWbCPc6GUNaDALDI6N6BEQg7Av
X-Gm-Gg: ASbGncsGggkB0PZbTu85BNBhNayA/N9n3C5fDZVJjKTCauCX/7k74YuEPKRKGKFQlVz
	iY5mX/GaupKVO7UoNgEO1S0n5UzgBOuvYpJaLypWPK9I3mwHEDPjDyuH0MTVCoCHreuPijLwjbc
	6V8NnUfXgABqyupqtmxNspIQsfmdW5Uhoj/cTSC0/ejwMTthsbvh2Cvaq4XNPcguFNgrKIXm52d
	2CcTkQuBSgj96LSHwdkELxrasAISaBL8KGewiyviXP3c1WIWWsABhvt5IF/bIqoqbznxNovD9bc
	mBOPp7lzwDRNqTXVBJ3d5sMhUgw0Rbs3UpL+CLXUhpaQFHp6TZGoEnjvIGLZ/cBP7bSvijcx5WC
	UoDIS7yxiDKo9ROENzRsPPm7EnXPLQlWURk9K0RDQSuawDkACxPLj+fV1WPfF87WjOQOLog==
X-Google-Smtp-Source: AGHT+IE+G13sfmVz9goh550EgB9md8VuCM2m11aMEfOcLfVAOWhOadBKdJLLzNbmapPvAfQb9eUrpw==
X-Received: by 2002:a05:6000:2212:b0:3e7:471c:b11a with SMTP id ffacd0b85a97d-3e7659c44d9mr9235744f8f.19.1757956105745;
        Mon, 15 Sep 2025 10:08:25 -0700 (PDT)
Received: from flaviu-Aspire-E5-572G.. ([5.15.80.80])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7d369ea3bsm13146383f8f.0.2025.09.15.10.08.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 10:08:25 -0700 (PDT)
From: Flaviu Nistor <flaviu.nistor@gmail.com>
To: Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Flaviu Nistor <flaviu.nistor@gmail.com>
Subject: [PATCH 1/2] dt-bindings: hwmon: tmp102: Add TMP110 and TMP113 devices
Date: Mon, 15 Sep 2025 20:08:18 +0300
Message-ID: <20250915170819.126668-1-flaviu.nistor@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a compatible string for TMP110 and TMP113 devices.

Signed-off-by: Flaviu Nistor <flaviu.nistor@gmail.com>
---
 Documentation/devicetree/bindings/hwmon/ti,tmp102.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/hwmon/ti,tmp102.yaml b/Documentation/devicetree/bindings/hwmon/ti,tmp102.yaml
index 96b2e4969f78..840b5306a8cf 100644
--- a/Documentation/devicetree/bindings/hwmon/ti,tmp102.yaml
+++ b/Documentation/devicetree/bindings/hwmon/ti,tmp102.yaml
@@ -13,6 +13,8 @@ properties:
   compatible:
     enum:
       - ti,tmp102
+      - ti,tmp110
+      - ti,tmp113
 
   interrupts:
     maxItems: 1
-- 
2.43.0


