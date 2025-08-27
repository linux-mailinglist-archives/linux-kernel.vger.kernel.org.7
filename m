Return-Path: <linux-kernel+bounces-788740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BD2FB38988
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 20:28:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCDA0205B58
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 18:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 132F52D97A1;
	Wed, 27 Aug 2025 18:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="br5GY858"
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABED94438B
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 18:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756319323; cv=none; b=JYDYS+xN0fHsRUghOwOJkYc0rqKFuSn4h0G/0677bc1wqCiaFs70hQgWlrFIm0cSi8zrzPOJu2Agd0hRguEcoY6J+Gk46QsVKB+2+uA4zpe/F2Yn6QSIZ5/cpmkDEax998oqqg8C1eIuIpda9YvuhMwKy5+7mGbqxNGCPdGMz+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756319323; c=relaxed/simple;
	bh=41wqfGoUvCOSCwBnkrsV8Al8LdILnHJRjtaAseQQoqo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=V3OQ9w9suYUS6d74pM1fuSykljCfPxMsR9NgY1esAns+1LkSC/KhHb59vnU4ZShY7Gtf+OLLqF34yeea9BBMSGZhL3G07VjomGZGgW821nigd7O3ZsnBc4UoTtvXsf8cq5h5yvpbnhZ1W5/dNhflDeoU2+B+WyTTjg+gCJqLmf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=br5GY858; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756319318;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=41wqfGoUvCOSCwBnkrsV8Al8LdILnHJRjtaAseQQoqo=;
	b=br5GY858419c2v32Z6PeVsAhcd4ny8W0OEjE7Dz2x7cAsMc4ZJqVzZvOCCMyBwrVrq+YF8
	LxtKzhK/A0nyt058rLDOO4MiQNGNYNdOd9QpQpuCYwX7sheyCWlUSVTAg9zJcoXx62I2wk
	s52wIEOFyTcYY/DopaL8X/Ux9zKB0kU=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>,  Kumar Kartikeya Dwivedi
 <memxor@gmail.com>,  linux-mm <linux-mm@kvack.org>,  bpf
 <bpf@vger.kernel.org>,  Suren Baghdasaryan <surenb@google.com>,  Johannes
 Weiner <hannes@cmpxchg.org>,  Michal Hocko <mhocko@suse.com>,  David
 Rientjes <rientjes@google.com>,  Matt Bobrowski
 <mattbobrowski@google.com>,  Song Liu <song@kernel.org>,  Alexei
 Starovoitov <ast@kernel.org>,  Andrew Morton <akpm@linux-foundation.org>,
  LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 01/14] mm: introduce bpf struct ops for OOM handling
In-Reply-To: <CAADnVQ+LGbXXHHTbBB9b-RjAXO4B6=3Z=G0=7ToZVuH61OONWA@mail.gmail.com>
	(Alexei Starovoitov's message of "Tue, 26 Aug 2025 12:52:26 -0700")
References: <20250818170136.209169-1-roman.gushchin@linux.dev>
	<20250818170136.209169-2-roman.gushchin@linux.dev>
	<CAP01T76AUkN_v425s5DjCyOg_xxFGQ=P1jGBDv6XkbL5wwetHA@mail.gmail.com>
	<87ms7tldwo.fsf@linux.dev>
	<1f2711b1-d809-4063-804b-7b2a3c8d933e@linux.dev>
	<87wm6rwd4d.fsf@linux.dev>
	<ef890e96-5c2a-4023-bcb2-7ffd799155be@linux.dev>
	<CAADnVQ+LGbXXHHTbBB9b-RjAXO4B6=3Z=G0=7ToZVuH61OONWA@mail.gmail.com>
Date: Wed, 27 Aug 2025 11:28:29 -0700
Message-ID: <87cy8gty9e.fsf@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Migadu-Flow: FLOW_OUT

Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:

> On Tue, Aug 26, 2025 at 11:01=E2=80=AFAM Martin KaFai Lau <martin.lau@lin=
ux.dev> wrote:
>>
>> On 8/25/25 10:00 AM, Roman Gushchin wrote:
>> > Martin KaFai Lau <martin.lau@linux.dev> writes:
>> >
>> >> On 8/20/25 5:24 PM, Roman Gushchin wrote:
>> >>>> How is it decided who gets to run before the other? Is it based on
>> >>>> order of attachment (which can be non-deterministic)?
>> >>> Yeah, now it's the order of attachment.
>> >>>
>> >>>> There was a lot of discussion on something similar for tc progs, and
>> >>>> we went with specific flags that capture partial ordering constrain=
ts
>> >>>> (instead of priorities that may collide).
>> >>>> https://lore.kernel.org/all/20230719140858.13224-2-daniel@iogearbox=
.net
>> >>>> It would be nice if we can find a way of making this consistent.
>> >>
>> >> +1
>> >>
>> >> The cgroup bpf prog has recently added the mprog api support also. If
>> >> the simple order of attachment is not enough and needs to have
>> >> specific ordering, we should make the bpf struct_ops support the same
>> >> mprog api instead of asking each subsystem creating its own.
>> >>
>> >> fyi, another need for struct_ops ordering is to upgrade the
>> >> BPF_PROG_TYPE_SOCK_OPS api to struct_ops for easier extension in the
>> >> future. Slide 13 in
>> >> https://drive.google.com/file/d/1wjKZth6T0llLJ_ONPAL_6Q_jbxbAjByp/view
>> >
>> > Does it mean it's better now to keep it simple in the context of oom
>> > patches with the plan to later reuse the generic struct_ops
>> > infrastructure?
>> >
>> > Honestly, I believe that the simple order of attachment should be
>> > good enough for quite a while, so I'd not over-complicate this,
>> > unless it's not fixable later.
>>
>> I think the simple attachment ordering is fine. Presumably the current l=
ink list
>> in patch 1 can be replaced by the mprog in the future. Other experts can=
 chime
>> in if I have missed things.
>
> I don't think the proposed approach of:
> list_for_each_entry_srcu(bpf_oom, &bpf_oom_handlers, node, false) {
> is extensible without breaking things.
> Sooner or later people will want bpf-oom handlers to be per
> container, so we have to think upfront how to do it.
> I would start with one bpf-oom prog per memcg and extend with mprog later.
> Effectively placing 'struct bpf_oom_ops *' into oc->memcg,
> and having one global bpf_oom_ops when oc->memcg =3D=3D NULL.
> I'm sure other designs are possible, but lets make sure container scope
> is designed from the beginning.
> mprog-like multi prog behavior per container can be added later.

Sounds good to me, will implement something like this in the next version.

Thanks!

