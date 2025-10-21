Return-Path: <linux-kernel+bounces-862134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BE85BF4814
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 05:27:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 297E518A3F95
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 03:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9175E1DFE26;
	Tue, 21 Oct 2025 03:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OqBhMHay"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867922144C7
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 03:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761017213; cv=none; b=S9ISqtSnsrsJTIJzkWJ2ls/gE6Qh7hyVTyKAVUDv43FGc7U7YXqcGStVUeBjJjBkhH6GtZKWsGv29QLeldNJ5/ol9p1wmtLg+zEKImpeZxJjEBS/NNhmZWHKRPTqrMu/aLbpiHLwoXcCpjiHWyNk8/fKXVPbvz8H1p2+scNMFbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761017213; c=relaxed/simple;
	bh=uzrryI5nfJW+NDG28lBIggEvFX9TuFesMs/Ip3MR298=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iyrqsT3x32L2RtHqdoosym/fiLFUVHpAtScEZQmb2GfAKXy8XSmJsO9ucc8ECY3DEoBtCxh8ckbaidpj0RYMbmN8eKtzcOHIKns7JZGcHoFYty8ALWcX15MAm5BdrPPisy6gI5XSvBhImyes3/wPeLC9eltYy5mao1dhInDOhUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OqBhMHay; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b6a225b7e9eso3632616a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 20:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761017211; x=1761622011; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cjMD9UBOTdj1a9ZbO71TQudDiK1jemaaZMb7foM6kDw=;
        b=OqBhMHayIhhL4rc0KbFjAnF8pN5LhV1A9QXjOBPxMjtN2L/x+9Wm55eG32ESlpCgb3
         NpaHWIlNdPrP/iKvdEXENhC/kCT/70ZBoxVuw0P0c7b7F/CQxgJ41ZyKD4dM8Rq5rxV+
         nudXnubOhRGFr8JnRLAYG/VhJY8wT5ILaarH3yDoZpr9/5NV9RklSMjgv3h9UfqpdbaM
         8t1znmtks+WDE0+VgIZzZ8D+3DXTqhvXooUzzgLPMcQ4VJhlsSZFmEDSgAd/nFrlqoGw
         3H4mdjq6RM1ZC8LBleBv5NbaHvH22byIHIJ2UH1d+rfkF6g/ik3npb+NHMhOL90ivbCF
         UQiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761017211; x=1761622011;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cjMD9UBOTdj1a9ZbO71TQudDiK1jemaaZMb7foM6kDw=;
        b=PwbfDoE7ZdDSfDviELtUubfkPveBon6SpSQQ3fd6kJ9G+Uoc5H7Y5PlGXehsEXxOad
         WTDcbfR9qpLZQxcHEXDGKIgCG8jGeXY4Gtn8KH8NngR9rLQSP/fidH4XtwfXh4BHL4Cr
         /X8F9zTMufvYkmEat6xSunz3MXLYqdmkSo/0QqWaiDEvmtR1Il8pHDwzSJSnY8sZZM+u
         2J7UDJLmvfijpwcW4pkrzoGULiVToAkoaBiA1Gan129/Mq+o+U6CENMOx6dcfoWsxEkp
         Bj0xBXXqqmLMoZsnlybI1g0m6DPgupznCv8YKbN7AzLWJizRK7Iw+XVIwDTeGvN+CeEX
         B7ww==
X-Forwarded-Encrypted: i=1; AJvYcCUr7Vayq8Y6ktpz+fYgxnDNZuqgdvW9aqOu38+3oFNSWOXxaLr7hd/Fa25VF4h0D+iy7LL5ms8u2It1Qdc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1yWbuPnhvdSjvkl4VZtbg/wNK0rvsu5AnJmEPlKJtXjvd6k3+
	SnoJ3JoFRRQzYYV1ogQ3uO02E7exCoITMM2UDIcNVeAmgKnzWCxSaWQRe8EMBH0r
