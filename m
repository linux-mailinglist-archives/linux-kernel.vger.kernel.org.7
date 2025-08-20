Return-Path: <linux-kernel+bounces-777532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B075B2DA94
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 13:12:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65CCD1883909
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 11:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0C6D2E3390;
	Wed, 20 Aug 2025 11:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bbyLLFhD"
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B9A191
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 11:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755688181; cv=none; b=CGCKsClt1UlAwS5V47pSWbkZYNTyJtOqUMxhP1CY3+Er3U42eAOFmhD/hzFcdFNoXr2fw23M/l8bswmPMEI2S0Wx6J3CsLO1Gup+g5fSKkUx4rTG3EvFAB+h5J1sZ3rcpn2+gHPOFpdoNQPoJXu5oZPhe7pdIq9HecM+odCsjp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755688181; c=relaxed/simple;
	bh=eS0joPJOXjw9o3sjhnQ33Z/UzsOa7txJj8+EFbnFUmM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VVT25QIfMcmMh1FMCQkkUZ9gKmj+Ql4UHjMCHCqpfkF0Ud433Rq9M87LmzMe46zot9l+twUBwlRxYNjYsIae8AHOuQ5whwwk2y0n4HVpioBGRn4zrJlnZ5RqBBPpbugfVaui2Lw/BOBW+icKLVjsDmnaAZK3qrkAtymYFZFlSoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bbyLLFhD; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4b134aa13f5so41043311cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 04:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755688175; x=1756292975; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BLrqFezb204NBVU0Lw3ykD9KoUJspk/0DRdxFnKOLVA=;
        b=bbyLLFhDBPum1BOESrflOeahm+GNtam0lD1NACqiyqs2jzG2Y4nxBFo/JyB/8vgpSV
         Ya0DBOlJV5CrioqAmUV6OqssqUCSm9zQAc4bcZGWErvsTJHVCSGSwYmWcIGP4801DbL+
         foypl1E3dmdLUCUeb8pTbMA5fW3cN1MEAJf5INQQySHilt6pwj2sal5we1yylWik30ys
         f8LNSrVOKjT93Q4DPI2ZEIoOrLw1iuc9vTSE8qxzYponMl4qKZ2L/UVIk6jtMipFIAl6
         VkDOXOYJOxpjd5nLv+m+AL4aNTc852cxBLCCSwm7uzXsES1F8pmOUOVnL7KiBpTq8Fi3
         0vWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755688175; x=1756292975;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BLrqFezb204NBVU0Lw3ykD9KoUJspk/0DRdxFnKOLVA=;
        b=Dj+tvNZSGcq/FJ0+SwP+S4nhGXeGwI//0K86Lvs43gO04Fyh1cJ4nZLMbdmYtVKkA2
         h2W6ou4M2WDhVzAuv0Xs7TH4h1l1EwuckGMLELhd9XEptjSM8cpRX280VCZ6xK/B87Qp
         8bDyBfbyxYITDXIXLr3oV5CY7/l6gnXR4ttWpVuSpgOmyVReyQJwK21x7eHBG+Su7M56
         OWhyISqUtlMUW+/SLBMMCMoAD2ZrPl3VNVSiexTJwaMDnrmMpFp+ZTMPZm3CbcVX+J2P
         W2wWOT2MYyoFI3yaYoiu8cHN9CddzKgdNSoWPDhHHEJueW9Wq5Bau2odaxfhEth9eII0
         WOEA==
X-Forwarded-Encrypted: i=1; AJvYcCWu2JknyIEw00JC+rhVKEI3AwTk9sF51ZgQIemanv5FOchT+MAJXmLAvQ5nF7mWECScLsxsdVPTxdgDRx4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOMbX9vHX8FE3lj3r86fOM7FuaD/8SXkygtnzRawXxyr2uRQgm
	zc1K1epEAoUWLiyIVgmovoodny/bch20dxM2aXxFD6ylbOtdkpM21WfVFDboD/kRXHTXW5+GqRf
	azNcFgi2EsyqcvgjfWnuYSdusGlD1utg=
