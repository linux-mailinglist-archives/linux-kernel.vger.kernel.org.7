Return-Path: <linux-kernel+bounces-775577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 089A3B2C0C6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 13:45:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48B4119612E3
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 11:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9408232BF51;
	Tue, 19 Aug 2025 11:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="gGsrdKZK"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23A9532275C
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 11:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755603675; cv=none; b=qEFEYwJdNQC3swPYWnSN/22b9Ck5dSXlNsKj5fRcy4rlDwXgc8uwLNQI1YK+KUAKvUmQRcSHuWy9in0lbBJd+rgc2xIjKdKfkhrDS3wlDY9RN3Dah8rVfsMVE1ZRHz6xqTaaXCASPAJnRW2taXGqVfJbh0n0lrHCQ6CHoh62mTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755603675; c=relaxed/simple;
	bh=VNMMvrCg1lsdLD1b2UbV0m4F3N3we7IQoNxCVi1o8sU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TFi+RF6eV1UhsvLJQUBLzWZyF9UHa1c0Irpdw0373sb3UiYQZHSz9CIkyYeOFsibENS49zhkwWH8/42/U90blNqcKrC32KRLG7dAqkF3cWu+/v47LeegIc3AlcEu7tGVzMowSQ07ZYH3YJUsaMyzSlVHu7RHOokJWOFUhrPE/Hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=gGsrdKZK; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-333f8d3be05so35797191fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 04:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1755603672; x=1756208472; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tuib0sswv+oZbbdQrooeXCEG/zbTBeXmUDDIjBMwhc4=;
        b=gGsrdKZKHihOd/DeJJN4DmdqRl7hSExSabD2MYSHdz4Lk8xkxPQqxljQfzUg0OzZ/P
         KnuUTICxXoUGm2l2lZY/yEm1/SQVYTw+vJTtfIYj9SjzlF/vsJP/HnNheQ5CuqQXRhXj
         CdDLOQD0+zyynn4G1zOeFYgt+1dy0YKtmoCcHSQMbk07tPHQ1kkGDI8OBsx5sUKS9TNi
         2SKFiDg7zr+hPvv+PLFuaNaD7uogN+WRHhZoVNTzcraKZ5n9uFYzk2rV7Z1sqccaNGMI
         ZJRZ5pDSYisu/EvY+tSuyBbwakqn8aYhxe0WfsJ6ZBcuOgAHEEsYSdKvm+EfrZFexIpF
         fVEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755603672; x=1756208472;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tuib0sswv+oZbbdQrooeXCEG/zbTBeXmUDDIjBMwhc4=;
        b=JkapbKZtVJQYadGrIbXBNA+20Hb46d/eHDx09tOFG/rl+OkCX3rN63tMjx+hj+n1ug
         F+JdXURzpMHHjfLIKBv3udz5RJXpF9DosERnRkxn2pFCno1s/ibL5vJG/oEROskBVArc
         dGhT/CUqMSEoWOqvBauVs6tUmqR58oP1oe5fm30+3cirmZ4eX5Eq85gmOOHFhfKaaDlf
         5w8E2zXFXaGaHPYPG++CyEa6lbCsNPmTLRdPD4XdeJi5zSHjSb3dGKFpJPkCmfsdGS8R
         YtyPEoEUKCfSu8+kCzum1qTwLhQR+6XsAzMrdRQ3LpcYgmWxVaT0E8kelBFe/qi2Cuz0
         FUtA==
X-Forwarded-Encrypted: i=1; AJvYcCUULXoJ3R7Su8Se/5TC/24Y2nV0rhn+vSpxa14GPQV8lUH2CBd4pKj6AB8tlFziPpOIdYmAqwsBZhofTKE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwO/jujt9EliP4Bu/4WsxQADtkK/dcYKjQ/pNSNXHYSHlBROC2
	QV/gRGYdbrVHf4odi3nDJ3yqHQQT4BhQJ9B9wc7e03FURFf8Q/9B7e/yW1pCKYel/Pzs/BijsSR
	gFnVyclvxy+MUIFYxkJzRGPJChKEBF2Gep6TV1WYsNw==
X-Gm-Gg: ASbGnctd7TP2109GiUam0TuuoYQzSqJ4zcBLjUOAmvzzIM3QlacBGr5T/6bKWuPQa5i
	M3QqqY8W0RJNy5z+ZxfbWLxUr5KlRjtM1cvLktkXmJZLatbdtuicDG6VzqjqTh3ceDGZ8K76geX
	KVQuCnFWnhlK//VF0bW7kpj1LK+dw/KWAVWv8ZDR8EjypymDuNsvL/OPINs3g84Ja/enQ4gZ2Di
	/c2uGbVnsqf1fBNucJ0HbqJqQ==
X-Google-Smtp-Source: AGHT+IGg10HeIEFBkgRlEcrjp/4T0XRDRw8xEDhjciR9L/zoe5JsrLo73GKK91+2b6uQCDMymTwKOwp13xMAHOXQleo=
X-Received: by 2002:a2e:a98f:0:b0:333:9b93:357f with SMTP id
 38308e7fff4ca-3353078bda5mr5810661fa.38.1755603672094; Tue, 19 Aug 2025
 04:41:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250813133812.926145-1-ethan.w.s.graham@gmail.com>
 <20250813133812.926145-7-ethan.w.s.graham@gmail.com> <CANpmjNMXnXf879XZc-skhbv17sjppwzr0VGYPrrWokCejfOT1A@mail.gmail.com>
 <CALrw=nFKv9ORN=w26UZB1qEi904DP1V5oqDsQv7mt8QGVhPW1A@mail.gmail.com>
 <20250815011744.GB1302@sol> <CALrw=nHcpDNwOV6ROGsXq8TtaPNGC4kGf_5YDTfVs2U1+wjRhg@mail.gmail.com>
 <CANpmjNOdq9iwuS9u6NhCrZ+AsM+_pAfZXZsTmpXMPacjRjV80g@mail.gmail.com>
