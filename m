Return-Path: <linux-kernel+bounces-846440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A184ABC8043
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 10:21:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC79D1886B6C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 08:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EC5427B335;
	Thu,  9 Oct 2025 08:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J+h95Nq6"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23BCE2D192B
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 08:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759998098; cv=none; b=BlD1L+IFGcQ7rTXayclVRz+NXXXVePK5+crVVvGNqZ3g1kV+LwwJWG9kt970/+NiVefypBTaNo6HkPAHp+MjNYaEIgbSalWSC1I1rHYrL2h2i0l0y5+UO17v0bzUeQnovFmKAuoDgO3Ovfc0ewEfXnp/weGa850B0fy5EeZLneE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759998098; c=relaxed/simple;
	bh=3NWYAaHRAHCqu2RxswRl/r2DPM5W5OJgweUTFiPX4Oo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G8x+yXCLoaDJx9p33l+OlSc+l1l96yXYvKrajTFgE3LyXR3Jl1gE3fjTmvZGeCLcBo+4ZRX4XWxZ5+rijRQDa50A/lCeD3vvih8SEc2NDxGuNcTnfS7HYMRMRu5RL6JczlQ5KcgoBrNHjpUU2qWT3JNwdUnLKbTQ9m72EH+/0Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J+h95Nq6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759998095;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OJVyxgI9Fg/pvM8nQUTMBYCnsJurTQ/jDlhcr7O+2R4=;
	b=J+h95Nq6A/aqUuBqmjlBDtEqiJclRW/N93Wnx8o9wekrmGNMvbRgM1yll2v9bfVDQjU1BC
	A8qrckgvAQ/Myfi3+4msasGqzmyqOACN+OJAMFtSMcWF3Ye1xAXmj6apzf3F7tdeLgNR4m
	T306LVV35gmbloXmMkGxSKPBJnCWWjI=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-300-MDqa7h44Pb-x_6Mhbu5UzA-1; Thu, 09 Oct 2025 04:21:33 -0400
X-MC-Unique: MDqa7h44Pb-x_6Mhbu5UzA-1
X-Mimecast-MFC-AGG-ID: MDqa7h44Pb-x_6Mhbu5UzA_1759998092
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-b2d1072a9c4so51442566b.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 01:21:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759998091; x=1760602891;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OJVyxgI9Fg/pvM8nQUTMBYCnsJurTQ/jDlhcr7O+2R4=;
        b=r02+vo/WB19l+m77MFXVf+3P33+ZsUOUDXsz+47N2r0fzljyAygfVgQMHG50xHwbDS
         EX7G0e2fDvZN/pmdJQqBMDv4k/dSTch6/saqb2/Mwx0n6POqw8CwjoIfQMh2llGzZm8g
         jzcE6S7PuvwcyB7bVXarac3ue7T3HSx8KPBEAjsVrbh0iWQKMoQsVaEUc1bbzPo/CqRP
         VYBzpcx9tU53G2zudpKPAdHPOOzyvtX1Yu7bO8AfQyVsOSFOZ51Tkp1icI/FQmCSzast
         1dHzqo+6StIsk4lBSCVvYPeQ6RFvVOfIFmz68q4bJQqnrylIzbzfGeE0cagIT4O97XTH
         ESoA==
X-Gm-Message-State: AOJu0YwuD1fSgOssyRABx4tqc4py43JKiozR2Bkv6VwWT9L1GNuKwFDX
	gPYPWFeSV03Ka5zaNpW68QNTiX0fqR2q4M+/nlNLLASPudmc1y04gG+aZ9YzeCttbOym0uRs3g2
	X/yRetpblYgXMat627rJUP0n0tNAi5QbaMT0/6VSBQjpi33s6AuHA2Owe95c71c1VqkKFu7W4oA
	KIffpVrR8GspzHi1Pdbx0+zf0BcUdG+THjdPI3WnQNpoR42jNdlHSq
X-Gm-Gg: ASbGnctGYxfwLgEBWZcXaWXgdXaD1U4MNNMHaTnMwRMYNN4gqhzvr+tauH9uzr88/e2
	60PWV83iyTRvNJv2+gaKg+qwvmM1N40vv30HDfUTOdrYs1spJiQEip4VUWtXAeOOfWB4DXEHScE
	S8mjGkt/K+v7kd3JuYZWgr1X4msGj4EoP70rs0YjbfND0Ehu0+Q7W50WTFXZxFYdoXCKMqV5IGv
	/L+yQkrB92fIVptfFk93WjF1/YPJOTg9DB887VvPGWfxQNlIjFDeSTo/Jer3VGqdecYRf8v6plQ
	LPBm+L20Kj1OGB3sw+dPoiurBNxSYwF92YUGnEMWyfTLcmn/xOat
X-Received: by 2002:a17:907:9349:b0:b3f:f6d:1daa with SMTP id a640c23a62f3a-b50aba9daa2mr758265666b.37.1759998091363;
        Thu, 09 Oct 2025 01:21:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IExcmQ8eTxCm2s2PTF2ZEP2FFTRKkcyMU7KFMgI3ry7TZh/TDeJ/CUdqVKsrHFgFuODCXnOZA==
X-Received: by 2002:a17:907:9349:b0:b3f:f6d:1daa with SMTP id a640c23a62f3a-b50aba9daa2mr758260966b.37.1759998090808;
        Thu, 09 Oct 2025 01:21:30 -0700 (PDT)
Received: from holism.redhat.com ([148.252.9.235])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b4869b4e27dsm1832988266b.70.2025.10.09.01.21.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 01:21:30 -0700 (PDT)
From: Lucas Zampieri <lzampier@redhat.com>
To: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: linux-riscv@lists.infradead.org,
	Charles Mirabile <cmirabil@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>
Subject: [PATCH 2/3] dt-bindings: interrupt-controller: add UltraRISC DP1000 PLIC
Date: Thu,  9 Oct 2025 09:20:12 +0100
Message-ID: <20251009082013.1331361-3-lzampier@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251009082013.1331361-1-lzampier@redhat.com>
References: <20251009082013.1331361-1-lzampier@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Charles Mirabile <cmirabil@redhat.com>

Add a new compatible string for UltraRISC DP1000 PLIC.

Signed-off-by: Charles Mirabile <cmirabil@redhat.com>
---
 .../bindings/interrupt-controller/sifive,plic-1.0.0.yaml        | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
index 5b827bc24301..a419de50f5a8 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
@@ -74,6 +74,8 @@ properties:
               - sophgo,sg2044-plic
               - thead,th1520-plic
           - const: thead,c900-plic
+      - items:
+          - const: ultrarisc,dp1000-plic
       - items:
           - const: sifive,plic-1.0.0
           - const: riscv,plic0
--
2.51.0


