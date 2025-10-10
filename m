Return-Path: <linux-kernel+bounces-848844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70FB1BCEAD7
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 00:11:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F978540CD9
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 22:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E919271441;
	Fri, 10 Oct 2025 22:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wvcq7pVB"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A661D435F
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 22:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760134312; cv=none; b=Q/fEiSnqeuJ9X3x2NqdKN5Kusmn1nHDLMoU3B2AmywFqSvDfjpT4wY10jYcFN6YduKAMCGYR4QBpd0Log5qHh2DNsIJc/hjncVT2qRC+xMgssEGgxXkYzqcw8bYLEsBRmmY28zougpRjQpzOVRnzIOrMs0C+EgWth3C3r8y7VWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760134312; c=relaxed/simple;
	bh=OvwE6536qJTPNbEdVMU8lrBXHJm3oc58O4QL6qpjGlE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PgGH6HzRYn1qRxX/AC9e1uelatgfSn8Mv40yZDZD9UyYk5Wy2miprwK85Z2/WZz0tDxAzyRWZxhM7K3v7aVyUVcP0KwQoal0NERV8G5j6hQpfyaWVFgMWboJfjvnHQVWAGR5BWiXYadDv1+R1QHwpnDjgJXtEugkKph4RNR4Z+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wvcq7pVB; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-782063922ceso4340438b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 15:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760134311; x=1760739111; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lsGM3Vvqi7Jw7i+T3f4D5/+jU4naDXyzda2rNALXGHk=;
        b=wvcq7pVBE28ccIsZksQXypsPRyBqUehvzxGhsiryXlWUYyHtzXf29cPHsvSLX8haIA
         vUEA/S/SwwO6ARzcqkgMEztDIfDljOFUKwJJYCfb+/qRzR9SrIBPcZhXH1AMVOtWUslF
         hclxL/k8agVytTYI6Gt43AwJmhL/us8uwuR3B4Wi1eZ8NkWYf0jnh/LhNUyQPxFWuVFj
         d0t//CHzhnAJK+mw7mcHpLNdgUDxx9mjLWZkEUamXKbRA5kTb1Iu/U5Z3cIUPJFvIQCy
         QgIZW3T/MJ4lCeoUpxg3A6cIeuttqUCNNbn5On9Wy0xvw1lVyffIwibjeBKFUC0aNnKD
         zDSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760134311; x=1760739111;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lsGM3Vvqi7Jw7i+T3f4D5/+jU4naDXyzda2rNALXGHk=;
        b=ieR75mjL+rOEEEysOP5MHsABLJVYT5TybvbLjBNktfea4+gWo233coPE0FGsUV8xzq
         Vm0UunExIYB+bhXPfvOTVDAww10At9dtLix2pGfkBX5el4eFr/558O3cOFuzVwOKElCJ
         EOmrUasvFUSyWTDhADmGBi4CQsR+A8ac0fmCGMTqqepkgJppgpO4GwRq8aiGgrjJ+Kq1
         16JLjNS8o8/WQRF+yjkH7zVzEpDkBXarmSQME5+KBODyGM22kha/9MmuqSWHtjBub4Ss
         Zkgkmb/UY1F8FvfhqPdNHxnzNeNwRFKX9Fq9HNjxFL8Tsj6vfYFJQ6GLoL7++GhGgmkK
         L0bA==
X-Forwarded-Encrypted: i=1; AJvYcCWHZZYzEEUxkcHsWlYpak01vuje6DODQ8L8ogXoVBX68N8dj9qu8HTYF8PkTGMII0oxWq63brB4uIiLtu4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2P0i7Lo1bcv34KR7X7ZM9ZkGde5RV2sZzGOR5SVF4Kt1asiRp
	haxwzmxhK4BzaG7NfI2MZ0IlissI7SsDYy0KbPQAleC/+oZHeUx9FemP5BTQWGAqwSMmjzOj9DF
	+3bePEg==
X-Google-Smtp-Source: AGHT+IFenC+Mrk91YZKniRHtOPi6sCMsCmTjdEzSwur6Lz9eCcJ6uSs2AJYWWqNdymTHXhX3NPlq6N0kfX0=
X-Received: from pjbbx22.prod.google.com ([2002:a17:90a:f496:b0:330:a006:a384])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4d05:b0:32e:96b1:fb70
 with SMTP id 98e67ed59e1d1-33b51118904mr19833208a91.12.1760134310888; Fri, 10
 Oct 2025 15:11:50 -0700 (PDT)
Date: Fri, 10 Oct 2025 15:11:49 -0700
In-Reply-To: <diqza51zhc4m.fsf@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251007222733.349460-1-seanjc@google.com> <diqza51zhc4m.fsf@google.com>
Message-ID: <aOmEpZw7DXnuu--l@google.com>
Subject: Re: [PATCH] KVM: guest_memfd: Drop a superfluous local var in kvm_gmem_fault_user_mapping()
From: Sean Christopherson <seanjc@google.com>
To: Ackerley Tng <ackerleytng@google.com>
Cc: pbonzini@redhat.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, Oct 09, 2025, Ackerley Tng wrote:
> Sean Christopherson <seanjc@google.com> writes:
> 
> > Drop the local "int err" that's buried in the middle guest_memfd's user
> > fault handler to avoid the potential for variable shadowing, e.g. if an
> > "err" variable were also declared at function scope.
> >
> 
> Is the takeaway here that the variable name "err", if used, should be
> defined at function scope?

Generally speaking, for generic variables like "err", "r", and "ret", yes, because
the danger of shadowing is high, while the odds of _wanting_ to contain a return
code are low.

But as a broad rule, there's simply no "right" answer other than "it depends".
As Paolo put it, damned if you do, damned if you don't.  See this thread for more:

https://lore.kernel.org/all/YZL1ZiKQVRQd8rZi@google.com

> IOW, would this code have been okay if any other variable name were
> used, like if err_folio were used instead of err?

Probably not?  Because that has it's own problems.  E.g. then you can end up
introducing bugs like this:

	int err;

	err = blah();
	if (err)
		goto fault_err;

        folio = kvm_gmem_get_folio(inode, vmf->pgoff);
        if (IS_ERR(folio)) {
		int folio_err = PTR_ERR(folio);

		if (folio_err == -EAGAIN)
                        return VM_FAULT_RETRY;

		goto fault_err;
        }

	...

fault_err:
	return vmf_error(err);

