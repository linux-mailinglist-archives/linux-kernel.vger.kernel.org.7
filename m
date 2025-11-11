Return-Path: <linux-kernel+bounces-895011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FA43C4CB7D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 10:40:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2B69F4EE4D3
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 09:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F6992EC084;
	Tue, 11 Nov 2025 09:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Kz7YMOlC"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 858382ED846
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 09:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762853721; cv=none; b=qSXvYHPnOyB4zGR3cbraA6XjLuXJjNilf+hz/7SXQs0i8ikxmC+7kZxACqGGqkfiilApTWmfUZay7FsjkLVhJ0684ZpEIkiTriZYqnQxudtMP2r5NtVMwu5adIivFmEW9PS8ngZoq6QexPrTlDj5679l0rOPtB6ScM1O+NsAzCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762853721; c=relaxed/simple;
	bh=EetqUyAEJqiuKxD3fEI2nbY8lCOitzdVH7lF4O8jjNY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DbRAwT3seDBMYM5XO/N5bk40KZwsUgOTriMednuwpsaotvDpT3tW6ymATVWWKAHwGBy1nGwmka9wkXYFNzydM9PSX/CfD4or3zhH1s7AoPLSwM06PPCmdlzV8oLFUNKb+iqrcynA5gocaNrBScUY4OJSrnYOqE9AKvmIQa3YlqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Kz7YMOlC; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3437af844afso2486943a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 01:35:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762853719; x=1763458519; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EetqUyAEJqiuKxD3fEI2nbY8lCOitzdVH7lF4O8jjNY=;
        b=Kz7YMOlCp0w+UrHY5twsYY8JF+Kv6/Dt+AXnLPCZ7Tlf6hTZaP85WkxpKixnmSKJ73
         yat5/nkJcYMecBUvXpPhOR2qauA/5M1fuRClERrZvacDw2anm4tkig3nq07KS3yLBCKO
         FAGgSaBjNDaFloCiyqHxCSSBMAZs9gXY52h0aMk+t0Qs5nudNVBUEu+0Vco4i37jdJuq
         pB4fqOJkVWqp9TsIgyEwyVUJiUk91mcjBkQlXKstFvl4YIGBvUO46Jr5zO+NUuDS5d4P
         fo+IilEs++lxM8dWoUrXcS+dya6iOfmPtlKK9rPF8LlN05X4GCd0jsxpegsA5Vsaxolb
         cBTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762853719; x=1763458519;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EetqUyAEJqiuKxD3fEI2nbY8lCOitzdVH7lF4O8jjNY=;
        b=XFYXFdAAnoyYbTijgDrR4Cbgs30Kz4dtIw6ATC7hY7hFTFEYk3vXbJ3WGEZvQRL3He
         102k7Sj3XmvD1vXS/q92Y8H1m4ITtJc3CDvvUKqe1ZO4f38rQv9DiYXD8kdIO1+XHWDr
         I7ORNnb+C5OoIggTZbE1vsX4cYx8hEnrK6gnSicYtnUmhj+4ChuMQSrp+nMWJsB8GuEQ
         DrSTIPrKUCcv9KfpWK6bBfPT2f9Jo6RBNmeshqeB0quxazDIrKWaRvDlyn5TW44QKVaz
         mXzH1RRijA79XzgnrgcyA5X5sCZBlbNWSfk6azt3yo+cR2UUEEOYGYPhGqZYIpGkJT3G
         oBtQ==
X-Forwarded-Encrypted: i=1; AJvYcCVTYm48MQhLm1/Z6Ufc8TJUU3dlo5ldztgpV+aZvOoFpyRAvH0SO6Cr7nVuOZxCPZ5TEJa7Kb/wATpN9IU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyq4Gwif5aKUnank+HOA5PPyptQTIZ3kMxoDW1e3v/p4KuWJG6Z
	4khPFH1ZCuh9y0mz4G/axmGcOHrmnCGK5UNt/r+S5jvSf2xWUc1Jk+7+ApQi0+E3Mh5pC7FKdhd
	2ltmLKz+1o/5ln/7FDVT4Az66wBPrkQjxGwv1tGdx
