Return-Path: <linux-kernel+bounces-739232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ECB6B0C3A7
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 13:50:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFA40188B041
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 11:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE9442989AD;
	Mon, 21 Jul 2025 11:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i5DgYe6H"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE61F2AE8B
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 11:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753098607; cv=none; b=ooem5jpnZvxslaeuY3hok6Vwm2zeaXw3svR2K7EytLFFcM5aKXFFNbdcqNfdENqTyxinofxZmzERphpVxvnaep6rmw0l6B4uMCTsKryDkv/ZjS7M2TDT4vplRRCaFKm6TMW6D9DJ9ulma6X2ripujdi52+3GDjMutrMCGmx2QXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753098607; c=relaxed/simple;
	bh=1QliNJY3/XWxPZSS6fLtwfwhk9UK/VozqaxUsIgBrRQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VjKhgQpHx4zeHguvuxMhIqRe3od6mOXi0PjvTNyyS0aAiXcWwUARCb6M+Pd/I9WrCjEtj5fJyBYqm+zJlzXl2T6/XW5yps3wb+yktksiqzJ5dGg0sRtedQZtdL7/m2p42JOAl8XsW1AGRBrf22gxjYBOYAoVl9HE6v5vo0AK2qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i5DgYe6H; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-75bd436d970so613364b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 04:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753098605; x=1753703405; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dZt6Ai9hbl1LalOlbqZoo6RUDZ53C0t7j4pmRLMyXOU=;
        b=i5DgYe6HHH8+jENf0UjLqrXsNto/wApKi71T18d5X2iWAMTJqiPAPvUcsaZyDt0l2L
         Z/KNfWjMwane7rdGcXtxA5AOh7TGxhfjy4GltgckOM2SjE8qNexgUv4v2Fn3/ir5KnL2
         mOvIR06aLFVBHfi38WqwyZ3jRwPu23jAtrFmIuBEOqASLPfWeP3/eECS4iOTNa03yEeI
         huWcLhgQXHv6KeRbvKMRHS0tdLHz9hHM+ePEMvKRLJlBZgAsziE5ot93UeT+roct8EtG
         fxFYE/R4xv+Ud+70atR0Nux8JB7yduD/SHxcJpABEXkhCpfjZtHtbj/dOrA2uf8PbXa3
         Rc7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753098605; x=1753703405;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dZt6Ai9hbl1LalOlbqZoo6RUDZ53C0t7j4pmRLMyXOU=;
        b=aCsdu7KxoZv9bg2fexFRaC1pKCH5GScVMNAGNwavoB3iW03/dP8+uMWidWCfMLd6uH
         MFrRBKBSgsLrz+J3rikeGq5iavXpfCQQ2qfWc52qA1wEyjjp8Qk7i9q98bkvJJPLy+6p
         0zLvpjwgC1gHsx1u5dwDiSYGEkgX/PaPbNMuClTkGg/pA7uP8WZglz3TxcR1cxHu0A9b
         5I15slJ9mwMd5pG0HnlmRP8BKg9VP0bErHfKZQqTHKCsZrcb7ztOn8eO0DC+yoRIHZNF
         3DLC6iZi0uKGlsHs2JRWvZxiLo3pVNrF2t2MDvQHGRdaVlywO3N9oGB9Ui510uvuYPqy
         XSGA==
X-Forwarded-Encrypted: i=1; AJvYcCWYArXVaXr138vYNMdjL36W3woF9a39foYJ+xPzxKyXlbFc30VyKn3De55pCU4V4MRwt2Uzra2ZuBEGG08=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/qEg0DX/9OQA23OXfX12PM7UbCzCx9oBsM0boNcXAbNUB+KAb
	I/UmrE6MzB+v5DsDNBw4DMu0aC0ZNTqnh2KjM7qZGQobaAifB4/y2QCd
X-Gm-Gg: ASbGncuAPpiYE5r7KAwWgvX5vNKvxA3NY2VOrfCiBt0WVKcAPC79EY6SursFELup5qM
	Vq3I+rnN9coYOvTuYVn0wfPK9jPx/JumDeN8Pu4R2dfD1WttnlbqjXkT3Uv/k7emuRMzG9+p+0u
	Q/HiSSTYvoOMcLMxntV7nc/CcnxrmEfSLezta/FFIlxeuahma6xaat/lu3mdQqp20zaIMr3jaZJ
	Rx84gVBwqUr6T2KM9CObsM6bIeZsDb5zyfzQBKb25VXLA1O8I2ztj93r9v6DU1DnRCXakolQRpx
	06i8BqyW4BlPbmTHPLT/DDqG/lMQ3vPZWB6dUlQHT9CtVM32QXxIxMgBsT7jlTeTYu1KXNE1Jn5
	4/cA0/3o/axlRwy+1l0j9rxWNT/q+bzScQvdlYFHRs6R1JcSo
X-Google-Smtp-Source: AGHT+IFE7JIwPmyMIlr6q+RLOHnV3iGmcVeYhfH5eAK9q7J9P+g3vPHm0C/5R0C/KXXmvmvV/UTK6A==
X-Received: by 2002:a05:6a21:62c1:b0:216:1476:f5c with SMTP id adf61e73a8af0-23812b50d6cmr33562059637.25.1753098603508;
        Mon, 21 Jul 2025 04:50:03 -0700 (PDT)
Received: from DESKTOP-GIED850.localdomain ([114.247.113.178])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-759cbe61e38sm5559229b3a.161.2025.07.21.04.49.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 04:50:03 -0700 (PDT)
From: wang lian <lianux.mm@gmail.com>
To: david@redhat.com
Cc: Liam.Howlett@oracle.com,
	akpm@linux-foundation.org,
	brauner@kernel.org,
	broonie@kernel.org,
	gkwang@linx-info.com,
	jannh@google.com,
	lianux.mm@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	lorenzo.stoakes@oracle.com,
	ludovico.zy.wu@gmail.com,
	p1ucky0923@gmail.com,
	richard.weiyang@gmail.com,
	ryncsn@gmail.com,
	shuah@kernel.org,
	sj@kernel.org,
	vbabka@suse.cz,
	zijing.zhang@proton.me,
	ziy@nvidia.com
Subject: Re: [PATCH 1/2] selftests/mm: reuse FORCE_READ to replace "asm volatile("" : "+r" (XXX));"
Date: Mon, 21 Jul 2025 19:49:50 +0800
Message-ID: <20250721114950.42139-1-lianux.mm@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <42db9f05-11cc-453b-8259-39cee70f137d@redhat.com>
References: <42db9f05-11cc-453b-8259-39cee70f137d@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> On 17.07.25 15:18, wang lian wrote:
> > Several mm selftests use the `asm volatile("" : "+r" (variable));`
> > construct to force a read of a variable, preventing the compiler from
> > optimizing away the memory access. This idiom is cryptic and duplicated
> > across multiple test files.
> > 
> > Following a suggestion from David[1], this patch refactors this
> > common pattern into a FORCE_READ() macro
> > 
> > [1] https://lore.kernel.org/lkml/4a3e0759-caa1-4cfa-bc3f-402593f1eee3@redhat.com/
> > 
> > Signed-off-by: wang lian <lianux.mm@gmail.com>
> > Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > ---

Hi David,

Thank you for the review and the Acked-by tag. I appreciate it.

> Acked-by: David Hildenbrand <david@redhat.com>

> -- 
> Cheers,

> David / dhildenb


Best regards,
Wang Lian

