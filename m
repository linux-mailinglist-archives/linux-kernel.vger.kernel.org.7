Return-Path: <linux-kernel+bounces-888560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BE8EC3B277
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 14:18:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DBF40505405
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 13:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A293832C305;
	Thu,  6 Nov 2025 13:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C3HBTJkR"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC5F32C333
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 13:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762434508; cv=none; b=vAovaziAAxjg1RYMqZgJEi9muDfrczSZyJYLoLRat+5fsJwx105HqXkc9ZaBBzD4Gra7AtN7gAZSx4jQJvDLItPc+Pnyap2rerWVVCDzSy+EB25f9maAuhugGSRAmhzsCN7otUASvtlGFJ3osKI6qyFCiPsUdfJy7T7+E3Yw5fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762434508; c=relaxed/simple;
	bh=fXOzwH23+ookahwd5aVH4s9O59Gqn2mFDZ8BxYBMUrI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sgkSaCrEanFZegSRntStfP4UE+2XumTSLFMCLUCwDsMDcVWEbK8M8PhazbnJFZJ+ctZkpbQgkKhd1lal9JMwD1qS68lO87PN9SLVyP8g/SD9d6KOaRlk4wIWLg9TJ245TKO0rK1YRyt/TGZhAHTQuGH8fe4tsGwZHtLL7d+r9zE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C3HBTJkR; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-28a5b8b12a1so10159285ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 05:08:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762434507; x=1763039307; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DiKUXXeHtxGgchjjyt6YLNM6oJ9XFDCTJqmUwZLcDQI=;
        b=C3HBTJkRKH8pacN/lOARYm7xOt19xjuHqBos4KbvAul98g5Gg5c4cxZD2Gt/iMJBq3
         Z+fPEqS6NcURRdgxJLNCloOpepzhFtlZ2wGxnmcTQ5PuoJQR3uf/QSQnsJWbwYShdSef
         DUccziwnKzUotGPnkiM6uESanOak+V0zWYcjUsP1KkeUl6QRlvxr0t1EOYA/qJGecXuM
         /dj4kL/5K++Mn/8bcjaxyB2K9UulsPo+hDroVNPTWZ5bPUMNSZa9jLk3kff1UG8HZk0A
         RDcJlcsFN9uKzItteeBhLICJ6Ms+bWOxzwesV97NaGwo4E35Dsps8g0e9TyYMM15YWWT
         nPDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762434507; x=1763039307;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DiKUXXeHtxGgchjjyt6YLNM6oJ9XFDCTJqmUwZLcDQI=;
        b=ifqlMDuTn7mcpw4ZBKJRANtn/QFopsYI7QU8YO8X83+VHYqFbejjRJLosQHHsxMH0c
         H9SVxdJw/RbrgH4Esveco2/dAi8WWnB2KW+IN0N+UTcyu+URhW1Tq2k9eJ+By11hLkGN
         pihz8gLE95TxHAjECe3atXSX06ZTEQv6/N6TJvCaBP9tARg6s9t21M4gOqRGgzVtH1gE
         1ajjuyyZ1CykgmrX6nu/FymaRzBHKm1U7fKsVxrhWi8jiNuae39xbo2tDRjCxlQhuUtF
         WhTgqGqJ956ZjwvG9N89JH/5kRapV9vq39TjRJ38mXt1HQQK0cSrJpBTCV4a0OyAP6EX
         CXlA==
X-Forwarded-Encrypted: i=1; AJvYcCUZTVUlO23M7MFuz6Mcx2e/zzpRdCCHHaPWhO9RWJtcu8KYLzF8vd0GYiFRbhyF6QFsZk2TCf+7Qr41CzM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5SD2BbXDX1hpsEYynwlaFL8QEatEW2NZTOqqNk/FZj//P5lzU
	WwGIRsBQdJaXFA21CsMIK420fw4Bja5pHKR52x5RdHgM2/euRhueni+1
X-Gm-Gg: ASbGncsrhnH/LqjUxfHWoX28uIX/KzekZw7I5XQiE2WhTdnhG48ZGgo7lDouhLS/PwF
	3Xb4Qr3FDrKzPLca0QM9kYtDw0EFVHG1vnKNOcwp0SPAE/IFN7hoJxUWLWOfRwI17p5dL18vLtK
	K+X4kgI9PqnWp7oxejYjXRhJE5RsduhtHzrUkrH7tlFV/ZZw6Kkzo8ZE7h0OTjfvhrm3lajaOcJ
	au0VApbC6XSzrmv+E63Clrz/41eAhNrIWycbSPStLLOFB+KcL8GlVxfw+0ig/6e3naggQnFLn5x
	ysBsXHYRM3xQ6vHrlltpbtv76eyGsP7afso2wq9r9rzUJuBBTbXkvdedcdCXrLRUCTo+FD8kls3
	YRK+jO2x9bMlBCpJ9iZ97lxwnhLv3NDSA82UgIxpKRcjSe8l9ujHNzQ+wuppEtnfl0zjoJu+Dp2
	s/+qEdoP7fXC9vjMCkX7pJVf+BiA==
