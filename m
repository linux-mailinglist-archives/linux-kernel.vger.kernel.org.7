Return-Path: <linux-kernel+bounces-780264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF091B2FF96
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 18:05:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2EDF727788
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 15:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D9CB2D46CB;
	Thu, 21 Aug 2025 15:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BsvbrIM1"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A28C283FD3;
	Thu, 21 Aug 2025 15:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755791887; cv=none; b=KCTbMJno7lnYcNXFGXPr5fA1FHZuYB1J9V5bUbk7bx857J405K3azJpgx1FZismWEHtQ8SzJbw8ofV715nk8euP0HG/qIWdMpW5EB3sg9OmQspAtHd6zd7ai5KpipdlmuVv2Js1ctHeuUM907BsDuocIeLOcCH5FwRdNxiafdYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755791887; c=relaxed/simple;
	bh=pTUWkvNCIyhLcProl9XhpfAEq16p+fwv6rNm58M87Cc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hk6cpo49xPS2+5bw4SOcagJS8RAUKRoT0j5UmLjBtQeOb9eHYU4YmCDoUOILwEbVkvhc6deQ2qvqb/YkeJcW2Z7Dg8UgxSoxWKfOZlYetXAuc12q8/a/iCa996+LnSaijn16702aIiXKDYT0uk3c3KJlQw55zsA/8xAfBxJHxq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BsvbrIM1; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-76e2ea79219so1453858b3a.2;
        Thu, 21 Aug 2025 08:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755791886; x=1756396686; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7jrUSLF8HrmgX2IqYpc6hu8jyDWmvx8chNYfkelzvuE=;
        b=BsvbrIM1A9oIUNiZBjqoNiKUfOicGAydxEh4zr1kz9ZgqTBSZ+EO2aa7IM5+z+/0og
         RdVRYPZePu0ziNJdRrk8TSLcqAz25iROvqKBAVMtM1ViFIXjR62EyjyHvBYHOzJBC/N2
         KWeJ+D5rjf7soDJaNz+x8NgiiR6KacLxTi5vc0Hx6UZwgjUkmVuQc26igPfLFw41Ij2f
         2wPRn4AoeWGeq2sP0ECi+QBLC/rvZEampP4KmvSLlDOs/syOtuGcAOdZqKwlOs4yLVQf
         U5nIsjM3kC0trDVK3lyxjQ4vHSbC3HyMpko6zUvLj7T6AIy6PsbsHEdOW8ZZiX0bOZBj
         mBlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755791886; x=1756396686;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7jrUSLF8HrmgX2IqYpc6hu8jyDWmvx8chNYfkelzvuE=;
        b=Acrjd79vEP0fSXTmlNPd2yox0TjGrvtg8ZZKWqaxhobogE/JCBbns2+ynalldfS9Wc
         bTgt79HjCM2QBw5m0W8lU5MtpRJGSAiW+hB4FsH3GxfF58cyUS1+SdCC2SAL9dRJCrHW
         ygsZHAK1+xH41MWKA3SXj7vM8iyk7Jud8EWLoi7yXy5eNhEXsXsI505ym4HGLJCUS7Z3
         ukyNKoesYMAZFlyqbWJmMwYIfQxTmFSyNylprIreDmq5/jkJ6cNB8zmQmVBR88agv7Y/
         P21gj/m1VSlbVGWfgxNSh6iZROkjzZAiBfTXA787gPoiclmAQbylyd4Vfv/io2nSTRQi
         MxRg==
X-Forwarded-Encrypted: i=1; AJvYcCVZWiEm86YIRzjmSDsXEOgBVseG73BObN0ouVclYG8i2aQsPliDT2oKWF6d7VBiqx96zZwYoItYgGrEJn4H@vger.kernel.org, AJvYcCWE/34jz+YEbc1lEOIO8QbfB1qbMuoupQVEpUTy9pAxrygMKaWTmqIP4qeUiQatfb72ZpvMA02RBIa7@vger.kernel.org
X-Gm-Message-State: AOJu0YzyDEGE3BRtqoZtuWGxB/DEPIPXqS/NqOle4xvh65JxBl9b2pzf
	5P7JBt+Wg8wFtXSUFhUd0hbbn1yefviAybr49SiWjvFPREAipY7dTZs+5Yw1tA8I
