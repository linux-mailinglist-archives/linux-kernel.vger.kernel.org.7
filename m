Return-Path: <linux-kernel+bounces-787190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8C26B372C1
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 20:59:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A5353A8CCA
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 18:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B9893728BF;
	Tue, 26 Aug 2025 18:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="KTzuNv4i"
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC5B03728A9
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 18:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756234726; cv=none; b=CTdETuarr9Q+a11aHJBKXN2rA9P8sBcQBfV2mT6dLYT8MIEGKjpbpiK4oB0F97w8uGVWVPG2bUDBz1Ex33Fdfu4hWgf325cg/GHNVsgnfksHvkmpM8zVbdJYr1Raj/JwdX4rYI6LslQ5v4FP2rUHlvXoOGMiM6gWhx69EZnZPmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756234726; c=relaxed/simple;
	bh=pJME+1KmU2SzOA/lb1+BnOW4h/J3iSbhKPhNpdWiID4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m6eaoLW1a92Lom5rPT1E1tygxWTaZsBqi3wQWq/aHKtXkal+5DwzUY/TA2GSiNQRFJjUvb9lzi2f927H8tY7nEZR+aKqjnYnvpJOebgqIsnWoFE67Auj8Kfftleqs8+FmIKtKWVU3+bO9vIk+qRS6aYhWaHm7DCkCp+X8OBH5UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=KTzuNv4i; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4b109c4af9eso49037601cf.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 11:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1756234724; x=1756839524; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pJME+1KmU2SzOA/lb1+BnOW4h/J3iSbhKPhNpdWiID4=;
        b=KTzuNv4iIOvR2/Okp9GCEoXbHGLVDtZof0ZdrJ/5BDGDLHFFf/wu3vhNswj272YLKo
         ZgDjFd9x77OjznESGRGkCaF1E5T0gbU7AYJDQts96nUx4EpEunvTfX4CTmqTwsZ5FG2R
         PAcVuVKYiC63dcYpgSHHCsk9xuP+tZLHYvjYzbdYSv3jSWBo3FFvJv3Fw+J884zm0kex
         dj9F6Rv2StZHhTxdjS44N4/vu5mfGHNCtrw8cwNLS0EP0EsgiQu12aFL61m3l3aVBf8T
         0yLnFV3TcO+5RqMsi+WyW/NWG34gq5nUZpjmeV1sp7uBdv0AoeQ7T4WAQz1GlFJZ+Hdx
         yzTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756234724; x=1756839524;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pJME+1KmU2SzOA/lb1+BnOW4h/J3iSbhKPhNpdWiID4=;
        b=pzl7g7DiTOHp2oJ63RPuhDD3Jqkets03vSVFVfH9jRIyImPU7R2undPear+8OQatHT
         s0YsS206IZjd8GHYchZQNLX6s68fruSdC9tHiGxgGRQLb0nmDVzku5Ca0PvAQf/cjSYv
         9pXr26/SKBRxOyLflH+tO4u9v53SUCycy/I5ze4u0YuiEsCmGOeMXDUY12D3tHK0Lwmp
         Nz2AyP+5wPFN5cTyq5RQ8Jru3XH3LckMS4VW4dLu2p2+DP0lmdLbNnQ5MYrQ8X+WIgdZ
         wFrMOUDh0b8mV3J9x19MiIi3yxyu/hpW5z3/EcnVAv5DvPd6QuqM2xfhVUvR8Hx1+4R9
         htzQ==
X-Forwarded-Encrypted: i=1; AJvYcCXoxgGqdaQWYJmtbDlCcinAXtWxFBHyWvYl13uGq+5TPZI0WPiv1t+lWMwAzV38kKo80m3PH5uqUS8M8bY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTFPOPh1UqMNgNT80669hoslBrjT3CtoPTN5gRvllgSYOFmVtz
	917JhdTVmRlrG20wjhu+Brw/lr62uFbmgEoMkGY5RLK0M1V16vZKHbKz0G7R5EJIDydXbDnxtD1
	rNvnaTj0GjXl/xmOUb2oi0Wpj0roBz5F3aeAsY5+tsg==
X-Gm-Gg: ASbGnctoRV1LnxPlQ1PnU70Sn0g1Z+JOwqChQJrM3/CqZEtNaVAUbqBVX3mTxAMQl2F
	TtfAqiurhVamo01qaCNeQ1noJMbwffeHDONUJlJRSl5VzsBGWckOTPRUuLJRZjpj5zfDABkEUgn
	OEOU1TGwuEG9iu3CKr9wCgZfyjM2kSDcDTllzOsh0f2/yKUKgSZ0OcD379Amk/favJ0DZ5Vk3Wc
	AQn
