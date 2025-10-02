Return-Path: <linux-kernel+bounces-840121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23609BB3968
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 12:16:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 906903C4835
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 10:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98F9B309DC4;
	Thu,  2 Oct 2025 10:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="HNjn4gZO"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4492C2FE56C
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 10:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759400150; cv=none; b=c+Dwg1/p4IzCGVbYsM1MA/yreMNB+vSxjRP2JAb+pbbIeVl/uGcGzywCa7ljbQP+dyKPPW22o466eMmJ/bBN79+zz7xbibL5tpSjKVUNpRQsf7vX0cLineLjFdv/kVWEfI0bvKcoSjvrPsZRyeGBKDaKR7wE+tv6PCMSZ/9pasw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759400150; c=relaxed/simple;
	bh=Vl6UFKVT3qMk/PeLrd8/N3VtqzoAfptqOHatiOGqDso=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=An8BPbfQCvQ0y8GZca/jKF4NFPwKOIpe9odq3wIHcmYgNw7V9h6fDWEiPcsUqZNhBDRlBhxo98rzGVPdIuR9M2Y3JgMuPOzKEfEP+lN301k5ZB6xkD4QDN2XpWNFQUuRg/GYIL/8irYLj0WX1VPXpqkQUMmUBozC3wPbTjLVeJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=HNjn4gZO; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b48d8deafaeso97556966b.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 03:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1759400147; x=1760004947; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Th7m+xgo8yV6XofOVv0pjYeQoHJ553LRrV/kRWz1zJ4=;
        b=HNjn4gZOKbl+Go1ZxFQ9K7VawyScAflzYvHSjlWDPgERZ8xMJn2zadxPJF3/Gj4Vnp
         7T9JpeZuOJzhAaVYixfeKqDawFxv0fmpQaqKVgVt/Wig2l0G8WklukpLeCviLcxn86yn
         YBrj/wEnohBXyHtyqPU9KLN1ERcD1nytzxHqCzTdk/nwRl5Oxq8b1gdnq+SxFM2tAXMs
         v942OynEAMo/RceVATxVnRQY1H4umQ5xizwN/+h07cHEfmmLXzKbCy+virN/q/7m5Ue7
         r0mgrQqInJRisJd380qxl2ANCNCOvu/48aQwhmirMr2j9X07FuHF5M1H08bpqNU5AVMT
         xvKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759400147; x=1760004947;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Th7m+xgo8yV6XofOVv0pjYeQoHJ553LRrV/kRWz1zJ4=;
        b=Gi/kU/kn20YRWtvguQY0JXtGwjJObdFZMG0asfO/sWzE1OyZp0LXeWFp+k5CZTqb/L
         lKcnn4USvKg3E91MB0U3zsmIfIrP9iMXgWiLT+406AD6U/OYqN9H8vw6BG9nrjtTUEKH
         VJ/QxbY+GOjB9NopemQSQaqui92EIP0DwTNrUJrg5IAnN5U3m+rGFDkYDzhFxuToofoY
         wFPrf1la/5WMSznbc/BsfcW0Uy1ftt8WZwmOpH/PeVxcas9L/Bw7opx0sIiZxUCgwbva
         GZJ4Odpk9D0Im5GEpYAskOdLxiIRKFIFHp/OkRdD1XYc5oMH42YLB3L2Imshj+LxWlz1
         eTzA==
X-Forwarded-Encrypted: i=1; AJvYcCWxVVM8332AKynxsK9/vRrezZqyPwULab0yPHeUtNv8j5NctMzsz+sD8N8fKEXPOxCk+PBMk21T9KI8tFU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUNwsswlgee2pgvHn2qMCyBzA3axtWXkHVqZrMPmBCiTTG8wts
	rjQrQTsKqW0VDKPinVVRzdtVIcdvg19jXfyZi1VEQi/kXaigpZflCBfzkO5dozyY3NM=
