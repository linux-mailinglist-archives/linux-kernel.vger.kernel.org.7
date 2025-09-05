Return-Path: <linux-kernel+bounces-803766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EDCBCB464EF
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 22:49:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A56B63AC048
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 20:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50FC92EA179;
	Fri,  5 Sep 2025 20:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RSYl2b4t"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1AC92E36F1
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 20:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757105335; cv=none; b=QSFB8jh5CbgzEbT9D1d9nwaC8+ProfUeDQAuN+5C9t5BXrEsXFv1fynQO+iWW15lumTCnODDU+OaZu2snxvQY8nLbuJZmQKyQK+Llpxt9Dna1tieOatPH5TrdOim6eqAOS+rMO4M8hRkmlcHu4YmZ+WAPrVZjc4vfKwXvSiJvcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757105335; c=relaxed/simple;
	bh=Lddiy/CUg8ag5U9qRcSe06M8YgtvRJvYOtgl2OT0pcg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uHQoDZ7V83qMUJsBgIjLwESet2KYH0GsDI5KE/43Iq8lv99saO4Lgid1VUCJXRYCmFoeNFkEyvkBi1IMUSU8lhMb5cfC+Zg2TcjwQWoZ1OuMXsMoZSaIRJKHPQ/4DuuoLe82+6qOfkGudeN4g1zDSPewCnu/Fcn9QlyzTjIDW+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RSYl2b4t; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-24cca557085so17285ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 13:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757105332; x=1757710132; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0GiODW3jiNFo5GcWlFYzIpqNrxA7Q2Lf72MRDCRU/DQ=;
        b=RSYl2b4tliMhv335SHVfOaEmGWxePnqCHaoRrniMsbveAJG9TioX7pB+XDbGOnduHG
         64l1myOpVNV0wriOAlmTGsaIq9sfVutpOSLY/zybUt97T7hZH83oZhsnsiHfL5AQkOr4
         6olDxSxG//JRPglwmw/juWEOfdA6DqQNLk/oXffKWh9BkAGKgM/3gRtu2czamRKZAF7R
         8zYu+fhSMaEAdEI4VpnMuwN1b+bbeO3AfRliRiXXM5I69rrRRFetkiXAlmuIhZFUUKDj
         5npOySA6E6bza7dk5ChUq8xKaSlCOmAQ1YG037feuJ/aNKgscuOlHtIT8TiUhuLHyXjG
         li7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757105332; x=1757710132;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0GiODW3jiNFo5GcWlFYzIpqNrxA7Q2Lf72MRDCRU/DQ=;
        b=HjdurTTUalbkP/crOuiytLj6hJRpLkUPVmWjEG4W+8cAeICR4RV85qr1gfj4BdGMHA
         K4C66zmX6lhhODT8yQF+MPwJozdGGEgcIVoJ4d/PUUX4MHYNk2jmbZQhf8EGhc5ychzy
         LwhSyCVTtZX4DaYcUy4Usu0R1nj/CF51QAkOvqb/CbRu4KsVZVWQj8UhCryRS5+esbMP
         17PDbEodm/Xc+iZvoQ35COBLvDflk+IlHlfd/u81EfWkyRodeASgJA2AaKF6wxmT/4gP
         HGH9sGtrxg0WR89lIOGQgyoMdsVn8IsVoAsHgeTOkeOHTneAGILgKB0+vHE+cCpAFjEK
         SRTg==
X-Forwarded-Encrypted: i=1; AJvYcCWrSTFBl9KN6k71e3TqkE6ott7r4TAGcePaBaUuHhde+JAvxstm6GfdSKyhyDmzuqs6PNkWvllezHWoY9Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+ZOdrbQxsFbrz933ibsI1DFhDwzuDy3NwPrI8xKqVK2WmQMJI
	DxcHFb+KLkc0Z+sAqgZtGRThEV5Q3nFaxss8Uxyl+KOi2keUz79hC7Fs/uPG3OQ0+0OGn1KVSkD
	WlYabRQ==
X-Gm-Gg: ASbGncuZKuGqDaLB3jVTSvm647CkXx6uHMKTc8DbgxblQV5r3LYAAKXf+0524y9CRV8
	WyZncfMCL3uXXJrTrlWlS9CcxINCm13dkgs+n7RCk2vOmo8zEO38gd0aCk7Uuc/Iff1/lAefCSo
	O0WV53Dm9CJX5hyFMfRYe+xd86wIiAydecOkNj+e2RZPUR+AI6TXlPfPGvoCt/jfFIZdUUc2xS4
	QaQTU7vvgCgAt1sbv92HLGwVyXe4xXYogoIfA+jP2E8dnn+mQtQ9JVkOhl+hTxbtXT569xR85sk
	4uoXc2zG0QoI2RbXpSvo94LhKcM7WPJ0RtrqzJ/+78rbgbK8aY3H/D88ubzgwMYyPdcshwVmyE4
	zhTzGSizlJfAIm8THyFq39K2451proCKCmtLbcLdlXQMznwx7AGKWRsQ+qDEUB7H2IiQ=
X-Google-Smtp-Source: AGHT+IGxaodK2oxo1/T0jE66aVjXGi/uDMun6FTCnFGDt00e/yHDWzq7NKgwd2BLevagOtIH+S35aA==
X-Received: by 2002:a17:902:e850:b0:24b:131c:48b4 with SMTP id d9443c01a7336-2517446fa94mr26065ad.5.1757105331740;
        Fri, 05 Sep 2025 13:48:51 -0700 (PDT)
Received: from google.com (132.192.16.34.bc.googleusercontent.com. [34.16.192.132])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24ced566602sm31649925ad.126.2025.09.05.13.48.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 13:48:51 -0700 (PDT)
Date: Fri, 5 Sep 2025 20:48:46 +0000
From: Peilin Ye <yepeilin@google.com>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org,
	linux-mm@kvack.org, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH] memcg: skip cgroup_file_notify if spinning is not allowed
Message-ID: <aLtMrlSDP7M5GZ27@google.com>
References: <20250905201606.66198-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250905201606.66198-1-shakeel.butt@linux.dev>

On Fri, Sep 05, 2025 at 01:16:06PM -0700, Shakeel Butt wrote:
> Generally memcg charging is allowed from all the contexts including NMI
> where even spinning on spinlock can cause locking issues. However one
> call chain was missed during the addition of memcg charging from any
> context support. That is try_charge_memcg() -> memcg_memory_event() ->
> cgroup_file_notify().
> 
> The possible function call tree under cgroup_file_notify() can acquire
> many different spin locks in spinning mode. Some of them are
> cgroup_file_kn_lock, kernfs_notify_lock, pool_workqeue's lock. So, let's
> just skip cgroup_file_notify() from memcg charging if the context does
> not allow spinning.
> 
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>

Tested-by: Peilin Ye <yepeilin@google.com>

The repro described in [1] no longer triggers locking issues after
applying this patch and making __bpf_async_init() use __GFP_HIGH
instead of GFP_ATOMIC:

--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1275,7 +1275,7 @@ static int __bpf_async_init(struct bpf_async_kern *async, struct bpf_map *map, u
        }

        /* allocate hrtimer via map_kmalloc to use memcg accounting */
-       cb = bpf_map_kmalloc_node(map, size, GFP_ATOMIC, map->numa_node);
+       cb = bpf_map_kmalloc_node(map, size, __GFP_HIGH, map->numa_node);
        if (!cb) {
                ret = -ENOMEM;
                goto out;

[1] https://lore.kernel.org/bpf/20250905061919.439648-1-yepeilin@google.com/#t

Thanks,
Peilin Ye


