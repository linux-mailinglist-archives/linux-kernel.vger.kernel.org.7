Return-Path: <linux-kernel+bounces-835552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BAFABA76BA
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 21:10:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E888017986C
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 19:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E93825CC5E;
	Sun, 28 Sep 2025 19:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HprrTUwg"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10662749ED
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 19:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759086484; cv=none; b=hXoer4q/glTq0bnHOPL44npZvLETnREkyFVQH1zNyBNHquqSUT/Vy95fCyJFTmwhUXJRWUvmLphLx0kigp7TIf50qElvGKmzbL76vPZ8QPtnxX3bVoZUt2vxbmISC5o21xmeHglHNyarMNSx81twPp6BQXHmgs3/KSp4G+QDA/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759086484; c=relaxed/simple;
	bh=iu8bF1+1izo/N9nO598vTqm7TLEKTMTdaWt9KfjORTs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DQwdZ2rsQDBq/YpnT/CKH8tWg/rzwOk00J6itxif2uMkOPkhwdDQm04LLRUB+pe6B1bsPjCYrsqqdJpc5KlX4EgGhietC4/CJCQLKT7vgHGmTeIPDWoCbEzJZnc1VyCpDbQNTUnNyEOzag07TP2QEO1w1jhhW/dRASJiXA7tSY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HprrTUwg; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-7810912fc31so3027687b3a.3
        for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 12:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759086482; x=1759691282; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=r6rIkXRuvh9+tWEFzDbEPwiqaPEAKampFFEauxRboPc=;
        b=HprrTUwgn0RuYRn7h2IPOAqgFlbeMq4vzxXmBONe1ESEeNmdtfqtdZAc7kgFz/7rcW
         XWstQrxoyMQ9jgt+SwQ5kDcFl0t8cvQu5n03N4zuZmEeFkNQ5u9NEVLMFFWMcyCf5/JG
         BaU0T8b35xKOx64vcboD6oHKa77eKabkTA3sp4wdoqC7iEzCiAQeKW12fV6EtXVDYtzz
         zVupgYRXAiHFr0opipvsGZOXE2/Hz+VHThkwR+u9+PTft2JbDORB0cQ6J6s2KkN63oQQ
         F8XsNeT7g0g8n2vm3aGmYkQae+GyfQ+MzSaPFXYFlUTNsCfZk9FTGioJ64XYoWudxhRP
         otiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759086482; x=1759691282;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r6rIkXRuvh9+tWEFzDbEPwiqaPEAKampFFEauxRboPc=;
        b=HWf0ezCaltjqbc3KDwl4Qu/mH8Ly5Df/7VgbSmYNYg1WIwv/6gnJSskT1IvIB3Q0+d
         mBdveLzbS2kcOW9toaYMdehavZcgpyuN90f5MeHSsm4s+/KkB7PzvwM7NesgteVzvQSR
         IGBPFzYMCkfpuntcj3K58YFpggL5KNgSU0vO2535+Ivyea+Y4KXWJudyGUoWwSmn+fT+
         4rYCCq3xxM3t7iEYIWyyxEs/G1KmGBpSBu4kR0PLWeDoud6mN4GUlg6pkbUBfYnLv8lN
         Yx4Ylg/SQVkK4fBzkKeTEFcOiHJfzm0Sia91EXab8zQaVAturHRAyUMGlbDKWYAT1auZ
         PR7g==
X-Forwarded-Encrypted: i=1; AJvYcCUd3rKUb5+qnS60uGS4foujKpCtbg1EBbClY5l+4UW0ysSqQ1CkZ0c2EFRFsHDFMcQ8gY8xzz/mVHepwvc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxS5nhjRY94e9pGKsMIU8J6/mc/pMoFKGXrYPCTsaeuPC2QIIKr
	FJyhzyAJ2vGWd9EkZEcorCihM1HyuKmM0KxiUT7/deKFxvl+pbuiDDJHv2spub/HwG1ITX1hwdS
	Q/J/AgjMB9BRpkQ==
X-Google-Smtp-Source: AGHT+IG3DYQZH5AWOVC5jjKnDvm3R5bOqt3Kna9JyjjCIT0P03vRmnYOpx62s2gMEvWQZHaWnGO1XY6oqMnV7Q==
X-Received: from pfbhm9.prod.google.com ([2002:a05:6a00:6709:b0:77f:456b:23da])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:178f:b0:781:1e0d:a181 with SMTP id d2e1a72fcca58-7811e0da5bfmr8289263b3a.14.1759086482049;
 Sun, 28 Sep 2025 12:08:02 -0700 (PDT)
Date: Sun, 28 Sep 2025 19:06:22 +0000
In-Reply-To: <20250928190624.3735830-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250928190624.3735830-1-skhawaja@google.com>
X-Mailer: git-send-email 2.51.0.536.g15c5d4f767-goog
Message-ID: <20250928190624.3735830-15-skhawaja@google.com>
Subject: [RFC PATCH 14/15] iommu/vt-d: sanitize restored root table and iommu contexts
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

The persisted root table will contain context entries from the previous
kernel. Sanitize the root table entries by setting them all to zero.

This is temporary, the context entries for the persisted devices need to
be kept intact.

Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
---
 drivers/iommu/intel/liveupdate.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/iommu/intel/liveupdate.c b/drivers/iommu/intel/liveupdate.c
index 755325a5225c..3783632cf634 100644
--- a/drivers/iommu/intel/liveupdate.c
+++ b/drivers/iommu/intel/liveupdate.c
@@ -306,6 +306,26 @@ static struct iommu_ser *get_liveupdate_state(void)
 	return ser;
 }
 
+static void sanitize_iommu_context(struct intel_iommu *iommu)
+{
+	struct context_entry *context;
+	int i;
+
+	/* TODO: Keep the context entries for the preserved devices. */
+	for (i = 0; i < ROOT_ENTRY_NR; i++) {
+		context = iommu_context_addr(iommu, i, 0, 0);
+		if (context)
+			memset(context, 0, PAGE_SIZE);
+
+		if (!sm_supported(iommu))
+			continue;
+
+		context = iommu_context_addr(iommu, i, 0x80, 0);
+		if (context)
+			memset(context, 0, PAGE_SIZE);
+	}
+}
+
 static int restore_iommu_context(struct intel_iommu *iommu)
 {
 	struct context_entry *context;
@@ -324,6 +344,8 @@ static int restore_iommu_context(struct intel_iommu *iommu)
 			BUG_ON(!kho_restore_folio(virt_to_phys(context)));
 	}
 
+	sanitize_iommu_context(iommu);
+
 	return ret;
 }
 
-- 
2.51.0.536.g15c5d4f767-goog


