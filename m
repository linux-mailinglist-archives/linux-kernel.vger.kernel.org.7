Return-Path: <linux-kernel+bounces-807848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE6C8B4AA41
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 12:20:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E2A4340BB8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 10:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 716FA3191C6;
	Tue,  9 Sep 2025 10:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Qhyg533a"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0113101D2
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 10:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757413069; cv=none; b=Z62RApYzEm5ZBO03K5DxkPE4ux6S+RpdfOzqHxqIxiBuUGGelDGX41po1v2k3ZsWuoc6gHb0EgmL9oGWdqxEZvhM4lMpHeZSy4B01dywlFKmJOzu2kegoiGx5E6Z/1vOlhfR8wHe2E9xPKOR/Y33+3I3VPyL6wfLTpNJJeudU08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757413069; c=relaxed/simple;
	bh=4ntcZH3ovQ5NlPNFJUOxZaBnGJTvw3YqF3eMuT7MaSI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FfZeurJe9KRauG665Yp4t8C08I9UK/fetL2/irdDgmmuvgRtcxIRrKQpIGLcQLVZtm8UWiVV2vLzWXqlSwlFK1ixGxDwPPLMgT40Vrd/4EwClsUD4363qgTZxZJvB/tzROSoE6pwdTud3HxNwadng1JnRtHy92SPaaU5zGwDGVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Qhyg533a; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-55f720ffe34so7041350e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 03:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757413065; x=1758017865; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yTOjobUwof9Yzc4Kuwjdn4adfxee8+12s83EWKmIV5o=;
        b=Qhyg533aDWddVNipy8ID0IwZyepiC71pEHjEqoXcWG2oVesfi8TdRf4FR5Z1/BAZ81
         Ty9QsqJK2nxGB/Yw7qFIsYvrfQAv/grC0nKse8hSOf/7vL1f1GTjjpG+oO+FXe7JHZC9
         Uad58qJTP3VubECgLuA9jeVWHMpOb8rIoj60JokWxqARPqqnf5gtE3kBZavLx153vL/g
         /VTqpLUebDDO+aUZtn93f32pzCF8Qyg60Q0FEYhyLTbr83yIa3n+vdMokZ30IuZ2rttn
         D7KOKTiCrVdD0HvxhfcVI+crK70GxyVVjRRBjpSdB1fJ0tjBec1+4k5ae7lq5qum2t70
         XUqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757413065; x=1758017865;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yTOjobUwof9Yzc4Kuwjdn4adfxee8+12s83EWKmIV5o=;
        b=nTrbuRHuEcSyRufDi9nSLZgyMQjcL1OMYozVRk03oU4ELfEv6jrxccRJ0EV6bvsKSP
         1G9t/iMUS7uTWetEyF1JcnVNsIIH5QN5xgTf3h2yexqyPQvaACXoQRwahdTXJJCNMg1o
         1X426D7OXGtcEQry5AKYEd7cLihDqhrBoztY7aGpreTq3pBaeNATlVYyWdIFkbM0BbDa
         xqbhLt1mvcZc8LYvV7UxN7wfyXgXTzbJiB/B1rsOiKrAGBiUjE+unF5xVjnFjl9hqYNq
         HV3LF7UzeufmTlH8IrJLg6JmtOita0VpQbT6Kqj4gL9M/ztIQHHNRXdiECcrhXd5cpld
         GnvQ==
X-Forwarded-Encrypted: i=1; AJvYcCWzmFgH0sy0qAPC1gZYCGMRjbfEN8hfx4s3wxFuPCF1SzT+AvzM7IXZ12f7g6R4QohCRMUTxT9uAM3QX6o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8xd6xDoyHhV80+ZwQ366poa311d0HdT+AuiJ80cvPLyOuUr2H
	1rLseWzPjVugtQHNPB+MnabkW74mqFrdr2hWIZLdbDmUEryyTsMNQjqv3E/+5fZEUwrLYeBz4Ze
	UfRo6NZp9XVYZVub3oHi4F+/YRdWzISith6IaBQQm9vmvrff0ZDk4
