Return-Path: <linux-kernel+bounces-864624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE0E9BFB33D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 11:44:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2BBE189CFA6
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 09:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 060AC28B3E2;
	Wed, 22 Oct 2025 09:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bHdqppXL"
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D48FF2F5330
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 09:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761126245; cv=none; b=Uzzyt6aIoB0PQImK3fKPT7rb0nJ5yNyV8d86PzbqAooWD/ZdZ7KX8DCPrDvyYBJzu+33eu6wbTCPaoAtBONuAjkk+ys76Qwr9rKADfxGMlnQtaUA1y9bDCHKItpbN3a5WPajNZpUQKNdl5iMhWBELkfSYKSzDjUqFOEwOuBn4Pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761126245; c=relaxed/simple;
	bh=UIlHCnSUg7Sz6EMxU9JoMcjFVpE9+lYXJBhrkV15us0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uf8MNbClVHIHrWWh8hFgzVE5fIUmgWsIaSofouwKs3kdOq4n8bxprU1/FbS7mvGLwftXamvSn7aWwLajBKCpClREDAm2ByGEaQAMlD4GbxXGDTXu0kFWgxcMyoaDKtlh62uy0vnJuj1NHlIU4ARRtO5kxpgnDqMvmX0A3DDhL64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bHdqppXL; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4e8a9b35356so9915411cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 02:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761126241; x=1761731041; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UIlHCnSUg7Sz6EMxU9JoMcjFVpE9+lYXJBhrkV15us0=;
        b=bHdqppXLGq88usyB7Iiz2oQKuq9esKlQKWDxYSuj6S6e49HrKv+FGMqUijvXNm95Ti
         v9LThFoi2ni26lMfxYfBCCSHhj+R90u/s6SVKfeNfoZasyn3/pyyn8pIpLAEPqNvv7v9
         p8WXLRXngiXnVUTqIXhXKqyhhPLYN08om20V/zc6E2qL5n8kqgAHhxOq9itqpkpVItje
         qjHbNZd+oSfckukGqL68Kntu2Ynp8Z8HLuQ9WXHcZfZqyjsXQk42Mb2giAP7odsriZ/K
         UCFlMUbxNe6PEpt8jR6Czlhea51jWSDXLl1mBM4dISGoEi1cH99uQ1JX8U7Caob6tuK4
         JyCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761126241; x=1761731041;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UIlHCnSUg7Sz6EMxU9JoMcjFVpE9+lYXJBhrkV15us0=;
        b=Rwri2zE+gvyO2M7fSTPXYzUWHyl7vnxxuBUbQT0vGYhE43rgEY+whtGHKc/nzdBFyj
         qwboojZobwREHVP2D3ljysEzJYLULBB/7w6dTwN9POxECCyxz76pBoLwwqhRwepYSo3F
         IjhHn3fUznzbfJ5i322lUdHYcDJfMeDSnUDfszxlod3j4SfYn7u1xyB2mlEl+xMr0+7E
         Bevt7abNvN8K1IRfWA8b7+jFKen5E9i+aowC58NTIyu+T4+VpUK7K/1Fm03j9wr03ILV
         gmMY8nLsWhyrKNvAB6l4nBPepqwForABZoTP7Mn0C8jwFusFpTUcsXtAv0sI8tlHCY6r
         kDIA==
X-Forwarded-Encrypted: i=1; AJvYcCXW9xQpi/qWvv6RimkeZ2hR2ynpyXf4WROn4+JbHRhPzOAoh9nOXl0kEFiZZXyRw/diR1fyDAbgkIMS8a4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1fHskxPrsLtMid3B7fw+YCOwBOvEPxlWu814+DmkNvpQN9XQn
	9GdH8GpDj+QfYt3lUhZapvj0vdYeRBwxpJZIcld26HnkHgM8N7BNJGhM/AvaX98IoN/iqLv2Cve
	gEg1q0v3lKTsn3/nmNjS28Pi1lS54IpfnJrISjxSj
X-Gm-Gg: ASbGnctxgb2FteUX+lf38K3iAEeuYfRp0Q+0lgKukz6PmdddmxWvfILukbhka50T0tV
	cEmulxJBt0fG0Z30qUXc/xJVxn41Bnx9sJKVpiimmLpvl9JdQNSblhC6dPAi57IHsN8x9Irp7X9
	WdxUZaJ2dj4m7oIN1LB+ieFF8I2wTIHP+tInfU2l2tcU2bOyUs4ENu9tZPhAAwtt4B1csm81INa
	6pCEgvWJ/IsJHQJzcW8SYF1rdPNk3exTmYcQYOAUPdUfljeyFeVCq8kCbVbBviTZmqM2yPqe3eB
	bCB3f66uudFDwZ0Q8WYVCO1IIoYBOaPTxDlG
X-Google-Smtp-Source: AGHT+IHMVaR1KLvSbLKE55rXsDOxB9pFk2q8FBKOFas3Va8erj7vqYTEhEid6Fc8ZQJmCt6ROs9GdCqYImYUM+78EQo=
X-Received: by 2002:a05:622a:1450:b0:4e8:ad2a:b0cf with SMTP id
 d75a77b69052e-4e8ad2adeb5mr171413751cf.9.1761126240464; Wed, 22 Oct 2025
 02:44:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250930115600.709776-2-aleksei.nikiforov@linux.ibm.com>
In-Reply-To: <20250930115600.709776-2-aleksei.nikiforov@linux.ibm.com>
From: Alexander Potapenko <glider@google.com>
Date: Wed, 22 Oct 2025 11:43:24 +0200
X-Gm-Features: AS18NWCvJIsDRRmmPGlRlrKGRNevHIxIdBHxPohsj_ockyK-Yc0HtDMQf0r6L8g
Message-ID: <CAG_fn=XM_HRovM+VanVsNoi2ug1HQ1yx8oBhYAj0sVDJsh0nfQ@mail.gmail.com>
Subject: Re: [PATCH] mm/kmsan: Fix kmsan kmalloc hook when no stack depots are
 allocated yet
To: Aleksei Nikiforov <aleksei.nikiforov@linux.ibm.com>
Cc: Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, kasan-dev@googlegroups.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Ilya Leoshkevich <iii@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 30, 2025 at 1:56=E2=80=AFPM Aleksei Nikiforov
<aleksei.nikiforov@linux.ibm.com> wrote:
>
> If no stack depot is allocated yet,
> due to masking out __GFP_RECLAIM flags
> kmsan called from kmalloc cannot allocate stack depot.
> kmsan fails to record origin and report issues.
>
> Reusing flags from kmalloc without modifying them should be safe for kmsa=
n.
> For example, such chain of calls is possible:
> test_uninit_kmalloc -> kmalloc -> __kmalloc_cache_noprof ->
> slab_alloc_node -> slab_post_alloc_hook ->
> kmsan_slab_alloc -> kmsan_internal_poison_memory.
>
> Only when it is called in a context without flags present
> should __GFP_RECLAIM flags be masked.
>
> With this change all kmsan tests start working reliably.

I think this makes sense. The whole __GFP_RECLAIM filtering was mostly
for poisoning local variables, so we don't need it for allocation
hooks.

It is still possible to pass __GFP_RECLAIM to kmsan_poison_memory(), but:
- it is actually not used in the entire codebase;
- the documentation clearly states that kmsan_poison_memory() will be
allocating memory, so one should be mindful of passing wrong GFP
flags.

> Signed-off-by: Aleksei Nikiforov <aleksei.nikiforov@linux.ibm.com>

Reviewed-by: Alexander Potapenko <glider@google.com>

