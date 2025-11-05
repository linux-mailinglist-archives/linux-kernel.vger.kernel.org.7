Return-Path: <linux-kernel+bounces-887500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0420DC3861F
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 00:38:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8792D4EA576
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 23:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 905272F5A1C;
	Wed,  5 Nov 2025 23:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ts7QTdIw"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB951CAA6C
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 23:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762385883; cv=none; b=m4F4R7tDVDxWsUBuBR46jrTncFoAUmMHfueqvB5lekcMDR5zlwZYkMfgupBqn/Q6hShGQUjQAporybMPTA8Ah9eiX5pRg8jSX8y9/saSUq8SD2mTC45Ph7xDH2JmGJtZfPZBisMp8OSX/ky6kHtbjx4p4v4ZoDEd1hGIj/ppIdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762385883; c=relaxed/simple;
	bh=gddbQ+Itd7Ojfjtk5FdtrnY3uKmgUByG80qPQ8ZvjtI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Be32l/MHahZr90sePsnLBwrCMDWa1swg8pYlLhPbuy30Dbnu8lPwl0S3XvL/1WcnshCqJ7url4FQcaYfLgti/hgoWZXdPNnezDVrovw1HMSfD6G/nB2cLYqzYrSLXo6+0BZ+ZK2Z6eW5Uj+j6D4O++TZC/jRa3u9XjHrkLWWtOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ts7QTdIw; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3401314d845so557677a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 15:38:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762385882; x=1762990682; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9fVUkHQDwvPqUlHZQUDqXxahAxilIHdqJl6WVxMgWaU=;
        b=Ts7QTdIwxedzHjNtuBEutS8NMj3e0wM2n0iSMtVTksR7dN8sm42V1tkG3/v2KLJyYw
         Tv7oxmQ2DcPmWlre6lHfEA1bmsqf32R1mNM8jJ1DCblQnadH69dU5CJXXqrC+BJJq2Gc
         MZO3EAnDBap2597JRSgnA5rPEP/dRuAr0wrtt+JZWQ56d6fGHly5vDBVl7ORGyG0vLVP
         Quer3xi+3JB8s/qdnVnhJuoqC/HMuQ0qtmJif7ZuceC1mVJUTzaq3WHopKgAi63KQczw
         esegAGBRH22BWfY8t53ll8SAj/QXqhMrAapzaVH7WZQqi5Mlihb+n4tMVQaauiEeLz0J
         jrGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762385882; x=1762990682;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9fVUkHQDwvPqUlHZQUDqXxahAxilIHdqJl6WVxMgWaU=;
        b=qyVglJ/o8WfYY9nDzE2DPGsjX7Rh8yrtNGVTlhMCTaNxhQVlH4wF1Br74HfO5/MQJH
         AZVtzeo5M5ZHTciMyFztY7KdbjmAxdlgfV7PZ65EFbOVeNiJopFfbDeYZgSreb988+Cs
         Xn7Cm6O99VLCG7YCR50S1OqoA4lXE2JCfcu+aaWRtrw1XD2W6CKBF2q7Az/0AOHWdDdy
         2C2TU4VOonhsYvWDmbxZZuIL4qr2TBJR3068TQwUa9CPjyThWXuYaSocmkOmV8+dCAcA
         xE1bRaebGy58JgG8cav65vCwAgNd50IyDhG957J5Y9J2/nn+tzCTS1Q6hutiHY7+i0f1
         BaFg==
X-Forwarded-Encrypted: i=1; AJvYcCV6xHZv1AiOwXaEYooxpkhsbPgVZ3MJxdEtLuO4pJ8dwMkdQaMa6XiJxhVMPcaFiExcr+lZkUDkUEctP9A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgE7zc2E0WTlkVfz3+MrtHJeXDEBoD/SAwJbigjIqT6aT7y6P7
	Uln8yZsjy2OxGeiNtKR3msXZO1QqgJfhTkNEBFcn3jSnsLW5lTtiO1c8
X-Gm-Gg: ASbGncvRk38LufJk54Yy4baFroou9Adok7boXD3WxB3pqy+tTqdivlmb7+VDD4/V7NK
	I6H8+OMS2nsa++MkLtGN54CD44unEUD4D1R1GZBUwZep2e+qRv3vL7+6+NfEkwBnWzi0Sh897rD
	+kBPmywkKs6ky1vC/NwKXdpV9zdrf9Ea3B9Pg4ei2YIXkN7Hj2VsoAsBHupDCRbvw7JbJRy48zx
	eyHvXP9VEGCj5MkxXAwDu/o0y+FUx1m0L88DfR7Jqo7iC5LKVCkVL8eU0Lr6njYiQ/Zv2gXGD1W
	HzhjEcb10u+q45Y+37Om9jjZGLp/maoVuyWQdpSn39YzK50nt7a6ifN/HPqjjYyi4kbFJVEkhoC
	pS0SuC06r4nRf63qIODioS078pojNcUA1abt3v3RkYoH2AusqCBQE+3SWAEfmLkW4jZ56VthseO
	F6h2cjJ0ZQ84NtvG3Ihqau03Dj
X-Google-Smtp-Source: AGHT+IF5T6+DOCSnDpoLDg2pzh3olheTdfkjvm41AL9sLBEpMp4B3RXVO38qeeSA3u2FwUTtP18r/A==
X-Received: by 2002:a05:6a20:12c3:b0:331:e662:c97e with SMTP id adf61e73a8af0-34f85511aabmr6954608637.37.1762385881643;
        Wed, 05 Nov 2025 15:38:01 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:cdf2:29c1:f331:3e1? ([2620:10d:c090:500::6:8aee])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-341a68ad143sm4020376a91.3.2025.11.05.15.38.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 15:38:01 -0800 (PST)
