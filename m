Return-Path: <linux-kernel+bounces-765867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B140B23F30
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 05:57:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 651D51B618BF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 03:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EF5A26ACC;
	Wed, 13 Aug 2025 03:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q88//AJn"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A122BE02B
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 03:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755057250; cv=none; b=ek6uK/tyI3t2XLt1THWtU8vvf8Y3XC9ixRvsDfARDsbMzc8Olc8Dzzh9txZ2zwW2wVkKz3iNV2fkpFaUJKiQSQCkcxGQa5dOhwFXVHopwtdaiNRRZ+dLa76iSC+4RCP+SO+FG1B4v3Vg9Yi/KlpKIskSlo4sfrq0mOcvU9R2bNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755057250; c=relaxed/simple;
	bh=Skda6nTvSWoZGGOd7yZiDe24NOcyi8WiqRzV833V2EA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cVesMSaouJQdv18cXzIXqEA6MyzFg+UeXmHp83OtHOxWTMtOIsVnPRTyTxMtnzzTkl9QJa6lLXtk/uZdoCZS2aQPhXhaH2sTdWLMrrWTzqhH0BmzfD2qsQ2E4//DBoTxlEqHmFQeSv+sV9BczQ1XayfqnKkTkQGzBVTyJyHcDDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q88//AJn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755057247;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ldor2CsT8B6HWfUu/hwR1kEDuR0LOGQwR1IQ7tbgj10=;
	b=Q88//AJnoZtpwXolzlyXSnIUWECoaTTmqKH1MvHCgo6lEsbv7OP+ulouRZhcz9pkPsfX7B
	Jv+Z/Crkw9to+j+AK6DztJOd2PVHxf59nNZ0Tv2tKazYilZdaWrOciTKkJ7Fgg8BvskHRe
	vq7Y8S8uWHdHsvlT6CQznvk6ruTeoO4=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-65-_viJz_KMNZimGTKB9mVFOg-1; Tue, 12 Aug 2025 23:54:05 -0400
X-MC-Unique: _viJz_KMNZimGTKB9mVFOg-1
X-Mimecast-MFC-AGG-ID: _viJz_KMNZimGTKB9mVFOg_1755057243
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-55ba1981389so3190332e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 20:54:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755057242; x=1755662042;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ldor2CsT8B6HWfUu/hwR1kEDuR0LOGQwR1IQ7tbgj10=;
        b=qjCVARkV8HF6D2fNIfQY3b8S/VQBrF5SXj2OX5Zi8PQ19/mGdbP8WJi/EBGnXvMxJG
         n7GLy+QxMtlqC3plywuBvaDFP7AGL+bTbBazl8K2lM+q9lZkpy2hIjdbHbA4NYoAoTZ+
         g4kjvWKqyF2z8lbAPW4xwfoyOyfDQFzvvPO7+8XLP6zKqqe2y4bESn/GOy6I90naDBS5
         964EUfkpZUBTpg5UlXIcmMRFxvmrnRvbh/TVzkPKPF96shZWyPdidqpEtcui0nTNPW0B
         2/bhKPrH8tpq8z3PhdtlsL5qmSXwHJW735Rrg0Al0o3Bo1iCE5xq9eAxYALbzaKcIIo7
         5a4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUzQcz1pdkD2WbENi5TsyLmajeb29/u24ohyYYBlal7cxczWjNJGScnlPE/ZRDDrOKL280RBzc8UYFN/Yc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsM8toUUEvd/zu487lZmEBlrn+Vzzd0sDeZ83s54f7DnaHQ9v/
	xd9s4+omlQBFZMHRJkw0PmbQK6XpdJ1jbYB9FPLVMStSMS0UYarnhfZ863uUwqVufDthfFyrrPA
	SHDdDhqCujchiCSSJuQPuWxr+TuWfl3zpc8keiy6/lOU94LwXyNZEds4MNZOs/F6cUEjG2jI021
	TOkyqjjI4qUoFwfnd0VwM23OObzExLlv2I8tdIhK3n
