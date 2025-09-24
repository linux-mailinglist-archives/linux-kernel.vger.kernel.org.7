Return-Path: <linux-kernel+bounces-830196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74812B9907A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 11:06:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 360982E657D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 09:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93D952D541E;
	Wed, 24 Sep 2025 09:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="No3ZD47h"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E6F15ECCC
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 09:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758704766; cv=none; b=IcZtumpnfXq7L2DXCUi84jPxmp1BuomMvjP58iDpCv/EHNHsCdF3z/lP450NIgf+DxXLglgsWFL6Be99i/9KT4pX9xC3ecNFIVB+Q6oMAEfOFYlIQ6fx/DkH6VTxyc+Ig7F7KT6c8V+Y6wWDZan+voDp9vsdbh3Vj0fWSrAqG9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758704766; c=relaxed/simple;
	bh=hV6pVJCy88z+Ez46hm5FvsCmrpZWxYrT9wmMYgVLqLI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bIXJLynhip4MBTX3QLxpJLmNIlyHvL+W3Ii8Tb8jDj1Z95U+JxTwUJZq6Rv8QIvzJcTUXiRPj7ahInbM0DmuL0Od/t4ZpE0Esd4cSzXZzdcQ29N0Vpaw/1UPaidlpTjjpk1AokhJ39XqfxoZP6z7icNE1Pd1Uckjto/IBm2oI1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=No3ZD47h; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-367064ef8a9so30001581fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 02:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1758704762; x=1759309562; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hxEUHbOZ6w2gZYBHft0CTA/ULDWZ/SYwd+sBl17eLJY=;
        b=No3ZD47hjgaFPxmRksDyPOSDuAyjKgEYOYNinXh3OjHiQNH4kHujlG20smGHMAi3lK
         YdqoxHKNnhVY8heTbGBk3G6MGzS63YlJ34CWeGYlNjYdmDqJFXiqMKwRO6iXd/zFjmrf
         Os607w95KHMvEGNTbN2Yz7DBXVMK6rj56iliKsP1Yf+LnLYkjqtaD5N4Ir0vmxiMfiYg
         Wo4b2JNxDGFN4jPIBd2Lt3ngYNQbTXT/bEiVtN+yvFJkYVGAJEQUFHgaUavHj+AQWhTy
         wIFb/WWKqZ9MzYWsPf/4XUS/SzZjjQ5hiA1rgPQfekmSW0mZhx+80sNM7lwqPxeIcu6H
         8iew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758704762; x=1759309562;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hxEUHbOZ6w2gZYBHft0CTA/ULDWZ/SYwd+sBl17eLJY=;
        b=wiVnUnoD//UR9Bszov/a+572pZtQQPBpKiXmCQcuNwHnKASzM8YtvFBdwo0YgGiTIf
         5HtjsHq9LqmsLWXaRAsHQXfGGCiR7n7lqcKwOZvuLcchxbjBq/5NhDTY8iqfxt/nW7e/
         b26LrFKBZn9N2SqGeG6R0f6aNDeItCzDKS5078gmdgXDc4G/X3pvBVABtVReKvh3jfMn
         XmNuxRPBZN4n1LAQYr6GFsMH1Ns4gntITWqo1ziEVSQWC6QhQIPUeatdUn6dbBaaXzF8
         Aya8udr4O2/J9hapCZ90qT6wLk9TfMRwSoNm8nizjew1I09o7mMmf3xD9e06yv5Yfel4
         sfZQ==
X-Gm-Message-State: AOJu0YxT7QRhsarGYyOcuJggZEqAS80tad06vAVKOf+YLvls1KS4K7DV
	RrohIdUGrwMCT6/oruJBYgQKlXLlLbmsVM0Q7MZ6IgFrWFIQTa9zDcSMca9Ua+XntXKMpaIuw2G
	R3/SEDpCwXoB0xwJopw3L2nNVjveNq6od/zpANzJB7w==
X-Gm-Gg: ASbGncvZc7sxKBiogzC2dUm0TcYrYoDvz52R4O0T3yhmJKzU3LFCUCeK4Nwl9GLCjIo
	Emi+7g+IaRtTjCaNFcm12B6HXlkM6n6GevVo868PtIQSXNcKFCA8tiWz+yRERSfZNXPuRktTTE7
	IWv7t7NYJJ03fKT5GetrTVJt9QGEKZ92KecV9bulef45SHHGfJImKnM900whCsW+v3vmWHxst01
	DbaJUHpBlckr8z+3pBRfI+LDvr1ld7aEEgprmwB
X-Google-Smtp-Source: AGHT+IH7Nmy3mld+qkzUDRq6dwD3hmciCwsBuq9DPFIP04OaJHup0AtZbCzJqBcnwyE12Mfaz2q5Ei5fZhlAOCiBhtM=
X-Received: by 2002:a05:651c:234c:20b0:364:f7e2:3908 with SMTP id
 38308e7fff4ca-36d16bf698dmr16950931fa.26.1758704761910; Wed, 24 Sep 2025
 02:06:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250917153859.363593-1-marco.crivellari@suse.com> <20250924090330.7748Aaf-hca@linux.ibm.com>
In-Reply-To: <20250924090330.7748Aaf-hca@linux.ibm.com>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Wed, 24 Sep 2025 11:05:50 +0200
X-Gm-Features: AS18NWBgeCvLLAozlxVxWa0adq5AECdaXGbqHkUSh_nmAZ-djbth6cAkpVPaTbs
Message-ID: <CAAofZF7gqhoQzRZh0=O8oAzCabMrGZ-rZkt18Vpc5BkNywVj2Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] s390: replace wq users and add WQ_PERCPU to
 alloc_workqueue() users
To: Heiko Carstens <hca@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, 
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Michal Hocko <mhocko@suse.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 24, 2025 at 11:03=E2=80=AFAM Heiko Carstens <hca@linux.ibm.com>=
 wrote:
> > Marco Crivellari (3):
> >   drivers/s390: WQ_PERCPU added to alloc_workqueue users
> >   s390/diag324: replace use of system_wq with system_percpu_wq
> >   s390: replace use of system_wq with system_dfl_wq
> >
> >  arch/s390/kernel/diag/diag324.c  | 4 ++--
> >  arch/s390/kernel/hiperdispatch.c | 2 +-
> >  drivers/s390/char/tape_3590.c    | 2 +-
> >  3 files changed, 4 insertions(+), 4 deletions(-)
>
> Series applied, thanks!

Many thanks, Heiko!

--=20

Marco Crivellari

L3 Support Engineer, Technology & Product

