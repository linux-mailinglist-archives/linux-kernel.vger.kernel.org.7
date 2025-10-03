Return-Path: <linux-kernel+bounces-841862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BF9EABB86C4
	for <lists+linux-kernel@lfdr.de>; Sat, 04 Oct 2025 01:37:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C269B4E59DF
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 23:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAD7F2765DC;
	Fri,  3 Oct 2025 23:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CP+IkT7y"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D7C19DFA2
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 23:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759534657; cv=none; b=nS2FxjEUngcoOdvzDVmZC7uCymLxpuer0HTJof/F2Osd3Gv4r/QpJ9el3cA4DllByaXOB4giQCCFuwkl3ZIW0IIRC86xvwTHPSOuGccpAgerK3n/LhX8ctik4Tv5E2NKyFudt943WatLSxHSYuI0DyNC4MrJ6CXjpJ9KnC0zEw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759534657; c=relaxed/simple;
	bh=GNFmT2VxEaPkh32hnm7rrBTVz4auBq5soR9sb5kDJTs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RCWX8XXDP1FejQQhJ+CoBPJD4tPzPWsiX0capt9Cp+YKLw7Fb61EClcCnSjw2fcoRyE+gsB8kI933wdBWDhcJCIHAaUmeC5EELeP9htq7NgYE5u+rireZhYiryy/141TSuP2otiX++IxSyHnWVP6NPW2WtnNFKWvvL3H726SeVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CP+IkT7y; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-77f67ba775aso3871973b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 16:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759534655; x=1760139455; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8opnbw/m2Z8T5yDXIhCeyupu0RmNSEU/h2Gk1+QmiW8=;
        b=CP+IkT7yqUoHZoT7zCW/Gm9XneFhutzrzUrIVZiWwcnMJcBSJ3p1hDaj3yK2mQUl02
         KPW+98yOockhCm2MqcqDsFfSpOmX0Pb6HuI+xgECZSurqSCcQKNqgDn4YF07vAZhgiRj
         f/WephWzE1sBwEM25yu9BuGHOQAJqv1AVT7B3Q44rXFF8QFFCZOtFegmhBCehfn5EC0Z
         j3exu3bw4/ogRD/ICwExcXeJRsr9HnWI4C2cI7MfCEpN60IYwCm7xaEDan1ArbgOdo6p
         cT2xWKnJfsDbvmyDJDOEZbIZrlAEoMhVV/PWA7LrgHy+L3IKpxd4CJkvwJ9TbeQNlVvz
         E4jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759534655; x=1760139455;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8opnbw/m2Z8T5yDXIhCeyupu0RmNSEU/h2Gk1+QmiW8=;
        b=C1syl9/uC8gpGFndIsw2OimZ2xXmAAEQRIkhWteQlnzE/wWOS6kHya2NzlpqWH027+
         EbCg4Q1I5heqM3P3JOcl2X40hu0I8cgLUdYBRoc9Q66c8+03sDeZ1zQlvIKuEs/qBI9o
         MMMxzSM+9RPAsIS51lNRn3eLW535U0XUUF9C3Xpg9OXiLcBkqWIPX7MfFY8G1QqW7qAy
         uP/yn5TTml7hiYqkaZp1Zo+vY5kpD93+yRt4ST8Qax+8uYO9jPTInCbcc6P123lkD+kY
         h/XUnkT47w+NHCynnt8picfPeeBuAX+pwjdx4YW/dqZaSpG/cU/oFlaYdaV8ICACHCIq
         HzWQ==
X-Forwarded-Encrypted: i=1; AJvYcCXcS/vOIYx7LKYZv0hTyZixwwzbk3FfNLoPzGQ3XTylBoKCsnMbPPqcaYVj55A37f66ij0I73Z/t5kZPKY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+BTUE4l3FooTB+xQNkV3yteGtxhhVuM+qkP7B31jAMJ5RphYI
	rBXldVag5FuLvIQDUCQPgBpiBtCs95C2CE31qaiRtscA5lf8ME5Aba/k
X-Gm-Gg: ASbGncvRWRCDbS4QMeB43hrxdPTl+PfYFlJcpFwfO65/d9g/oA98vEz77wFR1SXlhI5
	sbsGBO83TPJiFJdYUioYMPbrkvzFnzbtDPuzCqlveKOVkKxLDWHSDlgEbrMCuS9zHyF9L0tscOK
	cG9UDPaa/TPyOjnIcK0GdY3tVKdAly4aLhXcZM3Ui1XLM5UIqZyZhWlasghBLB5InwnE2Hhh8sU
	CSA96U9eCMadXWrQfZH9nxkaaLgdoRAEFmGCFV20iqQ2ruriSoX9ETxkQP28GsrYnPSDKXABBjX
	Q7/QXWAREB7yVg2ZBDucNOOnf93vrTr3mvytRr6+QOrx2I7ZGmlp1m0a0CgIPsjGIDUBADK9hJO
	qqTCQoefmqALkvmy49JuRKISWAHzb5KI0AI8RrGfglgc2mzgnxyOUtbHGVZgPCigy4CZZXIFj
