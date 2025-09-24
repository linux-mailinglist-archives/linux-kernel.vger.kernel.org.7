Return-Path: <linux-kernel+bounces-830949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 81B2AB9AFA4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 19:08:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E7EE1B283BD
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 17:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22ECD314A9E;
	Wed, 24 Sep 2025 17:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="C/1lM3J5"
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ECE3302CB2
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 17:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758733730; cv=none; b=qEDglO8iSdIHxAQBO0IhVVDTcavMIY2DekpROuGB7Fm1Bz6GcE18KJbkiIZG2m5n2XoNa6QBdIq/acI2vxW5UP1f3RqgdV/4B6YTNzAINLqJ9eRroqiolx/HUAUpuHrP+ZcRle3YJQHtg+uAxcIRZ8bIW+8dphHsZ7O8kOgmK9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758733730; c=relaxed/simple;
	bh=nUAmv8H9hgiFvCdcE/9leaa+cZA/AIOWo7WtnrTKZ5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IM5BRZux4UpeYM9uvNUzy9iScII1f2AEIdo4U5kQoK1IroePK4sRsH1qRNbdNsUh/n/xyvyu7PG/se6duXK9F8ODqC9t/ZeSjDoQ2/b9ItR/Hykvun8Ti8DQd4zNJEINvGHnVqWVoP6hivKzxGwvhzMra3DjW+/i6gyXP873bXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=C/1lM3J5; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-4256f0444caso134975ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 10:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1758733728; x=1759338528; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=u9YvycGlNJV4Q2DejLBsM63fTc6nBtT2JcHZL2ev/Ww=;
        b=C/1lM3J5UtZ5FOfHQ7WA5HbOvk+zRWBXdb+7Su+Z054saIPpkhnR61Ihhf7oYAjhlO
         wMlR+HcYp7VXra1vhGRNB8D3lFM1cC1GiFIExnE4hPxsGrik21Xx4xVRQShGBg4UJ/RP
         5vGaMAPhiRRZmECno1l9ydeOeAJzb7j57o9gnBSbj3mBR7vmZToZeairoKT9g4mWZSML
         V0uRXIciig4zy1t8675RUaZJa7pzwTlHNErr6Sy9PtyWAbMMNEaeYzcKk1VD9ROF5XBt
         7Kz8KM47rO2/Paq4T10CwV0/HGmFFnShcVYE4+xA7NY1PgjSyyXGnAAgIOkihIIuG1rU
         mxQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758733728; x=1759338528;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u9YvycGlNJV4Q2DejLBsM63fTc6nBtT2JcHZL2ev/Ww=;
        b=GqCYi7V055xxcjpOEwVxJfXAM+Iw8DUPxAduQy+uhksrFUSVva4q9qbU/OJtajxcKy
         50T8LyHKc3eoywr3xahkeEVMWygUmDP9dOjztZeSb3skETlN45XQF8oO1REJNFfOJnAS
         RO+bnUEJBFoA5+lmRhK6VSh086Ag932QnSB0briV4iSZypExMicB7mpMnufeBf4vGRPs
         Z90tNW25iMWdiO4S7tOaVEB6m1JtLSIOufCvjFPu9Vix+MZWUGbPdGWY4kegmEEkqKUv
         00YoEjLA+uiUBX9XrLSc9dPS1dTxyIfiFtNOANVRD/qnG0+RYX5bVEMuGpMzWFOTSSfZ
         DoYQ==
X-Gm-Message-State: AOJu0YxdUe1tMTbTAdmKJsKwgvB0bvxazOL8k2bmuzuH3gbcXXjzX4oM
	T5TAoy7LUcgIQYnFa/6knk2uhn/Zyouj/oZf6JcCCKnShMfnN6Po62yWr4wxpExlkEY=
X-Gm-Gg: ASbGncvxLKxJXFTgfb2Y12X1XoW8qIT9jSJnJZDIIBKWi0iEYL6mpMqvsOoxJmcH9LA
	KHULzkXXdh15cmw20BAAVSCxH+4w/vCNT4CwsSY+IFph4294/IecfFaTI+TfIAWc7Xh5sewexRA
	mEX5+sO3A4b9fe0hklsM7IpuCCL1wt5DTUbYdGlQn7lGt+kvrcD2MKJ3r0v/e/n1JFuXaqDB0Ru
	Feodf1nInOV3xCr8q2OefUWhqOvYtd+7bAFjofAzdmSHCUTNLcdZX3qGJ1Zd9xVw2P98Ti35MVU
	6ffTgSVC2T9LK5jihSV8+NH7GXlyykz52fhcmUdmqzwQc/P2ZCtRfNJf6yAp3/pIgpvpqR0bWJ0
	0NEjwWKS6zDIT0YTOKO7+mt+K
X-Google-Smtp-Source: AGHT+IGI2XTu1luL1W07izdN35I/CB5PQt7LugDhcv/pXBGWRBL2UtisiXkcMiabO518Q3HGRFAjrA==
X-Received: by 2002:a05:6e02:5:b0:425:7afc:b84d with SMTP id e9e14a558f8ab-42595660be3mr5073975ab.18.1758733728037;
        Wed, 24 Sep 2025 10:08:48 -0700 (PDT)
Received: from localhost ([140.82.166.162])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-42585a701eesm18122715ab.7.2025.09.24.10.08.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 10:08:47 -0700 (PDT)
Date: Wed, 24 Sep 2025 12:08:46 -0500
From: Andrew Jones <ajones@ventanamicro.com>
To: Juergen Gross <jgross@suse.com>
Cc: linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	virtualization@lists.linux.dev, x86@kernel.org, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Ajay Kaher <ajay.kaher@broadcom.com>, 
	Alexey Makhalov <alexey.makhalov@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: Re: [PATCH v2 10/21] riscv/paravirt: Use common code for
 paravirt_steal_clock()
Message-ID: <20250924-8189d2caf8323e5f6770f429@orel>
References: <20250917145220.31064-1-jgross@suse.com>
 <20250917145220.31064-11-jgross@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250917145220.31064-11-jgross@suse.com>

On Wed, Sep 17, 2025 at 04:52:09PM +0200, Juergen Gross wrote:
> Remove the arch specific variant of paravirt_steal_clock() and use
> the common one instead.
> 
> Signed-off-by: Juergen Gross <jgross@suse.com>
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  arch/riscv/Kconfig                |  1 +
>  arch/riscv/include/asm/paravirt.h | 10 ----------
>  arch/riscv/kernel/paravirt.c      |  7 -------
>  3 files changed, 1 insertion(+), 17 deletions(-)
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

