Return-Path: <linux-kernel+bounces-888335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 03C31C3A80E
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 12:18:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BB03C3510AD
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 11:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2819830F528;
	Thu,  6 Nov 2025 11:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="D9H4oseJ"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5188130E849
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 11:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762427823; cv=none; b=FtljeB0KGT4Bcqb5LIW2Nz4BZvfhV6Ct02EVXdeN70j5Au0bUQGWTbgQG4GFBWt14gQKjmZbwFStOc6qHeBFC5oNCiftTH7YprsMWlLudaLsApuV8zGi7VSgucoHBoIDdfhO2rURGB8M00v5LwM8vi3diBjcuIHsQSp56bI3T68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762427823; c=relaxed/simple;
	bh=5eNc+nOiefXMo/F9DPBs3t4XDeKRYV4z6yHiYx/WKvc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TURF9BWHRCK0nq0xtVvQg9OgAwlB294p0NopFr3N3+b7iLZvV5rcRJ1V9DutNV3G0gK2qCW6QvCeNNoEvYHOXeFccINV5hNOID+1I7OaJ0Ayb1ik6QFnwrER+1M0xB1XGtxtW2z1OoIGk6tghKAn/sR7oTlSTEeel7zQj1TNgBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=D9H4oseJ; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-3717780ea70so9620001fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 03:17:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762427819; x=1763032619; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5eNc+nOiefXMo/F9DPBs3t4XDeKRYV4z6yHiYx/WKvc=;
        b=D9H4oseJ3hO8TyjO4cRGxCR5xfDKVfmH4k+3XcnILdvZS9jZMvOr7m7p43qTdeORxG
         G/DXSl7tuyt7fUN8pueJzPdEJYHelNT1lrA9QiyrFMKDt5F8tDxmDFXkTbmQmCNEGfMv
         r0U5+DPAVBE2bjFhiDe2EZhKnZ8Oh/OEgFYPIVQXMyl4ax53IZpuOMxeW7F5lnDt8Pwu
         qCwi7niJGnKeQoxZglaG/AivUmgG1Vr42DNmdqkdvJJGULMoQuz9MTP3kbe1EUthaCkb
         lK7ABGY3peL0fOmUk/PxiYnE4QrP96LMLjWZYOJINWOpCqSWtU/KPqpcKbP7/tfFufXC
         Ytdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762427819; x=1763032619;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5eNc+nOiefXMo/F9DPBs3t4XDeKRYV4z6yHiYx/WKvc=;
        b=o0JH9ZG3fnUehbN3SteBeEFwoq/dp/U8JOqJWtjmcufe99IliSGZnDRn4EloXkAEFm
         23TrVUF/mh7tFzMVqKcQflvNdmAkXK3XCE5VhWMTiv/nVFUb4oYSkX6OXX6/hOkFvtIs
         byMAPiUJIaLXYN/U4+A4h8AVZZf1QPG/WckfbJ0cuswvDe8cw6Xe8NHyEKvOS86GE4G+
         G2Hy6Cv1xu4iEduv+CYfgqV5R2VOesoPl2N3vIhhccd1lQMxb4GrhQh7vNjWgwSIu3KN
         ws+FDw98CbuV9LlaN9RidudfeF1qXk5P6SXTzQt3qEBix/ZAIarwby+G/slQjqwS0bAI
         O/AA==
X-Gm-Message-State: AOJu0YwEWcxdWCkmtwICzVLY7kINadg2W5EBCk5JuT3IoCouA+3IyIdP
	TVGcEaokFrq07adrY3X/YIJaEzLQlXCygJillZffUhcrukSFRn2I6GX9bQHxb0lSPAJGzZEkZcF
	oPTaBH/qEXwEnDWFupsN5LL0hDFVWXpXJbSObORVXIQ==
X-Gm-Gg: ASbGncvtEI6+DnLfgOg0on4+HkcF4ZuDC0tivnguPs5tv4C/6ZW27Hog6L6R6DG1qds
	N3zewp52zSSuuA63oaoj2wHRKNZPBHqiKX0FrVReTUWaiidUZynUmGS+yBwlKTR1v+ak9NZPsB6
	pcRKi8us5tEzEJ/yXA2T/vW+Xfz3xUIZQzHx6Ho5ppvMmLvQYznikYySWRBZIMIxxhhFvnpkrb1
	MYtl7F9wFAEF5tAal/g1RbRrZhF7gbucXdqbcY0hRhnZF+dk8kciMwDGiZcdHxrskTIQlLEVjfA
	6O6rPq4y7SExgTL00g==
X-Google-Smtp-Source: AGHT+IHYcENGTqvymfQ1WOetN6c+qYHeKLd/0G4rh8vRBzb09b0W5AZ86qMpZX0M21EDepNZjbeEnDbHONIX+WPYXYs=
X-Received: by 2002:a05:651c:23c4:10b0:37a:3260:c8ad with SMTP id
 38308e7fff4ca-37a513e7181mr18653281fa.16.1762427819514; Thu, 06 Nov 2025
 03:16:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251105160819.302988-1-marco.crivellari@suse.com>
 <20251105162932.GAaQt7bON4FtSmxQ3Z@fat_crate.local> <CAAofZF4fBbFtiKxde2M2ikK4k-LqYVRoavPbNVh-XFiQPmfGvw@mail.gmail.com>
 <20251105210800.GCaQu8sKCjZ9Xcq8-n@fat_crate.local> <CAAofZF4Sdk0REJFearcrB5_MLLQZWaNpecUPV0+BOiNcvmTaWA@mail.gmail.com>
 <20251106104921.GAaQx9MWLfhyqHNDYK@fat_crate.local> <CAAofZF7cz_F9qgr7WqbORwH5iMuAO9f0SkWRQxQ4ns4o2X_xJA@mail.gmail.com>
 <20251106111137.GBaQyCaXz4RBMNsULJ@fat_crate.local>
In-Reply-To: <20251106111137.GBaQyCaXz4RBMNsULJ@fat_crate.local>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Thu, 6 Nov 2025 12:16:48 +0100
X-Gm-Features: AWmQ_bkuBOPmW7AIbnSHHhM4OteYDnQbRCEjZ1_1w6q1h8RBmH44fIN9Z7Gcf0M
Message-ID: <CAAofZF7j-Y6mSydny2KtpVX1n5GTKNhu2PE1R7dwB9=SoAzPpA@mail.gmail.com>
Subject: Re: [PATCH] RAS/CEC: replace use of system_wq with system_percpu_wq
To: Borislav Petkov <bp@alien8.de>
Cc: linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org, 
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Michal Hocko <mhocko@suse.com>, Tony Luck <tony.luck@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 6, 2025 at 12:12=E2=80=AFPM Borislav Petkov <bp@alien8.de> wrot=
e:
>
> On Thu, Nov 06, 2025 at 12:03:51PM +0100, Marco Crivellari wrote:
> > I was torn between "replace" and "rename", because there is a new workq=
ueue,
> > not only a rename of the old one, because for now it is still existing.=
 :-)
>
> You can also say:
>
> "Switch to using system_percpu_wq because system_wq is going away as part=
 of
> a workqueue restructuring."
>
> Now it is perfectly clear what's going on.

Cool, I like this version.

Thank you!

--=20

Marco Crivellari

L3 Support Engineer, Technology & Product

