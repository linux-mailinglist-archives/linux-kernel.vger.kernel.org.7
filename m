Return-Path: <linux-kernel+bounces-646787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF498AB608E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 May 2025 03:51:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E26B19E4F91
	for <lists+linux-kernel@lfdr.de>; Wed, 14 May 2025 01:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 992A11DB365;
	Wed, 14 May 2025 01:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XbSlhSLw"
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06DE328EC
	for <linux-kernel@vger.kernel.org>; Wed, 14 May 2025 01:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747187483; cv=none; b=Ob4M9FQhb4u+i++lS+dqv5oSUJMKHZAkTXeAZQkucwe95MLKVLxNp6rZW9VMSBshJZnzkA5mgLfaHl1/4PWgiZLk3zSSPzVyDGjhWC4N1RoJHks0sQjqT0XG7fFI/pgf8Eo0B3wn7D3T5dgcJtbQJanBfanytPNfx00pvH6rEAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747187483; c=relaxed/simple;
	bh=NrTHpkXDgyFKfDSv/Z8v98A//Ci/DfGTge4fOO8kAmA=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=Iun2+4dxi1Ca0i7MOFxBHX3CY74Pyivz9bmpzsIDvNu4ZK6h550S/MyrISPOghXoo0LI7jfRATdRBd5xW4BHkjpW++jr1UnJmYeFU/sxkKwfolcwzU4wEDsUxczFoeKF89EO/k3hPVTLuL3JitH/YQSCcvrgCktJIb9CC75E7Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XbSlhSLw; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1747187476;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eoIeoOMx+pE7UlqvUS9JFs32zgR6E1s6Ghwd2YuL0jw=;
	b=XbSlhSLwIKMVAIXFuMWiOVwjKAexZk/BH9jKR4riQ1+mZE1QnkLvH9gH5MP+cTKcyazuBp
	fXurpKDa/3iQiD+vqJqRypiw6fYKBd32BewswxvJi6efN0f8gMhT6E0y/ewLRA/Ye6H+Ou
	bOGKBmMjHyueH+IQzw6UwCEe33c0dMg=
Date: Wed, 14 May 2025 01:51:14 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Jiayuan Chen" <jiayuan.chen@linux.dev>
Message-ID: <4741dfb9fa4cf32cef28d9f2b7e7c2e788430800@linux.dev>
TLS-Required: No
Subject: Re: [PATCH bpf-next v1] bpftool: Add support for custom BTF path in
 prog load/loadall
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
Cc: "bpf" <bpf@vger.kernel.org>, "Quentin Monnet" <qmo@kernel.org>, "Alexei
 Starovoitov" <ast@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>,
 "Andrii Nakryiko" <andrii@kernel.org>, "Martin KaFai Lau"
 <martin.lau@linux.dev>, "Eduard Zingerman" <eddyz87@gmail.com>, "Song
 Liu" <song@kernel.org>, "Yonghong Song" <yonghong.song@linux.dev>, "John
 Fastabend" <john.fastabend@gmail.com>, "KP Singh" <kpsingh@kernel.org>,
 "Stanislav Fomichev" <sdf@fomichev.me>, "Hao Luo" <haoluo@google.com>,
 "Jiri Olsa" <jolsa@kernel.org>, "LKML" <linux-kernel@vger.kernel.org>
In-Reply-To: <CAADnVQJJ7pLsm0UTzPOj1H+rdaaY7Lv0As0Te-b+7zieQbntkw@mail.gmail.com>
References: <20250513035853.75820-1-jiayuan.chen@linux.dev>
 <CAADnVQJJ7pLsm0UTzPOj1H+rdaaY7Lv0As0Te-b+7zieQbntkw@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

2025/5/14 05:19, "Alexei Starovoitov" <alexei.starovoitov@gmail.com> wrot=
e:

>=20
>=20On Mon, May 12, 2025 at 8:59 PM Jiayuan Chen <jiayuan.chen@linux.dev>=
 wrote:
>=20
>=20>=20
>=20> This patch exposes the btf_custom_path feature to bpftool, allowing=
 users
> >=20
>=20>  to specify a custom BTF file when loading BPF programs using prog =
load or
> >=20
>=20>  prog loadall commands. This feature is already supported by libbpf=
, and
> >=20
>=20>  this patch makes it accessible through the bpftool command-line in=
terface.
> >=20
>=20>  Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> >=20
>=20>  ---
> >=20
>=20>  tools/bpf/bpftool/prog.c | 11 ++++++++++-
> >=20
>=20>  1 file changed, 10 insertions(+), 1 deletion(-)
> >=20
>=20>  diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
> >=20
>=20>  index f010295350be..63f84e765b34 100644
> >=20
>=20>  --- a/tools/bpf/bpftool/prog.c
> >=20
>=20>  +++ b/tools/bpf/bpftool/prog.c
> >=20
>=20>  @@ -1681,8 +1681,17 @@ static int load_with_options(int argc, char=
 **argv, bool first_prog_only)
> >=20
>=20>  } else if (is_prefix(*argv, "autoattach")) {
> >=20
>=20>  auto_attach =3D true;
> >=20
>=20>  NEXT_ARG();
> >=20
>=20>  + } else if (is_prefix(*argv, "custom_btf")) {
> >=20
>=20>  + NEXT_ARG();
> >=20
>=20>  +
> >=20
>=20>  + if (!REQ_ARGS(1))
> >=20
>=20>  + goto err_free_reuse_maps;
> >=20
>=20>  +
> >=20
>=20>  + open_opts.btf_custom_path =3D GET_ARG();
> >=20
>=20
> I don't see a use case yet.
>=20
>=20What exactly is the scenario where it's useful ?
>

This patch just exposes the btf_custom_path feature of libbpf to bpftool.
The argument 'btf_custom_path' in libbpf is used for those kernes that
don't have CONFIG_DEBUG_INFO_BTF enabled but still want to perform CO-RE
relocations. Specifically for older kernels, separate BTF files are alrea=
dy
provided: https://github.com/aquasecurity/btfhub-archive/.
If we want load prog using bpftool on those systems, we have to hack
btf__load_vmlinux_btf() before or write custom loader with libbpf and spe=
cify
'btf_custom_path'.

I also found a the similar topic:
https://lore.kernel.org/bpf/20220215225856.671072-1-mauricio@kinvolk.io/

Additionally, pwru supports "--kernel-btf" which serves the same purpose =
as
this patch.

Therefore, using an external BTF file is a common practice.

