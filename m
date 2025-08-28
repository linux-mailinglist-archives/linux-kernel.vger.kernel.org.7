Return-Path: <linux-kernel+bounces-789255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44F26B392D4
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 07:18:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2DC657B0B08
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 05:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4D2C1C5D77;
	Thu, 28 Aug 2025 05:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="L9/jxTjE"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C715347C3
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 05:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756358271; cv=none; b=c1ixoM2z1hb4TBgfvTQJ08VUnlMNrYGyZl9XG0jO0ufTAwmQ0n60AsBinu+uZztlbE3yx/SRmBqY+dmVohs9uawa+1oJ6HMpd9hnrnSOPoVQTQXR3q87giomTg0bl1OytkwDgjsIyL2MkHJ84oGc24VkJzpES2r/FelNo5FKTXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756358271; c=relaxed/simple;
	bh=EGKR/UbP9HoOguKRcZDGqIF4moN4Gv+faof7Hpxn1OE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NlX8tWI3j2lwpGMAgj6+GNd84XbYJyg7F/RNst7wXWV9vnr6po9yMPt75FJU5AEqpvRLvsl54oq18dVUMkd7yQBjrP4W6ZStg2qE5ium4SKp3Ih8Bq+h7xnK27NNpPWKXJm2bti7k8ptWCZf8umTUi436T1ymbYjYaWWUqDhnHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=L9/jxTjE; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-afcb731caaaso71787466b.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 22:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1756358266; x=1756963066; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OG1WuC2hheSyViU3tcDLma/6gW2kIJ97ZTkGB1ykit0=;
        b=L9/jxTjEft45Kbcg64X+zpQDdpkPZIlINI6v++11a+dMeSovOH+yQv70zodCcm9IjF
         d6d1Hkjf9mN3pGdOqCYaEOqnDor3ihUDH1FQvyA/4hNFsWufuj8+84vb/WvNlfhk8oXx
         tREOaUlkNs6LIhqkHbhFt5pKrDJOlgWspq3ZZGSgh8TrS8IvTYvNeDxwBsVw9n7hC/6Y
         9pSG4fHjFRKVmX02OoPfr9OyP7D3V0oEYA6hxz35ZgsniYncJubwbiWe05X18efypjvo
         akjgYCKGLxTSvliNMD0YEfBfEKudUxvbMZg32uqHtuPTRImIYPuLV5V4jswzdWDWp1tn
         KF5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756358266; x=1756963066;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OG1WuC2hheSyViU3tcDLma/6gW2kIJ97ZTkGB1ykit0=;
        b=GRc/qttAbPaB0V3+upSF+kiuCBMJqjRycq0uyApiovzYbOA3knW1U1xecWJKmtaTwc
         HR8kfpaRwVcvf+KktBbUUJ9QSY95AvGcyItB7A+zYoDK/+/+pIpM2nzjXzhpHEBWMe47
         wqmiMSA7jLzyTLiDWCVG4rhz3bfNSqiMmAE/yeG3WrB9lltzDhpzFyNJkVqtYMWAhxW0
         mulRWMWvQNQkhYpEQDnL2GgHXTqKtD+s8ncaTNr/v58RneYyMdv+QlZir366fUgKAmMY
         Wgz8tKJMaXYbfPKsa7MoMZZm79wKXw1qIwKVL/A49Z9stTz99u0qbNM5TyQvUv0yLX+s
         0pIg==
X-Forwarded-Encrypted: i=1; AJvYcCUyOhue/5FVGmo0eiI/rYoXI9SCwCzdqfaPdEy4IlBFIBrJghuXGAAgYP4uaLJZCeU+cvXmv11nEyjctcc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWrHELpOYQ7lV3/p1EXvruqU0yChOEOUxs324B56Kc4jITUgOw
	9OJzVlCOj0MlUstmLlf57SIM2OeKzt13cykH1TyHNgmWXufMOcGplqePq9dWvKiBd03f31a7UeG
	kqj+rYHo9pE4KT1IUZITju8gcjIhFi5MUC4zT7saiLg==
X-Gm-Gg: ASbGncuLp8sJGlr+HHhMYVLT9vYzlD5xjPsxUPomkDdNDeqsyHq1kf5IYPvhzD01xF6
	uSiLZVgT88CSswWEyu7yMvhMovuBvB5sEZNnY96UMlUw4XdK6R8gjfUrvo8vfGU+7UWACR0dcj8
	EU31PykgCgW9L6JzD8i9mn82syO/MHqNfQN1gnsqYK7Grw/HVzci/XtIfl0mXZNAK6vipHpMKMv
	8t1rfXLMlj3iOmqPOwl0N7uLkzUW1AaO7o=
X-Google-Smtp-Source: AGHT+IF8LgvafHMV8UZau80cAyTYYRm10wxMO3zhQW42jodfKJ3LU2Dgpe9FDWXWK2r4Ls++4xgpcdwiUyG7ZsKp2eE=
X-Received: by 2002:a17:907:928a:b0:afe:eb48:2a3a with SMTP id
 a640c23a62f3a-afeeb482f03mr57033966b.65.1756358266579; Wed, 27 Aug 2025
 22:17:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2aa3f478-9c87-4102-b83e-bf235372d834@redhat.com>
 <20250827150330.280399-1-max.kellermann@ionos.com> <20250827165309.44e465ff214e45f1a6665b24@linux-foundation.org>
In-Reply-To: <20250827165309.44e465ff214e45f1a6665b24@linux-foundation.org>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Thu, 28 Aug 2025 07:17:35 +0200
X-Gm-Features: Ac12FXz7j6ZCD1KpPsfv9iOBu4iKeV--Ltb4TvtOolpiU2Niwq5q2UQwxZ1pFaQ
Message-ID: <CAKPOu+_EfTBxh7xpaRdypD-hnqAbgj-bSdMTZE4uafqMudxBRg@mail.gmail.com>
Subject: Re: [PATCH v2] huge_mm.h: disallow is_huge_zero_folio(NULL)
To: Andrew Morton <akpm@linux-foundation.org>
Cc: david@redhat.com, lorenzo.stoakes@oracle.com, ziy@nvidia.com, 
	baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com, npache@redhat.com, 
	ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org, 
	shikemeng@huaweicloud.com, kasong@tencent.com, nphamcs@gmail.com, 
	bhe@redhat.com, chrisl@kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 28, 2025 at 1:53=E2=80=AFAM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
> OK, but it remains the case that we have seen code which calls
> is_huge_zero_folio() prior to the initialization of huge_zero_folio.
>
> Is this a bug?  I think so.  Should we be checking for recurrences of
> this bug?

Why do you believe it's a bug? To me, as a newbie here, such a call
seems perfectly fine; please explain.

> Also, sigh.  I do dislike seeing VM_WARN_ON_ONCE() in an inline
> function - heaven knows how much bloat that adds.  Defconfig
> mm/huge_memory.o (which has three calls) grows by 80 bytes so I guess
> that's livable with.

Oh, how is this possible? defconfig has CONFIG_DEBUG_VM=3Dn and that
means VM_WARN_ON_ONCE() is just BUILD_BUG_ON_INVALID() which should
generate no code at all.
Here on my computer (aarch64 with GCC 14), the size (and the
disassembly) is exactly the same. This confirms what David Hildenbrand
predicted.
Are you seeing some compiler weirdness, maybe?

