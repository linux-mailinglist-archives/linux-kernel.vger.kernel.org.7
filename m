Return-Path: <linux-kernel+bounces-724034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8551CAFEDC5
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 17:30:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E3D0580A54
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 15:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C08F2E8DE9;
	Wed,  9 Jul 2025 15:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="LOtOa/+5"
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 209912E8892
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 15:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752074980; cv=none; b=UYRyC6eyQmQYKl2SBxiTKw1kl9KBGbKziaJp4MZA5Io09ToyIE+LLcZhNZ1AvxSf2EFfe4Bp6ssujtHSupg2LeOqkeTlf8TdGeNmJNSatbo5BMQd+e8H5sBkEuYermM9cWX+qSYpmXIKixEM0CPCFCuHKGWbnhJmlIGoHT5FYYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752074980; c=relaxed/simple;
	bh=p8u1I+TwDnZvr0r3AL4vw+eoMhlu7STVgxRUoFgI2GU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PBEIZCNITUKIa7VmDqlz5Hooddgt2vHHmObWdJuGtJrV4kdlrhDeeDJFzbfvfVP+s2EKAlhTQ/JUTYLyXDbkX+Gkg1xby4iEEmSBgm/X5i6sYh0+N1FPYZPyXRPLxwEJpuBJcFTiTEwMCmg8ZyCqdP8DBWxvBExM3V5MtUB4XwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=LOtOa/+5; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-716ee8947cdso693287b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 08:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1752074978; x=1752679778; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qi9rgpEnLHZiafsUKLOufZyd7/6HZqWViU92Vja6Uog=;
        b=LOtOa/+5jQalS4WprVyD/D7ZtWnXDVRitYTzPWO8g9cHWF0lvePdNi/8503R092h9u
         /0YUzmWEwvxg/QWeFI8gkQyO/Mm91MVtPiEUrWv47tWCxLq5tm4BvD8cKJcPi2kByDv2
         6SPwTh1X4j7fARSI9Dx8mFZutxjtgiXj/3cb6RDTtBynA2zV/xmalQQewYeO4uykoNx+
         t1JGV1uVRVILLiVHqy++bzzewxxmUDX2V+FzxEbX0TQLajmQ6cL+7QCZ7j0/tmdWCLng
         Vkk4x/Mq2w8rX2oR7M16zKOagmjefPWZZBY7vzN64mZReLJvqABD+w+xMbjkClv4F7mg
         EKxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752074978; x=1752679778;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qi9rgpEnLHZiafsUKLOufZyd7/6HZqWViU92Vja6Uog=;
        b=XowfsCC8IxYcl/D/pMbA3Du/wRwZc4KTw1jw4SQ2bnBXzcfk0mmrd5D0VJY7J1plUj
         Jvax/QuNFnHdIcv9o3dLWcnIoBDBhbynNDQ2/+jYGaWtFqlgFgVlF0jGy10cjjgTYw+n
         jxBF1byK/b6/Kv9aO7sWfuT80mcsDxFnP9x5EX0FKZyBaFCXZN66yUenKIABFGWQOVMc
         QR1dkZTQ8z01mcJR10XoQQbzyuZgTNmloIXfIdRL9nonYxCwU4ZCNrhaw3aVJt+LluFn
         PP0q/P14oY2fpnafPchghWQgG8aQw7GmzoZAiKK1c1H2tGEes+ih2Gpc9VAJ92mWt+Qo
         n9yw==
X-Forwarded-Encrypted: i=1; AJvYcCVYSrgyvJ8OyFZxkTO07la2nAG3luwLQiLM1HPqB69ISiw9k/DgcHYHPNuVrbhrCkPE9q2pLUN+UUkGJN4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJc5TKBcgVy9Sa7flBoe+YmDXNsqYDPN211lbdxFMc/Sn4q9wS
	IezJY9N3pkWwv34oRM4zJSwX5BUzoR5tnZ9QcrBVDzcME274mmkbWrEl0qLXv4KDq4KqhblsM4J
	EI9Mb+Ib3HtJPQCkfRjGpTmxA8vvExf3jHTrfEheJUfAY3uHOa5u99A==
X-Gm-Gg: ASbGncssZ2MtpM3BbFUBaSEfFIqe0iZhOJqH5kZOBi20Dnb8rbOr9d0ksmbZuaoGKuU
	boPe16HZHAjp7mYgjCL3GOYkgQ2VtrWJuQ7HnAebwhZvvCAM7M/8tFi9f7gs4j/t5dsdwwn4JbK
	zePGzQdzl0xh1qcr5ETo/GrxAuwKvbsNCl1rhBD4wfz5U=
