Return-Path: <linux-kernel+bounces-743352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D070DB0FD96
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 01:30:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A478AA6961
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 23:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC435273818;
	Wed, 23 Jul 2025 23:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fXMkNIOm"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6406272E4C;
	Wed, 23 Jul 2025 23:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753313425; cv=none; b=aa0MZTw1kPQBmUc4o+HMV+dlkmRlM3QSGoOqOzAUonqnB4GZ01oQvBNs/Ys1EKO6jqyBrPkgKwj7W8LNMintb3mDQaHc7Zj0TxEGEuNW5x6N6YYESNhc1X4681l6WfD8U7nhyMZusCzcYW84CFM9DcJv3vow65eo/w+VSJG3r2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753313425; c=relaxed/simple;
	bh=DwgiZDixqRdoXcYRdSuU9lWFsNVWyi8ccwqmBP9sykE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iZPrLZuSWHMsUDsfWAMkcJLYa/1CQMwcoKzQGRwgxMyETwGUQCuGPBHr8OiJEE07+LSn8yVtMNRg34L3+405Xw+C6c/GPWFKv3StsvmDl9Wrausju7a46bxF1ZMsC5BqBV6PLbf6ZtyN0ZDS9g1tjTnzG5VvXYzreWMoGuhLMk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fXMkNIOm; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-234b440afa7so3815525ad.0;
        Wed, 23 Jul 2025 16:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753313423; x=1753918223; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ctQnw4T9aGCXVWE9viBmqQcA3jC8U36JYDmPl4dskAY=;
        b=fXMkNIOmsS4/qJGP9zPeR9baWvH63NUdofs1edsRZy9Bu0/w8Stzcki7anCou6fTNh
         x2xiKZ1M3b3sR/+fFD8ud34Bvl52uRcpo6iularxHpGecsonsI6/O+rjohA+HZPvGLUm
         BPUhBuuqdLmahsDWFMR9SvPsZ6KUx732lfRTFVdDXmBhVgdOjVArdqnezr2JKT669ODW
         Yb6BgPP+TmluCtyNiR0CkFL5MSTa69OuMYv3LrDCmUX/Yl9VNvG/OgpuXbxySB1h5x2e
         tl2ox5f+Hg9wCVma4vLcwK27eOu0FlQUfo6fw6eC+QxSLR/omfejRux2DTi/wpicDEux
         +Sog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753313423; x=1753918223;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ctQnw4T9aGCXVWE9viBmqQcA3jC8U36JYDmPl4dskAY=;
        b=EiissSSkhLEvkKE+2Opg5qUbO5qV4a5VCE4vxD1vKhD3iIgYxIt1JghgB7Gh7KXVzB
         bCDS819Cmv/f4RiEOaYoBVNUCQWuibesAzYbH1Ifk+aMd0Uh1FsP2/trqa4jpUJJrcBy
         ytjnI20sZjcy5gSpwjDDQ+VwBrx3x1iVhk1eqi6wMEhbVOHAz3q5GOrU0pq7ztgAD7ma
         Ex8B5oyk3T5svu5wlC2siHiEtGKxPNMFN5DjGxOmDqR6EyiW8Fe21iVATJhotUNdfNN1
         0kG8mia4ob4mKpo7MVvVZmRMZDujsk18qHWtb9lKrM7PllFWgYEA/DwzvJC+F9z7I6Nm
         RRiQ==
X-Forwarded-Encrypted: i=1; AJvYcCW4TuwcNRUWVp6YrNXzEZmxwjRCLfZuW1+tPeuA4rF5eNHEBhiCwdMCoqEt9kWgJ2R4d3t8n0lg9mXkGrpL@vger.kernel.org, AJvYcCWh7inEl1YECIfDltUMXpLqsIGLPqifqXDkm8QyszFfQ4Y1Xl2AH8hk02wtIRI7JWXqgfMqDFXdJkU2@vger.kernel.org
X-Gm-Message-State: AOJu0YxtPQ+sMez+2dxA5P99kHvGjsJ1xRmYktUR0kFkozUHNSr7ZqwH
	ehAGModlujhz9pa23G/BCrYzpv3FnRZb8gOAeOLHEYlqrWAgye0QoarR
X-Gm-Gg: ASbGncs/WD9gG6HIWKTpBkDtYClmcftK5FQcNpf2ymx2XLmyV5D7+/F1AIWaHbyJslD
	zvwE3D76LMhvfufEz4HohF46dRCwpGB4aeIXzAI+EgIAGPeNWC4SAi3Krl6JWiaaOlU/1P5X1UC
	FZiY6YVMOnr3EddukfO7zhoCv5nDq7PTVchFt8ZVEdBhhH6Y1jy+QDeZwoBuP+YOwR62jkWwRWt
	pkKI60/jk+B5b5fDXcIrTLcRLZ1IzMX9tNDgcYvp1H7PxDkONAhPgJG8qI7aPjUvHktvZkWlpSr
	LJn9xwelFMQtXzTquZBVl+qItHxCQLopBRKLlwdf90eNnUWmZolateIsPaKILsNbV0/yoPkVNU6
	iklaIZdLpUwL4KBePYE3VQFxShRBMLitOgmeGfY7lBbFFk0e8wUYLkwjcH0/EyNEkkBb7AubTCa
	6JP/Z/jBIfMg==
X-Google-Smtp-Source: AGHT+IHZCkMRvU1ebyh0sGVf2NLMMyqLlu90qCowRnMKoLmMxtKGnQfXhTbY0WtI4zdzMW1NJgaPSQ==
X-Received: by 2002:a17:903:40c9:b0:235:f77b:4b0e with SMTP id d9443c01a7336-23f981b40aamr66297385ad.41.1753313423090;
        Wed, 23 Jul 2025 16:30:23 -0700 (PDT)
Received: from localhost.localdomain (c-76-133-73-115.hsd1.ca.comcast.net. [76.133.73.115])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fa48bc6fbsm1260765ad.120.2025.07.23.16.30.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 16:30:22 -0700 (PDT)
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
Subject: [PATCH v3 02/13] ARM: dts: aspeed: fuji: Fix DTB warnings
Date: Wed, 23 Jul 2025 16:29:58 -0700
Message-ID: <20250723233013.142337-3-rentao.bupt@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250723233013.142337-1-rentao.bupt@gmail.com>
References: <20250723233013.142337-1-rentao.bupt@gmail.com>
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


