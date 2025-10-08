Return-Path: <linux-kernel+bounces-845469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 76BDFBC511F
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 15:00:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 723764F77B7
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 13:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC1CD27B50F;
	Wed,  8 Oct 2025 12:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dpRejHo/"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773AD26CE3F
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 12:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759928396; cv=none; b=P4mUJiu5Ou8LC0y+qU0U9stmzb7tZj1InfVS/XIA7mMRIjn0Qisl4MW2RWfOv/44ul9yjQ72b/zPLuDDzI523dDz1KE0RY3GyFIBR9awm11ymMgMaybQaMrX9Kyp7eT0WHiJouqxSLc7BIgTEibLmDNQLtTEsytnq9MW4Ne/8io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759928396; c=relaxed/simple;
	bh=rpvnoiwVgRwtp5vtftIIzY6dMvIEVla5by01D+997ns=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Q1xHjhFzHRBp+qYyf9UqI5nalhonH37PDbBDFMz09aIYeNmoRhSABlbHjCqJpj94eVTMZE+UaSsixBDiuTyaNA7WSuIPCDq9w7yzBbbs5avgG5VjXvs0km9ZOgsa4XbUWXNZa4/pfkNfN6vVc7nwzXvasQHZmfDXTtoCFIQ3+Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dpRejHo/; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-46e303235e8so63790975e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 05:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759928393; x=1760533193; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=R/gB/5AyaPSdIrAxreQ3UUV2P7u+LQ2v1uTWQNbCwJQ=;
        b=dpRejHo/mzII+Oob0KBLVp4UFi/iy+ErDgbo+ic76LeBOdDXnMS2W1MWoMfOitj9wg
         HC7MnjTNSqoGco4KuhjfxCTmZm6AhQv5Xm6C0piTXPeNPF6+HzOOZ+sc6+ucD5h+F6s2
         nmltKcy4Eklg8XefgQAvQhf9M0LscTIJjmRgoQ3Ied9q9YzSUefhhFrX3uzvQPOv0Hu8
         lzE2CPlXyFykkE0UnTfadBla4OE+x6Wz4yxtUMCfuWdExOsr2pCNhlD/P7Dad8SykF0z
         4WjgR9mKOUcY/7aUWE39ZWu3m8HqWR3llgku8HvP0ExosKr1ehicjPcMNDWakd3pXBt+
         3Rqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759928393; x=1760533193;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R/gB/5AyaPSdIrAxreQ3UUV2P7u+LQ2v1uTWQNbCwJQ=;
        b=iLdcGooF73gRM5lQfWPI8riOHzWndHzucX0L52gkIOcimgIOXQxHv5z5aDsXnsT8/c
         eat0q4SQopyyKAJAENk3w0Uo0A+BbGbDFUbXMkymS7maWUYnRmd/JICpjPBrN7A/TyFw
         Z0qCT9zr7Z6VQH3kB9s0WluJsMbchrFwYR7rrheaEauqqefX8wh6N9gaW/3xKYYA3efB
         L1KmLWhrFmHe9a5gqyaRu7lTSqwwu4LR3XiBC/eH8Lks3aBOuue1SkrQw1P4j+2AQbEe
         0EIrL5zhDO5/yAXjnpqmRym/qMH4iuXQi+OHB3BMJyrErDvQlm4mz/GZgZrEuRBk6Awy
         c12Q==
X-Gm-Message-State: AOJu0YxLhBbdCM2EwPyhSIKUMYYqHoSzYKCknR88IpFR+mu1WgzaQXIW
	+RZV3sx60aFKYKrWCvoCYoPo5QgTt6XJttHRGA/qy1/w7NybIayjI1oXtDvaU41QHY1L5QClpdC
	5YHylDJp7z4VKQgq6Cg==
X-Google-Smtp-Source: AGHT+IHzaS5ipgkkAY1+ObaRaQ9zgsFXNgdU7+XqYJiEUNYrRwbKTaDYoUOFMMqh18xBSjuEhXUBg0G2wiNXGC0=
X-Received: from wmvw6.prod.google.com ([2002:a05:600d:42c6:b0:46f:aa50:d703])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:8718:b0:46e:731b:db0f with SMTP id 5b1f17b1804b1-46fa9b08f09mr20915055e9.28.1759928392960;
 Wed, 08 Oct 2025 05:59:52 -0700 (PDT)
Date: Wed, 8 Oct 2025 12:59:51 +0000
In-Reply-To: <20250908160224.376634-2-marco.crivellari@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250908160224.376634-1-marco.crivellari@suse.com> <20250908160224.376634-2-marco.crivellari@suse.com>
Message-ID: <aOZgR7X5ZyXZh_jc@google.com>
Subject: Re: [PATCH v2 1/2] rust: replace use of system_unbound_wq with system_dfl_wq
From: Alice Ryhl <aliceryhl@google.com>
To: Marco Crivellari <marco.crivellari@suse.com>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Michal Hocko <mhocko@suse.com>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>
Content-Type: text/plain; charset="utf-8"

On Mon, Sep 08, 2025 at 06:02:23PM +0200, Marco Crivellari wrote:
> Currently if a user enqueue a work item using schedule_delayed_work() the
> used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
> WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
> schedule_work() that is using system_wq and queue_work(), that makes use
> again of WORK_CPU_UNBOUND.
> 
> This lack of consistentcy cannot be addressed without refactoring the API.
> 
> system_unbound_wq should be the default workqueue so as not to enforce
> locality constraints for random work whenever it's not required.
> 
> Adding system_dfl_wq to encourage its use when unbound work should be used.
> 
> The old system_unbound_wq will be kept for a few release cycles.
> 
> Suggested-by: Tejun Heo <tj@kernel.org>
> Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
> ---
>  rust/kernel/workqueue.rs | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/rust/kernel/workqueue.rs b/rust/kernel/workqueue.rs
> index f98bd02b838f..01e331a1f11b 100644
> --- a/rust/kernel/workqueue.rs
> +++ b/rust/kernel/workqueue.rs
> @@ -667,11 +667,18 @@ pub fn system_long() -> &'static Queue {
>  /// Workers are not bound to any specific CPU, not concurrency managed, and all queued work items
>  /// are executed immediately as long as `max_active` limit is not reached and resources are
>  /// available.
> +///
> +/// Note: `system_unbound_wq` will be removed in a future release cycle. Use [`system_dfl_wq`] instead.
>  pub fn system_unbound() -> &'static Queue {
>      // SAFETY: `system_unbound_wq` is a C global, always available.
>      unsafe { Queue::from_raw(bindings::system_unbound_wq) }
>  }
>  
> +pub fn system_dfl() -> &'static Queue {
> +    // SAFETY: `system_dfl_wq` is a C global, always available.
> +    unsafe { Queue::from_raw(bindings::system_dfl_wq) }
> +}

Please add documentation to the new methods, similar to the
documentation that existing methods already have.

Alice

