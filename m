Return-Path: <linux-kernel+bounces-747486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E987B13469
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 07:56:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FC701771C5
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 05:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1F1E22577E;
	Mon, 28 Jul 2025 05:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NiBo1L7S"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7D8221FC4;
	Mon, 28 Jul 2025 05:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753682188; cv=none; b=L6vAsbyFAVB9nZAvJOpzAB75x8KM+bwajrdeBaiXZaQqyA96ttmJTmt8sAMEXgkDZpcXpZd09H3KkF4JRLoVB5tisKpXHeXHr90zkfEiT70M4uc20UpYAxM135q50ZFKA/YGsOs0lCUCQ1h6WY37xYiYtp5CJKxxlb+XfcrdUa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753682188; c=relaxed/simple;
	bh=IGgAMc1scPm0dLtQnt47FYjA7V6fX2Jqk4mK77H8zUU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iq4gpeNJzFAh/5+hKNn9bbbdp1dtOkPrNVgLeNyre0V2OFe0VtJJ7BsX981jPdkmnVdKtlgmHjnNTAk7DDESOpp2i8kS2DqeR+x/GxOC6TWYS7oDP967oeljyumyt3BCUkht0iumSM11+1utRDZWpkNi6looDzB4qBxviiViQeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NiBo1L7S; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-235f9ea8d08so37916535ad.1;
        Sun, 27 Jul 2025 22:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753682186; x=1754286986; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0v1yUQUeQEzUoSADn+AjVSEy94CHuuV2CUdJl0yjuIM=;
        b=NiBo1L7SIyRTJUnWAGjAHL+qX7Maawh0GfE9xfWHZKzMgB9Acx7sh8IBRkY+Cpt4eE
         LOQLmJI01o+JOTTQyAXLqliYiUaOPWpvP+/uKFO0XMGc8xyJObWCH+zBrRgF4ZbhuAII
         KtUuZ3eypaF3hHmjvDdOXIElFDshZlmFFRkAcGj7FIW77UZq2W5YLA7SIz1GW9OFCKsn
         vNcDR1o67a0PCOeecm0+meb4LOb+MjqFQno+5P1Zj/P5z3/Wn9qqAIuy+1zZNSkrACjn
         2jLjX4T8YUN47nIRKNdauESkrdgXxgRjQEgr7C7CjIVi0YanrmT2zjVd28zmHLa80JAq
         svAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753682186; x=1754286986;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0v1yUQUeQEzUoSADn+AjVSEy94CHuuV2CUdJl0yjuIM=;
        b=Nwi5UIB4YpJw2o6i8rPODgMplrtiBauBv/uQYXQJ4KyCCMlGVeqfr40MnVylTSvduv
         4fzuov088I8qNxt1YquaWXKe+2+eHJMH31zcac2h6WJlJbjXQ7+VXi1Qxy5fsK234UWi
         WZ4CSia1J9D57Vs4dzqfaBGV+l9u5AYnV498gLZ2eTeO3U2lJVx69KTygyPoOFES3xYi
         cEPk0J3W/OlsFpyzKfg4ed8YqyeH594rtcn85/Mke2PRCI/AOpL+Gi5nu4epy63d//UG
         bSCqKm4xa/lROMI/wAwbbv5zTAH5zzwF8VtGd0xgZxjgJ1FdYUQyly2SloSQd+bGEtyz
         M1tQ==
X-Forwarded-Encrypted: i=1; AJvYcCULut/oXPz2/Cjozxir7aNPoGsvSIxWZVuH+hD3ry5ccpWys3T9sybYqlFsXyliBxDIij4YtlVTG4Tu@vger.kernel.org, AJvYcCXsyigO86r/b2rpmcD7cxC/aJVM49+TkRCagSqFzW5wv685bWqobg7GXQ63ZIFzV+njDzlYqNv9B2RGdXxW@vger.kernel.org
X-Gm-Message-State: AOJu0YytEf7WqsgEVCKjSHSR9jMOmIMrD/vBysrVzeukn6A9EsJyaiNg
	v1bilhqOd9e785BopjnkJB7BWKErZycKvjhF/WM2AmZcEAtBzkjdwwhl