X-Gm-Gg: ASbGnct1SG8WB/y3Lvxiek6hZB75I5c4AlN4m+AJLTMNT750v1hI9WBqUwB5Cjkou6B
	VryZGqktCZnwKY/fQX3l+g5IA8cfGwi3XrWYFaq2uLcAhd8pKTYclInWqckCl/9FDeeTFeEiBWM
	OLtcb/Q9UIbZROIlrHX675H26w5oW3bLF5ZQqxqLYdH0HkppD1umaxKXJ6GEhJznY47Sp1QSrif
	FQQPatOJxsN9bE7HCE=
X-Google-Smtp-Source: AGHT+IHMkSl/ptmGGhKdk9o/G/iYd9nV6mxPKNnrNLrjJ4Z1XGzXiiAN67BtmKbuHWnf8+QOK5wXqrVGylyKQuCEKMk=
X-Received: by 2002:a05:622a:1147:b0:4b0:8c29:f6e1 with SMTP id
 d75a77b69052e-4b291a66088mr29672571cf.7.1755688175303; Wed, 20 Aug 2025
 04:09:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250812093339.8895-1-xuewen.yan@unisoc.com> <cf7847e4-78a6-4286-baba-60ace0c3d507@arm.com>
 <CAB8ipk9BDzsTTcdRKc9R_Hc72cOY8YyUfrCoY3_9hPJ8D-Fg_Q@mail.gmail.com>
 <8a84e658-1c2d-4380-8979-e1cc5bf5768d@arm.com> <CAB8ipk8kf1+Vd94wQn1XnWPvWqP1szxAeUroos1iV6Z17vbxFg@mail.gmail.com>
 <e3861092-71d3-4f36-8013-d721f60c1392@arm.com> <CAB8ipk8W8Oj2vu14sGX0wncPpJRD=xL35U8QW1wou-CX+3H0KA@mail.gmail.com>
 <7b3601d1-f39e-4691-84d1-8aa397e06535@arm.com>
In-Reply-To: <7b3601d1-f39e-4691-84d1-8aa397e06535@arm.com>
From: Xuewen Yan <xuewen.yan94@gmail.com>
Date: Wed, 20 Aug 2025 19:09:23 +0800
X-Gm-Features: Ac12FXx54VwkQZO70uvSr64Ev9lIe8yqsbzsqKJQHAWCNRSQqkfu53haKfJk4FY
Message-ID: <CAB8ipk-bRR3hT-+42gAN6oRZzEkoKN5K1o+zpep14-RJthXETA@mail.gmail.com>
Subject: Re: [RFC PATCH] sched/feec: Simplify the traversal of pd'cpus
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Christian Loehle <christian.loehle@arm.com>, Xuewen Yan <xuewen.yan@unisoc.com>, mingo@redhat.com, 
	peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org, 
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, 
	vdonnefort@google.com, ke.wang@unisoc.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 19, 2025 at 10:01=E2=80=AFPM Dietmar Eggemann
<dietmar.eggemann@arm.com> wrote:
>
> On 19.08.25 03:02, Xuewen Yan wrote:
> > On Mon, Aug 18, 2025 at 11:24=E2=80=AFPM Dietmar Eggemann
> > <dietmar.eggemann@arm.com> wrote:
> >>
> >> On 18.08.25 12:05, Xuewen Yan wrote:
> >>> On Fri, Aug 15, 2025 at 9:01=E2=80=AFPM Dietmar Eggemann
> >>> <dietmar.eggemann@arm.com> wrote:
> >>>>
> >>>> On 14.08.25 10:52, Xuewen Yan wrote:
> >>>>> Hi Dietmar,
> >>>>>
> >>>>> On Thu, Aug 14, 2025 at 4:46=E2=80=AFPM Dietmar Eggemann
> >>>>> <dietmar.eggemann@arm.com> wrote:
> >>>>>>
> >>>>>> On 12.08.25 10:33, Xuewen Yan wrote:
>
> [...]
>
> >> Looks like we do need also the sd cpumask here.
> >>
> >> Consider this tri-gear system:
> >>
> >> #  cat /sys/devices/system/cpu/cpu*/cpu_capacity
> >> 160
> >> 160
> >> 160
> >> 160
> >> 498
> >> 498
> >> 1024
> >> 1024
> >>
> >> and 2 exclusive cpusets cs1=3D{0-1,4,6} and cs2=3D{2-3,5,7}, so EAS is
> >> possible in all 3 root_domains (/, /cs1, /cs2):
> >
> > Isn't your CPU an ARM Dynamiq architecture?
> > In my understanding, for Dynamiq arch, there is only one MC domain...
> > Did I miss something?
>
> Ah, should have mentioned that this is qemu. I used a dts file
> (qemu-system-aarch64 ... -dtb foo.dtb) with individual
> 'next-level-cache' entries for the CPUs {0-3}, {4-5} and {6-7} so that's
> why you see MC & PKG. Removing those gives you a system with only MC:

