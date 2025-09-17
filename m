Return-Path: <linux-kernel+bounces-820179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E42BB7DFAB
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:39:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A036F7B0D66
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 07:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34B9E2E2DFC;
	Wed, 17 Sep 2025 07:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bZluYryS"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B726ADD
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 07:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758095514; cv=none; b=mJJCAm1rQC5uOIGUGIsPmzOUN6Ws3gMrB2KpYG4tUtSRrDvM8H5ZLaES7pN9p00qSZsTMl81JdGLimGilZdLsbcIw7dDHz3n2zUl0QlXCXaPXfZvR3KGHKGtjckRfj/N5No2G9FfGp7CZSzDejud90ngrK2M5ktj1VwAgcMi5KE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758095514; c=relaxed/simple;
	bh=tr0zppIKxkHFYdB6TdXnZIHoVjUkgmEVhqgprCOWvlw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hONbNuYFM7S0xffWWgAssQJzDlAtBrT5D+qHzB+ElschSbVpekC9yVelQ5S8uG7ovbNfBO3C1Zf+Izi1TksRiRDAQgigNFybm2tVyUGewbDwA2wf6sHfbsTThjd/1uoEVvLg/xpDDW3MVRv0VxkuJ4pt1+B7bR/b9fKqR8TMaMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bZluYryS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758095511;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=tr0zppIKxkHFYdB6TdXnZIHoVjUkgmEVhqgprCOWvlw=;
	b=bZluYrySy7NjUVlMeBG6EP85H3cacURqyhwvX/NyFe458S1TuiUvef0rQW6k0rPtVAcMnp
	kgqbNmxDnu5IBCFdU9EZQf6dGwrgd9/nuonY5q9NwjwW1NpBVR1aek80lXJaoOU3NvrKJ7
	9BJ1+zGz6TgUKDMgSMUapsUupVGW4mg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-671--I-CxWzmM0em4K_lpOUkdg-1; Wed, 17 Sep 2025 03:51:50 -0400
X-MC-Unique: -I-CxWzmM0em4K_lpOUkdg-1
X-Mimecast-MFC-AGG-ID: -I-CxWzmM0em4K_lpOUkdg_1758095509
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-45f2b9b99f0so4238535e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 00:51:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758095509; x=1758700309;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tr0zppIKxkHFYdB6TdXnZIHoVjUkgmEVhqgprCOWvlw=;
        b=jHL9fvYNWgk7DpAfasZkU4snHnREDmD/6OEuM3ZNncdR4j/DQ7eA0FNy1wDoQix91t
         hhtOj6iLbFji4fpzRooGLoRc+fRtYGR9Y0PMJbDUowyofH3bhq3Bq5MOzjUegujOn/V+
         bVvTxC3F8bEsZ4i2lFNSu1DezYkonEFB+zEiVtw1OyD8nHfHA4GFBhj00TBVQ96dli3E
         yfKDqeHn7Yi8eRezwdhzIBRDMU8HEqhQlFIy8hXNNk7TOtYD6h4mRbnMAQjCSsbMGldR
         levyTnvdoH5QtnLYSwgqYBnQPmWmqKOKfb3/edmFVpxz4qWO33R/risNYWEEFKiC1zK8
         ATLw==
X-Gm-Message-State: AOJu0Yxxt1EnFE9kxOvPsLqevf7jxNqAUzaWW2eldYnrpL3oiumJo4Ut
	htD4jegL2MjIvXH+OIGSLnlV7hHKh//U5s+1Qtf4JX9/GS3cq1FRgwP4/t8GLLepi/j+zKquXdk
	URInDwqqfo+tsysyXWfF+k6fsPX9AYj5rVwEG8EwC8Jo6VQlqfqInekRc/sNqGOTgYZ49mfZ+hW
	Se
X-Gm-Gg: ASbGncvkIIv1t3niAkau4V0hrYYnofmeFFCfoF098eFQB5EcasKlOrqzZ4hupVZ3W+Y
	/O7NeqjY7Gd816dXLu0ExPHZ/ImjXbOcQlMxiUk9yI+uunOcYZnjmvjW7FMcTd5wArQX6ssDZ0U
	HzaXux7iPqRs5DndneaqrpjdopD/oY2XwfDPAXqy8QardBlq5kY5V8WN7Nc100fHhfKS4v3oRm9
	3tPeBTNvcHlsub+3FIymMrB3L1MHVls2JcxvbxYIJuDJRRtwlE15jdAUKRjn3EpiiJirDGVyTjj
	MQREQA64hwanhJf1sY8yY+eVFhSePGAzZIzhXfbfFktHJBMafAhxwHyQHFzSrn7ArA==
