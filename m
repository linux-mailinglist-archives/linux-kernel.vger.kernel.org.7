Return-Path: <linux-kernel+bounces-887503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B728EC3863D
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 00:43:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 78D834E6740
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 23:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B5972F60D5;
	Wed,  5 Nov 2025 23:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N3ixblNQ"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F552F5A06
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 23:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762386210; cv=none; b=Qlhaak2RJuGAoGGBktGIfkpL+4PC95TZp85RIEQ0IugRzdO/tuMPH+Ugo19R0yDXrKo4CorFLDlq4wnT3kRnDSh2klV2Gf4mS0VA/N5kfFG91Q8ccxJo8A42xpqIgrGw1q9YbbhcUDXwWikavt/220sEZKbSsl2OMmZBRuMtN/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762386210; c=relaxed/simple;
	bh=Ak0a/MofXeKeQ+l3St4/37wwo2EI1oYqy7US8b0zxnI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gv/CbudQ5tvxUiq+10moX5MGRHcccaEagrKeV7BKkd608ZpVzDoAe00evT4o+Hr4pVhZpVe2HuWbBWh5oPcNS6pI+z2UqkQbc3TptWRZyUicb4wSW8fxjNJ75DPYdHS0PtqQCXD7xevkchzYbkpJER/F9KJNa2bhRj3c/mWtLbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N3ixblNQ; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-429c7e438a8so327063f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 15:43:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762386207; x=1762991007; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IqjzYrKsdzYpWMG26lMkMc/ll/hhUuKrKyM2DREXhn8=;
        b=N3ixblNQvBxpfJ6LwigQOd6qlBzlThhsyTAAjhyiAU1g6RZQvrm1pXEtma51wD5dqH
         3VAuloJDwk3o0HuVegYYfokIC2/S+J+lZCvpe+iJ0V1YZ5xsiwN6SZKQDmR7qK6xaxiC
         KkOO2dD+Gg9rJl3872bVYN1dQLgArfal6b1pQQEMfUVuxOej4t6wR808ekACKRwJFwTk
         EJ90KVGfHGTG8YGtAt6yJz7QcplgoHsq4V3wJ1CqvREsJtrd97mTeeMGyKmRNoOQQoQw
         Rj7xa4bB1e7R+rkvd3FfSzAxJbDEVPfDzbsdN4WS/04+jMB/rZJuA0P5j+xJqOsbFu66
         pQzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762386207; x=1762991007;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IqjzYrKsdzYpWMG26lMkMc/ll/hhUuKrKyM2DREXhn8=;
        b=rrwnoIEKfIPPLVpVn3NlZBMUW0m8H/9Wcn6723y0vL3zFMbBZbezFoj+TxjbbHC5Sh
         cnCE4mzfTwVxa46xrSXY+ux4eBu//mzHWH7rQULC8/zAUpbqHwanTHqLyJHs7faPK0xX
         S1PqhEJ4vVSUxVfT+Sf4Y6lk0wirfBdJ04DENN6CrwRjZ/HT6Xo5iyFvr4nRkmYQqyAz
         Gzlkks4Ju2GOqfyjWNlWbc7jym59jAZU2bC/vurOZrBDIRhSSLmBwhBvFaFn2WVoxGcn
         Jkh3oVzTnzRT1SyxCC9T7nx260TiafVlMXxuW1/JfhVKKNHe3dWA1eqQA04MatjGcR60
         92Iw==
X-Forwarded-Encrypted: i=1; AJvYcCXqVOa2uR+7xC+Uch7DwQbOj9ICySeyAsvniwi6gdXMYRl7tEWRgD7wegy+K+IiRyZdMln+GKAUz1wwH1Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGml21o1Z2MAdGp5zigukQFeGrLxgyyyvd9PIlsxuT3amEs80Q
	uDQZT58gQmmsiZ3Dpjv+fM4/kcLLGqHmPVHKha4w6jtcYF2nIPMXd3fOdFLu5W37dnw1uJG7WaO
	I3qsswdeoNDzJckPjUnnaw4UgMjLrtWk=
X-Gm-Gg: ASbGncunzvQthco9tblh275D3x1bFHxtPDUK2l26sgsaK+aPl/6ILWG8JWeagBzWUww
	1JN7cxQOlXnP4CPqxQCUvMminzA8KLrdmXfirpRqJ5sjH68f9v5pDiNy7BnGM8PhmjGqEiCXRm4
	mI4yQ+7MYYN10tcPNmBH/uNiPweEwLGVoqXgQaZasd/sgDIjzzLtv855KdS1He/Jp+RJ0sP8MdX
	knBgvaAe+ue52LDq+CNiHXe3n5PRFVWXof829ew7kf0JM77Ju4xZoup7rjhPVI2vaBqWRCwFBjQ
	Q4wWM9aq/RRIVqBczA==
X-Google-Smtp-Source: AGHT+IHy2tfHNgJ6cQpCodGNfGYWTZ5F1i/eU0t3ocsIu6em6NiXgoAdtiWwWZT/GQIXmPMwErZiV6BOsWuGXGX8nJc=
X-Received: by 2002:a05:6000:230e:b0:429:d170:b3ac with SMTP id
 ffacd0b85a97d-429e32dd82cmr5292052f8f.13.1762386207144; Wed, 05 Nov 2025
 15:43:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251105201415.227144-1-hoyeon.lee@suse.com> <CAADnVQK7Qa5v=fkQtnx_A2OiXDDrWZAYY6qGi8ruVn_dOXmrUw@mail.gmail.com>
 <b3f13550169288578796548f12619e5e972c0636.camel@gmail.com>
 <CAADnVQJVYDbOCuJnf9jZWdFya7-PfFfPv2=d2M=75aA+VGGayg@mail.gmail.com> <8541c5bb758bc06e8c865aaa4f95456ac3238321.camel@gmail.com>
