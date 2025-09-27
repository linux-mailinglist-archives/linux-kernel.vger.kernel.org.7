Return-Path: <linux-kernel+bounces-834777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECBF6BA580F
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 03:51:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EBEC622EE0
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 01:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A825720A5E5;
	Sat, 27 Sep 2025 01:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SYhOYqhx"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A631A9F8D
	for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 01:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758937902; cv=none; b=X5zAvYA8v0XAeQ9nq15zVxopTqKFnnpjKkeBuMMUo2koTDhWKg3sRo5ouLLyoqgHZSxpO3LuQ8BCdSFiHZjpHtSgmqZNNg+EdMjA40oO9qK9D/DXU++sy5dZeClS+OE6nXC4B9ewo3TavH6OEi5cT2i5ZQ/osJNeHw1iAmWydb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758937902; c=relaxed/simple;
	bh=qkIQ3n+rzM3+RhfCK0XXihWsQ3Ri2LnrlHgV8TJTCeY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hUTPqTpBQHSKYPOUaggAlnvtAdVoJUAMqTSo2haJ9/+tcRATOxvCbPE6u6vbQV+eHeC9nuxVVVCI3afL5DyUnTgXhX7vNsNDYfJAxDTy59ksTxSQ6ZdtcAOW00xVLtMzVjhtFVnPpZLBFRDM6IcfPQ3/HlG5h0iSTJaZxuD05QI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SYhOYqhx; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-afcb7ae6ed0so430056366b.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 18:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758937899; x=1759542699; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zs1xWPcCbZGD0sIYaMwWpCbxlxVk6Wa8F50KXuKcgSQ=;
        b=SYhOYqhx306KX3uWtk1Dox8S9YJFO9XZlcz9SV+xHBg38KkdwGJTLvkXmdTrRS+PuJ
         CibEpTFXuRvrvfcjMoXWoBIrH84LUQOD8ig9xxqJjBVTH8MXexORF1OwYPjHle3DRRzC
         PjghQ9KAadFfM1JZEn3LApypI2MZ+E2SJUOmOjvRHpSOk492flo2aV+a5HLIaM36k1Jg
         pO6LdE6lPx5RSddadB5dhkB7MOFaaE1ZRWGfdeFw9BmjLmCL5/laihDfM86+NFHbYyXa
         xro+8rbluvbr2v3FCJb4kMwFq2bM7yM5Q8qUDN6YSK11nxlttMibn80xf45b1FqHzuq6
         TvxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758937899; x=1759542699;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zs1xWPcCbZGD0sIYaMwWpCbxlxVk6Wa8F50KXuKcgSQ=;
        b=BnhGmyTCElKXG2m3mu20MGB09RBpzmQVLTYMekLVEykA3LAc2Brwvi5hjON6mC+9x3
         ODX8X7D6zWvaL6iIs4lc04YPq4sHbrLbqMZh/ZcQuqdNDcE/sbhE9PdGudFEtTmLTr4v
         jq9ow7MjSpokKISPxtfhHxrdLk8b8outOxb4ZJvkODM6fqX5dxtYCuMRwDl1s0pEIipW
         MuB3z+hf4zRu4WCbP2fgzS7cDRnHiFvtK0I1lypmMQDsDsS/+xEu7UJN7cLL3JSLfhnn
         NqsPioGLpl/yPu3s1ufanZ7iUx3naQs6V856mPaOpn4+vGIuJdjzF2qPRVnz4M3UD8VE
         GK0g==
X-Forwarded-Encrypted: i=1; AJvYcCVbEhN6KIW7tX7L0Hiiqx8OOzS0ooZIeqbqR0AfJMzOO3NL5X//4KLrjELuYt5wX1F4y0pi0sPLSWypH1o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlwQdAROGeGgz+IYcsvYFrYpnihJbv2xY/jJnmKE4DNzLCpZz5
	ttSB8DQi8j8G7aN7EwfmCqEN/yV4Pb/+tJFCYuH23cEleht2tLnVl3e9b5S7e7jUUM3gdoBNwpW
	bw4k5d8kmxFyIP7+BeOXH1GIZUmx4ZuFjrw==
