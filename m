Return-Path: <linux-kernel+bounces-780255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B556DB2FF7F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 18:01:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18D08A25DEF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 15:54:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FC64276024;
	Thu, 21 Aug 2025 15:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rxMyB0Um"
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 194F926A09B
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 15:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755791660; cv=none; b=G9OirxUlyqw1b9tjfStXKPgfl1AEh7eAMrRqbWi/9um6fC6CzCn2rEqarzvoWoFRZwSWPEzp1A4VGgSvu72tVvdCGmJADtuLRDKlUxAVSEj+tBjDyq7ID8CXSwT90vBndDoJ3pXBTgcQ5nSFqtvrnheQYPBYgACSnYcdKMDhZ/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755791660; c=relaxed/simple;
	bh=s3NkfWdWiM3+pPoQeRZMPqKFnHl7CSCDRhf6EKIfA6Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CTC7JRFaFKIohYxKj7Xu4P3upxniGck12Imj/EQrsJX7p9Vu5FGlQBhnEivLjBdUi5KgOfeNOtPwHj1MnkhJDMNMzZse1FoJb/d3TegfJrAdC9jU/S/VN88K0maoTplPy0DM1xTTPqVMQsZBEHFjbO5uQziVuz1gOt08P18xt9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rxMyB0Um; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4b29b714f8cso319981cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 08:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755791658; x=1756396458; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fN8fFqbbfxw/oj3xUy2dOVhcytSJepW36qzZ5F62/r0=;
        b=rxMyB0UmDLqlI7cZo5cyd3RZjwHsxqdmjDJ2h1nA6QQ2cXjsSv6XA030Hwgh3Fabl7
         1lxVI8Ynx+lpYSsDFomj6/naIiluHTZLW7fR6boBUwG11PLoBz3pXJ9yJQx07VPgsOTh
         0z+np+4lNGlgxYSIY0ZYXEVPpTjOJ3kNyVVfkTmwDa8Yi7o8sQFHDP7JjzFt4pJtJ996
         ZoZFBiWvPVjxKqlTUiSqWdJnUbvjlTz+P+oC9nkvyYcSOoryb1qofLQXBTLZb072GYWb
         eJpqA1KrUW6XttAXaAbp8vvDiV0mUC9Y1nyCkVKt6xzQTceszMBDyC370r0TcTSOgBPu
         v25g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755791658; x=1756396458;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fN8fFqbbfxw/oj3xUy2dOVhcytSJepW36qzZ5F62/r0=;
        b=oPDvk0zSmUuxCbU1LojRdW0z/tby8rQ2bXkGfTdgCmcSLOxgE5QJ2Pbz4pOXIUS6P/
         TPkoYPfdW+cusRtLtu+hAYl+x8I3RaN66At9e/UrEamSELqGtzdOsVXfnCzLD4kM+UGP
         4PUC3cZg0TAJGRnTy62nkUl8L7QCXQBCP9gImKjeyWC+dHOAh8ie3xv+1U3R66dWdsTp
         KZkezFajWr7D9OMlxAmrfaOM7ojt3jKmn2YDHeqKBa7EVLalx/10N0NjP4AJ2VUQJ6eT
         SGzN2EB/8xvzXcID4MIuOHwdu87qPbP56Ru5MCwJ+9EXORhyNK1nDBR8ZeQsFMx2TUzA
         1TKw==
X-Forwarded-Encrypted: i=1; AJvYcCUdC07DM1y7ffYK/HD2PtxPm0tyiK3/ipnZSCC046v19aP9B9IfE7I+IY8OL/f4klYZ1LynxJQB8AB9FbA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjMtTo3UqLzwB0AzwZafwCv15tNKXeZfBSXbV8ttZwG+uMCsBU
	7UMafJjc0omRRQ90jm8F1njfNs2pX1B/ThLbwNlmnmN+wb7x1xXMaa7XTZUYfLH/JjBdI/aZEuE
	/C/5+WGWyVo+dWEI91BJMRV7onHfd/Ra0fTJxn8fB
