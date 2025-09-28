Return-Path: <linux-kernel+bounces-835547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B9CD2BA76B4
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 21:10:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 337B27A70F9
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 19:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCBD626F462;
	Sun, 28 Sep 2025 19:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Xx9LuwPF"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A94026C39B
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 19:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759086477; cv=none; b=bd26PYgh4up4mFBdXT42ea8TTiAun+ugawCxZRyFkVmqQA3vo6IhD+isxrVyKvHJdIOxGyDe/5/eagp7h+q/tptPSAHXsySH0ZnNPYIHEZGskllhASf+xt/1H05CIc4N/fi0FJ5vt+YQmbZTD4Uaf3Us9Hvmz/eFVcupjo20vgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759086477; c=relaxed/simple;
	bh=jkmwgnL7BhvDTNRmHeg8Vg8AsLanY9NZX4iIKwYAEYk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qxxTmiHONPOj78/zPuHBCKIccipkOE3a0DMkFN87oQMEOKSUuHAKnG7nY3NExzLi9jn5YQwm6ersWKVGIJ1N6avpt722Ysq6Z4Iy032Jlo760sn7RpdtMFPQ7RvM59Jggca+xdic9bsXDGcQHhulq3cKsixi6+fPiazDJHIrC2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Xx9LuwPF; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-77f2466eeb5so3163480b3a.2
        for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 12:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759086475; x=1759691275; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ucXCpHZHap8YpvFOrTnapJK/l5FI9kkW9aB4eroyCmw=;
        b=Xx9LuwPFaKX0yyMZ+zf91gKq7rJuYCKk5S8f5LV7Q9JP3M2rH5mqYs6s6KpkoUpCnf
         0TZJg85adPtuYPGaOt4t8RNx2dqkEyQcJ+vY/yF6PhvOioD6JA4HIPM38RZjN8reFkIf
         voq+j4fq5jEYk5UlEehUDBl26ThH05NL34cMUCrPtjBagWvyv41HUjHg1r7TIdZJ4xB7
         EomL/kRlyQdb5/kFk/dBguhOH/bi7NJONFaryKUWSL60i4NvKYkzxTW54GXJzLzIrj1S
         Hc4DjUt7WL+TLc40x9x/fbpo+nOdFMJHPkPv6BQeQsY3D9xoNa5IO08quFXmzvMoElIa
         BbSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759086475; x=1759691275;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ucXCpHZHap8YpvFOrTnapJK/l5FI9kkW9aB4eroyCmw=;
        b=HS6uEgGjw2wKjjCDxZThNnSNfEV9REAnISng6ehjQ8zqBqVFLZP0PemZJeFZNlaQDW
         Cg4JVz4L2I87ypy81ZdQq38XpcNxWIaDJpFpwMQr7tqVb2wW8L3J7oxx7VAlO/tCIsPr
         os3KZF/+Mm1TWEVJwO3nllrgCLA7ZUe1HBeXCDe01KfGswMXtZTp1TNivVmlHHJxrsqK
         cpa54wFhoSmj313iKFegfnNMdmKeMYsTVGAmjZnJZL+hM0eLcyB7nCkF93F9Y4TzuELe
         lwbsvw+sJSH+T9aF/9AWLbufQkmkgMT/CYcUWcpAviL/QrHisAL8UOAgL7dNaX2Ib+4N
         JqUQ==
X-Forwarded-Encrypted: i=1; AJvYcCWeeTq67xpy8oX9iXpovtXKLTS5ESW8CgtTgg1dSJzzm09DT/670hpLpNCuI2BJP2eBlHDT0z/3TxP6eQM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQmdMaNKHPMGz9PqCY1a+IMqv8M/NanWXFiroNNXS3NUptYT1k
	yXs9z3FGpxhPjghmQrvWEGsN9pjRziaNLCsZ9W54aMTO9DVQygkZIsgWu8kh3PH/Lta1eUBnadQ
	SxUkvpbBhZsRGnA==
X-Google-Smtp-Source: AGHT+IHCtCjCjURftUd42BI8Xn94s+m6l5b6UgXQA8KkQXHy6gXqsx21JjwsoB3Xl8hB9g8pCQfv/F4XvBfXyg==
X-Received: from pfbhk3.prod.google.com ([2002:a05:6a00:8783:b0:781:65e:cee5])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:240d:b0:76e:885a:c32c with SMTP id d2e1a72fcca58-780fceda55bmr14907781b3a.26.1759086474819;
 Sun, 28 Sep 2025 12:07:54 -0700 (PDT)
Date: Sun, 28 Sep 2025 19:06:17 +0000
In-Reply-To: <20250928190624.3735830-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250928190624.3735830-1-skhawaja@google.com>
X-Mailer: git-send-email 2.51.0.536.g15c5d4f767-goog
Message-ID: <20250928190624.3735830-10-skhawaja@google.com>
Subject: [RFC PATCH 09/15] iommu/vt-d: Add live update freeze callback
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

The iommu_ser needs to be updated during freeze to set the physical
address of the iommu_units and devices array as the virtual addresses
will not be valid after kexec in the next kernel.

Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
---
 drivers/iommu/intel/liveupdate.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/iommu/intel/liveupdate.c b/drivers/iommu/intel/liveupdate.c
index fb214736aa3c..a7d9b07aaada 100644
--- a/drivers/iommu/intel/liveupdate.c
+++ b/drivers/iommu/intel/liveupdate.c
@@ -258,10 +258,21 @@ static void intel_liveupdate_finish(struct liveupdate_subsystem *handle, u64 dat
 	pr_warn("Not implemented\n");
 }
 
+static int intel_liveupdate_freeze(struct liveupdate_subsystem *handle, u64 *data)
+{
+	struct iommu_ser *ser = __va(*data);
+
+	ser->iommu_units_phys = __pa(ser->iommu_units);
+	ser->devices_phys = __pa(ser->devices);
+
+	return 0;
+}
+
 static struct liveupdate_subsystem_ops intel_liveupdate_subsystem_ops = {
 	.prepare = intel_liveupdate_prepare,
 	.finish = intel_liveupdate_finish,
 	.cancel = intel_liveupdate_cancel,
+	.freeze = intel_liveupdate_freeze,
 };
 
 static struct liveupdate_subsystem intel_liveupdate_subsystem = {
-- 
2.51.0.536.g15c5d4f767-goog