Message-ID: <8541c5bb758bc06e8c865aaa4f95456ac3238321.camel@gmail.com>
Subject: Re: [bpf-next] selftests/bpf: refactor snprintf_btf test to use
 bpf_strncmp
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Hoyeon Lee <hoyeon.lee@suse.com>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, bpf <bpf@vger.kernel.org>, Andrii
 Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song
 Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,  John
 Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>,  Hao Luo <haoluo@google.com>, Jiri
 Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, "open list:KERNEL
 SELFTEST FRAMEWORK"	 <linux-kselftest@vger.kernel.org>, LKML
 <linux-kernel@vger.kernel.org>
Date: Wed, 05 Nov 2025 15:37:59 -0800
In-Reply-To: <CAADnVQJVYDbOCuJnf9jZWdFya7-PfFfPv2=d2M=75aA+VGGayg@mail.gmail.com>
References: <20251105201415.227144-1-hoyeon.lee@suse.com>
	 <CAADnVQK7Qa5v=fkQtnx_A2OiXDDrWZAYY6qGi8ruVn_dOXmrUw@mail.gmail.com>
	 <b3f13550169288578796548f12619e5e972c0636.camel@gmail.com>
	 <CAADnVQJVYDbOCuJnf9jZWdFya7-PfFfPv2=d2M=75aA+VGGayg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-11-05 at 15:33 -0800, Alexei Starovoitov wrote:
> On Wed, Nov 5, 2025 at 2:52=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
> >=20
> > On Wed, 2025-11-05 at 14:45 -0800, Alexei Starovoitov wrote:
> > > On Wed, Nov 5, 2025 at 12:14=E2=80=AFPM Hoyeon Lee <hoyeon.lee@suse.c=
om> wrote:
> > > >=20
> > > > The netif_receive_skb BPF program used in snprintf_btf test still u=
ses
> > > > a custom __strncmp. This is unnecessary as the bpf_strncmp helper i=
s
> > > > available and provides the same functionality.
> > > >=20
> > > > This commit refactors the test to use the bpf_strncmp helper, remov=
ing
> > > > the redundant custom implementation.
> > > >=20
> > > > Signed-off-by: Hoyeon Lee <hoyeon.lee@suse.com>
> > > > ---
> > > >  .../selftests/bpf/progs/netif_receive_skb.c       | 15 +----------=
----
> > > >  1 file changed, 1 insertion(+), 14 deletions(-)
> > > >=20
> > > > diff --git a/tools/testing/selftests/bpf/progs/netif_receive_skb.c =
b/tools/testing/selftests/bpf/progs/netif_receive_skb.c
> > > > index 9e067dcbf607..186b8c82b9e6 100644
> > > > --- a/tools/testing/selftests/bpf/progs/netif_receive_skb.c
> > > > +++ b/tools/testing/selftests/bpf/progs/netif_receive_skb.c
> > > > @@ -31,19 +31,6 @@ struct {
> > > >         __type(value, char[STRSIZE]);
> > > >  } strdata SEC(".maps");
> > > >=20
> > > > -static int __strncmp(const void *m1, const void *m2, size_t len)
> > > > -{
> > > > -       const unsigned char *s1 =3D m1;
> > > > -       const unsigned char *s2 =3D m2;
> > > > -       int i, delta =3D 0;
> > > > -
> > > > -       for (i =3D 0; i < len; i++) {
> > > > -               delta =3D s1[i] - s2[i];
> > > > -               if (delta || s1[i] =3D=3D 0 || s2[i] =3D=3D 0)
> > > > -                       break;
> > > > -       }
> > > > -       return delta;
> > > > -}
> > > >=20
> > > >  #if __has_builtin(__builtin_btf_type_id)
> > > >  #define        TEST_BTF(_str, _type, _flags, _expected, ...)      =
             \
> > > > @@ -69,7 +56,7 @@ static int __strncmp(const void *m1, const void *=
m2, size_t len)
> > > >                                        &_ptr, sizeof(_ptr), _hflags=
);   \
> > > >                 if (ret)                                           =
     \
> > > >                         break;                                     =
     \
> > > > -               _cmp =3D __strncmp(_str, _expectedval, EXPECTED_STR=
SIZE); \
> > > > +               _cmp =3D bpf_strncmp(_str, EXPECTED_STRSIZE, _expec=
tedval); \
> > >=20
> > > Though it's equivalent, the point of the test is to be heavy
> > > for the verifier with open coded __strncmp().
> > >=20
> > > pw-bot: cr
> >=20
> > I double checked that before acking, the test was added as a part of [1=
].
> > So it seems to be focused on bpf_snprintf_btf(), not on scalability.
> > And it's not that heavy in terms of instructions budget:
> >=20
> > File                     Program                  Verdict  Insns  State=
s
> > -----------------------  -----------------------  -------  -----  -----=
-
> > netif_receive_skb.bpf.o  trace_netif_receive_skb  success  18152     62=
9
>=20
> Is this before or after?
> What is the % decrease in insn_processed?
> I'd like to better understand the impact of the change.

That's before, after the change it is as follows:

File                     Program                  Verdict  Insns  States
-----------------------  -----------------------  -------  -----  ------
netif_receive_skb.bpf.o  trace_netif_receive_skb  success   4353     235
-----------------------  -----------------------  -------  -----  ------

So, the overall impact is 18K -> 4K instructions processed.

