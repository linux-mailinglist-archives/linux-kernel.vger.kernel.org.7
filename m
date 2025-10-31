Return-Path: <linux-kernel+bounces-880352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B30C8C25950
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 15:31:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 670E14F6745
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 14:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22CC334C12B;
	Fri, 31 Oct 2025 14:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hRia0Ay9"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D907942AA9
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 14:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761921028; cv=none; b=RaW+NkoSAp+ht/g1SNZ1yliSE9A73kj1Y+gAkWe2ofjcJQY3kxW9l+2gpwlRw75q25M7U2TQRwLs89kWgikj8SvqvyxTq4bwAAkZEfYW2YtZOJiZJ1FEjoKmc/3CbOY0w3Do5hBef7x7scyxXGgODv4CUGaFecEnKAmJG6KsrTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761921028; c=relaxed/simple;
	bh=ia+M42NiQvrmHNhVtx6g1EFyz+OuuCQ1rF/Q3fUKCuI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aCvjTv5vo5wMdcSgc3OAqRc3ptDOdGcbFCKVk+bnSg/Q/gWQmQ9ZWkaV55OfGqAEyWisKjYj9hrs1NoAo4Ndm3KehwTlDGY0TOcjWq2dVwfhfvfJeurrRZZ5lf1IdDQuVN0yOwSca7xrYcld3t1+LwS7/vuUUi8XCctvC7EwVBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hRia0Ay9; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-4270491e9easo2019178f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 07:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761921025; x=1762525825; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ia+M42NiQvrmHNhVtx6g1EFyz+OuuCQ1rF/Q3fUKCuI=;
        b=hRia0Ay9mTHS94yq6vsEmXsHyXE+sU8GoFAwvpQ1qmf9vKB5eLF6F6y+f8V+0km16/
         dyyzfgwhsQRkFfTjuxsQy6nmG4OOcn35lZVMUdbeRj6lbJQqemAg1NBUW+C015Ti7dnE
         TJsvASF9K2bOGvdQLPIuXbZ0PJcAnw392ZanBIhhVTP7rpkbnAoEJXV52zmjbyuWoEqm
         wDvBaIJr4k4cXUP5aSYcR6smxm2pZEvnWB5QpwLPjX4gjeP5vjtSPrCenTgL6ELVNlZh
         givM0cBk3hpTCAIFPxmoFYRznO7x8ONiZpCjxBbXGwbfICvvGeNcRHs90u2IA9GD7/47
         LTbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761921025; x=1762525825;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ia+M42NiQvrmHNhVtx6g1EFyz+OuuCQ1rF/Q3fUKCuI=;
        b=ZlqufP96lrKWsIclFoFgOyGcMBJC8ko1Bf+jd3Loh+Q6YiUWgj4S/uWA8PGbXVTyO9
         QFrmicEQS/C1jV2ZQtr6nCsb/sBCk1v4qQtFHFrwzLhPW7qGsk788BOzMJe7uMELVocV
         U568TvnD6zVZHubcM+00xzbm2a0dbEKxch9en/0xnPFKZga4U7VYVQ6nEJJsoyba7PFs
         Uv6WN1KvIjEr/6oVprNhjLjxXOFQJKlPfpjMTr7p7j7zxK4K00KybwLURBjE/0PHyYqY
         8QmGxvIwW/Bnz4nk/LSyTr0/7f2Xf5amBxfr8HGTOonj4FRgUsZv8cPJRuLYzcl6THOw
         o1tQ==
X-Forwarded-Encrypted: i=1; AJvYcCVkaqH3mmR3PQXaRFYxhfcroB6S5K6CSQsj74DNiYMtiMG5BzypAHkYbbS23AtJdI1wgdY2HcpeiA7bbgY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+DRQHqkXKwrPsXCm17/aopT/JITlIpmSq1MPsusOe/dO+dY8B
	Tam7XSaAcMb0kpaOHMg98cSPGb7Ec4LyeJmXc5otN0HAU12pPunbSoWJnFDC0p9dBGAjc9ED6Y+
	NQ8/3I0TvimStPZ0pua1jJnhTOMgdavA=
X-Gm-Gg: ASbGncudcFw2n9CuitJw8G+BRa3oTydWO8C96xfRXuTYXNJxa7GTaOqdwo3UvHGM9zL
	x2/bbyRBR4EVHYUz60JBTXVOssh83K/6bhlK5hKG+hDoBJNPZjx6FGDaRgoS6VN9sejnIFb8i6b
	lg/Y4YGR+Tp+zhhamxCLfOvsdV00lo4OoPGdulXDDOshshbtRO8zw8JMiQs9OV7F5KjY2ATCR9I
	jcRBqmCA3Ga0tJx+crcftpAdgq9wtaJj44JgDFHpg2JGvkhL+oxxhjb2s/yXmHmvtcvhKecQm8T
	r1SoIuNI9WPiBwIIPSWgxHWDvKxF
X-Google-Smtp-Source: AGHT+IG47+1l6FUj2/1yJRideOAXxtsrE8rGnANzQdIWUW6DOVBq3l0Iv41VbMySpGkkF01BSpkfDesVFy8Szgf9fo0=
X-Received: by 2002:a05:6000:144a:b0:429:b8f9:a882 with SMTP id
 ffacd0b85a97d-429bd675f77mr3223983f8f.10.1761921024798; Fri, 31 Oct 2025
 07:30:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251031032627.1414462-1-jianyungao89@gmail.com>
In-Reply-To: <20251031032627.1414462-1-jianyungao89@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 31 Oct 2025 07:30:13 -0700
X-Gm-Features: AWmQ_bnznBbDi_yNCkuW1kxoDfv4wWjEeJzqF_OTpFLEUCa1V4CI_Ja3Wv55C0U
Message-ID: <CAADnVQKzF=jrJ84es2=Ko-WdcNxQnBWErb06huFyZs6-HuhowA@mail.gmail.com>
Subject: Re: [PATCH 0/5] libbpf: add Doxygen docs for public LIBBPF_API APIs
To: Jianyun Gao <jianyungao89@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2025 at 8:26=E2=80=AFPM Jianyun Gao <jianyungao89@gmail.com=
> wrote:
>
> Hi,
>
> Background:
> While consulting libbpf's online documentation at https://libbpf.readthed=
ocs.io/
> I noticed that many public LIBBPF_API helpers in tools/lib/bpf/bpf.h eith=
er

You or AI ?
The whole thing looks like AI generated garbage.
Sorry, but no.

pw-bot: cr

