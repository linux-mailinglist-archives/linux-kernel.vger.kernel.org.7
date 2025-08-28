Return-Path: <linux-kernel+bounces-789667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68439B398DA
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 11:53:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3015D169CED
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 09:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EFAB2ED165;
	Thu, 28 Aug 2025 09:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=readmodwrite-com.20230601.gappssmtp.com header.i=@readmodwrite-com.20230601.gappssmtp.com header.b="Y9C5JNPy"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99DFF2ECEA2
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 09:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756374790; cv=none; b=dYQx80nBCmwE3oSSR1ZGwds/zwX1xdorFmbHKUWcwdWbCAavRgjYI3LXVLwprM9l5sJPqfp2asgKJhCr9uer+UUZKN5Gt0CQx1HOOEnPh7wj7uX+bFa1bfV0N++M/9doRCkhRmZ3rn9iJjonreHVttw71llZYAnDr4q074NMz8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756374790; c=relaxed/simple;
	bh=CVa6GmAMluDPsP+Q998eJHpdv/J8OP2iwTb/vFH8cVg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=heRqx86/RHwOAYuJ6Z3eXfQ5EVCrMp3RJEy7sT5e8gNKaKX/hwEHBSlno6kZ4wS6mHUwG72H3H9aYgJTDTOaqlYA4GlRpElOnyXAI6vg6vE4OI/Lpze1hRG5Ecj57FMjC6n1PG0vQ7fLneOhtZBl/2G15+iAsC8FGXNWAApFkoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com; spf=none smtp.mailfrom=readmodwrite.com; dkim=pass (2048-bit key) header.d=readmodwrite-com.20230601.gappssmtp.com header.i=@readmodwrite-com.20230601.gappssmtp.com header.b=Y9C5JNPy; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=readmodwrite.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-321cfa7ad29so1387636a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 02:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=readmodwrite-com.20230601.gappssmtp.com; s=20230601; t=1756374789; x=1756979589; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CVa6GmAMluDPsP+Q998eJHpdv/J8OP2iwTb/vFH8cVg=;
        b=Y9C5JNPysytbE40N6Vha+7S53QT2lmAH9vTLgJ4Jkw4kLBnHQ9nMDqVYVUDn5RiJJ4
         MIjWlFHo2Pe7oUsM29VOviL7wkh2GDidQZVJrxNHK+VdpTlqToySyvSTc4qqdtixfBGe
         6n2uI7gzvNc3gWauJTxnBSwYJixbm4ZmPpcTEYWeHj4FrBaSjqc3/gbNiiXA1Cgl5i3B
         LEPePhb9vZZg+6r0FoEz8cnRyi60Nny4quQrxUJaEBfP3syfYpbGk2lc0LEOGLHdFvpk
         psYSvgtjSBpn9gp0NjQvYw4X58stBs71O7O7gMsCv+zkfyFpPbk3zj5jrF2Tn0KTi9Ui
         gYDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756374789; x=1756979589;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CVa6GmAMluDPsP+Q998eJHpdv/J8OP2iwTb/vFH8cVg=;
        b=UQVu81BL/oCNJniDFfWEAMiGRNV1qRkOVdBVHexoLj45u5hrMzN0qS1JYy51qjdFOd
         omN769AkXZL5A35zxN5Cnv4peYPYFCgpgUn6G9pkT+u/PkoLZSBWviBaBHC0Z4p7U9ci
         9JVBYIxt1zPVRwXusvxecj+zr9Hke0xwriB8Xw6O7QnZiOc6g2UFZU2dGppHQZo/UNL1
         ZOpCeWSdhW1c7vlQbLjjA75hYp/4ODKU8YMGyVRl8bl0oBE7gR5kNJS6TNRiPvX+pKjl
         styblorW88+kEdGNT/jSOmESIJVEvuXrLglnFAnfCVBoCAemhyWhfmJLifXeCPG4cnJD
         nTcQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBrAmDezLWH/luDDgjHy2BHse5+VOrNoUEyNSnq9fxIb1YfjOCsVO4GTJxGapJzdLSs/ohoyPWas5Hrz4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzexXFLgD7wEcQEiBg7GUq1STqey5nFDUW097Chx++auCYvF2h8
	Pl3Fjlr6jP7JftACywedN0yA/3bTox2d+2PywWNHveMCwx8J5zSkSOVlsHzHUdYqegcGpxNXdyJ
	4gEMOwYTJmYqvaEMYOLLsbMd48Y3ZgVZsKANYw3eF0XCUG1KoAc+HxRk=
X-Gm-Gg: ASbGncscVB3k/DdnU6BdzvJe938PTvI0c8tIiXjQT0517tC/4y7oNyYo+B2eksN+Mtl
	dGZfiky39UNulrj3yT3pxaYFH7ITFiBlPComhDYxR5CuriMz9a883/x9M5RnZ9nTIdTbhZY0kBu
	KAtkeviaQIwg//DbiTyTSHduewRuz/KDzt9R6aqLc9qSytnK3WDvl/9m8Jn84CGTo/6EtPgqp1w
	Lzopr55RdpZkCgnfZfmYgq97mymtekAog==
X-Google-Smtp-Source: AGHT+IFiPdVsknu0U0byAooRoHYi9Kg867zs/XmQado5OBM8B30B7VRf7vH1HN0s27q1gbRfKpCDHOffF2/n/I7g+k0=
X-Received: by 2002:a17:90b:380a:b0:321:335e:19cc with SMTP id
 98e67ed59e1d1-3275085e80dmr10678185a91.4.1756374788898; Thu, 28 Aug 2025
 02:53:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250827140149.1001557-1-matt@readmodwrite.com> <CAADnVQKs0=iM_QoP9+SN6kG3iZ8hMwqeLWrQ5S3TvBbW4dgk3g@mail.gmail.com>
In-Reply-To: <CAADnVQKs0=iM_QoP9+SN6kG3iZ8hMwqeLWrQ5S3TvBbW4dgk3g@mail.gmail.com>
From: Matt Fleming <matt@readmodwrite.com>
Date: Thu, 28 Aug 2025 10:52:57 +0100
X-Gm-Features: Ac12FXwXov8EhZrXIVQ2GFdBqP51A06NQPbDibzT34Dfary9rb9a1p7gB-p2qOQ
Message-ID: <CAENh_SQJ4xt0rSimsHXTNDJaEqWV2P7wgh1g-bXB7iE3hHt99Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5] selftests/bpf: Add LPM trie microbenchmarks
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, Shuah Khan <shuah@kernel.org>, 
	kernel-team <kernel-team@cloudflare.com>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	bpf <bpf@vger.kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Network Development <netdev@vger.kernel.org>, 
	Matt Fleming <mfleming@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 28, 2025 at 1:30=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, Aug 27, 2025 at 7:02=E2=80=AFAM Matt Fleming <matt@readmodwrite.c=
om> wrote:
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/progs/lpm_trie_map.c
> > @@ -0,0 +1,19 @@
> > +/* SPDX-License-Identifier: GPL-2.0-or-later */
>
> I fixed the tag while applying, since it should be //
> also dropped or-later to match .h and the rest.
> I believe that's what you meant.

Yeah that's what I meant. Thanks for fixing this.

