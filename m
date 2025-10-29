Return-Path: <linux-kernel+bounces-877099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AE65C1D31C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 21:27:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7986F1888BAB
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 20:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B98D035BDCD;
	Wed, 29 Oct 2025 20:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uDvBTjFN"
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70EFA35BDBA
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 20:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761769632; cv=none; b=aP//3cu4GZyMqhk2UFE6J0KyaTaDdddOjdNJeKi8W8NWYrzfoYxkqrg+iHfx6yqgg8BHXNYj6MKQNPzaDJZe3qAFCPlGxA4IkBo3nQm4yUM+9LQTZolxjSjOrzBRyA7O/nkG5UdRwaZwCiPQ3nD8QwfTqM3oo5Bc65fftOf+nKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761769632; c=relaxed/simple;
	bh=+Pc7w3IAtNlTyP1zbbSyl8Dgv7qPtTj68AwRg9Qnoeo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Z93fCbbtRlJoJDU7o94muqXwXmNSSjjwh2WmaHbOJ8CnfbJ4yVPcueT+51RIPGa+c6GNkYhqNM3YgO5AkgYa5NmTdE1QcZQu8qOEHEVginp9ELLwY6NDPB7x2ta4wofDsoDL1Qoglm/UsHM3FZjPIraX06uFGPmyXdDRpFl9MwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uDvBTjFN; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761769626;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L5vmLW+oATPFNaWdtHY1yVME8el6pZeETE8QCtK8TCA=;
	b=uDvBTjFNloStyK5QFb/yoXxdR2x9MXtvvx+VlwjlfcjJkJJCF/u4jP8Z1O8uvzIJVQei7i
	DLMoZGz0HxN1qz2OYh0rxnJZijSp4ZzRT5ISRcNxuFsImqMhMXzbscUzEIQ+vEupnezkGS
	jrYIMHJUDg0Es/IWmxMEqmpTQ0M5jVI=
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
Date: Wed, 29 Oct 2025 13:26:59 -0700
Message-ID: <87cy65e9nw.fsf@linux.dev>
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

Ok, thanks!

>
> Also, 0 is a valid fd, so we cannot use target_fd =3D=3D 0 to attach to
> global memcg.

Yep, switching to using root_memcg's fd instead.

Thanks!

