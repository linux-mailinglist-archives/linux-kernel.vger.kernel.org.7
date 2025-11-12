Return-Path: <linux-kernel+bounces-896706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DA2DC5104C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 08:53:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C8A2A4EC013
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 07:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD3E22D9EDD;
	Wed, 12 Nov 2025 07:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="JGwKsVaH"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A4AB1E492A
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 07:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762933934; cv=none; b=OtY5no8Fe7dWpmaxnVZ1yipGESlyLudEywg/Y79IFFRdnU8GPXEeduZ4dTwwAFZPvdunO0JcZELKP19cQQrdvAX2aQkHpqEo6zYHui9aHuQTD1jZGOecFD8uVXzIPMTmO4Ll2KTJtQSZ/hWeh7cen1WAsPe7+7Qh0GXY223LMjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762933934; c=relaxed/simple;
	bh=PI6ZGWyo084vtAmcwr3XK4acwTrj1OVP/mypm1sK568=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QH4ANWMoDyXZ1gfTSyTt0vJBBa94IZefOY2+dyRR8dUkOVqtHprYpNbgckzABwPyjxVVKCHNsLA4EtQzO1LBMbRxy7tR4NhaqGcyIDIdiAsoL8bHfTGKH2eETrtPEx+/78kYBE4O9GXuzuHWW/6RLaVxaTKfXNo4kixjCvCrmdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=JGwKsVaH; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-640aaa89697so633071a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 23:52:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762933930; x=1763538730; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=baF77Nd6PddrT+NcaQcnWaJHYcsWM5/03L4b2UgZmEs=;
        b=JGwKsVaHr8J3u8f5yM34xz/z8I/lHfkBPaYAZw0pV1K7/gIreV8H31BSZwAZfUpuLt
         82gmiOm4YXWwNV9/GzKQZxn4JtsNt3da7H5Ea6H/2BLCDXEXDG6UnCXwSUpSVZiMSy/f
         tFY4hfutCH4ZCU/dvvHNXxJdhgk1Ti1yvb8WVPlurWwApCeJqvNWy4apz3WwtGa+buWC
         hKKFAFAuiDNASaA4QwTeSm02zC5LhHtL0d3WPW126LkZTyLldCFGvNzKER8PjTY5K8OI
         xTEouHlEqwXXtFhNrM80CoFN9ZHGu0U7+HnlCA/GjXU2VDKqfx28yzq9q/VGhc2tbxFe
         o1Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762933930; x=1763538730;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=baF77Nd6PddrT+NcaQcnWaJHYcsWM5/03L4b2UgZmEs=;
        b=DUHN9/F05gxK4Xa0c29J2Pd9dYY+khT0INDUap0rwYxNs+1HPxDL48pqY0y7VKxMFe
         CpELlQ030Q5MLa5UbUHmxk2o1a+IsGwp9Scx3jpok0JbshnvAj5iJuSZPuCiIifNfmEa
         HmnMMdeXq88151leUvIj7edk2AeAtjCLTwdgWrYkWcECZoNfiqvm3e7NWqDNRH7MPK+C
         vB0dKs0QOSoRszOLgOC7iIMT5Gx/tLkjCX2Xaqs2nZ45QjYy3HtX8I62daHYjB7jRmR7
         682jCM+YAlOqgaXUTzZYPTOvuGqJd71rLo42oN38foDRc3JmSnRNaQmrAeBukBM5XIpq
         ZtGw==
X-Forwarded-Encrypted: i=1; AJvYcCVjZhMOcu5MFQwY2DSIYq6Um3ZGEcOHK8EzfC3di100Ix/Z2U/MdGqXuvy6wp6EWlbHGeGG68hTCWJSzzQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwI9ezWNmhQtGAw0F/CzwK0tdBxRVKhdVHCzQNnDRFdsRTEAQHY
	yXf6ZAaFGkSRLyY6S6V94TAsKAbupe/OvMoWLmCE+q7SDW+QHS3VS/clJ+79nM7C+sM=
