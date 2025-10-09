Return-Path: <linux-kernel+bounces-846439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D2B85BC804C
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 10:21:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D272F4F72F0
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 08:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCC7F2C028D;
	Thu,  9 Oct 2025 08:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d4zz/Djs"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17EDF29ACD8
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 08:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759998094; cv=none; b=aRQbNJIoQaMcQzEmLb7DAC9CFAzVX12Nx4W4mYcpGPzBjfQ0oMGJB77mvFZOUtjcAx5/YT3j9hJjISBjV3SuVY+XkTY3kbrKo318Uh5m6mdChMem8LvfZm2yMSaemGhU4c69BO2JvKIJL1h848nICzJHOh5YNc5yDgNHlsSbEJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759998094; c=relaxed/simple;
	bh=oUu13nAPqZ9Sk+3NClMhwJiqKDOxqXNHAlUK88P0GdQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fA3w1dfSrV47MDpCQ3U/4NVAKkAOabcuKHNf48FicecsbbOptoCsjKrLdbUg2HTc3ErLgSrUA/Lcyk3Di5T/DkWuVtl0Da+zcculMctyuHxvNPbUXQ1ZCZK+wW0NTLmPCTdy7DqEcRz+9rjbYPLQYZkOMbjifMb0s0HCR+UBj+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d4zz/Djs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759998090;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=69ME3BFXEVp+2f1cKazmVJlzdaHKV1pAL9MxTHMgn2Q=;
	b=d4zz/DjspnM8qYx4RtxSLuocd8oR3znehTabqIkBXz64qDS0OvbODrQu43OcxKadWS0qwF
	JPpmmCq2xaDaXsaLRB9MpsPqoZp8T98d5cxTYnx+lQQreM7R5N5kWoRhxCezi6EJ18Y6xp
	jmtA85FJ0d2atQzPSBIepDVbFBC3+jA=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-BSmbf7lAPH6kZgjCeHtG-Q-1; Thu, 09 Oct 2025 04:21:28 -0400
X-MC-Unique: BSmbf7lAPH6kZgjCeHtG-Q-1
X-Mimecast-MFC-AGG-ID: BSmbf7lAPH6kZgjCeHtG-Q_1759998088
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-b3d73e1ed87so82845066b.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 01:21:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759998087; x=1760602887;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=69ME3BFXEVp+2f1cKazmVJlzdaHKV1pAL9MxTHMgn2Q=;
        b=qT0SNt8/r3VeE/4B9nfqc+TQshJf5BBsJW4dPIggnP5tCgO42TIPpS5QCLFkecjPI9
         26RX9oKzoyAagacpIJg4HqdGCr9fgumaYdpbVlXbLj8soCQCCs0RWQs2aBwEKR8onIdL
         HgpLSSgJY15uQdFuU1eAoU+f/YPfMOQ4ieQzF3FhECQBeYW/3aFqjnpMJ5qKW6yOV7Cp
         ZfJbndvRJtXIE/lfpyA/XMHh/dOVsmXSOLw0GIfR2NXIF1Q8oJgGKZ2SeGpw9raRJf5d
         roczfQIP/Rw2HVp3OGtNWGVUnni6hBUVpt2PhlEF6jwyocwvtMQJvlvms8iU0y4wewyk
         OUng==
X-Gm-Message-State: AOJu0Yx+nH7qMLLquVL/xil7QJV1dgf3OjR0JaF2mlXF/dNe/5UTP0FJ
	Opcb8OjYSJRKGkhIQB1MSxHUdF6DNcI1KBS0VmvHcsKmAAZa4lejHa9pJYOUvJtUZlUGiFgBAg9
	+WzmEWCihHmBzPHjwZ2LAePwp09RcPdIlCXtQvlv0mnyIMLaTYQkqVfvmFiC5TI7h5Onsfg+4UG
	VeFKrg5G8xxhgHxc2B7ux78NmivlO/reTC0jw0vPzqBLeFP9a6vhZx
X-Gm-Gg: ASbGncsv4GC/8L821Soic2sdrfpyzx9yUPrM0YBnLPeUtYxTKlyCVdyCXDn+Jx6jj3I
	Qm/6use7Yz1UK9AV3742lYBgd9AzO1ZIh41Omsg/XcL9rNP4K3w8kI/DCmvEvfsP/SCKJpdrh34
	Hd0Vb4G99aPZcFB+KNEYXnYdextxsUQxb/D56yK3UpiGzPa36RU5P0FpG7PYdEnxCVSg0zYWCiP
	/meHPFxWX+P+qJmKH6CJeXTwgwdZutbZHJdTcs/7NZasjUE0a5JtVUNCQTJMkv4d2m8nVFdodks
	UNgal5UL0r1+7eyitkho4v9TwrPgDDljDJWEZhV+aJgycNuVEQrE
X-Received: by 2002:a17:907:a4c4:b0:b2a:657:e733 with SMTP id a640c23a62f3a-b4f429f034cmr1151761966b.15.1759998087410;
        Thu, 09 Oct 2025 01:21:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHVjMgqntPb0Ku3WrCmKlIFeEE9zkajxUeW2OCAErcWYVR5IHLUb+ylRoCc+fH0u/EYTD7qaQ==
X-Received: by 2002:a17:907:a4c4:b0:b2a:657:e733 with SMTP id a640c23a62f3a-b4f429f034cmr1151758366b.15.1759998086937;
        Thu, 09 Oct 2025 01:21:26 -0700 (PDT)
Received: from holism.redhat.com ([148.252.9.235])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b4869b4e27dsm1832988266b.70.2025.10.09.01.21.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 01:21:26 -0700 (PDT)
From: Lucas Zampieri <lzampier@redhat.com>
To: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: linux-riscv@lists.infradead.org,
	Lucas Zampieri <lzampier@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: [PATCH 1/3] dt-bindings: vendor-prefixes: add UltraRISC
Date: Thu,  9 Oct 2025 09:20:11 +0100
Message-ID: <20251009082013.1331361-2-lzampier@redhat.com>
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

Add vendor prefix for UltraRISC Technology Co., Ltd.

Signed-off-by: Lucas Zampieri <lzampier@redhat.com>
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


