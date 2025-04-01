Return-Path: <linux-kernel+bounces-583568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A869CA77CC0
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Apr 2025 15:52:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 510B73AFA98
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Apr 2025 13:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E60B3202F67;
	Tue,  1 Apr 2025 13:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h4eBnJol"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E86242046A8
	for <linux-kernel@vger.kernel.org>; Tue,  1 Apr 2025 13:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743515433; cv=none; b=ipGCKKzeNpX1JUY4p0nNuF2asfWgZRTA+Bvm+FMEeck1SKMuKgnd0tFE5cdm53c9pp7onHxqUu7TNA3Q0xfluz1g/1fWpsssraUZaG0UwZxEdjXpC/VTrGZ30GKUeiF42tk2JH91ulkwVVlpcFUFYE+3WClTyRwqcY3u7TdHU8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743515433; c=relaxed/simple;
	bh=XFE5r2ZCMZfiB1VRacCvR4HvM7ruBuXbkJsTsR3k7f0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=E0ar3VZzUPe76wNSQfOxWd3Ol8Tlx2ukH0hv+qZtB1gIYhvzhHEG0LCReQayIWiEQSOygSJ3yX9i8PY7xUXw0afWvnDJhv/hO4mJdTa7YpEjKKTLPUuj5vlLeV5VdHukUe6kJ7eydVXuRHuZ9UF9Sxg7W6EN/dJkSKK1V2OQ/pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=h4eBnJol; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2ff798e8c93so9537269a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 01 Apr 2025 06:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743515431; x=1744120231; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3WfaQepZyfqhY1/gdznvWi1BCaJ/jmuLFPNtip4Ezso=;
        b=h4eBnJoliPSkoVQou/ecibG66tbN+V/OZbr1eCsm4R9DZUl7uy+adhv2r/7WUuilIT
         heCsvM+oihqduVaxH+zzqy8ZJunbo7O5g/p0H5r2N5NOVc8fcONLS4jbmGqp5zZWP3n6
         Yv6cmMimPKHl6xXawNV+BV/MgPaxrwGY9ZuyQfF03tEsyvYhUkzyOw3LPfThBz+JUpIa
         4XyKbVBgvm8GaKD8g+T/1pOBAv1Otr4VhnJIIglDI7PxrFngiIkNBY/YPBQKXfPivAKg
         Ys5ljLJKaS06R2S3RQhuJTY6DnOoyu0otFEBrxMmc8csEAq6tT+t6RNllFdbgfj7bZpm
         xAIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743515431; x=1744120231;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3WfaQepZyfqhY1/gdznvWi1BCaJ/jmuLFPNtip4Ezso=;
        b=gwZsM0RFxVsD61pMnecU87qNUtAAjJGHokmuo9k4s7ZZcEjvhvJxcHSonVrTw0tXCv
         9b6caWKu89UdtRyJb9CGi6uNy7k6Nr0z72pVhIS/WROOyh7InejLnjgDOzBsXOsB53ys
         Kj7lJZeDvea5U271eYQYyDM+DODulBP+YL0zDffTIAQLE1RESdDBQCBo4sIZXQeXNvwM
         k9XzRV+n+6/ScQmeCU2GFdFMD5FIMPhJX9LGvZPeDJSB2jrw7I2Yt87SsYPQEubw5uIQ
         C59w1wMlIGnjQqsjGwwuF3OXwhxhu6AUZ96VdrLTRrgixW4bXBTVdygwDhjY/RR1LduB
         997A==
X-Forwarded-Encrypted: i=1; AJvYcCXsFjVfTCN+JzXRmL2sp3rAjKH249TFIK6M5cVHyi6OQOC7AoWUnFZM8+rg7OfpTsU8uOEU0w+D8g39wrg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUpZ95DfPA1l84vI0ocULYeNsJUIQnhJGbO+cOKCuyXnsXGH7I
	LaoXBya1TsiwGM8lozVwH06eQzgFyvoaRt1uKUM+Mpp09vAU1hhfGVk2OMKdkJvc/bB7QsPv06F
	DNg==
X-Google-Smtp-Source: AGHT+IFjeo+lNeBLAG9rmyvReUDtET44boF1eZUVAA5ym3B/uepPlvxsx7/NhJ1YUn7V1m7gdAt3KsNSxqw=
X-Received: from pjbse5.prod.google.com ([2002:a17:90b:5185:b0:2f5:63a:4513])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5685:b0:2ff:698d:ef7c
 with SMTP id 98e67ed59e1d1-30532157b9fmr20047876a91.29.1743515431239; Tue, 01
 Apr 2025 06:50:31 -0700 (PDT)
Date: Tue, 1 Apr 2025 06:50:24 -0700
In-Reply-To: <20250401120507.48218-1-m.lobanov@rosa.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250324175707.19925-1-m.lobanov@rosa.ru> <20250401120507.48218-1-m.lobanov@rosa.ru>
Message-ID: <Z-vvIBP_lENf4Ro8@google.com>
Subject: Re: [PATCH] KVM: x86: forcibly leave SMM mode on vCPU reset
From: Sean Christopherson <seanjc@google.com>
To: Mikhail Lobanov <m.lobanov@rosa.ru>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Maxim Levitsky <mlevitsk@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Content-Type: text/plain; charset="us-ascii"

On Tue, Apr 01, 2025, Mikhail Lobanov wrote:
> Hi,
> 
> Gentle ping on this patch:  
> https://lore.kernel.org/kvm/20250324175707.19925-1-m.lobanov@rosa.ru/
> 
> Sent on March 24, still waiting for feedback.  

It's in the queue.  From Documentation/process/maintainer-kvm-x86.rst:

Timeline
~~~~~~~~
Submissions are typically reviewed and applied in FIFO order, with some wiggle
room for the size of a series, patches that are "cache hot", etc.  Fixes,
especially for the current release and or stable trees, get to jump the queue.
Patches that will be taken through a non-KVM tree (most often through the tip
tree) and/or have other acks/reviews also jump the queue to some extent.

Note, the vast majority of review is done between rc1 and rc6, give or take.
The period between rc6 and the next rc1 is used to catch up on other tasks,
i.e. radio silence during this period isn't unusual.