Thank you for your patience in explaining:)
Looks like we do need also the sd cpumask here.

Thanks!

>
> [  106.986828] CPU2 attaching sched-domain(s):
> [  106.987846]  domain-0: span=3D2-3,5,7 level=3DMC
> [  106.987941]   groups: 2:{ span=3D2 cap=3D159 }, 3:{ span=3D3 cap=3D154=
 }, 5:{
> span=3D5 cap=3D495 }, 7:{ span=3D7 cap=3D991 }
> [  106.988842] CPU3 attaching sched-domain(s):
> [  106.989096]  domain-0: span=3D2-3,5,7 level=3DMC
> [  106.989136]   groups: 3:{ span=3D3 cap=3D154 }, 5:{ span=3D5 cap=3D495=
 }, 7:{
> span=3D7 cap=3D991 }, 2:{ span=3D2 cap=3D159 }
> [  106.989679] CPU5 attaching sched-domain(s):
> [  106.989692]  domain-0: span=3D2-3,5,7 level=3DMC
> [  106.989773]   groups: 5:{ span=3D5 cap=3D495 }, 7:{ span=3D7 cap=3D991=
 }, 2:{
> span=3D2 cap=3D159 }, 3:{ span=3D3 cap=3D154 }
> [  106.990466] CPU7 attaching sched-domain(s):
> [  106.990482]  domain-0: span=3D2-3,5,7 level=3DMC
> [  106.990632]   groups: 7:{ span=3D7 cap=3D991 }, 2:{ span=3D2 cap=3D159=
 }, 3:{
> span=3D3 cap=3D154 }, 5:{ span=3D5 cap=3D495 }
> [  106.997604] root domain span: 2-3,5,7
> [  106.998267] CPU0 attaching sched-domain(s):
> [  106.998278]  domain-0: span=3D0-1,4,6 level=3DMC
> [  106.998295]   groups: 0:{ span=3D0 cap=3D159 }, 1:{ span=3D1 cap=3D160=
 }, 4:{
> span=3D4 cap=3D496 }, 6:{ span=3D6 cap=3D995 }
> [  106.998584] CPU1 attaching sched-domain(s):
> [  106.998592]  domain-0: span=3D0-1,4,6 level=3DMC
> [  106.998604]   groups: 1:{ span=3D1 cap=3D160 }, 4:{ span=3D4 cap=3D496=
 }, 6:{
> span=3D6 cap=3D995 }, 0:{ span=3D0 cap=3D159 }
> [  106.999477] CPU4 attaching sched-domain(s):
> [  106.999487]  domain-0: span=3D0-1,4,6 level=3DMC
> [  106.999504]   groups: 4:{ span=3D4 cap=3D496 }, 6:{ span=3D6 cap=3D995=
 }, 0:{
> span=3D0 cap=3D159 }, 1:{ span=3D1 cap=3D160 }
> [  107.000070] CPU6 attaching sched-domain(s):
> [  107.000082]  domain-0: span=3D0-1,4,6 level=3DMC
> [  107.000095]   groups: 6:{ span=3D6 cap=3D995 }, 0:{ span=3D0 cap=3D159=
 }, 1:{
> span=3D1 cap=3D160 }, 4:{ span=3D4 cap=3D496 }
> [  107.000721] root domain span: 0-1,4,6
> [  107.001152] root_domain 2-3,5,7: pd6:{ cpus=3D6-7 nr_pstate=3D4 } pd4:=
{
> cpus=3D4-5 nr_pstate=3D4 } pd0:{ cpus=3D0-3 nr_pstate=3D4 }
> [  107.001869] root_domain 0-1,4,6: pd6:{ cpus=3D6-7 nr_pstate=3D4 } pd4:=
{
> cpus=3D4-5 nr_pstate=3D4 } pd0:{ cpus=3D0-3 nr_pstate=3D4 }
>
> [...]

