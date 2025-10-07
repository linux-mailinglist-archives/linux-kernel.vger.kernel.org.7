Return-Path: <linux-kernel+bounces-844896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B3136BC3031
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 01:53:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6A0D34F0AF5
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 23:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 615812777E4;
	Tue,  7 Oct 2025 23:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WjprLjm3"
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED9A2773E5
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 23:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759881178; cv=none; b=Q9Lcbt4/k8LpAI3P+cZQaGBfGgSUfVrAqRx/SQCt330Yo2XP2pE2g5ScdujTOOE/rcmLfJIFEVP4FkGAdFy65VeXADLpwQj3V2YJbDVidV3gwHB2p91xgVK9zxCaKixwEDSk9Ow6HO/oaSgSn1DhlaG4EpuW6tWUjmPfA0M0Yhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759881178; c=relaxed/simple;
	bh=kS74sY1O+BpSAvJrceTnPc0y9keMpb6Ghrsoi+xe+ks=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jNeN5AMKQ3fuFiJHfu9rVBrZIEeqlxv76zG+dRm3Z6bvCJByklnItl5h1ARUqIh/mr3kfuMDu0iE1MmUyHT7iItgZxUaXN4moTkW5j6NslcmOzKgT63nuf8+iCc5wvgQPbCGwsJAtL7/wnjxxFo9V3RDBYJYE9YuMpufpeh4pCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WjprLjm3; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-42e7b22e007so22029705ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 16:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759881176; x=1760485976; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kS74sY1O+BpSAvJrceTnPc0y9keMpb6Ghrsoi+xe+ks=;
        b=WjprLjm3ohppBH7urHjLb2jMKSvMRXR+15+Xtpw3XwXu3dUp/BjZSYP1z4oRP88Nhv
         za9MrJ2BlJK/NvuI617+FeSOijD/oiXtxFlaqstbMy+QD9qxLVeAooGg60ceFQUV2/RQ
         laZT5hKgu8eoTyQsQAEJwDkTCF42nKCK8YcY/kww5Rf1r07gJgsjhUma0suxYS14R2ts
         Sf05/hAFxmDpwPWe34CGqH4Vl/mIJnScqvKJQe5IWbx2SxGzCIAkccTopFnf134L5ykf
         X2QviKJIH4g/zThpADR2a/ZHnQrNDr+ojTJR1BlC2IUkjktE6buhda8iSxaX04mqBB4p
         FHkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759881176; x=1760485976;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kS74sY1O+BpSAvJrceTnPc0y9keMpb6Ghrsoi+xe+ks=;
        b=ChL4WCsVGPw2xDX/w109KhTz8loUDgUS9/9tok6fYyyZAxwQF9jr4IKVQzRLxSw8SO
         gx1R2U9Q1AorCglPmYrh7/yIh8AhoybMx7AqsMcIWQ+TcwwP53rhGVG7fYNwmIH8MPoY
         2jtbCk1QceuTPnk1FvbKhM83K8jTgEJmTCE0ooqNpx0o9w3m+X9fmPL/c9XTyehTo7GI
         P80x+T4sO6jwd5484TrsvaxtB8NaTZp0ITwtKGKvAehGsVt6CCcO0m7hlIhCqJYy/nxa
         Qy92Df779qhpxRbwFclKjcgMsqZkHqaVFYFtQIQJZdZweusptIowpVWUXKT+WH05xePm
         uSwQ==
X-Forwarded-Encrypted: i=1; AJvYcCUjci+jdHwrP0COW19eGZiweywh5M6mEr1DzhvHzKjTybUXWygnsuIGDjtTKx3AavWM20juY98eEI//6Jo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzi3fiQyPmNmfTvYz6kVQpF+9jGYKs11NP8e09CWUFZMhQ23WtF
	doTnRtVt7UcNWyQB8HfVNsy6/M1s9dqbqDOjslCU5sRLbzrRHtLmodL+9TD3hIjFoymEpXCIdWx
	CoPyJYMLdIIU8C+hSRFG61Nn+abr4QxE=
