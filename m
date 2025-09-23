Return-Path: <linux-kernel+bounces-828709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C969B9540C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 11:30:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7A0914E1D5F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 09:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46A51313295;
	Tue, 23 Sep 2025 09:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cRBV2JyJ"
Received: from mail-yb1-f195.google.com (mail-yb1-f195.google.com [209.85.219.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46AC822ACEB
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 09:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758619826; cv=none; b=hcyihl5/8GZN0TmlBiE66TNR/G1rzz2/KfuuXxklcfhRHRC8Y0xkVInAVNuKsRzO+x0PzstyXUV71bZEQCGugris5mYN0sVBF14boi0Ch6kzYO8ClWMtQYThqqu9RcMdxsWmung4pJj1ijbiCxiNGASB+qj2W9z5WEs4ATIqwAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758619826; c=relaxed/simple;
	bh=LKMkqYRs5oKuE6YZh/sJ95NDmetgm/PvSx2UxGirKIE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SwGOJm9Qc/MKh0xKKhmUVnaLocMEGl3D0NF79lJqTcPEnCy7s+/n8L2ayD3WsekDzeOBuvzeM6iaryvzJM3c319NEf3nkSCPTaVDF1Ta14tZleUYwKpE7OeEZEZ0yScAHvLZEGXGt22NMUfjfzSN4yXtoAcJen0PM87rJ7vn96A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cRBV2JyJ; arc=none smtp.client-ip=209.85.219.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f195.google.com with SMTP id 3f1490d57ef6-eb3671a7db4so287574276.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 02:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758619824; x=1759224624; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NcHqzSr7+1u/Qh2ljI8pw/83Ihm75UvV5W9PNWXiB6M=;
        b=cRBV2JyJ24kBX5fcn08mtDhUcoFQJ0dfJNd/uuFDYv91gPyVGVTUbdg9+eUukLGJWZ
         CtW9d1UXisEU3XqpQJzgjPcdEgjgPwVLMKlS6vphI5S7yZpPj3jKnT6JM8NvH+8Zymf9
         6ZoX6xABoGK41mZCoGaQgU0FJNDxh9h0g5OZpxykVHEsHuaZ92ekCGpbgJkDXNkIKDad
         2nDVrhQPnoIFO2FruQv+LdtIi27uU+egAOiGKiswt1O7eJmuOG1H8manVbVsw0W4byy+
         1AzCxXaCnScy+++L0DBp+oj99E+TtL6FybuBxKmgVp807s+OOTcCaj58bWqx81CFX5bj
         hEEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758619824; x=1759224624;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NcHqzSr7+1u/Qh2ljI8pw/83Ihm75UvV5W9PNWXiB6M=;
        b=tUq3jf/s0IhmKRpp1ZxOjb5PDXylF0VgDzSIWUMobA8cRkB7bm5KFCvBcyJ1t8cGU0
         UP6wk1M+QtXc3DpgZ+Mi2gjbNBuAjv9YEQgwBdq/fh4sCFcmzQdcVUS5w0C30z2MmLft
         PEN3EsWzFWIWjrjBGSmX29uV4XJVeWmo9Ch9URL2a/2pLgthjYO52OiJ/YWuq+2kAIgw
         uwsitfJqfsshzqK2A2HT32vciWcwSYBksWx/QZNOvmxdGpPRwC6UCNY46KPVk2SrrskB
         J5pccLzJriTrQ8miirMhJDbiGLj6KVWpc8nYWFV6gE3CbHCzWCE+qkLO2pwnWZ+Mu+nE
         DWjA==
X-Forwarded-Encrypted: i=1; AJvYcCWZn1T0r1e65MQdnPD4PJHiGyOynqAEt8iDOU8F9JwScDj6sEhwvhGeXBS+6bjZMajG0P3aMWwxqKNteps=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8xX0ZTdn+4RvsHal4/8WDA+7QBCJC71TVsqsi0MvLyFI2V9N7
	ANHVmTI6ElpWhEds2l693kzdCF6PzIztYqlhw8KhPEUleCnJjFZpALok9UT2PK+zt0tKjKv+A+e
	hTazhK9Vji6TOvNw/3dOqceTryhtRR+s=
X-Gm-Gg: ASbGnctvrxY0RR0G2ViyxlQbEQ3cIcf0ysR8nbQPwdBK8mPIl7Xs2VbyeGKzT6uJDjJ
	Ks2Q7IwSf/fGLc+xF+mOOpB6B87IGGBDA2t1JTUwJ1boNgwbtZ45do5NMiWW+cygmDEfu0aAmQM
	YGSHeo1iTjZSON5CbfZ/xSA5EO2JwkUks9q6I/ko423sOdo01Ly2KqAa6yqGnmabi0UPCCNtitt
	NGW9mA=
X-Google-Smtp-Source: AGHT+IEpeDeuEqQGLXjrM0BwMCnbNEzmEaZuDZ3jW+GAeAMxDzM45uFfdnNHqqnY09+sCgEmTN26dMoqQO7lXxlt+8o=
X-Received: by 2002:a05:6902:846:b0:ea3:bfe8:d03e with SMTP id
 3f1490d57ef6-eb33a6c602cmr1233861276.20.1758619824172; Tue, 23 Sep 2025
 02:30:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250923060614.539789-1-dongml2@chinatelecom.cn> <aNI_-QHAzwrED-iX@gondor.apana.org.au>
In-Reply-To: <aNI_-QHAzwrED-iX@gondor.apana.org.au>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Tue, 23 Sep 2025 17:30:13 +0800
X-Gm-Features: AS18NWAyWAy_AE2pAiCc7Hz3of5UzftwpXm2I6gPoVUtddSIY5tEuOVAaliaOpU
Message-ID: <CADxym3YMX063-9S7ZgdMH9PPjmRXj9WG0sesn_och5G+js-P9A@mail.gmail.com>
Subject: Re: [PATCH] rhashtable: add likely() to __rht_ptr()
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: tgraf@suug.ch, linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Neil Brown <neil@brown.name>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 23, 2025 at 2:36=E2=80=AFPM Herbert Xu <herbert@gondor.apana.or=
g.au> wrote:
>
> Menglong Dong <menglong8.dong@gmail.com> wrote:
> > In the fast path, the value of "p" in __rht_ptr() should be valid.
> > Therefore, wrap it with a "likely". The performance increasing is tiny,
> > but it's still worth to do it.
> >
> > Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> > ---
> > include/linux/rhashtable.h | 5 +++--
> > 1 file changed, 3 insertions(+), 2 deletions(-)
>
> It's not obvious that rht_ptr would be non-NULL.  It depends on the
> work load.  For example, if you're doing a lookup where most keys
> are non-existent then it would most likely be NULL.

Yeah, I see. In my case, the usage of the rhashtable will be:
add -> lookup, and rht_ptr is alway non-NULL. You are right,
it can be NULL in other situations, and it's not a good idea to
use likely() here ;)

Thanks!
Menglong Dong

>
> Cheers,
> --
> Email: Herbert Xu <herbert@gondor.apana.org.au>
> Home Page: http://gondor.apana.org.au/~herbert/
> PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

