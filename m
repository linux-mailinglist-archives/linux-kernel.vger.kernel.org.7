Return-Path: <linux-kernel+bounces-863681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44C59BF8D19
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 22:53:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6B2319C14E4
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 20:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB73A28031D;
	Tue, 21 Oct 2025 20:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gBEICNCx"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7800C27FD72
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 20:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761079982; cv=none; b=kHZJ+EIsdEFYfqLLN7HhKaXjJFw+aliRIgSf2NdTKSA+T140V+GDJ3utBaNzV5m5iFSH+sPm/yvW2UG1W2+RLIgwRTnCcL8IbtnvERGw06P4+oHe+HXsN/UbtQVHCy2x7kmZjz1jnRnsBn6eeICtfMwXExYd1uUfCDahBzrZTFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761079982; c=relaxed/simple;
	bh=35GUA1OLm2UY2rLd5ftsCwqE0YKKZwDoylm8PTqhnKE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IiVYtSN5abzyMJRaylKdVvvWCASeepHHCLvWu9cyhp0XrxKQofNICY6tSA6ZIkbDqrwl5rnQrGzMgbTu4gzFFYXoSUQGEDX/xh18NEl6YvdfZMpKvKeNeRxb2O/XhDgVxoGQo6IxzbR46qg/rRwvZ5B5UyBUxaKyQWzSQvNLjhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gBEICNCx; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-471075c0a18so63523565e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 13:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761079979; x=1761684779; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KX1U3LQDhrzk0zMYgAFvq4hyuRv8alrTza4fIy2YOi0=;
        b=gBEICNCxlgrIEJpwu/ynalYfewOExF+lYyHzRWulwZhqLxdSYByGomo2qd4jW7rZVu
         l3Ls1K2AqdnyURI7j7p8WUAtdsRrrMMw1bgenT2FgfsCuYC+i9W+zFXL0D2iESsfQiK9
         HZdd9YHOD/oszTO8edRWtO6vdbD10fCaVWCRBw8gnESnkNIcHgs0DCLIxrcBn1FWEqfx
         ClPKjDDaXq+19GC+xCXqMRyJgHu7IGNdnv5s0sp/Hh6XSZq/8SHy98E6IQzVeURxzkld
         AXA3VJniz6r2BlEbffdLzAgBREuJgpJH0GEUIlN9z66qDNf5jrU/rI4RKoYGOvHBGAiO
         TFQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761079979; x=1761684779;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KX1U3LQDhrzk0zMYgAFvq4hyuRv8alrTza4fIy2YOi0=;
        b=dEkPzpE5ZVLsPX+lElqFJbdpHo0w21fRl2tWHf9CZ5a+mSi6x7JTdkJD3lBUwGFMFm
         uLrLF0d8MRSKzA10J3OdqeCkz5UvoNpIF0f2NVE2wQwDlkEOnj1UKDpb5i+QANfdx6M2
         hORMSVGuKNbm10GPM2dlpu6WTcIj81jxooxFpGdVTXO9RfIYyn1JLwrbPZ8a3SgMwzP6
         E6MKxipfShHFCJR1WA86SkrpDQjJ26ZD/bmVkLfCVQirM8RWbbhCM4iNy8wfA+xmhIeR
         zqD5kgO3nPFGkH9lFsfHZBIauNajhV9Sw5oSO6QF0Koxu7z30YmKVl1hnzx/NLPuLy5i
         K0AA==
X-Gm-Message-State: AOJu0Yy3YhGebiEB13crU/nEMfQGH0+7K00EmSHFZstBKHRs0UTkeVwX
	vnGsfarEEKx9SCo1MigWtstUHaJfXaEeoRpKbNwhoXyb4rbb6H0hmx7z
X-Gm-Gg: ASbGnctEQktw6Ms2H5HK6gBBcyhCWTFUAiSqj9xipVNOp9BYpGSMspixWbtAoLdk4Lh
	3es+xfBJY0Ue3DfoG7ypbgN5S8EZiSrj/vB6F1i0EfA+y/9V18+AteG/PeQlVH5suVc6JBZq2CD
	9Eq+0f4ns7tlXX9WW18Q34wFt8KvhIc1K0ptWcUMDUeoOcm+YFFlKeMifXD9wkHeGKO0pXM8HFP
	M+Kpx/mFu/OHW3IQ9xfwOMGKF3zdYk9+Rc0Y/VeQpAp7cB5j4El8dvP/8I1nr91Org5vLBxQL2C
	fGiuw5eERHxr1gp2dvrjam37c8o6mM5okItUjRalKhRw3T6kKTtG7daz8QY4IYIERjm6zsypKx/
	BPCPPxa+uPKfIizkMq2waSLH3Wc7/dEjP99BG8B2o+Y7AJSlGLF/wzvTxVNRG3VHOkKfoYKv3xF
	h8MX/XVpPwhLTPc0hNvVpJ1uH05Hmz4LDxFWm0t6L0nFmLhhp04O1L
