Return-Path: <linux-kernel+bounces-806938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ACA9B49DA7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 01:54:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F020E3C6ACF
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 23:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D09B3101D9;
	Mon,  8 Sep 2025 23:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D4UtkBDx"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D5BE1CAB3
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 23:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757375665; cv=none; b=UCT5aQt1tXFEiTi4ecNn/BgjsaaW51dG/1KRTcLGpe1MU4QUsrziXvPST9bgT0xCKRRXvYJVIsRngs0mGkWuRw4CBz7ljyAj8V5gPhHME2EZxK8NHI8AnB/qLUlRvdKRhzE9dEwZd3XRtqTucmUH402X7RzhDikXdV/xTBiyUvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757375665; c=relaxed/simple;
	bh=nqQiLGDt4E8Jq4QZSeVe7zoFw3b3ODJL8vpKGUrpq1Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=P4vk3EQ5fLdFZRzsYZbS1kEZPtiPB1Sa1t2v20DbbCVVEZwKYOY7CHUl1v817MJxio+h9mmK7CQ42mGEEzJvam1GSK+604HCbJW7ggm80tPv51HqaMnggQn62ltf4TdPVEpDud6SBUPxHq80K1SRbXY0/PLZoFxYae1YuUUXE9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=D4UtkBDx; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-772299b3405so10293383b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 16:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757375663; x=1757980463; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=K/rfS9/CYErQEW8MvIwXJiXzKk2lG6NUVw07jdOfv2E=;
        b=D4UtkBDx6kewgzUqBGgAizUJQL+gilwW6/qUW7e1sW9aLGQQJrdZI/uSXgJCkfEsok
         BxXjOZVcva7pGHmBk6fyDs8VvDQm0KHaWgZWAfrT+BZahGLSBNk2fibvaOeHXJLmQkH1
         /gJhA+PUgHl+TV93h2958FIIvV6+PqLKUtlXZPPYQUR+0lXvnb6aw03Lm6G9TDS+ua0f
         yBG3oVWlZHr/eyz43zxB6Fwj4xXSaEwbh8FYRpAW9zsRIMmWjLloCnX5yomvCKf/2HYf
         kTJTbvZcVH7t4a+PbxM9FC3gAaB99cU7SmecDa4l5X2IrsJXJ1jQk9UivSx2CaL3htFY
         IgdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757375663; x=1757980463;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K/rfS9/CYErQEW8MvIwXJiXzKk2lG6NUVw07jdOfv2E=;
        b=uZWOiaC+n9Epst+mP/nC0uS9M/su36aM8YQNVmkK8Wvceyh+1h6YitzYgQD9cXngAB
         2zGvA73SgzuFeTUB47N8N2WJ+PCJenft3FJB8Yd4xJo/WKmO1LcARYdV655l4dfFwmkb
         gP7mBC29f/24r67sz/InpUnfcmr7atkrb5X3KOQJMeP0RRwwroR9giHCMHVjA/SfpaYT
         v0Ua9e+0wXHRgEXbHmiQOBkObHj/jftjDBoRUSiR5l2Vsvs5aI/bmZcRy/+ogeAV1x9H
         lhjwKyojZemy2XvQkvIMh+qhbJIbAJ0dYZzLk8dMEotTG2X0Aa0LXyRkzzcK+fFNnWr9
         Zk/Q==
X-Forwarded-Encrypted: i=1; AJvYcCXMlxh4c/RmuLl6a5aj4fWntsmNXrY+LJEmjWbed0hLs0B69wSgQTuD5/rOvxJhpQq64vGgVQ3m7Y2rf1M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbG9Av71XKmBWePNZ39UUMYbuY0DPlU3Z81wwIGl5n5bcDRiPu
	2cJIqvpHrHutgFDx0YcMIPHB1jbqIDTE4cRJDP6EKR3UbCk89nUFbrmT2QW7PE0+G91ux+luqmx
	z7QQf3w==
X-Google-Smtp-Source: AGHT+IHFuX9HZZ+3Ap9KfIP9YqmTsis1lj1RdPwzOjpZRGAUvoQwOVBBtSltO2l5sj1D1kqm/ucDlsqS4As=
X-Received: from pfet12.prod.google.com ([2002:aa7:938c:0:b0:772:32b1:58f9])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1394:b0:771:ef79:9338
 with SMTP id d2e1a72fcca58-7742def5d1emr11472262b3a.21.1757375663426; Mon, 08
 Sep 2025 16:54:23 -0700 (PDT)
Date: Mon, 8 Sep 2025 16:54:21 -0700
In-Reply-To: <b55f2ab4-da7c-5fed-adab-ceca54282ddb@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250826233734.4011090-1-seanjc@google.com> <b55f2ab4-da7c-5fed-adab-ceca54282ddb@amd.com>
Message-ID: <aL9srWU7gnKJzeig@google.com>
Subject: Re: [PATCH] KVM: SEV: Reject non-positive effective lengths during LAUNCH_UPDATE
From: Sean Christopherson <seanjc@google.com>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Michael Roth <michael.roth@amd.com>
Content-Type: text/plain; charset="us-ascii"

On Mon, Sep 08, 2025, Tom Lendacky wrote:
> On 8/26/25 18:37, Sean Christopherson wrote:
> > diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> > index f4381878a9e5..746a57bf1f71 100644
> > --- a/arch/x86/kvm/svm/sev.c
> > +++ b/arch/x86/kvm/svm/sev.c
> > @@ -2360,6 +2360,8 @@ static int snp_launch_update(struct kvm *kvm, struct kvm_sev_cmd *argp)
> >  		return -EINVAL;
> >  
> >  	npages = params.len / PAGE_SIZE;
> > +	if (npages <= 0)
> > +		return -EINVAL;
> 
> Would it make sense to include a !params.len in the giant if check just
> above this, e.g.:
> 
> 	if (!params.len || !PAGE_ALIGNED(params.len) || ...
> 
> ?
> 
> That way everything related to checking "params" remains in the one
> statement.

Oh, yeah, duh.  I overlooked that the only way for npages to be '0' is if
params.len is '0', because the PAGE_ALIGNED() check will handed len == 1-4095.

Will send a v2.  Thanks Tom!