X-Google-Smtp-Source: AGHT+IEd2P6zJ3kWghatDD3PuttWYXbQstUnXrNxhPW9V/XABSJDX4cZ3tvH6hXpPKypZE3XGkQDfVX5HjrqG3b1m4k=
X-Received: by 2002:a05:690c:6d04:b0:70e:731f:d4c7 with SMTP id
 00721157ae682-717b1b00f7fmr39534977b3.8.1752074978213; Wed, 09 Jul 2025
 08:29:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240729180233.1114694-1-mic@digikod.net> <20241007.aek5Ohpahlai@digikod.net>
 <20250709.ZooYu6oasaiN@digikod.net>
In-Reply-To: <20250709.ZooYu6oasaiN@digikod.net>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 9 Jul 2025 11:29:27 -0400
X-Gm-Features: Ac12FXyFIPyY3gbGpyuEASo18cXUllnIboPZdeX6_Di8-I0tjzRR9-qOUQiFx04
Message-ID: <CAHC9VhSZ7bfyKvUxmN+0P-XSN-FC6CH44PTKB5nj5mS32vRNHg@mail.gmail.com>
Subject: Re: [PATCH] tools/certs: Make print-cert-tbs-hash.sh compatible with
 recent OpenSSL
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: David Howells <dhowells@redhat.com>, David Woodhouse <dwmw2@infradead.org>, keyrings@vger.kernel.org, 
	Eric Snowberg <eric.snowberg@oracle.com>, Jarkko Sakkinen <jarkko@kernel.org>, 
	Daniel Urbonas <t-durbonas@microsoft.com>, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 9, 2025 at 9:20=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <mic@digiko=
d.net> wrote:
>
> I can take it but I'd like an Acked-by please.

%  openssl -v
OpenSSL 3.5.1 1 Jul 2025 (Library: OpenSSL 3.5.1 1 Jul 2025)

With Linus' current tree:
% ./print-cert-tbs-hash.sh ./LVFS-CA.pem
Could not open file or uri for loading certificate from -: No such file or =
direc
tory
tbs:e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855

With the patch below:
% ./print-cert-tbs-hash.sh ./LVFS-CA.pem
tbs:b11d0663606508a8510b760d68acb599f1911726f7c06c01df4d122fce8b957b

Tested-by: Paul Moore <paul@paul-moore.com>

> On Mon, Oct 07, 2024 at 08:42:16PM +0200, Micka=C3=ABl Sala=C3=BCn wrote:
> > Could someone please take this patch?
> >
> > On Mon, Jul 29, 2024 at 08:02:32PM +0200, Micka=C3=ABl Sala=C3=BCn wrot=
e:
> > > Recent OpenSSL versions (2 or 3) broke the "x509" argument parsing by
> > > not handling "-in -" (unlike OpenSSL 1.1):
> > >   Could not open file or uri for loading certificate from -: No such
> > >   file or directory
> > >
> > > Avoid this issue and still make this script work with older versions =
of
> > > OpenSSL by using implicit arguments instead.
> > >
> > > To hopefully make it more future-proof, apply the same simplification=
s
> > > for other OpenSSL commands.
> > >
> > > Cc: David Howells <dhowells@redhat.com>
> > > Cc: David Woodhouse <dwmw2@infradead.org>
> > > Cc: Eric Snowberg <eric.snowberg@oracle.com>
> > > Cc: Jarkko Sakkinen <jarkko@kernel.org>
> > > Reported-by: Daniel Urbonas <t-durbonas@microsoft.com>
> > > Fixes: 58d416351e6d ("tools/certs: Add print-cert-tbs-hash.sh")
> > > Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
> > > ---
> > >  tools/certs/print-cert-tbs-hash.sh | 6 +++---
> > >  1 file changed, 3 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/tools/certs/print-cert-tbs-hash.sh b/tools/certs/print-c=
ert-tbs-hash.sh
> > > index c93df5387ec9..22bdeec4d286 100755
> > > --- a/tools/certs/print-cert-tbs-hash.sh
> > > +++ b/tools/certs/print-cert-tbs-hash.sh
> > > @@ -54,7 +54,7 @@ RANGE_AND_DIGEST_RE=3D'
> > >  '
> > >
> > >  RANGE_AND_DIGEST=3D($(echo "${PEM}" | \
> > > -   openssl asn1parse -in - | \
> > > +   openssl asn1parse | \
> > >     sed -n -e "${RANGE_AND_DIGEST_RE}"))
> > >
> > >  if [ "${#RANGE_AND_DIGEST[@]}" !=3D 3 ]; then
> > > @@ -85,7 +85,7 @@ if [ -z "${DIGEST_MATCH}" ]; then
> > >  fi
> > >
> > >  echo "${PEM}" | \
> > > -   openssl x509 -in - -outform DER | \
> > > +   openssl x509 -outform DER | \
> > >     dd "bs=3D1" "skip=3D${OFFSET}" "count=3D${END}" "status=3Dnone" |=
 \
> > > -   openssl dgst "-${DIGEST_MATCH}" - | \
> > > +   openssl dgst "-${DIGEST_MATCH}" | \
> > >     awk '{printf "tbs:" $2}'
> > > --
> > > 2.45.2

--=20
paul-moore.com