X-Gm-Gg: ASbGncvJzlfv+j++SAQY/werpz3EP/3HSrxbAoLYCrlobcPrZcAEUMxU7l5xAu6vQGA
	PUsmuiGy/HDjWZu8iL1eekZLIS9qc0/pG8BX6CeE+8i6/NL9wCh+tr3yiyIVavAKORiJwE5K/zt
	CTOkUgtECaN7qRxp0xZekBEAi+/3nVpyO8sGhqR9on2QhFxdIUlWfk7VcpM+UG4crX81XGM3wBf
	U88+7rjvPkZnp8qw07VZljeBrdbZafBvRQd3O+UgADhRodP8Vqp/dLtbiICZRiB2dDCilfTKKdm
	cWLaqdtswutdxm6ItzryeQNXPOPQt5kxhh2yqkuUlz1LuU1SV16RC7bR87g9TIuMgEWEus09KuL
	lN3peFnh0bT40gAfHKJA78gi17klfe0LRIvizR+GvP12VqeU=
X-Google-Smtp-Source: AGHT+IEANrnSY6fFShGILep2ycHZBMPux8sJi2tr6F2Rs1Ziij66iom0whiB3Kjde3in4VCY4nqZlw==
X-Received: by 2002:a05:6a21:328b:b0:240:75c:6f40 with SMTP id adf61e73a8af0-243307c954amr4973125637.14.1755791885735;
        Thu, 21 Aug 2025 08:58:05 -0700 (PDT)
Received: from [127.0.1.1] (061092221177.ctinets.com. [61.92.221.177])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-b47640afb33sm5094320a12.38.2025.08.21.08.57.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 08:58:04 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Thu, 21 Aug 2025 23:56:45 +0800
Subject: [PATCH v3 8/9] arm64: dts: apple: t8015: Fix PCIE power domains
 dependencies
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250821-t8015-nvme-v3-8-14a4178adf68@gmail.com>
References: <20250821-t8015-nvme-v3-0-14a4178adf68@gmail.com>
In-Reply-To: <20250821-t8015-nvme-v3-0-14a4178adf68@gmail.com>
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
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBop0HVmCaSw/+oi3sVEhtvuJHWUTvf8G4prmp//
 YiXmbkm2zaJAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaKdB1QAKCRABygi3psUI
 JNK2D/4mz5vu/Rrjfd46ezfd+12en5Stf1fevsnGAnRYJmwNP8Zj6ewOMDKb4Hckbr65gbaranD
 OJvCXduPVY9ZRPucRECvzMASR04HDR4v2cIHjb5up1ho8zS+wLOfRxOYNEaZO5ktb1B9ArBaiGA
 wfgnzBeZdkzBMSo7YkVwl+NzOOxNSQTLT4uHdvz49KXPWLrFN32P72V3ljyxXnQNlCAtmCNn8uD
 xx3eH94bhUFbM3S5opENJyqagxAa1FBemcAN+hRu/dRqQfgK1swLrWe0Oy3OO1HmGpmEKbvXm8I
 MYzrAbr6V0FqLUJvbPh/Xck2EdsfumT+0+PG/p50KfM7pLvKQDRqKMMxAqlXlliR3U/XkzcZPg1
 FsgQKhYDvympCQs1t1eycSHUAZu04LFNHFPuIA3IX4HTBdfV5ch2xLMsm9jXK0LWYej7A3V9V1S
 JWMx/i1eZWu2XGGRM3XkORCctP4PXtasy5MJqaQ4r7oKj+1kemOwGWZJnmY5bHeYyCYE8amrOlk
 hIoe0sRkETeS2C/+MJq2ODhDJHwcj5XuEAz71QwW7r7pbQ6jXoJP85oZscInTKf7cpAzzS+Xcnt
 iwSaZm1PFWWRGr66hmj0ufw4LKq3Mjrh9lPlH8mQOwFjp1T73EEdYaSnw/W2H4MiB7PibcEv6Vm
 k5r4QFW71ZZa3fA==
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


