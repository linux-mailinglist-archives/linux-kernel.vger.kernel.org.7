Return-Path: <linux-kernel+bounces-751584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D9BF4B16B25
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 06:21:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BF771AA37F9
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 04:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50EF33595A;
	Thu, 31 Jul 2025 04:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cxxl1O/q"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D1A21CA07
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 04:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753935690; cv=none; b=Mvxk8IekykmqcublCgYQpYtow1l+jR68V518u5l5sISWF6b2zyW9maJBGpveogvTYMtQSOT487+trW5W9hhLWzOgPF/oFHOn672stvtNuB5B2w5QEDTr/WVLiqHBmdJQNOOZz9qi0IQjygJMG4hT1EtcO9oa8VdoJp6hpQm3GpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753935690; c=relaxed/simple;
	bh=9BJQuIYAIutl68a1U+8y+EA6p+nEfqHCPz7d3Cp+oAo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QaowTBmZ3JmKoqfwEJpW26IBbExE8wMejIzKJXZDekqsqfSplk20hjP/Guen7nHF32KkCKw3nrOMhgDtp1KElSyc9Ami4pwqYrizcKpWksNwLmjUgOzYaKRO23BIX68saOhSwgyr73vwA4FyLf56iPh13hyH+b/VPSnDFJimdRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cxxl1O/q; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-af910372ab3so140018666b.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 21:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753935687; x=1754540487; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9BJQuIYAIutl68a1U+8y+EA6p+nEfqHCPz7d3Cp+oAo=;
        b=Cxxl1O/qm2aPtKmymSFbNCb3EfHmb7o48uxEXCpzSux/sulEYl8Iw8c9+UlYixXWVu
         W7xq5MWwF5RTiOuaE7fJt6W2sN9/wYqo9ADR4Rcw4dsN9okAlH96KEDOar1Qdxed8fPI
         8xRbV0PFcfYHtY69xLYPcinzK0wr3LEAK+iP9Oj5bgPwIe29HOGsswhqZVtS35HJ1wyt
         rAuahkK/Z6BelHgkP/ZplneRZ31TQc+R+NNpu4Wi3z+OwkttbxYrHNoofXg5fCm0spC+
         MeUA8qyRt0JUYyQZk9kOH0Qeedl72p2lQ0U29Z98SnFJlV0XfnxX3OSlG4HYcKU+gBAZ
         aKBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753935687; x=1754540487;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9BJQuIYAIutl68a1U+8y+EA6p+nEfqHCPz7d3Cp+oAo=;
        b=B5P6C53Ww1XhoI4lGgVUGgThQqUDaleuTmXHk7odsoHLXfH6l/QvHDZLxpIbbNNFlM
         2Rj8uE19JXm91pVXhs21cq1VUiruJ0MWnuc/xJRMpHY4NM9AUPVLwGS5pVyh9tWdsKc8
         X9X9HovMSTaGn6wrVkj2ut7inWBFCHVSSFj+ib5xmg4jGjjdV0GAnI5H4IT8Y15/0t8c
         axAXwPpFxKvbWUUpVizfvlhqvT4Km3Pg1RiiyTHYrSaU1BXmgf5kO2qDyGfoU8i14xW0
         QPz5Yk2RoS05GJuMRwTk0ST0IDT1hLW3eW6TTyFexqZVnFT7SJ9tVD0zPZVhI9F06104
         IdwA==
X-Forwarded-Encrypted: i=1; AJvYcCWsu/JDhjX5ErZbHZxOz+he1NsY/riqMIX/bKVpXMpGzGsZA3M+m95PEX+hY47jcDhs8eYtFSoat+8b+ss=@vger.kernel.org
X-Gm-Message-State: AOJu0YwC6vPD2FP949Z0/vBgMVp/n2z1jhQwebew4yT6tOajdx0C5P8+
	fZkQx4cSK1GDn1slfgEKNcybrpD80Xrr/dWSPLqoGrOn5EGBy+TvU2iZD7r/JMAXBBZAjfPAcNJ
	ftlxlph2v3Zd6FFGTA7YmI/b2eOxefxk=
X-Gm-Gg: ASbGncsJH9rnzEpbJVa40c378Tw3BD5ChIur7faGMG7a/WXNy20BToxh/RD0LK3TWlx
	hNaP4Vhi22EEL//FhFZd8b2JItwhAeVMEcAGVqe9eEfIa02lzLF2T+/afpf0LLZ3+cgO5GIT/Rs
	YvqPRPg+y7q78dvOIai7FW62FMHdl/DGiFGaE22Q9WFjJgBh3nGLXMR9FM9u4WqlMlKRI4kQMwy
	mEJlQ==
X-Google-Smtp-Source: AGHT+IFsRIvPieDFYT641UvwL7THmLq5MSMZmAr0zOT6DiN0hmQqflFpA5SmiQmhMpOU4K4VJnJuubD9eFMLOnwZw9I=
X-Received: by 2002:a17:907:9809:b0:af1:4c23:c8c8 with SMTP id
 a640c23a62f3a-af91bd8c916mr72969166b.12.1753935687125; Wed, 30 Jul 2025
 21:21:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPM=9tzVm80-v6_5nt6kko3nR+aQLZ7R98i419FV8f4-ayQWUw@mail.gmail.com>
 <CAHk-=wirxHy+KU6jmtO2dzmGQ1BwaOdd5Mjtrc40fGvZVULQQg@mail.gmail.com>
 <CAHk-=wjn5Pg2Gp=o2NVv-nRKqE=E75AxUypWCCpQ7MDXuHx+YA@mail.gmail.com> <CAHk-=whnuRuQEky2GsCDRQSf1dZbpoqnK+puw=qdR-D7aap9SQ@mail.gmail.com>
In-Reply-To: <CAHk-=whnuRuQEky2GsCDRQSf1dZbpoqnK+puw=qdR-D7aap9SQ@mail.gmail.com>
From: Dave Airlie <airlied@gmail.com>
Date: Thu, 31 Jul 2025 14:21:14 +1000
X-Gm-Features: Ac12FXzNGe35UR-PT7t462E6zfwe3SyrAqAV_g_rnM4vwCxBuRx39FIJ9Sr-fqg
Message-ID: <CAPM=9tygJqtbmYzB5gktxp-7fBfv_9gNq9p9+SdZ6wiYE2-6PQ@mail.gmail.com>
Subject: Re: [git pull] drm for 6.17-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Simona Vetter <simona@ffwll.ch>, dri-devel <dri-devel@lists.freedesktop.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 31 Jul 2025 at 14:03, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Wed, 30 Jul 2025 at 20:40, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > I'm very unhappy with the end result, because it just results in a
> > black screen at boot for me. No signal.
>
> It's not something in the merge, and it's not something in my tree - I
> see the same plain "just a black screen" if I try that commit
> 711fa2667d8b that is the top of your tree that I pulled.
>
> I've started bisecting to at least narrow it down a bit.

Okay I don't have an rx580, but I have an rx480 which is pretty close,
but it is booting fine with your tree at least, DP and HDMI connected,
so it's not widespread AMD breakage, anything in journalctl/dmesg?

Dave.

