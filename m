Return-Path: <linux-kernel+bounces-745025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C1EDB113D5
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 00:26:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72A381CE3B2F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 22:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99CFF23B612;
	Thu, 24 Jul 2025 22:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B5FFXaqO"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 922BA14A4F9
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 22:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753395954; cv=none; b=TjASBmdQAWNBT06mHeaJ/hrP/X+1ovdR1ci+aeXNiG/QgPPyCDG/5O5mvQFAgDlKnBWVCRTMZMTGEjOYQCZLLB9uwh0rT2MKXuXWff1MLP+4HZwHmTzuTiRFPxf85QSSrz1U2NL9Yc3/tZP0C+PhhJZgA8jg8u21ktZk2M57SBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753395954; c=relaxed/simple;
	bh=eNjYM1tNHNUNL1+Ymu7OdSzkBbAInfT3GSj6d4lfWzw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EYQeUdFttVs6d+eVkniY2frGFCKSEeQWAFGzZl4ehDiSR5Fnk7HaqT0LcgqzLbHPEbQ32y6M0Vg9pTkWLs3E1CC5p3GCKLPEWpJ7ZGSH6myCbcQiSOiSvLGSJ0VgjuLQKE0dhUQb9DMJXZAz2heeZ3v3rhrDf8lBFk4mudaPzc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B5FFXaqO; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2352400344aso13344725ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 15:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753395952; x=1754000752; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=p501nKIndOK0ynfRnWpItUkjJfZoq0gihafIBjBOE5Y=;
        b=B5FFXaqOmtqnmIbXc8ntKrSAjQZxwpC3jiH4rxDhDlqoVWnPW7cODkXDY6MVuK+Mdd
         lWplhzpN8935ez4anrfW9bMIl8X954izkt534mAHEhbyMFP/26JDGDOg1S4uDcbv09vN
         n9DbxOWKerBYfEHwm5ZSWr7GxyJUVWt04u6SzVjQGjeamggjnUY7V7Y+njqfPb2deSbn
         jNt8t9EIYWdnLI9BF1zqaVFfz9dtc1HN4SVMXdfcl6jd8eXdWdHPxBFndX9Urpk88LP9
         J89uVgi1pTHjBLFAPXB1EyebyJW3yS23auJILQmleoaLU90ty0KvkHXkBbW8Jyy35ypl
         CUxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753395952; x=1754000752;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p501nKIndOK0ynfRnWpItUkjJfZoq0gihafIBjBOE5Y=;
        b=erKfGSf3yXLp8vB37stn+WJv0o8SH5uprbOBzbHfbfsdnErPn2K4tmPkgpsIc2s/EQ
         NCCmlvXGHgsP5Ff6YiegqAj69VSPhx+HgattcKJDq7Wwx8ovvt9v5foNRzKlWe+Dywwi
         vGe9fAqUF3Nr0Nnwl44r9inGMwAtumbvdSLKpLc5lF0vMQtkxPQghig4Eai1B+dK5Ttq
         If8LE9+vtitGtv1LaasJZwUOze6koFOvH3B2wC0NXMkbciif4elrWMK6uRY1SU/jAicX
         3uDuL4BO5lcr4sFyiNYcPpZBXAOZaqVlSl8ipA0bBln01SgxNxGV3nLjrNzk0yS3xgLn
         aQ7g==
X-Gm-Message-State: AOJu0YzCUv2Grbs/QitVIql6esq8zxU3kHYq2C51IZrPjsDKO82wOPQi
	cWxkG2nGkMetimFg+2uSKD085MEMPvuKNGZO8LP15SYeCPcEUZAIvNGN
X-Gm-Gg: ASbGncsoqhD0slX38mQB5yLnn2ZL0uVsCqCc7pr3r6M4o9W6+ArsZ/mQmjkCehDpVfn
	uJ7O9IDBgz6pnRBYrMJBLzu5ZiRXKgrl2CDdVAhVa150vGULjbYxTcEDH61TuupwVM/7yiv+DeE
	WQ8Ony0tbXPleVX2+Q+AGrVEVFdcGF87fbtMU4VFxEp3sXFzVZkYMIBDvvFu2NpUoz01DxBejTa
	DLdKXX1x6HYiTlW0L7UIOW5oTLxjAIYmNfiNMLb4n7faYb4Z7scNfM1PoQy9cReRMsFf7AKhbjx
	/+6K0XUcVuD+j1baL/83lKgdUSjCjFldJQdg3C5pBTxZa7dytxmlHjsNmHU8y6sd1vAy3+3+YX/
	dJCp544QnPe3bD5zOtGMR1l7jsT6nhqVx
