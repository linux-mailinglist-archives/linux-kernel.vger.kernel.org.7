Return-Path: <linux-kernel+bounces-762775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48417B20ACC
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 15:54:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D35AA17CE21
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 13:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D09B022F152;
	Mon, 11 Aug 2025 13:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UMxQ6pKW"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA94719DF5F;
	Mon, 11 Aug 2025 13:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754920328; cv=none; b=WSHC81sj5F2zhceESbbEBp1kCaczGXFxAwstm7Ab9ep3BbTI6mD5XCUOMYirRZvW0PKu+Tw6dXD4CRqwXs8bPETterDMtIwLMNR1qvOFGAFzRq6YKazgUQlJDyULAcdAwEq9A80OwSQNc19Nu129ElJ1QfYlqCsA4t72rpP/BjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754920328; c=relaxed/simple;
	bh=pTUWkvNCIyhLcProl9XhpfAEq16p+fwv6rNm58M87Cc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mmNpqL8hHDC+MzmVtdMG14HPNCTWD7Fk1YcuwYxtbJNHDXgr6ixzVR6yYq0h03hHk4/j1OaTLJ22csA/MOpPy+vD6do/bvcmGYdcNOgHf8sTndNGcY9blKOPkIl5ji5s+QIpYNIyIjRHXyi/c/xvxNd0AtlWW2pQT0XPNqmdE20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UMxQ6pKW; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-242d3ba2b44so12818185ad.3;
        Mon, 11 Aug 2025 06:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754920326; x=1755525126; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7jrUSLF8HrmgX2IqYpc6hu8jyDWmvx8chNYfkelzvuE=;
        b=UMxQ6pKWpTY8UmbONnWaevCA9SeTr63A3zfFv9C4YVKrEP3HCWma5+8aqr6EZrUCSE
         PVfSw++OJHuduF+2sGhjtMjsEKJp0M+d+fMWtnBywG5+HStq1y3tFvc5dcbWwXIZ5raZ
         /7LVlq9Eze5ntJfChZsv/1kZlRdkORJa4BUp1pZL65Kuz4noYt71U5D8JPP4wYQrn3+4
         NL0pQiW9c6qLxQfYjAs2yz8YdLb15vdcj/XQb/TfLBSKTgTqa1D0wWclb4IzGjIoFwLu
         L+hyg5Y/Y9vF3OpRj/dZQHRJp03CoN5uSMd0Mqm43guN9rpNYF1H7bz50Yp2ZBXZ8dQx
         8BqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754920326; x=1755525126;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7jrUSLF8HrmgX2IqYpc6hu8jyDWmvx8chNYfkelzvuE=;
        b=ADDcs/NrlLgqOSWCU2qqTbGsCjbXFJZ5x69S/DZkRvdRpiJVmXEFXO73qdYrKNGKBd
         xsf6CQDrH4jKfMznbgA4ZQ9h4mSXY4wTBjV5JRy6u6dS2Nb4lUUn2N6Ve7qHdR/ocKgb
         Gz40yjqDClF7Mc4AoTR2VkMAG3rHehHSkvrvt2OK+thrij+DxJSuj86Kh09CjBRm6AIu
         t7YuPai5YD+fYdMy976975tSh1fmp4ars5mryKI6IjLxFpyMNmn6Z4M1z5rbBBRZE5HV
         QcDgtFKTpvfk97nM8C6NAZmnfvs6U9Qz2Pk45kybw/2DN/Wgz1cNz6fCFmZcQgydmJod
         sYdA==
X-Forwarded-Encrypted: i=1; AJvYcCVoJ3afCTlzGMX5QNRGKFKkdTXFXXV30Ji5ekmFooHWB0LnOQnzryC+xBH4+Qi+oIN7X5ViDxkA2RGI@vger.kernel.org, AJvYcCWDhi9bp04ySzJuam4LyaN6aZPCw1BbUe3TjeEA3XDQhoMPFvB0N1CkW7LPvgEwmgnKnGHm3GYomsaOVpXi@vger.kernel.org
X-Gm-Message-State: AOJu0YweqPsFBPhpVgL9gNokAP/quLy7SGi+zjKEmSDPdnrD8rhW4s5q
	3RfHzffFKzY51l/sBy/FIGrfL4QTvMzQ/FwnuCyXDPiH4y9oYIbUHi52
X-Gm-Gg: ASbGnct0z2Fd4eohSyZu+QFs5icWhkItD7N4L9SGA5V7OAe/Z7zpZADTD+MQOMn7GZH
	aEqliJipOQo9g6nguMzPfzm1g0FFIvjYOzp/x7P63JpQ+qXVjt+v7eAVAcnhzJhveU82WYosjEt
	RmdU7a9DeGDyUhTh/7dlsikJpuQUQS2n50jRDAcUaW1lCNfWMNDjYMrPCV4Qb8Yvhbd2V/sYT1z
	oHdzVK+jWKpUqxh0c5x+F47segNlRMV6BrUecb+g4JiyJHbLO4EZS/inEw+OdUxKACkkTzHR1H8
	DlYB1YHtEmUFXpbBI//vDpIrY+Lp/K8UA4L5jnBqao59+gkpzn1f+I7Kw8GMaxl+69TPrmmomeE
	gCPkyQn2q3n7mXZdK166uIF+0PHZCjeWlTsrlPhHlRsiLVdo=
