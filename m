Return-Path: <linux-kernel+bounces-830988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 184B7B9B15A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 19:38:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2DB14E10C1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 17:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 949C73164B1;
	Wed, 24 Sep 2025 17:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="v27TYE90"
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A68B27877B
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 17:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758735527; cv=none; b=l1NyAZRup5pEMqQePgKjZ6AHTKgNiqD9Bmu1H7CjMEkO8nRFhhfZdxf1t0qMD5MIe+93nCcbLydsA5Rxm0P+ojC6dTAA5V77hsdx36R8P/UW33WqHfxnaEeliZBC9wTYmUyvzAN52kjxudPiGUgH4qX3zuvRNpNgc0B048UIG68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758735527; c=relaxed/simple;
	bh=HwkuRjZyF8nc3aG2oZgz+kqLSp8LzUr5e3REkcJOgYo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RF8rKhZJSdMGL9L/Ru7Km7zAMCatgsDlFJfuerDx4wWmU9/m9mmgNdb27QkrHPRCOby6vXLr+9NF2OJeMH3P9bQabwGPYITlyNTs1VdulJsvidE1FeUcZ+5UnuDPOIMtGoDaYmH8eGwnnRF7/SnUlr4CDif8wL4Jo6otZY/rA3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=v27TYE90; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <9051652cf548271da9c349758cbd70aaa3cee444.camel@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758735513;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=spBZPmwRqI9EmFUq7zimsqIiesNFqWfB0isv5A1f+aU=;
	b=v27TYE90miPWCb/2v1Qrg+R1bVZTJI04x6XwBigPNcwlXqqmUCYoazNBrP17EEuu4p2neN
	5R4NFGFsXk2MtGXkF9zOTvTmnIJ6DP6Y+YYPPyJtVuSjMLVnD54O7AnsbTWoIYknz8+PM/
	46zyYQNg+4s2SxW4jwXgK8QW39HeJA4=
Subject: Re: [PATCH v2] bpf: fix NULL pointer dereference in
 print_reg_state()
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: KaFai Wan <kafai.wan@linux.dev>
To: Brahmajit Das <listout@listout.xyz>, Alexei Starovoitov
	 <alexei.starovoitov@gmail.com>
Cc: syzbot+d36d5ae81e1b0a53ef58@syzkaller.appspotmail.com, Andrii Nakryiko
 <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, bpf
 <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Eduard
 <eddyz87@gmail.com>, Hao Luo <haoluo@google.com>, John Fastabend
 <john.fastabend@gmail.com>, Jiri Olsa <jolsa@kernel.org>, KP Singh
 <kpsingh@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Stanislav Fomichev <sdf@fomichev.me>, Song Liu
 <song@kernel.org>, syzkaller-bugs <syzkaller-bugs@googlegroups.com>, 
 Yonghong Song <yonghong.song@linux.dev>
Date: Thu, 25 Sep 2025 01:38:22 +0800
In-Reply-To: <qj5y7pjdx2f5alp7sfx2gepfylkk2bytiyeoiapyp3dpzwloyk@aljz7o77tt3m>
References: <68d26227.a70a0220.1b52b.02a4.GAE@google.com>
	 <20250923174738.1713751-1-listout@listout.xyz>
	 <CAADnVQ+SkF2jL6NZLTF7ZKwNOfOtpMqr0ubjXpF1K0+EkHdJHw@mail.gmail.com>
	 <qj5y7pjdx2f5alp7sfx2gepfylkk2bytiyeoiapyp3dpzwloyk@aljz7o77tt3m>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Migadu-Flow: FLOW_OUT

On Wed, 2025-09-24 at 21:10 +0530, Brahmajit Das wrote:
> On 24.09.2025 09:32, Alexei Starovoitov wrote:
> > On Wed, Sep 24, 2025 at 1:43=E2=80=AFAM Brahmajit Das <listout@listout.=
xyz>
> > wrote:
> > >=20
> > > Syzkaller reported a general protection fault due to a NULL
> > > pointer
> > > dereference in print_reg_state() when accessing reg->map_ptr
> > > without
> > > checking if it is NULL.
> > >=20
> ...snip...
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (type_is_map_ptr(t)) {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (type_is_map_ptr(t) && reg->=
map_ptr) {
> >=20
> > You ignored earlier feedback.
> > Fix the root cause, not the symptom.
> >=20
> > pw-bot: cr
>=20
> I'm not sure if I'm headed the write direction but it seems like in
> check_alu_op, we are calling adjust_scalar_min_max_vals when we get
> an
> BPF_NEG as opcode. Which has a call to __mark_reg_known when opcode
> is
> BPF_NEG. And __mark_reg_known clears map_ptr with
>=20
> 	/* Clear off and union(map_ptr, range) */
> 	memset(((u8 *)reg) + sizeof(reg->type), 0,
> 	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 offsetof(struct bpf_reg_state, var_=
off) - sizeof(reg-
> >type));
>=20

I think you are right. The following code can reproduce the error.

	asm volatile ("					\
	r0 =3D %[map_hash_48b] ll;			\
	r0 =3D -r0;					\
	exit;						\
"	:
	: __imm_addr(map_hash_48b)
	: __clobber_all);


BPF_NEG calls __mark_reg_known(dst_reg, 0) which clears the 'off' and
'union(map_ptr, range)' of dst_reg, but keeps the 'type', which is
CONST_PTR_TO_MAP.

Perhaps we can only allow the SCALAR_VALUE type to run BPF_NEG as an
opcode, while for other types same as the before BPF_NEG.

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index e892df386eed..dbf9f1efc6e7 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -15346,13 +15346,15 @@ static bool
is_safe_to_compute_dst_reg_range(struct bpf_insn *insn,
 	switch (BPF_OP(insn->code)) {
 	case BPF_ADD:
 	case BPF_SUB:
-	case BPF_NEG:
 	case BPF_AND:
 	case BPF_XOR:
 	case BPF_OR:
 	case BPF_MUL:
 		return true;
=20
+	case BPF_NEG:
+		return base_type(src_reg->type) =3D=3D SCALAR_VALUE;
+


--=20
Thanks,
KaFai

