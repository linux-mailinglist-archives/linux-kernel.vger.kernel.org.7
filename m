Return-Path: <linux-kernel+bounces-850423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B343BD2C03
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 13:16:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0810189BB00
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 11:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A229258CDF;
	Mon, 13 Oct 2025 11:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K7sNQVMM"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462072571A1
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 11:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760354163; cv=none; b=F+lSlJKL2SJrgkY/u9+sNf5odfIGTKUIW7t9iG5aJCOkpidedLB8LFJJ6Y9xVaeDLn93/PXXWM/WCVKuIfm3fVyQbBRY/TUsdoZmPnHXgQva9+kE4eVutdyA7WUdkrBUSngPWiybF/WtrJZlx6qA4TSrjh8tJ9MEhvLXtIGNMMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760354163; c=relaxed/simple;
	bh=+6VII37RHqDNfppTlqwcNFr2ZT+PLo6yM/8orE91hkg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ci2S3tf6y//xRZhD3pHTx98KTbPMAGYEMs2/oNit93p/FxhttL6EP5udZ/7bpjtZFYfivlPJVhco/ktld6XC7TcQ0Vaiin3/iNluDp2OliqaYnaldE0DhlVMmsYfW75HDO/+KtDKMmXkrWsgbwKE3Br5szLVAc7ZEBLCt7UeISk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K7sNQVMM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760354161;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4womYyfAPXvRIazIdsWxNUOGmmlPDZZgpu1ixU0rOaY=;
	b=K7sNQVMMLa/WXrPOcRqnCp+tkgxXJoUT7TGNQOCvcclVQoLqCOm79jM8YRSg0McBq1sAYl
	UCVvl1PVw0l2kC4jxtlZ4jb/Ls/DLRBjZDleYZwq/EZvt0AO/NSrsRlzavT4XdZKCnZ9zD
	Pn7+0T/POSjCJ8CEDFvKdJZy6Oa9aaw=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-601-bOHPfnZdPtWmcUVsPVGasQ-1; Mon, 13 Oct 2025 07:15:59 -0400
X-MC-Unique: bOHPfnZdPtWmcUVsPVGasQ-1
X-Mimecast-MFC-AGG-ID: bOHPfnZdPtWmcUVsPVGasQ_1760354159
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-b3d21b18e8fso342045366b.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 04:15:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760354158; x=1760958958;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4womYyfAPXvRIazIdsWxNUOGmmlPDZZgpu1ixU0rOaY=;
        b=v7ugqQmACwZpzrFgcqijrU+mAjp+1IEf1YvLHsiRxIvYGX88VFGCSxKmeQMCxofKf3
         C0DiN9dIwrXXvYuEj8x0xcI20MFazFaO4OBeT4CRC2yvdmGtphorEES4xCMs0ZWrXMpg
         xIUIpR4a8UYH6wu+2DEhK91hGzwCCEDI8bpoJ+h7z2dTaY2X7/tkMU1lB8pWm+X8d5Kf
         HDXbITh14cVkLWE7BsymMbIEtDzyeli5wXXL6cSSI66gH8O20RJQUtWBF5u1jPrXdvNt
         T2M1Fre5pEYCHdbfdr6PFImBf/2mucV57KYF+Sn7JnhRx2tl3y70Du/ppm13OX7TogqP
         4yFA==
X-Forwarded-Encrypted: i=1; AJvYcCVEShI7YXZWFOukmhVCR65irU5FtXEKUsr2tmpt/kEga6P9AerBmtL8l+oazrWU3RqJX1yGfxsfByE46fU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvS0oyX4PHeGyBtjevSA9/HHobI/RhTLV6Huz+kVAw6j2gdYDc
	Z9d/cAhtRSt8VUsyJG2Xl/cGhwnWoztbKvuLTBl77z9BlNKg9HuDUYffcRUoci7S7a7CkAF9vRq
	87wliqpbebR7Tpu63xXkvzoUJr0Blaat7Ge6+eSgG9qdFv4Ic82GcccioGvuxh31zvw==
X-Gm-Gg: ASbGncuDKeAx45gQH/wvjiB8Y4WY8bSltXq2SysiJgNsOMhRI6oDh9IWjvytrtFYGjS
	D6mFxpfkX63aADlu0BeVuV8UOBSNgRl3Rv/GS2W0rClYyKqOqOLp9hKJ2DdWg59lwRSDMGqFOvN
	QQXDv+m4kkjGJ4NPbR0dKvmZFiVFEi+WNF1qBS+nfi6/N2PN+CYc1mt2p0OaqsWuJiOq0qgjqvT
	pXRrSxxnSYpfMok4IEF3emuq0kvW5b4nXGn8/gMYS/Rw5D19ZV0e0l5x9Au6VQCQbOoNsCPrNhY
	YmC6w42Udoq9CmZhvg4QmALpmedWHSo+Hnvc85q0B5dD
X-Received: by 2002:a17:907:d06:b0:b2d:830a:8c09 with SMTP id a640c23a62f3a-b50ac6d0efamr1942221766b.44.1760354158584;
        Mon, 13 Oct 2025 04:15:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHg8rg8dsq7zJfh6gCzyRijPZxMfRfezjJZnz19r6DIJjozGij8WAfJBWxcI2QpDp4IppwBoA==
X-Received: by 2002:a17:907:d06:b0:b2d:830a:8c09 with SMTP id a640c23a62f3a-b50ac6d0efamr1942219466b.44.1760354158153;
        Mon, 13 Oct 2025 04:15:58 -0700 (PDT)
Received: from holism.Home ([2a06:5900:814a:ab00:c1c7:2e09:633d:e94e])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b55d5cad8adsm917336966b.7.2025.10.13.04.15.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 04:15:57 -0700 (PDT)
From: Lucas Zampieri <lzampier@redhat.com>
To: devicetree@vger.kernel.org
Cc: Lucas Zampieri <lzampier@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Vivian Wang <dramforever@live.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] dt-bindings: vendor-prefixes: add UltraRISC
Date: Mon, 13 Oct 2025 12:15:36 +0100
Message-ID: <20251013111539.2206477-2-lzampier@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251013111539.2206477-1-lzampier@redhat.com>
References: <20251013111539.2206477-1-lzampier@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add vendor prefix for UltraRISC Technology Co., Ltd.

Signed-off-by: Lucas Zampieri <lzampier@redhat.com>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 123456789abc..234567890def 100644
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


