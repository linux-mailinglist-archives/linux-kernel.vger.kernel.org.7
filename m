Return-Path: <linux-kernel+bounces-896704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A38DDC51016
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 08:50:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4C10C34D687
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 07:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 996F52ECEA7;
	Wed, 12 Nov 2025 07:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="hEHdimdQ"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBCE22ED853
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 07:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762933811; cv=none; b=QJzRbiWjkfJcunKfQh+MMRIMaDhbzCAtYjqbPoVWZNpSdm2xge8eUcmeXxO2VWJSbKBIDuY21EkrqAprH0+g3KIPRGbSe4HcyYZbA1wav+ulzV2owzrMn70+xVEeHHmnejuSTl4vxjBl1lvxi19BXxvZYWSCqxnzVcrFPkyUi3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762933811; c=relaxed/simple;
	bh=vQGEuOEI5CcliGhoSpli1L+Hj54P/8blyd40sP9gSxI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=haDwgFLk/1/4fzu2B8sC1evbw06cVIdJ04lR9KXtZs5tMzNEfgLKGCUCdXi858h1lzYC4P3lEYrxs5/zG38JPiaMxU3cdln8FuT9eVana+bLD94WunLkmQAgUXpsUo7U2Nhfw/cbcSjJxfayKAH8/GfvwdbyTdf5BgBt+Ki0BJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=hEHdimdQ; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b7272012d30so82436866b.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 23:50:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762933807; x=1763538607; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ipL3Z/6wC6GRR63sS5vId/ptcyhjHxEgUXfHm/LakcE=;
        b=hEHdimdQqrJZbhfw9mvGHyq7rfhp84Azrx0gry1bPRHTdG8f22gD2OL0GA2oGBU5Gf
         ekAfxxBO4vHF56sNu2h8bQq2IM8btoSuuTlnPATXj7/Jk3Z8Z1QiU/BnJdVgibbr0BI4
         T5mbbqn8lFDxNp1J7cLdJ/p7F49KY1OXaIxqK9eWVHOxiB8MK5TpI9uJ+XcHPETqhb8G
         xwwyTIFjEu3d7uLd5nsbndZXfPog6fGyKLJ8oJ6UL4N6Zw3P9xf9YRLAZlSe2oeZblQD
         gWaKa1LJWRF0DeXl9elOZFE7jKzh2EEXOdKDe642naCoXfMsr/anzAk9+AITTOAryKF+
         VxcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762933807; x=1763538607;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ipL3Z/6wC6GRR63sS5vId/ptcyhjHxEgUXfHm/LakcE=;
        b=OG2wMudHticzNi0kNsGOBSofheGekHuY2cLml5SXFi6iwdbJiQsQsmPMtqbugi3Q3w
         mT292W87N2PbiQDbXSPZgNfaItgE7BgBnPXbCy1lxUae+ZT+vcGTtyhjINLI3Yi+MUTB
         mEKRwTVR+i/Xc1NDqwoG+jpwev1yOYYf2YppIF8ZmwjiClyhVcFYqwDr2csrXUgMiZnq
         nOogfU1o7CbzcWf0udw7WIfUtpg0k93Qh+gj6GP/n8+aBc0EVkFzY82pBwYAIEenAv1q
         zwdGNObQraBP+spSHqwLcf0N56ehitHeKeI7Jgp7B/fvUEjENuTUQ7Lpz7E63UV4csGh
         fyFw==
X-Forwarded-Encrypted: i=1; AJvYcCWaO9qpcIWcFHIrb9EihfcmPUO4DvV+UfP8EymEevakncZSsVS40ISPKqUkx4UwiKYvQg/zjrgTG89Lnmo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVyUDWOt2Mskhi1Wc6EB1p2we1QqCULRpDMUPYqAngs370SyIV
	pQaRZTVMDMI+qPIq5QFByAuqmhdkMzZtXEJUwGYDkCmb2omyZuMiDVjxzSrNmhgfigI=
