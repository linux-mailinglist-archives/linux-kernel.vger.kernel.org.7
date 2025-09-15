Return-Path: <linux-kernel+bounces-816543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B325B57531
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 11:47:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B5087A42AD
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 09:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CC20242D66;
	Mon, 15 Sep 2025 09:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dRs4a/94"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E6D01B4231
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 09:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757929661; cv=none; b=LGPtZQ2ejLRWUHgSa/SmNS/egr92Kpn57x8nRI1nxc/1A1Uv6627ws122qz4V2bB9AfGX4zPBtHUk2gXuqR6IlqEwkz6AcclDK3h30jwFjMQUB33ARwz6R2QAOJcUv6D+tOGPbFE80XsTP/RS8IJ16JNILR3i/FaUsuPTuW0JoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757929661; c=relaxed/simple;
	bh=cxAqupFOX5uFq92Avu8qu3m3xhpolK/5U494g4n1Fko=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ZDcpUz5tvQxovkQMOiSTctD8i86DEUDTgihvtkUuLRjZ8yMP9gTpUZjZsb6JIZmRobSA4M1id9i+ZxpA9gZi/nTW+eb/qO8w0/0vvqrPq+LSqBn9LnNonQ21JK9YzaWE6ks0TVbkcJC3UzOH7Ncy+T9VGzX6cqnifnaKILFiNBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dRs4a/94; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-77786498b5fso767411b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 02:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757929659; x=1758534459; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=puq/QVPjJHJaaP1wqvS4Jd4MbGPB7yk1PKVylU/wUU8=;
        b=dRs4a/94Ab97T+2n9/ZsN+jqVRZVhyQnyMdM3/IYNwqHeSs7oqOd6Xq0MMcqLaT+g8
         CjAMk0zgtbP2lbqvUWuuUwLmjq2knQgwtmg1gx9oBX5P9w0dctwpjf9a6nszajtUl/0t
         ycnIGPJ1D0vTlC+4PTgnJu8+3mA7fjl7Cx61/DQTx2zFdOcBsyOJoO5BT27d4F+XFAI0
         /QVe1W59lOPhUU+d9j+krsQtacqBaSkB9fCZtUpZ+bjOo7j6ZueT1t8nHokm5En5xnBf
         d1C3R+c0VIJDtdf93+53Rv29dQgrtmc/jQZI8FlPYLI9avY+7vwfigZUJYge9MmUE437
         CoWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757929659; x=1758534459;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=puq/QVPjJHJaaP1wqvS4Jd4MbGPB7yk1PKVylU/wUU8=;
        b=EAF1n1q36ppz3xYPsG2rpJQwtyx2z8UHY4u+WgZ5RYiiwuH/garZGsSdsqHkcf+7Yd
         /dSMPLIZLySwbdDF32aEEQVymi+a4zJhCEyfoeHDwrfz8Wx8GAgEpIBOwXvuIe3rtZG/
         /aTmSYF4nJKhrhEDvKBAxpIjZ8OZW8Tk7Luaeu0A7nEUgUGR5JQuk2+66vun1IX+D5c/
         2YCEdmg9amyljqAgbZH/tRJoO91LVqwQW4tQYzAN6QfKiAl037N5Ilc1lQpgE5SxbNXO
         0lkEq9Svu7scbukFFLboxa6rICb3eU5exb340WoMD01jdobCDsP2jlI+4Hblln+11N9R
         osaw==
X-Forwarded-Encrypted: i=1; AJvYcCWJz1PjrkqYzrafXmK/dUX7l0cGLbt7ODt+C/BRor+4VNdZ/n2qkQU/tCFjHV/tK5s7da9bUpRZD7fRIFw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYPzU+CGDG8S28jkpo7vpMaVFZFn9p9GZTmqQBZh0FOCrnqp4N
	9kIgStnirqLlM9lhLIwNLkKyI5pMFe1/pOIxd8aI4FtBBLJOPppRaItW
