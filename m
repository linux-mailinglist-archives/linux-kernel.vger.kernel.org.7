Return-Path: <linux-kernel+bounces-821870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 821E3B827F5
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 03:31:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C0E32A5CEE
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 01:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C1E11DE3B7;
	Thu, 18 Sep 2025 01:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dDpCAGZS"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C321494D9
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 01:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758159095; cv=none; b=eqAa3IUhx1MQ4M5jcCSkxZVaSU9cLvq1t7kmK7edLXMVN8YAG6xpT0YIRq/Vb+/keYG/aXy0d7GOtYbgnzpuSHvEH9UQc8LcGbdzLN1MBHuqS7rMVYgceBZUyWMfDONtww0UFSYsFS6rAqfdG5T2R8KnQq1PuW5aG5Pu7i9M8Ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758159095; c=relaxed/simple;
	bh=R1ZFUdz+nNNA2MckZ/3W7eTROtGQkSQcYpiBkeM8gsI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dxndLsWLECNVhEWE/3juvZ4MX2AFUbIs6+aZnwj9aoPYrvkAdaQ7SrY9CuPODj51wP2vuZP3VMrHoHhZ1h0tktUp1cZROzVrO7ZNxVvo3tPWj2uTCASvrtm3zEnDuOfEm9rc0ga2CfotmWvYwWj4Wc7F+M969MxB00OaHxkjOjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dDpCAGZS; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b54ff31192aso279480a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 18:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758159093; x=1758763893; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eGu6jUV2+RT3PgqHH5oCw8Nh03q6VX9mmcyZQjqvWaA=;
        b=dDpCAGZSM2lZQbDdfM9HQVp8y1eT83aFzGszndb74JtsnJWcoPTQVxpW76kymOjqAX
         C5OEJFmRiJPWL5rdDl8FeuXNFOBdt/Btqoa2y9L6MdSzVUK8MFodmo/spgOJvx++lczI
         PMWAztu9DVPKSKrP5la7EvwGyuAiiIZfJ8rlJj6qUDWdeaboOHYc/tSP7H4keMZhL4NF
         tydDoJN442rbIhFw4+gCZz6oEJbBvcbJpKm/ezcc5kCvx1xTcSEhnGLm88eEZohap/U1
         sqsnOdZxrt+keiW5kuUBYJS5OZHJ5CatDJZAr0MLzgEa9ynldIB3lrgBgwYFDLMrTqHt
         ITtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758159093; x=1758763893;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eGu6jUV2+RT3PgqHH5oCw8Nh03q6VX9mmcyZQjqvWaA=;
        b=Hs0Qr3Y1X2YmbKv35mqOGEtYyOOXKfD0KSFA6pjOJK0eHxC3iPEM6Af9ouXepH7WZ0
         BjDNyHjQgesNvPm9DN5GDPKSc0U8P3E5rR/4r1fSC/hWSsyMzkbE2x/qH/Pedsy7Yxx8
         Btj2TlGaO7/n2STT3LqLIR+na6JEtcKiJt+0Ceiq2ciOWz3kRMOQNebWtxDhUvRYtZMS
         juosxBdbqG0oCswU1r0kA3KF61VzjRCZv0DJkSB8q5E/pC877CaY6DZpLzDmIcsdLw7h
         5mTqHgpcrLLUCLN3OEcz/j7sz+LbZj37yRcJTR2SbiKG2jTAuS7IrprtGoPUNR4LFIRk
         BBug==
X-Forwarded-Encrypted: i=1; AJvYcCXXlBxbX829KfJwuMrk/7ko8ekObFn3Mrzd+x1NT+jjwtTlArn/mh6vyDAm+TM9ll+3cEcCgHL2OzivOkE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzv+2Cw8XyINBp5WXoB/4EQQbqliGGE0fFege9KmJknPIRhHc9M
	6n05kMvuaH4QDh/Aa8gvTMU+YrKA2tl3qxn0ozJdhqn0ndu5acmpsOR1
X-Gm-Gg: ASbGncsAyAZxn+CKwbS/mMSVI+v1upM8RlHUiZxHjm2edMjSCPJZ1gVGZxF1Zmdw3HL
	9QO5t4fuY86xGEz6a3IH/Igq0WkTob1Haubw2pAOski8ShXQ4IngwbFDbJimD/ggd5jvlG0N4+t
	T7xhY96/BGrWNoniuW3kQTYDRGr2yMAJlUqZhdrxA27C76mqeLrwnuZYzAW84sReopM+asAvBsj
	9PknIKZs5tvabMtuiXIGBApuBMDIe6X4FUPpR52Uut7fdBlLSqA2U8jcNMIrbf80XYsKrOl9Qm0
	mybENmc4lctWivYmD4XPviDLOFJ0c+50QikzK60gkwuS3Cqsffa64GJKtDjyYdQ80WsDndqFNcG
	qwJKJ6ZwSp7Eek0ODNx4fHWOE/XuJHd9TU62yWoCE+lETc4REgtNO1/8mMM7by7I=
