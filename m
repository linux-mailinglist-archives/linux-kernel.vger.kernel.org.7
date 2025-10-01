Return-Path: <linux-kernel+bounces-839367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 03D62BB17D3
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 20:29:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A56B8189E8C8
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 18:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20CBA2D4B6C;
	Wed,  1 Oct 2025 18:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P4fBgzKe"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D602D46D6
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 18:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759343357; cv=none; b=llAdmBBeXNkI5u1skplI4ZvmI0wnMigBioRFQ9Q78HMtRpKvUqle99/FBvhIFvJvmDrSmgYVWldacB6ieTcr0mq3fK8fmpuYglcwSukX41TEIdJOwIsqu1SlKMna7apVlKHsv0Rk5fTiEqdkPOWCIw5McRFV3rDQNk57BBkQ9uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759343357; c=relaxed/simple;
	bh=j7i885BUIYK7Ahlc3uZPZzWMjBsq8Olqhq31vSDIRD8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=u+MvtGYCO2eWLBgk0r9JWRJnayfQiB/+ufNbNXQhRlJjGr2rAySgrq36U8nfs7xoYC5q1WaEHavhP7it3IokGCZa0dj8vQM7iRTlzP8IfilHrwO9/xJndqOYgtGm5jajsb3SJni3Me9Zd410ReQz9NX0oUqgqMw22bNp7s7ydKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P4fBgzKe; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2698384978dso871295ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 11:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759343355; x=1759948155; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HEtC1ejd2zwXZpseILezgJtRXvznbkDw6KY3FPlPFuQ=;
        b=P4fBgzKeIy/VdwvKKVnT2rFMTG2sI+0vZv8byzpE2Nlm4KfbFMvEdzDwS3Y3gXElsW
         t2dZjvHlpbE7zTo+2HtcXxrO5fSCsaqrLzR2MvulYFvvu97OyjFlG2AUogsjB2MRzf2c
         ybWISMkpBchPUqgPjo6CluuF5SnBhvr1kTcYJR/0GjFDUUWpqCh4pwF2hl3GAGLsqO8c
         4sELJQA0bJl1DnU/mtdp2UP/OzuM1NfumRDDKsCEpUce8Bkiz34FaZ6Bg4BZcuoDkZRa
         t9ysR66PXp8R3GsIcPpdN8MxVfbv5caP3aU6sDiRAcm8YLv5IeyuQ9t8f/HQPQ5LXt+Q
         65aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759343355; x=1759948155;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HEtC1ejd2zwXZpseILezgJtRXvznbkDw6KY3FPlPFuQ=;
        b=cLIOlMYAbQ1Uv7ZHW170Arq5558wucF9q+5H1x5R+lBvgkz4GCjT1A7+LN5GBv1KOW
         Oix8oZFnxoknf6EhFvde2Af0HyvqNNqVrN5d3Uj/J9+Z53Sc+VK6SOmq5lPNuComzS2o
         HanqRJRc2W+jBQF81IfqTcIfQP20o5FWU53eLLqzwZZVTcBAfRHVvAzsQJtUMYHsMsLo
         5PBOjcdvTGG3jI6ycc84DdgrjCfl3qwtqV2XwdZyEDxwUdZkRO7yR1/lZbekSvHr8sEw
         nP1SLhBtKQPaOsLl/iz2qY35X4/jt0hdPnmj6OBcWGH0n6IFxTE/CFaZk4ZBaO574NiE
         vGUg==
X-Forwarded-Encrypted: i=1; AJvYcCWX71d4UWSx2DmYbrr9E1L2JBYqF/JviVwFT/tC0EsKizVP9BDVhjUOKSZi4T2XL6oUIlJDqr0IlYzVsGQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz02R0bZActBJ1ufWniGuE8+FsQ3DrU3BeqpiA/21/1M5u90MrR
	LzG+SDWfvG1Djdg4MMekI5+/ixAwsW2cZ41t3mYSSEZCrJFOlilUpebX