In-Reply-To: <8541c5bb758bc06e8c865aaa4f95456ac3238321.camel@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 5 Nov 2025 15:43:15 -0800
X-Gm-Features: AWmQ_bndYwW94kW--NSZQuJg-9ElD91TnXSYs-Z0mmovjayEfLI3uc8pkBOaK5I
Message-ID: <CAADnVQL91xsujXt4GWjgCYC+PdBC-2ZH6GqefXws_YHiL7B7Sg@mail.gmail.com>
Subject: Re: [bpf-next] selftests/bpf: refactor snprintf_btf test to use bpf_strncmp
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Hoyeon Lee <hoyeon.lee@suse.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, bpf <bpf@vger.kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 5, 2025 at 3:38=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com>=
 wrote:
>
> On Wed, 2025-11-05 at 15:33 -0800, Alexei Starovoitov wrote:
> > On Wed, Nov 5, 2025 at 2:52=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.=
com> wrote:
> > >
> > > On Wed, 2025-11-05 at 14:45 -0800, Alexei Starovoitov wrote:
> > > > On Wed, Nov 5, 2025 at 12:14=E2=80=AFPM Hoyeon Lee <hoyeon.lee@suse=
.com> wrote:
> > > > >
> > > > > The netif_receive_skb BPF program used in snprintf_btf test still=
 uses
> > > > > a custom __strncmp. This is unnecessary as the bpf_strncmp helper=
 is
> > > > > available and provides the same functionality.
> > > > >
> > > > > This commit refactors the test to use the bpf_strncmp helper, rem=
oving
> > > > > the redundant custom implementation.
> > > > >
> > > > > Signed-off-by: Hoyeon Lee <hoyeon.lee@suse.com>
> > > > > ---
> > > > >  .../selftests/bpf/progs/netif_receive_skb.c       | 15 +--------=
------
> > > > >  1 file changed, 1 insertion(+), 14 deletions(-)
> > > > >
> > > > > diff --git a/tools/testing/selftests/bpf/progs/netif_receive_skb.=
c b/tools/testing/selftests/bpf/progs/netif_receive_skb.c
> > > > > index 9e067dcbf607..186b8c82b9e6 100644
> > > > > --- a/tools/testing/selftests/bpf/progs/netif_receive_skb.c
> > > > > +++ b/tools/testing/selftests/bpf/progs/netif_receive_skb.c
> > > > > @@ -31,19 +31,6 @@ struct {
> > > > >         __type(value, char[STRSIZE]);
> > > > >  } strdata SEC(".maps");
> > > > >
> > > > > -static int __strncmp(const void *m1, const void *m2, size_t len)
> > > > > -{
> > > > > -       const unsigned char *s1 =3D m1;
> > > > > -       const unsigned char *s2 =3D m2;
> > > > > -       int i, delta =3D 0;
> > > > > -
> > > > > -       for (i =3D 0; i < len; i++) {
> > > > > -               delta =3D s1[i] - s2[i];
> > > > > -               if (delta || s1[i] =3D=3D 0 || s2[i] =3D=3D 0)
> > > > > -                       break;
> > > > > -       }
> > > > > -       return delta;
> > > > > -}
> > > > >
> > > > >  #if __has_builtin(__builtin_btf_type_id)
> > > > >  #define        TEST_BTF(_str, _type, _flags, _expected, ...)    =
               \
> > > > > @@ -69,7 +56,7 @@ static int __strncmp(const void *m1, const void=
 *m2, size_t len)
> > > > >                                        &_ptr, sizeof(_ptr), _hfla=
gs);   \
> > > > >                 if (ret)                                         =
       \
> > > > >                         break;                                   =
       \
> > > > > -               _cmp =3D __strncmp(_str, _expectedval, EXPECTED_S=
TRSIZE); \
> > > > > +               _cmp =3D bpf_strncmp(_str, EXPECTED_STRSIZE, _exp=
ectedval); \
> > > >
> > > > Though it's equivalent, the point of the test is to be heavy
> > > > for the verifier with open coded __strncmp().
> > > >
> > > > pw-bot: cr
> > >
> > > I double checked that before acking, the test was added as a part of =
[1].
> > > So it seems to be focused on bpf_snprintf_btf(), not on scalability.
> > > And it's not that heavy in terms of instructions budget:
> > >
> > > File                     Program                  Verdict  Insns  Sta=
tes
> > > -----------------------  -----------------------  -------  -----  ---=
---
> > > netif_receive_skb.bpf.o  trace_netif_receive_skb  success  18152     =
629
> >
> > Is this before or after?
> > What is the % decrease in insn_processed?
> > I'd like to better understand the impact of the change.
>
> That's before, after the change it is as follows:
>
> File                     Program                  Verdict  Insns  States
> -----------------------  -----------------------  -------  -----  ------
> netif_receive_skb.bpf.o  trace_netif_receive_skb  success   4353     235
> -----------------------  -----------------------  -------  -----  ------
>
> So, the overall impact is 18K -> 4K instructions processed.

It's large enough impact for the verifier.
I agree that the test was mainly focusing on testing
bpf_snprintf_btf(), but it has a nice side effect by testing
bounded loops too.
I prefer to keep it as-is.

