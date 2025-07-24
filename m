Return-Path: <linux-kernel+bounces-743964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F257B10657
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 11:35:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 982BEAC7640
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 09:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1659C279DA1;
	Thu, 24 Jul 2025 09:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1UGICBqT"
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B781228C85C
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 09:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753349241; cv=none; b=szulK68BrA2pVWVKQjKxKgzUmLjrYD6D+t9ppib0XEYJ0t6D9pFm/jWktkIj080Lwk2Ru/oRIifbcU/NOfRE0FvkSjGoWeFcXFeDik/QaeJ36MWE9l0zb74eirvjRamwjfJLxPSOGGKoAc/L8z70UjwLlWhj1pxJpDSxW8ctif0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753349241; c=relaxed/simple;
	bh=+ZnY3P2X7S+RjIK7x3kjMud65ddeKN8CGNIBvXvMncQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kUydLNjOHNTr6mQ6hhQ2AzfVfyWQH0R6Oj2LCujizGMMqDRdhg7Xsh5ALD/5t1Y+r1LeLNwFqYZ+DoYMQBKrmd6YbtQuy8tkrh/U3jCwPHKzyXF6UT4Jti5q0uBPC9XjS9E1Q12q0fGZ7HtWEzNPOAzWLbfO2FpAPOdYglQeG1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1UGICBqT; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-3a4eb6fcd88so545793f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 02:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753349238; x=1753954038; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PsrwKI3F7bGxyMyCeBsCzUls3NPftVxNs1GB3kxRYJM=;
        b=1UGICBqT1ZIWgjiOXCuGr7zQ2PUhDBdeY/6pLHPij1lEpseCP2BOOaLdL6QNVl0r7m
         eMsemEZVgVeWohE71HCszNVOm0L21zODEACYjbRd4ZkFJh5avwAGKRvJLiYjrpyFpsqk
         2FVkPbXxv8cRSX8X9Cm3O573YU3y6Vg+HhnkSLY4bppxhf5V+3UMGwTcb9tyXasVgrXb
         3o7DzIrouI78rOYIlDCMj9pqL28X1x7UN6TYnAIkzxzyJlRmvpV6MrvDzkKCh7VHYzMM
         xleihsh3V4yBoVH6EiMxCrJiLTd2sCD13xJKeOcSspB3BBeNYmY0jhkGav/izNMuM/t4
         eixg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753349238; x=1753954038;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PsrwKI3F7bGxyMyCeBsCzUls3NPftVxNs1GB3kxRYJM=;
        b=lG1CpCAHAJYfRG2clTpWfjXSyhRvLFLsYyJLPDIyJsYoV1ISDINSKl72zjtfnL18XO
         m31nJz0nIobbLnbQaoflJOLp1hoDxqaJbJLHC8Yym3yCGhs70d129GzRYc0n7lNEG2SU
         zG3HsOCms1ip0Xl/3aG/V2iS9GtMg4g1YsKHseAA8Ck3ftrATcM8N46y2Zo2/wkpp7bG
         cF242QgbTYXK8+mRyO604pX12QGpUrexz272ndEs5UJOw72rIJ3Lv8niE10EXT9i1o+o
         w3k9dwYSqyrSe5on62Vr6/8oyYeRVU9o4LAS3yRnb/aJPXys8abHNlZviMPWLeZuVtn/
         pRYA==
X-Forwarded-Encrypted: i=1; AJvYcCUfms07lG55FrX/tY0RqQlSxDbnUt++QAbG3uBt5fbClzrZIXSkhyltXzJMAT2WWtmp+MMD3K635/oRwg4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzu4zBltcfh156mhhICkD9wt3z2egU1m3j0vG9AoLWjNSDKsBDl
	uHKSm1UMA+tY9HO+9lmpfEi1SZREiLWi+us48MR+YKKhgeB7pnAvPzMMVE8KQo13g9aqqJlJl6/
	Wj6n+Tc/vSpl471+tXg==
X-Google-Smtp-Source: AGHT+IELtTR5XvjXT9CI/JkCboBp8PAzgWTU7RN+Nu/d1GBEMVnbisQm+epTaSt63SxD8yXeLjeB/JQjltpOZIg=
X-Received: from wmbay36.prod.google.com ([2002:a05:600c:1e24:b0:456:1ccb:7fbc])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:4022:b0:3a4:d6ed:8e2e with SMTP id ffacd0b85a97d-3b768efff13mr4278297f8f.41.1753349238077;
 Thu, 24 Jul 2025 02:27:18 -0700 (PDT)
Date: Thu, 24 Jul 2025 09:27:17 +0000
In-Reply-To: <20250715135845.2230333-1-vitaly.wool@konsulko.se>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250715135645.2230065-1-vitaly.wool@konsulko.se> <20250715135845.2230333-1-vitaly.wool@konsulko.se>
Message-ID: <aIH8dULJCe4FUd8I@google.com>
Subject: Re: [PATCH v13 4/4] rust: support large alignments in allocations
From: Alice Ryhl <aliceryhl@google.com>
To: Vitaly Wool <vitaly.wool@konsulko.se>
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, 
	linux-kernel@vger.kernel.org, Uladzislau Rezki <urezki@gmail.com>, 
	Danilo Krummrich <dakr@kernel.org>, Vlastimil Babka <vbabka@suse.cz>, rust-for-linux@vger.kernel.org, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
	Kent Overstreet <kent.overstreet@linux.dev>, linux-bcachefs@vger.kernel.org, 
	bpf@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>, 
	Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>
Content-Type: text/plain; charset="utf-8"

On Tue, Jul 15, 2025 at 03:58:45PM +0200, Vitaly Wool wrote:
> Add support for large (> PAGE_SIZE) alignments in Rust allocators.
> All the preparations on the C side are already done, we just need
> to add bindings for <alloc>_node_align() functions and start
> using those.
> 
> Signed-off-by: Vitaly Wool <vitaly.wool@konsulko.se>
> Acked-by: Danilo Krummrich <dakr@kernel.org>

Acked-by: Alice Ryhl <aliceryhl@google.com>

