Return-Path: <linux-kernel+bounces-816204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE5FFB570F7
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 09:13:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 906B316C326
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 07:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF71528DB76;
	Mon, 15 Sep 2025 07:13:44 +0000 (UTC)
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1532A27FB31
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 07:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757920424; cv=none; b=oZ5GGgGxpiea205PSHBRpuLBl3FHSvj3ZlrHIvJK5fbgs1rf6QfByGnc7VqTpIofNgpkvuU9/gG/D5dTHUJ9XFxiFQa6YdXkD1BBctM9PWdDzqrrYEyn6keI52o4TSbTu9Lrg1/29+lAW+CmixVOXVdpmXl61kU0RDE7Bh0RuG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757920424; c=relaxed/simple;
	bh=dfvyAXJ+q2P35fAgIjXMmhc4HlVtSk3Mc3VBrceUE6s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dlPn8at0nEK3+BV9UmM4hegeUJyoBXlhVt0/3vhYddJQM6pYskV/h6rsp4MbTqyl3AHHvbhUA4KviG7+5nhPWmsi2v5nP7gqq47PNJ4I8+ZHqc3GAS1FgwYtj+Ue6QOITUc/gGbMbNvstybMSoa6xQs7UmO/+DwYk711mdM4dFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-52a8b815a8aso1755188137.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 00:13:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757920422; x=1758525222;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RLMuvQvb9Q0HlgP3n0zmCAk2FLf3hZGDFhVwbi0PK4A=;
        b=GiIjm6jM7vJv4mjsDw0BRLSr6DInwX3h80IBEHodm93Rg2S8OKHB6XiMbDfUm1It0Z
         LRAPu3Aj3ycGxHHe/T79duLgaHzt60h84gwKBzLoPV1NmLQ/Z/+1PeN8t34q3H3Pbnw2
         HXuIsGBNKs8r7Lu186EvPd4KJwTJDfMYfZqFvPBEDRXgjKXZuBkV0BElhiUVV0ob3fpx
         sdrBQx5o6NKVy4/6XU9qKAmfnJVYB7eHaHRd5K1USFEdtiQ4IA78n7Ns1bpecovD5l/K
         UZbU4f49xhBoYtFiLOnCkDzojmHqFTh6JX/WKDYfqdsTrTEzxgK6C6MxqufWcN/x+E9T
         I7Vg==
X-Forwarded-Encrypted: i=1; AJvYcCWyqDQQfzO5q7+K6On4kpRCe9GzuVzbPtCgyryr7+zRWdv/nK1sIST5zDpQRBqTjSg3eH9SNKOFJVVJRhs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyes5I3QpPvqXHZfXr/jibwAo1MBNvj/B1UsRZQYoRojH5WeWnJ
	Dk650Eivnh5PoQa7PZ2qlNTjS20uUHe9jtGCEogjJt2pzRroYLclWH6ZSLr8YNFe
X-Gm-Gg: ASbGncuM/EtifJhkJs1FSeyRYteyGSjie4OquJPYNK03Eu1iyfs3Utdwz+jzoBtqEZo
	PwwPXJ7LhVIwuOVZZfYYIVzvge8a4aRoRDTbZwi71yPAZ838oBkR8odCN3Io3yUE/b8GHUcBLqg
	gyeExC7E51luaa0Fi/6G3XcX0XQY+tm9Z/bOQMiAbZ6ei/f6gkehLXALShSwrsVaUyEKYWHKZTj
	MCXSgtRf9/8uRo/dkYcPKJ3l/CkICYL30lG0/AEcJYjUYmM7j/+Fygq4FmJsKNjDmTrDF0mkI8G
	KXP25aWTfOxfXZ0Gy0PnOW02nuefdvgbguB2NDrD5RQxE3Nqed1L1n0pgOZAH83nv0UOX5tDv4e
	t7kGxji/r6gaq5EluP2BdumVdcBrd1bJaH0VzK7cO/eS7ndrLGME/FQFyHpA9RgQ7eE9VYic=
X-Google-Smtp-Source: AGHT+IFgQvrpURw4sEBwftyKKhr26hyGVQAn1WUqGDMr2nE2GGejSRIiZziO4E1zspbbubrN2Vnn+w==
X-Received: by 2002:a05:6102:3e20:b0:523:da8c:eda2 with SMTP id ada2fe7eead31-5560e9cd2dbmr2851337137.18.1757920421833;
        Mon, 15 Sep 2025 00:13:41 -0700 (PDT)
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com. [209.85.222.44])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5537062c9c5sm2739034137.5.2025.09.15.00.13.40
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Sep 2025 00:13:41 -0700 (PDT)
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-8bdb4985309so857988241.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 00:13:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVZ27jyDk/W1Gewbb1vTyGWyYG7NgWg/JLz2DK49l6PGV4KZO2gbNsulfJURODy5QyGByFadgaEdEUgI8g=@vger.kernel.org
X-Received: by 2002:a05:6102:a53:b0:538:f3d5:fc12 with SMTP id
 ada2fe7eead31-55610dc0d40mr3363566137.32.1757920419553; Mon, 15 Sep 2025
 00:13:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1757810729.git.fthain@linux-m68k.org> <abf2bf114abfc171294895b63cd00af475350dba.1757810729.git.fthain@linux-m68k.org>
In-Reply-To: <abf2bf114abfc171294895b63cd00af475350dba.1757810729.git.fthain@linux-m68k.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 15 Sep 2025 09:13:28 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXOnUXJbhifdyYY50fo5zoG=FH6Rvp64mQHBB9yQRyiVA@mail.gmail.com>
X-Gm-Features: AS18NWBvIvDo2gS7rnEu0r9EhvBtLAuRYWpDZeLRfT5zdiYtp2SXSdMjVN81nKo
Message-ID: <CAMuHMdXOnUXJbhifdyYY50fo5zoG=FH6Rvp64mQHBB9yQRyiVA@mail.gmail.com>
Subject: Re: [RFC v2 2/3] atomic: Specify alignment for atomic_t and atomic64_t
To: Finn Thain <fthain@linux-m68k.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Will Deacon <will@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Jonathan Corbet <corbet@lwn.net>, Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>, 
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-m68k@vger.kernel.org, Lance Yang <lance.yang@linux.dev>
Content-Type: text/plain; charset="UTF-8"

Hi Finn,

Thanks for your patch!

On Sun, 14 Sept 2025 at 02:59, Finn Thain <fthain@linux-m68k.org> wrote:
> Some recent commits incorrectly assumed 4-byte alignment of locks.
> That assumption fails on Linux/m68k (and, interestingly, would have
> failed on Linux/cris also). Specify the minimum alignment of atomic
> variables for fewer surprises and (hopefully) better performance.
>
> Consistent with i386, atomic64_t is not given natural alignment here.

You forgot to drop this line.

>
> Cc: Lance Yang <lance.yang@linux.dev>
> Link: https://lore.kernel.org/lkml/CAMuHMdW7Ab13DdGs2acMQcix5ObJK0O2dG_Fxzr8_g58Rc1_0g@mail.gmail.com/
> ---
> Changed since v1:
>  - atomic64_t now gets an __aligned attribute too.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

