Return-Path: <linux-kernel+bounces-874315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11F34C16081
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 18:03:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF8C73A925F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 16:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AF46299927;
	Tue, 28 Oct 2025 16:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="PM6sdOJ7"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D052367B0
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 16:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761670763; cv=none; b=mkjGUQjvJi3BeZUB9VUF237mIwtrHXJP0b73Dv3MDIPcLIsJIyRIhhbukrdoU+Oir1rE4fdcH+uRxd4jw7hqWzCcjvNh94RroEgPA8ZhYEOE2Rct3Gq7Li3AaIvSZjWFJBIUjhZc0huN8T6tfYeJ6b8FFY/F9kRM7p04zyRv/VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761670763; c=relaxed/simple;
	bh=xUoo3v5ZJQw29XXrDvIiWl2fdN4FMA7KctAmF276cZg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OKxPk+7Egqvjy2ny6UrLi5kXdvevzacRuYVx1QfSbSGz5s3pameJqtrDLxfkAihbexcP3QiwxfdfAfr4FNngLaT2EJ96ZPWfR+cp+ajJrMV/hkmcOb0KOiWM2CcwB2uAUW6UnYErMoKs4BUIMg1Aqff5xqN+QG+Kzvri0r3Jono=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=PM6sdOJ7; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-63e076e24f2so3853316a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 09:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1761670756; x=1762275556; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=K2dc0g/PPsN9pIaKjPWHbYZ5oM9jT1rQwz1YwGMpT7w=;
        b=PM6sdOJ7+9YL1aKaXE5ZqDPY12eBSoaJyVAWvBbyRg6rH95qBYW1i85CUn5prnqwQw
         JuAJkRNwLK9wIOMAzq8fOAMy7RnTDmgiVNEn8qF+Tqq9vjC3UNjsksIXnAgXG5Rgzqle
         8deDirW/ps1vl4TASaSn1YErj7acU0J80pf4Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761670756; x=1762275556;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K2dc0g/PPsN9pIaKjPWHbYZ5oM9jT1rQwz1YwGMpT7w=;
        b=kxKMMS1Kdv1FaA+4+wC5FaU5h7IH08/dLNDI68zzWW6j5tbsG1YwsQ5dzWykitR5Hn
         +i6R6RQ5WN5ITGWclXnPBRsZ8C5fXF3ZuI+QmgergCnShMvfXJ7JfNMk/YWmYqkDoxiw
         7YCR+7EfTi9EJT4JUyilH2Ijb+2QpqtTwEtZSWkaF2glck/Rx9gaCtMtAtgkPABTcFzS
         Ma6BXsprYURqDJv2dOl4sYrJoxyRdlwlZ1aywgMOfHCSBLpdgzS2nvgtTYs6Az4uFEPp
         qMYWr+EDcIC92xp8Y/8ui6i5mbGTDqnaY85DGrpvESlm1TD1ht8DrFXy/C7hQXTQtHZ7
         n2mA==
X-Forwarded-Encrypted: i=1; AJvYcCWS0yHJ5xX4KiX+sj5CD2bSH7Cvyz+/B4YY6CpxpkysSpskrzwRjRxHrxwQkfw2CexqzG3EjAnX+npl9mw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPItEMknFfXI1foWqP7MZMO8zkdplg8THPE2zoTpW/nYSCxcP2
	rPfKR6J4LrPpSYEavqceEXJfYMTh+fof1e9CfMcQxBsOhKnWZ12+wE6CMSU0+w8AW75Zcs/MOuR
	RIFJ08/gmRg==
