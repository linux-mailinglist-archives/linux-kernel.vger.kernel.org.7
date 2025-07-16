Return-Path: <linux-kernel+bounces-733476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AB3E3B07529
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 13:56:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA4987B0969
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 11:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C16762F50AA;
	Wed, 16 Jul 2025 11:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kCV0QIWi"
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A802F49F2
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 11:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752666908; cv=none; b=g0YzkLY3fgmOtV6Uk7ppuLdHQx20WSKB6ivHCblTQRRQTLHE9r3yuUAIZkBB6MbA2iQw8Si+uyAcyiWI9TSJ85oKc5MjadCv942jTmNLKHqTRUgjwbBs+DAQN1p2QTokrKYIZhT1m0NhZ8qSi66D3bbvwkvNmc1bjnpN7JvGERU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752666908; c=relaxed/simple;
	bh=5MLzakPnK7x1wR/xUJvUAIyxiAo8Nz3QyiHKXJQC+ng=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QcoNBrUina7As1S3Eu7YsTzf5TZWJG2k8YWctdazBFc1Rge/m6+z/Al/0iD+r7omLG/DYzlpwFOB4ikPFaVaT4GXR5EH7B5yStfrafJzY9KiPimgw4BLRLjtL5vWk/RBl0ZvXqouFUGgRO2lGs3HJDEajni8CfHnh9TXVVcCXjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kCV0QIWi; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752666892;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5MLzakPnK7x1wR/xUJvUAIyxiAo8Nz3QyiHKXJQC+ng=;
	b=kCV0QIWi6mbXGDOyzDE1puMWGwAAhdSowsRx8oxSr0ZTZl/gfPGyM/3JBWm2lXrEc6kD6v
	EZidyBjcG5t3unZmTzNDO3ZwnKCaym38JNJuKTBooM/wgCiVO/QddpFF87PVKmmmsGunp1
	PaV20lPSwAhAmHDWYWJx7DyDw0dr7bE=
From: Menglong Dong <menglong.dong@linux.dev>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Menglong Dong <menglong8.dong@gmail.com>, alexei.starovoitov@gmail.com,
 rostedt@goodmis.org, jolsa@kernel.org, bpf@vger.kernel.org,
 Martin KaFai Lau <martin.lau@linux.dev>,
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH bpf-next v2 14/18] libbpf: add btf type hash lookup support
Date: Wed, 16 Jul 2025 19:53:50 +0800
Message-ID: <3339133.5fSG56mABF@7940hx>
In-Reply-To:
 <CAEf4BzZCPcq0eo=1SN-r=k5QF1XE5hihEYHYYdi37aiV7VXwVQ@mail.gmail.com>
References:
 <20250703121521.1874196-1-dongml2@chinatelecom.cn>
 <22e15dd2-8564-4e71-ab77-8b436870850d@linux.dev>
 <CAEf4BzZCPcq0eo=1SN-r=k5QF1XE5hihEYHYYdi37aiV7VXwVQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-Migadu-Flow: FLOW_OUT

On Wednesday, July 16, 2025 1:20 AM Andrii Nakryiko <andrii.nakryiko@gmail.=
com> write:
> On Mon, Jul 14, 2025 at 9:41=E2=80=AFPM Menglong Dong <menglong.dong@linu=
x.dev> wrote:
> >
> >
> > On 7/15/25 06:07, Andrii Nakryiko wrote:
> > > On Thu, Jul 3, 2025 at 5:22=E2=80=AFAM Menglong Dong <menglong8.dong@=
gmail.com> wrote:
> > >> For now, the libbpf find the btf type id by loop all the btf types a=
nd
> > >> compare its name, which is inefficient if we have many functions to
> > >> lookup.
> > >>
> > >> We add the "use_hash" to the function args of find_kernel_btf_id() to
> > >> indicate if we should lookup the btf type id by hash. The hash table=
 will
> > >> be initialized if it has not yet.
> > > Or we could build hashtable-based index outside of struct btf for a
> > > specific use case, because there is no one perfect hashtable-based
> > > indexing that can be done generically (e.g., just by name, or
> > > name+kind, or kind+name, or some more complicated lookup key) and
> > > cover all potential use cases. I'd prefer not to get into a problem of
> > > defining and building indexes and leave it to callers (even if the
> > > caller is other part of libbpf itself).
> >
> >
> > I think that works. We can define a global hash table in libbpf.c,
> > and add all the btf type to it. I'll redesign this part, and make it
> > separate with the btf.
>=20
> No global things, please. It can be held per-bpf_object, or even
> constructed on demand during attachment and then freed. No need for
> anything global.

Okay, the per-bpf_object is a good idea, and I'll try to implement
it this way.

Thanks!
Menglong Dong






