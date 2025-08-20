Return-Path: <linux-kernel+bounces-776785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05076B2D17B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 03:34:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E90187A2BF4
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 01:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 919E523BCFF;
	Wed, 20 Aug 2025 01:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G3SlrsrY"
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89EA8239E9A
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 01:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755653655; cv=none; b=mqbQYQqxnPj/x+z2y5xv21NC+pJaRZhrOo/5tXqkeOtpKdweHbUVTC4+JGHU0WM7t8V/dnneiiFp/lHLizfrE3JVAIPnyf+G+V9Evl2wFFk5N5mk0UWDEkFTKVFG827+v2wH8XPPLDQ7xcfzxI0N6Nrugwbsvd6SaUJkd1FBxJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755653655; c=relaxed/simple;
	bh=fnvvD0dXIr7uSUtfhnYO2fmLebqphg44/qOH2jJWk9o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g685f0vNi2aBOvfm857u5tBdJwmcvrXNPr8Zm5ohl2ID1VGE4n6Lg/Ly2jKdjNpm+Qy/KW+1t3K9lbDfoyfnmsu658sewll1nQFkMYhgl+zU3lpnnZtv5FqBMukpKmHQnCPbJH3tE5+2QNbUPEVk1dO4faeJZ19vomxYLyu58vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G3SlrsrY; arc=none smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-50f8bd52e06so1896408137.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 18:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755653652; x=1756258452; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/s5KX22ZKNy20GSmoKGpSXm9KhZqzsJchYB2SFtI2Tk=;
        b=G3SlrsrYo1YduW9Ry846AKLEHywDvQ2CZqSK3VjGnSnTPzj2IgwjFys30ZMOVQmDcS
         u9NUpQLmXjuA/3bo9GGbx7gg6DJnonmGHtCaycKj07iioCBeZv6aKpBjl3kii3MhVI+D
         N3oi57l64NvcwLwMiVMFQ5q6PdrgVwbwTwtZ3z+B18k3/dHm1ntGD+vmTCqQVwhdQYS9
         Vza9iAIcw8NaZUyoQxbFre7ydGX+gdkwN+MUhN5DHRCSScWQxI1WypungiBKvIheVmb/
         xGwY0+xd7cy4Ut+KEBLyS0Y50L4gzAlmbxjv/pMVuH3qDIJmK7yrSB2IL7DmAxCunbgO
         De7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755653652; x=1756258452;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/s5KX22ZKNy20GSmoKGpSXm9KhZqzsJchYB2SFtI2Tk=;
        b=Y6/WgeD7Uf7QnWavLfo7jZ27TFG2vS5XHx0od0FuU2exzGhQBl8HeaDg05cwSMF/O9
         LtO6B+I+M1nQdpPLNSGEXQTXhIDuJxkhsjxXrPetVKJ8k66guXNrXVnMoXU4yZAEM3uQ
         xGiZNSzSn95Vb3xHqETu2p/7rtGHX1gTeJFGfjl8XsquaYnIQq5JAeTKQOEaLt26eh1b
         9vwjRR9UUXXW3Kpwm08qEtdeEAD5uxQqhhuUu9RAmxpA5ETOTBG5kHWFuV23UxL/KQaU
         evbXB/yOtClKT7IbMnhiiuAm+PZACYbd4lBJt0w9EUmFHqsYoDqHE3XV6T4zLnRZ+J0X
         yasw==
X-Forwarded-Encrypted: i=1; AJvYcCX66xmE2QtUoQPlzpBoTnVdEbnVsXyfGBhSUDgBsyMSwphWpTGKQGyX/G6pCYvt2WRTIt/0+7PQemdDvyA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yytbb3Po3K80k38nzdkxJT8xNH8ruWqUE0u7zyCPblH2zz2WUDz
	rsqvsGjfmslJPhMyDSsScjLVGlGz/jYlgfMl7pIRT7kkQ80DnNv4hjsjwJrUmuMMtEDedpfCm/0
	kqmKAgulA1CSkBwK2eFkquJHptfe8DTk=
X-Gm-Gg: ASbGnctoRIup6rvnPQOA4WsB5eLHfj0EGXzwQbb/AGaERysD+SwSXwhUxvmb6S/njrp
	EjcidCJrIPzTnX2k8tB7HmjQLmMlyvtx3lVqeplBiNVVQxTa+SftQ8UDUUkpE0vPJ/EaPq5a5H/
	v8GgzAXmJ98qaAFagCJMNWlv4ofaIL2a/rK01VtH4ZtGqo09q3E9kVpBy5JbsM0NbCve1Yc4wib
	H3+xf0=
X-Google-Smtp-Source: AGHT+IH59QaYj8PVrLGYbCpuZBJCiG+vGOmEnEJInZ9CVrWnoyUY0LLSgv3CRoTWrZz6siUk73RTGOz9uGXGYGQdrMc=
X-Received: by 2002:a05:6102:32d0:b0:519:534a:6c27 with SMTP id
 ada2fe7eead31-51a517c8469mr357736137.29.1755653652254; Tue, 19 Aug 2025
 18:34:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250819193404.46680-1-sj@kernel.org> <CAGsJ_4ygTv1tCJeuF43NhRR4E0kiMLpk6i8c+UHoUMt6LXykww@mail.gmail.com>
 <aKUi7hvcaK0h0oMg@gondor.apana.org.au>
In-Reply-To: <aKUi7hvcaK0h0oMg@gondor.apana.org.au>
From: Barry Song <21cnbao@gmail.com>
Date: Wed, 20 Aug 2025 13:34:01 +1200
X-Gm-Features: Ac12FXyBMXRrPseaIunZh_CzIXyD525pwtM5WkB6blbfzShRnBs13xkgDqjTZ-8
Message-ID: <CAGsJ_4z6YvQULrEmNjFjLNrJ4RK6w0+d9uF2-7v06gOYirrYRw@mail.gmail.com>
Subject: Re: [PATCH v4] mm/zswap: store <PAGE_SIZE compression failed page as-is
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: SeongJae Park <sj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>, 
	Nhat Pham <nphamcs@gmail.com>, Yosry Ahmed <yosry.ahmed@linux.dev>, kernel-team@meta.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Takero Funaki <flintglass@gmail.com>, David Hildenbrand <david@redhat.com>, Baoquan He <bhe@redhat.com>, 
	Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 20, 2025 at 1:21=E2=80=AFPM Herbert Xu <herbert@gondor.apana.or=
g.au> wrote:
>
> On Wed, Aug 20, 2025 at 01:13:13PM +1200, Barry Song wrote:
> >
> > Let=E2=80=99s sync with Herbert: have we reached the stage where all dr=
ivers
> > reliably return -ENOSPC when dst_buf is PAGE_SIZE but the compressed
> > size would exceed it?
>
> It doesn't matter.  Software compression should never fail, and
> if it does fail due to a bug, that's not something that the user
> of the API should worry about.
>
> Hardware compression should always fall back to software compression
> in case of failure.
>
> IOW all compression errors should be treated as incompressible
> data.

That is why I think it makes little sense to add a counter
zswap_crypto_compress_fail, since zswap already passes 2*PAGE_SIZE as
dst_buf, which is large enough to hold even incompressible data. Adding
a counter that will always stay at zero seems meaningless.

We might want to revisit the old thread to check whether it is now safe for=
 us
to move to PAGE_SIZE in zswap now.

Thanks
Barry

