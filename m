Return-Path: <linux-kernel+bounces-848853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B5645BCEB29
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 00:34:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2450B4E1FAC
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 22:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39E6B2773ED;
	Fri, 10 Oct 2025 22:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Fv8sx2Qo"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4243A2586E8
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 22:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760135643; cv=none; b=sQbm0rGZ1VcYpbpPBkOCUFRZUQMzTEVy9+0dQZxf1ilVBF4oRE/ZO9tPNfbQQi1ip2Txs7gknTrYpJ0YcVgBBa6ZRz4n3ZTmtouMrQ2a4fVU5rkA9EfDZafSorWiv7uE2iMTw5GIJlEB+7mquk7sfLJS359gLYAA6ok58xUsGh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760135643; c=relaxed/simple;
	bh=I/cP/AoCDjjIwt2MtAJcP1otDSu5TbDmKw2vzr+vPcE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=F3XjSlv9ShNz0Jf3hWWMOX+PdS8oyo2g4L3hB4SQ+6CMiRQVbeo0xL1RX/1WbBymDs9YmSGCzg/8JI1fAjw4VTC73h2NQDHzM5kSi5dLwCCs0DxEmjjk89u9adkA48ygRj1IUD7Kl07yQFtpNlPe6pWQTytQpimsxvuN1gK0O5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Fv8sx2Qo; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b62f9247dd1so5958045a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 15:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760135641; x=1760740441; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SxXT6Zb58W33V3XDCfganTpzZzUvadE/827Eg8uHBz0=;
        b=Fv8sx2QoEJcgZo0qO1GKlKzzSqL2Y9NFKRiqcD3Ey9XsgBgNLKCr41pYKrRwzzBb4J
         3VXoQyqehwsDziccGriCxavrfTWzs6A/+aoFrj+8OMcCOLgfJkkt1vDg/3hDwxJ+pK5S
         AYZIwvTupsQHV+lalpjslxDYRfHEqztwvc/19YmrLbINkZdJt1Hr7t8gVPVxqrwZByGY
         nU2SEfVypCp9Msw/x7OxrQtxx9waVaRSdKgsjH2oESzgkefNUDphabl7nX4+OzIQTirX
         soS0HwkKUbRg3XyGUW4FuOzDooD6by802rStVCSepZEyzHRGjs7+X/1K4mZZcRQlvQXS
         06IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760135641; x=1760740441;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SxXT6Zb58W33V3XDCfganTpzZzUvadE/827Eg8uHBz0=;
        b=dTQJXgVIXslmsRVE8cHd+e7y+fieFThQeAKxsCf6O+A3VVZ5XRxONzLPGSDDju70rK
         YukTcLqRTfikqvGavkVc4aGhm/BcmOaEe28Sv32GOSaeM151pynjRW50/NHySWv4FYe5
         wMYTutJ+F9fxRmqGLXnZw8UcgDlD6VRad2creGBNg9IfIC0ape80p1S3G7z53PC7PmaB
         xj9WUlswrBwp09pCEw5wtM4j1DkAz83eK0iwIJP7UP35rlEfvo/WEY+Xhenbk+aSht6M
         7n2+ehJhZ45r7+MAmN4By2JIjqgJzScV4KpYukJ1BKhlMQhJZeDpBEByXjuZtlnRdwh4
         1XMA==
X-Forwarded-Encrypted: i=1; AJvYcCUBgBBMFPHnMaKAp0gNSnFs5DsFgPK/WKhR/ynOE8GBlz5rVPeGGawbG6jcxtrXfxOySJVqm4ZrVa9lAYQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrO0cKAnb7cvfE0p/TiZt5ETmM/nWi8pu1YCrPCLPGyEZTzTkY
	J2UaFdwfYVTdRNw/jfBg0Edfd3UkZSMBZe8mL0bDRxEFJOiKriNLhTavrZaGwo9l0Mk0OM7wVTY
	qngwrdCCpzbMxbr2tFH0y2WTweg==
X-Google-Smtp-Source: AGHT+IEHEsB7HplgKyiQY18CC50MOfISsxalHVWSfMxRYomdKvktQFnfgJPyfQJLdMMBANaenW2wtgALNKQ1B+fF2Q==
X-Received: from pjto23.prod.google.com ([2002:a17:90a:c717:b0:33b:51fe:1a8b])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:1648:b0:32d:f352:f764 with SMTP id 98e67ed59e1d1-33b51105d58mr17850554a91.2.1760135641187;
 Fri, 10 Oct 2025 15:34:01 -0700 (PDT)
Date: Fri, 10 Oct 2025 15:33:59 -0700
In-Reply-To: <aOmEpZw7DXnuu--l@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251007222733.349460-1-seanjc@google.com> <diqza51zhc4m.fsf@google.com>
 <aOmEpZw7DXnuu--l@google.com>
Message-ID: <diqzsefqfktk.fsf@google.com>
Subject: Re: [PATCH] KVM: guest_memfd: Drop a superfluous local var in kvm_gmem_fault_user_mapping()
From: Ackerley Tng <ackerleytng@google.com>
To: Sean Christopherson <seanjc@google.com>
Cc: pbonzini@redhat.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Sean Christopherson <seanjc@google.com> writes:

> On Thu, Oct 09, 2025, Ackerley Tng wrote:
>> Sean Christopherson <seanjc@google.com> writes:
>> 
>> > Drop the local "int err" that's buried in the middle guest_memfd's user
>> > fault handler to avoid the potential for variable shadowing, e.g. if an
>> > "err" variable were also declared at function scope.
>> >
>> 
>> Is the takeaway here that the variable name "err", if used, should be
>> defined at function scope?
>
> Generally speaking, for generic variables like "err", "r", and "ret", yes, because
> the danger of shadowing is high, while the odds of _wanting_ to contain a return
> code are low.
>
> But as a broad rule, there's simply no "right" answer other than "it depends".
> As Paolo put it, damned if you do, damned if you don't.  See this thread for more:
>
> https://lore.kernel.org/all/YZL1ZiKQVRQd8rZi@google.com
>
>> IOW, would this code have been okay if any other variable name were
>> used, like if err_folio were used instead of err?
>
> Probably not?  Because that has it's own problems.  E.g. then you can end up
> introducing bugs like this:
>
> 	int err;
>
> 	err = blah();
> 	if (err)
> 		goto fault_err;
>
>         folio = kvm_gmem_get_folio(inode, vmf->pgoff);
>         if (IS_ERR(folio)) {
> 		int folio_err = PTR_ERR(folio);
>
> 		if (folio_err == -EAGAIN)
>                         return VM_FAULT_RETRY;
>
> 		goto fault_err;
>         }
>
> 	...
>
> fault_err:
> 	return vmf_error(err);

This is true too. Thanks, I see why it depends.