In-Reply-To: <CANpmjNOdq9iwuS9u6NhCrZ+AsM+_pAfZXZsTmpXMPacjRjV80g@mail.gmail.com>
From: Ignat Korchagin <ignat@cloudflare.com>
Date: Tue, 19 Aug 2025 12:41:00 +0100
X-Gm-Features: Ac12FXy2y5KT1jl8o7nCrDwuS7gusbjmLZ1TSw-6nmPiK4uS84cdgeiBBwhyLx0
Message-ID: <CALrw=nGo5CfZseNwM88uqoTDwfmuD7BgXaijpCU-7qefx8+BZA@mail.gmail.com>
Subject: Re: [PATCH v1 RFC 6/6] crypto: implement KFuzzTest targets for PKCS7
 and RSA parsing
To: Marco Elver <elver@google.com>
Cc: Eric Biggers <ebiggers@kernel.org>, Ethan Graham <ethan.w.s.graham@gmail.com>, 
	ethangraham@google.com, glider@google.com, andreyknvl@gmail.com, 
	brendan.higgins@linux.dev, davidgow@google.com, dvyukov@google.com, 
	jannh@google.com, rmoar@google.com, shuah@kernel.org, tarasmadan@google.com, 
	kasan-dev@googlegroups.com, kunit-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	David Howells <dhowells@redhat.com>, Lukas Wunner <lukas@wunner.de>, 
	Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, 
	"open list:HARDWARE RANDOM NUMBER GENERATOR CORE" <linux-crypto@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 19, 2025 at 11:08=E2=80=AFAM Marco Elver <elver@google.com> wro=
te:
>
> On Fri, 15 Aug 2025 at 15:00, Ignat Korchagin <ignat@cloudflare.com> wrot=
e:
> >
> > On Fri, Aug 15, 2025 at 2:18=E2=80=AFAM Eric Biggers <ebiggers@kernel.o=
rg> wrote:
> > >
> > > On Thu, Aug 14, 2025 at 04:28:13PM +0100, Ignat Korchagin wrote:
> > > > Not sure if it has been mentioned elsewhere, but one thing I alread=
y
> > > > don't like about it is that these definitions "pollute" the actual
> > > > source files. Might not be such a big deal here, but kernel source
> > > > files for core subsystems tend to become quite large and complex
> > > > already, so not a great idea to make them even larger and harder to
> > > > follow with fuzz definitions.
> > > >
> > > > As far as I'm aware, for the same reason KUnit [1] is not that popu=
lar
> > > > (or at least less popular than other approaches, like selftests [2]=
).
> > > > Is it possible to make it that these definitions live in separate
> > > > files or even closer to selftests?
> > >
> > > That's not the impression I get.  KUnit suites are normally defined i=
n
> > > separate files, and KUnit seems to be increasing in popularity.
> >
> > Great! Either I was wrong from the start or it changed and I haven't
> > looked there recently.
> >
> > > KFuzzTest can use separate files too, it looks like?
> > >
> > > Would it make any sense for fuzz tests to be a special type of KUnit
> > > test, instead of a separate framework?
> >
> > I think so, if possible. There is always some hurdles adopting new
> > framework, but if it would be a new feature of an existing one (either
> > KUnit or selftests - whatever fits better semantically), the existing
> > users of that framework are more likely to pick it up.
>
> The dependency would be in name only (i.e. "branding"). Right now it's
> possible to use KFuzzTest without the KUnit dependency. So there is
> technical merit to decouple.

Probably strong (Kbuild) dependency is not what I was thinking about,
rather just semantical similarity. That is, if I "learned" KUnit -
KFuzzTest is easy to pick up for me.

> Would sufficient documentation, and perhaps suggesting separate files
> to be the canonical way of defining KFuzzTests, improve the situation?

Probably.

> For example something like:
> For subsystem foo.c, define a KFuzzTest in foo_kfuzz.c, and then in
> the Makfile add "obj-$(CONFIG_KFUZZTEST) +=3D foo_kfuzz.o".
> Alternatively, to test internal static functions, place the KFuzzTest
> harness in a file foo_kfuzz.h, and include at the bottom of foo.c.

Having includes at the bottom of the file feels weird and "leaks"
kfuzz tests into the sources. Perhaps we can somehow rely on the fact
that kernel is a flat address space and you can always get the address
of a symbol (even if static - similar to how eBPF kprobes do it)? Or
have a bit more complex Kbuild configuration: for example
"foo_kfuzz.c" would include "foo.c" (although including .c files also
feels weird). If CONFIG_KFUZZTEST is disabled, Kbuild just includes
"foo.o", if enabled we include "foo_kfuzz.o" (which includes foo.c as
a source).

Ignat

> Alex, Ethan, and KUnit folks: What's your preference?

