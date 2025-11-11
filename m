Return-Path: <linux-kernel+bounces-895126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CBBBC4D029
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 11:27:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 568594FBA31
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 10:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A566339716;
	Tue, 11 Nov 2025 10:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AiNMTADZ"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0118C33A032
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 10:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762856092; cv=none; b=nPTM12qD9I/mjHtvgc3q/cVw1mrtQOBw6KiFU9sv6mKUCRvVBZw+d4TEzGK2h6/Ezar7Utd5t/+pJAev6EOIBa7Id035IaroXNoopIsHDJp3v9rbFe/CmXfzg4IZNTrHl3Mg8Jm99OQmO0D5NGKvcJzWraDpVVGiA67eL+WewgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762856092; c=relaxed/simple;
	bh=QCoNa0bAFU4qkhO5GhIkfapiatY4Py/cCoDedmB34wk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BAX/b/a+DPucawNLEc48n6VmiU8MgRfnQrn62ojzCICNdzLeWFTRnkA9uU6tySBLDZ7p/E+ngn6MICQq6nktXbw1pnhFN/sfPQYOU9nFiADJUb3gX+c7EvD8brkgdZe2WVHNaqwKVoeZCNyd7WTZRX0whj4apMXQVfDmftpTrJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AiNMTADZ; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3437af844afso2516845a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 02:14:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762856090; x=1763460890; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QCoNa0bAFU4qkhO5GhIkfapiatY4Py/cCoDedmB34wk=;
        b=AiNMTADZUz0sVD+AWDCRC6XeC4li3NJTME4vB5hxqUPQE4kVBV7gC4Nr7Oms/vLoTr
         5LHEm5EQn+iV0YSy3I4UCODdhKEFSYazK4TgHC3QURhtIZodF1lD3Y/Ohbf4bcaNw9dJ
         JmNxcBUWBz+xy38inIAEOxN9REmNnRKNVzexvmuCkqFLrgSMGpchD8PAgC+D/pUhW30+
         9J4OU7/uR9uRNdOyUm92HpMaERRwhgBDXn6ZE0Z0vhVnYimQ+M+0JBlTpVO1jtXo91qS
         7p+tf72kM4ouhnmSbTJOBVuo5zHn/yKhI5KwzEQW3rFG2wbl+Spy+dp/Jq7c77psFLgE
         ntPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762856090; x=1763460890;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QCoNa0bAFU4qkhO5GhIkfapiatY4Py/cCoDedmB34wk=;
        b=vfatulx6GWcukZ/HoC0kFe/9W3PtzJvQN9FmG8/vNLOfhYzVCpOO1KdzBFKgZ2qoKM
         n4GzholSkY9YfCGPkiICK438MEoyYIZW3d9xlcEHKd4VF9PMhijY4WoxWhXsmRKS36dw
         BBiR0Joitr9o4wB/evSimAA91DgD4O6Iy6pGhwh5dPl6zD4MfE3HVossBc+J/VpwhjPk
         7pvdb3UlQKkg/lfy0z/KLGkwr3/Y36swLFJR/bT9eTCKfRtB9Ih018Qk8rWYrmG9iWwE
         VFKcr5G0bQv4HQDEUxrcssw4K5lyqjstJaEhS3M+CoXrTu2bIqpzCfOOYpkk1fID1DHQ
         lc1A==
X-Forwarded-Encrypted: i=1; AJvYcCVR3w6Am3Nk6A7hLbb7OvZwAqigi/3bAbpnmDzjPgbt851qvp85jneAPiVcplliXgC0N/5SRf1ozfWXUcA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVqPQ+0h4XBMpd3j2OHt3XemWczV7rXumMlxc59XOWaXtckAHv
	+3NyPfYmWMxLfMonpH4sCdGue/EOjTTgtvtvNvyR7MQGZIR5pnYUR1Yt1hraSd9tBwbZCTkKnC3
	+pIenbf+KZSuB3JQwikFeXPNevF+MlO89IR8M38QZ
X-Gm-Gg: ASbGncv4WQcEMIdSgzRkECWNo+U/7grqGKoLlGldzRkr1cF2puYFgAgIYFK6t5Bv53V
	3hpqmcbKfd6fA7lxEbxUS9sS2r4haNpNX4ulPFHGyIU8mhCSkVAPU2hDxYmrCS6YCxz/LwJqmLr
	iwwYMGHWLRkS+qO29pRbuRe//p4yTe05w9xXVCso1Ge/8nQCRe1x64AQPY9Ek4MvMfR6l0Knzkl
	f8iM9MeJlZHViIkVmaqS7nfe5jYp54TBaWLFs5Yf5zQcChwsMVSfpORYoPW0ErRhySvM/Wu+hX2
	ayERHVaNUuEu4rS65Q1V2gCW2eYCwIvpi1y1
X-Google-Smtp-Source: AGHT+IFQSxMJjSbUGKNKNlHPOvAOCrOFIwylDJVM9WLCE9houa0HQsWEPCsgreAvWbtMbfV9H0B8kgzaUxxNh9fow8M=
X-Received: by 2002:a17:90b:1f87:b0:340:bb64:c5e with SMTP id
 98e67ed59e1d1-3436cb89ac3mr14436274a91.14.1762856089911; Tue, 11 Nov 2025
 02:14:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1761763681.git.m.wieczorretman@pm.me> <8b0daaf83752528418bf2dd8d08906c37fa31f69.1761763681.git.m.wieczorretman@pm.me>
In-Reply-To: <8b0daaf83752528418bf2dd8d08906c37fa31f69.1761763681.git.m.wieczorretman@pm.me>
From: Alexander Potapenko <glider@google.com>
Date: Tue, 11 Nov 2025 11:14:12 +0100
X-Gm-Features: AWmQ_bk1ReQnmXZU019ENpKczYWPK1RduG0S2XHhWai-9JyZu-To_X33SgyNVa8
Message-ID: <CAG_fn=UzrdF4v_0iK5b+DHDhFG5pD-W4cac62YYK5x2hgPx9yA@mail.gmail.com>
Subject: Re: [PATCH v6 15/18] x86/kasan: Handle UD1 for inline KASAN reports
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

> +++ b/arch/x86/mm/kasan_inline.c

The name kasan_inline.c is confusing: a reader may imply that this
file is used for CONFIG_KASAN_INLINE, or that it contains inline
functions, while neither is true.
I suggest renaming it into something like kasan_sw_tags.c

