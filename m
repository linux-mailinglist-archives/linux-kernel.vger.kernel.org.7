Return-Path: <linux-kernel+bounces-862124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D9B0BF47A8
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 05:18:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EDB303507FF
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 03:18:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 320B2202F9C;
	Tue, 21 Oct 2025 03:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VveLCn15"
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF93B1F16B
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 03:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761016683; cv=none; b=nUe9am17EoisC2hspMsQU5a7gGHwasGwXV2ZUDZvJ+I+Z0/Lcx3P73DT85SZHZpuE6SoTIKFDTo3iiaHziF3PM7b/Zzaa2HharYPPDr6Bd358cSOHVKj7lDH/CLq8H2ERjowhY70WYJCb/m9NoEJ2UmGF5xKdSCjwfq8ZCS/GkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761016683; c=relaxed/simple;
	bh=sfQfeeJSIBOGYQeQglmRX/1uHnkqyry3lbhoV7QNqE0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h5jN2epeQRSIHvarj27ufleCo5ULPc22ABOCIF853Qm8xe91ZTmr98rYhNlsz6rUDdlNPS8RB+ej181qDj5glRtP0zsnMdhVIuMcFZgkSloYZdlOAl+UnSELZxwXUMDnusTevkPTdIOKdIQzhpItrBGtpiHmvQZErvvpicbuC4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VveLCn15; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-85a4ceb4c3dso709803885a.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 20:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761016681; x=1761621481; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IKp8K5lCZ3dpAyDEqf6jcNNDcXUsYhzNGDh14Qf0pAE=;
        b=VveLCn15TD+xby9ReQc5oxqgPGrqCJSWTi13Fk8KAI6qSXNKiSxLND6yuqgzPRxVkL
         fWsTG4x09G+7Kt5GzJHhMUcKan8i4q7TfV9eHIctFukRqV1Kn/DB2NUUfYOh3QZj7FXF
         1umfnz2QEdgxyDtaLdkMAoEcXvg1n4j9S4DdZ/4aEx3X0c7vBFoknsThK8o8hpEn/veS
         086Pe7fuXXh4zRAbhJV2FL2JOjug4IUH1HigCYpAwDox7D2kPicQfAWSLmRk2xOC2Z3x
         wUbvumnXwW5fH27m9Yipe4CK/kUdeYUAMsDX7yRfOerJPQTx7fxDwvsB1rajzQAv5Qu+
         JYmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761016681; x=1761621481;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IKp8K5lCZ3dpAyDEqf6jcNNDcXUsYhzNGDh14Qf0pAE=;
        b=c19QZfE1IxaTVurMu+lEfnCkvPwXkgRXnAhqCydX8XeMf/8oHuI4j/nm7UHgoUYx+U
         swBlIYTau3aHi4epSuW27MZpV2+9gIGz/7hpYbjRiXWRObpoQCc/zhevKMHGv9rr4VmA
         9ozC58Di42hKCVGrUbzSRTLrXNmPzKojf5x4stkJWET6kodpeKimf3cwVxrwCKiGEUux
         BK98F3hSDKqOsfBXTmnJul5TlWeBCz89nG9CHtGS/+X4xBYWAfm+MTHxLcny5d8GjAUL
         OTQ1Xa4y7HP90J2qJ/fi0HmEpjWwGsyE4Ik0N5c57KgHvEUPORJzC8hCu8exQSLKX7JY
         nPiw==
X-Forwarded-Encrypted: i=1; AJvYcCUcvRwIQy2BDXgocLdYIf0lrAGy1CTcnohFIC8NqhH9onXg2Y0hOMES8HtWjLECii7NILF5HDxR7rjQH9Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKuSyrmaeDo3l34EeydA6zdOXU8Nrtp8ONPatlDdsan4wy8BNr
	SEdsbOy22Fsrmib6l4LzckPRabdLwBGih4YI5Y1x/cQNDS6mYFUgaysw0YH9te7WooyCrL3N17U
	nSOp5UNUaHEF8DpoQYXzmwqmbteBK4XfifZcLNdM=
X-Gm-Gg: ASbGncuzjfeVFIrwnz9lawOvucFtOjvUDLMhzj3batqBKPLXxMOI7nfM34eUVOK0V8M
	VdiN5926mzpgkf6fvJuTxmNl3fGImFquOpoKV1dZN+Z0Mrr3AreUqQApHyc2FtlUszX3FkPsJAk
	G674P3EBFuIxrxrfcX+hyXItZDOi3Xsm0eG2Ne+6EwszYwD6yvun11k7fmFPa5ras+L6tl28LCj
	/REqtH6VlS2Uwj+Q/SZmjKtHboymTfNex75cjd8/aqsXoAEEHE7ZYMt5oey2YAsvpEVX8tv7JUy
	N7gbUJKbbzXH5AUQC2nUTCQSzAUbsw+vlW0N1g==
