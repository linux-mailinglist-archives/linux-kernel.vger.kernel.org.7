Return-Path: <linux-kernel+bounces-888304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 34962C3A6FC
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 12:04:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C3431345D84
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 11:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ABF130BBA5;
	Thu,  6 Nov 2025 11:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="BqmcGAbI"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD1F2C08BC
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 11:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762427048; cv=none; b=uHjngW1nhcNPLgKU6qX60P9QOOtx3xYg4lhIzB9p7kQM/tHQo3KBgLzs02rOpsZJKvL72ptEh8wydMbN7BcYtodH26o2hBwNROFOxtNfd+2oQB30j8X99b3HoTZlKTpHf4UkD4bwputa5PpaiNl38IfYCQgiFGpqr7oV5UIBEj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762427048; c=relaxed/simple;
	bh=+GeJ8NmKQkLawbH/LMVrmrdydLjiycqpLHBxv2MYx9U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OYnkaVdByHTi2FjMaIZZIFMsXiA4zEwTsXXWMJvyTqOuSGdxLDjRkKk8MR08IMYSnJWnKZ3NYRt+LEHnVftx2xIS0ZwC5+KqDQWXqswRPEEQbreX8cmP+oNsBDVA5svo0n4YPk7L7s990zDeaGBNxFKMBzJMR8ATe25/3TGGMoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=BqmcGAbI; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-59428d2d975so755771e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 03:04:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762427042; x=1763031842; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LyHaZAbJ53jyXeWbX+O1Xs3tfYFAmudzKPogsGg5xTs=;
        b=BqmcGAbI+LT59HfN9ZmXOspf9yAWEWx5uXYAQK/N4OoZA+CDeX3fiH8L9YZT+2ITx/
         C00phDGXeG0uUiV3tFvl1B9wvhj1UH8tA5I9FCAgpRCIpHEgb+QTMFQqimxcgcaZp+WT
         HK0Jn2z8qHu5qQFM0x+XAS0liLZwV4rXLHwExiQnK7n6sWQ20IY2Ffp3vnJad4bOEuTC
         cjhum6UB0M739hq7F1PGkj7BfvPQh3BjmUqh017CTMGjdTN+nx7aT4zIbrSouxNmtKgy
         7yXKZbAQEqsW7bBDan8iFsfh0zyH3EDNgHgqcSWJgW5MVs+/OfzI43Dvfb7Q/QdUQxMk
         Tn6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762427042; x=1763031842;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LyHaZAbJ53jyXeWbX+O1Xs3tfYFAmudzKPogsGg5xTs=;
        b=fu/zcAd7+aRXVnGa1moD/VdsJlDso3YzsTbjNQucbvtRrICd44Xju8SEreWnnHjOYL
         GtWG1H79S7empCS8Hb81h4v7M102H4nLSb22AeE9z+DvokQjle5Uds5KCMdSpg36e26V
         hCm050VJTFrrxbl/CcsqLzbovyDr3kPiNZ1Dwt3im32NrCRB4juahqQpq2CpE1q7bJhv
         KG6tw092sPfwFs155cQUaLeUbiB9/wdqglfz8jjlnsPit4DOzQmrJ0gvdEB1wnXbZLpX
         8gzblKknx9nVKaDKM1YXpyOhehsurWXuyO/YdRw3pcQ2B78lELsTmI3QgoxzGad60+Da
         //dA==
X-Gm-Message-State: AOJu0YwDlAYti81tLAhaXtKM0+GnCVI/YDQi0kmSzEX6/kqHOCdDJUOH
	+77jRAJQYR/aQ8HsO7Z325RKdGEw0legPhvAhr0xLWT0NcJR4SuoFaiSUmLuHiun2HSAeqOPX/V
	Oh+ZrPq1nhU13ix+wQtErXxRsFyxuD1gOaELJUAP0Bg==
X-Gm-Gg: ASbGncvnF3/7/dnvIxj+cbQT64ww4edp9U+WPnmBq3kHbcRUBQ0iv7ZkCEO+rGoUrT+
	cjefITocyKIqcH9uBMhu+WeV7rXexVlHPgMixDSt8gGtRntKsljsHHvSQKFI08Jc4w+9TOknlPt
	uInj6cbsaTElv7Y4qCYn4Is1jwHmBwcZE7IW/jioHxVuDsDWDjJ9aJmMcbGjkwawyW6zzUJUXbi
	ABfDlgfOqeV5F/+3WOWWNZ6fI7OG0KdttTFVu+kXdX7YaHPkGU6T7/bU0VF2z6d+BbOehUXAhSu
	00ULiOZFV2uj+wbydQ==
X-Google-Smtp-Source: AGHT+IHNS+lV8DDaPEBqqaz8m9DQ1tr37iv//49lVHU47CIoDVlu01s4MTSMDavSRxporI0IE2zgko0r5MzlKSRbmvo=
X-Received: by 2002:a05:6512:61b3:b0:592:fb56:f2be with SMTP id
 2adb3069b0e04-5943d7dd243mr2232093e87.49.1762427042386; Thu, 06 Nov 2025
 03:04:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251105160819.302988-1-marco.crivellari@suse.com>
 <20251105162932.GAaQt7bON4FtSmxQ3Z@fat_crate.local> <CAAofZF4fBbFtiKxde2M2ikK4k-LqYVRoavPbNVh-XFiQPmfGvw@mail.gmail.com>
 <20251105210800.GCaQu8sKCjZ9Xcq8-n@fat_crate.local> <CAAofZF4Sdk0REJFearcrB5_MLLQZWaNpecUPV0+BOiNcvmTaWA@mail.gmail.com>
 <20251106104921.GAaQx9MWLfhyqHNDYK@fat_crate.local>
In-Reply-To: <20251106104921.GAaQx9MWLfhyqHNDYK@fat_crate.local>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Thu, 6 Nov 2025 12:03:51 +0100
X-Gm-Features: AWmQ_bkqO5AWnwijQqvBv076aCG27zkaFUfGIMNS6UQEH9zKSWwtFXQwBUx15T0
Message-ID: <CAAofZF7cz_F9qgr7WqbORwH5iMuAO9f0SkWRQxQ4ns4o2X_xJA@mail.gmail.com>
Subject: Re: [PATCH] RAS/CEC: replace use of system_wq with system_percpu_wq
To: Borislav Petkov <bp@alien8.de>
Cc: linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org, 
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Michal Hocko <mhocko@suse.com>, Tony Luck <tony.luck@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 6, 2025 at 11:49=E2=80=AFAM Borislav Petkov <bp@alien8.de> wrot=
e:
>
> On Thu, Nov 06, 2025 at 10:17:18AM +0100, Marco Crivellari wrote:
> > It's just a "rename" from system_wq to system_percpu_wq.
>
> So why don't you call it that?
>
> Instead of beating around the bush and confusing me? :-)
>
> IOW, just do this:
>
> "Rename system_wq to system_percpu_wq as part of workqueue refactoring.
>
> For more details see the Link tag below.
>
> ...
>
> Link: https://lore.kernel.org/all/20250221112003.1dSuoGyc@linutronix.de"
>
> And now all those people who are interested in the details can go look it=
 up.

I was torn between "replace" and "rename", because there is a new workqueue=
,
not only a rename of the old one, because for now it is still existing. :-)

BTW,  thanks for your advice, I will send the v2 improving the commit log!

--=20

Marco Crivellari

L3 Support Engineer, Technology & Product

