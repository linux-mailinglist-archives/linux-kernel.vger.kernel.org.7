Return-Path: <linux-kernel+bounces-855024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A2C3BDFF8D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 20:03:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0DAA19A796C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 18:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 928B43009FA;
	Wed, 15 Oct 2025 18:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wcvHuqQ0"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C3C29C323
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 18:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760551378; cv=none; b=qIc27UVuiiZYnF85iY1jgPiZwNz3nz/5bFngblqKAn6LvSXuA0sqod6Jk9PR73B/B4RFpNfQpx6Glx5dtFPX2EIHQfTXslnzgODLsJclitEnDcwjaJ7HDrhwwg7x2hcXA8rcTLmRHEc8PUnxsQ0ubYHqWiaOWk3wEVNIRUBEoS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760551378; c=relaxed/simple;
	bh=6QCPDCRExOZK4LEydNe0YLg6HUoYLOPH0Yj4jCsSxT4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bQGNo1VSQpUE8gFRiQdmDNK/VCrRF5U9hoobQpDwXcU9bZyJfquXk7YaNq11dhYuzqVq+cGhF9w7A2wHdOdhT1dTugoayNTvNcRGzstbDwP5Wt1Vq0GTh1Tx2fGHvxk93BXL4vc7LSPLatKPv9dNsKD4Eo4PPWxjOhv66CZ4r0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wcvHuqQ0; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-3352a336ee1so22392977a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 11:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760551376; x=1761156176; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ry5mAFjD93bwdmGtL1cu54P4wKF+ZVBcWUkmTraV/hs=;
        b=wcvHuqQ0Ybd1cRuBTUZq/mzFj6dC0hRk8hqnru0luWtQL5HhjXTX93Ep9zNY+dNEDy
         /2iQJTeiBD10BTJ0YSsH6VHoVlUGicVFs8vheriqHFRsEvuY4maKDYwulBYv/Mqpfe+D
         d25+4ukJZcxUr8NVNENh4+pve677+M/V/xhdV1O7g4UXoLkKKqoTqAc3cqLvKtJqL8DG
         cmxxpydW6WqYYW7KN/dh3GuFR4zBw96Mypi/iPB/1PLo88beYaJgFREyibvcaoHZfJhj
         DxwRRaR9pnU1KnV0+4aeDMwMxi/o2E8tKTe1YoNt4g/jgHAja4bKGkUlUOpU9UNYF1sv
         1XRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760551376; x=1761156176;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ry5mAFjD93bwdmGtL1cu54P4wKF+ZVBcWUkmTraV/hs=;
        b=JwLbhoGtrXEXpHHhneygH/ezTXNjCuAebKR1UDSBmMnkJ79W/+t2zHs2HzL+QEJdOX
         pQ8vYpsSNPfwDD0w2PLsa07Zjg4lkqaRygAk2YHMRYbEekLdweDClSJ/VIEHAynE4eRt
         xXaKiOnqI6JCO9qNtBmLIzJRYs5pQvJgeGmWbHpmElKpqjuV53D9xkD/As+9K2eo+Cpd
         9HNdmAr0f+ZKa7sn3ykr6MDQi4//52NKr5CG7A/9jkn8TF6oQldVpTqEi2XdhzqQE9Qy
         7XwRjXSjhn7AaKZLN/LjXzMa8X09f5IENlyRge6BRCvfCoOi70t7MSThmU+ZUKC4SFcP
         MKOA==
X-Forwarded-Encrypted: i=1; AJvYcCVLE/uiLafrhUNaFN/S0tA2MFRAteNT1Q92wYAmM3msClF9ixabgCjGvp4H/wP/WF882ol7lUJNkJsQieM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxstAiizFKtxAhCX2jy5073py/Dc0BgBPvYo2EJwu8opc+ng8iQ
	FzQ82ffeQCKNfGtbxmPU8/N+s3D8OLW/67ck4HpEFh5VNTz9hqd4S5liQMMDEg57DwxHrCEjkL+
	foqro8g==
X-Google-Smtp-Source: AGHT+IH7UnzOFjcdUsIUp5GNVhPuWQjIuGz93nimomrjkve04RPAdXgMZUvIZJRh+o+2q9OLLXkkT+y9Ia4=
X-Received: from pjbsc12.prod.google.com ([2002:a17:90b:510c:b0:33b:9db7:e905])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4b87:b0:339:a4ef:c8b4
 with SMTP id 98e67ed59e1d1-33b513861d8mr38865281a91.28.1760551375781; Wed, 15
 Oct 2025 11:02:55 -0700 (PDT)
Date: Wed, 15 Oct 2025 11:02:38 -0700
In-Reply-To: <20250905091139.110677-1-marco.crivellari@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250905091139.110677-1-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.0.788.g6d19910ace-goog
Message-ID: <176055121712.1529254.17045515819433949532.b4-ty@google.com>
Subject: Re: [PATCH 0/1] KVM: replace wq users and add WQ_PERCPU to
 alloc_workqueue() users
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Marco Crivellari <marco.crivellari@suse.com>
Cc: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Michal Hocko <mhocko@suse.com>, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="utf-8"

On Fri, 05 Sep 2025 11:11:38 +0200, Marco Crivellari wrote:
> Below is a summary of a discussion about the Workqueue API and cpu isolation
> considerations. Details and more information are available here:
> 
>         "workqueue: Always use wq_select_unbound_cpu() for WORK_CPU_UNBOUND."
>         https://lore.kernel.org/all/20250221112003.1dSuoGyc@linutronix.de/
> 
> === Current situation: problems ===
> 
> [...]

Applied to kvm-x86 generic, with a rewritten changelog to tailor it to KVM.

Thanks!

[1/1] KVM: Explicitly allocate/setup irqfd cleanup as per-CPU workqueue
      https://github.com/kvm-x86/linux/commit/9259607ec710

--
https://github.com/kvm-x86/linux/tree/next