X-Gm-Gg: ASbGncvMDYbzWmjSftv776GDW6dQepCEFGwW4qFuTBh2V5ZZzq6GM+xoCx1YoAfz+q/
	dwqpVo6d64Cj7H6RmuBP3ktMoUuXx2MJxXu6tdd9TdyVQtflIfmgNzJW9l+EubH9VIrU90MPLGK
	WRNfq+Wtr9eUihrpaPc8kbZqYpTtcC/wJCBBCbnuU5LD2cN0n+wFF7gCE74EvGhZt7aK4vtdgeX
	5HLNAfL0BE8AiE5rkJnbuM+QMzrbHphOieDYspcOryLuKFf30ouMHzI3AMJPn+gauu4YGyvFuLb
	/uomo9iMsU8PnPb5Gez+z3tioqUnFvSZd3h6G/iERCnFzx3LXdmZE1UgxVuctHWfgcp8BOa6Kvt
	f3fIHP+AshPDHADdI5BaDE/vysw4CqoeCTg30ZNSVyp/wLsIx4AZ+KtJc+Hv2pz8LrtBuWikByS
	PV9lHtynjo86o7sA==
X-Google-Smtp-Source: AGHT+IFkrb3GSMhhW1bzYaSDD1E5kGgIrUWkWimOuuxU6/CLGbZTn7iNA2cGrP2NCWseV/3pUPbNoQ==
X-Received: by 2002:a17:907:7e8e:b0:b73:2bc4:ebf with SMTP id a640c23a62f3a-b73319649c1mr168849366b.2.1762933806298;
        Tue, 11 Nov 2025 23:50:06 -0800 (PST)
Received: from localhost (109-81-31-109.rct.o2.cz. [109.81.31.109])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bf9bc214sm1583946166b.52.2025.11.11.23.50.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 23:50:06 -0800 (PST)
Date: Wed, 12 Nov 2025 08:50:05 +0100
From: Michal Hocko <mhocko@suse.com>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	JP Kobryn <inwardvessel@gmail.com>, linux-mm@kvack.org,
	cgroups@vger.kernel.org, bpf@vger.kernel.org,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Song Liu <song@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v2 13/23] mm: introduce bpf_out_of_memory() BPF kfunc
Message-ID: <aRQ8LQWxoRF0kgXk@tiehlicka>
References: <20251027232206.473085-1-roman.gushchin@linux.dev>
 <20251027232206.473085-3-roman.gushchin@linux.dev>
 <aRG0ZyL93jWm4TAa@tiehlicka>
 <87qzu4pem7.fsf@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87qzu4pem7.fsf@linux.dev>

On Tue 11-11-25 11:13:04, Roman Gushchin wrote:
> Michal Hocko <mhocko@suse.com> writes:
> 
> > On Mon 27-10-25 16:21:56, Roman Gushchin wrote:
> >> Introduce bpf_out_of_memory() bpf kfunc, which allows to declare
> >> an out of memory events and trigger the corresponding kernel OOM
> >> handling mechanism.
> >> 
> >> It takes a trusted memcg pointer (or NULL for system-wide OOMs)
> >> as an argument, as well as the page order.
> >> 
> >> If the BPF_OOM_FLAGS_WAIT_ON_OOM_LOCK flag is not set, only one OOM
> >> can be declared and handled in the system at once, so if the function
> >> is called in parallel to another OOM handling, it bails out with -EBUSY.
> >> This mode is suited for global OOM's: any concurrent OOMs will likely
> >> do the job and release some memory. In a blocking mode (which is
> >> suited for memcg OOMs) the execution will wait on the oom_lock mutex.
> >
> > Rather than relying on BPF_OOM_FLAGS_WAIT_ON_OOM_LOCK would it make
> > sense to take the oom_lock based on the oc->memcg so that this is
> > completely transparent to specific oom bpf handlers?
> 
> Idk, I don't have a super-strong opinion here, but giving the user the
> flexibility seems to be more future-proof. E.g. if we split oom lock
> so that we can have competing OOMs in different parts of the memcg tree,
> will we change the behavior?

The point I've tried to make is that this OOM invocation is no different
from the global one from the locking perspective. Adding an external
flag to control the behavior might be slightly more flexible but it adds
a new element. Unless there is a very strong reason for that I would go
with the existing locking model.

-- 
Michal Hocko
SUSE Labs

