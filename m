Return-Path: <linux-kernel+bounces-865046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07A0DBFC225
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 15:28:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C128A5E7D29
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 13:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D72D26ED3D;
	Wed, 22 Oct 2025 13:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="NZW/8q4R"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E34C33FE30
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 13:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761138403; cv=none; b=PeA1j6VNOv4cPBXkZOjUh3PP0z9vVrO4p58vkFCHti10NXfFatrm60CJ5wbuhbVXPJVisSRfwudyKCHGM5t+NIXZK4jK5WFZK/7uo5fHx6bna1ihut8owo7dYFKNKFA2r75Q26TQL+Etq4OnrTTW8nNlq8D3i7ygONejCe/Hyug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761138403; c=relaxed/simple;
	bh=dbXEB23RvN4hR8GgYvg9KAkEEjFiXPuVtz/rEqoU8W4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AFoUZdg+CxRdsG4ER56O813gQhOtxMsdq94dO99l3KdvHtpJjaK1647h+v7+uZyVizF+Xo18vCFekKy4YIr3Ftg7EBigjr4ZtSw2R4rg63AYyOO/oPznwjZ2B15RgX1ZOW+0F3c0EE72bdj+n6yAzdpNg7nfDtmTcb6mG9DfKLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=NZW/8q4R; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-46e6a689bd0so64885095e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 06:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1761138400; x=1761743200; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/A8ZPFmWvxEQpR9qb9R3Mc0l75eRlQJgZk9qTn2p9t0=;
        b=NZW/8q4ROY6+JkUUQDT03OQbGzvcBAEBhIQQ24nOF7RQ4tKf1tWNYal9vpwlxs2mgt
         /5xL6+XoAQDiDCtYH78mq6bKFvGTqOklcG/bWBX3P2D9n6JdLdqBaZ5Qjiu9um4ADJPB
         8qlZrkV8lTL6aIIpcRmzeUh11cMv5cp1n6fslXMjj1YyPpW00a9HmGTeTuhh8Vqo5SVQ
         T2qqIH6uRD5iVH+n9y9Mdy5TbCWJjFyC5VI6S856/q622wUszGwgmY2XmDQuYe7EdX9h
         x74JD/CBTA75dgfjhcTRpMFKPqccv7EVse3ZSCQ/Gsd8laCS6GupTxPnUEoO1Ym6/mCs
         A49Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761138400; x=1761743200;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/A8ZPFmWvxEQpR9qb9R3Mc0l75eRlQJgZk9qTn2p9t0=;
        b=w5ZbQU4NVato1U6aQLU7lAHuHNS1jRQgfFkSYr2zkqhmACthL0djnMNrmpDQO2zryh
         Ry4wGov7qKh365WNycuqi06fmzQ2N3c2kDYqhCcfjYwecqETmARtDUa1l6USTz2LXeEa
         CaKbaS3RoZVlUhGQM4ZPrXHtZa19zBhbiBEMWLKy2jntr1SSv/OrNfMrrcYhcqVGCCAt
         DdP2Kto2bD3PVoAtUpW1wKsWn5f5g69bQgE1gf5XZZbweip3iM5m5KKh6SAjlSzlmkn3
         sIkoq+b1GJtfs+xOwL5TY/09gfJqSXUO6pFXDI9fAXzxGQXWvVkucm3TcE8e5Ta28JxQ
         pR3g==
X-Gm-Message-State: AOJu0YxpAsYibAZWG2K2DMrCWzx1IN8qPLbsfwWxkn5b2vGWOCCE4MwG
	x8F45FuO6n1FK9JuwgPBSziiMmcgwT6A10GHE+nP0mamuo+61hD4sXlQKJuv9Fl5//HuejLtiLB
	IIORX
X-Gm-Gg: ASbGncs4hubEtdtMi8zoi/gsBK3IQV84TuTFWUl0Rgh+FpxeccuFwWpq5/5KuuuDFhk
	qf4d47rBJiCiLK0pFxwoKUDPUN9zw7asC0/r1Skq66xSZYHgTpH0gp19aDXtVDABb9lhbRBajeb
	/DDoCvg0Vb16XN2eLZnRF6mzXVbWdSBWkolJTx4FinwLiZKlbptWtcZdxZ1HO7mEhXZSRtH7FQb
	bx7pu30Xl+DkYZ/k6bdRAsGhBdD8G8tCzuM5O+AcU6+MrL0pJ619YgTQZn0Xd5bHHzjTl8MEpJB
	290gomrkYNfyx2gRqNVs2NVkcxnTyAVqTDm+LN8d5ezBgZyjqZQkaM2uu0XpvrmCqyU7FcT0qxr
	m9HCkoU82HYNa09yVfxKoNJnzXM7OAMI3UT4dC0J1SWII+iX589NBCU5PaaBQ89eY6vzx4dC//S
	uL/iQ=
X-Google-Smtp-Source: AGHT+IEIuWodjd6E5M+XsTe/qj5t8SOFXrOcY96wnD76MT7O2+fL+fCFN6cbmJY/HzEaJJ52K3c82Q==
X-Received: by 2002:a05:600c:4fd4:b0:471:13dd:bae7 with SMTP id 5b1f17b1804b1-4711791c5dfmr172995245e9.30.1761138399653;
        Wed, 22 Oct 2025 06:06:39 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475c427f685sm44820495e9.2.2025.10.22.06.06.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 06:06:38 -0700 (PDT)
Date: Wed, 22 Oct 2025 15:06:36 +0200
From: Petr Mladek <pmladek@suse.com>
To: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Hari Bathini <hbathini@linux.ibm.com>, joe.lawrence@redhat.com,
	Naveen N Rao <naveen@kernel.org>,
	Masahiro Yamada <masahiroy@kernel.org>, jpoimboe@kernel.org
Subject: Re: [next-20251022] Kernel Boot Warnings at
 arch/powerpc/kernel/trace/ftrace.c:234
Message-ID: <aPjW3P2AU7L71S-s@pathway.suse.cz>
References: <72469502-ca37-4287-90b9-a751cecc498c@linux.ibm.com>
 <cdf7c458-b28f-4657-8708-1f820369baa6@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cdf7c458-b28f-4657-8708-1f820369baa6@linux.ibm.com>

On Wed 2025-10-22 17:36:18, Venkat Rao Bagalkote wrote:
> 
> On 22/10/25 1:52 pm, Venkat Rao Bagalkote wrote:
> > Greetings!!!
> > 
> > 
> > IBM CI has reported kernel boot warnings with next-20251022 kernel. I
> > see there are couple of warnings hit and eventually system boots to
> > emergency mode.
> > 
> > 
> With the identified first bad commit, is casuing the kernel to boot to
> emergency mode. I reverted the bad commit and built the kernel, then kernel
> is booting fine, but with boot warnings.

I guess that it is the same problem which should get fixed by the patch
https://lore.kernel.org/r/e52ee3edf32874da645a9e037a7d77c69893a22a.1760982784.git.jpoimboe@kernel.org

Best Regards,
Petr