X-Gm-Gg: ASbGncuOmfX0XiFJM1PDcLFHNNVv+f/9HB8a2MB2HOM16W5olmuHPqEXMd5HFU+PzCj
	D4N1mmKCmSh8K+3rPWB6MtJO971l2C07Bo8Ze40StWzkS7LtJS7Pkpz2sd9+zy6AKJLpbmDphUq
	cGM/ApqT/DBYo1Oj7Q2Nf4AUvl15jtOeIeadZjcgqe9EYuBn3PAOqm8oFiYchUqXxwb1/wASqvT
	BneMHIRQ3M2kFQ3zC05pitBFgY2HwHBj5CjSy9VHQT+y7B4/4SujNSnDDpnYxb+Ipwg6QrLkIe2
	wF8Q12v9oMZnP940ZlcceSwPCBIAfTEv93ezGclCNSbvy5NCUKJ7R3iExS+jYpBq7LdFvydJtTT
	R7CqhrGya4wB/G0z489f0vtVLy8gQpjod8yjL/8SWunWRsSRYlV95KJBz/LtqHua1+0L7s/+0fX
	yZgXw46KNcjg==
X-Google-Smtp-Source: AGHT+IFHEC7n8+B8Tb7wSp7/znoNLEQy2YYidfHzQJc/uhDuybjOx5iseDVn3XjiJ1+k5dNKflv98Q==
X-Received: by 2002:a17:903:289:b0:234:a44c:18d with SMTP id d9443c01a7336-23fb304fb2bmr160718715ad.22.1753682185872;
        Sun, 27 Jul 2025 22:56:25 -0700 (PDT)
Received: from localhost.localdomain (c-76-133-73-115.hsd1.ca.comcast.net. [76.133.73.115])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fbe514b59sm45091795ad.128.2025.07.27.22.56.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Jul 2025 22:56:25 -0700 (PDT)
From: rentao.bupt@gmail.com
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Andrew Lunn <andrew@lunn.ch>,
	Tao Ren <taoren@meta.com>
Cc: Tao Ren <rentao.bupt@gmail.com>
Subject: [PATCH v4 02/13] ARM: dts: aspeed: fuji: Fix DTB warnings
Date: Sun, 27 Jul 2025 22:56:04 -0700
Message-ID: <20250728055618.61616-3-rentao.bupt@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250728055618.61616-1-rentao.bupt@gmail.com>
References: <20250728055618.61616-1-rentao.bupt@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tao Ren <rentao.bupt@gmail.com>

Remove redundant adm1278 properties from fuji dts.

Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
---
Changes in v4:
  - None.
Changes in v3:
  - None.
Changes in v2:
  - None (the patch is introduced in v2).

 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-fuji.dts | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-fuji.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-fuji.dts
index f23c26a3441d..840d19d6b1d4 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-fuji.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-fuji.dts
@@ -248,8 +248,6 @@ imux16: i2c@0 {
 			adm1278@10 {
 				compatible = "adi,adm1278";
 				reg = <0x10>;
-				#address-cells = <1>;
-				#size-cells = <0>;
 				shunt-resistor-micro-ohms = <1500>;
 			};
 		};
@@ -577,8 +575,6 @@ imux67: i2c@3 {
 					adm1278@10 {
 						compatible = "adi,adm1278";
 						reg = <0x10>;
-						#address-cells = <1>;
-						#size-cells = <0>;
 						shunt-resistor-micro-ohms = <250>;
 					};
 				};
@@ -648,8 +644,6 @@ imux75: i2c@3 {
 					adm1278@10 {
 						compatible = "adi,adm1278";
 						reg = <0x10>;
-						#address-cells = <1>;
-						#size-cells = <0>;
 						shunt-resistor-micro-ohms = <250>;
 					};
 				};
-- 
2.47.3


