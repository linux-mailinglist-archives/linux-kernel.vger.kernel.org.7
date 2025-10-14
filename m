Return-Path: <linux-kernel+bounces-852832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 94506BDA063
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 16:35:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 695934E0F80
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 14:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7C952E9731;
	Tue, 14 Oct 2025 14:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YFBedQUy"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA91273800
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 14:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760452539; cv=none; b=Qd/PJJTLKXQTTu5TZfdmiDGS60jSJiALaNUrF0hCOVhMS8/4ToAiYpcAeZAumCGTv5HEHdtOy3jgyi0vQdIka9QRw5rZ8mc5vIiXaT6PyNuRsecLKpzXaWDTOFJFYCm7CP062RghyZdK3or77F/ZkBAEnT1i2mkZQDoaaZO7YL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760452539; c=relaxed/simple;
	bh=JYVEN0OqJi31lb/EBOxsUQedfZ4Fq8pZ+n4cQbV52UQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hsVNlcRRAv7M7Lp7Zi3FgjZQz5N7+2QluyCRMnQFGOSyT9nzPoAd9FYkuIZprel+TfTFQ+knXRvMRdRT+9euAGEVecN5Saw+jEqbDYrROuZcTwEhUSaS8707oV98Vc50bWSIwp7jFpjp7yDaIRU9DhzpV7WIpMDLc0/cH4o4icQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YFBedQUy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760452535;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MkDsCPEbcLpNNIg73v0m64/0N+FbfRudeNnq+y5jkqI=;
	b=YFBedQUyhHxoEKMgQaohZqpvXyndfxzz2ID47NqPEkgNWTcffJB9vwnMQjNhfIMAziRs9s
	wUv38MmOE3JkUQMRZOuXyVAb0EPfYEgjPtSyNkY1qAxLKhEnbrTIlwOobtMDupQaZr7QiW
	mYThVIALrTgKURyp7aV44lnIZwbBnoA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-19-VPpWggY5OPWZJXRhFrQZEQ-1; Tue, 14 Oct 2025 10:35:32 -0400
X-MC-Unique: VPpWggY5OPWZJXRhFrQZEQ-1
X-Mimecast-MFC-AGG-ID: VPpWggY5OPWZJXRhFrQZEQ_1760452531
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-46e31191379so39798425e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 07:35:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760452531; x=1761057331;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MkDsCPEbcLpNNIg73v0m64/0N+FbfRudeNnq+y5jkqI=;
        b=UcPa/fHJFt3AVnzyg5mvg8fIMsCqul4zvT153UvyKbG0JhPas547ZcRe5Hn4WCGhZr
         ziYjhtj1HYcUQiDXGW3gji2LZSn4smPu372ppLdWxAx03Apz3zhIKaeDYf6xtnux09qh
         tgw92jjUvqhxHdwBr3X5pObxt6OvKdFBRxGgY7V7q9ZKkrWtplYxPdOfipfxv/O32MRp
         uGDEJw9vu+9VgIHgIj7lxSyGSl9WnOY1WMBTzj0CdhDJQX1L+VQgCPREWENN0Rdub+Pi
         pzd/+M3MlQyq4GIOgZyP4+HwkoKIY9yDDqRBDdNTkaDI02hIRvDeS/zGURoqGua+ZGjk
         pqew==
X-Forwarded-Encrypted: i=1; AJvYcCXZlPoM0fXFIa7d0p6kaC9zPBGpoDcNJoWgGn2WP5gFQC+Y7AcKOopqUTlbvWdvpGjSFTYgrEYsKZS4GmI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaTUTvk3b5tvq+4GP6M5WHtxFGSnKZbylekKa2/99npoYcvflB
	VlbUFn0mHI/vNzL7Mted8dVXnQfHdyhM65+T9EnWrSL/Vurs8zWTBwVnQ/+aptPp3t5P/1h8evj
	nmW1HfvE4ao9TeYf7JyOTbbZpT8Nx5Yi8v8dq+y4jFgcx63xjQcZJFv9vWjZNzzsv+84ody7YF+
	Gx2rjByGWxZ/oF+r7fjhyW7xAGUG+8sYNoq04CNuYJ
X-Gm-Gg: ASbGnctS9Gn3qCl+GHPAZ8pBoKkhM6SMP7pCu4/vXbQ0k1Bd6WaohOV+YfIyIuUgdNg
	bDIIO7WfBy2153e64ayHsyMfgDTtKA19wq+VSAD7tEr2n0RZnI99qJWhQ6XCp9KCSfpwc88wqGs
	y292LWc8VmDGhDml7zoHNY
