Return-Path: <linux-kernel+bounces-853016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E25AEBDA7EE
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 17:53:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0AB36544E05
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 15:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56A6630101A;
	Tue, 14 Oct 2025 15:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DfWDy15Q"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD50D3009C3
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 15:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760456480; cv=none; b=rXBxgCiSRdM2c1bTQEmedJRVxOa2Gicv93mMpOj9Vbixpr4qYfCbPOC3IPtN9qGgtXKUGV8rB8sRpie8WNExf3YJIYpc9kF1b32vAk4OFhhzdDTHR6CBSsJZSaxOS/3W+26eW6fbxdaiMi5DyT63augwutA4WqBOh7dbsnGIBkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760456480; c=relaxed/simple;
	bh=FksEnlu5WCU0cg/YHpcnAOATZshUl2DJHKfj4doZvaY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IlCWJONAr6vejDn/sVR4kIzzZCGnGRdfeMbIZIRIFiF/mx895tEBf7LSZewslM3AenTg17omW/nxk9rX9XR3g1xzmihtx82BRs0fYmFeXA5+iSEcaLbhsm8xn64FVT08OJYGBXAccL3X2gjm6Qb4BUEfNFxv1dHj5FYCWPzerA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DfWDy15Q; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760456477;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NyZc7IIr5uPHqqlmg8fs1xLiepRwuPem5qvpkm3Ay88=;
	b=DfWDy15QUgqjDY0REaxWzF03aEuue7zHa8mCD6mRPY9Yy+EoVpXxlJIZZMbtSsLVWGcsGA
	zTU+uR9K9aNrJbf5BNVVE06NyCQclrthM6XQWGb/iak7uRiQeUmHv6vXlB1F7Josz2Ulmp
	snU5fwaMF+/NT3H1w4aogyXMtGOTrEo=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-318-OqiP22kQNcGrn2Z0ef1DQA-1; Tue, 14 Oct 2025 11:41:15 -0400
X-MC-Unique: OqiP22kQNcGrn2Z0ef1DQA-1
X-Mimecast-MFC-AGG-ID: OqiP22kQNcGrn2Z0ef1DQA_1760456474
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-b5c18993b74so54591766b.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 08:41:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760456474; x=1761061274;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NyZc7IIr5uPHqqlmg8fs1xLiepRwuPem5qvpkm3Ay88=;
        b=aRqJJ71e9+Px6P/qOmZXovCqjYa74MFQ1hBKhmfNc/LbN1CmUxwFp+oLavObpmY0cj
         stq/Lt9sQYI9H7Z/Kt0mpcfa7SzodszOm+M9Rk1J9en/ixFbUIOC8EN9rzQwt0X3PjAD
         Uzjp9f3qluPNayRlylpUD9gOWTLl4FtWIuSsdf7KAKwsiu4HQsRBnHXJz/WGxc+0Zo3S
         K9xVAS2U7sRDfsOIAiCNdHtNmFO2f1zh1Xxn5Clcri5geyrlppV0Ev6hjxuYGdqTMlKr
         9YuTLLZ2GGq4mb3oXboMY9sfp3/75Ml7+3Xoymxh+CkzgnOcZHfWSZbEFFfNM/oSPDGF
         C4Ug==
X-Forwarded-Encrypted: i=1; AJvYcCUX8jwYuUbfxnHlx9MvQ+oEFWlE420UjRy6oUQpkb0C1+by7Gsdb8xmCugXQD0tmAfqVXWzRm7H5uOxsNk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXgLaQ8bH/isj07gv9fzyP2X0xgTLpUl9lWJ06hrT/8jGD/E5Y
	YlIz5SEsbwZUa7P+zQpCVK8N23PyKFZJPczmy8nbEQDVWBOTPx/F478bDp8FSRDFyfBKPWtj5m8
	MktPHLQXbrORRmaA/VnF2D3OZBS/vJZMaRqk5j1JuzierYiT6PFMXbn8ef+pwjyJi8g==
X-Gm-Gg: ASbGnctTKgXZBiH3itcPjOuTbTGFoi5Y/CgGwkF/hjAYapEgW5LOhM8zaOXXnUFCYS8
	xdR9LOPTn/r7u87Mk+9sq4moWzcp01gTa9PwpyvnNJFCtRRUXEvV5rmx9LSkfbbttEql8rcZLvh
	gum500zRYjTBxMS5gpE0nnrK/Dj55AVJpZRRatXKx+FPXyoOy25sNveQh0mGCtvYBdsU/WggzzL
	xSCWLrmnslzMATLs9XWAq3hzMNLI+YEvTkw1plDKFHk9OIdADr0WjRJqzDlwKaJkgQe/8XjdsfM
	RVZmGZJCUxoZTIuSFNJg/jeY0KOcvORbWKqU2AX87y4TAzpRuw==
X-Received: by 2002:a17:907:c09:b0:b3f:5513:5cd0 with SMTP id a640c23a62f3a-b50aab9d5f3mr2865071966b.19.1760456474345;
        Tue, 14 Oct 2025 08:41:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE8YOUunm+yEdapdiiXzS/U6J1+P8DXbhA5H68j2co2OB4jD8IFwOvDPZjUIyGKLQUCNJRn6g==
X-Received: by 2002:a17:907:c09:b0:b3f:5513:5cd0 with SMTP id a640c23a62f3a-b50aab9d5f3mr2865069366b.19.1760456473894;
        Tue, 14 Oct 2025 08:41:13 -0700 (PDT)
Received: from holism.lzampier.com ([148.252.9.235])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b5cba45b3cbsm7897866b.40.2025.10.14.08.41.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 08:41:13 -0700 (PDT)
From: Lucas Zampieri <lzampier@redhat.com>
To: devicetree@vger.kernel.org
Cc: Lucas Zampieri <lzampier@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Vivian Wang <dramforever@live.com>,
	Charles Mirabile <cmirabil@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/3] dt-bindings: vendor-prefixes: add UltraRISC
Date: Tue, 14 Oct 2025 16:40:55 +0100
Message-ID: <20251014154100.168236-2-lzampier@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251014154100.168236-1-lzampier@redhat.com>
References: <20251014154100.168236-1-lzampier@redhat.com>
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


