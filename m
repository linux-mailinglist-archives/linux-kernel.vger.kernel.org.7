Return-Path: <linux-kernel+bounces-887445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21794C38443
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 23:53:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5A2218873C0
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 22:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A36352D5944;
	Wed,  5 Nov 2025 22:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N8bBTb0S"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CDD2242D79
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 22:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762383142; cv=none; b=axDn5PuPsnsxykRjrxXvrX9Qq1q/ZlTwF0uOMJnzx4WPYdnDXEt7savO4w4zn+R25RI5s1y7y4AGwYZrpXB0J/jumD3mI9J/mNGnZ0mxx1q1iObwbhcJHmAfQlmyCVfVu/A5NNqQCJjV7ujLrtthey7dQAFeF/brCV6oXcij0L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762383142; c=relaxed/simple;
	bh=l5JUzmodHo5k0pjByQaXoLIRkMflBv6P4mXMmvNQqLg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BWxHSCMXsUmlE3z2Ems7PbUDC8i30FKk7mjDWmvgVQ1arQA7RUWsdC2m4wxycxddQoRwbhVPGryQHv06hlWFt+8Kh9asJ6VzMvi/VCcJ8c88SyPERvHTrFLj5gPvdbeqtVaFmnt0/ckKlIfj6+Vbw7d4w52VfsnFJQujzP4+xVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N8bBTb0S; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2952048eb88so4536765ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 14:52:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762383140; x=1762987940; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1FJexW1JYx6DxuL3q/fhfUe6qlvpO4i0LqL1JMZwwtI=;
        b=N8bBTb0Szaaveb3zDVpKbBvHNVCGRJ0xJ2t5we6HPGE5IHv0PkzZrfLNhHT8OxJ3e7
         qB6DYyKeK1rfqTMjtA7I8sYMoBK/o0NgTshTJ85wLgz+Gw9T2Cy9qX5OoRuiJBl45B7p
         PiEAqVLDqKw8GkaUDX1mGJl1Uo0yQoHrucbZI/jYViEUnCPCKYL7xzs89s1D6hDm+GUA
         YlDcYzGJ3E0PV2cVqKSXu4STvQ/hrefVaO6meEoovcAcF/xCa4v7/Zp5bUfTVDbryDDH
         wXsj1nXU4hM4QTm+LXsudA6SDqj/+nNUmV3V0S5gWc/xRLoGhSZM7nfVlAoFMTv7OdZi
         YDpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762383140; x=1762987940;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1FJexW1JYx6DxuL3q/fhfUe6qlvpO4i0LqL1JMZwwtI=;
        b=b1LT3XXmXD6nWdx4MQiRXGuZ2sjG2poFpKa+z4qWLCOcrJ5NXSbNCQ6MCIoOqlmTCt
         9YG2mG9i8MA/xvM4WXKnAzK6r2fFmpFs4StLNGE7LpcBtj4NIoE9Tw8hTGlfyJ4vfUs1
         f3uSHJkv18uYmXTp+mrhPcyogt/FMCp+EO6+zD4vExGp0ma8g90EtkmI62H+UqJmW7Ei
         aA1nBtfsP7se/+BZn+ydPNlc4akIvgrRZzyhQx2wAgZv/LoOWDVEKx57Xp0QX3b/knBh
         oW6+3tbg7rqP3XiQynvqrVdgT8XiElCZ+f7GZ4i9BL53HzDTjjOw9ndG7IFKVaidtu/L
         UL1Q==
X-Forwarded-Encrypted: i=1; AJvYcCXHfN86Ub15BYzkrst2wvTLtAfEJVkgdkqeNlTw/G3VqMPhGAjKb09QQZx5qtvsT9x4E3SoOMm/lZklaL0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzo9rt0RUr248jtbulWpB6Wk9K1pPLa1wAi0jkCPg0+j0quITVr
	WG1RTLmGLWu/rbJXH0uJvo8w/+PwB5tWJArcqTciklTWNmDWJokNFpao
X-Gm-Gg: ASbGnctSXozfcUMLmr7AHiWoHeEtJUsHbPmNQrszIJjSYX+Kc11crSDd7aF5g9eMdu0
	ycdgA7UWCmzY5GkjltTJDLx3EbxYDyQq+Tyb/p+w176hh0qegG+fGf7P7DiGAuyvJrhJ+rCD/qF
	hbENG2uEel+S0/IOajVN9AXWtqgmXGpMlbmiAS67cRtiDHoQBelAMDmO4yZklRz1sPYQlfhLbYK
	3o46tAnHUjTtPiB6v3jbLxwuSNpYr07E41zqnpLEAPBkzR57UdgC2aKJQEF+Tnyrc0H1PjYuXXd
	YGGkUCYvmDBDN6MdniYlVONe4RcSvNNiFekg0fJYo5N52h8hSpBfF5n+UUk5LzNnIfbX06RdCtI
	8wCMR4G+dTc9wjp2D3VXbhfzS/SfswFZI767zzarKXMU4MkCDiLN0D4huEDZIkdUfxhDQKqc5VD
	WG5Tm0S47Yj990XdlwQkpp+GS60h2TfSkWTdE=
