Return-Path: <linux-kernel+bounces-789602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A75F5B39807
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 11:21:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65187687D6B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 09:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0127C2C031E;
	Thu, 28 Aug 2025 09:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MwdH0GyS"
Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B310920B22
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 09:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756372860; cv=none; b=grVRnWcMXvRqt0dDT/zRFU8BLJ9M7bXzOW5c5mNz43MC9/MdhupXiS9ZqaSxVcfc7gOrp4LTyChtoJON3ruNk3pRp87qxoZ+qXRImgVSrGvuWvqNuM9bT3KMqH6eCwWfGdkBUaRjVOKPwTyO+TgFsQJwVzIsT41aFKXpho69CfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756372860; c=relaxed/simple;
	bh=65CAHKlbfWD/0tT9kkxafM6Bk5emxPQ38FowJrJX/MA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HoRyS/8skhM+GM7Mb8UUHIeUNpUlUqbS7Ep/+6/JDN+XMSQlrHcG3E+ZHLX2jxgeLYGryPjlYmDKgw85gqIGN4OI0YAS34EiTqYdQGbcLT0ZKdaU4TQhEE2/amfUEU5MaavWy8X/9SMdGIjQxV8QE8JjNsRkWu9dFrykPOS9t88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MwdH0GyS; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-61c3f6067b4so597900a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 02:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756372857; x=1756977657; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YM5qp7X76Rcedsuqy22c62bk9TbDWzDaDH8Yo5p7tbw=;
        b=MwdH0GySCooZLWcItYMFVRWB/WqZS/+pMI5NNU9piW4cQLClxZ3n8Z2VktKoZgr+pe
         A40m1hJ5xJyiryl9SSJstC9M1/KAgYUpRur0UyJrsMw8IIMKRWM1AUp7WY771ye2Qh+6
         nLaPq9nj5CkAnypW6yqOeS3QKj5qoZZGJ3tdTusKKqzI5yFoyIt3DCBbFaPyxzAva559
         Bts9GBqkWhNP/Kw7VDc2Wo6yXcP6a02P1BOK6V6FRWOhoMkS/iHSF0uMbKZFGZWFJf3g
         FqZMTzfUS8e9FTKhoKHqGoANQmQJiAn1hWofdBrg9Qbmd/um4PSFiqPaaMFPmDbWu42f
         +Guw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756372857; x=1756977657;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YM5qp7X76Rcedsuqy22c62bk9TbDWzDaDH8Yo5p7tbw=;
        b=pbIYkhrojUhJ7q2xSD1s4aRfpyYIxqGgdjOqGN679LqGaDJcvmEFJclU17pMm5NwvN
         NX3D8Dg8SWSv5/9McRYigK+42GP2/mqjdnG1KK7ohKgg7lvJ2AjbRliKhLTRgAMvId9Y
         oH5HpSBaQnW/Twc1zX+FcVfjVqgVPq0NXsjCjDTAffthJe7VevA0og7kibbF3yDbQBqh
         hU08mrusrh67OWM/xELBHrZMHHZSLpI7nzMqBwpx/F4FtXb9bX/igU4fybAIqzYylhK0
         Z4JLS3/krZ9K7aQFXC+jEekX5LIiGYUPwmfuMxlz/Hb0Ap9ZnLP2v2gjSPBIFGcej/GS
         uw8A==
X-Forwarded-Encrypted: i=1; AJvYcCU/zYMuiDoqRGp0E2gjuNc8uBsIlGItYRnAmFW0iOWp385IlWZZX2ukwoooeGlA3Y2wqKJtsnqhww28g+4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFsckKHBzkOaxtQ9T0eUd5f9ZRUq2JhtJHggmXQXbSHxFA84dL
	COmzKIj145D+fc+ScXvO6x3fwhLeQBgIgvn9Le0rY2/FNjOZDIDtG5QSlFqhvFIiLrnsM7nTKik
	j0azYCStM+VmWyg==
X-Google-Smtp-Source: AGHT+IFkVH92/Q0D0GIcS9KaxX1UP6vLGf0Qcpt1E1rUVYyfKDRramMD/6V/MybaQIecatsjMOq8RZHy36Ab2g==
X-Received: from edn13.prod.google.com ([2002:a05:6402:a0cd:b0:615:6482:748c])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:358d:b0:61c:73cc:fb4b with SMTP id 4fb4d7f45d1cf-61c73ccfee1mr10144954a12.3.1756372856958;
 Thu, 28 Aug 2025 02:20:56 -0700 (PDT)
Date: Thu, 28 Aug 2025 09:20:56 +0000
In-Reply-To: <iucjeilrzonjldwizwkeo67ouo6o6nbqbnmlsyoua33737ekj4@uf4iekswazec>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250827-b4-vma-no-atomic-h-v1-0-5d3a94ae670f@google.com>
 <20250827-b4-vma-no-atomic-h-v1-2-5d3a94ae670f@google.com> <iucjeilrzonjldwizwkeo67ouo6o6nbqbnmlsyoua33737ekj4@uf4iekswazec>
X-Mailer: aerc 0.20.1
Message-ID: <DCDY7RAG4AN9.1192AMMUC2LMV@google.com>
Subject: Re: [PATCH 2/3] tools: testing: Use existing atomic.h for
 vma/radix-tree tests
From: Brendan Jackman <jackmanb@google.com>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, <linux-kernel@vger.kernel.org>, 
	<maple-tree@lists.infradead.org>, <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"

On Thu Aug 28, 2025 at 1:05 AM UTC, Liam R. Howlett wrote:
> * Brendan Jackman <jackmanb@google.com> [250827 07:04]:
>> The shared userspace logic used for unit-testing radix-tree and VMA code
>> currently has its own replacements for atomics helpers. This is not
>> needed as the necessary APIs already have userspace implementations in
>> the tools tree. Switching over to that allows deleting a bit of code.
>> 
>> Note that the implementation is different; while the version being
>> deleted here is implemented using liburcu, the existing version in tools
>> uses either x86 asm or compiler builtins. It's assumed that both are
>> equally likely to be correct.
>> 
>> The tools tree's version of atomic_t is a struct type while the version
>> being deleted was just a typedef of an integer. This means it's no
>> longer valid to call __sync_bool_compare_and_swap() directly on it. One
>> option would be to just peek into the struct and call it on the field,
>> but it seems a little cleaner to just use the corresponding atomic.h
>> API. On non-x86 archs this is implemented using
>> __sync_val_compare_and_swap(). It's not clear why the old version uses
>> the bool variant instead of the generic "val" one, for now it's assumed
>> that this was a mistake.
>> 
>> Signed-off-by: Brendan Jackman <jackmanb@google.com>
>> ---
>>  tools/testing/shared/linux/maple_tree.h |  6 ++----
>                               ^^^^^
> Did you say radix-tree?
>
> I was going to accept this because I put my code in the same directory,
> but since you'll be respinning..

Yeah, it's only the maple tree tests specifically that are affected. Did
I understand correctly that you're asking me to reword the commit
messages to avoid confusion? If so, yep good idea will do.

