Return-Path: <linux-kernel+bounces-896166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23E4CC4FC7F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 22:03:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D09453B6EA8
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 21:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D054335CBD5;
	Tue, 11 Nov 2025 21:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="awfdXOPJ"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B0635CBBD
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 21:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762894828; cv=none; b=qF9FP2cWMy0cMEXjhsl/Jt4sqHJK5H15uAbhFROYUOQgrbNFKc/5GPbs+dlZc2kZDvsCV/ogQuHrqzxGVJJcePFAQi8F57t1Mo8vQIN1/rJfHFaXfEHHwPQuEyTgg+27zzBr4VWObyJwv7sd5sfgeHXaXXZGZIeRINVA1kCU/Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762894828; c=relaxed/simple;
	bh=Fp+8AG6pBI0jJ/x1v+sgWdRn9Lp3GBtp4uOEuA09BJA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rC9l7+hIriu4M3u/XswL8Mk4kc0bs1VDZl60PnQFpZYPaCao5Yna6yrSwwSUjw630bGY45NqiDjxCxSVM6X02yBR4Su85ajMFTgIO7kFA70lZSVk3EZ9P12ttRrjEMGK5lf76MwwDTCXyzc/2Gpa0A6HIQ7aGSs6dsEkWHf0xeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=awfdXOPJ; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-641677916b5so183192a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 13:00:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1762894825; x=1763499625; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Fp+8AG6pBI0jJ/x1v+sgWdRn9Lp3GBtp4uOEuA09BJA=;
        b=awfdXOPJLudXiU59sgZ/KAWFiTttCUDew6wPsWzJGbRX6aI0opyW6TbrEpeX0mDJaw
         kkxnZQzUoGuDtUafQowngoRnJrdoKOA0YBGoh0eJIwQ/RO4X5UUE9Df52tXka0swmX++
         9568gdp8kD6chvjgXunC4os2/bvF5/+CEZ473tvnDj+tmfglnytzw6EdOwodHQjOvUrM
         DhzqY6PScZRCVw4L4lDBTfzQZyuTnVOpOgC9Qm4Pii8HstZnVxSKBr30UP9X/DkUZoP7
         252iZD6C+OlZCWDzcI3uEMrS4f2sRa1bir0CLZJ1wGpJ/fEJc8jsuzCZ8BFgVklN3U4K
         4vQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762894825; x=1763499625;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fp+8AG6pBI0jJ/x1v+sgWdRn9Lp3GBtp4uOEuA09BJA=;
        b=wNPWd+0Rsd4RLiocuhn8PLnMQzPrxuoDVP+MEHNgq/EGvDb++hzk5fPzGiVnHMAPpE
         AJ7xBaP4O94bNpLmkFlATyoTOBjOqTGbCyCRZ0HNH/N/TsFUWiz5sk4Fvs/bG4oe4gfK
         2iF1j7AQz7T0lTOIr9xFumY+7Et6aVNz9Hn7EN0D0YvA8x68LOXljHAkelQnj4GZgCx1
         pz3s3wGxF2Y5hgNUHUFw3Ib+kMQiRcouyRFd4dXWRCrmLRlRqEQesowb5YByL/YqnQOP
         2npDftDOpsvX6CLMIew6VK9i4ELA25sAvsL/0CrIw27r8UmVAY+slTy1bfBxuP4lfCcO
         JSCg==
X-Forwarded-Encrypted: i=1; AJvYcCV89Tdmt6gxSSjNuzu6qRWtP71PxZGxmGPF64vaeqpxzDDfIMFMk5LTCvIfp9RXS2d7SSlz/oDij36MhJA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeAuoot2t/VQlSKyHpVzmiivzALOV0cpvFJHzkVXz3a0fx7sve
	klVWxhg2ZXyNxNnjOzBYW7Cf1xc6IWwhxaSdE6XB33Vit9vAIoP47a6xuQpOdSW/IttiTz53PA4
	8dGphCmRSbZdHkuM4LX/0V2AwreZekz+tHbj5d9JEAw==
X-Gm-Gg: ASbGncvWM+A3lxwT3I+k0Pr4vd4XcMSNVmZfRgyq/mBAmbIy5Zny128n2wJSP5gRCe/
	pdag7iboCBzNH3vNBhpfuIHUhzsOpQwmyIKiE1ckT3fDBMaMw8Zq95Wjqia7yMUCMfqW9vaKaFO
	081VUXaLMTRkSfGCpKjk2cZQ6Q0JY/rn0sOfOe+VsvCbiLqBA27WY18TEBjRGwZOBTAnLlgPYLQ
	tj8QW3xmZ0camAd01H9MguhT8PDBA4Df6VPXpzl3dZN8tG2AGYrKmR0pXbq/RTvyam6