X-Google-Smtp-Source: AGHT+IFFcgx9KXj+jLf79Pju5kq5jwAVtbDiZ7dkTm0x2E6aEFwhvXO7JjhTU0TeYTFMldVIg3jsGQ==
X-Received: by 2002:a17:902:cecd:b0:269:91b2:e9d6 with SMTP id d9443c01a7336-2962adb61b9mr78252305ad.46.1762383139845;
        Wed, 05 Nov 2025 14:52:19 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:cdf2:29c1:f331:3e1? ([2620:10d:c090:500::6:8aee])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ba902c9d0d4sm346296a12.36.2025.11.05.14.52.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 14:52:19 -0800 (PST)
Message-ID: <b3f13550169288578796548f12619e5e972c0636.camel@gmail.com>
Subject: Re: [bpf-next] selftests/bpf: refactor snprintf_btf test to use
 bpf_strncmp
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Hoyeon Lee
	 <hoyeon.lee@suse.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>,  bpf <bpf@vger.kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>, Martin KaFai Lau	 <martin.lau@linux.dev>, Song Liu
 <song@kernel.org>, Yonghong Song	 <yonghong.song@linux.dev>, John Fastabend
 <john.fastabend@gmail.com>, KP Singh	 <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@fomichev.me>, Hao Luo	 <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,  "open list:KERNEL
 SELFTEST FRAMEWORK"	 <linux-kselftest@vger.kernel.org>, LKML
 <linux-kernel@vger.kernel.org>
Date: Wed, 05 Nov 2025 14:52:18 -0800
In-Reply-To: <CAADnVQK7Qa5v=fkQtnx_A2OiXDDrWZAYY6qGi8ruVn_dOXmrUw@mail.gmail.com>
References: <20251105201415.227144-1-hoyeon.lee@suse.com>
	 <CAADnVQK7Qa5v=fkQtnx_A2OiXDDrWZAYY6qGi8ruVn_dOXmrUw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-11-05 at 14:45 -0800, Alexei Starovoitov wrote:
> On Wed, Nov 5, 2025 at 12:14=E2=80=AFPM Hoyeon Lee <hoyeon.lee@suse.com> =
wrote:
> >=20
> > The netif_receive_skb BPF program used in snprintf_btf test still uses
> > a custom __strncmp. This is unnecessary as the bpf_strncmp helper is
> > available and provides the same functionality.
> >=20
> > This commit refactors the test to use the bpf_strncmp helper, removing
> > the redundant custom implementation.
> >=20
> > Signed-off-by: Hoyeon Lee <hoyeon.lee@suse.com>
> > ---
> >  .../selftests/bpf/progs/netif_receive_skb.c       | 15 +--------------
> >  1 file changed, 1 insertion(+), 14 deletions(-)
> >=20
> > diff --git a/tools/testing/selftests/bpf/progs/netif_receive_skb.c b/to=
ols/testing/selftests/bpf/progs/netif_receive_skb.c
> > index 9e067dcbf607..186b8c82b9e6 100644
> > --- a/tools/testing/selftests/bpf/progs/netif_receive_skb.c
> > +++ b/tools/testing/selftests/bpf/progs/netif_receive_skb.c
> > @@ -31,19 +31,6 @@ struct {
> >         __type(value, char[STRSIZE]);
> >  } strdata SEC(".maps");
> >=20
> > -static int __strncmp(const void *m1, const void *m2, size_t len)
> > -{
> > -       const unsigned char *s1 =3D m1;
> > -       const unsigned char *s2 =3D m2;
> > -       int i, delta =3D 0;
> > -
> > -       for (i =3D 0; i < len; i++) {
> > -               delta =3D s1[i] - s2[i];
> > -               if (delta || s1[i] =3D=3D 0 || s2[i] =3D=3D 0)
> > -                       break;
> > -       }
> > -       return delta;
> > -}
> >=20
> >  #if __has_builtin(__builtin_btf_type_id)
> >  #define        TEST_BTF(_str, _type, _flags, _expected, ...)          =
         \
> > @@ -69,7 +56,7 @@ static int __strncmp(const void *m1, const void *m2, =
size_t len)
> >                                        &_ptr, sizeof(_ptr), _hflags);  =
 \
> >                 if (ret)                                               =
 \
> >                         break;                                         =
 \
> > -               _cmp =3D __strncmp(_str, _expectedval, EXPECTED_STRSIZE=
); \
> > +               _cmp =3D bpf_strncmp(_str, EXPECTED_STRSIZE, _expectedv=
al); \
>=20
> Though it's equivalent, the point of the test is to be heavy
> for the verifier with open coded __strncmp().
>=20
> pw-bot: cr

I double checked that before acking, the test was added as a part of [1].
So it seems to be focused on bpf_snprintf_btf(), not on scalability.
And it's not that heavy in terms of instructions budget:

File                     Program                  Verdict  Insns  States
-----------------------  -----------------------  -------  -----  ------
netif_receive_skb.bpf.o  trace_netif_receive_skb  success  18152     629


[1] https://lore.kernel.org/bpf/1601292670-1616-5-git-send-email-alan.magui=
re@oracle.com/