X-Gm-Gg: ASbGncuyFWxePo4+3xVimuXJIvIUvpWeul5TRDSv8DRuqiu8JdhfaWbf6+svuycVas2
	xbc1Vs5RY2d25JLJdA6o9hvNRjg38kvh/vOhUb25SQB40+PqzeYRHU391uM8hgaXmEpf7S/STIJ
	K75Cuo/7LYuR2LJcHpr7TyaaBtqEENvJsCVJyHxjCFxJU/kDvq/9qmtPaZjL4jiuGVZowXUhwd2
	1bp9/OBNXJ7HWOs/SVeVYQ0CpXsv4VOa45zSDlG1MVZ9bj4TauJdjRGiNyOXsMmAuH8d1gJQblq
	VS4TTnMWNRvxYlvLPyar0oajq4fon7krKkmsqnWe4beC6W+Ga76zcFZS9U+P7q3/6RyRd4OfqaV
	Q8TpogSrBpytPYprylgZxtLegy+NwGgfT8X1D6M1WHvQ35AmhTk6ETwG7dRsdBDPbEMiLZAnI/1
	vtECw/lJ+4+6Actg==
X-Google-Smtp-Source: AGHT+IHrUFgBXB0mlhlDx5ulVZ/CWC4rg/lpc+ghJAkmKWSBb8GGXulAMnQrIW2KVp+058faH6NYGw==
X-Received: by 2002:a05:6402:218c:20b0:640:93b2:fd07 with SMTP id 4fb4d7f45d1cf-6431a579409mr1286553a12.33.1762933930379;
        Tue, 11 Nov 2025 23:52:10 -0800 (PST)
Received: from localhost (109-81-31-109.rct.o2.cz. [109.81.31.109])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6415d91f486sm10653900a12.22.2025.11.11.23.52.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 23:52:10 -0800 (PST)
Date: Wed, 12 Nov 2025 08:52:06 +0100
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
Subject: Re: [PATCH v2 14/23] mm: allow specifying custom oom constraint for
 BPF triggers
Message-ID: <aRQ8pu_57IeA_Jn_@tiehlicka>
References: <20251027232206.473085-1-roman.gushchin@linux.dev>
 <20251027232206.473085-4-roman.gushchin@linux.dev>
 <aRGw6sSyoJiyXb8i@tiehlicka>
 <871pm4peeb.fsf@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871pm4peeb.fsf@linux.dev>

On Tue 11-11-25 11:17:48, Roman Gushchin wrote:
> Michal Hocko <mhocko@suse.com> writes:
> 
> > On Mon 27-10-25 16:21:57, Roman Gushchin wrote:
> >> Currently there is a hard-coded list of possible oom constraints:
> >> NONE, CPUSET, MEMORY_POLICY & MEMCG. Add a new one: CONSTRAINT_BPF.
> >> Also, add an ability to specify a custom constraint name
> >> when calling bpf_out_of_memory(). If an empty string is passed
> >> as an argument, CONSTRAINT_BPF is displayed.
> >
> > Constrain is meant to define the scope of the oom handler but to me it
> > seems like you want to specify the oom handler and (ab)using scope for
> > that. In other words it still makes sense to distinguesh memcg, global,
> > mempolicy wide OOMs with global vs. bpf handler, right?
> 
> I use the word "constraint" as the "reason" why an OOM was declared (in
> other words which constraint was violated). And memcg vs global define
> the scope. Right now the only way to trigger a memcg oom is to exceed
> the memory.max limit. But with bpf oom there will others, e.g. exceed a
> certain PSI threshold. So you can have different constraints violated
> within the same scope.

Please use a different placeholder for that. Current constrains have a
well defined semantic. They are not claiming why the OOM happened but
what is the scope of the oom action (domain if you will). The specific
handler has a sufficient knowledge to explain why the OOM killing is
happening and on which domain/scope/constrain.

-- 
Michal Hocko
SUSE Labs

