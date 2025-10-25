Return-Path: <linux-kernel+bounces-869896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 32AC8C08F48
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 12:51:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7B3D44E7D0F
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 10:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5A7E2F547D;
	Sat, 25 Oct 2025 10:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EAwq7C7q"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B38F62F5304
	for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 10:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761389455; cv=none; b=r7OZsxkkca8ElGuaeb19gWnap16sPk1ETE3kuFxq4F7wnqXvsva7VsPxa/hppWkYOrv2ki/gR31e+s6ZWBKXLM5EHgLcxTAy2PD7wrKBqWSmuSHI+BgD1/F/zNGyzCIV/x0Zi+3uUb0rK7N0yXIMrmAS+d8YvFUGml4lviuPsCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761389455; c=relaxed/simple;
	bh=POkOiJXxYyVdXoybLfPGciVsCYLxYpIyRuwaeTZ4nlg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a26bghwpoL2LsFVEr+lQAdh//Qulv0LkDEEMJH+uMDo1CTJZAxXv57KZ0P3cJ4/FcAe4OFOooEpisFY/zJ8PVwiTTztCVE8DHH1L9+1tkXvSyMsprLy+ZBkG4cM6gl2eV5DzhobIox4EZ9u5fLhf/8J3mqAYlOurU04Y+qXmYlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EAwq7C7q; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761389452;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=POkOiJXxYyVdXoybLfPGciVsCYLxYpIyRuwaeTZ4nlg=;
	b=EAwq7C7qAt6Si4hjyiH+tKn59yTrAoRk/hlOL8kDzBy/Q+OcSHCuj2j/YM2baunzcGk1mP
	v07Slp788osDc32N+NU7DNFQqTRwKMLhcq8l9+JwYcE/qkxbB1lEvl8p0TMEG/JD0TA/g9
	Hbp2MfpYSrXNCzXPHPlknRm3Sxi22JA=
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-628-PX9pntb8OO6vl6yHc5dZAQ-1; Sat, 25 Oct 2025 06:50:50 -0400
X-MC-Unique: PX9pntb8OO6vl6yHc5dZAQ-1
X-Mimecast-MFC-AGG-ID: PX9pntb8OO6vl6yHc5dZAQ_1761389450
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-5d40dd41aa1so7174169137.0
        for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 03:50:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761389450; x=1761994250;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=POkOiJXxYyVdXoybLfPGciVsCYLxYpIyRuwaeTZ4nlg=;
        b=obto/fFM32Nu5nIdlO/zW/vFrhd4Kf3kunCjMjwYEpV51ihWVHDnRMjy3FdjP4ZqZs
         4dlsJ64TdZDqgKLo8aC8BbgA1PKs/SwE5boxITKEhPlY2sjyzBM1nd6Do52z/JNwrXiR
         IfRrLb036xaUm/s2r6ervUMteg4t7NXkf+BmFoirxv/LZFV8UFYVRupy+7im3X1ohx9S
         PURpQQp6dfPDB61EewBNEt4GaGesGQN1YHqBVxNjG/88OjEd9yNRz6flgLb0bSFqDp3Z
         VMAbUtDekp/K+aDkNbNXzFsJ7B9jZ9CkEtfxQQHN7jNl4jgGZyz6o/DEgU1M+RVLA2e4
         AlqA==
X-Forwarded-Encrypted: i=1; AJvYcCXYz5N6BBrXV0lTBRfuB/ghya+pNrh5P9hoZRJtbpAAKt4BEdSe+uYi67GE/VSnAlE3CTmD3iVGLyxsrUo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQ/ETEUNahLf8aIa0i5dxZWPPBuqMEdC64PCR71p5E80sZlNoj
	DVQbz3tZnELlRQeFMixPpIq4G0Q1Dg63mYta1olnixVNya7RFWC/HMgG5sByK6UGzm4J1mjP9q8
	udC4YSRmjzVTw2D4cdW8b0vF/FDXTkreM+LYKy5DLZVy4DVJJ53XG5QOI2RfIvBhfG6Zk34kyuj
	/p2+7+K2SFjIiey7yEhklblKBOZqHixMMfIxlFg++7
