Return-Path: <linux-kernel+bounces-869569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F75EC082F7
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 23:30:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFDFC3BC022
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 21:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65428303C8F;
	Fri, 24 Oct 2025 21:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K6uiFElY"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 147EE3043A5
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 21:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761341278; cv=none; b=ifD8ueH9Yl0qg54w45sgZ4lcKfZeNOn0mDsARnj/G9ZwXzxSsGsNlYocGQ/vxYb1FwQfQEZhlWNcyG+AtvnZBbGmOLRR6eKT9wH/wkpUASdPGiFoGxPskV540A+NRgV0CO4XL86qXOJZHsb+Tps8efMM/o1JT89oQwNPLDZundw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761341278; c=relaxed/simple;
	bh=h21JfMMhITzhhnwxP5rWgG9EeRef6/k5P5XIghANvRw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BSwMdCYhKQ+zMoB800tgAes24MnAdqcmUYicQUrE2h75fSgF27JULsOntuLhWOLDfoRHXc1Lkuyr6W1dhTO9s/rhUjz87Mo+k73klZpSBbktq9OeY/DVQHVDcC1j6Fxg2g30zF7zKUOWhgZFNCzic54px+fh/c6FI9DrQC8O2Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=K6uiFElY; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-63c44ea68f6so3209a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 14:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761341275; x=1761946075; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h21JfMMhITzhhnwxP5rWgG9EeRef6/k5P5XIghANvRw=;
        b=K6uiFElY40kNGINUvH4GApc/KLa8kiruvl2oq23LrMP6+CXhuu9VdsziBZS9lF6N8v
         1rNN1Ez/+2lDlk4TQtYbW6tX1+W0JwitV19y5PaRi+toxUj/3gUw8NoRCiKgqQIFRiLl
         yjU7VlzDpRE6G2NVOE/Zm4ovtN3crh+kYBPc9LnfQxX5+rCaTqoEMiKHwOZ/GJfn5kL8
         QgIXn9fXR6v3nFqFtoXTHoIIEj5P3q8imQ/LHhrSdoiihe13oEsJg/QD0geCyXfsz0XC
         yF5YzY2inrCJL6HrBaocySoS/VF8Oc5vIughMyRYziYeWhLIgRl/nvB/OAqjI5QK82eU
         eAPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761341275; x=1761946075;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h21JfMMhITzhhnwxP5rWgG9EeRef6/k5P5XIghANvRw=;
        b=DCUSMUFi5S34S85ek0bUJm7WHnX6KC3Yr6P0lkItYauYKYnS5XP+gC2UOpgBvEC+LT
         P29KvBiq9dduGOWUsfholGJ9q+SvfczEXZ89omYw5wIvYxLD2ZnlXvtucywZvZ9B2Ygk
         klX2DSoxjKTBd+PmxnEBbuugTij84t6a/A27m/4vKvkT+on8TQjWlO92bP3VpYsUaVJ6
         z8Co96oRgqGWMWB/tbIdgeq29y6dF6K3VKGvWUPQ3O0r7QDXu1e11FCIaDxS7Mm7646H
         ZQN9eFJ9LG85jIMjQIuk31PxUeEgCX7UHMm/zxJpuHNa+Dtu35T1EZ8q32R2MetK2LB1
         do2g==
X-Forwarded-Encrypted: i=1; AJvYcCXdeYTVB7uETO9MEx8Ns72WlfybGPk4AR7Slx3eHwrbEZNovS1WOpsoKrk0kC96pRsu12ZooCghlcaSIVk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFFVDY4oD1ZInAOXHHaLTD7B3roNRLVq29B06bzqiYiTZO83QZ
	/LkhMsM1dxXtWGjJ4kfqJFIkXBhXydtNVLKMeGhI9mNCouezSBEkF5YpO+kdMS9uI3cVOb422um
	0whOTsgawq1tMWQ1D7AUPukx3YGHVe+2vHxmIwluK
X-Gm-Gg: ASbGnct4F92foamLdA+rCkIwuXVNHztcJFG9nbQt+4QPu/47k76Jm1DePuAG7KIrIE/
	hbbhjXUu1HVEBtPqF6WxravkAgYLZX741I4CXpWymXYNj3fx8DjkTkGFSoXj5A9HOoGYGiYDp39
	jYmJ80luuMuL+2ivBTyzDxf4WIYWyws1l8YoOPfXk6jCT9ocw8tz2c6wMqpmI27LGiofkxYzfjr
	RdJui84WpJfLvhoLuqM/xhrRfYsAG611SFZHARMLMHCBZCrvWzEyta5rBZvh4GcC8xEoZxK5+Aw
	dhIgRuBvLFoD
X-Google-Smtp-Source: AGHT+IGkQJVbp0pEdj69ujfHSUeaQt6pq0SXhvCQgPbX7BctRJ1X4cEub4A5pea3IFr831oNbNIBwBZMof8A4GiTQJY=
X-Received: by 2002:a50:bb46:0:b0:62f:9f43:2117 with SMTP id
 4fb4d7f45d1cf-63e7bd43384mr33048a12.0.1761341275199; Fri, 24 Oct 2025
 14:27:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022233743.1134103-1-mclapinski@google.com>
 <6bd76106-339f-4204-a418-738b7ee545ab@intel.com> <CAAi7L5fxqiMMGJi2xB42L+A-xVQwx=10TBG_kU15=q=i=6kcbw@mail.gmail.com>
 <5c80882c-7d3f-4b8f-9a64-42b9cb2c5ee7@intel.com>
In-Reply-To: <5c80882c-7d3f-4b8f-9a64-42b9cb2c5ee7@intel.com>
From: =?UTF-8?B?TWljaGHFgiBDxYJhcGnFhHNraQ==?= <mclapinski@google.com>
Date: Fri, 24 Oct 2025 14:27:42 -0700
X-Gm-Features: AWmQ_bmYhcDlPOA020xGQukiNAis8bx4mmjmrWt9hS-CO_tUDwzDTXtZ2qoJkHk
Message-ID: <CAAi7L5dOJR2DK48_gS4_cUKQuVE+MqdFKfXcfmEwFAGPzrZZKg@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] x86/boot/compressed: Fix avoiding memmap in
 physical KASLR
To: Dave Hansen <dave.hansen@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Chris Li <chrisl@kernel.org>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>, Dan Williams <dan.j.williams@intel.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 24, 2025 at 11:21=E2=80=AFAM Dave Hansen <dave.hansen@intel.com=
> wrote:
>
> On 10/23/25 16:23, Micha=C5=82 C=C5=82api=C5=84ski wrote:
> ...
> > If called 5 times, on the 4th time `i` will indeed be also equal to 4
> > but the last `if` never executes since `str` is null. On the 5th time,
> > we exit the function via the first `if` and memmap_too_large never
> > gets set.
>
> Ahh, thanks for the explanation. The implication of the first `if` is
> what I was missing.
>
> How about we just move the `if` you suggested. Let's put it right next
> to the i++ so that they're *obviously* connected and the moment `i` gets
> too big, the very next thing that happens is setting `memmap_too_large`
> and jumping out of the function.

I might be misunderstanding but I don't see how that would work. When
`i` gets to 4, it's perfectly fine. That means we parsed 4 memmap
regions. I can't fail then. But if `i` gets to 5, it's already too
late. It would mean I've committed an out-of-bounds write.

We should fail only if `i` gets to 4 and there is more data. In the
case of calling the function 5 separate times, we don't know whether
there will be more data.

The check would have to be before `i++`. But then we're unnecessarily
parsing the argument. So we should move the check before the parsing.
And then we arrive at the code I proposed.

