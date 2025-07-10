Return-Path: <linux-kernel+bounces-726581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C70CEB00EEA
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 00:46:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E0C01CA7FD8
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 22:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E22C1D432D;
	Thu, 10 Jul 2025 22:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OQmviEOF"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B5DD8633F
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 22:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752187558; cv=none; b=QDd2/3f9dVIlyiTbzpqq0rnW8Atdzwuk16sRFAWwuQpRcsff8lmuha3tgZ7z19z9E9xJKoeNPl+f1dBVv+P8uHhOan/FvH4apWQqSk4enRoX8ImhFDE/22VNSJ4LCsl5wPvR1G46dZbRRQpfLkQxuo3IU9KJMXJAuCNtgks18bY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752187558; c=relaxed/simple;
	bh=ASuthF9LWI0NYc2lvvZiPPexlWyLf6OJpDYK25Z9I1Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WFi1O8DM9f4e8yxzvNkstF9HCVz08WDFz9oJOJHiAhQz8FMINDUKwww1uGcbSbUqwrQAAUevTWEfpDeOyGOjz6RawM4W1k1f3WlY31Fm8dMf5by3Z6jPJTQBEW5nNGb7M4/1GEYqdYEcUAkN6wTXXalR43Vs4Ikpil7swFHSqaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OQmviEOF; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-313fab41f4bso1995126a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 15:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752187556; x=1752792356; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fwKKtCrQ1LTqQDaAmH0rDuR3xsbJlV6bm4J01KtR8OU=;
        b=OQmviEOFcdmrNkbbhqt6p8QRfc2vIHVBd8+V+A4Ivglfg9x50JYLcI3mB9RGoHULKd
         RjsiGlZEtFKOG+IIQHTfw5Q1caij7NdxanlPdrb1X/XI6VEGBjO0gaCa7VrfVt4AFjGE
         BJJn2kI4J7szysXHS/alo+LLTn19JyEYrzpVNeyFnCxXRuLBUfHJXCGFOCEwz4AbyQUy
         WUw/6QLes0rk65cE5Wvq5ENNboVi6wupd/Efuzr1mj2FCqvlEHci+aEsohsKnJC53Bml
         kOiZHND/5iPHcWAq+pA98/um8QXxNNpZwsSisMatsRgubO8PdUfmJ5YrEzZxbp9xLOux
         TREQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752187556; x=1752792356;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fwKKtCrQ1LTqQDaAmH0rDuR3xsbJlV6bm4J01KtR8OU=;
        b=Tn5BulIz2MssNiE7qdbmqcUj8+oFZqwyt6ykvzg4reCWGpWOJS5NEw7LGhpN2AZ1yY
         tWO+pzX4OFPcQ+9N5rMg/fS5Uvd8NIV2MX5m+VsWER1DVcc/iHKy3ttnYKIVZceNLvZi
         b86YJ1g6UFV7az3D0msCxi5PIPfzyUkY3VS3mvwoxmq2q3VvjF+Xl+mMi9QSul53Cv6u
         vgL+CWC3khZjXRLIs43AddaEDM//grI6f5n4wOqGRu57gJTQnStUGpI0AmdwcPrursT1
         kKTTfd0t8UgQZCp+kSJYMGXoOECwuF4zuN3T2t04NmZ2qf+5kkTH/Yb0Pzjmqg3AD3pq
         OyDA==
X-Forwarded-Encrypted: i=1; AJvYcCW4B3LJx0XxZC0AtEZQalPNf9ePgtbAb8Y7yEpJbThWBrQlAZcOB8zQF3RaB6zgCBvSn40PTtVjHkeu3Bo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/ojnhB///MMJRjYd2ofL+T0/EFySgQFm8PD6wOOntzcfmnfgW
	JkQ+Bs3Ry6NaiiSAEpoew/Pn+cGTUQrqM4b+I7KWDByPy1bH6OflF/Y5ALIfK9bmFSrUSPz+otM
	rw9RzIg==
X-Google-Smtp-Source: AGHT+IFQLQws1wpWWj98zj6rPS2OtIN8GnmNDuftIFZrOMVh3t4f8o5j5+Wr0jCvHRAFb/wHyUgHGLmdh74=
X-Received: from pjbqo16.prod.google.com ([2002:a17:90b:3dd0:b0:312:14e5:174b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3d86:b0:313:d6ce:6c6e
 with SMTP id 98e67ed59e1d1-31c4ca845e2mr1681544a91.8.1752187555916; Thu, 10
 Jul 2025 15:45:55 -0700 (PDT)
Date: Thu, 10 Jul 2025 15:45:54 -0700
In-Reply-To: <a5dbf066-a999-42d4-8d0f-6dae66ef0b98@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250630202319.56331-1-prsampat@amd.com> <20250630202319.56331-2-prsampat@amd.com>
 <aG0jxWk1eor1A_Gd@google.com> <a5dbf066-a999-42d4-8d0f-6dae66ef0b98@amd.com>
Message-ID: <aHBCosztx8QWC4G0@google.com>
Subject: Re: [PATCH 1/1] crypto: ccp - Add the SNP_VERIFY_MITIGATION command
From: Sean Christopherson <seanjc@google.com>
To: "Pratik R. Sampat" <prsampat@amd.com>
Cc: linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, 
	ashish.kalra@amd.com, thomas.lendacky@amd.com, john.allen@amd.com, 
	herbert@gondor.apana.org.au, bp@alien8.de, michael.roth@amd.com, aik@amd.com, 
	pbonzini@redhat.com
Content-Type: text/plain; charset="us-ascii"

On Wed, Jul 09, 2025, Pratik R. Sampat wrote:
> Hi Sean,
> 
> On 7/8/25 8:57 AM, Sean Christopherson wrote:
> > On Mon, Jun 30, 2025, Pratik R. Sampat wrote:
> >> The SEV-SNP firmware provides the SNP_VERIFY_MITIGATION command, which
> >> can be used to query the status of currently supported vulnerability
> >> mitigations and to initiate mitigations within the firmware.
> >>
> >> See SEV-SNP Firmware ABI specifications 1.58, SNP_VERIFY_MITIGATION for
> >> more details.
> > 
> > Nothing here explains why this needs to be exposed directly to userspace.
> 
> The general idea is that not all mitigations may/can be applied
> immediately, for ex: some mitigations may require all the guest to be
> shutdown before they can be applied. So a host userspace interface to
> query+apply mitigations can be useful for that coordination before
> attempting to apply the mitigation.

But why expose ioctls to effectively give userspace direct access to firmware?
E.g. why not configure firmware mitigations via the kernel's upcoming
Attack Vector Controls.

https://lore.kernel.org/all/20250707183316.1349127-1-david.kaplan@amd.com

