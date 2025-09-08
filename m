Return-Path: <linux-kernel+bounces-805787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 83F20B48D73
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 14:27:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CE7C168399
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 12:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2006D2FF653;
	Mon,  8 Sep 2025 12:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="got50yaj"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 917D72FF643
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 12:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757334433; cv=none; b=ryiDYMuAmWVDC6uKkFrc1SiNTTSoyiINQutntUCe7uhcTCcPQGXOT12a82BaxHT+AelJmm7pZExxDRMdkOEHhtrUjMTytul1VnA0yX13L4i1GCQuyaTQYzzwH9JgF9/qMhpzbmRB0+tvC8Y1KX49N2hqSvusdEwVELDSi3nOKVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757334433; c=relaxed/simple;
	bh=ferqKjXFtqGeb7sFdzv7UE52DVVJqiUPYvwdn/1ZU4Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lBkBnZamzU0MUGI9y65ATy+vbv7pT1iLi65Qr8DxVrFDbSGK3jiOMShyq5Hw8JZdYuWLni+vC/IaHx1ujoznSgoDC9gQ78cHnZfDWmddyOmHNhvKg2nLcpcZmjseDYNTeJelHd55QELm1KJdv6KNh7tfCVUyhkSVuPSXOQXp0wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=got50yaj; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-55f720ffe34so5681809e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 05:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757334430; x=1757939230; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ferqKjXFtqGeb7sFdzv7UE52DVVJqiUPYvwdn/1ZU4Q=;
        b=got50yajiIp71VHYbQ7EldZDzjLtNfDG5NgHWQ2+qG+Uz+iQONuQZyPepwKiqpxQMZ
         NS8AvRObW00TBrkA5si/lZCduA5n8zX9S9j2xX/RWvYwLDaF2I++Q0hpCWAlW7KFjvja
         DQS/LoEcAsN59c58It0RxsLsvDWWwR3uTO/8S8fS6OPvH/HMPp80LUgpO1usgDYOdviI
         gHGWdLCAfAxk82HyH+EBWtEsEJ7UsFIkTA/kpnBhL8/mv6fCG7Z/WJNoFMpmgLrCqz0U
         xe8c70K36HFaXDXRzeyG0CK5pAqZ16DVj57PXad4yWOGtLQQnuqD7wix/2L7UWmTCdrf
         eQEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757334430; x=1757939230;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ferqKjXFtqGeb7sFdzv7UE52DVVJqiUPYvwdn/1ZU4Q=;
        b=VLkhkBNXNYsP5zcq5ML0xpBP5om2Z/hgEHMF7k4783Ft/zwQFpBZb2KGy9H0CHd0XW
         ILcv795XR8TPXFCwPx03ANio0v4INp9u4rgzpGZHZaW77bMH/I0PWiF09QshkUlxYva3
         VvfeP6pz7MUZdGm97iUNjG2W05JkHpSMvrGJA/BMZROxWqccqSoHpZ+1uXX+yan6za2x
         LU6E1OUjhmT9alvfk7txQPQKoVucF9WC++5xC1DwIpBziE8fh1nQ+YbctwrXn0NIeg7n
         p/Up8jId2hzmTeEF0ygZ6RzxaVoA1YuTyvKXd6hDwHI/TVvZktDnUpRJj9KEsxYdJ5+r
         0aCg==
X-Gm-Message-State: AOJu0Yx1TG1rmk9OPMADOcG67NINmLH4s6LcsVEXU6UoX4HeouOhFsob
	8/VaQ9F9iKnnnwtMAyesY7vs8irfGLmIHFs5fDWpcsKt5NmkyAcFR5WOBr8LlmHHgtggnrywnpM
	HX3VTuQmgmfa4vFxUsUI/uE7IRPqnu8HLrqaEY7Iqvg==
X-Gm-Gg: ASbGncvoxQacXskaJWFeFWIF8AJyYFbD5hxlYflpkMzsHZGGOekadANWPqFEh2VI6bB
	p2gQwMblXDfJZM77ldU5B/RETqdDrrBXidxpAhaJ+7pD7C6JJh2fMjQJJIhmee498e+hX4EqrgU
	DtZk0n5UnF9DBuBL9t5nybfD1QvN8K2zRVHNfzo3YEhylF31e2vt9Bv/6+MuykZYVEFifPqKCt5
	TKn5G5oi2zQDj6gT9zX2yrSGtg5fYUabIav/MMnqXmZFjbG8NA=
X-Google-Smtp-Source: AGHT+IFrVYcRJkJidkEmKsfcO0oDpqsP4H/zygbfQx0jx6wBEnrg8xIY6th1peRb5x5em5L/xmD++ZGP83XbRY1pAmg=
X-Received: by 2002:ac2:57c7:0:b0:55f:5c1d:6cc4 with SMTP id
 2adb3069b0e04-560995d6aaamr2726817e87.20.1757334429706; Mon, 08 Sep 2025
 05:27:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250905090857.108240-1-marco.crivellari@suse.com>
 <20250905090857.108240-2-marco.crivellari@suse.com> <1f2a16a0-9c14-4403-9c39-35f8b8138188-agordeev@linux.ibm.com>
In-Reply-To: <1f2a16a0-9c14-4403-9c39-35f8b8138188-agordeev@linux.ibm.com>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Mon, 8 Sep 2025 14:26:57 +0200
X-Gm-Features: Ac12FXxAIlK7zn-tspBWXA8RzSIF6QGQXIp8HUKs624vrIFiTe0KEM4TXyIvB2c
Message-ID: <CAAofZF4GJbL4wmjxDTQYJg7Mp_GjLVrR9trek7DqoH0EniX2uA@mail.gmail.com>
Subject: Re: [PATCH 1/2] drivers/s390: WQ_PERCPU added to alloc_workqueue users
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, 
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Michal Hocko <mhocko@suse.com>, Vasily Gorbik <gor@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 8, 2025 at 1:38=E2=80=AFPM Alexander Gordeev <agordeev@linux.ib=
m.com> wrote:
> > This default is suboptimal: most workloads benefit from unbound queues,
> > allowing the scheduler to place worker threads where they=E2=80=99re ne=
eded and
> > reducing noise when CPUs are isolated.
>
> A duplicate paragraph.
>

> Acked-by: Alexander Gordeev <agordeev@linux.ibm.com>

Thank you, Alexander!

--=20

Marco Crivellari

L3 Support Engineer, Technology & Product




marco.crivellari@suse.com

