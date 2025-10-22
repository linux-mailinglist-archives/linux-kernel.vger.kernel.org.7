Return-Path: <linux-kernel+bounces-864756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7D99BFB788
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 12:53:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17764189B645
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 10:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C5D03233EE;
	Wed, 22 Oct 2025 10:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WaB7rgIA"
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC98246762
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 10:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761130357; cv=none; b=XPHlJmJNVIqC+8S9f6iwYhztplYJ5D8mM5vQrJAnQfU1McO/ub6PDtSbAU9B5GG1TqNc7kVSS/BzXP08kztoptyo9+CKrvzcgCMMVDbpWsEOIvWy5WVLPT5rv2A+3iw4zjvdl0vke5DLXfzKkY2XxYWs3bVNO+NJxA9FwyL4vWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761130357; c=relaxed/simple;
	bh=+MHqJhddBVXKtcU8ztFKmj1eMQPN/RlOUsiDFZNENSQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HhEcDvrTilFPOvfjSh3TGv3rKMbDMUA6yJzTeXiwYpGOuvFvkE+x/eYK7HAHS9k+vSNgjGaJ+7OZpu+Mjvp7Gx4vUI2PblgXdiHapbfcLk2Dkv8pO32Ioaq08pr/W0xxAt7+V16PadNUy8pi5v/jKsjcbzAAjN4ubfwV+Vja5oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WaB7rgIA; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-88f8e855b4eso577432185a.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 03:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761130355; x=1761735155; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yEuWOBEN/U35xXneOxk8fuulvP+81wWTxzQsKgpzxyU=;
        b=WaB7rgIAnruCaEO18CYf8JzrQxGp6Utk7SjjB7RDD4VguyvdlTuUCVBqyQ1VWFQISe
         LiQ2VE+S8unO7YInLk5jK0NgTKXp5jC4kE0tH2OIBFLLj0AOClCHFmevIkwHgRBEgYzo
         6G1Yu2CsHt2aRf9fkJyvJc0rsSpGXp8aWmstzx8JlVYusz3nQse4TvBNvnQpHyAEMXPq
         5zQQiLvCMovdDs1XfmZ4zMFWnYI8EbGsZwUwscDxhoRrgm6hLtMROTjqGuE29IuWMzNF
         vzUhp61BibiX70keIOdJNExED+FisGKztCXlEflM3nocVzdXDSWGqFXE3+V0eZSc4JT8
         YheA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761130355; x=1761735155;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yEuWOBEN/U35xXneOxk8fuulvP+81wWTxzQsKgpzxyU=;
        b=WtW7leJGstw1z5csgtfvEeEoiTuuUXxvj9ouwATExGA/s7xmbg8gweqw3Y1KvQglrH
         ATDKJSnk706ZjCJxWOcPKL9LfxVBO/U8SpXvVzJRcCrtV5BVH70up58sy76vjm+2mfA5
         JeqKzjheHYQncoLLI2PFTHPK98cClJRIkBxcXBQj9CqOrV8GkTpLec8WJ9whW8lID/Ex
         uf5XniAVMJCoManYyWSoIahJvAkf4bGKNGoZaWk8Q5Hwchmvv8zdL68c+8yxikMLiAut
         If192/Fn3V/TXbTQzgyGNCitawqM+MN5O0gTEx16gGdMkFibuJ1uVxG6WP4cQv29Ob0z
         qRhQ==
X-Forwarded-Encrypted: i=1; AJvYcCXMLMA1CfChG29HiWyubrHPLvxa81kBUi6/Cu7e1gihXCn1PCVKxqPOos/PYGfDR+NsqvJOrVIqnIRqwE0=@vger.kernel.org
X-Gm-Message-State: AOJu0YydiknGm8113bNsaOAkMEabBfJ+jSnfUVqeLEyBNIoFXBKkKcFq
	008V8KXuCjUGvC6BGZxPfbABbCVpx6hY6s7/8/TmvPXLU0a1lGS4NO6LSLKrytImJDjtyHulQAM
	r5y/vxK1PmmdR00ohmna2o/VhrC4ocWE=
X-Gm-Gg: ASbGncvmlk/6lozpKLr0+C8ezY5J3oEBC9KhHehCpO+Dh3OOKc63m3BoVi1iCf4CgN4
	sq+oQ475uvMGVXoCWeJtE9qnH99gvKoEb7Rmw9YGrGr1hI3W1lRArIjm4B+KteKF60jJyX3i2xE
	k4lJwcIsm3uDbBZ4sfwNOf9OAm/sylnabkEFwzw4OISnIIHwLtu0un1We69RdLFOBj/QbuHeV1O
	swf12zgq6WSKTz6CQ6rbxtY+jai/bfpWxFF+lrEuIqx6+JdUxwEINKGQLeFXDUCv1hFTt32pnhL
	jJzvgrAGgHk/tNIXO5AdUIOS6l4=
