Return-Path: <linux-kernel+bounces-883568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 83281C2DC5E
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 20:00:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3BBDB4E4994
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 19:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8D701B87C0;
	Mon,  3 Nov 2025 19:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="GiQwvqaH"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B403299947
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 19:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762196427; cv=none; b=q9q+DlpQX4YphZjJAxO691Jrl7pEYn8dbK1S57T9hF4u1IWYnwTXBOuB8cyNbFmH7oy05XmdyVsEm86Wr517UiWOuudUfXEyJU16pbFsaqHcpMgKltbwTM5MFNy+1KDFdW9xDtkQpYwGIsVCuWuyOicM7fQh5hhfylGukCQ57ZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762196427; c=relaxed/simple;
	bh=5Kc76iaR2aicGpXWI2CwVtoEWluQcseYpAvOTgc83Jw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MLhg11O8nQfJ38KB9GR/Bfbs3Ca1kA6d1LtYynF8cIuDdy5+bo1TJrvqhlWulko5jw4kJ7AyUOXYD70+213JLONbOQRQEwwXJftSzT2N/hs0p9p4OdksPbaUfooP6nIyfFZjmo7z2IaI49bpgs/00+EIEOuM1BfvGN9ZcNOnxpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=GiQwvqaH; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b626a4cd9d6so698346166b.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 11:00:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762196411; x=1762801211; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QJ3N2WUq/UZ5e0T22UvDFgeGGC9bQkna+j2RgD0j4rQ=;
        b=GiQwvqaHr9wEq6132VYfm8iKRI4FGC+8x496Pvg6dWe9zodE9zoozX/wrcUk/ZKHgq
         5ckO9Z4C5FLWzUDAZ8UjroZRrOXlsvMiOtLxGNo4qZeeW4NH50rdjHPh6bIxQy8odj9M
         wbYZ0cWgsjHgTpxwRdWBCK8KaMUzIJ4ImKPOjHDYUQz1EhFOU09gRENbb87s8jpfXGUF
         2C3wHSy00Fqm3dbESN3krnSW6XEQ05WgtRYNgMOQ0KIx5MzAXk6AqUqSKN3wubDHrhNd
         Bhiu5HfFItPP8ebDYvCmtsJOCCPKLQmKGeSyHAtWnU9ey465/YJNfL7I/XIJwFxu1Xch
         9Drg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762196411; x=1762801211;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QJ3N2WUq/UZ5e0T22UvDFgeGGC9bQkna+j2RgD0j4rQ=;
        b=FyPlIFetX7QS+V3c9+BrDdP0Zhlh5h6S7pJ5RMQFisLgvGCawEWVC44O6R8GLZ0kl3
         tUzZ2+X08J9umRt7p74jfhXSI2hK1W50a0o9dCLL5tgKwozgca0sPrTkVpytjZVY/7mi
         Ga6M9b5UBGuOB9luyr/J5738o/msxGv0RQOqqI1Ay5K0OZ+miD3awI/DutIALJJs/bsB
         3qeNPtwPLpfgVXn3jhBdzwFGfQrjHW7F5wYizHDPw+/cXKZg0q4VB3sh6D/l74epqrPY
         NFTF/ikziDyD5Cr+RN2Ve4HmEJp71kKzJdKHgD4x8iTysGy4axOEMkKMcm0aZ0r/TbpQ
         CLcg==
X-Forwarded-Encrypted: i=1; AJvYcCXbjZKI8pV7RFG/2mNKgg8QV55OMrJDYktr102Na20ov1a+g9XlTYb2S0k+mYpBQSDDf1TmS0J0QcY1/SA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxV2dH5f1aNaPSuhvsCHgOSTvl8japBKpDg9/pgw9/jnNHG3GAI
	r6F4Bd0qkBgezO1F8A9awyziLhByPXuD/k1E5JAddUQjW27aI2TIN5oHB5RQLq52kx8=
X-Gm-Gg: ASbGncte0EtH3Cnm/aFCx0gqH5RNfYabh3yHEizbzxallaSy2unhx3aoFbmXuiaEZeP
	sXusS/A48yKMPOz3+2IKkDnqqYCftCdGpPnWfNvmtsrLHp5Sm9OaxuMyHJPlgcPC+Td+QUrNrTR
	sKSoDPpBklLOMV67Pu8XspvYglATMb1XQPs1JI2kAZ+tqeMApkJlDjTHOtV0w6G2ROKvEMroqpy
	QxsZjeaIoLymPComQd4el5mvM3TrOZdL3tV4/hgOJbNRGW/j5NJ4M0V8zlbpnSn8KSHmxc8Ueif
	SxR/i+27N97Wao0Upf08sa/ysiJEsBYzkbLnlDj5ouu7lrdJ5xofy7Cg4YG8F0P4sY/jUUeXX6k
	OlPPbtEN2SFwrYqJ/s++WMlz9fyeeAt1jvQHBepCSsuBYobqVrICgQ1DURa6PaaB9bhw7dx8TH7
	jUUTJqoRtt91i3hFPVklPNU3YB
X-Google-Smtp-Source: AGHT+IFhQXFPVDqHyarWQQ7R2subtRafoxgNsFUzIvYeodwBNh8qSwx6VEdKXz8J8S7jSfx/fTTE1Q==
X-Received: by 2002:a17:906:ad0:b0:b70:a982:ad71 with SMTP id a640c23a62f3a-b70a982f501mr457990366b.33.1762196410649;
        Mon, 03 Nov 2025 11:00:10 -0800 (PST)
