Return-Path: <linux-kernel+bounces-893812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF734C486C0
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 18:49:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9742018906CE
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 17:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D55A2E5B10;
	Mon, 10 Nov 2025 17:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nRaz1H4j"
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A8A42E540C
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 17:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762796957; cv=none; b=rK/rhqiX0hpQuL1cEWFgt7yHdm1uCEmriNFyscVDaHx6BD0eKz9VcjgtHpnlFkNtfeQ5m390ninHrjZFjX6IN04VpyTrOnaTiwg9jGUE0y+e9VNfjYo4xB8jiSoUDQzpdufzdhIegwbgiwP8zqJNUaW13ois4XLKhpJDXo2WhlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762796957; c=relaxed/simple;
	bh=O98arH5WjcI5ZayKxsmOANfoxY47t5wDmB6i5QtbFzo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZETzqSYdUYRpKIQYDPodSdS0L2+VNQP3zfZRyQXNgxTuVGOkTSzockUg8YtwFIph4XdwUkJv7mZmCUIVdUPd4i8/oNFDD25KMn1jHJc36a19DdTe1GCREh9vpBRjzkIQ5XbKxRiyDG0TMTRo9ME0yEugsmP+4GE1XUIHJYZywdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nRaz1H4j; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-88058103dcfso23992096d6.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 09:49:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762796954; x=1763401754; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BPbi2NPPrBKl69IkN7kcBKOxfNw5kLfKkjmbVe2fGbs=;
        b=nRaz1H4jWcNq5aIIMP1HzMyzpXUE547dlrLoh9EEQXJSuCzeEmLTrNGOqgOIyzgxxi
         +4IxsSc9/xH0X92oJKKEHX5/Eva4+4NjRJcuZLk/Ah1PozRGH/9qgW1d58nsKqXSiEUZ
         R94HC13GQTfmF+o3k64nrAJFhgB7tRETmKjcJaeIgJwdwLCdOwiuGl9fXTGmiDOlm8xq
         W7zInIYwwqKhB2X/8sdIHYY4y4yVdtATJe3k3vIoBMisK84GJP9ei+GoZ/LqOWlyahr5
         O/RHBC0rxI/wRA/C+Dzi/MLypGcHkUzdhmyHtv3V74PEYHPmHuQDIbmIjtwftXvbdENa
         648Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762796954; x=1763401754;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BPbi2NPPrBKl69IkN7kcBKOxfNw5kLfKkjmbVe2fGbs=;
        b=CMoupRqzgTgBJI0BC2aYQ90UkGKVZ2IMCBKAJK5U41htGF2g2DT8a2PbZcjn3JBM2m
         0yVIgUkoXunoFeuDG7NhGydIBQq69SMy4EPmz+CzCL4/EVbkv0vZ9Z2x4HHDYE5J5EN5
         lBTxOizRAp63YofA9Dodn3MngZd3qU9HM7QjjaGMs9QTVVvXbO5breIk5Jl/Ik7fhM66
         qTtiQDMnGO5FRSYcGyVoS6rAZtpUbl9mCDtuqzar0NuRVqVDwKw/N9BLq/q6+x3vLGtm
         tUCbeaJv9nKD9s8riGBMBT6Wht1Q5hDpyeRGZBPpksTMV6YF5ZOxijBL2JU26GMCRYnz
         V0Rg==
X-Forwarded-Encrypted: i=1; AJvYcCWKHQZjoHi9HH8J4tu4bjUYuGJ3bJaBfFtx3nNvdoNFE4/DR9jJurYoBnBCOYWNH7SsoXjuga3gi1J4hNE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQ0i6UijCwpojmuetJQA4qCB77X0aU8fUwoJIokuShr7Ih4dIr
	rjqe8JUXHfa/IjcFrvn6M3sFpK722ZavGinPPpzEi6e316oZJniMuswUxRaL+vREMJ61pJpWtVY
	nzA4nYFTQysdNwZ6OEILNkep3owlpeokcXjbVI+Pq
X-Gm-Gg: ASbGncsqNMJnLE+EyVqXi0qRAk3qhwBIWKDnNVu66ygKU1esHYyCpKje/e/IAyz5EKs
	gp3If27LsKgylGsTM5HRUXr0Mjqp7O0c0dIuLOEwtbmqALYillA37Bx/YN6cuOpMLm/h9QLdlZO
	0bKaOVENBn6mJnzArAhbxAsVNurb//81RlBiJvkKtjQKUIMc5vasUMTnuub0Ya3aZAIuh/fyAyR
	u7LKQP6C6b0n77+Jfo7sszDb4hvNTxzQlscmYk4+i9e/uIXhf4l5JZei3ABNvrKjCMglCYu9mZt
	Xz+j6T+eFukB0bLyzoy6G9lNMQ==
X-Google-Smtp-Source: AGHT+IHaNRtCNWgUYc5RPhLYoD+nULNJ4nH9LNtSZkCbb+Nk0d7DtvBVzdaKV0/uL+kFEgmffI/ryLd+1MDzyV+BJT4=
X-Received: by 2002:a05:6214:1cc2:b0:880:4bde:e0cb with SMTP id
 6a1803df08f44-882385de9demr131074376d6.29.1762796952867; Mon, 10 Nov 2025
 09:49:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1761763681.git.m.wieczorretman@pm.me> <0ca5d46e292e5074c119c7c58e6ec9901fb0ed73.1761763681.git.m.wieczorretman@pm.me>
In-Reply-To: <0ca5d46e292e5074c119c7c58e6ec9901fb0ed73.1761763681.git.m.wieczorretman@pm.me>
From: Alexander Potapenko <glider@google.com>
Date: Mon, 10 Nov 2025 18:48:35 +0100
X-Gm-Features: AWmQ_bkJUSMUoO8onDW_Kv00mrjnva_voIrMRMQdowErjlplIdY_Q4t-6BqV8ig
Message-ID: <CAG_fn=W033hGM7_jnj0irwW0gc6McLw2nbhfZROWfieqKTxVdQ@mail.gmail.com>
Subject: Re: [PATCH v6 14/18] x86: Minimal SLAB alignment
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

> diff --git a/arch/x86/include/asm/cache.h b/arch/x86/include/asm/cache.h
> index 69404eae9983..3232583b5487 100644
> --- a/arch/x86/include/asm/cache.h
> +++ b/arch/x86/include/asm/cache.h
> @@ -21,4 +21,8 @@
>  #endif
>  #endif
>
> +#ifdef CONFIG_KASAN_SW_TAGS
> +#define ARCH_SLAB_MINALIGN (1ULL << KASAN_SHADOW_SCALE_SHIFT)

I don't think linux/linkage.h (the only header included here) defines
KASAN_SHADOW_SCALE_SHIFT, does it?

