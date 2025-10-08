Return-Path: <linux-kernel+bounces-845787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 80B15BC61B4
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 18:59:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 035734F7279
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 16:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70FF32EC548;
	Wed,  8 Oct 2025 16:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bVQtLPPH"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F5162E9EAA
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 16:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759942709; cv=none; b=Q1rYPN3t6lRntLcO3WoewcCt2MGDKgMsgq4WOCKGjRfyLlR/0edsojcKaz2PbF4RoihVebslZPnTjj3W2EXn9G5Ax38mt/YwzEcxxlT+j9jmVIhgcGmIwcN7yy6QrGppSXt5J1oiQoASdzJfTbHu1v5FsOIjbAnvcxDnp80ipYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759942709; c=relaxed/simple;
	bh=IjbFp+AAJ0GPQMOTx6ZjwxXhALOLADjgQf3T5Jpj/T4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tc/2m9JqaaUOFgbNVaFdU6b9IUOyeOMAbB/yBTaJmTTA4uqQl8dH1saMlZrBjHkf3M3xelcbKy+X6XNdJl8OAqBX9Emhx3bTnHu2Y6eLNMtxvte0jk4INBXw2+LUDrFRUGEPRAWJIuCouW3x24m4rsGx+shcxcYDwPOzGHLK5Bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bVQtLPPH; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b457d93c155so5470966b.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 09:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759942705; x=1760547505; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IjbFp+AAJ0GPQMOTx6ZjwxXhALOLADjgQf3T5Jpj/T4=;
        b=bVQtLPPHCH4EnjIJ6KAsJGxVNok63vYB3A4A/pOedPuvVuQz6E8ecaZpaOdgxwuY2Z
         k6IMYeiVhk6Y3y+Wjp+lW2Y0GCAUidl9IW4cWg5uUi2fSQAX7cnCHW35lwl2oyQ3afWc
         sD/h/ZMbgJo6e+5NQvac5fP0PHuBZNNyJQHXyldRvf1NkWXleINdRhy2j4qh1U2qIISc
         GDVTt+wWy1t5tD5Yw8waMhAssvhRKYUIp3SSDg8YxwWMJ/VRulC4GvBqyc+powQB+fHr
         Xh0m+MCKwmh9DkWk5d7XUwZ4/K6iYzEuEeWk9wAgh0faoUF7C4AWLL8aJkaVEcyCbLPO
         vJuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759942705; x=1760547505;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IjbFp+AAJ0GPQMOTx6ZjwxXhALOLADjgQf3T5Jpj/T4=;
        b=AfLEth2N6+CWmBrfOk1jK4p8PJos3QDP8kfGanAjpwZX2e4hJAgYtwMarW/Xwknv8D
         6irPmE4Yb+61ZrITV9vyU2zDq0yDp0h9SxTzOOs48II5FZKmNneguHF2lQCi+R0FkDJp
         j3nGyBWJrnuJ8OVvvQM32Ebycn6F3eCgGTFGo9tOyev+oIUyH4qkupxAstrMtJASpCCJ
         5uUPLe7QcBelIWbAEQpeHA0rMemeb9AdMEsSKCoGysW3SFqLn8RhoGUXAmhhdZOsLLOe
         J4l3P8odckLOaxVSYFt8tv0/BZtbvU0SBL1BRh4TMgx+SXyrU4IQhwBs5QPER+XVvQXV
         Tjtg==
X-Forwarded-Encrypted: i=1; AJvYcCU068KZeOHQFOT1fXr/DS8b6Rtm/xXb73oIxf2EiWYOPiFzcuwNYedm+yjcxgbMj2YZPXG/Q4ymGjo74Qk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywi5EEAxjpIRCXSRVs9voAukf/dbXGhJFM0eWS/MTiPuFqhlj2N
	2Ki8e6IU5TMymdf5f3UZBf0Xo9M7Z6KXjJDF1DPtNYTstVHkqOcNjAUxDb79oakiDQbwngfkEXz
	m72r4tene6dxDdgYTdrTghoaGVkQJP88=
X-Gm-Gg: ASbGnctYjL26xPgruDm0HcbAYW95w0YpKNHNgI7gbVZm9ffbwcuPareRqyzVh5pe8hI
	5LCOBNfgu6Ef3qBolyqBIhUJQaLo9fw62P0TPNngR3ELmSIkpASW5MT7jKciR3w9+eFxbl8duJL
	/Fl1ECPJneN24D4EkVCz+vQjbEPTUMexBIYSCP6PTA/jVm7ew2HYesmlnS+gmv4HS2lGP/B+AKB
	ZivhhpmlHUgbbvwbc5CTer03I+NPFU=
X-Google-Smtp-Source: AGHT+IFM8B+yRjNiQWgGuDgYf4XUl4H+hx1IOIfC8pC6J7gmFamfZw32Vs0iDE5FnPT00Hq1ICxP2bzhEgGRBLspIeY=
X-Received: by 2002:a17:907:7213:b0:b47:c1d9:51c9 with SMTP id
 a640c23a62f3a-b50ac4d3a5fmr452540666b.62.1759942705378; Wed, 08 Oct 2025
 09:58:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aOaWpVGZSCY6kN-6@homelab>
In-Reply-To: <aOaWpVGZSCY6kN-6@homelab>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 8 Oct 2025 19:57:47 +0300
X-Gm-Features: AS18NWCT0X_F7IZWKb87X-14WoCCTqsfTJlR0tHQft1sveRDBANcDJ27fz9ygt4
Message-ID: <CAHp75VdKLoCyYHZsEpkmXNJQ5QSpA_crrWR+MS4-=xmn=g9azw@mail.gmail.com>
Subject: Re: [PATCH] iio: adc: Fix pm runtime clean-up in sun4i_gpadc_probe
To: Shuhao Fu <sfual@cse.ust.hk>
Cc: Jonathan Cameron <jic23@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 8, 2025 at 7:52=E2=80=AFPM Shuhao Fu <sfual@cse.ust.hk> wrote:
>
> In `sun4i_gpadc_probe`, in case of thermal register failure, the runtime
> PM usage counter would not be decreased, resulting in a possible
> inconsistency of runtime PM state.
>
> Fixes: b0a242894f11 ("iio: adc: sun4i-gpadc-iio: register in the thermal =
after registering in pm")

This might fix this problem, but it doesn't fix the whole mess in the
probe with devm/non-devm ordering.

--=20
With Best Regards,
Andy Shevchenko

