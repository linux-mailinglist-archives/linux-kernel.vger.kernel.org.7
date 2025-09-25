Return-Path: <linux-kernel+bounces-831906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7469AB9DD97
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 09:26:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB0B04A5027
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 07:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5C822DE6FF;
	Thu, 25 Sep 2025 07:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="IwdK6NeL"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7212E8E04
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 07:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758785200; cv=none; b=Zrq+XL/cGg1WA3L4h3Sz4PdW1A0YQ1F73vfPKGJLiBSdJQUQcP0aPEb9IQXY+lacjmEBnsm5y+W/hje2kpOIlgKJ7WpKvSUtFt6YT3SGDEirXVJpXgZ/8ovluF5uCXF3uQtUvuqOL+4vkBOVA+c2H0UqfvJyUrwdx8IVpqA10hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758785200; c=relaxed/simple;
	bh=IZNehkJyXObPO8qrTZgEq7p0XEf8K/P7GfRMVj97KFE=;
	h=Mime-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hzPA4v6MMBDWSe/xpBPL2h19/fLRSathV75PkPgGTGlZmKcZui9jtt4yWFq+gOxsglRU0v/5c9ibTM484UViQz3rNJ8m4kY6lmSlcTYpe0EQN+4sxgPpExsssBm0DQX+NGlNncVQFBhuVUoj3U99jvSXwHEv2x6u4EJqrRswF5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=IwdK6NeL; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-62fc89cd68bso1250158a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 00:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1758785197; x=1759389997; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IZNehkJyXObPO8qrTZgEq7p0XEf8K/P7GfRMVj97KFE=;
        b=IwdK6NeLoU87AO+lnLT53fnbvHEX8uSf8fAtANXWxwMSD00XIE8br9sLHCqFvLo3vQ
         SquijhXy3ee5tLU11p5J8j0mAp/DmialGVhcd704UiCujq3LmV6pv6ClZudfA6lERjXG
         Vps2Voinq7ELtM8UNde1V2CEzEsQIJQOdCOTXePMKGjsVH/ORJLSfvDDQcJ2Wjm10vFz
         zcRtg4RwH+EDsZu581qifEi5ZzSgwvuNhImd89+BEbZxwSx1knPLBcGKYAeDdCi/arlc
         HvVltNF2PYWySJuYYjK73ZF3Gks4cHhfIfGZAcSes236qNfhBJkSYYyhmXLqBEec2APZ
         GqJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758785197; x=1759389997;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IZNehkJyXObPO8qrTZgEq7p0XEf8K/P7GfRMVj97KFE=;
        b=brmmbf4BEtH9e8AtImm/LNvtiywOzkl/LMtRZJOQAw64mNAp6HNfD2ajFcMWcJTFFX
         ZL08pe57lU5ZSxdT2ZNaymbo857oj51u4gP3ZeMOwCJ3NXKFMkhmUzNI/g/vzqEtBY1m
         Bsw51S1oW8emX4+puWvwrg94PlzCTxl8qX0Q4yKgjfRe90R+ILNaNJZKPSImpHxC9+SJ
         D8V7k/NwmfEIY2PynihvFJImmEz5MLMG7q8CRiyK1r0wDJKDIGYynMax0BPBX13q8nsE
         t4vwPGZ/Si3yUD7LFfuToj5DBiewtSTpI+aqDt1ZwtPE31KRMziAUKWmVvCFF4m3h6mJ
         +9FQ==
X-Forwarded-Encrypted: i=1; AJvYcCVXe2buvvVAVqYNMS2wkcSWOP3fiEIhr1pki3/lDplNRbLfX4C7wipS+6hjmuy7220FmG0TT1Vrp/3fh5w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yza6yRTIkZfGHTSlKAbve5VxD0U1aGD3mQTPD6SFeeuFFDziC/6
	x8PuK5ROdlL3++R1lsKYj+RhUJFVyqMlQW43ZbwYXR9i9shWdmCPHRXZx3hhU2DZLGdMhrJo6Oz
	WhFRaDEe+/mONKUyIqOvdmO0vI77sqh+al2Vsab8npA==
