Return-Path: <linux-kernel+bounces-806939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA353B49DCD
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 02:01:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A71A844391B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 00:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1955D42AA4;
	Tue,  9 Sep 2025 00:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lTibQFap"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B7E74A07
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 00:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757376049; cv=none; b=rq0zBpV1VVyMW6rOmusejdvJhOTNVzdMGFVipc2QdG/dq1nJQ1y6KydmCT/PkyXd76wgJ+84AbNyJIhmAAQfNFSCp0PgtpR09iWjL0VtNxpPJ4VxqiSdMdMBuiMFfNSO0NPOeJ2CcIaKtipjf01YmpWJeisBt972z6FblMriJeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757376049; c=relaxed/simple;
	bh=t43UlVpJasRoQxmkSV3wU/+OU03S3iZK+XwFqLne8/4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=S/lKzfhPoykJZE4bJTSRfP3BAl+NXGJkLK/+ktK3954237aKQGO4WzS74NQnsA/u9hQtxUFslYL2EBM5gJmejnwort7AuI+udaNYFnj9PztCFN62I3c16ClxPNiprgCzCXN9Gac8ihRQF9yt/wa0kOIFkefQ9RP7/sHM5p3qi8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lTibQFap; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-32811874948so4308135a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 17:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757376047; x=1757980847; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=HsJSTvORJeiE9AQsY+DJV4sYMEZ3S3aUT20uePDrvh0=;
        b=lTibQFapm4QWn/J4TXdRViO1Oa/uzU51tR71zZJD/Cmos7nHNkHrvckXhmmFavL+KU
         QcY0Ce8ZnVW/UNFGQuUUI9nW2SCeIe/Bad0wW5eEDyv4DncaPOgakPmDl2Tla2gi9S/F
         OpyzEB/2qNbR4W74Bn7NwQOFRCpQiShgZWj+obyV57zBpcFpYijFO8u4bT5J2FcEfBcA
         toDy24WT+lB7pevWOakh6MjQI5Geo5E9YiOqoYiTkguySRsoj6qEqByvjj1F9GSekB1a
         tqRGUhHxIgEXnvRyi345ln2pds1Mq2yCcM5cOUlrcdbMn38mS5PHJhKPTommFZfI/MdV
         riTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757376047; x=1757980847;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HsJSTvORJeiE9AQsY+DJV4sYMEZ3S3aUT20uePDrvh0=;
        b=kto/8Ts2NPBRpP65KD5pbsOfj6UdR34GKtBdf8vbrpkikXRzkpAwV6zi1Vjmsr4m2t
         OV8jjLJ8IzoE8iKb5YMm/T4xJw48oUVbzo+4vozDF3yTUXXgzrpE7+/wCsKRkjF5RU9J
         Z4bCgHkgEbckBI2BfY2AfoMVg7uoLiT7f3UlRnRaXWUGgNgbar0p/WFI5uaYCHNLraHT
         D/txk7PwbtTeTi+kcW6Oo7of+0PcW1SekZgA7LmEHVZ+ebGWfpYr/ORLJxzjqDMn2tUA
         CM+gV1elSepgSgTNo0qzjUkxcve2zWmrCqb9QGiw+z9iuTDrsDmauTszJNKqZkRwZTgG
         7yFQ==
X-Gm-Message-State: AOJu0YzF/8O9HkrePnHCQIjPRcD7dlletrFCYQKVfO6m+p736YpyGqP0
	5HMF8PKNDSC6PK0dJbUO78gcjRw87iepcLL6eYUl1tpNEnyFz9GcnfV89vLBF8zH9YAl2fFC+7z
	TNGwugQ==
X-Google-Smtp-Source: AGHT+IGN+rw9t4njipIiYxG3sgW7qTh9wknWMp/Sn0+Kp9pr6wiAlds7UuRQrwUPPIjws8ivFi1cX3gkDSc=
X-Received: from pjbsv16.prod.google.com ([2002:a17:90b:5390:b0:327:7035:d848])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3c83:b0:32b:be68:bb35
 with SMTP id 98e67ed59e1d1-32d440cf991mr11855628a91.36.1757376047061; Mon, 08
 Sep 2025 17:00:47 -0700 (PDT)
Date: Mon, 8 Sep 2025 17:00:45 -0700
In-Reply-To: <20250908212925.708769718@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250908212737.353775467@linutronix.de> <20250908212925.708769718@linutronix.de>
Message-ID: <aL9uLYpUcOA9Jt4q@google.com>
Subject: Re: [patch V4 07/36] rseq, virt: Retrigger RSEQ after vcpu_run()
From: Sean Christopherson <seanjc@google.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Michael Jeanson <mjeanson@efficios.com>, 
	Jens Axboe <axboe@kernel.dk>, Paolo Bonzini <pbonzini@redhat.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Peter Zijlstra <peterz@infradead.org>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Boqun Feng <boqun.feng@gmail.com>, x86@kernel.org, Arnd Bergmann <arnd@arndb.de>, 
	Heiko Carstens <hca@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Huacai Chen <chenhuacai@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>
Content-Type: text/plain; charset="us-ascii"

On Mon, Sep 08, 2025, Thomas Gleixner wrote:
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -49,6 +49,7 @@
>  #include <linux/lockdep.h>
>  #include <linux/kthread.h>
>  #include <linux/suspend.h>
> +#include <linux/rseq.h>
>  
>  #include <asm/processor.h>
>  #include <asm/ioctl.h>
> @@ -4466,6 +4467,8 @@ static long kvm_vcpu_ioctl(struct file *
>  		r = kvm_arch_vcpu_ioctl_run(vcpu);
>  		vcpu->wants_to_run = false;
>  

Finally had a lightbulb moment as to how to eat this hack while not stonewalling
the entire series.  Can you add something like:

		/*
		 * FIXME: Remove this hack once all KVM architectures support
		 * the generic TIF bits, i.e. a dedicated TIF_RSEQ.
		 */

to discourage further abuse, and to make it clear that such ugliness isn't anyone's
first choice.  With that,

Acked-by: Sean Christopherson <seanjc@google.com>

> +		rseq_virt_userspace_exit();
> +
>  		trace_kvm_userspace_exit(vcpu->run->exit_reason, r);
>  		break;
>  	}
> 

