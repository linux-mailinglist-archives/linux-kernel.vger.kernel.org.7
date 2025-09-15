Return-Path: <linux-kernel+bounces-816867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C97B9B57997
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 13:59:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AAA518969C3
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 11:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A700304BBA;
	Mon, 15 Sep 2025 11:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="ouPoUD8t"
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDAC83043D4
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 11:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757937544; cv=none; b=isg/PI4+1fGhr2TQ2hiOx292ZoRuTupVTTtL0/LoVHA8KeBOTkpzgRjzoG5LO98XkW1uOp86ayZHM+4vRweH3N5ybUnlLb28VIGtnGTx9dOgTZvwOSI2rEaI4H0s+VwAd+ftEzOdO7a7mpx0a1dFr9SMN/DTUiHwUVJzEZ/W35U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757937544; c=relaxed/simple;
	bh=w+Wo4LOKOK6vQ7K4HYgfgfOSwUdpnB4dRYCTrPRiDio=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j7ITvYVtrUG2Y/qRVuvQ2UwLH4MomFcIu4tL0GBbnNTTIEDMIf/xrBSVr7HZoCf8sAEcPQLmbZWEcKZOKAovXMfG/dTojbQBABCp3SWbc63eiZ8sZWV396ZStqeuJzjhyajtk2l6vpVC4IajNaDaPxslYk0z+PrGQC6Qrz5LJZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=ouPoUD8t; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-88f49be4c21so85005839f.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 04:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1757937542; x=1758542342; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w+Wo4LOKOK6vQ7K4HYgfgfOSwUdpnB4dRYCTrPRiDio=;
        b=ouPoUD8tA6kbRYgZzX815/EDv1tqH0GGTgWVVb9mVyEUELXWr5F3WxRF0Nxf7VwaHB
         eE3TzEF/H+Od07YPlvs6+HhxfaeQ4cWWoV4QEQfVfwMgiOUqHBrrt5P3ju1k8T+dT3VX
         zeF53pPQ4+mpfp5k/FlzQjNVMZ+TMtFQNj7n3nIrziCjVkxziFl7YSHL23jkKN7U3spR
         TpuGBQSt4Kflh+lDmQ/+4Wqgwog/0WnwKp4+PE/chr3z2ibwo8w0HJqYFi1tdwaYUzr7
         a7lL/VViCFi58Qlozj5O1qPFie8Nf9WZINBdEKzE9VCqVOMMYyUEMaBLtdHuEf3IlO5/
         Mvew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757937542; x=1758542342;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w+Wo4LOKOK6vQ7K4HYgfgfOSwUdpnB4dRYCTrPRiDio=;
        b=FjhhO2nTKoUQXnnluw62HKTnyDtFtss0c/ZStc/K4eFX7mYCoEwyk6+oXtJwfRk7EA
         qhTrk8tdftduiDSd3b4g1zkdqWpHyu96sIWPfduIzgx6dS14bsi3YHxQ2N1fabjvwjpF
         NVqQad/ON4C2/lJFad1N1Db6fFt6QffldLdsISiFGV4ybIraBmssnjNQ3YFJu4Tb4zpM
         hj9y8QGG7H7vE2SxzNYQoidfMovOOye758KG3UikUCW3sqEzT3+gy49l5nw3JJ5BhIpd
         WsDb1HawZ9ran6D47KSZlvW65UuWXQf0I36QxrSI8qegGLwzu7WZef4aYsp4srAQ6QPf
         SGtQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5O1ZuKqEXylaAiwzfiDoQzgAZuey5mXTMIhZA598Mp9SIEwk6atDDdXC40qW+O5r8yxTB2pbm2cZgGtE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAuCrD3suLVTO8Lrn1skR0U2T/WnwGW/f3czrMtL9sOSgGuVCx
	9uN6cpFnXMB7I3zF3EctGL4ypCuCT8l8ThqW1QKqhvGJcvxO/29wPSWVxmIRE7rDwfwXlEVMBoI
	2Gek9zfxVb5oOZVC9d/iJs+EgkhxRtPftJeH5XkmsJZum5FaIGVif
