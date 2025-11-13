Return-Path: <linux-kernel+bounces-900087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 949E3C5992D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 19:54:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 429C23ABEDE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 18:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED08C31281C;
	Thu, 13 Nov 2025 18:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wI8zZZW/"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD46313522
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 18:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763060061; cv=none; b=gGt9at495JFjBM0e/HnN5Ywavgm83b/53qoI5q905vQslvejMnLbzvQyXOrtwPvO13aNhTiUkS3hcIsC1f6tbJk+Y97i8FskQ51UUmPIWfk2zym8foMtn60wt1KRbCplEJ8fC+h4P3auYKAeAnd2li7ir9hICg4rkxaJ2HZTwSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763060061; c=relaxed/simple;
	bh=FMPyLvuUt/PZ/G5WxsY1vXR+Y88MXaoP25kSbGbbODI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RCXtQr2IyE2xqPwKVp4y04Pk67vE9uPXQ8nN6kFGkl0hG6NpOjOmyuPlAnmKzqvf6dmmXiKmN8Jgf4bCLdhGnZDS+yZOowImLroNlMNM5UeKX1vuMy1etLNs6kM2Bn//fTy7EmxJYi+n2oT0tUTaPry1MQwM4R9jh+shoyjMTvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wI8zZZW/; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-297df52c960so27747645ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 10:54:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763060058; x=1763664858; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8n1/s9RaZEcOt9m3QKGZKQE6sB/YqrRhU3punAll4EM=;
        b=wI8zZZW/VF8Oqchn4RmT5CMgfJc7cIhrIaP5VP04ocNyNIp/6fdsjQMxoglbZpcc+T
         QCMrPhRiwmjUALSNFoWp9hdMPTEKMt7E5J5LQiOpm+7oEnCMqCLfzOfSIdj1uWF3FZcq
         DuxY1rmn1dGoj2BtpBGXMS6xpPBNSGDi9u7TbaQ4D/8Il868LHgZVGKIuP74/oTp4M5R
         49RWsHRpk1cCqroalz2R3tb9YE16d2N5F0HxbRhb/8rrirVxXWawj+hxmdffvL6v9J3f
         2bR8Gyrfh5dvz24OJM5Sz3Og3+0bfqAc+225RX3ePc1h4uypR81DHPoOl95YocGfZ8iO
         B8kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763060058; x=1763664858;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8n1/s9RaZEcOt9m3QKGZKQE6sB/YqrRhU3punAll4EM=;
        b=UPXmQOulIVThjxWQ2DcuCD5HrYCvrcE77BbbhcybLm7yoL6qf5fOBQgJr3d+wIdQjg
         ycuz0AI1qhP0HbAdKtcscI71nBipN/h/Glbc6EwaFdPietHb4QD4q2RVn1+jAR7lXd9p
         ns167qf6hgGz0ptidaE9DbCcUi40DTla2aVqe1BMKIKsHZx468mD7UcutmdGrX34znuN
         cPFQHxNPAZQLhbkDiOBJXxc38+1O59ERaezdXiCQcFV7hFFETRgiur4kyOA/D7g5IvKW
         ugNYmqFRX+iq+x+lYSXSbspVHXt2X7N9aJfdQh8iufr0Z3WtU6pDOxCAbPOgjfv4tiaP
         TbEw==
X-Forwarded-Encrypted: i=1; AJvYcCUs7mVfzaFJ652myjAc5h1aPZSTpZUueOuP0/wAmV2xBscXtaQ5w4aCNrWiCdIKkt5+S90MHM74zFhXryA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzULXb+7UoprrQjtDpXYYMU3CxJd9YE+4DpX0E4lZE6Qv1Scvff
	CRQhxFYGvgpNLlteTbOa3CLtHqhAaVS1PjBk46XdgcIrMIWq/6y/qbhHA5CQ7+95DA7MIp74Fml
	7ouk2cQ==
X-Google-Smtp-Source: AGHT+IEvsarrirvmCeHl1ineeicRUqdZYmQTIKm6UrYT7suNIHa17FzvX/dSYhupzGO5pgYCgT7nAj0KE/M=
X-Received: from plbkw15.prod.google.com ([2002:a17:902:f90f:b0:290:bd15:24ab])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1107:b0:297:e1e1:beb1
 with SMTP id d9443c01a7336-2986a6d684bmr712255ad.16.1763060058279; Thu, 13
 Nov 2025 10:54:18 -0800 (PST)
Date: Thu, 13 Nov 2025 10:54:16 -0800
In-Reply-To: <cover.1761593631.git.thomas.lendacky@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1761593631.git.thomas.lendacky@amd.com>
Message-ID: <aRYpWLUn5IABs1Vx@google.com>
Subject: Re: [PATCH v4 0/4] SEV-SNP guest policy bit support updates
From: Sean Christopherson <seanjc@google.com>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org, 
	linux-crypto@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Michael Roth <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, David Miller <davem@davemloft.net>
Content-Type: text/plain; charset="us-ascii"

On Mon, Oct 27, 2025, Tom Lendacky wrote:
> This series aims to allow more flexibility in specifying SEV-SNP policy
> bits by improving discoverability of supported policy bits from userspace
> and enabling support for newer policy bits.

...

> Tom Lendacky (4):
>   KVM: SEV: Consolidate the SEV policy bits in a single header file
>   crypto: ccp - Add an API to return the supported SEV-SNP policy bits
>   KVM: SEV: Publish supported SEV-SNP policy bits
>   KVM: SEV: Add known supported SEV-SNP policy bits
> 
>  arch/x86/include/uapi/asm/kvm.h |  1 +
>  arch/x86/kvm/svm/sev.c          | 45 ++++++++++++++++++++-------------
>  arch/x86/kvm/svm/svm.h          |  3 ---
>  drivers/crypto/ccp/sev-dev.c    | 37 +++++++++++++++++++++++++++
>  include/linux/psp-sev.h         | 39 ++++++++++++++++++++++++++++
>  5 files changed, 105 insertions(+), 20 deletions(-)

Looks good overall, just the one minor nit.  Given that this adds new KVM uAPI,
and the CCP changes are fairly minor in the grand scheme, my preference would be
to take the entire series through kvm-x86 (with Acks as appropriate).

