Return-Path: <linux-kernel+bounces-760729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18C28B1EF55
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 22:18:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E664B5A39BF
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 20:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19F4123BCF3;
	Fri,  8 Aug 2025 20:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="JcA2Z/7n"
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA3922C339
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 20:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754684293; cv=none; b=kcXQ0uRrvXFsoPSJPERG/Y3xbEFxDH6DJZD0I/h8mu6I0KLscrSGrnoDrVS13beMc6KEvb8qWNJGSKC55GtM61QQHmHd9CFHkCwXwfBYII6tyyA8IsjH5N3h5p7ni+0wxPsUCjrirWvDA/buXrl1P+6S5IqscNBCUaKqPbw+ZfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754684293; c=relaxed/simple;
	bh=Kq8+ejvIFPau5DE9L114jOiMGsVkvN/+RkJoqrEnsEY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jmo01+Pm64YIBLaaYvxujXhR7+6oeSTSfqOmyRGIrk0uex1xc5D2OpM7QqpnzjzSGWaJ53x+5MD+UbtDhHn4Ickzal6Bk0Vq1jklUgz+Hussx84qMCl36+RUfq+TXiFiYED7C4kCcGntUF2JD+KxOUuexT800YgwaqmpcgTSOzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=JcA2Z/7n; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4b0a27ebf01so14009401cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Aug 2025 13:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1754684291; x=1755289091; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v/EURho8HdzYkRlNQqj4Jp25lWoftNvoIKLrAmtRbxc=;
        b=JcA2Z/7npS5SkHRQEmgLgih7v0cDldqcChbz7jvffbKPBZmIpMVrNPEsjo2cajRrt/
         SJ0cYv04yeiVB6sRzrjR5n/z968kMXBkWviOX45762zJM7XvZLzAG4KcY+o+N8wVa/9Z
         ZNOCy7WCH/+UKZ93G9cy2kEDd0FuhSoNgukLX5vIfqhz37K8Afp3fi28vbhL+ITGWpqn
         L3KJdpJSYjHjySD4jfoQl/58qVSnMv5uKagzq/TBNQP0T02Adrm9zjtWTvQ1RQI9EB51
         W34+1zpMP4QNz5y6P+A9b42Bb9B2jyuopJhVEE4Qdq4XfzihmSTw65GUBBQCLTL6BMnx
         OXvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754684291; x=1755289091;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v/EURho8HdzYkRlNQqj4Jp25lWoftNvoIKLrAmtRbxc=;
        b=suCxUWOALOtileFpqcuY5u99QNdUDF83Jmp5Ga+sd/ub/Iuoyfwl9Dtu9Bhs47kSMa
         PYd1hvlZ8ZvEwRIjBdgOtxzohdIUX3vZSWjIyN/6hu5Lq18VW9h8tfxrdGZOSlZNxi1K
         w9c4TafPk1rubj/TKf2b5xd+ViQn9Bl4YLOK56g3fwyAPrjGMsGAFJSpJ63zlSGrJN1f
         92mo+zEsLeiDo7HGAJmJWV3F/zUVq/MzmI8L0fBxNbGaRy7/8xB+PszlOkqp2omKqcxk
         tLiGyTocUQSydpYzlmgA02fSt3bI+3Esel8qoo+Hjo5yiDfQ5+LxuSdHqpzJO5NKBn23
         tFEA==
X-Forwarded-Encrypted: i=1; AJvYcCVOcneOmTDs24hegYIkV+Y9VWu7qoOBMZrKIpKzwl96mnWkAC+k/l72p/YaBtR9ZDGmw8WDXFxhOibMbyU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMicHAnxb5bwtQ3zaArvJh66daEBNdUpdeejIfVNBQ5uBSqtlO
	WEFZm317uxv36/SLZJO4ewPV956P2mTf0iytn6oG+pfBewgvSSLFNjWM6RNbwoKHVFo=
