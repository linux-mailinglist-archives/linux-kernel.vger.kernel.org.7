Return-Path: <linux-kernel+bounces-878790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 3158AC2176E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 18:22:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CEC673504B8
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 17:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68E7324678E;
	Thu, 30 Oct 2025 17:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fRYib/kM"
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE5EC24677C
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 17:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761844964; cv=none; b=TFHA4PhCqh37hqa5/sFnCjr7ln1mvexeSyquCDEiD3nv2lTI8wju8UYje7rlTTdETxfxHpDHtqDVpy/8tIbGwBL8njvwdZnWpn7bLJWNeXOOWLuBRKEToQnUSOJcLk0B8qpqEIEz7Uwd6KyZ6053fNf58uuT1R5m1WWG6r1tqkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761844964; c=relaxed/simple;
	bh=BCoHEyyxZKYrrU4Ot3G1OWMRdoW/WRM++mtFk8nDG6U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Hg0+XJVbkIw85kPK0HAqlR7wK/Vexy16GDIB/VnpOtpiSVRdLIjsIbc/6GUJ4vcOz+6sieGoXT579iDdLsr4MKImF86GhiOqSSPjM2RyWLFS9AxqFX2EbcJ9X9KpfZkjLN97/QL0uTXkPKqQhMinbCne+F+is1CuBA4+tLr4d2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fRYib/kM; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761844959;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1yKUVg2QX7KLyptUjcVniVMmwZzulWf6rl33AVF5l/o=;
	b=fRYib/kMeIDOH90ZS1ch2yNi5D8QUkaH4tedw7Z/hSbGGXrRmdrIpZ8M9Y/J8qtzjFwMqj
	yOKKjjMwh9zn0bUKfvhmXdxn7jOOZaENuw1uvt38qHMAoafwoGb86QAtAWCbFkqIJfFVC+
	6SEitYt7Mlk0NycoOGJBAnM9Rn6cvbE=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Song Liu <song@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
  linux-kernel@vger.kernel.org,  Alexei Starovoitov <ast@kernel.org>,
  Suren Baghdasaryan <surenb@google.com>,  Michal Hocko
 <mhocko@kernel.org>,  Shakeel Butt <shakeel.butt@linux.dev>,  Johannes
 Weiner <hannes@cmpxchg.org>,  Andrii Nakryiko <andrii@kernel.org>,  JP
 Kobryn <inwardvessel@gmail.com>,  linux-mm@kvack.org,
  cgroups@vger.kernel.org,  bpf@vger.kernel.org,  Martin KaFai Lau
 <martin.lau@kernel.org>,  Kumar Kartikeya Dwivedi <memxor@gmail.com>,
  Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v2 02/23] bpf: initial support for attaching struct ops
 to cgroups
In-Reply-To: <CAHzjS_sLqPZFqsGXB+wVzRE=Z9sQ-ZFMjy8T__50D4z44yqctg@mail.gmail.com>
	(Song Liu's message of "Wed, 29 Oct 2025 11:01:00 -0700")
References: <20251027231727.472628-1-roman.gushchin@linux.dev>
	<20251027231727.472628-3-roman.gushchin@linux.dev>
	<CAHzjS_sLqPZFqsGXB+wVzRE=Z9sQ-ZFMjy8T__50D4z44yqctg@mail.gmail.com>
Date: Thu, 30 Oct 2025 10:22:31 -0700
Message-ID: <87zf98xq20.fsf@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Migadu-Flow: FLOW_OUT

Song Liu <song@kernel.org> writes:

> On Mon, Oct 27, 2025 at 4:17=E2=80=AFPM Roman Gushchin <roman.gushchin@li=
nux.dev> wrote:
> [...]
>>  struct bpf_struct_ops_value {
>>         struct bpf_struct_ops_common_value common;
>> @@ -1359,6 +1360,18 @@ int bpf_struct_ops_link_create(union bpf_attr *at=
tr)
>>         }
>>         bpf_link_init(&link->link, BPF_LINK_TYPE_STRUCT_OPS, &bpf_struct=
_ops_map_lops, NULL,
>>                       attr->link_create.attach_type);
>> +#ifdef CONFIG_CGROUPS
>> +       if (attr->link_create.cgroup.relative_fd) {
>> +               struct cgroup *cgrp;
>> +
>> +               cgrp =3D cgroup_get_from_fd(attr->link_create.cgroup.rel=
ative_fd);
>
> We should use "target_fd" here, not relative_fd.
>
> Also, 0 is a valid fd, so we cannot use target_fd =3D=3D 0 to attach to
> global memcg.

Yep, but then we need somehow signal there is a cgroup fd passed,
so that struct ops'es which are not attached to cgroups keep working
as previously. And we can't use link_create.attach_type.

Should I use link_create.flags? E.g. something like add new flag

@@ -1224,6 +1224,7 @@ enum bpf_perf_event_type {
 #define BPF_F_AFTER		(1U << 4)
 #define BPF_F_ID		(1U << 5)
 #define BPF_F_PREORDER		(1U << 6)
+#define BPF_F_CGROUP		(1U << 7)
 #define BPF_F_LINK		BPF_F_LINK /* 1 << 13 */
=20
 /* If BPF_F_STRICT_ALIGNMENT is used in BPF_PROG_LOAD command, the

and then do something like this:

int bpf_struct_ops_link_create(union bpf_attr *attr)
{
	<...>
	if (attr->link_create.flags & BPF_F_CGROUP) {
		struct cgroup *cgrp;

		cgrp =3D cgroup_get_from_fd(attr->link_create.target_fd);
		if (IS_ERR(cgrp)) {
			err =3D PTR_ERR(cgrp);
			goto err_out;
		}

		link->cgroup_id =3D cgroup_id(cgrp);
		cgroup_put(cgrp);
	}

Does it sound right?

Thanks

