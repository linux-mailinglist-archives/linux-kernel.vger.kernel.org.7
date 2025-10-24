Return-Path: <linux-kernel+bounces-869247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EB560C07676
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 18:53:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CE4304E2E98
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 16:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4320D337B87;
	Fri, 24 Oct 2025 16:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="IiQWoUba"
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3084D86342
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 16:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761324814; cv=none; b=FO7VVQjZV5UNpLVeijRP3GWoWSUoE4u3CpaPUtuoMatlwOAdLlvK/QRpLoYBPM5W9AlSo/6OWZTLX2op2Z9uSJhcLyTgOHX7C3JQGwZRJkhPMHlPh6f0LQVyNCMjHvpmICnvP5l9f1g8NcfUmP1OpfLvzOpe2EMpSu93hi9FuaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761324814; c=relaxed/simple;
	bh=DKUBl7W3huP6cGlFMGyhKUp/w1FwXrlf10EUmzCMMJM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DqWnv4KI3ZFshfg8y52et7d9J9VKqNdYxkYSf/K0WBwJfaUgWXKM1sESSqB3ssftPFqE7cGnl01bF9+SO5i98yvKkXg5sub8k/Gd52spCm5dAaS4/3rXi3WL6kQiKPxBMD5e4oz6WZIWBCPSLAwtv5dRMLVsD+e/+vs3e4Z+uTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=IiQWoUba; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <790be7b7d3752f26f2c4e62476acb0bfe448df84.camel@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761324803;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DKUBl7W3huP6cGlFMGyhKUp/w1FwXrlf10EUmzCMMJM=;
	b=IiQWoUbaLCLRE1Fxcnvuj23EB6VGiXYVfLI7g8+U9IuTiXRLuifR0gljXTy+CKeLCo20vT
	ueXg5n8DPnwu6dVv5q9MfzaTLbr7OMmxK+5yrizvl+p+FCyPhQ7YrqNbvbRoFzeM8bnhYh
	M9CnJoBoSICitxeXjd/t2J7QCIbhPcs=
Subject: Re: [PATCH bpf-next 1/2] bpf: Skip bounds adjustment for
 conditional jumps on same register
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: KaFai Wan <kafai.wan@linux.dev>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, Yonghong Song
 <yonghong.song@linux.dev>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Song Liu <song@kernel.org>,  KP Singh
 <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo
 <haoluo@google.com>,  Jiri Olsa <jolsa@kernel.org>, Shuah Khan
 <shuah@kernel.org>, Paul Chaignon <paul.chaignon@gmail.com>,  Matan
 Shachnai <m.shachnai@gmail.com>, Luis Gerhorst <luis.gerhorst@fau.de>,
 colin.i.king@gmail.com,  Harishankar Vishwanathan
 <harishankar.vishwanathan@gmail.com>, bpf <bpf@vger.kernel.org>, LKML
 <linux-kernel@vger.kernel.org>,  "open list:KERNEL SELFTEST FRAMEWORK"
 <linux-kselftest@vger.kernel.org>, Kaiyan Mei <M202472210@hust.edu.cn>, 
 Yinhao Hu <dddddd@hust.edu.cn>
Date: Sat, 25 Oct 2025 00:53:00 +0800
In-Reply-To: <CAADnVQ+Tt4GkhV74P_bekvCWbZOBgR5PEYt7sQHEzMTDeE4j9w@mail.gmail.com>
References: <20251022164457.1203756-1-kafai.wan@linux.dev>
	 <20251022164457.1203756-2-kafai.wan@linux.dev>
	 <39af9321-fb9b-4cee-84f1-77248a375e85@linux.dev>
	 <1d03174dfe2a7eab1166596c85a6b586a660dffc.camel@gmail.com>
	 <CAADnVQKdMcOkkqNa3LbGWqsz9iHAODFSinokj6htbGi0N66h_Q@mail.gmail.com>
	 <abe1bd5def7494653d52425818815baa54a3628a.camel@gmail.com>
	 <0d267da41178f3ac4669621516888a06d6aa5665.camel@linux.dev>
	 <f0a52150bc99aa4da1a25d6181975cd3c80a717f.camel@gmail.com>
	 <b190c9b2837b28cf579aa38126de50e29e0add32.camel@linux.dev>
	 <0d98a2c754884e94c3367209680c071a8df4279d.camel@gmail.com>
	 <90ec497a230584b0e627d12eaf172236b7a5165b.camel@linux.dev>
	 <CAADnVQ+Tt4GkhV74P_bekvCWbZOBgR5PEYt7sQHEzMTDeE4j9w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Migadu-Flow: FLOW_OUT

On Fri, 2025-10-24 at 09:40 -0700, Alexei Starovoitov wrote:
> On Fri, Oct 24, 2025 at 9:38=E2=80=AFAM KaFai Wan <kafai.wan@linux.dev> w=
rote:
> >=20
> > On Fri, 2025-10-24 at 09:21 -0700, Eduard Zingerman wrote:
> > > On Sat, 2025-10-25 at 00:13 +0800, KaFai Wan wrote:
> > >=20
> > > [...]
> > >=20
> > > > For non-scalar cases we only allow pointer comparison on pkt_ptr, t=
his check is before
> > > > is_branch_taken()
> > > >=20
> > > > =C2=A0=C2=A0=C2=A0 src_reg =3D &regs[insn->src_reg];
> > > > =C2=A0=C2=A0=C2=A0 if (!(reg_is_pkt_pointer_any(dst_reg) && reg_is_=
pkt_pointer_any(src_reg)) &&
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 is_pointer_value(env, in=
sn->src_reg)) {
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
verbose(env, "R%d pointer comparison prohibited\n",
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 insn->src_reg);
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
return -EACCES;
> > > > =C2=A0=C2=A0=C2=A0 }
> > > >=20
> > > > and in the end of check_cond_jmp_op() (after is_branch_taken()), we=
 checked again
> > > >=20
> > > > =C2=A0=C2=A0=C2=A0 } else if (!try_match_pkt_pointers(insn, dst_reg=
, &regs[insn->src_reg],
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 this_branch, other_branch) &&
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 is_pointer_value(env, insn->dst_reg)) {
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
verbose(env, "R%d pointer comparison prohibited\n",
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 insn->dst_reg);
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
return -EACCES;
> > > > =C2=A0=C2=A0=C2=A0 }
> > > >=20
> > > > this time we check if it is valid comparison on pkt_ptr in try_matc=
h_pkt_pointers().
> > > >=20
> > > > Currently we just allow 4 opcode (BPF_JGT, BPF_JLT, BPF_JGE, BPF_JL=
E) on pkt_ptr, and with
> > > > conditions. But we bypass these prohibits in privileged mode (is_po=
inter_value() always
> > > > return false in privileged mode).
> > > >=20
> > > > So the logic skip these prohibits for pkt_ptr in unprivileged mode.
> > >=20
> > > Well, yes, but do you really need to do forbid `if r0 > r0 goto ...` =
in unpriv?
> >=20
> > Currently `if r0 > r0 goto ...` is forbid in unpriv, but we can allow i=
t.
>=20
> Let's not relax unpriv. We don't need new threads with researchers
> whether such things can be exploited.
>=20
Ok, I'll keep the logic for both scalar and non-scalar cases.

--=20
Thanks,
KaFai