X-Google-Smtp-Source: AGHT+IE58JuV5i1D6ly/rqum2FQefP1CgkfT3QO4ht/oHVyJQYHM1C33Yzh8g6xhgVumYzltifu0Gw==
X-Received: by 2002:a17:903:3d0f:b0:252:50ad:4e6f with SMTP id d9443c01a7336-2962ade2bccmr97176955ad.54.1762434506664;
        Thu, 06 Nov 2025 05:08:26 -0800 (PST)
Received: from 2a2a0ba7cec8 ([113.102.237.74])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651c8ef47sm28931545ad.74.2025.11.06.05.08.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 05:08:26 -0800 (PST)
Date: Thu, 6 Nov 2025 13:08:22 +0000
From: Guangbo Cui <jckeep.cuiguangbo@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Waiman Long <longman@redhat.com>, linux-rt-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v4 2/2] PCI/aer_inject: Convert inject_lock to
 raw_spinlock_t
Message-ID: <aQydxtOtgPTPxL_9@2a2a0ba7cec8>
References: <20251102105706.7259-1-jckeep.cuiguangbo@gmail.com>
 <20251102105706.7259-3-jckeep.cuiguangbo@gmail.com>
 <20251103192120.GJ3419281@noisy.programming.kicks-ass.net>
 <20251103192709.GV1386988@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251103192709.GV1386988@noisy.programming.kicks-ass.net>

On Mon, Nov 03, 2025 at 08:27:09PM +0100, Peter Zijlstra wrote:
> On Mon, Nov 03, 2025 at 08:21:20PM +0100, Peter Zijlstra wrote:
> > On Sun, Nov 02, 2025 at 10:57:06AM +0000, Guangbo Cui wrote:
> > > The AER injection path may run in interrupt-disabled context while
> > > holding inject_lock. On PREEMPT_RT kernels, spinlock_t becomes a
> > > sleeping lock, so it must not be taken while a raw_spinlock_t is held.
> > > Doing so violates lock ordering rules and trigger lockdep reports
> > > such as “Invalid wait context”.
> > > 
> > > Convert inject_lock to raw_spinlock_t to ensure non-sleeping locking
> > > semantics. The protected list is bounded and used only for debugging,
> > > so raw locking will not cause latency issues.
> > 
> > Bounded how?
> > 
> +	scoped_guard (raw_spinlock_irqsave, &inject_lock) {
> +		if (ops == &aer_inj_pci_ops)
> +			break;
> +		pci_bus_ops_init(bus_ops, bus, ops);
> +		list_add(&bus_ops->list, &pci_bus_ops_list);
> +		bus_ops = NULL;
> +	}

I found that there are two styles of calling scoped_guard in the kernel:

  1. scoped_guard (...)

  2. scoped_guard(...)

Is there any coding convention or guideline regarding this?

> +				rperr->root_status |= PCI_ERR_ROOT_COR_RCV;
> +			rperr->source_id &= 0xffff0000;
> +			rperr->source_id |= PCI_DEVID(einj->bus, devfn);
> +		}
> +		if (einj->uncor_status) {
> +			if (rperr->root_status & PCI_ERR_ROOT_UNCOR_RCV)
> +				rperr->root_status |= PCI_ERR_ROOT_MULTI_UNCOR_RCV;
> +			if (sever & einj->uncor_status) {
> +				rperr->root_status |= PCI_ERR_ROOT_FATAL_RCV;
> +				if (!(rperr->root_status & PCI_ERR_ROOT_UNCOR_RCV))
> +					rperr->root_status |= PCI_ERR_ROOT_FIRST_FATAL;
> +			} else
> +				rperr->root_status |= PCI_ERR_ROOT_NONFATAL_RCV;
> +			rperr->root_status |= PCI_ERR_ROOT_UNCOR_RCV;
> +			rperr->source_id &= 0x0000ffff;
> +			rperr->source_id |= PCI_DEVID(einj->bus, devfn) << 16;
> +		}
>  	}
> -	raw_spin_unlock_irqrestore(&inject_lock, flags);
>  
>  	if (aer_mask_override) {
>  		pci_write_config_dword(dev, pos_cap_err + PCI_ERR_COR_MASK,

LGTM, If there are no objections, I’ll include these two patches in the
next version of the patchset and add your Signed-off-by tag.


Best regards,
Guangbo