Received: from localhost (109-81-31-109.rct.o2.cz. [109.81.31.109])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7077ce927csm1117305366b.63.2025.11.03.11.00.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 11:00:10 -0800 (PST)
Date: Mon, 3 Nov 2025 20:00:09 +0100
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
Subject: Re: [PATCH v2 06/23] mm: introduce BPF struct ops for OOM handling
Message-ID: <aQj7uRjz668NNrm_@tiehlicka>
References: <20251027231727.472628-1-roman.gushchin@linux.dev>
 <20251027231727.472628-7-roman.gushchin@linux.dev>
 <aQR7HIiQ82Ye2UfA@tiehlicka>
 <875xbsglra.fsf@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875xbsglra.fsf@linux.dev>

On Sun 02-11-25 13:36:25, Roman Gushchin wrote:
> Michal Hocko <mhocko@suse.com> writes:
> 
> > On Mon 27-10-25 16:17:09, Roman Gushchin wrote:
> >> Introduce a bpf struct ops for implementing custom OOM handling
> >> policies.
> >> 
> >> It's possible to load one bpf_oom_ops for the system and one
> >> bpf_oom_ops for every memory cgroup. In case of a memcg OOM, the
> >> cgroup tree is traversed from the OOM'ing memcg up to the root and
> >> corresponding BPF OOM handlers are executed until some memory is
> >> freed. If no memory is freed, the kernel OOM killer is invoked.
> >
> > Do you have any usecase in mind where parent memcg oom handler decides
> > to not kill or cannot kill anything and hand over upwards in the
> > hierarchy?
> 
> I believe that in most cases bpf handlers will handle ooms themselves,
> but because strictly speaking I don't have control over what bpf
> programs do or do not, the kernel should provide the fallback mechanism.
> This is a common practice with bpf, e.g. sched_ext falls back to
> CFS/EEVDF in case something is wrong.

We do have fallback mechanism - the kernel oom handling. For that we do
not need to pass to parent handler. Please not that I am not opposing
this but I would like to understand thinking behind and hopefully start
with a simpler model and then extend it later than go with a more
complex one initially and then corner ourselves with weird side
effects.
 
> Specifically to OOM case, I believe someone might want to use bpf
> programs just for monitoring/collecting some information, without
> trying to actually free some memory.
> 
> >> The struct ops provides the bpf_handle_out_of_memory() callback,
> >> which expected to return 1 if it was able to free some memory and 0
> >> otherwise. If 1 is returned, the kernel also checks the bpf_memory_freed
> >> field of the oom_control structure, which is expected to be set by
> >> kfuncs suitable for releasing memory. If both are set, OOM is
> >> considered handled, otherwise the next OOM handler in the chain
> >> (e.g. BPF OOM attached to the parent cgroup or the in-kernel OOM
> >> killer) is executed.
> >
> > Could you explain why do we need both? Why is not bpf_memory_freed
> > return value sufficient?
> 
> Strictly speaking, bpf_memory_freed should be enough, but because
> bpf programs have to return an int and there is no additional cost
> to add this option (pass to next or in-kernel oom handler), I thought
> it's not a bad idea. If you feel strongly otherwise, I can ignore
> the return value on rely on bpf_memory_freed only.

No, I do not feel strongly one way or the other but I would like to
understand thinking behind that. My slight preference would be to have a
single return status that clearly describe the intention. If you want to
have more flexible chaining semantic then an enum { IGNORED, HANDLED,
PASS_TO_PARENT, ...} would be both more flexible, extensible and easier
to understand.

> >> The bpf_handle_out_of_memory() callback program is sleepable to enable
> >> using iterators, e.g. cgroup iterators. The callback receives struct
> >> oom_control as an argument, so it can determine the scope of the OOM
> >> event: if this is a memcg-wide or system-wide OOM.
> >
> > This could be tricky because it might introduce a subtle and hard to
> > debug lock dependency chain. lock(a); allocation() -> oom -> lock(a).
> > Sleepable locks should be only allowed in trylock mode.
> 
> Agree, but it's achieved by controlling the context where oom can be
> declared (e.g. in bpf_psi case it's done from a work context).

but out_of_memory is any sleepable context. So this is a real problem.
 
> >> The callback is executed just before the kernel victim task selection
> >> algorithm, so all heuristics and sysctls like panic on oom,
> >> sysctl_oom_kill_allocating_task and sysctl_oom_kill_allocating_task
> >> are respected.
> >
> > I guess you meant to say and sysctl_panic_on_oom.
> 
> Yep, fixed.
> >
> >> BPF OOM struct ops provides the handle_cgroup_offline() callback
> >> which is good for releasing struct ops if the corresponding cgroup
> >> is gone.
> >
> > What kind of synchronization is expected between handle_cgroup_offline
> > and bpf_handle_out_of_memory?
> 
> You mean from a user's perspective?

I mean from bpf handler writer POV

> E.g. can these two callbacks run in
> parallel? Currently yes, but it's a good question, I haven't thought
> about it, maybe it's better to synchronize them.
> Internally both rely on srcu to pin bpf_oom_ops in memory.

This should be really documented.
-- 
Michal Hocko
SUSE Labs