X-Gm-Gg: ASbGnctOmH3PE4dulmRYbW1JxGz74xWid80IgcmFmpwzXvsBPaAmMvF4IXrO55u4fn7
	A7cL92MG6Sb9Cpq2qJnC9IpPf3I0ua4ZCgJYXOlhFn3esGOMBlXP43f2sl480cKdLm0+ve8dIUz
	8yn8xUo19lvC4adGQ6Kg+kWlj+1XiuL2KivledBti7oOfxo6UDgXhbJ7/akUZI17EeOAu7SWW5V
	vf//oX19WOVErI5X7WgBj+3+Wo4p9IAnKP3RW6gWvLAyWAltd7tYEkQSUIucuHaIE80rpDfk6gA
	3R3p2Mp8bAbiT/enyqRcS0dvm6ywbsIUy/zQbZHmuE/soDVXhwyjxO+XdgqxiOrdQrmaBAGjxr+
	Z983I+ccqNRZNbd5MMmckL0u8cVnrqyTZQ/v13BZinANlWI5Gy/S7G1yVbaV/8938sd3gTEx83z
	7BHsvWbU85ujiL
X-Google-Smtp-Source: AGHT+IGRsYIjYMDPHPWyETlwLlG2Zy30jh5DmGcJISmzXiHxweHbcXx7yy5GDLFSE/EbxlmscbGNTQ==
X-Received: by 2002:ac8:5701:0:b0:4b0:695d:9ad0 with SMTP id d75a77b69052e-4b0aed0ba35mr50986991cf.3.1754684290662;
        Fri, 08 Aug 2025 13:18:10 -0700 (PDT)
Received: from soleen.c.googlers.com.com (235.247.85.34.bc.googleusercontent.com. [34.85.247.235])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b07c80ddbbsm59490131cf.57.2025.08.08.13.18.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 13:18:09 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: akpm@linux-foundation.org,
	bhe@redhat.com,
	pasha.tatashin@soleen.com,
	rppt@kernel.org,
	arnd@arndb.de,
	coxu@redhat.com,
	dave@vasilevsky.ca,
	ebiggers@google.com,
	graf@amazon.com,
	changyuanl@google.com,
	kees@kernel.org,
	linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org,
	linux-mm@kvack.org
Subject: [PATCH v3 2/3] kho: mm: Don't allow deferred struct page with KHO
Date: Fri,  8 Aug 2025 20:18:03 +0000
Message-ID: <20250808201804.772010-3-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.50.1.703.g449372360f-goog
In-Reply-To: <20250808201804.772010-1-pasha.tatashin@soleen.com>
References: <20250808201804.772010-1-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

KHO uses struct pages for the preserved memory early in boot, however,
with deferred struct page initialization, only a small portion of
memory has properly initialized struct pages.

This problem was detected where vmemmap is poisoned, and illegal flag
combinations are detected.

Don't allow them to be enabled together, and later we will have to
teach KHO to work properly with deferred struct page init kernel
feature.

Fixes: 990a950fe8fd ("kexec: add config option for KHO")
Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Acked-by: Pratyush Yadav <pratyush@kernel.org>
Cc: stable@vger.kernel.org
---
 kernel/Kconfig.kexec | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/Kconfig.kexec b/kernel/Kconfig.kexec
index 2ee603a98813..1224dd937df0 100644
--- a/kernel/Kconfig.kexec
+++ b/kernel/Kconfig.kexec
@@ -97,6 +97,7 @@ config KEXEC_JUMP
 config KEXEC_HANDOVER
 	bool "kexec handover"
 	depends on ARCH_SUPPORTS_KEXEC_HANDOVER && ARCH_SUPPORTS_KEXEC_FILE
+	depends on !DEFERRED_STRUCT_PAGE_INIT
 	select MEMBLOCK_KHO_SCRATCH
 	select KEXEC_FILE
 	select DEBUG_FS
-- 
2.50.1.703.g449372360f-goog