X-Google-Smtp-Source: AGHT+IEISLt1R8Tq3GUFGAlLRQg2JU0sPn1UxM/cYxwrh/JtX54j7bP+h6dE4yyysVO1BfHw279yngY5UxCTBJDhC+g=
X-Received: by 2002:a05:620a:2950:b0:80d:4088:82dd with SMTP id
 af79cd13be357-8906b7aaec6mr1842418985a.0.1761016680601; Mon, 20 Oct 2025
 20:18:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251017160251.96717-1-dev.jain@arm.com>
In-Reply-To: <20251017160251.96717-1-dev.jain@arm.com>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 21 Oct 2025 16:17:48 +1300
X-Gm-Features: AS18NWDI6AbZQPBjErDyOP8dFS6M9xx3Z6lnBR5rWfIWS85iIEUyVJpIZk0sZ5U
Message-ID: <CAGsJ_4xwS9Q_5e8-F6PmyHm_1OyuHuTKnnzH_WPNiOmVzkkmdw@mail.gmail.com>
Subject: Re: [RESEND] [PATCH v2] arm64/mm: Elide TLB flush in certain pte
 protection transitions
To: Dev Jain <dev.jain@arm.com>
Cc: catalin.marinas@arm.com, will@kernel.org, anshuman.khandual@arm.com, 
	wangkefeng.wang@huawei.com, ryan.roberts@arm.com, pjaroszynski@nvidia.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 19, 2025 at 12:36=E2=80=AFPM Dev Jain <dev.jain@arm.com> wrote:
>
> Currently arm64 does an unconditional TLB flush in mprotect(). This is no=
t
> required for some cases, for example, when changing from PROT_NONE to
> PROT_READ | PROT_WRITE (a real usecase - glibc malloc does this to emulat=
e
> growing into the non-main heaps), and unsetting uffd-wp in a range.

I recall seeing this pattern frequently in multi-threaded programs. The sta=
cks
for the threads can be observed by running strace on a multi-threaded app:

mmap(NULL, 20480, PROT_NONE,
MAP_PRIVATE|MAP_ANONYMOUS|MAP_STACK, -1, 0) =3D 0x7fbfcd14c000
mprotect(0x7fbfcd14d000, 16384, PROT_READ|PROT_WRITE) =3D 0

The stack guard page in the mmap region remains non-READ/WRITE, while the
rest of the area is set to RW after initially being PROT_NONE.

>
> Therefore, implement pte_needs_flush() for arm64, which is already
> implemented by some other arches as well.
>
> Running a userspace program changing permissions back and forth between
> PROT_NONE and PROT_READ | PROT_WRITE, and measuring the average time take=
n
> for the none->rw transition, I get a reduction from 3.2 microseconds to
> 2.85 microseconds, giving a 12.3% improvement.
>
> Reviewed-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> Signed-off-by: Dev Jain <dev.jain@arm.com>

The patch seems to make a lot of sense to me, but I=E2=80=99m not an ARM ar=
chitecture
expert and cannot judge whether __pte_flags_need_flush() is correct. I=E2=
=80=99ll leave
that to Will and Catalin.

> ---
> mm-selftests pass. Based on 6.18-rc1.
>
> v1->v2:
>  - Drop PTE_PRESENT_INVALID and PTE_AF checks, use ptdesc_t instead of
>    pteval_t, return !!diff (Ryan)
>
>  arch/arm64/include/asm/tlbflush.h | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
>
> diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/t=
lbflush.h
> index 18a5dc0c9a54..40df783ba09a 100644
> --- a/arch/arm64/include/asm/tlbflush.h
> +++ b/arch/arm64/include/asm/tlbflush.h
> @@ -524,6 +524,33 @@ static inline void arch_tlbbatch_add_pending(struct =
arch_tlbflush_unmap_batch *b
>  {
>         __flush_tlb_range_nosync(mm, start, end, PAGE_SIZE, true, 3);
>  }
> +
> +static inline bool __pte_flags_need_flush(ptdesc_t oldval, ptdesc_t newv=
al)
> +{
> +       ptdesc_t diff =3D oldval ^ newval;
> +
> +       /* invalid to valid transition requires no flush */
> +       if (!(oldval & PTE_VALID))
> +               return false;
> +
> +       /* Transition in the SW bits requires no flush */
> +       diff &=3D ~PTE_SWBITS_MASK;
> +
> +       return !!diff;
> +}

Thanks
Barry

