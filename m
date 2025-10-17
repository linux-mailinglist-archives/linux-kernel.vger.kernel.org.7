Return-Path: <linux-kernel+bounces-857529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 46D0CBE7061
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 09:57:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E7E5E35B51F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 07:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C25A5261B9F;
	Fri, 17 Oct 2025 07:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vVDFZY74"
Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A972550A4
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 07:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760687845; cv=none; b=LstmiD1GdRUlJXLrfq+bW3l8vpLKw9UmW6z1nHxBoJJAG1s/Nu8ANMbpgeBSJkQDug6rdZPnM4M2FGi7Ljzefoy7AEf1WnMN6RA/Nh4cPZA51To4wUBifcE0oZmHTehFYedinnSDqoPavayxQUB9a6bY47/gII3tekutug6QBrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760687845; c=relaxed/simple;
	bh=v+cwEQu/l0K0aFYXom/va+vqcAeLTQs97OiCDReEkHw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=WjrxpTIEIIBhOnQ1E0FscIiYigBDH7e0FLpzQRShe5+G3WrLVMoGz7DovwJwRZjcI8Q6Xm470WVKmgZURyuCRb3iIsN7nxJ3nWXJTOsKy20geNMBaMbkJgYAutzR2xiiBryVzcIUx+GX++irWK4tGLUD7ey7j85lhEBq67Gi+XA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sebastianene.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vVDFZY74; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sebastianene.bounces.google.com
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-62fcb646334so2302195a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 00:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760687840; x=1761292640; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YeonnmR22YpdBnRA2e84Q5k99IvmMWnT+8o9upY5Y8U=;
        b=vVDFZY74BUn7SwR+HcQh6hCO1CcPD/ge0uBt1oCTtBtsXJOsEaQ73+aVEkOkuBJCX+
         dXBWWSMGJHNuVLRk8PBekaN7dgLC7asULPOlUPz0xR4jZMhyI8nx1Vbfpk++GzdeSnBt
         9lkyXcd9CgfE7RpACmj2CPKikse6SOBWudwQLoNCINaowcZQpceES1ik6BmSJ3i5uDIk
         KUq3Tn5L3BPmTBZCwCZENGnxC30CBd2voS2xbFXheUbOLfzRiC/XDQFQ0NegJIHdkbwo
         racm6skY8qS+x4TN5P7EYxqhyZVXAL6elqNJPDQGD1S6R49r1rWmly7ZNX63DBcnBJxa
         FwQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760687840; x=1761292640;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YeonnmR22YpdBnRA2e84Q5k99IvmMWnT+8o9upY5Y8U=;
        b=eq/GaC3uIsm4wAVnMmuPeDHRltSKqTeu90eNvp5CIjX9cgNdTjRXVhZLH6Dsn2c71s
         yvBW6Hs8QZQk9HxLTnJ+RSS8LVBPl5CajLs3ASWixeCNnwpAZpSIM+IgZNoBXqJAw2pE
         aSYBvygUU74k6qQrBBY2yVknHowbv9qK27y1C5rMS4UwcMddvl/H7qwIhiKVhgUwLWH+
         zLUREKyVOK/1NB3nPa97JNlPm+0baPdGmTleL200RSehxpLPGPvmJ3C92yJaY4LGPg8H
         BCRJhHHrcPGs9HJbxm8GT/CRwkjfFQqWTWfQGurDin3wsoVOVthY2u5TgYVpxsmdZ2JA
         0JJg==
X-Forwarded-Encrypted: i=1; AJvYcCUAD50JNnskGkPAxAHxOpar6TAhxrXqKFMSG42+RBK4vg1IixCDupS2yp8ocgl3fFEzxJZjcFrWD7ep2aA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxa20JAqxNwuFU+yHKsjcgZ2L1cHZIzsBnfX34sjm3kEhqdVUbE
	4WWhy6mI9IaGRYmz9zt7SuySRSKD1bjSv+ydYU5gR22Zg0KLWJAgq8/4PtXb4oRb/A3/u971kYc
	57Kbf7yg+o09syUxz5BqvLvKdA5vJLA==
X-Google-Smtp-Source: AGHT+IFurVwu13hTVgjqFkuyg+jJU8SJ/2HWVhpsWHXh/EE63aqE9d17vw6ppnqZ4TszNyVb3fhURmcJUleEuWeLYDE=
X-Received: from edya15.prod.google.com ([2002:aa7:cf0f:0:b0:639:f07d:725a])
 (user=sebastianene job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:20c2:20b0:63b:f93a:57b with SMTP id 4fb4d7f45d1cf-63c1f6b50c1mr2138541a12.20.1760687839997;
 Fri, 17 Oct 2025 00:57:19 -0700 (PDT)
Date: Fri, 17 Oct 2025 07:57:10 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.858.gf9c4a03a3a-goog
Message-ID: <20251017075710.2605118-1-sebastianene@google.com>
Subject: [PATCH] KVM: arm64: Check the untrusted offset in FF-A memory share
From: Sebastian Ene <sebastianene@google.com>
To: maz@kernel.org, oliver.upton@linux.dev, will@kernel.org, 
	catalin.marinas@arm.com, suzuki.poulose@arm.com, kvmarm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	joey.gouly@arm.com
Cc: ayrton@google.com, yuzenghui@huawei.com, qperret@google.com, 
	vdonnefort@google.com, kernel-team@android.com, 
	Sebastian Ene <sebastianene@google.com>
Content-Type: text/plain; charset="UTF-8"

Verify the offset to prevent OOB access in the hypervisor
FF-A buffer in case an untrusted large enough value
[U32_MAX - sizeof(struct ffa_composite_mem_region) + 1, U32_MAX]
is set from the host kernel.

Signed-off-by: Sebastian Ene <sebastianene@google.com>
---
 arch/arm64/kvm/hyp/nvhe/ffa.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kvm/hyp/nvhe/ffa.c b/arch/arm64/kvm/hyp/nvhe/ffa.c
index 4e16f9b96f63..58b7d0c477d7 100644
--- a/arch/arm64/kvm/hyp/nvhe/ffa.c
+++ b/arch/arm64/kvm/hyp/nvhe/ffa.c
@@ -479,7 +479,7 @@ static void __do_ffa_mem_xfer(const u64 func_id,
 	struct ffa_mem_region_attributes *ep_mem_access;
 	struct ffa_composite_mem_region *reg;
 	struct ffa_mem_region *buf;
-	u32 offset, nr_ranges;
+	u32 offset, nr_ranges, checked_offset;
 	int ret = 0;
 
 	if (addr_mbz || npages_mbz || fraglen > len ||
@@ -516,7 +516,12 @@ static void __do_ffa_mem_xfer(const u64 func_id,
 		goto out_unlock;
 	}
 
-	if (fraglen < offset + sizeof(struct ffa_composite_mem_region)) {
+	if (check_add_overflow(offset, sizeof(struct ffa_composite_mem_region), &checked_offset)) {
+		ret = FFA_RET_INVALID_PARAMETERS;
+		goto out_unlock;
+	}
+
+	if (fraglen < checked_offset) {
 		ret = FFA_RET_INVALID_PARAMETERS;
 		goto out_unlock;
 	}
-- 
2.51.0.858.gf9c4a03a3a-goog


