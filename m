Return-Path: <linux-kernel+bounces-781184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A2E1B30EA2
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 08:15:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B5FC5E6918
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 06:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADDF92E371B;
	Fri, 22 Aug 2025 06:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZbzqWX9x"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C8712E3710;
	Fri, 22 Aug 2025 06:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755843304; cv=none; b=mKhgOWHUCW8HVA3dRFNhf1z303FT3VXKWORD47zjcNqjSjN6/NdsLqadQWOxCQ27XnVs0g0uFnJqW3eIrOWNDCnTbx6++uCGrYp9QJz0VjP5ci2xM+ZuuFBQ1nlDoj3mwKLfnMxKQHYJ3oeSRyLV0CSd/FEqI3G5rG8TCeW3zDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755843304; c=relaxed/simple;
	bh=xMrs/O6EJnBVQGsgC0FYROP54LHFf82XlKCetaWrpik=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SrgKYpa0hiyctXKkLCJ/zl+9LiUDgBwL2u4MNIezLPRS4M2jntx8/8+K1ESUr0H1Vyj+WFLmKgcNlJRM1L/6Ta/0z3/F8iAtmpY/c7XmE1SwdqM93sOrIAq2ltn+/Jp80JylUN2+FbIPeE8kEEi6ulbmgdmuEW9KvOmR/yLuzfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZbzqWX9x; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-24456ce0b96so18502745ad.0;
        Thu, 21 Aug 2025 23:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755843302; x=1756448102; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p4Mp9ub8voKbHs9L0zRZ9WclG4wR0S5cTRrb6q1ZcxQ=;
        b=ZbzqWX9xko4VUWQdP+UaNiRxS+o5MXZgt3fLJ8qpU0kX+tJvSb5xKvk7e108tfuxmG
         dceAt5DRlipVFao31L9FE8DvRZeZRu4jl7aBcxGy84rcCHLF/5kISFejIY7fZ8IDMsTn
         GZcbWGJVOg5X2KP6Qz/LJXLpkyUTtrnEBAZxP9rHq0ML9s2B8YZrn7yNdaqBRYe6GKbX
         hwQ5kvyRfTtKw2bREm594buITNUpvamWh+FqPElym5FgOXizFqmzk0PELvDyLcEnleFb
         DLenXwnW/9bOGMJLklRvJVko/OLAXa82JqI23VKW3xiXE61UcR9rIDSlBPodOVr49HKW
         ZRaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755843302; x=1756448102;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p4Mp9ub8voKbHs9L0zRZ9WclG4wR0S5cTRrb6q1ZcxQ=;
        b=W70TD6ZyCJ6G0+TzelAZAEPbRVg6xjp6RWepk2YLEkNRBrj3xd22Nqw8qEieOVhn9D
         Z5tORf1SnlX3Rquuouv4WmS8Z8EJmUVz+9/7+Q/BJFeGnVhubd35u23xWQiXKSdACJkS
         GmIllzdOmNh7OFVM17FU5ZkydwwIBE7b5zGcmBNY28vAVPAEOA6a+TuJivatAF1VkD7x
         F/R+RhZ81pUI3qq9lZRB4n1seOher5sBJlI2TxXUk+ee+et6YyLEzckZ352Q3pWZQ+Ka
         rAjBIl2FJzC0DuZbCVSQE1BLyNfVnhxCSg96XNlWS5+gGmR7UpVGZ3lRMtKY7UPUh85q
         go5g==
X-Forwarded-Encrypted: i=1; AJvYcCWdSLZeqfbjUtDhoF/M8sk2QuXfpTXNv0fsn5gu6uoiv00A2+X8qBrCagX+/TWaz7ywEK6rjBiR0kJudOR2@vger.kernel.org, AJvYcCX14gL7/066AbN3k9k64iHSDtw9MlWO+NoMFk8tgjVRCSTyWSu/HC69UrLvrD8L4idGdL5+7xRc57Zb@vger.kernel.org
X-Gm-Message-State: AOJu0Yzj02/sNSETSCW+HbMPHVDikx2IHr69RCx99gwopFL2qjbC33+K
	d1u6TbEa8HaUNbx9UhRjJ+mQy+h4F1XfVO7pgEulXTGamBWKmaK5nvMj
X-Gm-Gg: ASbGnctZwCiJkd6vb5h60bvoAbzB/mdIls06opvczYTbbQpZtjEejDUkV3/DPGfDpHk
	0WE/oYEtlIbP106ljzo2Nf6H/l+B/Vqib0kz5ok3QVvYzYktDQu4HCfoQQZOxKa1YyZvV0ltbA6
	2YFvyVooxmPd3O4UMSFv2/1HliokIU3zF5rd7NbK2ebUDiOC7UbIMvl4VvzDQmuj+4VLNI2Dpo9
	/+T8B3Gz5KJ0GOdYoucZ0X3GgGaudnApVpyQU2O+t+Hkmw0w20s0LSVoL14BGJZgMxCg26thVoC
	g4P4BoWspt/pQVeqMTOshJ/ZKIciErLScKx4GDJ6fD2coDFWUS4u/5hv53cqIDhsIdDKrZGYTCJ
	BXb2EOd4wWMwvbYqk3BZK/tXAV9ycqbjDZMFnsy1tlTwkpkdLT2ExShXR73+d/Qr95a+WPFyeOb
	dk+mZPcBWdn+/W/3Tl5Xt3r8VZr9ki
X-Google-Smtp-Source: AGHT+IGcphv3Y4S/+8hBXnAifQ0Lugya7F08rZBSa88ZhxJo9tLkgsV8/t8NAnzRDkBfLXViimjVPg==
X-Received: by 2002:a17:902:d50d:b0:245:f6aa:1cd0 with SMTP id d9443c01a7336-2460245b0fbmr71854855ad.17.1755843301678;
        Thu, 21 Aug 2025 23:15:01 -0700 (PDT)
Received: from peter-bmc.. (2001-b400-e35d-8041-a0f2-62d1-f7aa-e5b7.emome-ip6.hinet.net. [2001:b400:e35d:8041:a0f2:62d1:f7aa:e5b7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-246181c48c1sm28660385ad.116.2025.08.21.23.14.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 23:15:01 -0700 (PDT)
From: Peter Yin <peteryin.openbmc@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] ARM: dts: aspeed: harma: add power monitor support
Date: Fri, 22 Aug 2025 14:14:51 +0800
Message-ID: <20250822061454.2610386-2-peteryin.openbmc@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250822061454.2610386-1-peteryin.openbmc@gmail.com>
References: <20250822061454.2610386-1-peteryin.openbmc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add INA238 device on I2C bus 4 for the PDB board power monitoring.

Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
index b9a93f23bd0a..741d2d9b6d03 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
@@ -373,6 +373,12 @@ power-monitor@40 {
 		compatible = "infineon,xdp710";
 		reg = <0x40>;
 	};
+
+	power-sensor@45 {
+		compatible = "ti,ina238";
+		reg = <0x45>;
+		shunt-resistor = <500>;
+	};
 };
 
 &i2c5 {
-- 
2.43.0


