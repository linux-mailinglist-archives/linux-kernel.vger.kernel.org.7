Return-Path: <linux-kernel+bounces-873929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AA2CCC15170
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 15:13:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A6A1150373A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 14:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A39F43431F2;
	Tue, 28 Oct 2025 14:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LkD9PecY"
Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB183396E0
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 14:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761660301; cv=none; b=u1SZi3919+wgsPoNwgpNj3pV7+ivXnhtuKjSitS+CehMQr73Eak1AMuqlRXRI2JonnFEIUNCcA8eL8BavoYrKYRUk9AqdNFYZlIRs5jWeqPckruzfYmNOFrVinyiytjb3AyG9N0eFzAlPRwiMZWKJXLO4Flza+bltHM9HAsGss0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761660301; c=relaxed/simple;
	bh=XJNXAFxZiK88cHz3NFRWbJYZtmI5vkRXCxubdq9iJNw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aYRlKd9jJwmrChb3GPcv+cWd6Wua/ZUuvZbZrULtrjlydN5KEpLljBk2MjxdNy53/4KfUxTglFxZZ9Yb0n08ZMQGl7cGxXmXdGnjsB8xVXHbcxWEx4D04DPs8mC/zzcEzVc2tUqON7LxOXVDwguJQBAapzA0NfFlaMbNq3otQpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LkD9PecY; arc=none smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-63e3a7a67a4so6485508d50.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 07:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761660298; x=1762265098; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tV6lq40DHC8JcmNfWL6yF+Abxx6Ldftej9yA3XYbJaI=;
        b=LkD9PecYZJCjpN81Xp8B9YuIdXawRmUkLPFYl5OV4oN411bhpSHRDj0WgIRDVgMA+2
         rt8yeyDnCpeG1F6Qu4K+Ns0oYJuNmuEPjnA0NJR/eAvgiccf9rDmkXG+Cbkt8i3+FQiW
         Hb30KZacsgjYXqrX1++nRbU3aofjx4BHnkH0j+ZBZBobTJs3s+K9BZjYsq4du/CF5rDs
         JfLL3A7auKDgK3fsnJplkRf3hQu0C7JUt6cCrTDaMrjmsM/oVPK9kgxXM1Df+t4pt4Vp
         xf+rGMhZZuDHRtSse0fQUp4svRhLOC47JpJv0OMcMRLS7bte+auvFiZ8c3SXHvP6BZl3
         D+OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761660298; x=1762265098;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tV6lq40DHC8JcmNfWL6yF+Abxx6Ldftej9yA3XYbJaI=;
        b=MzI4TUXHJJI4TU0R7kauOsuDAVR1yRHqVWlHHBeHaMRA3nrmj399seiI034/ZkejxN
         jv09b4w6AkeE3CaQIsfESrCdIN/R01L03Y2/zYBwlv+XSvWQbjx3+JRD5hKAyHSZiKGp
         6VvzeB3XT+LChNhXC7Fscyu2JMCGMIXPziSuFGO92gibV3mflTHOqxCp/9rr1JpEVZji
         vFgbM6PyiQPodhGmfjxGxWguHQ0VQsM7yxbIbMWu7uFGBF6NlcF/sv8+JmZu0aWiE0BJ
         hJjeMtZPu057jzVDSN/15zlehjBI08v1sDPpv60cDKkSmNMdy2HVIG9r5hfCmJf20eps
         K58g==
X-Gm-Message-State: AOJu0YwjWhBlOsQkEzrTvORLzB7eK17woyC5J8oENy+Ie6mUqkwrjWvt
	JpiLhDPqPAcMFoYKrZ8pxzZ7GFw5UjNbKkJ6ESh5JIOeHy7bIxOVNQc+iqjhBTWbbu67wbEmlYB
	pZJPxSa7dkV+ajeOg/8Zi2/J76ePN774=
X-Gm-Gg: ASbGncsesoRJ8IVeGxNg36oyn/vqrLWWBGMhYZYpgNRbvuCMomfLiYSeDNHRfcd45jN
	LsDY+JC95OmJhPSP9/mnrTlBW5WHD4NxbXfadYnXUYRbgU2mZUEP06CXdnO7pdf4TpMgYROMT/Z
	m4emFwUf6hV8RMH8A360LZQBwMDdbA1anFyMlKH/lQxFs6ubdq7el9WnAwfsspjOHMmIFv1More
	Km4gGt/O2zumEXVe4/9dYU2NCW2+auO2ZG/FV/4v/4a5btOKpBTDtnxiFpBz0c9U37FcYIvUJie
	KgD81HbvrS0tnyle2g==
X-Google-Smtp-Source: AGHT+IGO59IsEPrMaZUmuz6Z8HqEjQzA2Ntsc7bvDVyVXUheTpOGkWA4zrFX+wmhIbJUO+iBKxLOdRdY9YaXu1dEED0=
X-Received: by 2002:a05:690e:d83:b0:63c:e90c:a6d8 with SMTP id
 956f58d0204a3-63f6ba849bamr2974242d50.44.1761660298140; Tue, 28 Oct 2025
 07:04:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027083700.573016505@linutronix.de> <20251027083745.231716098@linutronix.de>
In-Reply-To: <20251027083745.231716098@linutronix.de>
From: Yann Ylavic <ylavic.dev@gmail.com>
Date: Tue, 28 Oct 2025 15:04:46 +0100
X-Gm-Features: AWmQ_bnQq8Ze7k4D-80utHvwT6MTXau8I1_bRZ4nLy6wJZW1-jMkY-uZGE3OIrk
Message-ID: <CAKQ1sVO9YmWqo2uzk7NbssgWuwnQ-o4Yf2+bCP8UmHAU3u8KmQ@mail.gmail.com>
Subject: Re: [patch V5 02/12] uaccess: Provide ASM GOTO safe wrappers for unsafe_*_user()
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, kernel test robot <lkp@intel.com>, 
	Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, 
	x86@kernel.org, Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	linuxppc-dev@lists.ozlabs.org, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org, 
	Heiko Carstens <hca@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Cooper <andrew.cooper3@citrix.com>, 
	David Laight <david.laight.linux@gmail.com>, Julia Lawall <Julia.Lawall@inria.fr>, 
	Nicolas Palix <nicolas.palix@imag.fr>, Peter Zijlstra <peterz@infradead.org>, 
	Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>, 
	=?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 28, 2025 at 10:32=E2=80=AFAM Thomas Gleixner <tglx@linutronix.d=
e> wrote:
> +
> +#define __put_kernel_nofault(dst, src, type, label)            \
> +do {                                                           \
> +       __label__ local_label;                                  \
> +       arch_get_kernel_nofault(dst, src, type, local_label);   \

Probably arch_put_kernel_nofault() instead?

> +       if (0) {                                                \
> +       local_label:                                            \
> +               goto label;                                     \
> +       }                                                       \
> +} while (0)


Regards;
Yann.

