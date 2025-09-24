Return-Path: <linux-kernel+bounces-831082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47A4FB9B7CC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 20:30:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFDC62E7B6E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 18:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33451281358;
	Wed, 24 Sep 2025 18:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YNMHctgJ"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F86414EC73
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 18:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758738637; cv=none; b=TXVbQtqKv8UaeMFtNCVEQM8OoX1hhw/8brjGMiVVEHyM+TLvdiXrd0kXkrohwLqwOcOO9H7fmN44T0Szp33XygPfyzO7vsZyV1Cgdt/SZQJUDNyb8inDKMn9QY56uwaoq/NbYcWEWU+HZWvCDwlrFS1jjqQP/WzXC8uiQ1X++0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758738637; c=relaxed/simple;
	bh=5nqj3fAD1h+T6SNvMIibru9X2ZJzXeYzWYfnhhFeYkU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SCyEUf3hA+1/RD1lijdEfJua6Os3fcVVQsVB6WW1Fel0NWdDamVgou4Bk+IIR7zPE2ChT5AMReqwxFIsYhRw1bE/C1xW2SCP3VQQKGfDQFaB+mAOuJfuYgmbhqqm8Y1AVHEUkIhhwYurAckha38iJG5eSjbvE58yS9nd6pkrMLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YNMHctgJ; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-24458274406so2270435ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 11:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758738635; x=1759343435; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0orpj8kKzOLIoFLQuzfzAYvQ/6+/WjKNXq78Px6yaWs=;
        b=YNMHctgJKvNLiiuciMWP0Qd/KXJO2e3UsIXkRSOHmzVdpg2DMpeed3UWO5JSYln4Mp
         4CWZHU8bGCQJ4k4HkPnsXuOou340DaXsxpSc9teHjOikB7KLXCq1IDdjs4NDaAjZ6cww
         H9F2CCqZSQFLIKyXRTzwnhe+buKEKnkHfwN9Jvc+axYCx+rRXrCVWSpiAORO59Ns+7En
         /fF5jx3x0kazyT0M3osU+/99bASscx1w+JpHP7PlTZPXcT43aTDJkQ5gThjwbPwJsVtz
         WEOOgIlBPsCzHvRTZtGlASd2wEA2m8L5XrO3ltMO8hbXKfFSyrOWVc+fEaaQhe9kP7mA
         tTvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758738635; x=1759343435;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0orpj8kKzOLIoFLQuzfzAYvQ/6+/WjKNXq78Px6yaWs=;
        b=T7qoUn9HALSO1IAK5wvjDCnC1LJPhtitelR29Hj6DXCBsKiErzpaOhJTl+sFvnhdbH
         4JVbBlurwLfnh6wzwGv+Q/9/ofcjD3wQ5Dqqj6y9mrDXKDrcngx27ziFPZ9YzIu9ChLC
         NS3H9BVp/0Lon4/voFyiD/93B4PGppJAR1GMfvdkHYTM68fWLHaiSRpWsJurk+NDQtH5
         68qZ6FXlGKHkAdG7tdoZmulRR1BUcQeSZHwiiGTnZNaNau/2XD/D6raav+FqS7En2zaK
         WOrejNmHMDqA88AEFOA4X1o6t58M3973twHaSxmTfyNYpK++CbkJtDGjH+VBAtESVBf7
         Ql4g==
X-Forwarded-Encrypted: i=1; AJvYcCXUb9Zl3Kai+YLQKCwYAQ/1AOrcpa5vqX3qTNpZt0oKYq9ntA5IjIDAcCelg46NRTr6UbG49BTxSHZ8jio=@vger.kernel.org
X-Gm-Message-State: AOJu0YzECKbqLtWNNfl8Pk+w7bkKauEncgj+VgGhWcRTbTzgcl9OWdZe
	32chch3GMA6WeZJrMAYhjAdefphKWpTiWPaSqCKE7/0LECUA3/Vy59RvhqopJSkjOZ+01PC098I
	7i0lQQw==
X-Google-Smtp-Source: AGHT+IFXo1YtMlm/thVEKH/A2s96aBhqcFtzdeO84CUbY2jR86ggP7c4ogR8CeME5mE1AWN1GkR2fh/uCV4=
X-Received: from plbml5.prod.google.com ([2002:a17:903:34c5:b0:269:b2a5:8823])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ec8b:b0:264:ee2:c40f
 with SMTP id d9443c01a7336-27ed4a665e9mr6995435ad.52.1758738635595; Wed, 24
 Sep 2025 11:30:35 -0700 (PDT)
Date: Wed, 24 Sep 2025 11:30:34 -0700
In-Reply-To: <175873596698.2143185.9486968747074623197.b4-ty@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250919004639.1360453-1-seanjc@google.com> <175873596698.2143185.9486968747074623197.b4-ty@google.com>
Message-ID: <aNQ4yrhId4s5vxt8@google.com>
Subject: Re: [PATCH] KVM: x86: Don't treat ENTER and LEAVE as branches,
 because they aren't
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="us-ascii"

On Wed, Sep 24, 2025, Sean Christopherson wrote:
> On Thu, 18 Sep 2025 17:46:39 -0700, Sean Christopherson wrote:
> > Remove the IsBranch flag from ENTER and LEAVE in KVM's emulator, as ENTER
> > and LEAVE are stack operations, not branches.  Add forced emulation of
> > said instructions to the PMU counters test to prove that KVM diverges from
> > hardware, and to guard against regressions.
> 
> Applied to kvm-x86 misc, thanks!

Oh, and I opportunistically added the "1 MOV" pointed out by Chao.

> [1/1] KVM: x86: Don't treat ENTER and LEAVE as branches, because they aren't
>       https://github.com/kvm-x86/linux/commit/e8f85d7884e0
> 
> --
> https://github.com/kvm-x86/linux/tree/next

