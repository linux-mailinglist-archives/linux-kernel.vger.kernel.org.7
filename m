Return-Path: <linux-kernel+bounces-855755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4C34BE2340
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 10:43:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F9943AAAE1
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 08:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 061CF307AE1;
	Thu, 16 Oct 2025 08:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KfZ6HJaU"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5BE52FF65D
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 08:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760604204; cv=none; b=LytbqnxZ1pj09mA8rjpVc3E6DBNPlRYwwb8fW0AjrVs3OTMSULefX3jpR3GKoUVkGmxvXttnqblwBVljGLRwtNve3hklhdGaiCXCkhI+Um8gbaAk+uGqKaCJ/XBChlZAay8Hq6Ad695J/64lGMha4vHg8vKKg/kVmRRtHekeRh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760604204; c=relaxed/simple;
	bh=GwdorghP7pkx6jrL0xNhcOjrQ7rW+RmSi107hDe95KA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VBuTVp1/Sz++Dc6fofVqgJJeo5POTREb2jdxzBaBZ9VNxa+ELDxq0rdAynIRzcz18wFfyUFASuAIBt9XDtVEcbnw+AP/72Hi+GXvrEYvKLZHyzHQLuaRYKOtmw/ZTZHHITqQpcU89ErZBnoifXzndXBJ4ot8gCywZ3i/ibLlz5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KfZ6HJaU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760604201;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NyZc7IIr5uPHqqlmg8fs1xLiepRwuPem5qvpkm3Ay88=;
	b=KfZ6HJaUAIH1Lt/DlkqEsEtU0MsCanyLel1xP+QYZMA5R2MXBXTbHnAp++UGFbVx8g1oCM
	1JqSG/F8eKepk0w4KNuuLzMhJaI+ckUtSzyZkHjScBaCuUOBWsqb1AnK2/giLBCSh02gFu
	BgT7aAmP4hhhMRAH/YXVHMDOW6ISK50=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-290-j1gs0xkEO2S6FNCTMRkeUQ-1; Thu, 16 Oct 2025 04:43:20 -0400
X-MC-Unique: j1gs0xkEO2S6FNCTMRkeUQ-1
X-Mimecast-MFC-AGG-ID: j1gs0xkEO2S6FNCTMRkeUQ_1760604199
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-47111dc7c5dso2188225e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 01:43:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760604199; x=1761208999;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NyZc7IIr5uPHqqlmg8fs1xLiepRwuPem5qvpkm3Ay88=;
        b=clJOqvELE8cPe2C3VzMmrS/mpbEITHGp043nEoGUN4iY0jK4M+7lAIuhZaMg3LtI3V
         9FUSKKkKnZyPFM55LhViLdwd6T77Ctco4MFtkQ9mxVmmz+Ov2a3LASl0I0hIFeRqB7t1
         IMymtcN18jy+IALcy3ljDmTXO0HyYztBUd/xaqAolPnyrB9OHR29NSAZnhLLVpqeFqwb
         w1/l/DkLMqlvbCEZZag6bNUg2iT2iN4Cw+Sht2N2fTNaFFCHap1SjUh7E/9VsU6KkaB0
         k8c/5EKqC+DPNF9jHNQqNCRcdDK2Pd4O8Tp/81t7+5K9mG9q9F1KS1Ik9hNqqagwkQE/
         NIDA==
X-Forwarded-Encrypted: i=1; AJvYcCVHTHbP3gMwjfLNS6jGE/jcIyoh0xsBO2z5N4yY/vhMMw47JlE7H5ebxkNDDUQTzkSt0jA2jArixZc7UPY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKoI2Vq0iGO4tZ9GxoaafT/m4xdujDowjRNAOlCHUoZfxeuqh3
	dYcs3t0LL28Xl/1iVC1KBC4EqubWBOx/DFyX4tBUgwI8Zuv/hjozko4iSgckEvGkd2WI/e0KYcG
	7DtTOsLOxmkd8i5Ajvj6lvKSeE2GTVHypfbL9ZK5Vdx/KIiWZYMIWPg3ugM1a1l1wOw==
X-Gm-Gg: ASbGncuL/OlFtz30cOLYIFBo9rOFIw4FAlxnjmbUHBrIwhUHFfwsDxzcu0hU2z+0Hzj
	bZIsRYWFtkbnBqE72GKzpeljen5RYW/Rfs9+arCS84oRN1rdzCIJLnfwZ+P+RRLcVxNCQMLMkoL
	EOmVXptPqGKb0k/qexAVUTt3U3gxzJMDzqMaZt14C91WwItPWucChNmcrDw+tPOhZhLYQiIhvbP
	GysITeOfB+hDk6fQEMglTRKC22UVfzr38vOgxze9RpYq7WUi39FeIaMYCuYBx9nBV5kUJeHjmcl
	eroKJCV+8sv5aVa5Wx/5ZwEklaoWSNAXuTMhneF8jD+z1qmVcmClSJqPhYBIqJbOQJN6L9weD+p
	hWmrcxNHj
X-Received: by 2002:a05:600d:8350:b0:46f:b42e:e362 with SMTP id 5b1f17b1804b1-47109b5f2b7mr15373725e9.19.1760604199113;
        Thu, 16 Oct 2025 01:43:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEmApA8Xn0mWrWAdsDCHfPRyxd1aa6agiKyJgov+9nbvSF56luOsz5TtoeRoXkFTcWe5tAr4g==
X-Received: by 2002:a05:600d:8350:b0:46f:b42e:e362 with SMTP id 5b1f17b1804b1-47109b5f2b7mr15373555e9.19.1760604198708;
        Thu, 16 Oct 2025 01:43:18 -0700 (PDT)
Received: from holism.lzampier.com ([148.252.9.235])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5e1284sm33047565f8f.45.2025.10.16.01.43.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 01:43:18 -0700 (PDT)
From: Lucas Zampieri <lzampier@redhat.com>
To: devicetree@vger.kernel.org
Cc: Lucas Zampieri <lzampier@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Vivian Wang <dramforever@live.com>,
	Charles Mirabile <cmirabil@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 1/3] dt-bindings: vendor-prefixes: add UltraRISC
Date: Thu, 16 Oct 2025 09:42:54 +0100
Message-ID: <20251016084301.27670-2-lzampier@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251016084301.27670-1-lzampier@redhat.com>
References: <20251016084301.27670-1-lzampier@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add vendor prefix for UltraRISC Technology Co., Ltd.

Acked-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Lucas Zampieri <lzampier@redhat.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 9ec8947dfcad..887bcb792284 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1642,6 +1642,8 @@ patternProperties:
     description: Universal Scientific Industrial Co., Ltd.
   "^usr,.*":
     description: U.S. Robotics Corporation
+  "^ultrarisc,.*":
+    description: UltraRISC Technology Co., Ltd.
   "^ultratronik,.*":
     description: Ultratronik GmbH
   "^utoo,.*":
-- 
2.51.0