X-Gm-Gg: ASbGncs16vwkIt8gbdxA4aLD8b8o/9uwc/FrQaONmZ0k7TKKzgDGBXsz7Xy23W5iSiq
	2zIlnYKFOdsvLcaqEmPm8gL1S78kxaBLxO4AMkQFQkWTDIppR2V5vhHIePymZBYks/0aD5iD5yF
	fiuQcdtTcK21uuegLm2HlkOSpbI9AYLeq2RRXoNa1l+xwmuhR1O4n4wEYqaPAl1t2Wbi/gqwbkz
	dVp759rNEae/Yk+TZ3i9ujNNI5H2+qXwDP7aSthnCDv+aCJ5wu0wys=
X-Google-Smtp-Source: AGHT+IF7ftkzBG+sErHG0PyIKhN56o5QPEdRNCi+vPkHmyiE5ovuaHVbNMUd5SO4AajLAnQHLFuy1cPHbgz3xOWbu6o=
X-Received: by 2002:a05:622a:1aa0:b0:4a5:a83d:f50d with SMTP id
 d75a77b69052e-4b29fa06aadmr5250511cf.11.1755791657570; Thu, 21 Aug 2025
 08:54:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250818170136.209169-1-roman.gushchin@linux.dev>
 <20250818170136.209169-2-roman.gushchin@linux.dev> <CAP01T76AUkN_v425s5DjCyOg_xxFGQ=P1jGBDv6XkbL5wwetHA@mail.gmail.com>
 <87ms7tldwo.fsf@linux.dev> <CAP01T76xFkhsQKCtCynnHR4t6KyciQ4=VW2jhF8mcZEVBjsF1w@mail.gmail.com>
 <875xehh0rc.fsf@linux.dev>
In-Reply-To: <875xehh0rc.fsf@linux.dev>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 21 Aug 2025 08:54:06 -0700
X-Gm-Features: Ac12FXwQnszAXbgUOsvMFTdZCWPF5sLUrZJo15MDmJrYfWcN3MOe0juq7mH91Ms
Message-ID: <CAJuCfpGTBvwv9vZ1T60ejk+uDVrTLbCDvhP0hMiT-Cr7to6yEw@mail.gmail.com>
Subject: Re: [PATCH v1 01/14] mm: introduce bpf struct ops for OOM handling
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>, linux-mm@kvack.org, bpf@vger.kernel.org, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@suse.com>, 
	David Rientjes <rientjes@google.com>, Matt Bobrowski <mattbobrowski@google.com>, 
	Song Liu <song@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 20, 2025 at 7:22=E2=80=AFPM Roman Gushchin <roman.gushchin@linu=
x.dev> wrote:
>
> Kumar Kartikeya Dwivedi <memxor@gmail.com> writes:
>
> > On Thu, 21 Aug 2025 at 02:25, Roman Gushchin <roman.gushchin@linux.dev>=
 wrote:
> >>
> >> Kumar Kartikeya Dwivedi <memxor@gmail.com> writes:
> >>
> >> > On Mon, 18 Aug 2025 at 19:01, Roman Gushchin <roman.gushchin@linux.d=
ev> wrote:
> >> >>
> >> >> Introduce a bpf struct ops for implementing custom OOM handling pol=
icies.
> >> >>
> >> >> The struct ops provides the bpf_handle_out_of_memory() callback,
> >> >> which expected to return 1 if it was able to free some memory and 0
> >> >> otherwise.
> >> >>
> >> >> In the latter case it's guaranteed that the in-kernel OOM killer wi=
ll
> >> >> be invoked. Otherwise the kernel also checks the bpf_memory_freed
> >> >> field of the oom_control structure, which is expected to be set by
> >> >> kfuncs suitable for releasing memory. It's a safety mechanism which
> >> >> prevents a bpf program to claim forward progress without actually
> >> >> releasing memory. The callback program is sleepable to enable using
> >> >> iterators, e.g. cgroup iterators.
> >> >>
> >> >> The callback receives struct oom_control as an argument, so it can
> >> >> easily filter out OOM's it doesn't want to handle, e.g. global vs
> >> >> memcg OOM's.
> >> >>
> >> >> The callback is executed just before the kernel victim task selecti=
on
> >> >> algorithm, so all heuristics and sysctls like panic on oom,
> >> >> sysctl_oom_kill_allocating_task and sysctl_oom_kill_allocating_task
> >> >> are respected.
> >> >>
> >> >> The struct ops also has the name field, which allows to define a
> >> >> custom name for the implemented policy. It's printed in the OOM rep=
ort
> >> >> in the oom_policy=3D<policy> format. "default" is printed if bpf is=
 not