X-Received: by 2002:a05:600c:198f:b0:46e:3b1a:20d7 with SMTP id 5b1f17b1804b1-46fa9af8595mr204735745e9.19.1760452530939;
        Tue, 14 Oct 2025 07:35:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHRryLs4WIGONNx/31gi7TRTpZGUqKiXRcYoOaODwhm9G1YC6At5q1zb3Ec5A0TF/vYqP4NuMRa2aDH00hz3h4=
X-Received: by 2002:a05:600c:198f:b0:46e:3b1a:20d7 with SMTP id
 5b1f17b1804b1-46fa9af8595mr204735495e9.19.1760452530521; Tue, 14 Oct 2025
 07:35:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251013111539.2206477-1-lzampier@redhat.com> <20251013111539.2206477-4-lzampier@redhat.com>
 <20251013-trimness-stainless-48343053f204@spud> <6b7c3c90-d3bd-4d75-9cc0-74d3945fbdfd@iscas.ac.cn>
In-Reply-To: <6b7c3c90-d3bd-4d75-9cc0-74d3945fbdfd@iscas.ac.cn>
From: Lucas Zampieri <lzampier@redhat.com>
Date: Tue, 14 Oct 2025 15:35:18 +0100
X-Gm-Features: AS18NWDHw3ilq3xf4zsXNnm36BWMn-DfS6Dq0bHoaXz_kGv7G-Ly9Z3fIfWQqSg
Message-ID: <CAOOg__Cx1x0745LCPh5=EMiDeAVUWy+zzGCqb=BQ-RSFoyZDLQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] irqchip/plic: add support for UltraRISC DP1000 PLIC
To: Vivian Wang <wangruikang@iscas.ac.cn>
Cc: Conor Dooley <conor@kernel.org>, linux-kernel@vger.kernel.org, 
	Charles Mirabile <cmirabil@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Samuel Holland <samuel.holland@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Vivian Wang <dramforever@live.com>, linux-riscv@lists.infradead.org, 
	Zhang Xincheng <zhangxincheng@ultrarisc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Conor and Vivian,

On Tue, Oct 14, 2025 at 10:15=E2=80=AFAM Vivian Wang <wangruikang@iscas.ac.=
cn> wrote:
>
> Hi Conor,
>
> On 10/14/25 02:30, Conor Dooley wrote:
> > On Mon, Oct 13, 2025 at 12:15:38PM +0100, Lucas Zampieri wrote:
> >> From: Charles Mirabile <cmirabil@redhat.com>
> >>
> >> Add a new compatible for the plic found in UltraRISC DP1000 with a qui=
rk to
> >> work around a known hardware bug with IRQ claiming.
> >>
> >> When claiming an interrupt on the DP1000 PLIC all other interrupts mus=
t be
> >> disabled before the claim register is accessed to prevent incorrect
> >> handling of the interrupt.
> >>
> >> When the PLIC_QUIRK_CLAIM_REGISTER is present, during plic_handle_irq
> >> the enable state of all interrupts is saved and then all interrupts
> >> except for the first pending one are disabled before reading the claim
> >> register. The interrupts are then restored before further processing o=
f
> >> the claimed interrupt continues.
> >>
> >> The driver matches on "ultrarisc,cp100-plic" to apply the quirk to all
> >> SoCs using UR-CP100 cores, regardless of the specific SoC implementati=
on.
> > Why is that? I expect that you're doing that intentionally given the
> > ultrarisc employee listed as a co-developer, but with only one SoC usin=
g
> > this IP core it seems possible that this bug in the hardware could be
> > fixed for other SoCs that are built using this IP core.
> > Is there a plan to, for example, change the core version to UR-CP101
> > when the bug is fixed?
>
> I originally proposed to match on ultrarisc,cp100-plic under the
> assumption that it would be the case.
>
As far as I was able to verify with UltraRisc, this is a bug with the
cp100 cores and not the DP-1000 SoC, what that means is that any other
board using those cp100 cores should have the same bug. And I agree
that the function naming in this patch makes it confusing and seem
like this is an issue to the dp1000, I'll reword those in a v3.

> Furthermore, it is my understanding that if the bug is fixed in, say,
> UR-DP1001, then the PLIC node can simply be
>
>     compatible =3D "ultrarisc,dp1001-plic", "sifive,plic-1.0.0";
>
> I meant my reply that I had assumed this bug was associated with the
> UR-CP100 core, but I should have stated so more clearly.
>
> Vivian "dramforever" Wang
>

Lucas Zampieri


