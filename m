Return-Path: <linux-kernel+bounces-771711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 84B7BB28A95
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 06:50:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8770C1C26DEA
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 04:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 943F81DE894;
	Sat, 16 Aug 2025 04:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ac0A0pgm"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6435A79EA
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 04:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755319822; cv=none; b=VuR19OL5GxghQeiNAnrXFK82Xmw3DNRIGag5m/NKLS+M2e8y2xtAquZ/ksqu/wmwfbqQQZKbEF6RPrk8IIwjIFCgjCKK78bpM+2xcM4rLmnYhXisI30i2OgPXSrPH3WRzq2cfYK+cpHRtloT8WnAuQAjQyTgi4khL4IhQd5Rfd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755319822; c=relaxed/simple;
	bh=BNvSs17H30Pojr0mYh58UbN4qSdGEsmKv1b+WURr28o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CNzD9Mhyp2bnJejQKqGEHqg+DB1B8UsjX8hWdMcJ6GccZnO5p69I8eJSwlDzziJHhiYsOSZ7MgY5BVWgm1RnEtcW+qW/Q+yFVZoCKj16erLMaWyNAjnJUVTp81mzYYPxtJ8lZcIr3TspIoXig1nzDL/dqCXbMlMYspZ85LzvkM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ac0A0pgm; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3b9d41c1149so1890270f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 21:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755319817; x=1755924617; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BNvSs17H30Pojr0mYh58UbN4qSdGEsmKv1b+WURr28o=;
        b=ac0A0pgmYmpVddezLCCslg0nWfxdfR4uI8XmVffgzdSOC0eF63cM5uRrtd6X3hEh4X
         MQD7YgYDx0SuVZTr3+zOkc4CUNrF4Rph9yZkBA2Z9d/TWLipfzKPCWAcsnHaMmCYX/Gm
         IxQxATgHFK4xB1jYejWO7C6aDrD4tE54wVpcTW+bIz0GeAPUlX+66zf4pmnMulh4e9r5
         xj95atBOQcYCfi7FpEynQMR0SHoxUb0mTWWu9KbkUv88/5R9mdV3JTuJYwUIXaO5Nosl
         NY6ACKTRMDl9zCBajiufinf5DfAaGWpl6ax9ygEfYtKQjTeHfPz98wlksSS7Pa0e9hVH
         RiPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755319817; x=1755924617;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BNvSs17H30Pojr0mYh58UbN4qSdGEsmKv1b+WURr28o=;
        b=fzpGYkj3vYdcLZdgwEUsGx1oqsXUt4AIo6EbdtRXGTa3c3SHC4cBrqZ30xg6vro39B
         OvlOwri8fl4el0nXcV+k9WPw5OeD6zSK8uaI+zNBWjbI22JYu1trx3b07o/ktTYkT2T/
         4OuxLun2KRiHhKPPXDJ9NRU8/vc4TOeUCA1v2CPlD2c9LsRN9SiCULxyNQfcs+eZm/SM
         MADonsQkitlGdF6neGJvMqO00ufbvHAQWIk+riWVXipeGBxzYVQwOOIwtUm2f/+sAOoy
         yNVpE+R4k668pvLDakUm0UG2KOKB/YhoouCPHajznaga6IHIpnA9TLMmdz2zbV1nlBnD
         Ll+g==
X-Forwarded-Encrypted: i=1; AJvYcCUjgH/RuaQcbaABZNV7Aib1VQ8NiBQW0Xc+JHD9fqeL1CY31f8UBLU5IICS9e13TtH0ha70cbrlmR5ScW4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywd8POqs0m4eKwOMRNSQ0DIo4/VCqF//IrdaBUyTzKjZjg4IesE
	ulnOtDmUT1O5Cseu4gfKkK9EXCv4wBTAAAYjkn8573OeDnCDb3IvOJsZwgwTqyeoSSFTpNeI8Io
	X0pmGzOHUBCfTe+99MSsRKWvva+83JSw=