X-Google-Smtp-Source: AGHT+IH7x6PzB/jpkOPVprK93HcHA2jlE9LSPDmfVuRTuFZ8graOQso5EGuliHqnNQqcqLY5o7Pky9G7peBJC7yYL1M=
X-Received: by 2002:a05:622a:286:b0:4b2:d5bf:20a1 with SMTP id
 d75a77b69052e-4b2d5bf2602mr93874511cf.23.1756234723572; Tue, 26 Aug 2025
 11:58:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250807014442.3829950-1-pasha.tatashin@soleen.com>
 <20250807014442.3829950-20-pasha.tatashin@soleen.com> <20250826160307.GC2130239@nvidia.com>
In-Reply-To: <20250826160307.GC2130239@nvidia.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Tue, 26 Aug 2025 18:58:05 +0000
X-Gm-Features: Ac12FXzbC4_094zxu3z9fUDRO3yQVd4QdY6g8DyMrUl3RDt_kmv57pEA7HFGGV8
Message-ID: <CA+CK2bCR84H90dZP40yFw086JP+YwH4=V0ncFfNoR8Mo5+azkA@mail.gmail.com>
Subject: Re: [PATCH v3 19/30] liveupdate: luo_sysfs: add sysfs state monitoring
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: pratyush@kernel.org, jasonmiu@google.com, graf@amazon.com, 
	changyuanl@google.com, rppt@kernel.org, dmatlack@google.com, 
	rientjes@google.com, corbet@lwn.net, rdunlap@infradead.org, 
	ilpo.jarvinen@linux.intel.com, kanie@linux.alibaba.com, ojeda@kernel.org, 
	aliceryhl@google.com, masahiroy@kernel.org, akpm@linux-foundation.org, 
	tj@kernel.org, yoann.congal@smile.fr, mmaurer@google.com, 
	roman.gushchin@linux.dev, chenridong@huawei.com, axboe@kernel.dk, 
	mark.rutland@arm.com, jannh@google.com, vincent.guittot@linaro.org, 
	hannes@cmpxchg.org, dan.j.williams@intel.com, david@redhat.com, 
	joel.granados@kernel.org, rostedt@goodmis.org, anna.schumaker@oracle.com, 
	song@kernel.org, zhangguopeng@kylinos.cn, linux@weissschuh.net, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, 
	gregkh@linuxfoundation.org, tglx@linutronix.de, mingo@redhat.com, 
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	rafael@kernel.org, dakr@kernel.org, bartosz.golaszewski@linaro.org, 
	cw00.choi@samsung.com, myungjoo.ham@samsung.com, yesanishhere@gmail.com, 
	Jonathan.Cameron@huawei.com, quic_zijuhu@quicinc.com, 
	aleksander.lobakin@intel.com, ira.weiny@intel.com, 
	andriy.shevchenko@linux.intel.com, leon@kernel.org, lukas@wunner.de, 
	bhelgaas@google.com, wagi@kernel.org, djeffery@redhat.com, 
	stuart.w.hayes@gmail.com, ptyadav@amazon.de, lennart@poettering.net, 
	brauner@kernel.org, linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	saeedm@nvidia.com, ajayachandra@nvidia.com, parav@nvidia.com, 
	leonro@nvidia.com, witu@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 26, 2025 at 4:03=E2=80=AFPM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:
>
> On Thu, Aug 07, 2025 at 01:44:25AM +0000, Pasha Tatashin wrote:
> > Introduce a sysfs interface for the Live Update Orchestrator
> > under /sys/kernel/liveupdate/. This interface provides a way for
> > userspace tools and scripts to monitor the current state of the LUO
> > state machine.
>
> Now that you have a cdev these files may be more logically placed
> under the cdev's sysfs and not under kernel? This can be done easially
> using the attribute mechanisms in the struct device.
>
> Again sort of back to my earlier point that everything should be
> logically linked to the cdev as though there could be many cdevs, even
> though there are not. It just keeps the code design more properly
> layered and understanble rather than doing something unique..

I am going to drop this patch entirely, and only rely on "luoctl
state" (see https://tinyurl.com/luoddesign) to query the state from
"/dev/liveupdate"

Pasha

