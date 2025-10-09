Return-Path: <linux-kernel+bounces-846680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F81EBC8BA8
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 13:18:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F4293C04DB
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 11:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53D882DF153;
	Thu,  9 Oct 2025 11:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h/Bh1hRY"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FDB725D53C
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 11:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760008674; cv=none; b=W0B360mO2gUHGugSdo2js7EMe3kDjTJYkvbFXDhEj/3lz/FPshzMSiNkRcX63VbXF/XlZlwAL06GufujsOCYMuGe12nf07n4hFzEMX30gH4U/U3jeohyvvTj4sPAE8pxcIJsl2MzESm51B5s09jVTEqutas86WxnwKwGYSd5WWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760008674; c=relaxed/simple;
	bh=WCD/CAfB1G/FRBM8fWx7yMrkRvfIIG1WNz92HG5xPeQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MYLRr3fbgkbH+zaCiNjfS17avFzGzhAwYBrq0AD3Moe6nZRdJXTGmosvcw3+lYh+e+ocwstE9ZD9Lc7fiT0wyAu/2/k7uKdIgp+ZHP47kNSj+vHTkVh9o99Mto7k3KdcF5B1QVcu3Zmekt+EvVDXG3e5IdQ2YoZJTUcIE5+ht9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=h/Bh1hRY; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-46b303f6c9cso6586295e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 04:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760008671; x=1760613471; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9V+rmx7EVh5VI0c3HgYqM0kYENxMSiiGZS93FmTbvHY=;
        b=h/Bh1hRYFwCy//G9bitEyswKpWz6jclO5gwlOMlAErhNWutwR9pMiUFhDEVplEva+O
         yNh7RrDWpU42iqZp07U14xmPHz4aLVBTWfE4doBgLL72rjH7tyEwOTlG36gNhMdSv/5o
         7W1PwvphuDrKEpSi71RtQD222H245pzI2OXRNd6/fytAMqlEIt8UZ3g8zpEjO42is3wn
         t6XJVuuqEqyGdrdt9z8T/URUZwhHL1Ya6wlg3zXi4hC24Bzy0tSb/Y6KAaJ3WzEr/Ja0
         JhKpP2wV4mfel41RUqwWO6YOz+dr6lhJYoryiJglcK/W8CEMTJQn3oxxTXWOzotD/xy5
         wEzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760008671; x=1760613471;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9V+rmx7EVh5VI0c3HgYqM0kYENxMSiiGZS93FmTbvHY=;
        b=qH5BIO07sD574Cs5YXKRnC4oMnriMvKhI7WTEEqt6NNmumth2QJkufug9k7j8WYO3p
         la3amW3Cax14S26vYzwKLYVQ7ibeJLinMDkv1ywxjGsSC3GlY0RnO0/BcD5WwhBrsr02
         Q72ZhAxfwY29SofVMMmLzgzelpR9K4IMRfMk2D6gwgukRYHwOY03Bv8yg1KFN/Mj1iqQ
         xUHV6qVFADL1B3mPDFOwOE9HXf7Ku1NNM6L5G82czkBboKMVsWY6szk8HJjuR3Za1PM5
         5LizmsJPhZ88Dg9vM4l2SI+baJXqUZmm1pAdqZ5ZgPd0NsO6mDZoy73zjNStmlLvh1po
         0GIA==
X-Forwarded-Encrypted: i=1; AJvYcCUUdbdGin+F/OxCMBuLJIcnjjkzS7sckbJj5VTY3ACHH+tCAlakzB5Pcfswuv4hRtETAt+BAsP6SuWcD1o=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywz1Ll1p4H9+HyyjOsOBcQ3T3rRJZFmj4jW4ojofv0xU/7dVE8W
	JeAYCrBpgwhREbCt4/HRKhUvD6vzTA83c1YDvMXyDmYrTvQn6ho1q+8Y85JEstcvHY9qx3cVIXG
	CSZ+KFLyflNr+7uQjKw==
X-Google-Smtp-Source: AGHT+IHQw/K1TucPKWkYddnQPYm60dywH4XygHGaugmTTi9j0hJVxv8XQQDUDwaI/iz2G9F3qXxpGXrzXS4lbaU=
X-Received: from wmcm4.prod.google.com ([2002:a7b:ce04:0:b0:45d:cfa4:ce19])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:502c:b0:46e:3d41:5fe6 with SMTP id 5b1f17b1804b1-46fa9a9ebb8mr46744985e9.9.1760008671266;
 Thu, 09 Oct 2025 04:17:51 -0700 (PDT)
Date: Thu, 9 Oct 2025 11:17:50 +0000
In-Reply-To: <aOaJlHEPzHcAdcUx@tardis-2.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251008151554.340806-1-marco.crivellari@suse.com>
 <20251008151554.340806-3-marco.crivellari@suse.com> <aOaJlHEPzHcAdcUx@tardis-2.local>
Message-ID: <aOeZ3ho6SHjmaw_2@google.com>
Subject: Re: [PATCH v3 2/2] rust: add system_percpu() around the new system_percpu_wq
From: Alice Ryhl <aliceryhl@google.com>
To: Boqun Feng <boqun.feng@gmail.com>, Tejun Heo <tj@kernel.org>
Cc: Marco Crivellari <marco.crivellari@suse.com>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Michal Hocko <mhocko@suse.com>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>
Content-Type: text/plain; charset="utf-8"

On Wed, Oct 08, 2025 at 08:56:04AM -0700, Boqun Feng wrote:
> On Wed, Oct 08, 2025 at 05:15:54PM +0200, Marco Crivellari wrote:
> > The C code defines 2 new workqueues: system_percpu_wq and system_dfl_wq,
> > respectively the futures replacement for system_wq and system_unbound_wq.
> > 
> > This change introduce system_percpu(), that use the new system_percpu_wq.
> > 
> > system_wq will be replaced in a future release cycle and should
> > not be used.
> > 
> > Suggested-by: Tejun Heo <tj@kernel.org>
> > Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
> 
> If we were to expose the system_percpu_wq to Rust, then we should also
> add queue_work_on() API to Rust, otherwise it's kinda pointless IMO.
> 
> PS. We can use the CpuId abstraction:
> 
> 	http://rust.docs.kernel.org/kernel/cpu/struct.CpuId.html
> 
> and have an API like:
> 
>     ipml Queue {
>         pub fn queue_on(&self, cpu: CpuId, w: W) -> W::EqueueOutput
>     }
> 
> or maybe a different new type `PerCpuQueue`?
> 
> Regards,
> Boqun

How is it ... can we cleanly separate queues into those where you must
specify the cpuid, and those where you shouldn't?

Alice