X-Gm-Gg: ASbGncv8qc9F0SKIaa6TA6WA6WN2/9SGAgByQO7B1rtwBX2AU1EtAZGkCAW8IB/tPvV
	nDVVXjibRwNOOODFchwYy6VRbp8BWxo2rJ1pgHTgvwTkbvhftPenqUMVYLAAZvMBS/VgGGothzR
	4VZy1WY/eaY2u5IUNUjk0sqPpNrdIdeX/CzqL1AUdsL0IqDNrQ1XK2HMcL/MdiG482a1Ak5Gtrq
	KJLmTqb
X-Google-Smtp-Source: AGHT+IFPvY8ec5Jn5OTlpsBfvFYtAsonj3tCEjtnK0os5EQlDMqmiyj8gQxFAf5K2RSyQc73thlVSiKnZ0ALE9aWQug=
X-Received: by 2002:a05:6000:200e:b0:3b7:735f:25c9 with SMTP id
 ffacd0b85a97d-3bb67100411mr3698495f8f.21.1755319817249; Fri, 15 Aug 2025
 21:50:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250812124941.69508-1-bhe@redhat.com> <CA+fCnZcAa62uXqnUwxFmDYh1xPqKBOQqOT55kU8iY_pgQg2+NA@mail.gmail.com>
 <CA+fCnZdKy-AQr+L3w=gfaw9EnFvKd0Gz4LtAZciYDP_SiWrL2A@mail.gmail.com>
 <aJxzehJYKez5Q1v2@MiWiFi-R3L-srv> <CA+fCnZfv9sbHuRVy8G9QdbKaaeO-Vguf7b2Atc5WXEs+uJx0YQ@mail.gmail.com>
 <aJ2kpEVB4Anyyo/K@MiWiFi-R3L-srv>
In-Reply-To: <aJ2kpEVB4Anyyo/K@MiWiFi-R3L-srv>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Sat, 16 Aug 2025 06:50:06 +0200
X-Gm-Features: Ac12FXxYLTsqomvoG9UG93Lotus4fuW2rcu_NxDqALVSquB40p2BNceICCGi8q4
Message-ID: <CA+fCnZcdSDEZvRSxEnogBMCFg1f-PK7PKx0KB_1SA0saY6-21g@mail.gmail.com>
Subject: Re: [PATCH v2 00/12] mm/kasan: make kasan=on|off work for all three modes
To: Baoquan He <bhe@redhat.com>
Cc: linux-mm@kvack.org, ryabinin.a.a@gmail.com, glider@google.com, 
	dvyukov@google.com, vincenzo.frascino@arm.com, akpm@linux-foundation.org, 
	kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org, 
	kexec@lists.infradead.org, sj@kernel.org, lorenzo.stoakes@oracle.com, 
	elver@google.com, snovitoll@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 14, 2025 at 10:56=E2=80=AFAM Baoquan He <bhe@redhat.com> wrote:
>
> Ah, I got what you mean. We probably are saying different things.
>
> In order to record memory content of a corrupted kernel, we need reserve
> a memory region during bootup of a normal kernel (usually called 1st
> kernel) via kernel parameter crashkernel=3DnMB in advance. Then load
> kernel into the crashkernel memory region, that means the region is not
> usable for 1st kernel. When 1st kernel collapsed, we stop the 1st kernel
> cpu/irq and warmly switch to the loaded kernel in the crashkernel memory
> region (usually called kdump kernel). In kdump kernel, it boots up and
> enable necessary features to read out the 1st kernel's memory content,
> we usually use user space tool like makeudmpfile to filter out unwanted
> memory content.
>
> So this patchset intends to disable KASAN to decrease the crashkernel
> meomry value because crashkernel is not usable for 1st kernel. As for
> shadow memory of 1st kernel, we need recognize it and filter it away
> in makedumpfile.

Ah, I see, thank you for the explanation!

So kdump kernel runs with the amount of RAM specified by crashkernel=3D.
And KASAN's shadow memory increases RAM usage, which means
crashkernel=3D needs to be set to a higher value for KASAN kernels. Is
my understanding of the problem correct?