> >> >> used or policy name is not specified.
> >> >>
> >> >> [  112.696676] test_progs invoked oom-killer: gfp_mask=3D0xcc0(GFP_=
KERNEL), order=3D0, oom_score_adj=3D0
> >> >>                oom_policy=3Dbpf_test_policy
> >> >> [  112.698160] CPU: 1 UID: 0 PID: 660 Comm: test_progs Not tainted =
6.16.0-00015-gf09eb0d6badc #102 PREEMPT(full)
> >> >> [  112.698165] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996=
), BIOS 1.17.0-5.fc42 04/01/2014
> >> >> [  112.698167] Call Trace:
> >> >> [  112.698177]  <TASK>
> >> >> [  112.698182]  dump_stack_lvl+0x4d/0x70
> >> >> [  112.698192]  dump_header+0x59/0x1c6
> >> >> [  112.698199]  oom_kill_process.cold+0x8/0xef
> >> >> [  112.698206]  bpf_oom_kill_process+0x59/0xb0
> >> >> [  112.698216]  bpf_prog_7ecad0f36a167fd7_test_out_of_memory+0x2be/=
0x313
> >> >> [  112.698229]  bpf__bpf_oom_ops_handle_out_of_memory+0x47/0xaf
> >> >> [  112.698236]  ? srso_alias_return_thunk+0x5/0xfbef5
> >> >> [  112.698240]  bpf_handle_oom+0x11a/0x1e0
> >> >> [  112.698250]  out_of_memory+0xab/0x5c0
> >> >> [  112.698258]  mem_cgroup_out_of_memory+0xbc/0x110
> >> >> [  112.698274]  try_charge_memcg+0x4b5/0x7e0
> >> >> [  112.698288]  charge_memcg+0x2f/0xc0
> >> >> [  112.698293]  __mem_cgroup_charge+0x30/0xc0
> >> >> [  112.698299]  do_anonymous_page+0x40f/0xa50
> >> >> [  112.698311]  __handle_mm_fault+0xbba/0x1140
> >> >> [  112.698317]  ? srso_alias_return_thunk+0x5/0xfbef5
> >> >> [  112.698335]  handle_mm_fault+0xe6/0x370
> >> >> [  112.698343]  do_user_addr_fault+0x211/0x6a0
> >> >> [  112.698354]  exc_page_fault+0x75/0x1d0
> >> >> [  112.698363]  asm_exc_page_fault+0x26/0x30
> >> >> [  112.698366] RIP: 0033:0x7fa97236db00
> >> >>
> >> >> It's possible to load multiple bpf struct programs. In the case of
> >> >> oom, they will be executed one by one in the same order they been
> >> >> loaded until one of them returns 1 and bpf_memory_freed is set to 1
> >> >> - an indication that the memory was freed. This allows to have
> >> >> multiple bpf programs to focus on different types of OOM's - e.g.
> >> >> one program can only handle memcg OOM's in one memory cgroup.
> >> >> But the filtering is done in bpf - so it's fully flexible.
> >> >
> >> > I think a natural question here is ordering. Is this ability to have
> >> > multiple OOM programs critical right now?
> >>
> >> Good question. Initially I had only supported a single bpf policy.
> >> But then I realized that likely people would want to have different
> >> policies handling different parts of the cgroup tree.
> >> E.g. a global policy and several policies handling OOMs only
> >> in some memory cgroups.
> >> So having just a single policy is likely a no go.
> >
> > If the ordering is more to facilitate scoping, would it then be better
> > to support attaching the policy to specific memcg/cgroup?
>
> Well, it has some advantages and disadvantages. First, it will require
> way more infrastructure on the memcg side. Second, the interface is not
> super clear: we don't want to have a struct ops per cgroup, I guess.
> And in many case a single policy for all memcgs is just fine, so asking
> the user to attach it to all memcgs is just adding a toil and creating
> all kinds of races.
> So I see your point, but I'm not yet convinced, to be honest.

I would suggest keeping it simple until we know there is a need to
prioritize between multiple oom-killers.

>
> Thanks!
>