X-Gm-Gg: ASbGncvJqkpIN3cQRI6PZVRT8KxugYMYOV1HfByN5O/+3lwGTYwior0T8Em6UWnElnZ
	LrUuL8AbUAQ5A9Y0zx03QkT6YPk5b63UmIJKK34gf5MiYyDEbMD5qdTGLu2boK4p5zxcM9+EMHL
	rb7ABgI6hoas4u7mapsUEnIbABQ7Iw5MXgehXKbboCATFuy5dTUXtVbDg3rbmFnozR9Df1qrzO2
	P6Ru+/ukAIKTZr4X3KP9xnvutvXdzqvdb1+Fj1c+IRItNU=
X-Google-Smtp-Source: AGHT+IGhorzk2+W/xTGL2848aOlY3Nx+slQICiBj8FIH8pICQTD8gFOQKQ61znfWdK6mZ45eCBiZxnfzCGeIUtkRXco=
X-Received: by 2002:a05:6e02:1a8f:b0:427:b642:235 with SMTP id
 e9e14a558f8ab-42f87374f3bmr12991435ab.10.1759881176249; Tue, 07 Oct 2025
 16:52:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251007-swap-clean-after-swap-table-p1-v1-0-74860ef8ba74@tencent.com>
 <20251007-swap-clean-after-swap-table-p1-v1-1-74860ef8ba74@tencent.com>
In-Reply-To: <20251007-swap-clean-after-swap-table-p1-v1-1-74860ef8ba74@tencent.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Tue, 7 Oct 2025 16:52:43 -0700
X-Gm-Features: AS18NWAzI3OkoEtAtDpIuyhsnz4mBz4te4CIYqMQaeNGgBOGQrrb52ocbOBCeHw
Message-ID: <CAKEwX=PisWyb-Gt=n7ZBPNTNjbRNM5F5j4LE4NoRgTUB+2ZV-w@mail.gmail.com>
Subject: Re: [PATCH 1/4] mm, swap: do not perform synchronous discard during allocation
To: Kairui Song <ryncsn@gmail.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Kairui Song <kasong@tencent.com>, 
	Baoquan He <bhe@redhat.com>, Barry Song <baohua@kernel.org>, Chris Li <chrisl@kernel.org>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, David Hildenbrand <david@redhat.com>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Ying Huang <ying.huang@linux.alibaba.com>, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 6, 2025 at 1:03=E2=80=AFPM Kairui Song <ryncsn@gmail.com> wrote=
:
>
> From: Kairui Song <kasong@tencent.com>
>
> Since commit 1b7e90020eb77 ("mm, swap: use percpu cluster as allocation
> fast path"), swap allocation is protected by a local lock, which means
> we can't do any sleeping calls during allocation.
>
> However, the discard routine is not taken well care of. When the swap
> allocator failed to find any usable cluster, it would look at the
> pending discard cluster and try to issue some blocking discards. It may
> not necessarily sleep, but the cond_resched at the bio layer indicates
> this is wrong when combined with a local lock. And the bio GFP flag used
> for discard bio is also wrong (not atomic).
>
> It's arguable whether this synchronous discard is helpful at all. In
> most cases, the async discard is good enough. And the swap allocator is
> doing very differently at organizing the clusters since the recent
> change, so it is very rare to see discard clusters piling up.
>
> So far, no issues have been observed or reported with typical SSD setups
> under months of high pressure. This issue was found during my code
> review. But by hacking the kernel a bit: adding a mdelay(100) in the
> async discard path, this issue will be observable with WARNING triggered
> by the wrong GFP and cond_resched in the bio layer.
>
> So let's fix this issue in a safe way: remove the synchronous discard in
> the swap allocation path. And when order 0 is failing with all cluster
> list drained on all swap devices, try to do a discard following the swap
> device priority list. If any discards released some cluster, try the
> allocation again. This way, we can still avoid OOM due to swap failure
> if the hardware is very slow and memory pressure is extremely high.
>
> Cc: <stable@vger.kernel.org>
> Fixes: 1b7e90020eb77 ("mm, swap: use percpu cluster as allocation fast pa=
th")
> Signed-off-by: Kairui Song <kasong@tencent.com>
> ---

Seems reasonable to me.

Acked-by: Nhat Pham <nphamcs@gmail.com>