X-Google-Smtp-Source: AGHT+IH+e0YsGvHk4dFv4/hkj2NgB2ttZSxI+gZm+9yj2ImFkWPrLek2DaIdjfDu/vAiHUMqP9wuFNVI+e9wnD3MABk=
X-Received: by 2002:a05:6402:51c7:b0:640:ceef:7e4d with SMTP id
 4fb4d7f45d1cf-6431a55d74emr573319a12.32.1762894824747; Tue, 11 Nov 2025
 13:00:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251107210526.257742-1-pasha.tatashin@soleen.com>
 <20251107210526.257742-6-pasha.tatashin@soleen.com> <aRHe3syRvOrCYC9u@kernel.org>
 <CA+CK2bA=cQkibx4dSxJQTVxVxqkAsZPfFoPJip6rx8DqX62aEA@mail.gmail.com> <aROaJUjyyZqJ19Wo@kernel.org>
In-Reply-To: <aROaJUjyyZqJ19Wo@kernel.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Tue, 11 Nov 2025 15:59:47 -0500
X-Gm-Features: AWmQ_bnYdSMroRMjjVnLSAE6-uLxVnY6rxuibiqAyIlNle_pZdH3zG6_TS_O-10
Message-ID: <CA+CK2bAwfChKVNtHxVi3NWbE=LCLFacB_tD=ZamM-2UTNHOnzg@mail.gmail.com>
Subject: Re: [PATCH v5 05/22] liveupdate: kho: when live update add KHO image
 during kexec load
To: Mike Rapoport <rppt@kernel.org>
Cc: pratyush@kernel.org, jasonmiu@google.com, graf@amazon.com, 
	dmatlack@google.com, rientjes@google.com, corbet@lwn.net, 
	rdunlap@infradead.org, ilpo.jarvinen@linux.intel.com, kanie@linux.alibaba.com, 
	ojeda@kernel.org, aliceryhl@google.com, masahiroy@kernel.org, 
	akpm@linux-foundation.org, tj@kernel.org, yoann.congal@smile.fr, 
	mmaurer@google.com, roman.gushchin@linux.dev, chenridong@huawei.com, 
	axboe@kernel.dk, mark.rutland@arm.com, jannh@google.com, 
	vincent.guittot@linaro.org, hannes@cmpxchg.org, dan.j.williams@intel.com, 
	david@redhat.com, joel.granados@kernel.org, rostedt@goodmis.org, 
	anna.schumaker@oracle.com, song@kernel.org, zhangguopeng@kylinos.cn, 
	linux@weissschuh.net, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-mm@kvack.org, gregkh@linuxfoundation.org, tglx@linutronix.de, 
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, 
	hpa@zytor.com, rafael@kernel.org, dakr@kernel.org, 
	bartosz.golaszewski@linaro.org, cw00.choi@samsung.com, 
	myungjoo.ham@samsung.com, yesanishhere@gmail.com, Jonathan.Cameron@huawei.com, 
	quic_zijuhu@quicinc.com, aleksander.lobakin@intel.com, ira.weiny@intel.com, 
	andriy.shevchenko@linux.intel.com, leon@kernel.org, lukas@wunner.de, 
	bhelgaas@google.com, wagi@kernel.org, djeffery@redhat.com, 
	stuart.w.hayes@gmail.com, ptyadav@amazon.de, lennart@poettering.net, 
	brauner@kernel.org, linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	saeedm@nvidia.com, ajayachandra@nvidia.com, jgg@nvidia.com, parav@nvidia.com, 
	leonro@nvidia.com, witu@nvidia.com, hughd@google.com, skhawaja@google.com, 
	chrisl@kernel.org
Content-Type: text/plain; charset="UTF-8"

> I believe that when my concerns about "[PATCH v5 02/22] liveupdate:
> luo_core: integrate with KHO" [1] are resolved this patch won't be needed.
>
> [1] https://lore.kernel.org/all/aROZi043lxtegqWE@kernel.org/

Thank you, I replied to your comments in that patch. However, until
KHO becomes statless this change is needed. We *must* have KHO image
as part of kexec load if liveupdate=1.

>
> > Pasha
>
> --
> Sincerely yours,
> Mike.

