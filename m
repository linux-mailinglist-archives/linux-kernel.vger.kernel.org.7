Return-Path: <linux-kernel+bounces-739729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 68816B0CA31
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 20:01:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9FD177A2EE2
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 17:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55D782E0B45;
	Mon, 21 Jul 2025 18:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GBKxpzo4"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E31E2D3748
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 18:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753120871; cv=none; b=A5pkTQookQtzzNczkr2wPQ+6a1zc0E+DuWKwbI3vYUhWBxO6Xg6brljU36pUj3D56U9Dx8atQekGRReUZZ9ahnmQEMPI+LneyhMAuFSq+QuigIN4y2AqKXU2MUjSX6CIi3KAcu7LG6YaCXgT6acDyt0ig+mPe69mYEI0dtQKTII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753120871; c=relaxed/simple;
	bh=pFi0iNg20dO512kniaVlxq0eQv3JXBjCcE9+ainODKU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=LEWPqN3IYJ5DVFF4nk97x9ajR/qeNX9PtmwXXyefWjKFkw6/8helw0Er6r0yhkpY8Yd+qa2UuVh12SfRPr29x2rtfFIVhVfSRbgdhoW0AFjGp2OVPA21aUT+2hLgQITATrRNQcnmlrF+JAK5QpI5P3TnYSCLjBCQzFhgqx4LGXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--brho.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GBKxpzo4; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--brho.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-3132c1942a1so6216226a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 11:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753120870; x=1753725670; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nkwILaoRvCGTt3850C+OpAJVMyb+bC6KByMj+ffuFyY=;
        b=GBKxpzo4jIZzmsmtFRmy4Ai2ztTkE98/cfShd+T5qQuDogeuTHR/0v/T8cuuvx7tXN
         pzXluF6ypAH2eIGEzMVPA8zw5LArsc6TwjRtMkb6FYgVHQ6YCGkexRtezOC2JgY4jzds
         GNrGI5OABDpr3XletwY2aHwiP7LISWu8uVkQBmyVmMmzfz+Us+GOSwVn7zkSTRnPmV6B
         sgWNpB+4r00Q0RXlSWBh2r9n80707UoYI9TDHlKf9p0Tzyf4EQwP/WQPrm1rj4+7WkVy
         J82EvENiGsMkKSXhRegPHV55Ceg0iMxSFrm0SPAZLN66X7ssLH2P7uaMiYb9PXbU6Bhm
         QfDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753120870; x=1753725670;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nkwILaoRvCGTt3850C+OpAJVMyb+bC6KByMj+ffuFyY=;
        b=fdC8xsr9X7X0WafjSPX+4vWUOn7m64zFCHQK3sk18Xm7u0yCVkyil5IuB6/Rg6DOuS
         ++9ikhQRXf3tEdq+CxOxX0vjibBC7+NuQCmRT2NzSDWz3fN9rRNtvv8kzE/k7fwbJIKc
         RZVbKX7G2MEnvKxlQFSu+RztL+Vf3F8lv+5c6qp/MTC4DrRyq2OFlA9D/dU9BbcJLNTA
         xMI9fq4nVoPHi1BeiJS4l8xdbeSEKmLLEwjWDPpBQG2o8JD7m5pfg75ozZGp+Tv6t2I6
         DtWYy8EY38LJOfktae7wuzhGj4E50JLPU7CHAKxoJfE/Xb2z3BwAWc57GUrOljgIFn5w
         L55g==
X-Forwarded-Encrypted: i=1; AJvYcCUfuHYO8DJWOUgcNKIdQNBFAlGxlc1RIIQCg7gFuEINULrocp2iuA6UbFqn5xiDsyXwQ2suIW4AUcayh8c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqUkxoq6b627332RT5XiUrGE1prb/rDShXGee8I0TvOGsXaqte
	i2qg1DpHuSPAxGu/endYLPp9o2yJ87mrHhIh0AoGLzieg2ygxO4kaEt34/uDyEQ90UAiRLEPKw=
	=
X-Google-Smtp-Source: AGHT+IEMVgugN4IL+CFFSpkR2FwGQ9XHs+U2c8+mJb7PyriwEGtvZrHfeHjlWf5Bk3t3+bv1LkyTurDn
X-Received: from qkab26.prod.google.com ([2002:a05:620a:89a:b0:7e0:f93f:98db])
 (user=brho job=prod-delivery.src-stubby-dispatcher) by 2002:a05:620a:4892:b0:7e3:54d8:3fdd
 with SMTP id af79cd13be357-7e354d84002mr1925664085a.16.1753120857996; Mon, 21
 Jul 2025 11:00:57 -0700 (PDT)
Date: Mon, 21 Jul 2025 18:00:47 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250721180051.3645697-1-brho@google.com>
Subject: [PATCH] x86/resctrl: avoid divide by 0 num_rmid
From: Barret Rhoden <brho@google.com>
To: Tony Luck <tony.luck@intel.com>, Reinette Chatre <reinette.chatre@intel.com>
Cc: Dave Martin <Dave.Martin@arm.com>, James Morse <james.morse@arm.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

x86_cache_max_rmid's default is -1.  If the hardware or VM doesn't set
the right cpuid bits, num_rmid can be 0.

Signed-off-by: Barret Rhoden <brho@google.com>

---
I ran into this on a VM on granite rapids.  I guess the VMM told the
kernel it was a GNR, but didn't set all the cache/rsctl bits.

 arch/x86/kernel/cpu/resctrl/monitor.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index c261558276cd..226dee05f96e 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -359,6 +359,12 @@ int __init rdt_get_mon_l3_config(struct rdt_resource *r)
 	else if (mbm_offset > MBM_CNTR_WIDTH_OFFSET_MAX)
 		pr_warn("Ignoring impossible MBM counter offset\n");
 
+	if (r->num_rmid < 1) {
+		pr_warn("Invalid num_rmid %d, cach_max_rmid was %d\n",
+			r->num_rmid, boot_cpu_data.x86_cache_max_rmid);
+		r->num_rmid = 1;
+	}
+
 	/*
 	 * A reasonable upper limit on the max threshold is the number
 	 * of lines tagged per RMID if all RMIDs have the same number of
-- 
2.50.0.727.gbf7dc18ff4-goog


