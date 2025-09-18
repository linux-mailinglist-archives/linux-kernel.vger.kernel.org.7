Return-Path: <linux-kernel+bounces-823597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CBC7B86F1E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 22:45:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E2507C716C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 20:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A25112F7AB4;
	Thu, 18 Sep 2025 20:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d42QCTEJ"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF0E2F7463
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 20:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758228324; cv=none; b=NwTs4Px/YB+kNZ4VtVfsI8eafmjQjfXLi+vZIF+GkJnG6nTtcYYu4nOaUFUEna/2u8LohW7/cdgEQqqUtCp91d2JFOsqKeJP6XwxmciBCxnx7wggqj0tWTDm/GAMj6H8mfVrxbwZsLQ7RqPo90vhUnT7Hd4Pzwnzyq5JuCcqnBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758228324; c=relaxed/simple;
	bh=WR4FHVVhcDnWn/j+5eNlUmmFrVtxMPPjypE6sBwEbC8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I1tDdRANU/Xl1kglJJ/oQTbzyanHAHkVQ0m+7Bxdheo2o6LZ/z0LiYF9fe91/V9BgqqoiJ8VEQRIEfXekWj4O5yHcIyaqPXr6Fnd4MT7h41jh84jGbCeiBSdv4mz37JWm1Zz7FY71vxxo0gHqsDBJXE6gCc2DQp8Zju+tyrhaNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d42QCTEJ; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-77d64726e47so986883b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 13:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758228322; x=1758833122; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BtrLIyGEWOU6fa2LicSTWFbyugqQN0mZ4i8wIx/QdRc=;
        b=d42QCTEJ6b0LWyjxN//vc6rGfaagxepE+pStlmZmwOm4YDMP/Bgspb3aSfFUdfUv7z
         3CPz77sxDf+AhUtNifT0C3Nb3RkDrrn+gdMwane7x33KC+CE7iA2fWwru9pLXub3gPMi
         /kYg9ag1zCGAbqgnuza5nLMOxNKPjs+ULkRrqXPA0wHtPI441SqGsLvjT6knKd7gHryH
         6pxgJptuSnk8RKcnNL9+LcYRZW2UKxBuB+oW9ymFDJofPDdSR28AoDWvYvmsxazldmAf
         pnNOJbDgcoRzzEizbdmZXzcfJ+ftsTSmTsn/NXFrgqKUf0wEXpowbLVvrWTUeZ6d5iEH
         M5DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758228322; x=1758833122;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BtrLIyGEWOU6fa2LicSTWFbyugqQN0mZ4i8wIx/QdRc=;
        b=HGBww0glbZC/rupzN4wwLvApFsBrYh8te/EQO9EAhwnNVYA3hqHahb0utqN1RaIa8b
         0ztXRxa8F3LuOHMrk4aLU6yo+1zwnGr/G4EKDjA4ropDv4aYyf0bX7LRn+jYBX7BW5zs
         STY2M5TPJIWWM+5tSewXqocgPIhGMGuFKEklkZYjQf/Lq2Havg2FXOlk6Sp9Thp0+fF4
         V86Yv2wRCNi3akp8Dqex6h4AcJ+xN5pZ83le5vdzMZlwKdNEUJdIr93S9Zw/5VhyHIvC
         todhSiUixqObqz+oQFe027uAOgEjPtACjYtNEIpEAGTX0KFidb7VzivI2rRdm3ixY+V2
         0mXw==
X-Forwarded-Encrypted: i=1; AJvYcCUXgmKUFpqDH1kN/vgoJL3bDFuH3G0M8V+LAwcWSnX7gxI+gieyo4/SgwLu5BNEUsuRMGkALdAUzZCZHzo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQ+k/OOdG/wG53S/3En3XrGRc4ftDtfvkmIpWXhf3dhVnDnPxF
	GDN5W7IztODxetkKRQE+B5Iq6odpOr2JB82YZ0x5uqiTh5UDxxFQHlqb
X-Gm-Gg: ASbGncty9cHgXc9WMi9RHJ27yUI5Gw8cT5ZvAefPDR/oZCRqGxgbT4afQqoDmNVMkrR
	zcMHFZtkU+IGQ4Os0gPkcgz+iFTMa1pv4S/7b4Xgl5InJ9yBYmr7dKonmo5HJKfOQ3HorWbYMPF
	w0bt+2CeeGO198uZkE6a9BxK5ReUyWu08Lw0StdQh3b1eouerTLXTpzR3GJasjbDp8SWluPY8kg
	EkO1eMtmla8USZiH9LiQ4NfN5E6QvCAEWiVXBttToKjt7dnIfZRCyJxqjfAvKj47KFkAMkKe0TX
	LilMX9vuCqrxNKHrfr7tkkaqrAN6RQsIBYK69y0sH2T1cBeMjpg/UPS8WdAbAD08JzXVbDYTNO1
	gyAEBRcwD4EDkXXPr0atcl9bilZ0mZ/NlWffRXzgL6tS/mOwHWFg=
