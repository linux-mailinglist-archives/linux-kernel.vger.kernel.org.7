Return-Path: <linux-kernel+bounces-858524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A68FBEB0EE
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 19:22:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C255B4266A3
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 17:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A857B305E27;
	Fri, 17 Oct 2025 17:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gvUPL0lk"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0D42459D9
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 17:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760721635; cv=none; b=YpVb2xdi1/nrEg/t1zIQSIBmCiM4Ujccs1YFvcvH4FMPt7Z3nhMWnw7Y6TEVyHnGIrv6F9ZoVezscW+6W2dtaL75TTVllLsPt5kYD+7uZJ3f9F3hJ9e09TcL0kpvtg2f0TOXDtkWYCnlBEpt2Y+5WVPPyjTO++OBpyq1WOmTl5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760721635; c=relaxed/simple;
	bh=38APfVEhFgNJQtC9xpMbjPblo+/ZvzMJts2TmLGPnqQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K/PZpgIOL4mLjXnJ0iHCpYJssFe3agRoGxk9sqlUNEPpj4wWDAwtmcJEy9OQYj1vsASPpSz3DxCfOWTBNvUFANsHUJNj30Gf8qHI8U1ViSwIFR432YxIhpcJYZ9dxi3GpOifwaszAaj2rC5ESicM2DCRtx4dKWvZ/M3phz0LeNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gvUPL0lk; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4711b95226dso8842045e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 10:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760721631; x=1761326431; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C/JD7ilbWdKJoamFy6d75aFxBhIfji9qRkffcEQrmBU=;
        b=gvUPL0lk/NvHvpE8x7UOfu8GlhAaaST4bwUur3dkiRWejrdVneqm0wp/+n/fPuMGrA
         G0juNVYALj0wUXShOGB37mJGbO6bZcGJni7m/ykbSU/brrDC0vqZwPtclgb+dMDRjusR
         UnICjLJBAkx826qI4LBIvWgjKFB0Q2aO/DXt+/o7K0opKoEXH+//Cgy2Dv/iuXXsj5vW
         gO9rKp4nhQKYWDegY/RskwvfruPne2ZZqcBAV7DXfqtOic7Or8TbSJoClu3oiI/cNdH4
         5MeumGtOlBtCo8qf0xWyj2iNB2Xb+yqZ5wJUpf7vTH809vkwsPe11btWo/rlGMA114YK
         VqOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760721631; x=1761326431;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C/JD7ilbWdKJoamFy6d75aFxBhIfji9qRkffcEQrmBU=;
        b=kZMYh680z6FTF5mmdhDhHTNdbvxfUVkGTMeTFGFKPzT11/t53f17yhjdV/oxlTdwgY
         dMOgAaCO4FbCt11mKNrwqLdJ18Dv3/A/rb1tighxHh6JLZMEFQzh5NkizMh/nuM3wdze
         5r9ikrhPEerJ7HRECOspBBwFqAlfOfIvK6wn89egcTTxk0/ewKwoS6vPu3DP5mQwKPuo
         JS08Etnvv6oumzsPP9KShhpgDCXTcIXSWJ3nDMny4fDcuG2JfbH4dlyCyIh6cG06WmNo
         JxpZdhe7wnLqw0GAxrbE2ZugIX63n+wP3t5stYWzTzTnRaDbTXNhkWBm/5FRO2M54VOF
         5yeg==
X-Forwarded-Encrypted: i=1; AJvYcCXNANZhAfi8t8L0UuHsY8wXs8VYSaz7L9TKbZkRy9Mpyr6P+0bdjd2raUQBTCsO1JLmsaZ/09dUIf5z+Rk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyayRA3jwI4PELeGuhYR3dTLcT0PQSP6lMOmWJJBc5iRuVwjV4S
	y9UYQS3h7H25s1sxnnpYJyU0gB482DODPZ2JvmimygeE6RefNYL0/AfqN3ROK6aQEAUqEm12FGX
	CUYhnqw3NnnZvv2EwGK9ZzEMYTnCTuO/wncyc
