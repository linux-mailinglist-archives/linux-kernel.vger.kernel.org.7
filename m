Return-Path: <linux-kernel+bounces-794028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 924C6B3DBAE
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 10:01:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6033B16FC57
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 08:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F5FE23B632;
	Mon,  1 Sep 2025 08:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="bbjPmF5X"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD592AD31
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 08:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756713692; cv=none; b=THoWBmqf8H/UGDV+JCEHcPdNlhUJy4U1ydS1hOvVGuAEDQWMpISdwmQvK+79rnbiRZbE6LLd5NstXvUi3FM+lBopTttwVblrASuBH2C17kTdpfoCMUNVCdMMWnchmxXAd3i29f2PYd1JwsNBYJ9KieOdumM3eb2vAJpWNK9v920=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756713692; c=relaxed/simple;
	bh=ElVgYPiPhFnmapkjg+o9uJKTkd6XvGBVXP9+0Qz77V0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mr3zHIKSD68uEQya4mpWzARt9DyoK9oENkhjxHLZ2IEdC9no4uW+T2nQ8ZrlXLbO6ihBaZCq6Nox5BQPCdYwaiOc711l2eOjDK3+bwgsuUggZO92xS4emMKOD9kqiaToC4ajXzIgr4vian+1/1IR2rHs4W/fnkKt/x6fFupPAn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=bbjPmF5X; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-afcb7ae31caso776329666b.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 01:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1756713689; x=1757318489; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ElVgYPiPhFnmapkjg+o9uJKTkd6XvGBVXP9+0Qz77V0=;
        b=bbjPmF5XIaR4v+fHYWO0DGthTJMVGuNa2eBoxs6DSabY/0E9aySW/lThgGNaL7cck4
         PNmRLJhYFuicsWHBwqzfv6CRdemwN5Yk8TmnIwjlDVfzQn6T9oKymARYj9uIQdBGQFDc
         7wZNGhkKcJqojSpIsK5O23IhODMfxVlKGHP+1tABYu9MePscYFLLKCgZxbpkA0Ubbc1G
         MbIoI0rsSdlSvgxZDbXtTTGexwx0t36AL2UpUZGNXyPpKncEahCAyWrQcCQWCmgykGiv
         67InJFLdhs7On5xTeSCqy1ygb692SEzjPKfEXrqFlbzf7inKRjcdaXCnSm2zjnXDvl9Z
         fXFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756713689; x=1757318489;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ElVgYPiPhFnmapkjg+o9uJKTkd6XvGBVXP9+0Qz77V0=;
        b=W7PgHOA1o+Ro1l/qgQOV+B2HZSLnHn2s6Qhq3zSVHp4oh/HPKi6jRRo/CcDbaj0xqb
         sxm0E/wH2ApCvw+lLxcjGB1CrznAvWykk4QyFNz+aO6KmvVKGzKxOxR5OgmYFbXSZzE5
         GV6BVrU2hUjsBuR9kXWJl/FyylLL+sq7BERqcNUl61b1RKTAXXCM8WNLZD7DimM7YM1V
         oxK3mp1BqE45+YW6C5hO/VxxDYfw6nyYfpNnQqHzr+Asz2lcUzE2i+4oA94Wgo3GKhHs
         rMs5GkRqD4+27OgfMg7KZVPWudiSJ3wB8tWxDnIPya/CbHPpw6h0Zd12q5zR/qksjOzd
         qdmg==
X-Forwarded-Encrypted: i=1; AJvYcCXew+wJO+BbbUYWwhleuk33ItiPIFf45fvkpTonwfYUn3PGZd7nKLAjsJKnz0T8PjjyyVi/7WzCKs9rOCI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxgu4+3ENp14DpmuJkOQyrP8WCCFJH5BbxNKALb1uxS/eG87pnG
	QGvUbsLy7CtUXceG+3v18gPqqm63aVuxn6/0fyaPhDa5ckX/SSsa12EflQb0pzw8XTRcw0L5Icv
	4Yy0HHTlqJoB5WF7ga7et9gvVOs3UYEBUwQnwvWbUXw==
X-Gm-Gg: ASbGnctoeu76z68evcHT45a8Ao+B86nOQwm5pdyggW9MGlo2F2I6Jbpip7S5OlYujHJ
	Ia4k4tPwoshqHRq3X6f+/rC8zlPaA/yel5SfbCz29YbcOIzULPWr112Ok5mfjuz9FrLFVqtctnr
	TyQGE2/ufNENkpo2m2Q/XEbDVi5cw5tfr3vDpNztqiJF3uxj3gcE10zJLSXLtr5VijXOZPbwXbI
	TaCzhGjZo05mPEBtFwCTXbv+mgDxRfcjUk=
X-Google-Smtp-Source: AGHT+IGbf2+rtrG5OsSWDupeVt2DyJOST/f2CR3y0EAEtEchftiG5U1wyRNP5BqRghvnVqjtrLUrmIVj5/y59HxwLBY=
X-Received: by 2002:a17:907:86aa:b0:afe:caf7:6def with SMTP id
 a640c23a62f3a-b01d979a6camr770360566b.54.1756713688363; Mon, 01 Sep 2025
 01:01:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250901061223.2939097-1-max.kellermann@ionos.com>
 <20250901061223.2939097-2-max.kellermann@ionos.com> <052aee05-4cfc-4fa2-8944-4c85676c95ed@lucifer.local>
In-Reply-To: <052aee05-4cfc-4fa2-8944-4c85676c95ed@lucifer.local>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Mon, 1 Sep 2025 10:01:16 +0200
X-Gm-Features: Ac12FXyLver_1AinPcvhgsFNWur1r_pRnDcdlhlX6jXPmQjj6RJlaLuNO2Kj3Wk
Message-ID: <CAKPOu+-A6EoBnJhYkgX3Ktuivo2hpDZtbCKPfcmR_SNsvPQ02g@mail.gmail.com>
Subject: Re: [PATCH v3 01/12] mm/shmem: add `const` to lots of pointer parameters
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: akpm@linux-foundation.org, david@redhat.com, axelrasmussen@google.com, 
	yuanchu@google.com, willy@infradead.org, hughd@google.com, mhocko@suse.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, Liam.Howlett@oracle.com, 
	vbabka@suse.cz, rppt@kernel.org, surenb@google.com, vishal.moola@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 1, 2025 at 9:44=E2=80=AFAM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> On Mon, Sep 01, 2025 at 08:12:12AM +0200, Max Kellermann wrote:
> > For improved const-correctness.
>
> This is not an acceptable commit message, you need to explain what you're=
 doing
> here.
>
> I'm thinking that review will be the same for each...
>
> For instance, reference the fact you're starting with functions at the bo=
ttom of
> the call graph,

My 00/12 already describes that adding "const" to mm addresses the
lowest level so higher levels (outside the scope of this patch set)
are able to constify their APIs.

Other than that, there is exactly one dependency between the patches,
and that is documented in the commit message of 06/12. The rest has no
"bottom" or "top" that I could describe. All other patches are
standalone.

> and mention which functions you're changing.

So you want to have a list of function names in the commit message?
Maybe I'll write a Perl one-liner to extract that from the diff, but
.... will that really be helpful? To me, it looks like noise in a
patch set as trivial as this one.