X-Google-Smtp-Source: AGHT+IHwNn3pqjoWotecuXY2Bk382T7KlekPldLWjd7xtyWnaXq++HkfhSeL9JeF/XIh23fgTqEc8A==
X-Received: by 2002:a05:6a00:22c4:b0:781:1b4c:75fb with SMTP id d2e1a72fcca58-78c98dd945emr5793503b3a.18.1759534654703;
        Fri, 03 Oct 2025 16:37:34 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:2a3b:74c8:31da:d808? ([2620:10d:c090:500::4:e149])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78b01f9ac7esm6083494b3a.7.2025.10.03.16.37.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 16:37:34 -0700 (PDT)
Message-ID: <d108d59be611a63c73303347d07fe0ba5f2b74b7.camel@gmail.com>
Subject: Re: [PATCH bpf] selftests/bpf: fix implicit-function-declaration
 errors
From: Eduard Zingerman <eddyz87@gmail.com>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, ihor.solodrai@linux.dev, 
	alan.maguire@oracle.com
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, Andrii Nakryiko	
 <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann	
 <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu	
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, John Fastabend	
 <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev	 <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>,  Shuah Khan <shuah@kernel.org>, Nathan Chancellor
 <nathan@kernel.org>, Nick Desaulniers	 <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>
Date: Fri, 03 Oct 2025 16:37:32 -0700
In-Reply-To: <20251003-bpf-sft-fix-build-err-6-18-v1-1-2a71170861ef@kernel.org>
References: 
	<20251003-bpf-sft-fix-build-err-6-18-v1-1-2a71170861ef@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-10-03 at 17:24 +0200, Matthieu Baerts (NGI0) wrote:
> When trying to build the latest BPF selftests, with a debug kernel
> config, Pahole 1.30 and CLang 20.1.8 (and GCC 15.2), I got these errors:
>=20
>   progs/dynptr_success.c:579:9: error: call to undeclared function 'bpf_d=
ynptr_slice'; ISO C99 and later do not support implicit function declaratio=
ns [-Wimplicit-function-declaration]
>     579 |         data =3D bpf_dynptr_slice(&ptr, 0, NULL, 1);
>         |                ^
>   progs/dynptr_success.c:579:9: note: did you mean 'bpf_dynptr_size'?
>   .virtme/build-debug-btf//tools/include/vmlinux.h:120280:14: note: 'bpf_=
dynptr_size' declared here
>    120280 | extern __u32 bpf_dynptr_size(const struct bpf_dynptr *p) __we=
ak __ksym;
>           |              ^
>   progs/dynptr_success.c:579:7: error: incompatible integer to pointer co=
nversion assigning to '__u64 *' (aka 'unsigned long long *') from 'int' [-W=
int-conversion]
>     579 |         data =3D bpf_dynptr_slice(&ptr, 0, NULL, 1);
>         |              ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   progs/dynptr_success.c:596:9: error: call to undeclared function 'bpf_d=
ynptr_slice'; ISO C99 and later do not support implicit function declaratio=
ns [-Wimplicit-function-declaration]
>     596 |         data =3D bpf_dynptr_slice(&ptr, 0, NULL, 10);
>         |                ^
>   progs/dynptr_success.c:596:7: error: incompatible integer to pointer co=
nversion assigning to 'char *' from 'int' [-Wint-conversion]
>     596 |         data =3D bpf_dynptr_slice(&ptr, 0, NULL, 10);
>         |              ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>=20
> I don't have these errors without the debug kernel config from
> kernel/configs/debug.config. With the debug kernel, bpf_dynptr_slice()
> is not declared in vmlinux.h. It is declared there without debug.config.
>=20
> The fix is similar to what is done in dynptr_fail.c which is also using
> bpf_dynptr_slice(): bpf_kfuncs.h is now included.
>=20
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---

I can reproduce similar issue when including
kernel/configs/debug.config with my regular dev config, but for
different functions: bpf_rcu_read_{un,}lock().

However, this is not a way to fix this.
Kfuncs are not supposed to just disappear from DWARF.

Running pahole in verbose mode I see the following output:

  $ pahole -V \
      --btf_features=3Dencode_force,var,float,enum64,decl_tag,type_tag,opti=
mized_func,consistent_func,decl_tag_kfuncs \
      --btf_features=3Dattributes \
      --lang_exclude=3Drust \
      --btf_encode_detached=3D/dev/null vmlinux
  ...
  matched function 'bpf_rcu_read_lock' with 'bpf_rcu_read_lock.cold'
  ...

Alan, Ihor, does this sound familiar?

