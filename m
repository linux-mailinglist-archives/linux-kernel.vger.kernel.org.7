Return-Path: <linux-kernel+bounces-861409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 12253BF2A7B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 19:15:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9DDE04F9EE7
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 17:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C57F43321CF;
	Mon, 20 Oct 2025 17:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iM1jAKgR"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C4943321C0
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 17:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760980402; cv=none; b=QBX37cKeJiJ4l7KDTzZbZ9SGGA1zgyZudtGJ4XqZmYxX5t2DOPHGToHVacI6qogVFVbdvgZfuPp/Zz4ryBmKQvEUMdYvV8lCenJrtfbWsArhRiYdq7XGvt72X0PeyluwiW3msBIR3kQndXSYSTOAEPHbg8ODxSL+LK+vYMcJcdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760980402; c=relaxed/simple;
	bh=qdhd4fAQohIjlG3EgHDubuZx3bxc7SthTqZLWrGkZjQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AjRv75xPUDO8gQePfI40ufj8oVh3ffcxl/gMQudraW1SJyg7LXqvOc3KtKeEwuZqhmR4qfU2JEwTlcpYvkFhnsKO/II0LhaJna5FJ3DGOJkNZdcyPvkOWN3VD5Ho4tVoUj0E869+FTVeqhgmagBxaKyPEorZkb4sZu9gxGpegN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iM1jAKgR; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3ee64bc6b90so2960105f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 10:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760980398; x=1761585198; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RGI6Q7BTAs/HMJAhH5ug/+5JV+NNvoV5bQjyt72+yc0=;
        b=iM1jAKgR1m1AIPLkhYC7seTiDoDHL3KG3BcmIL7UT35Ei3Hlb+MtLsjjEYtxRmpIoU
         ih5heAOWw7z2BamSEuIofAm/Bw6mKs1vY/0JQi1++FWi6AH2dR7Fm6Ouca5eO7nLMUHV
         Ylw30JTbsva+Fol6eB6BErrzVRAoR9cuZ/qBJxwc2ACLK8yfhlkcWXixdmhyGkHdkDmK
         V4run7cslRKiSAuj213bYMtkQdVq2NlBvLvPk/VGefpIAK1tp6btPYbAMvjZXQ9NBhkb
         gtn50x+dJGqSsbQjQmWLk6Ng36WdMWa1TnJjvH5jiH9A+71XAcn0sTICm5/DlvgSMKrj
         KjvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760980398; x=1761585198;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RGI6Q7BTAs/HMJAhH5ug/+5JV+NNvoV5bQjyt72+yc0=;
        b=iR3nH0cUmH8hvPfW8X1+Juo6qa1svfsfrjTvLyejpM9TSyZcEUan9O7P1mR85KkDon
         oG33dbPZm5fic2FE6N9DfnHlwtK/xBmxorvt8qzyPYF4w3/mvxg8OgY1jYcTsHBAHh/0
         cem4J92MrWR1YfcJxvrNwGpz1JoeCBnusQfqqnufOf1pq4o8grR6eQBAtXKpLF6mNlSm
         yghzK+jFK2ixSmV8SelUdshsKbJF6somv3ZBPoBvPpGMEYrVyePlxvfq+eAyd06J9R83
         S8JEiuTBmPFMopAsC436Jn2dwwP6eboW/DqmXCQB+XYORIAA1nPg3omoQ7/VD4cZvZ2U
         JhRA==
X-Forwarded-Encrypted: i=1; AJvYcCUsH5VpgDFBYZFv0WU2Z3p6kY+ATNKhR6+LgsDmMbzvcIAZiyxwfjb6oC3qo3BX4c06eduPdzbdb0gwZ14=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtXQvn8FzsPXEQSeTPM3oukrhN2R5xyu3z7caD9eB7FF3cepin
	3VQIWE/80Cl042+7ECfPQuLHxHj/5BhN5bVABoMTfrYh5LwVF889DcREEKVzFYYoDlmQN2rFya5
	GtekhfJrY1Le+aei3eKXKwiXCT5c857I=
X-Gm-Gg: ASbGncs5DJsIBYrBQES/HhdwYKMwAhimWklnB40XbTS7uosUjsX/GhNbZrgrmvX5kQ8
	s1HflJkN+HjGSZsML4JsZC5ztLXVwLfblPEHj/iTFZyWAbfJmbynlSyKDpidIX17Q8iZCMYCCU3
	4VMvb5einFJ4FqJyzRyBF2AXvzRekCOvBF2pnATBq/GzCqHaz7IsfStXZBkse/3VEuo8w93le+j
	ua/HQGOsVCW6UK6+Gzjipnjh6jJDpG8NIA8Cmk98aghBdvJ2Psl6WW1wA==
X-Google-Smtp-Source: AGHT+IEodoyCQ4s3ezeiwvbSuedTGQrnQgPdmuDQggu8D72dLZWaeRuVepbyTu1eDOJWleQ/3mxUOhbhAORfmNTXRPQ=
X-Received: by 2002:a05:6000:2f84:b0:425:7179:16eb with SMTP id
 ffacd0b85a97d-42704d87ee4mr8625832f8f.17.1760980398375; Mon, 20 Oct 2025
 10:13:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250929172724.75108-1-sj@kernel.org> <75584276-6d30-4e35-9e59-e084c60d1c5f@linuxfoundation.org>
In-Reply-To: <75584276-6d30-4e35-9e59-e084c60d1c5f@linuxfoundation.org>
From: Nhat Pham <nphamcs@gmail.com>
Date: Mon, 20 Oct 2025 10:13:07 -0700
X-Gm-Features: AS18NWD-XcABY9AYH26aivrP7s7U2VJn_xaY3Jej0bnRhuMSCHP69gzanE8702w
Message-ID: <CAKEwX=PBrcPnEkEhWQn_CTtT04qaKY2WsWXjDSSyPUGX4yY-sw@mail.gmail.com>
Subject: Re: [PATCH v1] selftests: cachestat: Fix warning on declaration under label
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: hannes@cmpxchg.org, nathan@kernel.org, shuah@kernel.org, morbo@google.com, 
	justinstitt@google.com, nick.desaulniers+lkml@gmail.com, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, david.hunter.linux@gmail.com, 
	Sidharth Seela <sidharthseela@gmail.com>, SeongJae Park <sj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 10, 2025 at 1:07=E2=80=AFPM Shuah Khan <skhan@linuxfoundation.o=
rg> wrote:
>
> On 9/29/25 11:27, SeongJae Park wrote:
> > On Mon, 29 Sep 2025 17:24:06 +0530 Sidharth Seela <sidharthseela@gmail.=
com> wrote:
> >
> >> Fix warning caused from declaration under a case label. The proper way
> >> is to declare variable at the beginning of the function. The warning
> >> came from running clang using LLVM=3D1; and is as follows:
> >> --
> >> -test_cachestat.c:260:3: warning: label followed by a declaration is a=
 C23 extension [-Wc23-extensions]
> >>    260 |                 char *map =3D mmap(NULL, filesize, PROT_READ =
| PROT_WRITE,
> >>        |
> >>
> >> Signed-off-by: Sidharth Seela <sidharthseela@gmail.com>
> >
> > Reviewed-by: SeongJae Park <sj@kernel.org>
> >
> >
>
> Johannes and Nhat,
>
> Assuming this will go through cachestat tree
>
> Acked-by: Shuah Khan <skhan@linuxfoundation.org>
>

Hi Shuah.

LGTM:
Acked-by: Nhat Pham <nphamcs@gmail.com>

