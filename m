Return-Path: <linux-kernel+bounces-768876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D4AB7B266CE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 15:19:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 281341CC169B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 13:17:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 598653002CE;
	Thu, 14 Aug 2025 13:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tp/IFejZ"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB7B15E8B;
	Thu, 14 Aug 2025 13:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755177439; cv=none; b=W531sT6xeyvUPB7aG+7ucebL9b60A6MGaKw+0YQvnTc8u/kTbaeZrg7nejRlIFpkf8FYdtBE7lsRKZ5sBXHbq265KOISzBKxwtuZiDiFTU03fxh8NMDO+kEUn5FwPuVIK8Ln0EZglnZgPNwDYOwxNkdSrsLZkwhwtExh1D5MVf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755177439; c=relaxed/simple;
	bh=9kMuQKW4Z0YWZcFJf5QnFiW2s0f1P9Y+rOU7gLJIkZQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t6q02BGTCcoztFGNo7APsyIjz18OCG813oOnhL0eFp6PWjFAZr/n/371HYUqYXfmzOEzpVK53fSIAaq9p10siHDW39vUZyzLjtsdNVwn74QKVNoZ2VciDpmFHnfOPEQiAMLQyZvWiB6UMcn+Iqg13Dry/CZjViUeGU46mkX7mX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tp/IFejZ; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-76e2e8e54f8so776694b3a.1;
        Thu, 14 Aug 2025 06:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755177438; x=1755782238; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c7EPaE2bHAD0ecNNc0XMu907yYWecMKnydM+hyTx2ZA=;
        b=Tp/IFejZilPuGOghjyNhVtO/omTM92N2NSlwzO3Bx+xSSYG8SD2St8aPY9UhZeH3Jd
         nq0LHO9d6gG7MN56pHyH80sNj2Sz2Ow7mciq/ZCNwY+jqfAmCIugImgDLlzUE5rmVPaR
         tox3SbfxDxICfiV0/lWChXhAcAJ1x7tlSuayBGzPpgP8y/K1Vi1ZWr/2CQqLtvEIfify
         5NNJxafp6zB7x7Tgr4qWjpEJzEtxkroP4PemzLM9XafGtoSxGFAnOuGxvogRLmFBbxfg
         usH9I/Ahv2Ewlj1K0L7bxnaHh28TGCP8WWrXPFFXrdrRDI3rwbeLUTVYjI9GCUOcURAh
         OL8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755177438; x=1755782238;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c7EPaE2bHAD0ecNNc0XMu907yYWecMKnydM+hyTx2ZA=;
        b=d7UVhdv6KInk3HU/txGHSSK5PNQ9hyEVMi2mOuGjS1FWjgFLAfTNzqPKrgfBnz2H2I
         LSGCQy6AXaT2laaaM7L/w0TEiPbOuuVsA+iuMBFal2H7RqmfjAz8VRUHg4Eq2KjjtfpK
         1jyY5NNeTVvSlzE+RkcU7wBzAEPdEDN/gRfRmvmLj6oGdO7Gakq4dzABm3zQmfhN+pNm
         V6EFSHInoH/zu5LmnIjaUwkhsMfK62a4NPOvXkPFv/2x2Lo2uA3gs00G7jf4RSh1w84c
         Se0EPz1ynF63/f7oCo6R3CVdzSFoN87TILM3BxVxzQexWl/5X5POzulIw+MBVbDH9KRQ
         yhSA==
X-Forwarded-Encrypted: i=1; AJvYcCVfebzx2SQ/oD6XoCDouQJKti92L3bdk6LZ4atsxjjniAWIjNd/MXlosTYS7v95NVVg+U6Bp2ymVIO7XA7h@vger.kernel.org, AJvYcCW4C4srjVt3hbZyGhy6QllIS3ZFetsu1m40A+Q38JRblK+6c4OoFAtQkJnWd2TaehPJ50s0xKLMu5zB@vger.kernel.org
X-Gm-Message-State: AOJu0YziHBtGDLT9gI+dK3Eidz+Fw61l6gEYbzemlukgOICvalAApOmG
	glxxTbHLPzfw+FfALzmrUbLe2JfKbk6cZP9pOA//FJWjCdYHQMlakQQx
X-Gm-Gg: ASbGncvQQBXNiBp15B39/QyFOuEaHMCqdzMtkoWorhlhqWr3+iCbjD5hlQ21nnM/wwW
	ivYpmDTNdDP2CCSEO/Fc2WqZNVt73Klvmw+5BWJILCL2O5eyVGUKz/HQ6LZb59DvD5j6fzi1opz
	BWwRwlG9OmpujOeyUQ0rDQD0hFEpbyrQOvwUluNym6+newfHto463RmgtePM5kkYRNxMDIT7kqB
	0iSMSSTW89lq+69tB1P+USZIzpZiPj/e5mzzXoqywIMjrSiITo7xFHjvdQzefFe1flMtlfhq6lA
	LfMhLupCCO5IYrO9XXg0LG8F0+nqSez8jPYE3X74JIJTUFWpXQjKPA8PI1sc0jpBf0dNVzs3PQq
	UfWn2g11D+xWVhrNIZtT1EB5U4MANFkUahXqHwvwk/I25Gqxfr94iTkn7Q7Q1L0ko+OKhxtnl2J
	JUe0mpJ4FkVGY=
X-Google-Smtp-Source: AGHT+IHJTBWuxjynBe00sfTNegD+JzVwhghLenRNVmzvPfO9IQgdbzp+OP9LwO/SXZV/Xcl6IoJ+jQ==
X-Received: by 2002:a17:903:3c2f:b0:240:3e40:43b0 with SMTP id d9443c01a7336-244586c262fmr43696825ad.43.1755177437402;
        Thu, 14 Aug 2025 06:17:17 -0700 (PDT)
Received: from fred-System-Product-Name.. (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24218d8413asm335652995ad.63.2025.08.14.06.17.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 06:17:17 -0700 (PDT)
From: Fred Chen <fredchen.openbmc@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/4] ARM: dts: aspeed: santabarbara: Enable MCTP for frontend NIC
Date: Thu, 14 Aug 2025 21:16:58 +0800
Message-ID: <20250814131706.1567067-3-fredchen.openbmc@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250814131706.1567067-1-fredchen.openbmc@gmail.com>
References: <20250814131706.1567067-1-fredchen.openbmc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the mctp-controller property and MCTP node to enable frontend NIC
management via PLDM over MCTP.

Signed-off-by: Fred Chen <fredchen.openbmc@gmail.com>
---
 .../boot/dts/aspeed/aspeed-bmc-facebook-santabarbara.dts  | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-santabarbara.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-santabarbara.dts
index 2f5712e9ba9f..ed30f3bf61a4 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-santabarbara.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-santabarbara.dts
@@ -1248,8 +1248,16 @@ temperature-sensor@49 {
 };
 
 &i2c11 {
+	multi-master;
+	mctp-controller;
 	status = "okay";
 
+	mctp@10 {
+		compatible = "mctp-i2c-controller";
+		reg = <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
+		label = "mb_nic0_mctp";
+	};
+
 	// OCP NIC TEMP
 	temperature-sensor@1f {
 		compatible = "ti,tmp421";
-- 
2.49.0


