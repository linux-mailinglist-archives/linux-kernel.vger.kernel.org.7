Return-Path: <linux-kernel+bounces-895027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 10041C4CC25
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 10:48:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B4F3B4F61FF
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 09:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BB622EFD9E;
	Tue, 11 Nov 2025 09:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bDI6rpIX"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B4BA2D7398
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 09:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762854220; cv=none; b=YTbONLRlWjT3rCEj0MWKZ1y8e5jX+uLA3q6y8H1lYZ9YrPAbyW82BEQIFBRi3CoXKgAmSMGKlpDoC33JXPmwXM9AZ47hjF4U1J8KItAGWNud9wBx77vIQ2sp5cLNOKUWb482ndvX2uLTcXxurxxQaoRhJnRV12xMeH2g0Wb1lNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762854220; c=relaxed/simple;
	bh=pIXt5RY2avngREVQV/WVzy+4eYrZh/+QLtTn4Iny2dI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KdGjeYHWnDYmgOk74p3dqA9Dx9kmdxw7ngKGkC9ZtqmwAsOERTLygKBhpWuUB12byb/Do3HHz6CFw0ALx0boAooCk/tSBUSF7LXXSmQz9HPs0N9+Je9g+Fa/Qy/phJNnCa1qJfils7sHPKLHalGr8nlDk59HQ5cUjmtOSQU3zjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bDI6rpIX; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3436cbb723fso2505101a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 01:43:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762854218; x=1763459018; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pIXt5RY2avngREVQV/WVzy+4eYrZh/+QLtTn4Iny2dI=;
        b=bDI6rpIXP+VW2NampGr8t7hh8Ew6NtNigDPB3koLxGn1qiiXqZTHvBzvF4LWvCcpie
         flg5+jhfDcXJcAx627ZwaAODmfN5uIs4uUoGXULR/fI6jc0pZKdchmt023fiRLfuYgYO
         2cFJ+lV7JQSiX9TkpF2iyVq7+1x5WuECi0S2/82aa1KbPNw4IHTLhknhkhlR5pUlVkHp
         SCH8nl6PEXDaLYMh6ugXjkdT6KwkahZRD8WytJMwxt4k8GBOdogALG2kzeQLN4eezV+6
         n701TG65idRjBYGoxWzbIQLodKpsYiK3a/TivfTIAqJvbmjKw9swCowpDTlR8a8vaKfR
         xS0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762854218; x=1763459018;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pIXt5RY2avngREVQV/WVzy+4eYrZh/+QLtTn4Iny2dI=;
        b=RpyMK0OCSBsCqafQtPQ0/kcv6tHC6W0nab76MDk0/3JZ0YNiwF2aZ7VaLNwuke7yiN
         Gtj7cH9iZuNqOrSjC5QRBDoLjBH1o6HJSfVSOrCrjkKgZS9c+rhDfqEjvdQanrq7xxsJ
         XTRkY+kg4JLiHsgf4nuXyjb+Q3ggr3OlqdOnkfRsuUm0gXLPvpYsu/kgA3Fy9H8PnmcX
         jkwbnq8fZvjJX5Bx5hdr0NNqziwP5m+CgNIaug/0XXZZq8QJDri5isPYPH7/l6dO6vZg
         D/orLvxwGrYt0SH7JAjiloLkaN2seOxsKkPqU6AnCuBkcGMi+7aR0cgvAHaEzuf/vXsy
         oR8g==
X-Forwarded-Encrypted: i=1; AJvYcCUDXFyAF9SuLkEKkVO3ux4Y0vSksynlAyxj9UxaWx6TjFTcUbLPyjPjOEuSXWx5zUmDuu9s7vruKuVjd4M=@vger.kernel.org
X-Gm-Message-State: AOJu0YytioY5Sq9rLWOFrzwlYaP4ianDhzKQYRrrVnK66Fmv9StGp8x+
	csCtXkkoPXhRY8hL6FQsfGmDx8LXmickGQxaMJiIjmsFPfzPJa3RntZLNH9A98AdHPfshlq3NSt
	EpPobDzO+0voyoin/xw4kZKXTjFV3S/wI6FPkbkv7
X-Gm-Gg: ASbGncvJjg8nVBaOMys4IBiGw4/jFZAzspG+DK0ePzZ5KYCdXP3JyNUQfvxJRkZW31+
	MCmk7zjLdPXCsxf/8KLGZC4kbOjRpH6udF2PmSUu8i9M0Rp3vDzsNWAmtlH/Wu+wuGBTBM/VJeW
	KeFZQDZb2qA/X4JVm5gS5MBf4VWxD+jATsZN8gdpKdQdzg50f7cgQvSAkKGNRICAy9XcOSruhS+
	ocGeBwQ1tjyeSqk25MP+oNDh36CvUCufnzn2SY+dylRYtFynZ0hLz5WObDrVYsE/eSJ5BQBav7J
	rF/woWyj/7fSZ4wYE8m6BZ5Ha2+dJc5KmLzb
X-Google-Smtp-Source: AGHT+IEXo9sAHez4NR7EbhnospiZemL/LvJQCJ/Qa++0OXR1ORpXnOCB1WU1DKZb7CVWmG9+mXoqaQaxouu4ZLKngmU=
X-Received: by 2002:a17:90b:6c3:b0:340:5b6a:5bb0 with SMTP id
 98e67ed59e1d1-3436ccfd8dfmr13988152a91.26.1762854218118; Tue, 11 Nov 2025
 01:43:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1761763681.git.m.wieczorretman@pm.me> <d030a07c956c1e7cbf8cd44d6b42120baaa41723.1761763681.git.m.wieczorretman@pm.me>
In-Reply-To: <d030a07c956c1e7cbf8cd44d6b42120baaa41723.1761763681.git.m.wieczorretman@pm.me>
From: Alexander Potapenko <glider@google.com>
Date: Tue, 11 Nov 2025 10:42:59 +0100
X-Gm-Features: AWmQ_bkUJ_QlWZiGCG2FxZvthHc4c4y_090hZyMeaaw5jt0Qf6xk9VB1Qerb_Pc
Message-ID: <CAG_fn=VUzLi1C9jss1eHV=pPh4QFmWk-fQUbhNwrGNSUk-yKaw@mail.gmail.com>
Subject: Re: [PATCH v6 08/18] x86/mm: Reset tag for virtual to physical
 address conversions
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
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 29, 2025 at 8:07=E2=80=AFPM Maciej Wieczor-Retman
<m.wieczorretman@pm.me> wrote:
>
> From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
>
> Any place where pointer arithmetic is used to convert a virtual address
> into a physical one can raise errors if the virtual address is tagged.
>
> Reset the pointer's tag by sign extending the tag bits in macros that do
> pointer arithmetic in address conversions. There will be no change in
> compiled code with KASAN disabled since the compiler will optimize the
> __tag_reset() out.
>
> Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
Acked-by: Alexander Potapenko <glider@google.com>