X-Gm-Gg: ASbGncvkqe9LhguVfYbtm1RjLOAwD69NrUgMH9zUTwX4PdqZYfQbsbioUbi/N0/LyVM
	yocLUhaJGGCA4NhLmA00HEVlcTYZSuKsj9vTIJQBfdHamygjJJPR6uhenn4RBYKo+UhqBdO+OwN
	4gHPDKIkNrwxlo3CTdV7KMjLviLMqi0u+RPL0WjGLug0WK2NmW6Kw55EZKk2+6C3s7I9vCXhuME
	JsNKtyaaqFr+cvPcWyd1ihORWVpxgYrJBVOWSRF
X-Google-Smtp-Source: AGHT+IHTDrsD99f5SQM6r2xQgpJxH71mXjBKOGQCXs9gTx5sBfVD90LiO27Njr8hwWJISfU1lWc6TvRVPNc4XTqs0j4=
X-Received: by 2002:a05:6e02:3312:b0:423:fd3b:ef72 with SMTP id
 e9e14a558f8ab-423fd3bf017mr46668695ab.0.1757937541951; Mon, 15 Sep 2025
 04:59:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909-pmu_event_info-v6-0-d8f80cacb884@rivosinc.com>
 <f740b716-6c8b-46a5-31ae-ecc37e766152@kernel.org> <aMftcHLgBvH76erX@willie-the-truck>
In-Reply-To: <aMftcHLgBvH76erX@willie-the-truck>
From: Anup Patel <anup@brainfault.org>
Date: Mon, 15 Sep 2025 17:28:48 +0530
X-Gm-Features: AS18NWDM6MzdjjPsw0ij-OL-CWk_57B0_4S3ilJtO7cErapGgoLvo5MzWEvUv3s
Message-ID: <CAAhSdy3wJd5uicJntf+WgTaLciiQsqT1QfUmrZ1Jk9qEONRgPw@mail.gmail.com>
Subject: Re: [PATCH v6 0/8] Add SBI v3.0 PMU enhancements
To: Will Deacon <will@kernel.org>
Cc: Paul Walmsley <pjw@kernel.org>, Atish Patra <atishp@rivosinc.com>, 
	Mark Rutland <mark.rutland@arm.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Mayuresh Chitale <mchitale@ventanamicro.com>, 
	linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Will,

On Mon, Sep 15, 2025 at 4:11=E2=80=AFPM Will Deacon <will@kernel.org> wrote=
:
>
> On Mon, Sep 15, 2025 at 12:25:52AM -0600, Paul Walmsley wrote:
> > On Tue, 9 Sep 2025, Atish Patra wrote:
> >
> > > SBI v3.0 specification[1] added two new improvements to the PMU chape=
r.
> > > The SBI v3.0 specification is frozen and under public review phase as
> > > per the RISC-V International guidelines.
> > >
> > > 1. Added an additional get_event_info function to query event availab=
lity
> > > in bulk instead of individual SBI calls for each event. This helps in
> > > improving the boot time.
> > >
> > > 2. Raw event width allowed by the platform is widened to have 56 bits
> > > with RAW event v2 as per new clarification in the priv ISA[2].
> > >
> > > Apart from implementing these new features, this series improves the =
gpa
> > > range check in KVM and updates the kvm SBI implementation to SBI v3.0=
.
> > >
> > > The opensbi patches have been merged. This series can be found at [3]=
.
> > >
> > > [1] https://github.com/riscv-non-isa/riscv-sbi-doc/releases/download/=
v3.0-rc7/riscv-sbi.pdf
> > > [2] https://github.com/riscv/riscv-isa-manual/issues/1578
> > > [3] https://github.com/atishp04/linux/tree/b4/pmu_event_info_v6
> > >
> > > Signed-off-by: Atish Patra <atishp@rivosinc.com>
> >
> > For the series:
> >
> > Acked-by: Paul Walmsley <pjw@kernel.org>
>
> I was assuming this series would go via the Risc-V arch tree so please
> shout if you were expecting me to take it via drivers/perf/!
>

Based on offline discussion with Paul, I will take this series
through the KVM RISC-V tree.

Regards,
Anup