X-Google-Smtp-Source: AGHT+IGOanZlY8Its8Z5zgoGkBUJsmBN4ikOpEkYf7uzbD1LSmcj2tRFWQFTSjPPudRqtS+X3p5OtA==
X-Received: by 2002:a17:903:41ca:b0:234:ba37:87ae with SMTP id d9443c01a7336-23f98162005mr138262995ad.4.1753395951573;
        Thu, 24 Jul 2025 15:25:51 -0700 (PDT)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-31e662b3304sm2132001a91.17.2025.07.24.15.25.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 15:25:51 -0700 (PDT)
Date: Fri, 25 Jul 2025 06:25:23 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Thomas Gleixner <tglx@linutronix.de>, 
	Inochi Amaoto <inochiama@gmail.com>, Chen Wang <unicorn_wang@outlook.com>
Cc: linux-kernel@vger.kernel.org, Anup Patel <anup@brainfault.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Samuel Holland <samuel.holland@sifive.com>, 
	Marc Zyngier <maz@kernel.org>, Nam Cao <namcao@linutronix.de>
Subject: Re: Affinity setting problem for emulated MSI on PLIC
Message-ID: <qy6z6ym2rje36vgt6az6hkubsaeenicsu5ouxwbkuwml2inib6@qvz66lad64h3>
References: <20250722224513.22125-1-inochiama@gmail.com>
 <87tt32r082.ffs@tglx>
 <re3qxwkm3lu7o77kyfswwennqvtpyonlj4zajt5eu7z5zwkosr@mwacqq6bpbk4>
 <87frelrgn6.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87frelrgn6.ffs@tglx>

On Thu, Jul 24, 2025 at 01:07:41PM +0200, Thomas Gleixner wrote:
> On Thu, Jul 24 2025 at 09:34, Inochi Amaoto wrote:
> > On Thu, Jul 24, 2025 at 12:50:05AM +0200, Thomas Gleixner wrote:
> >> May I ask the obvious question:
> >> 
> >>     How did this obviously disfunctional driver gain Tested-by and other
> >>     relevant tags?
> >
> > I think the SG2042 pci driver does not support affinity setting, so it
> > is ignored. But the detail thing I will cc Chen Wang. I guess he can give
> > some details.
> 
> It does not matter whether the PCI part supports it or not.
> 
> PLIC definitely supports it and if the routing entry is not set up, then
> there is no way that an interrupt is delivered. As the routing entry
> write is delayed on startup until irq_enable() is invoked, this never
> happens because of PCI/MSI not having a irq_enable() callback.
> 

You are right. As I debug this problem, some interrupts are enabled when
entering irq_set_affinity(). And it does not have IRQD_AFFINITY_MANAGED
flag. So I think the problem is covered by this: the plic_set_affinity()
enables the irq. As these irqs are enabled in an unexpected path, I have
noticed the problem before.

> > For SG2044, I have tested at old version and it worked when submitting.
> > And I guess it is because the commit [1], which remove the irq_set_affinity.
> >
> > [1] https://lore.kernel.org/r/20240723132958.41320-6-marek.vasut+renesas@mailbox.org
> >
> > IIRC, the worked version I tested has no affinity set and all irqs
> > are routed to 0, which is different from the behavior now. Another
> 
> That does not make any sense. What sets the routing entry for CPU0?
> 
> This really needs a coherent explanation. Works by chance is not an
> explanation at all :)
> 

Yeah, I know. I did not dig in when it is worked. This does teach me a
big lesson this time....

As the problem is covered by the plic_set_affinity, I think it may be
caused by the same problem. Routing to CPU0 is not the real reason,
setting affinity after enable does this trick for the problem.

Regards,
Inochi