X-Gm-Gg: ASbGncupf9mu1y8xB7TsrsPI0fOFfV/I3545lHSZMxcfR5f5/p3ao6CYtBlA3H+EZi2
	t1q+fHRfbkyE932iQUjoIvpRFE8ko6bUVBTc9gEPN3y6McM+wR9WTpKaTnBwrAwhkZbzaQrzH+K
	O3y9Jr05SKwaJn2M2hfuLsIvERmZOxSEwOhynuGgcFozHaVAy2gGCxyrxVvpQWwXiPUrhMSqQl3
	qnGvUj+m5DoRjF8gS8+YPkYtRrzqV13gjlGICfm
X-Google-Smtp-Source: AGHT+IEZ5GvUtxsAL057zSJQgyKWUuSzCjwHIwtQd+xWtc7Krr8W40mAfMvFE7TBrYsLihx4TdiVsiDU3knnkx58H/U=
X-Received: by 2002:a05:6512:15a6:b0:560:83e2:1dce with SMTP id
 2adb3069b0e04-56273118bbamr2949736e87.6.1757413065505; Tue, 09 Sep 2025
 03:17:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250905090857.108240-1-marco.crivellari@suse.com>
 <20250905090857.108240-3-marco.crivellari@suse.com> <f672519b-d21e-4576-8cb8-989b95c88f97@linux.ibm.com>
In-Reply-To: <f672519b-d21e-4576-8cb8-989b95c88f97@linux.ibm.com>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Tue, 9 Sep 2025 12:17:34 +0200
X-Gm-Features: Ac12FXz1-AToyo6RC0skU4624VyUlnMOXfyNr8QsqwBYoWNthmfKqMMwnljWEcI
Message-ID: <CAAofZF4FORxsQnqmtK+HcBgvzZrFMCUiWjyttKn39a0zL75WVA@mail.gmail.com>
Subject: Re: [PATCH 2/2] s390: replace use of system_wq with system_percpu_wq
To: Mete Durlu <meted@linux.ibm.com>
Cc: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Michal Hocko <mhocko@suse.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, linux-kernel@vger.kernel.org, 
	linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 8, 2025 at 10:33=E2=80=AFAM Mete Durlu <meted@linux.ibm.com> wr=
ote:
>
> If I get this correctly system_wq will be obsolete and users will get
> system_percpu_wq instead, which means local cpu gets to deal with the
> delayed work and its timer and it has an affinity to that cpu via per
> cpu workqueue. In that case;
>
> > diff --git a/arch/s390/kernel/hiperdispatch.c b/arch/s390/kernel/hiperd=
ispatch.c
> > index e7b66d046e8d..85b5508ab62c 100644
> > --- a/arch/s390/kernel/hiperdispatch.c
> > +++ b/arch/s390/kernel/hiperdispatch.c
> > @@ -191,7 +191,7 @@ int hd_enable_hiperdispatch(void)
> >               return 0;
> >       if (hd_online_cores <=3D hd_entitled_cores)
> >               return 0;
> > -     mod_delayed_work(system_wq, &hd_capacity_work, HD_DELAY_INTERVAL =
* hd_delay_factor);
> > +     mod_delayed_work(system_percpu_wq, &hd_capacity_work, HD_DELAY_IN=
TERVAL * hd_delay_factor);
> >       hd_update_capacities();
>
> Hiperdispatch's delayed work wouldn't get a noticeable benefit from
> utilizing a per-cpu workqueue. We probably settled on system_wq to
> utilize the global work queue at the time. Would system_unbound_wq
> make more sense here?
>
> Thanks.

Hello,

I will check the code and if it is possible, I will send the v2 with
system_dfl_wq (eg. the current/old system_unbound_wq).

Thanks!
--=20

Marco Crivellari

L3 Support Engineer, Technology & Product

marco.crivellari@suse.com

