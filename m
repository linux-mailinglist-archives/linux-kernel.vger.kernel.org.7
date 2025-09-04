Return-Path: <linux-kernel+bounces-800689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2009EB43A94
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 13:45:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D2DB1C26200
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 11:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 361502FB626;
	Thu,  4 Sep 2025 11:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pVjP882H"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE452FC869
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 11:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756986209; cv=none; b=WecbFhMC/knYgD3KdC793/qKW2mbMqJivmxT09MZ4WBSKOBAX5JLM5cyOQIeYdCK+iyQofCyX345P5PRSN87LSh9LEutsiwLSF/RH1Wf6TtYQ7rgwT6WjU/iGQVQihG/+5CRMFTq167vXKZJgd9MYjrV+YhciUMLxV79sHDw8WQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756986209; c=relaxed/simple;
	bh=muiz7naDGEkZ3ifHiHEdACkPE3MonaLd2fMm6LWbdcg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 Cc:Content-Type; b=KCyiTB4bMH3ulHWwT/83aKNaVwoHCrqS0sLDH2RnEWFZviHQTljCNSdC1qMHrVN3OhzLN47Shjb9B2zOAFiEGj/BkzCXl5MXkBYV5rBxntu1Oo+wXzxE6oYIED1lLFDNUcRdhYcDEU01hZIp5zefn7kcT2r21VCji9Y6GzD1ST4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pVjP882H; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-24cb39fbd90so9125755ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 04:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756986207; x=1757591007; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=muiz7naDGEkZ3ifHiHEdACkPE3MonaLd2fMm6LWbdcg=;
        b=pVjP882Hf8ZlGsgSpArkl7Bq9IGsIq0IAQePi89hK8du9kVG12bxJUBMKevDrxIHVV
         DUolbDorqRwooUfrYao8NlwCNW0e3IpDUO25yEwFQ9oaQvy+SNbpkEEso2YTWtX3MdAZ
         tMgWcSkZ6t9EYwGMguehljHSYEgcFBaKIAWZwkFCZ8i+WqQsJiiHNLYlKb5dzFiVwLae
         OUcEkJkd72oVRu6PMY/1gst4Pz3A9HMch6eyNuY4G9rvgh3JOlHDrTokj7ECoW0eaaic
         5uQpU8rlbIkoSnH+EC7DjWtNIHk5pxZsMcs7BYsfBpkZk44YYiR+phNwIxGQQLC/ehDv
         cJnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756986207; x=1757591007;
        h=content-transfer-encoding:cc:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=muiz7naDGEkZ3ifHiHEdACkPE3MonaLd2fMm6LWbdcg=;
        b=b7KBICY7M0iwXVnALF4zDpWOC2tHNqldNb33+XZvzL76UjPLA6nzKyYaDHqc6HN5t1
         voacWFr/y0LZMbLCt+10gxk9vQQqhRtVBfd2PcGZSlombEyvmVBQU3TIfwBltuHIL8WH
         jJi3HUsauKNV26kPvErgiMwhdhVvfAEDafnhmXe26wonBeH680kcaLppBWT1xIdIcG7C
         KiVO5rGuyhgX1ikkb+IQ0dxuOJycvdlNs1PJpckMpQfbtvTtdYW6CylhBru7k88s/jX+
         dUZt09afQpvvtM9kei7CTDHpaZO1JLzgTaiQcWpAz8IareJ30JrQy7TSkkIJm3MLgwZ9
         MgIA==
X-Forwarded-Encrypted: i=1; AJvYcCUTMFzf5bWviAUqk53TVqNzkucLigicEA6APOZQ9fgrgBkLH8ePhimNnAZ9D+om10ytN1t0qJ7OT07fucA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcQ5dUMvAW7t9nxI5f26/rnTnOqJe+RVDr6X6qgVCRVD783+yL
	GQ1SdHNqiWc7Q0dNezifZtLoeQ+DJ212dKq6xjlfMIPjwocslWO8643xKFoVP1vjRQSZ/cbP4Z7
	V2O0HPFcdnMhutU/1AudHvGzGj4ZXtax8ZiJTK3eD
X-Gm-Gg: ASbGnct6EPucp37eiR9VkbgugA4abfQyFHz8ITi4A/Onfz8qraSro1GzaLVwEMbwCwJ
	CGXdTjy29mMEVbSBaI0HaD+m9bWMvroNI5SBi2OeaSSbFeNFNnKMQMbKF3CQeuaGNMLjb8Am0w2
	h75QPUub90QcY9hyLuau/bBXLYW9Rmb6SAel1b+iq5I2n9Thzh7B/za+HlW8frTbJS6xk/UGVJ0
	uFNRnKibsok5VtSYQy4hrORWmP3/cXLhn1ZJQW/F63hYG9IZ/pF
X-Received: by 2002:a17:903:2a8b:b0:248:fc2d:3a25 with SMTP id
 d9443c01a7336-24944b0da8fmt258366925ad.38.1756986207111; Thu, 04 Sep 2025
 04:43:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250903092754.2751556-1-abarnas@google.com> <20250903092754.2751556-2-abarnas@google.com>
 <aLlEOYZqT07r6G_V@smile.fi.intel.com>
In-Reply-To: <aLlEOYZqT07r6G_V@smile.fi.intel.com>
From: =?UTF-8?Q?Adrian_Barna=C5=9B?= <abarnas@google.com>
Date: Thu, 4 Sep 2025 13:43:15 +0200
X-Gm-Features: Ac12FXxEQX8Crqr8PV1pxbSjW9Mcxxq96iJ-CqMFMybLuuhBwuzyFNki_Fu1js8
Message-ID: <CAATBrPEMuoVQwCqycrZ14PsNH4u+Di+eycAofObb=8kS9dpvfQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/2] staging: media: atomisp: Change name to better
 follow its behavior
Cc: Hans de Goede <hansg@kernel.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Andy Shevchenko <andy@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dan Carpenter <dan.carpenter@linaro.org>, 
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-staging@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andy

Regardless commit message, is the change OK and can post it as a
patch, or similarly to second patch it is not worth the effort as it
will be refactored at some point?

> Change name to clearly states what function does.
Proposed description:

staging: media: atomisp: Rename `inv_subword()` to `clear_subword()`

Function `inv_subword()` does not inverse bits or subword and neither is
inverse operation for `subword()` function. It is used to clear target bits=
 of
move_subword operation (specified by start and end-1 indexes). Name
`clear_subword()` explains the function behavior better.

Best Regards
Adrian Barna=C5=9B

On Thu, Sep 4, 2025 at 9:48=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Wed, Sep 03, 2025 at 09:27:53AM +0000, Adrian Barna=C5=9B wrote:
> > Change name to clearly states what function does.
>
> The Subject and the body of the commit message should be more specific.
>
> Missing blank line.
>
> > Signed-off-by: Adrian Barna=C5=9B <abarnas@google.com>
>
> --
> With Best Regards,
> Andy Shevchenko
>
>

