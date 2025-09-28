Return-Path: <linux-kernel+bounces-835541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 560F3BA7699
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 21:08:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0483178F9B
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 19:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FDF825D528;
	Sun, 28 Sep 2025 19:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ybyFXCPb"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE3C25D1E9
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 19:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759086468; cv=none; b=T0kXRyJelbQUIWuuuhE3fdO34Q3LRlQ0pim2gFEoLaooxoArkVET7WQ2jnZixufcr/7Ohmjd/O1QKP+jHajPktrCXPmfNw1BPuHgDnWs7yyFWhRSao7FIAf545jsgkn26vHgdRjZGrrVRb7Ic/ZJJeijukJirqwk3NltLpBn9wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759086468; c=relaxed/simple;
	bh=8L0DFfHrZlNZX0VjY4FjLPOo4H3abf6EW6LzlAWKOaY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mZ9bVozzAH/Grzxcq2TE0CwJ1WIYPcibPvzdrh1DmfJpuy+D4bnCb1yQe7ulpdUT1jniYmZaCVZg331f1tr8gzAyPlbcG3s8QEBLaySTnMYmxOszJOekHn0hl1KmP10Jd8GmAXg6YhEOHg40CsaJDNayU9f8JP/SHHs3i4mWfDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ybyFXCPb; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-7847cc45409so317497b3a.3
        for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 12:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759086466; x=1759691266; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=unF6bUsLM9O1vzcXGUHanadtXOZ35cPd5k0W1K58MJE=;
        b=ybyFXCPbynpfm2KlLj+2TEFZoa4PM4pDiN2K5OaujpQi/GCmCuyrd26fJQP7h4HSy+
         0bcbBXvdWAUOEqqNELznZ+x9ePrKljX4EtTFy4hIej9oT7o4U/zZB4cPFSdx7IY5967s
         K5DAOsw6ruBauAugfepZebJT2WcG/E5H/RwYOUfA5TTF4K7lx0gQleANyN3Uwgw+xL7H
         cvtP9jo2LppP7PIF3gtB+v0f8KLse6tJVjyhMlAf76HFH7veRXHd61Sc5vRpw1CnCzRx
         BaH8Rb42GPxK6hKeAelqo41duQDTVSwUPHPmcb8d9i4mgnZUFnSwDAtMHsWKbQITtvED
         kkew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759086466; x=1759691266;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=unF6bUsLM9O1vzcXGUHanadtXOZ35cPd5k0W1K58MJE=;
        b=boLilNUiiJb3Wef5qq2thjmG///n+ZQRYTj8Wz15zB1y5goHgiw9ZKZu9E3CaLyXj/
         2+prW9W8Zau3LmIa1PvMbN2HhqS1Q8MlKOQEkcHbTLG3waMTyP1YePSQ7SObYQj0VlRx
         YWQiP2iBqmOYAjxy5tSz5IYhZPILqGeS9z2T+pvglk4jIDwYpsnd5TdbmgACxZJw6bKf
         E+6Bd6GuJTYhjKRyWITaFGA/D84VAp8gyn1BdPXvHWiXeYbecITwZhqUtj3ppEzjbcZI
         JPJGUxGjq4RhrD1GV8DTU8eJcAa88B7i+00OYA7fp8RhHHkkqpoeLQwgo21y3YbirJby
         9baQ==
X-Forwarded-Encrypted: i=1; AJvYcCU3HnFUFbct/Wwxf2T5+Ic/K58qo5ILJzQ2YkHoJWr3epTk1B4B9Z7YXxgc1vBBqn7nhZlup9C+Vg8jj/U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmUraZaNrkU2AJ7cgfkrChqgRNe+LjVwTyCYuysYAD5DUm2Cfa
	BGUtiWnWV7eCiZzMvV5UDFZNhVx7LO2qMbrhbZuncjcgJq/DXwU2VcJsQri9oqr1YI9cs44x52O
	2CBNNtgrf9uvowg==
X-Google-Smtp-Source: AGHT+IFHeLeByvDx3H7Fv/UY9IPnM3xJSFbkXHDcYCobgRG472vqOkunFnZPCYmzKNVjAjQUoI+lXVkr/Z2l0Q==
X-Received: from pfht2.prod.google.com ([2002:a62:ea02:0:b0:776:2281:3189])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:6a26:b0:2e3:a914:aacd with SMTP id adf61e73a8af0-2e7be0668c2mr18263550637.2.1759086465857;
 Sun, 28 Sep 2025 12:07:45 -0700 (PDT)
Date: Sun, 28 Sep 2025 19:06:11 +0000
In-Reply-To: <20250928190624.3735830-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250928190624.3735830-1-skhawaja@google.com>
X-Mailer: git-send-email 2.51.0.536.g15c5d4f767-goog
Message-ID: <20250928190624.3735830-4-skhawaja@google.com>
Subject: [RFC PATCH 03/15] iommu/vt-d: Prevent hotplugs when live update state
 is not normal
From: Samiullah Khawaja <skhawaja@google.com>
To: David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Jason Gunthorpe <jgg@ziepe.ca>, iommu@lists.linux.dev
Cc: Samiullah Khawaja <skhawaja@google.com>, Robin Murphy <robin.murphy@arm.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Kevin Tian <kevin.tian@intel.com>, linux-kernel@vger.kernel.org, 
	Saeed Mahameed <saeedm@nvidia.com>, Adithya Jayachandran <ajayachandra@nvidia.com>, 
	Parav Pandit <parav@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>, 
	Vipin Sharma <vipinsh@google.com>, dmatlack@google.com, zhuyifei@google.com, 
	Chris Li <chrisl@kernel.org>, praan@google.com
Content-Type: text/plain; charset="UTF-8"

Hotplugs should not be allowed when the live update state is not normal.
This means either we have preserved the state of IOMMU hardware units or
restoring the preserved state.

The live update semaphore read lock should be taken before checking the
live update state.

Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
---
 drivers/iommu/intel/dmar.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index ec975c73cfe6..248bc7e9b035 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -26,6 +26,7 @@
 #include <linux/dmi.h>
 #include <linux/slab.h>
 #include <linux/iommu.h>
+#include <linux/liveupdate.h>
 #include <linux/numa.h>
 #include <linux/limits.h>
 #include <asm/irq_remapping.h>
@@ -2357,6 +2358,10 @@ static int dmar_device_hotplug(acpi_handle handle, bool insert)
 	if (tmp == NULL)
 		return 0;
 
+	guard_liveupdate_state_read();
+	if (!liveupdate_state_normal())
+		return -EBUSY;
+
 	down_write(&dmar_global_lock);
 	if (insert)
 		ret = dmar_hotplug_insert(tmp);
-- 
2.51.0.536.g15c5d4f767-goog