X-Received: by 2002:a05:600c:4194:b0:45d:f680:3140 with SMTP id 5b1f17b1804b1-45f32d00275mr36902325e9.2.1758095509187;
        Wed, 17 Sep 2025 00:51:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEyBWttLmmoW2Rdao54xB1Mzs2OxtnnDqvmSaNRLJA2ANoccn4Qd8GhOipM07vkBK2FEqKmTA==
X-Received: by 2002:a05:600c:4194:b0:45d:f680:3140 with SMTP id 5b1f17b1804b1-45f32d00275mr36902205e9.2.1758095508769;
        Wed, 17 Sep 2025 00:51:48 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.30])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46136daf54fsm27865465e9.5.2025.09.17.00.51.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 00:51:48 -0700 (PDT)
Message-ID: <6aeda48661359eedd232c9bb0c337d93c36dae70.camel@redhat.com>
Subject: Re: [PATCH v12 8/9] cpumask: Add initialiser CPUMASK_NULL to use
 cleanup helpers
From: Gabriele Monaco <gmonaco@redhat.com>
To: Yury Norov <yury.norov@gmail.com>
Cc: linux-kernel@vger.kernel.org, Frederic Weisbecker <frederic@kernel.org>
Date: Wed, 17 Sep 2025 09:51:47 +0200
In-Reply-To: <aMlJqDjWNyak07LX@localhost.localdomain>
References: <20250915145920.140180-11-gmonaco@redhat.com>
	 <20250915145920.140180-19-gmonaco@redhat.com> <aMg5EzmxG3hG7aJK@yury>
	 <820443ea-56d7-4fd0-9535-b1339e53240c@redhat.com> <aMhcYCCJDFWoxcyw@yury>
	 <aMlJqDjWNyak07LX@localhost.localdomain>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0BrZXJuZWwub3JnPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmjKX2MCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfIQuAD+JulczTN6l7oJjyroySU55Fbjdvo52xiYYlMjPG7dCTsBAMFI7dSL5zg98I+8
 cXY1J7kyNsY6/dcipqBM4RMaxXsOtCRHYWJyaWVsZSBNb25hY28gPGdtb25hY29AcmVkaGF0LmNvb
 T6InAQTFgoARAIbAwUJBaOagAULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIXgBYhBMrKEfgLgd0WcK
 eo9u9KbElYeE3yBQJoymCyAhkBAAoJEO9KbElYeE3yjX4BAJ/ETNnlHn8OjZPT77xGmal9kbT1bC1
 7DfrYVISWV2Y1AP9HdAMhWNAvtCtN2S1beYjNybuK6IzWYcFfeOV+OBWRDQ==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0



On Tue, 2025-09-16 at 13:27 +0200, Frederic Weisbecker wrote:
> Le Mon, Sep 15, 2025 at 02:35:12PM -0400, Yury Norov a =C3=A9crit :
> > On Mon, Sep 15, 2025 at 05:02:45PM +0000, Gabriele Monaco wrote:
> > > 2025-09-15T16:04:53Z Yury Norov <yury.norov@gmail.com>:
> > > > So why don't you pick the original patch instead?
> > >=20
> > > In my opinion, the /juice/ of that patch was included with [1],
> > > here I'm just adding part of it.
> > > If you prefer I can pick that patch and adapt the commit message
> > > to reflect only the part included here.
> > >=20
> > > [1] -
> > > https://lore.kernel.org/lkml/1706509267-17754-3-git-send-email-schakr=
abarti@linux.microsoft.com/
> >=20
> > Yes please.

Alright, will use your commit in v13 while changing the macro name to
CPUMASK_VAR_NULL as suggested.

> And can we rename CPUMASK_NULL to CPUMASK_VAR_NULL to avoid
> accidents/confusion with real
> cpumasks initializations?

Note that in the linked commit message, you have what I believe is an
incorrect assumption:

> So define a CPUMASK_VAR_NULL macro, ... and effectively a no-op
> when CPUMASK_OFFSTACK is disabled.

According to what I can understand from the standard, the C list
initialisation sets to the default value (e.g. 0) all elements not
present in the initialiser. Since in {} no element is present, {} is
not a no-op but it initialises the entire cpumask to 0.

Am I missing your original intent here?
It doesn't look like a big price to pay, but I'd still reword the
sentence to something like:
"and a valid struct initializer when CPUMASK_OFFSTACK is disabled."

Thanks,
Gabriele