X-Gm-Gg: ASbGncuhNVJrmEro6j+2UKKuJYgedt72fzlkXUICt5XZXd6qNSOgdBlfmQ2K8SbTKZF
	3kfrACjPDRoCiFiBTRgQ7pHad/EiUrrp+8Oq5dnLwxLfGJynapw9JXaPhi62h0u/lDyVAL0tF0E
	7jvyJWzM4zmxJ7n5iqg5dP9hvb9C15LLp2+VSxNsVls9CCCbsc/+ZFuCAp8cKxYhqnz0Yj0HoTi
	eJiHypBbXc+ttg=
X-Google-Smtp-Source: AGHT+IFoMSBXt4dDM2m7skZhYltT4ezcqzojlUVcokaY1XjlusJW2CedcRxZC1Hj7bu6NzSzFDDNWZXCUGhtawMVbwc=
X-Received: by 2002:a05:6402:42ce:b0:62e:e5b3:6388 with SMTP id
 4fb4d7f45d1cf-6349fa81093mr2108322a12.19.1758785196810; Thu, 25 Sep 2025
 00:26:36 -0700 (PDT)
Received: from 44278815321 named unknown by gmailapi.google.com with HTTPREST;
 Thu, 25 Sep 2025 02:26:36 -0500
Received: from 44278815321 named unknown by gmailapi.google.com with HTTPREST;
 Thu, 25 Sep 2025 02:26:36 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250923153146.365015-1-fam.zheng@bytedance.com>
 <40419dea-666e-4a8d-97a7-fa571d7122f4@intel.com> <AEC34AE1-AEB5-4678-AC9D-39155E97D86C@zytor.com>
 <CABgc4wTjc9nxmB16LkxiOL5gYO9K8kr46OqM=asyUkX7cT50Sg@mail.gmail.com>
 <CABgc4wThvZrxBLb0JRiROCws12qLNUxwcb4cJa_W63qh41apjg@mail.gmail.com> <585D086B-733C-4274-B274-794F360E8E33@zytor.com>
In-Reply-To: <585D086B-733C-4274-B274-794F360E8E33@zytor.com>
From: Fam Zheng <fam.zheng@bytedance.com>
Date: Thu, 25 Sep 2025 02:26:36 -0500
X-Gm-Features: AS18NWCTT_nnIvTOBeuqZvc8QEsP14wdwP9TFottPFdBIlDmadovY0Q4T0MAh1U
Message-ID: <CAG+v+KZL8teU5ReRNEJ2sdKgP02+K26DLMt2=KapZPfqcSWM3A@mail.gmail.com>
Subject: Re: [External] Re: [RFC 0/5] parker: PARtitioned KERnel
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: fam@euphon.net, Dave Hansen <dave.hansen@intel.com>, linux-kernel@vger.kernel.org, 
	Lukasz Luba <lukasz.luba@arm.com>, linyongting@bytedance.com, songmuchun@bytedance.com, 
	satish.kumar@bytedance.com, Borislav Petkov <bp@alien8.de>, 
	Thomas Gleixner <tglx@linutronix.de>, yuanzhu@bytedance.com, Ingo Molnar <mingo@redhat.com>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, x86@kernel.org, 
	liangma@bytedance.com, Dave Hansen <dave.hansen@linux.intel.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, guojinhui.liam@bytedance.com, linux-pm@vger.kernel.org, 
	Thom Hughes <thom.hughes@bytedance.com>
Content-Type: text/plain; charset="UTF-8"

> From: "H. Peter Anvin"<hpa@zytor.com>
> The difference is that this is highly invasive to the OS, which affects developers and users not wanting this feature.

Yeah that makes sense, thanks for clarifying. By having a hypervisor
at least in early boot of secondary kernels, we don't need to patch
device enumeration etc. In the kernel code.

Once the kernel is up, it can be then promoted to run directly on bare
metal, so zero performance overhead.

Fam