X-Google-Smtp-Source: AGHT+IE8751B+bVDOfdJ1EVLTNVCctqoy8v2KTEAWN2TnaxEmjyaFaE2yRT5zYFCYRIrStFZWJzm6A==
X-Received: by 2002:a05:6a20:9189:b0:247:f6ab:69cc with SMTP id adf61e73a8af0-29262399d44mr1426160637.26.1758228321256;
        Thu, 18 Sep 2025 13:45:21 -0700 (PDT)
Received: from localhost.localdomain ([119.8.44.69])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b54ff35aff2sm3178181a12.1.2025.09.18.13.45.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 13:45:20 -0700 (PDT)
From: Han Gao <rabenda.cn@gmail.com>
To: devicetree@vger.kernel.org,
	Drew Fustini <fustini@kernel.org>,
	Guo Ren <guoren@kernel.org>,
	Fu Wei <wefu@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	Han Gao <rabenda.cn@gmail.com>
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] riscv: dts: thead: add ziccrse for th1520
Date: Fri, 19 Sep 2025 04:44:48 +0800
Message-ID: <71ac2ff73a63bd8674c4bc91fd287390d5339609.1758228055.git.rabenda.cn@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1758228055.git.rabenda.cn@gmail.com>
References: <cover.1758228055.git.rabenda.cn@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Existing rv64 hardware conforms to the rva20 profile.

Ziccrse is an additional extension required by the rva20 profile, so
th1520 has this extension.

Signed-off-by: Han Gao <rabenda.cn@gmail.com>
---
 arch/riscv/boot/dts/thead/th1520.dtsi | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/arch/riscv/boot/dts/thead/th1520.dtsi b/arch/riscv/boot/dts/thead/th1520.dtsi
index 59d1927764a6..7f07688aa964 100644
--- a/arch/riscv/boot/dts/thead/th1520.dtsi
+++ b/arch/riscv/boot/dts/thead/th1520.dtsi
@@ -24,8 +24,10 @@ c910_0: cpu@0 {
 			device_type = "cpu";
 			riscv,isa = "rv64imafdc";
 			riscv,isa-base = "rv64i";
-			riscv,isa-extensions = "i", "m", "a", "f", "d", "c", "zicntr", "zicsr",
-					       "zifencei", "zihpm", "xtheadvector";
+			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
+					       "ziccrse", "zicntr", "zicsr",
+					       "zifencei", "zihpm",
+					       "xtheadvector";
 			thead,vlenb = <16>;
 			reg = <0>;
 			i-cache-block-size = <64>;
@@ -49,8 +51,10 @@ c910_1: cpu@1 {
 			device_type = "cpu";
 			riscv,isa = "rv64imafdc";
 			riscv,isa-base = "rv64i";
-			riscv,isa-extensions = "i", "m", "a", "f", "d", "c", "zicntr", "zicsr",
-					       "zifencei", "zihpm", "xtheadvector";
+			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
+					       "ziccrse", "zicntr", "zicsr",
+					       "zifencei", "zihpm",
+					       "xtheadvector";
 			thead,vlenb = <16>;
 			reg = <1>;
 			i-cache-block-size = <64>;
@@ -74,8 +78,10 @@ c910_2: cpu@2 {
 			device_type = "cpu";
 			riscv,isa = "rv64imafdc";
 			riscv,isa-base = "rv64i";
-			riscv,isa-extensions = "i", "m", "a", "f", "d", "c", "zicntr", "zicsr",
-					       "zifencei", "zihpm", "xtheadvector";
+			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
+					       "ziccrse", "zicntr", "zicsr",
+					       "zifencei", "zihpm",
+					       "xtheadvector";
 			thead,vlenb = <16>;
 			reg = <2>;
 			i-cache-block-size = <64>;
@@ -99,8 +105,10 @@ c910_3: cpu@3 {
 			device_type = "cpu";
 			riscv,isa = "rv64imafdc";
 			riscv,isa-base = "rv64i";
-			riscv,isa-extensions = "i", "m", "a", "f", "d", "c", "zicntr", "zicsr",
-					       "zifencei", "zihpm", "xtheadvector";
+			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
+					       "ziccrse", "zicntr", "zicsr",
+					       "zifencei", "zihpm",
+					       "xtheadvector";
 			thead,vlenb = <16>;
 			reg = <3>;
 			i-cache-block-size = <64>;
-- 
2.47.3