X-Google-Smtp-Source: AGHT+IG48cx6eMc3yWVGBT0daBkOovb/80ZhUVtFTOZrtyO8Rw6UMLlSBk12jg9YEQoOEfu4lRZoog==
X-Received: by 2002:a05:6000:240c:b0:3fc:c90d:9957 with SMTP id ffacd0b85a97d-42704d6c585mr13473049f8f.16.1761079978558;
        Tue, 21 Oct 2025 13:52:58 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427f009a797sm21895076f8f.27.2025.10.21.13.52.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 13:52:58 -0700 (PDT)
Date: Tue, 21 Oct 2025 21:52:54 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Andrew Cooper
 <andrew.cooper3@citrix.com>, Linus Torvalds
 <torvalds@linux-foundation.org>, kernel test robot <lkp@intel.com>, Russell
 King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org,
 x86@kernel.org, Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman
 <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 linuxppc-dev@lists.ozlabs.org, Paul Walmsley <pjw@kernel.org>, Palmer
 Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org, Heiko
 Carstens <hca@linux.ibm.com>, Christian Borntraeger
 <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>,
 linux-s390@vger.kernel.org, Julia Lawall <Julia.Lawall@inria.fr>, Nicolas
 Palix <nicolas.palix@imag.fr>, Peter Zijlstra <peterz@infradead.org>,
 Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>,
 =?UTF-8?B?QW5kcsOp?= Almeida <andrealmeid@igalia.com>, Alexander Viro
 <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara
 <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Subject: Re: [patch V3 07/12] uaccess: Provide scoped masked user access
 regions
Message-ID: <20251021215254.673dbd35@pumpkin>
In-Reply-To: <874irsz581.ffs@tglx>
References: <20251017085938.150569636@linutronix.de>
	<20251017093030.253004391@linutronix.de>
	<20251020192859.640d7f0a@pumpkin>
	<877bwoz5sp.ffs@tglx>
	<874irsz581.ffs@tglx>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 21 Oct 2025 16:42:22 +0200
Thomas Gleixner <tglx@linutronix.de> wrote:

> On Tue, Oct 21 2025 at 16:29, Thomas Gleixner wrote:
> > On Mon, Oct 20 2025 at 19:28, David Laight wrote:  
> >> There is no requirement to do the accesses in strict memory order
> >> (or to access the lowest address first).
> >> The only constraint is that gaps must be significantly less than 4k.  
> >
> > The requirement is that the access is not spilling over into the kernel
> > address space, which means:
> >
> >        USR_PTR_MAX <= address < (1U << 63)
> >
> > USR_PTR_MAX on x86 is either
> >             (1U << 47) - PAGE_SIZE (4-level page tables)
> >          or (1U << 57) - PAGE_SIZE (5-level page tables)
> >
> > Which means at least ~8 EiB of unmapped space in both cases.
> >
> > The access order does not matter at all.  
> 
> I just noticed that LAM reduces that gap to one page, but then the
> kernel has a 8EiB gap right at the kernel/user boundary, which means
> even in the LAM case an access with less than 8EiB offset from
> USR_PTR_MAX is guaranteed to fault and not to be able to speculatively
> access actual kernel memory.

It wouldn't be a speculative access, it would be a real access.
But 4k (eg a single page) is plenty for 'reasonably sequential'.

Pretty much the only thing that has to be disallowed is a reverse
order memcpy() (or one that accesses the last bytes first) for
copy_to/from_user() if the length parameter is ignored completely.
Linus wasn't brave enough to remove it from the current version
of access_ok().

I do wonder if any other cpu have the same architectural issues
that required the guard page between user and kernel on 32bit x86.
(One is a system call at the end of the last page.)

LAM is one reason why 'masked_user_access' is such a bad name.

	David 

> 
> Thanks,
> 
>         tglx


