Return-Path: <linux-kernel+bounces-725285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7677AFFCED
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 10:55:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C44A01C2751F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 08:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47655292B48;
	Thu, 10 Jul 2025 08:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="LENEC6da"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D7FC292B5B
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 08:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752137667; cv=none; b=A/qrFmIyNAg1RfHiVyey5n6EMvHwSs36C8FJ7O1eHITXjDN41CJTY/mKmzPp+v2uGGUo+o+avDQEHaA1cTNP0bcWinLrETIrATAiEAqYA6KNaJgZRp9jSRWNTm4l8E7Mtrbt1CyW8DBlaBlHs7LNbI4bpsvi2+s/doDJTJ2GEU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752137667; c=relaxed/simple;
	bh=kuMO4alh4taqq6qqK8Ezmq1eFdMQaf8rRvbNnP7x1ZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ewaXxvDcA08GdKd5CkLUFVZsK0eqRuS2DlgxFOZRg6uXOsEfKh/xgw6A3XZe1LaRihrHgGXzm2dDVRsHO4nSvhA/dJ9yaX2DmixquUYiOvim5pLVHTGYgr/FuxDrDW2zWsUFxVRmJqyNJCgzz2iGD7kyzI3fhem6QlIXbqk4BAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=LENEC6da; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-237311f5a54so6588755ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 01:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1752137666; x=1752742466; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=euNz/l/CHGPv/Gat71a8nUVi70h05zHrvuBm3oNz29E=;
        b=LENEC6dajcKktGlvKMstisUT7+YxOsw6i+54mmKubHTWy8oH2js8w+1etQkArkfdPd
         Z5BO9cwZc7LFDTpSt7kwHcQzOUEnB1YTVUpYfrP5nbq7aa92r9sKiscMtsgyuPZgcr6N
         /dW78f71s/1bf9ZO+eEqyiLT+9cx+0W+uMy4m5FyzjnwUrT6OnfPyS9mscJzp5nNv2JC
         ARkEtXIEeOSWNL3kLpmLoTULpVELNluih7qd6turjp0UEbtDPYTJu3FMm1wyI1zJkeIT
         OvAItdgXmNSCXrQuAcg8Y/xg9affIgB33aLOHHlzGgHZF+opOtuXP1pui/lPMrF8AYhd
         hS5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752137666; x=1752742466;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=euNz/l/CHGPv/Gat71a8nUVi70h05zHrvuBm3oNz29E=;
        b=iHe2qqX6jqTu/EAoUG6flOMv3qLG4n/mJs7QTvbguBQ30b+cOga1VYO01d10oQak7O
         qxsKCdUQwGdW3fJfQS3qgNjRHLMHZgAwnVRVNisW7ngAulPUgsyOXqNpwFbwhvLJ+YeZ
         IZXy1TyUqj/D8Uzl5G7t4YJPqA/kMifBqqdX1ypnPdKWlekTL462gPOq/DS0BOKWJEIN
         RGEPOoRExQIw8+3NFm5oco/r5jkSDcW3wlOX7O9I3tgEEEwCN89xl9Kvkf6OCXfHQ8wp
         YapHHPjXXWPqqko6BQd4r/xmPUumCQ0rsoh5XTXdYiWrk3EgXRxgHoN0sWaqQqaPzSB1
         SdwQ==
X-Forwarded-Encrypted: i=1; AJvYcCUzIiJFNLNEx3m4zO9Vln8mH/BsXhmaCY9uS7Q/sN4vHWc0K39OPONAiZJWEKoDLgManamUhagIjo7E94Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxI4A6SpX1gTrlehfiUTpODp/B2G+XYuJQh8kwBG9K7IBu81zn
	qlPZ3HZBrumpQ5/1DkvED+/Y57uLYRhLMBzlWA9K6Fq8mbn3dGbMLflaxqeaPnsPNehygjGemAj
	mf2Xx
X-Gm-Gg: ASbGncsyHSRyI+V6sn6ivcb6WmGDjanig70+RADi+MBuywr8ZZelru3fWO1LTfil8jp
	ftvv5qpIy48C9mBnWH52QghQ6WR+aHNJBpgIQpjyMvjs3dH7zT1SXYD80bfmh9U9bV/0oe+loMY
	kLo7aaIwRh/EoznCKbFcXl+uTYFLUDdYlZB9i02+h38ZHaxrN9aqmPNJzKG3FJh1SVbD39nCazg
	6VQFHwOh7Ji23+IKmnO8HYLkc5Lb6LYqjV6wlulSb0AbEMIkCYcyg5rr+5UzoRy2na+dvQvIE3T
	5994XEuRc8jLI5Ml7F+Q/6wwSXzygKEqjXodyHic1VfnyhA2yKUcaGqh9sf1IpNjcTiwkcNYuKz
	+54FpuvFJiQAe7Q==
X-Google-Smtp-Source: AGHT+IEt7OZwGubuhbBz8Z/1KB4UN6EU83aIIreg1b4VW2wSiqDfLzbhNwjVrNvPGleM5LD1QDFIHw==
X-Received: by 2002:a17:903:a8f:b0:235:1962:1bf4 with SMTP id d9443c01a7336-23de4803965mr31979305ad.14.1752137665596;
        Thu, 10 Jul 2025 01:54:25 -0700 (PDT)
Received: from localhost.localdomain ([203.208.189.12])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c3e975d41sm1650228a91.13.2025.07.10.01.54.21
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 10 Jul 2025 01:54:25 -0700 (PDT)
From: lizhe.67@bytedance.com
To: alex.williamson@redhat.com,
	akpm@linux-foundation.org,
	david@redhat.com,
	jgg@ziepe.ca,
	peterx@redhat.com
Cc: kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	lizhe.67@bytedance.com
Subject: [PATCH v4 4/5] vfio/type1: introduce a new member has_rsvd for struct vfio_dma
Date: Thu, 10 Jul 2025 16:53:54 +0800
Message-ID: <20250710085355.54208-5-lizhe.67@bytedance.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250710085355.54208-1-lizhe.67@bytedance.com>
References: <20250710085355.54208-1-lizhe.67@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Li Zhe <lizhe.67@bytedance.com>

Introduce a new member has_rsvd for struct vfio_dma. This member is
used to indicate whether there are any reserved or invalid pfns in
the region represented by this vfio_dma. If it is true, it indicates
that there is at least one pfn in this region that is either reserved
or invalid.

Signed-off-by: Li Zhe <lizhe.67@bytedance.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
---
 drivers/vfio/vfio_iommu_type1.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index cade7ac25eea..61455d725412 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -92,6 +92,7 @@ struct vfio_dma {
 	bool			iommu_mapped;
 	bool			lock_cap;	/* capable(CAP_IPC_LOCK) */
 	bool			vaddr_invalid;
+	bool			has_rsvd;	/* has 1 or more rsvd pfns */
 	struct task_struct	*task;
 	struct rb_root		pfn_list;	/* Ex-user pinned pfn list */
 	unsigned long		*bitmap;
@@ -774,6 +775,7 @@ static long vfio_pin_pages_remote(struct vfio_dma *dma, unsigned long vaddr,
 	}
 
 out:
+	dma->has_rsvd |= rsvd;
 	ret = vfio_lock_acct(dma, lock_acct, false);
 
 unpin_out:
-- 
2.20.1