X-Google-Smtp-Source: AGHT+IFgm4RzzzE6J5r3iBNe2NZOigsbOyh949b8qoEAVuFdNMyuLJZ2th5tpGzARJNLzEYMcYkYag==
X-Received: by 2002:a17:903:4407:b0:240:1f19:d35c with SMTP id d9443c01a7336-242c2209b65mr207786575ad.39.1754920326147;
        Mon, 11 Aug 2025 06:52:06 -0700 (PDT)
Received: from [127.0.1.1] (061092221177.ctinets.com. [61.92.221.177])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-b422b7b2700sm23504993a12.15.2025.08.11.06.52.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 06:52:05 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Mon, 11 Aug 2025 21:51:00 +0800
Subject: [PATCH 8/9] arm64: dts: apple: t8015: Fix PCIE power domains
 dependencies
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250811-t8015-nvme-v1-8-ef9c200e74a7@gmail.com>
References: <20250811-t8015-nvme-v1-0-ef9c200e74a7@gmail.com>
In-Reply-To: <20250811-t8015-nvme-v1-0-ef9c200e74a7@gmail.com>
To: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, 
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Neal Gompa <neal@gompa.dev>, 
 Jassi Brar <jassisinghbrar@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Hector Martin <marcan@marcan.st>, 
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Keith Busch <kbusch@kernel.org>, 
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 iommu@lists.linux.dev, linux-nvme@lists.infradead.org, 
 Nick Chan <towinchenmi@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=798; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=pTUWkvNCIyhLcProl9XhpfAEq16p+fwv6rNm58M87Cc=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBomfVRpulWh4MRp5/M2zxFrKVaLRt4h6MaA0rMR
 +QTSNA7W/uJAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaJn1UQAKCRABygi3psUI
 JIJaD/4ole1VdYaF3B3syLR82Nf1oZ+zvyPX4nskCUA+dlYnOPXR/DgGgwNxxRkSfTJkWvTjxEf
 b/sUDSZQzdnbdO60VfzpXw4yaBcWWMvjnMcisU/kBxYW90no9davink9VsL/5jjY+X9DegWBdsx
 I3DTjjBi7hIUc90SZF/sd6SULA87lmyM0rrfNORPgcTKNBalPldknE+rIs0Iv5fBdNId9vdsmAX
 4UDOjEE/PMVO4cOYCth+kP1Iz0I50BftFGakkSEObwVzMkbXnt9NcaQYmnLmmqwhXtTHuJ7NY3n
 Fwlu9wDTRKWV8rsMB6gwlDC9ZnuMi0Ndlnc/1zHfkDi1YqAUa3vK3qZd8qsvPAHe+iUzjpq0gGD
 5jVIga74uOTkS2de52aBK1M8Cpn3Ln3xyWrRhyPEdtUzjx0DlmRnXcGjUt0V+ObyGINdSbs6BEc
 Ab6qBtZpNDDYaqUqxnC5V/o7qCHfK7RlXPVVw/NPISdXxDbkhvrOIqmXJW2FuN7mFgb0iRpPXuA
 6VMBCnxr5sWvKMPlEV8vyGAIZE7JuznOvv4DbzUwedcsKItgSQ5KT6mujiB8nloLKwI4hWJ8/f6
 0MTe4J1fFcTItTHtf341IPux0FyNTG62adT4oNHIWATLDI/I5In4VM9rm4UHUmADSeqjBqTeLrA
 yu74lDeSmi/0JkA==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

Fix the dependency topology of PCIE power domain nodes, as required by ANS2
NVME controller.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 arch/arm64/boot/dts/apple/t8015-pmgr.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/apple/t8015-pmgr.dtsi b/arch/arm64/boot/dts/apple/t8015-pmgr.dtsi
index e238c2d2732f7944dc1f984a4eb647ba212b9ea5..1d8da9c7863e5b7a732888342de9d481f309edd8 100644
--- a/arch/arm64/boot/dts/apple/t8015-pmgr.dtsi
+++ b/arch/arm64/boot/dts/apple/t8015-pmgr.dtsi
@@ -658,6 +658,7 @@ ps_pcie: power-controller@80318 {
 		#power-domain-cells = <0>;
 		#reset-cells = <0>;
 		label = "pcie";
+		power-domains = <&ps_pcie_aux>, <&ps_pcie_direct>, <&ps_pcie_ref>;
 	};
 
 	ps_pcie_aux: power-controller@80320 {

-- 
2.50.1


