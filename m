Return-Path: <linux-kernel+bounces-891275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E4672C424EB
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 03:34:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 761F04E22B4
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 02:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC31228312D;
	Sat,  8 Nov 2025 02:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U3DrIOfS"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6990A231A21
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 02:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762569278; cv=none; b=m6OH54re7QCoIB8l2FFgbdA2fnMQtag5D2swwYX7eTBx3qf3WZ1vX3mjho/Pz9YcJRg7fQEpwZSiBZqWf5P65hofZrF75ziaX7CxJ6jq4dsax1l+hWXKWRW7V8URRYRkUg5xvnbnQD/hX2qYZVa8MYTbyvfYjpVleGALOLP2Sgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762569278; c=relaxed/simple;
	bh=Z5X50pyR0wS4lIYsN0HttoXOv4LWl0AVzhpUed4BCes=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f/57fx9wAZ4sNOWfBwlyG9n3XrZLdsVqJXrXBxq7G18bNAjH4w5z0VP1hG5QYzFmzRSTiAEttcKSFo7s7G3va3ZvLrlY1QzbGm6WP6c7TmZqkwyvTqSXBuRIOCFlNIgjz+c4aw92C0aU+aLdrVFWjzeUOkgwgwWctu7+k3upBaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U3DrIOfS; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b71397df721so153355366b.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 18:34:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762569275; x=1763174075; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o5potOoY7oJuZDgAPEu8n/B2FvMnFZR/4eU+wIwynFI=;
        b=U3DrIOfSq41Jo3yYoAQLR69+/6srBs7EQUBw3cFjNj0P+rGMxtjqXzGgxMJehgsBRp
         j+ZdYANEkArSXZNYKh5miE5FSr1n6yDWFYMjLMI+0FXvRygkV1jhMw2SmzZ1NmL6W6al
         Mw6m0eg8s+mmHZOv3rktMgjlYqLPc+yxeJQh/bWwb1VUDpgVx01UQn6x9MzZ7xUmCfGH
         ILAJlVboKdtBmlfLnZhFXbq2qfWXl749HFiPtCvOZUjR3Nh8ug8iWQthDAoExZQ29sPz
         WzsYAGzE99rqQROMErzV22Douo7fDgasIfjtTlbsOGU61teRnXsSyoBp+TLYPGP3akAK
         hZIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762569275; x=1763174075;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o5potOoY7oJuZDgAPEu8n/B2FvMnFZR/4eU+wIwynFI=;
        b=MuSVAHP7ZEXOXyPmMLrVxyFVB5BR79QXiNpkDDWWn1lBwit4Yvfbr35wsY2KyMKIKy
         EhE2sDhkowmZmtJnA5FX8MHw9+cseOmKrP53FO1Dfbebcm4v2hJlKSm+VduRbpAGzX1p
         WUaVvlmxlOPHUETrxRmZ6cL9Eyqm69sf+0/emQt8SXZz7Qcj0y7J+s3tlGBS7bddqohC
         gAU855+e4rPHx9oebCHxIW/8ZTwnzHyMmr1x7X+ZN7KtuYsl0rFnk4bzDY25GBjbXBVa
         F7QjPEogdIoa0jaIz8RKBPZIemTWJVuBLZG+v3B41Hb6+PrvwLZhF2FEwYl8DX6HedMK
         ytfw==
X-Gm-Message-State: AOJu0YzDWUyxvtQ6Z9SZp27rfl1wXE/8J/E9yEIS6gQ2/ofT1G9hOOiN
	vPqloT1QR+bbfkjHt+gL7+Rdsh9LRPJ8kQWAdpAfBymm8ZJALy829G4t