X-Gm-Gg: ASbGncvpuANrrSISQYTP37cQBf9TogEKnLenPNQgsbnX/A5FuwMWBE8cjk7E3bTiKuB
	RKUqbFFm54lblgdSHNse5gjuBj2poi9CqCYiAm4KGZBrFCw7afVGAE3VKIBek/RrOJugAQz28Y3
	EdTOkyfaPlxfgj8en2+38eU328RMtUYD+ods8jMHN3W8hjAHDBYqMkLXCLs40Ah3qpBsn1c5d/S
	E7k8nBSMSzDSvwqLLA9Q8oORM1SltIMb4ajK2wxdceFiyaF5JAvD4ZVJU1WkhStj6JMhoVhnnHl
	L8/Eu6mustz1lAQcNVTnXvoLaywmKGktpYYaLWtAaMeB+NZaINxs+w4F9jjC8p7NJ9iFDIDiChj
	/zSE5gXO90CPF2SXn0tCs1ediTIRnsaBZTtXHKf1FNC/82t0halLczpxczHw=
X-Google-Smtp-Source: AGHT+IGkXts2jRdzrIsnTzuf0gryCyKv7pwYxHT8stwUeB3vyz3wWYX7tzBsHMaYizcHXmUk5+6mwA==
X-Received: by 2002:a05:6a20:432b:b0:245:fb85:ef58 with SMTP id adf61e73a8af0-2602c90cbe2mr16311805637.40.1757929659394;
        Mon, 15 Sep 2025 02:47:39 -0700 (PDT)
Received: from [172.17.0.3] (125-227-29-20.hinet-ip.hinet.net. [125.227.29.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77607b184f4sm12997210b3a.62.2025.09.15.02.47.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 02:47:38 -0700 (PDT)
From: Leo Wang <leo.jt.wang@gmail.com>
Date: Mon, 15 Sep 2025 17:47:23 +0800
Subject: [PATCH] ARM: dts: aspeed: clemente: add shunt-resistor-micro-ohms
 for LM5066i
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250915-leo-dts-add-shunt-resistor-v1-1-d65389148a3d@gmail.com>
X-B4-Tracking: v=1; b=H4sIAKrgx2gC/x3MwQrDIAwA0F8pOTfQylpmf2X0IBprYGhJXBlI/
 32y47u8BkrCpLANDYQuVi65Yx4H8Mnlg5BDN5jJLJOdF3xTwVAVXQio6ZMrCilrLYLPaFdvHz4
 aZ6EHp1Dk7z9/7ff9A4VGMn5sAAAA
X-Change-ID: 20250915-leo-dts-add-shunt-resistor-8f96c94cf2a9
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 george.kw.lee@fii-foxconn.com, bruce.jy.hung@fii-foxconn.com, 
 leo.jt.wang@fii-foxconn.com, Leo Wang <leo.jt.wang@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757929656; l=1194;
 i=leo.jt.wang@gmail.com; s=20250618; h=from:subject:message-id;
 bh=cxAqupFOX5uFq92Avu8qu3m3xhpolK/5U494g4n1Fko=;
 b=GRx+rMoPC+Ks8u7cyFLnZgiZtR2njjInKSWufNm641lfB01ZSutgDpAepPQNVYxa1v3HucGVm
 CXu/0vJgogXDF0XZGPSB2GXDvlJT6dGy7IwENtdjSa5g1twGsK3oMQP
X-Developer-Key: i=leo.jt.wang@gmail.com; a=ed25519;
 pk=x+DKjAtU/ZbbMkkAVdwfZzKpvNUVgiV1sLJbidVIwSQ=

Add the 'shunt-resistor-micro-ohms' property to the LM5066i power
monitors on I2C1 for the Meta Clemente BMC board. This accurately
describes the hardware and is required for proper power monitoring.

Signed-off-by: Leo Wang <leo.jt.wang@gmail.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-clemente.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-clemente.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-clemente.dts
index ecef44d8997775b26cac10353b42b03dc644f033..a614f947dafc9a6628c3f3d45b62ff3ca9d2b618 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-clemente.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-clemente.dts
@@ -642,12 +642,14 @@ &i2c1 {
 	power-monitor@12 {
 		compatible = "ti,lm5066i";
 		reg = <0x12>;
+		shunt-resistor-micro-ohms = <183>;
 	};
 
 	// PDB
 	power-monitor@14 {
 		compatible = "ti,lm5066i";
 		reg = <0x14>;
+		shunt-resistor-micro-ohms = <183>;
 	};
 
 	// Module 0

---
base-commit: 3708a165a98c23cc83216deda88bc7d64ba85527
change-id: 20250915-leo-dts-add-shunt-resistor-8f96c94cf2a9

Best regards,
-- 
Leo Wang <leo.jt.wang@gmail.com>