X-Gm-Gg: ASbGnctV6XoX0kDZnJS07C9//rLX4phyqswzmaLw7TlJd9CZKtk3DT6jyE7QzV1TUHX
	mPy5Qkw91vSLv/K3C1TiZkdMG5b/pFnNjPtrbxcdS8HE3UFp2anXNL+G1KMx1gkkjC8ky67TSlk
	dnncXI0N1F+TCwlFcDRWTA9w==
X-Received: by 2002:a05:6512:aca:b0:55b:8277:22a2 with SMTP id 2adb3069b0e04-55ce0345860mr417148e87.21.1755057242535;
        Tue, 12 Aug 2025 20:54:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEZexknp+rla3L40FUKhJV5/CkF/Q1buN23b5+UivngVCIbFHMBHBYv82Z303ckdVGtLcpYInGr0FEz6ewgXYw=
X-Received: by 2002:a05:6512:aca:b0:55b:8277:22a2 with SMTP id
 2adb3069b0e04-55ce0345860mr417134e87.21.1755057242110; Tue, 12 Aug 2025
 20:54:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250805211527.122367-1-makb@juniper.net> <9B71EC74-D1F4-4F7D-837A-A43E53CEBB89@juniper.net>
In-Reply-To: <9B71EC74-D1F4-4F7D-837A-A43E53CEBB89@juniper.net>
From: Dave Young <dyoung@redhat.com>
Date: Wed, 13 Aug 2025 11:54:43 +0800
X-Gm-Features: Ac12FXyxBbd3MqroyWxKC83iyko_mLksVDwNvBYetOdQP2oCw_iEtH2TUcVrO6s
Message-ID: <CALu+AoQnXfYtuKQxVKK32sC4D98Y+Yn30TjTr2xmXhZcHe0x=A@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] x86/kexec: Carry forward the boot DTB on kexec
To: Brian Mak <makb@juniper.net>
Cc: Baoquan He <bhe@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Alexander Graf <graf@amazon.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, 
	"x86@kernel.org" <x86@kernel.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 13 Aug 2025 at 02:01, Brian Mak <makb@juniper.net> wrote:
>
> On Aug 5, 2025, at 2:15 PM, Brian Mak <makb@juniper.net> wrote:
>
> > Hi all,
> >
> > Here is v2 with the comments from v1 addressed. I also added a patch to
> > the series to add KEXEC_FILE_NO_CMA as a legal flag. I noticed that this
> > was missing when I went to add my KEXEC_FILE_FORCE_DTB flag.
> >
> > Thanks,
> > Brian
> >
> > Changes in v2:
> > - Added a patch to add KEXEC_FILE_NO_CMA as a legal flag
> > - Added a KEXEC_FILE_FORCE_DTB flag to enable carrying over the current
> >  boot's DTB on x86.
> > - Modified the commit message to include more reasoning for the change.
> > - Changed a pr_info print to a pr_debug print.
> >
> > Brian Mak (2):
> >  kexec: Add KEXEC_FILE_NO_CMA as a legal flag
> >  x86/kexec: Carry forward the boot DTB on kexec
> >
> > arch/x86/kernel/kexec-bzimage64.c | 47 +++++++++++++++++++++++++++++--
> > include/linux/kexec.h             |  6 +++-
> > include/uapi/linux/kexec.h        |  4 +++
> > kernel/kexec_file.c               |  1 +
> > 4 files changed, 54 insertions(+), 4 deletions(-)
> >
> >
> > base-commit: 35a813e010b99894bb4706c56c16a580bf7959c2
> > --
> > 2.25.1
>
> I see Andrew has sent these patches to linux-next. Thanks for that,
> Andrew!
>
> Dave and Baoquan, have you two had a chance to peek at the updated patch
> set yet?

Hi, The #ifdef CONFIG_* which can be replaced by #if defined(), but I
do not have a strong opinion.  other than that do you have kexec-tools
patch ready? It would be better to provide a link so that people can
try and test it.

Thanks
Dave