X-Google-Smtp-Source: AGHT+IGyol2ICo5LkwOJQM5YrI/z89CMfK7noN15fH9mKTb1oN4Xwj7kuK4ucc0oFR/zcNay6QAzWQ==
X-Received: by 2002:a17:903:2307:b0:248:7018:c739 with SMTP id d9443c01a7336-268139031a0mr60323995ad.28.1758159093380;
        Wed, 17 Sep 2025 18:31:33 -0700 (PDT)
Received: from VM-16-24-fedora.. ([43.153.32.141])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-269803184d3sm7860915ad.116.2025.09.17.18.31.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 18:31:32 -0700 (PDT)
From: Jinliang Zheng <alexjlzheng@gmail.com>
X-Google-Original-From: Jinliang Zheng <alexjlzheng@tencent.com>
To: harry.yoo@oracle.com
Cc: Liam.Howlett@oracle.com,
	akpm@linux-foundation.org,
	alexjlzheng@gmail.com,
	alexjlzheng@tencent.com,
	arnd@arndb.de,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	david@redhat.com,
	geert@linux-m68k.org,
	hpa@zytor.com,
	joro@8bytes.org,
	jroedel@suse.de,
	kas@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux@armlinux.org.uk,
	lorenzo.stoakes@oracle.com,
	mhocko@suse.com,
	mingo@redhat.com,
	rppt@kernel.org,
	surenb@google.com,
	tglx@linutronix.de,
	thuth@redhat.com,
	urezki@gmail.com,
	vbabka@suse.cz,
	vincenzo.frascino@arm.com,
	x86@kernel.org
Subject: Re: [PATCH] mm: introduce ARCH_PAGE_TABLE_SYNC_MASK_VMALLOC to sync kernel mapping conditionally
Date: Thu, 18 Sep 2025 09:31:30 +0800
Message-ID: <20250918013130.2425537-1-alexjlzheng@tencent.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <aMrkoBhIcP37YgyS@hyeyoo>
References: <aMrkoBhIcP37YgyS@hyeyoo>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 18 Sep 2025 01:41:04 +0900, harry.yoo@oracle.com wrote:
> On Wed, Sep 17, 2025 at 11:48:29PM +0800, alexjlzheng@gmail.com wrote:
> > From: Jinliang Zheng <alexjlzheng@tencent.com>
> > 
> > After commit 6eb82f994026 ("x86/mm: Pre-allocate P4D/PUD pages for
> > vmalloc area"), we don't need to synchronize kernel mappings in the
> > vmalloc area on x86_64.
> 
> Right.
> 
> > And commit 58a18fe95e83 ("x86/mm/64: Do not sync vmalloc/ioremap
> > mappings") actually does this.
> 
> Right.
> 
> > But commit 6659d0279980 ("x86/mm/64: define ARCH_PAGE_TABLE_SYNC_MASK
> > and arch_sync_kernel_mappings()") breaks this.
> 
> Good point.
> 
> > This patch introduces ARCH_PAGE_TABLE_SYNC_MASK_VMALLOC to avoid
> > unnecessary kernel mappings synchronization of the vmalloc area.
> > 
> > Fixes: 6659d0279980 ("x86/mm/64: define ARCH_PAGE_TABLE_SYNC_MASK and arch_sync_kernel_mappings()")
> 
> The commit is getting backported to -stable kernels.
> 
> Do you think this can cause a visible performance regression from
> user point of view, or it's just a nice optimization to have?
> (and any data to support?)

Haha, when I woke up in bed this morning, I suddenly realized that I
might have pushed a worthless patch and wasted everyone's precious time.

Sorry for that. :-(

After commit 6eb82f994026 ("x86/mm: Pre-allocate P4D/PUD pages for vmalloc area"),
pgd_alloc_track()/p4d_alloc_track() in vmalloc() and apply_to_range() may should
always return a mask that does not contain PGTBL_PGD_MODIFIED (5 level pgtable)
or PGTBL_P4D_MODIFIED (4 level pgtable), thereby bypassing the call to
arch_sync_kernel_mappings(). Right?

thanks,
Jinliang Zheng. :)

> 
> > Signed-off-by: Jinliang Zheng <alexjlzheng@tencent.com>
> > ---
> >  arch/arm/include/asm/page.h                 | 3 ++-
> >  arch/x86/include/asm/pgtable-2level_types.h | 3 ++-
> >  arch/x86/include/asm/pgtable-3level_types.h | 3 ++-
> >  include/linux/pgtable.h                     | 4 ++++
> >  mm/memory.c                                 | 2 +-
> >  mm/vmalloc.c                                | 6 +++---
> >  6 files changed, 14 insertions(+), 7 deletions(-)
> > 
> > diff --git a/mm/memory.c b/mm/memory.c
> > index 0ba4f6b71847..cd2488043f8f 100644
> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> > @@ -3170,7 +3170,7 @@ static int __apply_to_page_range(struct mm_struct *mm, unsigned long addr,
> >  			break;
> >  	} while (pgd++, addr = next, addr != end);
> >  
> > -	if (mask & ARCH_PAGE_TABLE_SYNC_MASK)
> > +	if (mask & ARCH_PAGE_TABLE_SYNC_MASK_VMALLOC)
> >  		arch_sync_kernel_mappings(start, start + size);
> 
> But vmalloc is not the only user of apply_to_page_range()?
> 
> -- 
> Cheers,
> Harry / Hyeonggon