X-Gm-Gg: ASbGncvCP+oaIfwlxpY27Ut3MstJUy4QWMftdQePECwwbGVbXnv5Oxn5fUpj1Rf0Fr8
	YE5GNrVG6M/De6e0D4FcWrY3omN6UalMnYwA9AEPynwWlsAnZn6NFC5pMKwtcQVLgCOPTgqMY9x
	lWn2ttDwVuRtYQLhzaO2fwWZa3ZoFWRVDyYwU+CvD7CL8eXbg7fkOFvvOh3pvEDkUk+JnI+Pa5O
	nYRO2yBeRoK3MLMI7hE0eD/C3gKLwsEr6eA+HG6BwdgOzxRjXE+gJZ4ET8oUUcF0FBdQ4QG41x2
	H/Vp9AJ6MVtmRT/zyl4YiKqJPic1UqBqhVK39KgJceMg9tnjD+KgOm3E37bGLbms4aejFM9SaE2
	R2xGoXLlXe8XB+VzqXu1rNT/EdLPrEZjfpp1c63zV/qmCGYqQpKrl9ShMfKGa+YZKJ+qSxJg+hS
	+0vzYNvXLivT2BJGuZ3p6bZ77eKlOjo82QMWrrNeYFK8xrKnaXAA==
X-Google-Smtp-Source: AGHT+IEU8ucSRGCQ8yeUqxnefauviz30XW/vEeL1QR+arXa90yShFB11CkPH88aAq7dWyp5UdmSeSA==
X-Received: by 2002:a17:907:9723:b0:b3d:395:3234 with SMTP id a640c23a62f3a-b6dba597c68mr519478066b.48.1761670756116;
        Tue, 28 Oct 2025 09:59:16 -0700 (PDT)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d853c549fsm1159835666b.37.2025.10.28.09.59.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Oct 2025 09:59:15 -0700 (PDT)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-63c21467e5bso3693578a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 09:59:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXW2jgW5nlIoNXXF72lm/74ieyAaFos6Dxb/5m2t/V8pK6r7EoceejYoPmcNiRQc4bR1DsfuCMnfFDjxQQ=@vger.kernel.org
X-Received: by 2002:a05:6402:5244:b0:637:8faa:9df7 with SMTP id
 4fb4d7f45d1cf-63ed8cc16aamr3779861a12.29.1761670755473; Tue, 28 Oct 2025
 09:59:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ea7552f1-842c-4bb8-b19e-0410bf18c305@intel.com>
 <20251028053330.2391078-1-kuniyu@google.com> <20251028095407.2bb53f85@pumpkin>
 <CAAVpQUARk-XeMdTeGy_s65sdwuLY2RzocGyJ=2_WkhsrFN-bUw@mail.gmail.com>
In-Reply-To: <CAAVpQUARk-XeMdTeGy_s65sdwuLY2RzocGyJ=2_WkhsrFN-bUw@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 28 Oct 2025 09:58:59 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiTN=1Sm5DVnXDtQ-tSiPuz-7QVpgP2vt6LgaEnhbubfw@mail.gmail.com>
X-Gm-Features: AWmQ_blBlp8rG7EHRLe1uP1FYCp4LO5ZZWflvlu1_iOk9v8s-pHpb1shOoMSUXA
Message-ID: <CAHk-=wiTN=1Sm5DVnXDtQ-tSiPuz-7QVpgP2vt6LgaEnhbubfw@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] epoll: Use __user_write_access_begin() and
 unsafe_put_user() in epoll_put_uevent().
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: David Laight <david.laight.linux@gmail.com>, dave.hansen@intel.com, alex@ghiti.fr, 
	aou@eecs.berkeley.edu, axboe@kernel.dk, bp@alien8.de, brauner@kernel.org, 
	catalin.marinas@arm.com, christophe.leroy@csgroup.eu, 
	dave.hansen@linux.intel.com, edumazet@google.com, hpa@zytor.com, 
	kuni1840@gmail.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com, mingo@redhat.com, 
	mpe@ellerman.id.au, npiggin@gmail.com, palmer@dabbelt.com, pjw@kernel.org, 
	tglx@linutronix.de, will@kernel.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 28 Oct 2025 at 09:42, Kuniyuki Iwashima <kuniyu@google.com> wrote:
>
> This is the Zen 2 platform, so probably the stac/clac cost will be
> more expensive than you expect on Zen 5.

Yeah, clac/stac are horrenously expensive on Zen 2. I think they are
microcoded - and not the fast kind - so effectively serializing.

They got enormously faster and pipelined in later Zen microarchitectures.

Sadly, Agner Fog doesn't do timings on those instructions, and I
haven't found any other place that has some overview of the
performance on different microarchitectures.

                Linus

