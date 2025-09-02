Return-Path: <linux-kernel+bounces-796954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E12AB409EE
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 17:58:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3AB21BA05FD
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 15:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F400C334380;
	Tue,  2 Sep 2025 15:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hJANq9j6"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC3132ED40
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 15:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756828677; cv=none; b=LVn5O+nDp4ix+kLpIi+NOYusTZZiJRvJ3jRDbKN7rOB86TNlBO+s6XNv3hYuOfnvjSxu3PhFuW+fUhoz/abn2Y5CkA+tV+AQiAChTKFjGyz2OAAnmN6+OEe16zJYzPeLcHzi8ewvNAyOY1DCPfgv0AOJIPyH4mTjexl0AOVX9HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756828677; c=relaxed/simple;
	bh=n0fd6xEx/+Cfe0XsYnDfSmRrGzf66Rk9db0hUym7nQU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YP9zO9r5gnykOC9WT+AvkrhRlXNjKN0oe69qC+IiW8e9SgbLaODJdfVo45cV3QzqAb+2tWRsg6OYvukKMNtKxZxGAnIycVqKL9mgqGAIAcjoLKp3tSijFYG12aEQeSDoLCMAhF++/efyWtvDlzIzqa8sVxFdTtUeu1xQh8gC7ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hJANq9j6; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3dad6252eacso364123f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 08:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756828674; x=1757433474; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WazHtu/C+Ki5N7AOy13THFKawYgRh4R/pKoB6roqKlg=;
        b=hJANq9j62HrBa0/wTT/y0N3wWc+trvI0lhVAte19PfNWnDqUA1j0rLZF2vBCxT9HdN
         1Hge3q+IyOxPr6qqwlI5UrjHvWNm8meL12fXI+69t3RfO5rVHWMOSbX/g8v7AbEhPihQ
         utSrQY8a/ssTcH8pJgfEX8AyruAswjxcOSQcPRLWVVdtD4K3NMLt04qx3W4lOlcTBBLa
         3Jrq9Sh6H8YreQs5Rchkghq3f56T9ZUF0U19iYWOIBcdg95nMVgRI3RiC9qMlDFSwWPx
         Z3q0QOEtnVxbgbwo543qOGuj1akyCkaNPsXmF/uagEbzvZk/MBUDT6v35O7nAMVGsezF
         NUFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756828674; x=1757433474;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WazHtu/C+Ki5N7AOy13THFKawYgRh4R/pKoB6roqKlg=;
        b=Tsk7xVb0L70Mngyqv1BAQCCSL44NNE1cp76LA7AGXxDTZ8WDqnDnl/HxkrZD5rt6j7
         ltF1PyBSeaZMDukEqyZP3eeug6rX3DuLzD961nyELUTfnGa9z8SI2X/9LomlyGymjrY1
         sgdRJ0nqKdAU4r3O7pCbC76cqI6gcSPHrbC7oS5Pt7oK6OffuYJYdFCQ/vK4ODu7JLPF
         FR9ZlVFmgfKquj+pU5hg9rwI9ZsrNOG85uqplilfOKdsF9X/X2ri3uUcyutauNUnh2iK
         yUrFOmihGyY3NKekmLzOUlYg+jQf87uYOGmSthxkB7cUm3avb1nOys1EmktIzHpZ1jZg
         ItSA==
X-Forwarded-Encrypted: i=1; AJvYcCX5esiL/0SaZhCpRyFcrSl6keVJ9tR3hxcWpaJvI9BDVeJyNBKjBujyTe/eK4NuJxapke7h5+8jiqEwUhQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/SiCD8F6lsrz9Vg6RT53CI3jaSV8m122wW7zo/sFV8Vu1tvYb
	51IQnlHHQfQjmeZ+jvRSxadR/LePdF7jvBe1CiQ7wCdqRMQEwpxyH/Zy
X-Gm-Gg: ASbGncti40iPbNxZJffDEZucME/C5+rNH61Ihv3m5BQhanQEqrRqNGwpe03gK1pFqrH
	NdN4wry5XybRqowWtsXU1Nc2ZQfU2szpmsuj/iaM9xubgYjPFnIqfGG0oUVJ3fkhQ0EDIbcgMVL
	EmCOY2+kRZ9y8tb8liH5AWZNWnvsLsusYKZMaZkVdKHq25piq7vfqqKlDSildxwxObKibYrgFH9
	liRnEJWOK6yt984mRDy/f9kUJg6996mjT9Wz6Qy24jIYChr0sebBDLWArBX1Aalx/RVOtfEQhuJ
	tK7djavp6Ksd+MjwmraQ4n28Wz1nDM1i+sK5fZ2ZxtR7/DUtCqmpCHhBTCL1U3dEOxZ0/XAlO6f
	5K/BXwhcHdulcXA==
X-Google-Smtp-Source: AGHT+IHcOAzz8VVG5t22jgn5zsII5Ivg87fvqkT+HcIozssVkQ/DPJiq41qWcCUdZRNBTyTiCd9XHg==
X-Received: by 2002:a05:6000:2811:b0:3d2:25ba:e7f9 with SMTP id ffacd0b85a97d-3d225bae9femr6067898f8f.46.1756828673800;
        Tue, 02 Sep 2025 08:57:53 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:8::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cf3458a67esm20193336f8f.62.2025.09.02.08.57.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 08:57:53 -0700 (PDT)
From: Yueyang Pan <pyyjason@gmail.com>
To: Suren Baghdasaryan <surenb@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Zi Yan <ziy@nvidia.com>,
	Vishal Moola <vishal.moola@gmail.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Usama Arif <usamaarif642@gmail.com>
Cc: linux-mm@kvack.org,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] mm/show_mem: Dump the status of the mem alloc profiling  before printing
Date: Tue,  2 Sep 2025 08:57:50 -0700
Message-ID: <8dc71d31de53afa4c0bb25234807b1e6ead5ba55.1756827906.git.pyyjason@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1756827906.git.pyyjason@gmail.com>
References: <cover.1756827906.git.pyyjason@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch prints the status of the memory allocation profiling
before __show_mem actually prints the detailed allocation info.
This way will let us know the `0B` we saw in allocation info is
because the profiling is disabled or the allocation is actually
0B.

Signed-off-by: Yueyang Pan <pyyjason@gmail.com>
---
 mm/show_mem.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/show_mem.c b/mm/show_mem.c
index ecf20a93ea54..51892ce2efc4 100644
--- a/mm/show_mem.c
+++ b/mm/show_mem.c
@@ -427,6 +427,8 @@ void __show_mem(unsigned int filter, nodemask_t *nodemask, int max_zone_idx)
 
 		nr = alloc_tag_top_users(tags, ARRAY_SIZE(tags), false);
 		if (nr) {
+			pr_notice("Memory alloction profiling is turned %s\n",
+				mem_alloc_profiling_enabled() ? "on" : "off");
 			pr_notice("Memory allocations:\n");
 			for (i = 0; i < nr; i++) {
 				struct codetag *ct = tags[i].ct;
-- 
2.47.3