X-Gm-Gg: ASbGncsSiJa2GFyqgssAIEaMIu0Culg5ijlmp1I2Ow0jSLlgtjXWvS/56r9x4q9cafp
	/BBVtG18vmfyjtwSCoOUB7K9J9Hx0uABkS/pwIZhqjQo4F9gWQYaBnzDgtLdnP8JpgEcYZqH/rg
	xVYZEDgOJnBjMg/LjYz0yXpilvjzuvEBsU1p0MyH1eyjhsWtcDjF8RWRBwra+aiOpiQK7KbruPb
	GJKJU0jpKQLG6FU8qyL5DfSsdilRbhZ6M6KNOINoqhK4kK8m9tJngRgBhEGT6SS5JaflBPxcoPi
	rVXScjQSYq1TtLH2wyryQTcOA0NF9bBJk4C0fTHWDug+DjcrWmltHNctHBjt8iaU86TB16o8H1u
	jG32ENdaWUK8YT4jTOalWpnRtmvvFw85dRA1GnbRHfPdX0xKtIXBmqafl6A3g9pGNHk1ueURTdq
	ybNLMpCmp9qg==
X-Google-Smtp-Source: AGHT+IF8sH5AJD5BmsEI+wfEUF+AscOx+lX9t+VpBog4E5GD0fnsTzO8XVh1qgisOXry5AIp9gqKVg==
X-Received: by 2002:a17:906:ee87:b0:b6d:4fe5:ead0 with SMTP id a640c23a62f3a-b72e028a487mr148451766b.10.1762569274625;
        Fri, 07 Nov 2025 18:34:34 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bdbd1ecfsm391337166b.10.2025.11.07.18.34.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Nov 2025 18:34:33 -0800 (PST)
Date: Sat, 8 Nov 2025 02:34:32 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Nico Pache <npache@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-doc@vger.kernel.org, david@redhat.com,
	ziy@nvidia.com, baolin.wang@linux.alibaba.com,
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
	ryan.roberts@arm.com, dev.jain@arm.com, corbet@lwn.net,
	rostedt@goodmis.org, mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com, akpm@linux-foundation.org,
	baohua@kernel.org, willy@infradead.org, peterx@redhat.com,
	wangkefeng.wang@huawei.com, usamaarif642@gmail.com,
	sunnanyong@huawei.com, vishal.moola@gmail.com,
	thomas.hellstrom@linux.intel.com, yang@os.amperecomputing.com,
	kas@kernel.org, aarcange@redhat.com, raquini@redhat.com,
	anshuman.khandual@arm.com, catalin.marinas@arm.com, tiwai@suse.de,
	will@kernel.org, dave.hansen@linux.intel.com, jack@suse.cz,
	cl@gentwo.org, jglisse@google.com, surenb@google.com,
	zokeefe@google.com, hannes@cmpxchg.org, rientjes@google.com,
	mhocko@suse.com, rdunlap@infradead.org, hughd@google.com,
	richard.weiyang@gmail.com, lance.yang@linux.dev, vbabka@suse.cz,
	rppt@kernel.org, jannh@google.com, pfalcato@suse.de
Subject: Re: [PATCH v12 mm-new 04/15] khugepaged: generalize
 alloc_charge_folio()
Message-ID: <20251108023432.yqw7u7wnh5x3xvgh@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20251022183717.70829-1-npache@redhat.com>
 <20251022183717.70829-5-npache@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251022183717.70829-5-npache@redhat.com>
User-Agent: NeoMutt/20170113 (1.7.2)

On Wed, Oct 22, 2025 at 12:37:06PM -0600, Nico Pache wrote:
>From: Dev Jain <dev.jain@arm.com>
>
>Pass order to alloc_charge_folio() and update mTHP statistics.
>
>Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>Acked-by: David Hildenbrand <david@redhat.com>
>Co-developed-by: Nico Pache <npache@redhat.com>
>Signed-off-by: Nico Pache <npache@redhat.com>
>Signed-off-by: Dev Jain <dev.jain@arm.com>

Reviewed-by: Wei Yang <richard.weiyang@gmail.com>

-- 
Wei Yang
Help you, Help me