X-Gm-Gg: ASbGncv5ty9HtRLyMwAWLNR8Wz7SVgrmyQ5SjodrwmwlFZa80TTnpu8/dD2MWYIHTvs
	scIX7Nkb33B/Br8tToMJDkDuAhGzydRQR8vOLvi+NGs0hjU2yGAkorOUTRPOyGK43wzEqpNqFqG
	kUiMSf5EhuAg+UYjs3GQ9MNNL6JVJia1QMQXT+ZUY99bWDsPrJL1xnun2SQisNrtXoVcsm7fuFG
	MkYfdLnV0ZfFXqqFFPwmMOgsUJqIyTXrrTGsBMOhchrNq1unBsumRiwXVUV2cQbwB69Lr9Lsrtn
	g1dDt1AJoaVoLYhX8w==
X-Google-Smtp-Source: AGHT+IEXnCgwKH7gRsD5Y2TmkOK7NQ6/uJOgBWUykyzj5DkPpJxyOTNB5lyxbsY6LrB21TGx/14+ltRy9ugNfwT4Rv8=
X-Received: by 2002:a05:6000:4381:b0:406:87ba:997c with SMTP id
 ffacd0b85a97d-42704d9a02cmr3211524f8f.40.1760721630408; Fri, 17 Oct 2025
 10:20:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251017092156.27270-1-yangtiezhu@loongson.cn>
In-Reply-To: <20251017092156.27270-1-yangtiezhu@loongson.cn>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 17 Oct 2025 10:20:19 -0700
X-Gm-Features: AS18NWCGzBAbgYmrodlFlBvWORKj7llNgBsdnucr7BBrFvE8KwSmhxURQJ8Hhkc
Message-ID: <CAADnVQJjSNEuX=HJKrD=pefC4C9dQk2aqP+hnRscUEDTntVXyA@mail.gmail.com>
Subject: Re: [PATCH bpf v1] selftests/bpf: Fix set but not used errors
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 17, 2025 at 2:35=E2=80=AFAM Tiezhu Yang <yangtiezhu@loongson.cn=
> wrote:
>
> There are some set but not used errors under tools/testing/selftests/bpf
> when compiling with the latest upstream mainline GCC, add the compiler
> attribute __maybe_unused for the variables that may be used to fix the
> errors, compile tested only.
>
> Cc: stable@vger.kernel.org
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>  tools/testing/selftests/bpf/map_tests/lpm_trie_map_basic_ops.c | 3 ++-
>  tools/testing/selftests/bpf/prog_tests/bpf_cookie.c            | 3 ++-
>  tools/testing/selftests/bpf/prog_tests/find_vma.c              | 3 ++-
>  tools/testing/selftests/bpf/prog_tests/perf_branches.c         | 3 ++-
>  tools/testing/selftests/bpf/prog_tests/perf_link.c             | 3 ++-
>  tools/testing/selftests/bpf/test_maps.h                        | 1 +
>  tools/testing/selftests/bpf/test_progs.h                       | 1 +
>  7 files changed, 12 insertions(+), 5 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/map_tests/lpm_trie_map_basic_ops=
.c b/tools/testing/selftests/bpf/map_tests/lpm_trie_map_basic_ops.c
> index d32e4edac930..2b8edf996126 100644
> --- a/tools/testing/selftests/bpf/map_tests/lpm_trie_map_basic_ops.c
> +++ b/tools/testing/selftests/bpf/map_tests/lpm_trie_map_basic_ops.c
> @@ -226,7 +226,8 @@ static void test_lpm_order(void)
>  static void test_lpm_map(int keysize)
>  {
>         LIBBPF_OPTS(bpf_map_create_opts, opts, .map_flags =3D BPF_F_NO_PR=
EALLOC);
> -       volatile size_t n_matches, n_matches_after_delete;
> +       /* To avoid a -Wunused-but-set-variable warning. */
> +       __maybe_unused volatile size_t n_matches, n_matches_after_delete;

I think it's better to disable the warning instead of hacking the tests.
Arguably it's a grey zone whether n_matches++ qualifies as a "use".
It's certainly not a nop, since it's a volatile variable.

pw-bot: cr