X-Gm-Gg: ASbGncuvb/l20X02Q3/hf65+C8+tdAtHqYVGCYo/1DZrTJnFfNKUCfLOy0IRI1X5GuC
	JNjWKScbimCPnc72pfP880FznC9TJ2w6TokVTXV9vC83U8Wji1GnMIEaOOa/zLSEo1dItEfVOqe
	szOudVZSAKMU1FFud4EH5Fhi6Zr1SSjFeA7DvnfI4raDlJoX06fqDqjgnovh3waf0CRx5QesBJH
	mTPGwqMB9b7N5TZINtHk16FhG6dF5gmnt3l/a2Jebd2kjVm6KQi9E4gnb81Id3nMhw/dpOfvxx/
	GHoQOsG3WYCn2kYgGmVmwP5TncuwqB/YyduulFxJfGPuJJvgViJ08xWUDVnenTb4ujVPqNWMAMn
	jGOzUkhoM/tm2KNi6M68ofriZid51dzm20rsadO0g8aeLagt/b3JRVrvZIAGPxU00Mz/R+M4=
X-Google-Smtp-Source: AGHT+IHjxc98EvLLxYgVX6wj7cWG6MWtoknxN7328kax/JQPcMwe8LPQoQKsk4jid+pgrkSFmrGKDg==
X-Received: by 2002:a17:903:234c:b0:249:44b5:d5b6 with SMTP id d9443c01a7336-28e7f443f91mr50983455ad.40.1759343355315;
        Wed, 01 Oct 2025 11:29:15 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:1ed4:e17:bedc:abbb? ([2620:10d:c090:500::6:420a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d1d31bdsm2670855ad.94.2025.10.01.11.29.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 11:29:14 -0700 (PDT)
Message-ID: <0a2232a7faa9077ba7a837e066bd99bab812e4a6.camel@gmail.com>
Subject: Re: [PATCH v3 1/2] bpf: Skip scalar adjustment for BPF_NEG if dst
 is a pointer
From: Eduard Zingerman <eddyz87@gmail.com>
To: Brahmajit Das <listout@listout.xyz>, 
	syzbot+d36d5ae81e1b0a53ef58@syzkaller.appspotmail.com
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
 daniel@iogearbox.net, 	haoluo@google.com, john.fastabend@gmail.com,
 jolsa@kernel.org, kpsingh@kernel.org, 	linux-kernel@vger.kernel.org,
 martin.lau@linux.dev, sdf@fomichev.me, 	song@kernel.org,
 syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev, 
	kafai.wan@linux.dev
Date: Wed, 01 Oct 2025 11:29:12 -0700
In-Reply-To: <20251001095613.267475-2-listout@listout.xyz>
References: <68d26227.a70a0220.1b52b.02a4.GAE@google.com>
	 <20251001095613.267475-1-listout@listout.xyz>
	 <20251001095613.267475-2-listout@listout.xyz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-10-01 at 15:26 +0530, Brahmajit Das wrote:
> In check_alu_op(), the verifier currently calls check_reg_arg() and
> adjust_scalar_min_max_vals() unconditionally for BPF_NEG operations.
> However, if the destination register holds a pointer, these scalar
> adjustments are unnecessary and potentially incorrect.
>=20
> This patch adds a check to skip the adjustment logic when the destination
> register contains a pointer.
>=20
> Reported-by: syzbot+d36d5ae81e1b0a53ef58@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3Dd36d5ae81e1b0a53ef58
> Fixes: aced132599b3 ("bpf: Add range tracking for BPF_NEG")
> Suggested-by: KaFai Wan <kafai.wan@linux.dev>
> Signed-off-by: Brahmajit Das <listout@listout.xyz>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

>  kernel/bpf/verifier.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index e892df386eed..4b0924c38657 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -15645,7 +15645,8 @@ static int check_alu_op(struct bpf_verifier_env *=
env, struct bpf_insn *insn)
>  		}
> =20
>  		/* check dest operand */
> -		if (opcode =3D=3D BPF_NEG) {
> +		if (opcode =3D=3D BPF_NEG &&
> +		    !__is_pointer_value(false, &regs[insn->dst_reg])) {

Nit: I'd made this a bit simpler: `regs[insn->dst_reg].type =3D=3D SCALAR_V=
ALUE`,
     instead of __is_pointer_value() call.

>  			err =3D check_reg_arg(env, insn->dst_reg, DST_OP_NO_MARK);
>  			err =3D err ?: adjust_scalar_min_max_vals(env, insn,
>  							 &regs[insn->dst_reg],