X-Gm-Gg: ASbGncs5pWWYqQL+jGaW+bOmBlHPCdi/yvS5neyF/NLnaeTOKHMXgfYT9ojUXWHp1A2
	YZpX8a74XvHUPZDo2dHGfRniX3BcxmoNngLotpFKWiGx0x3iGo3mtJGY7G1YglsUGWRBR21NUsQ
	WtF8kXew4bE43pmUy+zVVM6I8UwX/IwhXa3t9WiFz6FpaWzAfdb36kE9H4tKSNDLr2vwHHIoNZo
	Inq2ZLqcOLynAn8q545mQJLCZ5gWd7ywc35lzJPe927srGyaa823snWsOlOaG0=
X-Google-Smtp-Source: AGHT+IGhcqqrtlZvmhw9atNcQRBpQp8K4rlgl9psbV65FPi2trVxKxFvUr52BtENvfA2/K/LOLrXff0m7xxljb1ivIA=
X-Received: by 2002:a17:906:478f:b0:b2c:bf1e:2788 with SMTP id
 a640c23a62f3a-b34bbbd9e1dmr974789866b.39.1758937898582; Fri, 26 Sep 2025
 18:51:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250913-fix-prctl-pdeathsig-race-v1-1-44e2eb426fe9@gmail.com>
 <ef4878fe-3edf-4bd0-bb33-116ced1a4eb8@gmail.com> <20250922154819.c3049158ca006e1561ff5dcb@linux-foundation.org>
 <20250923120344.GA12377@redhat.com> <CAGudoHED4nx8QT-yw-zdcUApUyvt2HCOR9c3SQ3tAm9J7Q1jEQ@mail.gmail.com>
 <20250925162759.GA25838@redhat.com> <CAGudoHGiO8vfyzuRmVHePR_TCeMSXjOv1TFpQ3i8Jk9+RMmTtQ@mail.gmail.com>
 <2a3b72a8-6604-4c7e-a9b1-0c770efb29c6@gmail.com>
In-Reply-To: <2a3b72a8-6604-4c7e-a9b1-0c770efb29c6@gmail.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Sat, 27 Sep 2025 03:51:26 +0200
X-Gm-Features: AS18NWBkJO3XnlGx2QTf1dvNJ2jSGVKP1jes-wB5FdJWhQVn4O7zWEUYMYBwZvY
Message-ID: <CAGudoHF4P-NVSCJGvy6BSeU10tNbbB_oKq=FhtrOzUAaJychig@mail.gmail.com>
Subject: Re: [PATCH] kernel: Prevent prctl(PR_SET_PDEATHSIG) from racing with
 parent process exit
To: Demi Marie Obenour <demiobenour@gmail.com>
Cc: Oleg Nesterov <oleg@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Christian Brauner <brauner@kernel.org>, 
	Linux kernel mailing list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 27, 2025 at 1:58=E2=80=AFAM Demi Marie Obenour
<demiobenour@gmail.com> wrote:
> My personal thought is that prctl(PR_SET_DEATHSIG) is rather rare,
> and also the lock is not held very long.  In particular, exit
> already takes tasklist_lock for writing, and that is much more
> common.  Therefore, I would be shocked if this added any significant
> contention outside of contrived benchmarks.
>

This is my suspicion as well, yes.

> What I _am_ concerned about is potential starvation,
> especially on PREEMPT_RT.  Per the documentation:
>
> > - Because an rwlock_t writer cannot grant its priority to multiple
> >   readers, a preempted low-priority reader will continue holding its lo=
ck,
> >   thus starving even high-priority writers.
>
> This allows any user to hammer tasklist_lock
> at will.  Is that going to be a problem?
>

I can't speak for Oleg, but he also expressed concern over free access
to readlock tasklist, presumably including in this context.

My take is that any thread can already freely abuse the lock in this
manner by spamming waitid or kill (and probably in some other ways).

The existing spots are not trivial to fix. Should someone do it, your
patch is comparatively a minor addition effort-wise.