X-Gm-Gg: ASbGncscYsK6YXhNqYEX6dfvl2OQ6kLi/KPUZcVeKQPuNlkaLXNFXw6dKcw2B/cI4Nj
	4jpG12ZgV2zTWhFgq9NbJrogZAiRo5zBfq7r/BIG0XUUCWGl/xVgTJy7v3AWo2gEuMeSECFApD8
	O2zk7/MNhIZuluqvpAZR4MZQ9jQ6pSGFbftIMqbpERcwGimFscjpqOYxU0hOZWJlJNAeXy9776o
	S8kO4Sde5QzmDE6PM4rcYi0tEHTOJUoG5z3M5+Om/hmXe3MLmaIR3TXf59dAmsvK/SbKg2UzrgC
	gY+n6jVZo4NRdPLEdQV34qAEXQKslX9rTPSRrYkhhQRzYiZ09xOXuGHw4H6MrFKsafZhnq68VbH
	1XeDdoohsm2clHs5sWWdMM9Uk4eilzN2w01O2HOb0jx3sjrQtT+5t7arKLbzbYB9ouv28e08SyZ
	C3gXqiFCuhB1zaLDhJ6TInWZd+vZhywf6zYy7pXO4=
X-Google-Smtp-Source: AGHT+IF/ESP3usAHvJ8gXhwfuHUOUkVJhbwwiRVZnXLNUWbrQKg6OnRLQEbgOPECnJx2sXt084fvwg==
X-Received: by 2002:a17:907:2da9:b0:b0c:b51b:81f6 with SMTP id a640c23a62f3a-b46e8e7846bmr867815366b.43.1759400147499;
        Thu, 02 Oct 2025 03:15:47 -0700 (PDT)
Received: from [172.16.220.227] (144-178-202-139.static.ef-service.nl. [144.178.202.139])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b4865e77427sm174862366b.36.2025.10.02.03.15.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 03:15:47 -0700 (PDT)
From: Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
Date: Thu, 02 Oct 2025 12:15:36 +0200
Subject: [PATCH 4/4] arm64: dts: qcom: qcm6490-fairphone-fp5: Add UW cam
 actuator
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251002-dw9800-driver-v1-4-c305328e44f0@fairphone.com>
References: <20251002-dw9800-driver-v1-0-c305328e44f0@fairphone.com>
In-Reply-To: <20251002-dw9800-driver-v1-0-c305328e44f0@fairphone.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
 Daniel Scally <djrscally@gmail.com>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 =?utf-8?q?Andr=C3=A9_Apitzsch?= <git@apitzsch.eu>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, 
 Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759400143; l=921;
 i=griffin.kroah@fairphone.com; s=20250804; h=from:subject:message-id;
 bh=Vl6UFKVT3qMk/PeLrd8/N3VtqzoAfptqOHatiOGqDso=;
 b=R5y0mqJiVScdIvjJoFsVsDdI7oQmckSWsFG+2hrz7V/xbN4Fd/GWabpQv7ZrcRk5FqcGiioWE
 dJmkBVE6f9UAbNurDPEGpRNGE74wOhNKRSfjURhi/0Lfbzczc9ehpIJ
X-Developer-Key: i=griffin.kroah@fairphone.com; a=ed25519;
 pk=drSBvqKFiR+xucmLWONHSq/wGrW+YvcVtBXFYnYzn8U=

Add a node for the Dongwoon DW9800K actuator, used for focus of the
ultra-wide camera sensor.

Signed-off-by: Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
---
 arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts b/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
index 2dd2c452592aa6b0ac826f19eb9cb1a8b90cee47..0e86cd5ff527925c7dba15c4e0ee5fc409fe4ce6 100644
--- a/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
+++ b/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
@@ -627,6 +627,15 @@ eeprom@50 {
 };
 
 &cci0_i2c1 {
+	camera_imx858_dw9800k: actuator@e {
+		compatible = "dongwoon,dw9800k";
+		reg = <0x0e>;
+		vdd-supply = <&vreg_afvdd_2p8>;
+
+		dongwoon,sac-mode = <1>;
+		dongwoon,vcm-prescale = <16>;
+	};
+
 	/* IMX858 @ 29 */
 
 	eeprom@54 {

-- 
2.43.0