X-Google-Smtp-Source: AGHT+IF+UfILE16/+y31/plfKL4BsKCPsgS9omTYmo7r7nqziwmbbysRvcZ1nTCNlDK4BHMGeEjCaYDlClvwVJdT4QE=
X-Received: by 2002:a05:620a:25cf:b0:850:b7ad:c978 with SMTP id
 af79cd13be357-890708f2553mr2525779185a.49.1761130354392; Wed, 22 Oct 2025
 03:52:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251013092038.6963-1-ying.huang@linux.alibaba.com>
 <20251013092038.6963-3-ying.huang@linux.alibaba.com> <CAGsJ_4xaA8QRjP9H=n1hQfEfGop7vOd5Y=J+KQzuOyfa8GK-kQ@mail.gmail.com>
 <87a51jfl44.fsf@DESKTOP-5N7EMDA> <CAGsJ_4zPH0fwBOLQwh1y6jG3tCXHLGRCTyVVSCWb+NfLCEMV0Q@mail.gmail.com>
 <871pmv9unr.fsf@DESKTOP-5N7EMDA> <CAGsJ_4zW6ogVdi=t9JCuvGD9N21mA_ORXRCakw4Av68d9n+DDw@mail.gmail.com>
 <875xc78es0.fsf@DESKTOP-5N7EMDA> <CAGsJ_4zKGS-Xd-58ufXGoyRfaZWd8wTgv0b6ibHJ2aS14mQqtw@mail.gmail.com>
 <87a51j6zg7.fsf@DESKTOP-5N7EMDA> <CAGsJ_4y32i3aNYPum=8J3_Kt6vOSisr_jg6btB-YG1uQBqHG7Q@mail.gmail.com>
 <87ms5j4444.fsf@DESKTOP-5N7EMDA>
In-Reply-To: <87ms5j4444.fsf@DESKTOP-5N7EMDA>
From: Barry Song <21cnbao@gmail.com>
Date: Wed, 22 Oct 2025 23:52:23 +1300
X-Gm-Features: AS18NWAP0fbsGHxZLrVjv_J-9bnvKPZdV1GwoS51_2cxWur2X2S3xT3hLu6HdG0
Message-ID: <CAGsJ_4xhJSLnXOZy4kPmnif5Paq+OPN_Ww+rPk2WO4-ADSC0Yw@mail.gmail.com>
Subject: Re: [PATCH -v2 2/2] arm64, tlbflush: don't TLBI broadcast if page
 reused in write fault
To: "Huang, Ying" <ying.huang@linux.alibaba.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Ryan Roberts <ryan.roberts@arm.com>, 
	Yang Shi <yang@os.amperecomputing.com>, "Christoph Lameter (Ampere)" <cl@gentwo.org>, Dev Jain <dev.jain@arm.com>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	Kefeng Wang <wangkefeng.wang@huawei.com>, Kevin Brodsky <kevin.brodsky@arm.com>, 
	Yin Fengwei <fengwei_yin@linux.alibaba.com>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 22, 2025 at 11:34=E2=80=AFPM Huang, Ying
<ying.huang@linux.alibaba.com> wrote:
>
> Barry Song <21cnbao@gmail.com> writes:
>
> > On Wed, Oct 22, 2025 at 10:46=E2=80=AFPM Huang, Ying
> > <ying.huang@linux.alibaba.com> wrote:
> >
> >> >
> >> > I agree. Yet the ish barrier can still avoid the page faults during =
CPU0's PTL.
> >>
> >> IIUC, you think that dsb(ish) compared with dsb(nsh) can accelerate
> >> memory writing (visible to other CPUs).  TBH, I suspect that this is t=
he
> >> case.
> >
> > Why? In any case, nsh is not a smp domain.
>
> I think dsb(ish) will be slower than dsb(nsh) in theory.  I guess that
> dsb just wait for the memory write to be visible in the specified
> shareability domain instead of making write faster.
>
> > I believe a dmb(ishst) is sufficient to ensure that the new PTE writes
> > are visible
>
> dmb(ishst) (smp_wmb()) should pair with dmb(ishld) (smp_rmb()).
>
> > to other CPUs. I=E2=80=99m not quite sure why the current flush code us=
es dsb(ish);
> > it seems like overkill.
>
> dsb(ish) here is used for tlbi(XXis) broadcast.  It waits until the page
> table change is visible to the page table walker of the remote CPU.

It seems we=E2=80=99re aligned on all points[1], although I=E2=80=99m not s=
ure whether
you have data comparing A and B.

A:
write pte
don't broadcast pte
tlbi
don't broadcast tlbi

with

B:
write pte
broadcast pte
tlbi
don't broadcast tlbi

I guess the gain comes from "don't broadcat tlbi" ?
With B, we should be able to share many existing code.

[1] https://lore.kernel.org/linux-mm/20251013092038.6963-1-ying.huang@linux=
.alibaba.com/T/#m54312d4914c69aa550bee7df36711c03a4280c52

Thanks
Barry

