Return-Path: <linux-kernel+bounces-776084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DF9CB2C856
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 17:21:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF60C722EBD
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 15:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A6522BD01B;
	Tue, 19 Aug 2025 15:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smartx-com.20230601.gappssmtp.com header.i=@smartx-com.20230601.gappssmtp.com header.b="OHOjyYnP"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01158284883
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 15:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755616849; cv=none; b=uyIMzT1mpnEeqqomOOxAStrtsiKYeJeWGqDBhcdL5aZvLoz/UHX0aHLlCVN9ihOxS4mdE/uRkzJcLZboXr8XgE/5p4p54RfajedahjTIaaLaWsOPrVEyVkQHiHVyOcdJ1dOfezY+vTtM/QlIBkRzKE6hOwd8GyIJneoHyWlhuxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755616849; c=relaxed/simple;
	bh=HomK9oR9q6PgZ6KTjkrL0ZAF4ixtQM3rr4sUa8Fd5OA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nn2RB8aisErmO5Tf7rvfKk3VYMlF0uGltJioWWUbeednmFsf3USSd643Suq5/0w/0xuHG8bru2CEHbuz4YXXkzJkHD3iABPdjCJGjxMLyvWbzbLaUIrh2b0Vkj4bYYHJzAPCu/pTOnWE8nRHkZL+9vRHZy2i42GB+iETw+3mKig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=smartx.com; spf=pass smtp.mailfrom=smartx.com; dkim=pass (2048-bit key) header.d=smartx-com.20230601.gappssmtp.com header.i=@smartx-com.20230601.gappssmtp.com header.b=OHOjyYnP; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=smartx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smartx.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-32326793a85so4223607a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 08:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1755616847; x=1756221647; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A/CvHxpYU6aT1JADHVD5nQ98mr1UgBNDG9QHGX5cLNQ=;
        b=OHOjyYnP7YYoC+synqXCNnGbymEKbqsj2St7ImKmsPYoJLWXpioWCZPU0nsBhQB9Wr
         Q5uRk2Wgq/Oht8CWltecQ6B7dbd0LWa3LKdqvYOlNfW7jRbsxnflhKFeN/wQqVV9cfBf
         Y0RBPo1siNrOtV8dFlG29tbWiDbn2xorHBy53mrRYyufvlfWJV2UZvcxOeMWWGXSBdGc
         1ao0bYK1I2ZvB+Juh2SWujynTmwWxqakfKEvxGQRuV+jnwsQIK5+zWZBXtcxiZHJRFBq
         QLAY6o1oVbzEZofvTnlVBIw0TP4IAL2FpG7uAbR8ZUxT1tdwR2Zldl39hqpLGoLiz+qQ
         j45g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755616847; x=1756221647;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A/CvHxpYU6aT1JADHVD5nQ98mr1UgBNDG9QHGX5cLNQ=;
        b=fkbD8a62W7mIaUqgOONy20Kelgu17UfSuZ9qyw3IXDaMp4XZm2KAQt1iZMwH6PqRo+
         plD7wW+YFqOguLZyjpLOPgyEN1WVf42ARsR9wjY0/sXfKdAQON0YBBscTUW7VHdtgJo4
         bvJ+aejJ/j2LjLATVVySfzehKTa2lr6MMXG5xavHyd3JU1BVBzoWGUJydmMSMlU+PtZo
         uvk5oVT4ADu5RlhLCKIr2b0tNGUmgfrIlZNMnAi9RaMSHTMyxsdLBJHZCUhQabOeqIWQ
         e2Qdqlc8xsFWDsrX3cmnqgeInA9hC1rBLpcpynRtZsyAKOifMBGzeeO2W9AzkopbXQzF
         uSkQ==
X-Forwarded-Encrypted: i=1; AJvYcCWPs1Nc8oUA499hvKQ/+V7qEIUCqKhYXKAjsGk7sP2aLen6vGxeBwP7Z6sYRch6XhgpjnLCXI8MFxtVW8A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1PvOjiGIVfBukUoTMTieks+8P5KEM850NKZBqPybtEAaUgf4r
	9wsOy2safn0TGBFOenESgBVZDtiZE0W3qKve9JpSC3rWnF86hgH65ABLoRJQQ3yv014=
X-Gm-Gg: ASbGncsQIw7ITCV1hxBCimMO3zSS1azck68kpPp/69Dmo2AG1ZRbZkfFaHm4/KSgEZ2
	BvZxVlCl6OXlS2oWOxzHO8rhEV8VRlXMgZbvj8rfcPeQCmOgCj6OQSDQwiZKW9MEdXarGa5fLYS
	kvV65arsoKYCRhfbhUuAtnzhPOTAMJRKtTod/cz20F2sEYJbwdJhCu1Vx1f55eUVAwB4RNGmVYt
	Okv73QNo96Gl2harJ8kfzgoD0qmD0HMISjBpk02kSmjh+WTf5GG/H4mKVY5MAh6QwcHA/JvCMaV
	kXfX4whb9DdxWjVc1BoOFMy7iG5OIadL2I8Tnk2F5qadmw+QuStvaEK0n4aXEkpEb8Ud0NTaNKG
	UEQQLHjF3vrrGJzxOI8qYuEgYtEO2lpjtFfO7u/5xhn47eCwW
X-Google-Smtp-Source: AGHT+IENiUhPFrfHidhITb1KfiGNdBaldsZlAkjMOx4cUC6/Qm5aq9ey8Ddfx+brVMdYtBBvx3KQXg==
X-Received: by 2002:a17:90b:2fc7:b0:31c:3651:2d18 with SMTP id 98e67ed59e1d1-32476a9509dmr4224591a91.16.1755616846994;
        Tue, 19 Aug 2025 08:20:46 -0700 (PDT)
Received: from localhost.localdomain ([193.246.161.124])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e7d546ce3sm2771227b3a.103.2025.08.19.08.20.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 08:20:46 -0700 (PDT)
From: Lei Chen <lei.chen@smartx.com>
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>
Cc: kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 3/3] KVM: x86: remove comment about ntp correction sync for
Date: Tue, 19 Aug 2025 23:20:27 +0800
Message-ID: <20250819152027.1687487-4-lei.chen@smartx.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20250819152027.1687487-1-lei.chen@smartx.com>
References: <20250819152027.1687487-1-lei.chen@smartx.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since vcpu local clock is no longer affected by ntp,
remove comment about ntp correction sync for function
kvm_gen_kvmclock_update.

Signed-off-by: Lei Chen <lei.chen@smartx.com>
---
 arch/x86/kvm/x86.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index d526e9e285f1..f85611f59218 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -3399,9 +3399,7 @@ uint64_t kvm_get_wall_clock_epoch(struct kvm *kvm)
 /*
  * kvmclock updates which are isolated to a given vcpu, such as
  * vcpu->cpu migration, should not allow system_timestamp from
- * the rest of the vcpus to remain static. Otherwise ntp frequency
- * correction applies to one vcpu's system_timestamp but not
- * the others.
+ * the rest of the vcpus to remain static.
  *
  * So in those cases, request a kvmclock update for all vcpus.
  * The worst case for a remote vcpu to update its kvmclock
-- 
2.44.0