X-Gm-Gg: ASbGncsToL+k92BmHfFE5l9jqSNyV/8qlVlTjOw8ZRkbze66NTIK+a6D9Xt5x7WFd1f
	c5lC9bZGPAv1CIDzlb5SS44GOKtRXIztpIWscYyc/0tPGsX486+iHWzGJWffnwXbm7Oh20SM4ct
	ZyO0qGNoRHlbw3c+NJZ2qglM2OZu4m9Zp1iHDbqIl1ACIncPI11zrO/ESghvdo0zfSF3YnuZ4=
X-Received: by 2002:a05:6102:32cb:b0:5d5:f6ae:3913 with SMTP id ada2fe7eead31-5db3e1ed199mr1939903137.21.1761389450355;
        Sat, 25 Oct 2025 03:50:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFwsyffeJ+eI1nKhYc20dry/5VXueJq+gvTP2aaGjDy37dbuMYWFrmN6kkfCaw0QToy5vgyRxRXy6SQbOpVh7I=
X-Received: by 2002:a05:6102:32cb:b0:5d5:f6ae:3913 with SMTP id
 ada2fe7eead31-5db3e1ed199mr1939895137.21.1761389450000; Sat, 25 Oct 2025
 03:50:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251024084259.2359693-1-amarkuze@redhat.com> <20251024135301.0ed4b57d@gandalf.local.home>
In-Reply-To: <20251024135301.0ed4b57d@gandalf.local.home>
From: Alex Markuze <amarkuze@redhat.com>
Date: Sat, 25 Oct 2025 13:50:39 +0300
X-Gm-Features: AWmQ_bmwcw8JGGEkkE3wWPKO0fCAY3lGT5ZQ4OURnSkGm9gSZBzLJvO3Udtlllo
Message-ID: <CAO8a2ShRVUAFOc7HECWbuR7aZV0Va3eZs=zxSsxtu0cMvJmb5g@mail.gmail.com>
Subject: Re: [RFC PATCH 0/5] BLOG: per-task logging contexts with Ceph consumer
To: Steven Rostedt <rostedt@goodmis.org>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, Liam.Howlett@oracle.com, akpm@linux-foundation.org, 
	bsegall@google.com, david@redhat.com, dietmar.eggemann@arm.com, 
	idryomov@gmail.com, mingo@redhat.com, juri.lelli@redhat.com, kees@kernel.org, 
	lorenzo.stoakes@oracle.com, mgorman@suse.de, mhocko@suse.com, rppt@kernel.org, 
	peterz@infradead.org, surenb@google.com, vschneid@redhat.com, 
	vincent.guittot@linaro.org, vbabka@suse.cz, xiubli@redhat.com, 
	Slava.Dubeyko@ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

First of all, Ftrace is for debugging and development; you won't see
components or kernel modules run in production with ftrace enabled.
The main motivation is to have verbose logging that is usable for
production systems.
The second improvement is that the logs have a struct task hook which
facilitates better logging association between the kernel log and the
user process.
It's especially handy when debugging FS systems.

Specifically we had several bugs reported from the field that we could
not make progress on without additional logs.

Re: MM folks, apologies for including unrelated people, the only
change is the addition of a field in struct task.

On Fri, Oct 24, 2025 at 8:52=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>
> On Fri, 24 Oct 2025 08:42:54 +0000
> Alex Markuze <amarkuze@redhat.com> wrote:
>
> > Motivation: improve observability in production by providing subsystems=
awith
> > a logger that keeps up with their verbouse unstructured logs and aggreg=
ating
> > logs at the process context level, akin to userspace TLS.
> >
>
> I still don't understand the motivation behind this.
>
> What exactly is this doing that the current tracing infrastructure can't =
do?
>
> -- Steve
>