X-Gm-Gg: ASbGncu24XK7bU6wv0PdkiCa55ozhY6cDUFEB0/t1fBau+OdZ+tDlBKNyKS6x2RE0IT
	pEnGwt/56Hn/PRyWti5NMjjnM9PvQ92gH+4JgUPlZ6kf6sddNEmC4C1TsvPSqoD2FOtcOPn6jCX
	Mhh/LB5owP1AixjscHQm1NPekGp9tCe/ef41fN54WfXzOMWR4gyl/1KHJ/AFoWUCeSeMJQeDVfi
	YeJf1hoLyaF8WMzLOl6sejTxQ0BQaCNfQOnh+niRy1qCAKgW7iYkEdGZQLO+OPL7MWrUX5tiK5R
	v1hWRXuttLQsKocCqsNIEbRhsmGeM2ZksG4Y8nd8seatDG6eDsA98IDLtmEmTDUVecadSJ5+C9Q
	MwTD5AiuCA00sl6EOXX4mHhijvrubjYCsxVh3QrbntqST3IOH3AA3DrWusmEupt28yD6Hvx06Gt
	6VlPY5CT0=
X-Google-Smtp-Source: AGHT+IFmEIck/KyapQ16d4axJavndse6vNUCmyR2rzaGVYX1dvrJbAa1+rMRMt2WXweu/DdRWnLv3w==
X-Received: by 2002:a17:903:2f85:b0:248:a642:eec6 with SMTP id d9443c01a7336-290cb56169bmr192029475ad.50.1761017210753;
        Mon, 20 Oct 2025 20:26:50 -0700 (PDT)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-292471fe4d8sm94574595ad.96.2025.10.20.20.26.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 20:26:50 -0700 (PDT)
Message-ID: <6cd4bb7732465debf55ef244aaafbc5047323628.camel@gmail.com>
Subject: Re: [PATCH v2 bpf] bpf: liveness: Handle ERR_PTR from
 get_outer_instance() in propagate_to_outer_instance()
From: Eduard Zingerman <eddyz87@gmail.com>
To: Shardul Bankar <shardulsb08@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>,  Andrii Nakryiko <andrii@kernel.org>, Martin KaFai
 Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,  Yonghong Song
 <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, KP
 Singh	 <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo	
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, open list	
 <linux-kernel@vger.kernel.org>
Date: Mon, 20 Oct 2025 20:26:46 -0700
In-Reply-To: <20251020060712.4155702-1-shardulsb08@gmail.com>
References: <20251020060712.4155702-1-shardulsb08@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-10-20 at 11:37 +0530, Shardul Bankar wrote:
> propagate_to_outer_instance() calls get_outer_instance() and then uses th=
e
> returned pointer to reset/commit stack write marks. When get_outer_instan=
ce()
> fails (e.g., __lookup_instance() returns -ENOMEM), it may return an ERR_P=
TR.
> Without a check, the code dereferences this error pointer.

This description is misleading.
The only reasons for this patch to land are:
- reduce cognitive load to avoid thinking about special case;
- silence the false-positive notices from the tooling.

That's what has to be reflected in the description.

>=20
> Protect the call with IS_ERR() and propagate the error.
>=20
> Reported-by: kernel-patches-review-bot (https://github.com/kernel-patches=
/bpf/pull/10006#issuecomment-3409419240)
> Signed-off-by: Shardul Bankar <shardulsb08@gmail.com>
> v2: Drop Fixes tag per Eduard=E2=80=99s review (not a functional bug).
> ---
>  kernel/bpf/liveness.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
> index 3c611aba7f52..ae31f9ee4994 100644
> --- a/kernel/bpf/liveness.c
> +++ b/kernel/bpf/liveness.c
> @@ -522,6 +522,8 @@ static int propagate_to_outer_instance(struct bpf_ver=
ifier_env *env,
> =20
>  	this_subprog_start =3D callchain_subprog_start(callchain);
>  	outer_instance =3D get_outer_instance(env, instance);
> +	if (IS_ERR(outer_instance))
> +		return PTR_ERR(outer_instance);
>  	callsite =3D callchain->callsites[callchain->curframe - 1];
> =20
>  	reset_stack_write_marks(env, outer_instance, callsite);