X-Gm-Gg: ASbGncuPK55b/Qle8fMNHEqZJXbP+SGxhDpJRxD+nD/I3aQi+g7iYf7jINROd7MopgO
	y2k7qS0PwRwoIzPZLoLmLU2NrH07TzzE8UeJnF4vkOo9RSXHVJbydkL6tEXH3sJmn5JcOxWs28S
	SFgr6ly7BnTPyjVZgwBLbOOHdpZF5lV2G5zs0DoISgfpQhVayKG5m8wYCPpRCxcpaTG2V0O9FVm
	l8s5QA88gE6onkYWBbK5oIvK2eMvfNu6OcjSUeq4UmRhdveJyMNEBk/m13Y9X5CONbjjYOL4cEY
	LCMF0w/DgcfrSCJ8EL2YVP/ZeQ==
X-Google-Smtp-Source: AGHT+IE1gIu9BAiXsX0H1O+GFnCkjCXA7LjUzdEGNtie4OCQJL0hEG9RvsKQFDwhfkMp+tiOpjzqm/vRLg5+ZmsNZZg=
X-Received: by 2002:a17:90b:390f:b0:340:c151:2d66 with SMTP id
 98e67ed59e1d1-3436cd0bb4cmr14245240a91.30.1762853718758; Tue, 11 Nov 2025
 01:35:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1761763681.git.m.wieczorretman@pm.me> <fd549c974b53b5410dbf85c0cf6a1f9a74c1f63a.1761763681.git.m.wieczorretman@pm.me>
In-Reply-To: <fd549c974b53b5410dbf85c0cf6a1f9a74c1f63a.1761763681.git.m.wieczorretman@pm.me>
From: Alexander Potapenko <glider@google.com>
Date: Tue, 11 Nov 2025 10:34:41 +0100
X-Gm-Features: AWmQ_bkZUqiS435kDnMhK6mmvyG8PwqBjo8fr1ltJrKRlyqzMnD3vTHwKYRZs0Y
Message-ID: <CAG_fn=UoQeoHh6Bpy0YOCywpfaimuYZM_d043JfxLVReW8PdJQ@mail.gmail.com>
Subject: Re: [PATCH v6 07/18] kasan: arm64: x86: Make special tags arch specific
To: Maciej Wieczor-Retman <m.wieczorretman@pm.me>
Cc: xin@zytor.com, peterz@infradead.org, kaleshsingh@google.com, 
	kbingham@kernel.org, akpm@linux-foundation.org, nathan@kernel.org, 
	ryabinin.a.a@gmail.com, dave.hansen@linux.intel.com, bp@alien8.de, 
	morbo@google.com, jeremy.linton@arm.com, smostafa@google.com, kees@kernel.org, 
	baohua@kernel.org, vbabka@suse.cz, justinstitt@google.com, 
	wangkefeng.wang@huawei.com, leitao@debian.org, jan.kiszka@siemens.com, 
	fujita.tomonori@gmail.com, hpa@zytor.com, urezki@gmail.com, ubizjak@gmail.com, 
	ada.coupriediaz@arm.com, nick.desaulniers+lkml@gmail.com, ojeda@kernel.org, 
	brgerst@gmail.com, elver@google.com, pankaj.gupta@amd.com, 
	mark.rutland@arm.com, trintaeoitogc@gmail.com, jpoimboe@kernel.org, 
	thuth@redhat.com, pasha.tatashin@soleen.com, dvyukov@google.com, 
	jhubbard@nvidia.com, catalin.marinas@arm.com, yeoreum.yun@arm.com, 
	mhocko@suse.com, lorenzo.stoakes@oracle.com, samuel.holland@sifive.com, 
	vincenzo.frascino@arm.com, bigeasy@linutronix.de, surenb@google.com, 
	ardb@kernel.org, Liam.Howlett@oracle.com, nicolas.schier@linux.dev, 
	ziy@nvidia.com, kas@kernel.org, tglx@linutronix.de, mingo@redhat.com, 
	broonie@kernel.org, corbet@lwn.net, andreyknvl@gmail.com, 
	maciej.wieczor-retman@intel.com, david@redhat.com, maz@kernel.org, 
	rppt@kernel.org, will@kernel.org, luto@kernel.org, kasan-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	x86@kernel.org, linux-kbuild@vger.kernel.org, linux-mm@kvack.org, 
	llvm@lists.linux.dev, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> -#include <asm/kasan.h>
> +#if defined(CONFIG_KASAN_SW_TAGS) || defined(CONFIG_KASAN_HW_TAGS)
> +#include <asm/kasan-tags.h>

Perhaps moving this part to patch 04, along with the newly added
kasan-tags.h, would be cleaner.

