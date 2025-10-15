Return-Path: <linux-kernel+bounces-854649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D87E6BDF038
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 16:27:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3803400417
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 14:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DF4F26FA50;
	Wed, 15 Oct 2025 14:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B/PmxhGW"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E5423D7D8
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 14:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760537905; cv=none; b=UR/jPJ9iwN3GOzVJX/KoduJpRQTfz3g7mCzkPcmCkWQCQ1dw6aa1zA5YFPX+53a56DTKvd5L+m0UCnaaVJMoyGQN6Gvly5gOBQ0wevbwAaus1AnenQGdBl1C4sSdhqUqokwOW9enA1VQagO6/BVoyxm+pKZUMDWDXHjQTf4uQYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760537905; c=relaxed/simple;
	bh=CXI0qMvWqpeePDr4xBG9e2uqemr9IpjeVUqDleKN93I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Sem86c/E0xWlZqn9X/1Zx9dCos3uaNEmbuWOEzjA/45N12+OPTrUy/nll9n6+zeDoGZMDmP6UBCRkdB+aMpz3VuawhvpRYdYgrTS77PVF+OdCPFu0mZygnwX/6AoFHWpSH2nyyqWp2UtbJQzhRtDhfMgrcAC4VoR/9YUNhUxYl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B/PmxhGW; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-28e7cd6dbc0so76700215ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 07:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760537903; x=1761142703; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oOprrquoKlbkEreJojZ4KykFg8G0TswcVk79ghRz+Tk=;
        b=B/PmxhGW4USjX2YXd4ZukIPoqXuA90fULSmrq5rxT67yJShl4XIqibhEUVtGPwhFzO
         LN+xQ7/xaXSQZpakOu7fsyY2WVywH57LwnVqGH1l3Xg1AlYjmTI+hpO0xxxkEPSCS5dP
         hbiuSkNdc88c/KTt7abdO5MNcO/ahcESDoEOfRzkbRmGYXquGsyVVaVTVZaASZ+D8FTw
         qfwa0Z2+SoYpr6q8x0f3d+cVTS4q91SzPXC0I8tbIiSWiocp/laTNC7gUrW94UxwMqib
         /Uai3NzxDARFGDsp9J4CzvLvNP5De+rlVmeEfUWyuGtB98kdh2YF9PeL0QrJH3O/YLXm
         nQmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760537903; x=1761142703;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oOprrquoKlbkEreJojZ4KykFg8G0TswcVk79ghRz+Tk=;
        b=C4eDgyZFWtG1IcqPAPM7GJz8iIyG1HKtjB8OkXV85GjkyKQHVzuQ9IPDyyMLhjXRYq
         F2r7aD0nG0WFLbNjRBxg2gbKfZ+N5hUAkSqMmPt3iTyBPKbFf2uc95ynrWBmSSmMIpff
         z/v56fHiVCSfh/CHPFq3pIA2nn5lpUVu+TXykLG8XZv48oBHMIgu1Va2I4/aOuidoOoS
         dGawI/kGtmW7jmaYaMgFnc7X8ET7TXI0hndkN2WD/cgfoGMJdABUzUaogWEVMS1bcxdT
         VAfWU0QVKOGancg9iMXNVEOHBw47e06YkhUxP2+VvcxhALcc3EJBGRqquU9N2+SPUjGb
         Fvbg==
X-Forwarded-Encrypted: i=1; AJvYcCUpHrIDOyJzkd3JI28ql4N2RgFL+FWXZYVTXt3nlFe7SK3Keu/YolZ6Klgo8xtPjQwh3pQ1SrCofpPuQXo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlrVdi4Uai0C20W7+81o0gqYDW0FOe2k7u9xFwnE2M6wTYn53q
	a8skUnud/4qlWHjjqOrma+L3tg4wOI61PTXg/Sr24thZjU0o0mw4Djoe
X-Gm-Gg: ASbGncvN2/FF79JSZF4+yhF2XfjvEFQltviE5yXfmD30BM//lSSsRXtgdnlvgma/zVR
	Jw4KtpQLJADuEAFyxJUvblM/YbYowinqFfe1R+qeuT0EQDpUBvokyZyAR8Nnr0As3cb7mYAgdtm
	bdQSAkHtqXlaO1f26IRGp7xP5tIiYIDXMKJCDzsoc1dDl9FDkPo2uaXXkywpqz3rEre4SYoXBru
	UxJMxlvTw+b0Ts+qV7tr0IzFHCrJ1XACsnpHTU/LfVOzRRRP7vimYX/KR3xDtkgjMrWsQb1yw0C
	ug/I4Aaeep/A/iDDF7yAb983csOWdQsSnY439Eur8nFwiczTMCga3C22a8i+av93DF9ZdtPWKba
	b0I9ortKZGBC9N/FU2LvHwqlShmFzHeieuVhbw9jeQQrCrmYhaxpfYXWUGUrzEF/HisPIbi+ET0
	V4x5PmOImIO590CTBd
X-Google-Smtp-Source: AGHT+IFbpJ/lHtUZtOELQrDFo7AxEZqNrS9hHE1/EnXHjZzMn0AR8tXrPtdpNdO0986Yh1aFevTgmQ==
X-Received: by 2002:a17:902:e78f:b0:24b:182b:7144 with SMTP id d9443c01a7336-290273565bdmr371321185ad.7.1760537903035;
        Wed, 15 Oct 2025 07:18:23 -0700 (PDT)
Received: from localhost.localdomain ([2409:891f:1b80:80c6:cd21:3ff9:2bca:36d1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034f32d6fsm199561445ad.96.2025.10.15.07.18.14
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 15 Oct 2025 07:18:21 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: akpm@linux-foundation.org,
	david@redhat.com,
	ziy@nvidia.com,
	baolin.wang@linux.alibaba.com,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	npache@redhat.com,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	hannes@cmpxchg.org,
	usamaarif642@gmail.com,
	gutierrez.asier@huawei-partners.com,
	willy@infradead.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	ameryhung@gmail.com,
	rientjes@google.com,
	corbet@lwn.net,
	21cnbao@gmail.com,
	shakeel.butt@linux.dev,
	tj@kernel.org,
	lance.yang@linux.dev,
	rdunlap@infradead.org
Cc: bpf@vger.kernel.org,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [RFC PATCH v10 mm-new 6/9] bpf: mark mm->owner as __safe_rcu_or_null
Date: Wed, 15 Oct 2025 22:17:13 +0800
Message-Id: <20251015141716.887-7-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20251015141716.887-1-laoar.shao@gmail.com>
References: <20251015141716.887-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When CONFIG_MEMCG is enabled, we can access mm->owner under RCU. The
owner can be NULL. With this change, BPF helpers can safely access
mm->owner to retrieve the associated task from the mm. We can then make
policy decision based on the task attribute.

The typical use case is as follows,

  bpf_rcu_read_lock(); // rcu lock must be held for rcu trusted field
  @owner = @mm->owner; // mm_struct::owner is rcu trusted or null
  if (!@owner)
      goto out;

  /* Do something based on the task attribute */

out:
  bpf_rcu_read_unlock();

Suggested-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Acked-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 kernel/bpf/verifier.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index c4f69a9e9af6..d400e18ee31e 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7123,6 +7123,9 @@ BTF_TYPE_SAFE_RCU(struct cgroup_subsys_state) {
 /* RCU trusted: these fields are trusted in RCU CS and can be NULL */
 BTF_TYPE_SAFE_RCU_OR_NULL(struct mm_struct) {
 	struct file __rcu *exe_file;
+#ifdef CONFIG_MEMCG
+	struct task_struct __rcu *owner;
+#endif
 };
 
 /* skb->sk, req->sk are not RCU protected, but we mark them as such
-- 
2.47.3


