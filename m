Return-Path: <linux-kernel+bounces-892733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3719C45B4D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 10:46:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E62C3B73AF
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 09:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4289230170D;
	Mon, 10 Nov 2025 09:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="AZ299r+v"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7959630146F
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 09:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762767932; cv=none; b=cu3SgSV/NA/Sri++18hPO/dzsDLEL4qqtyTMrPVVC6opGMQl2Q4McBNi5k7HKOVD32PrYJK8sl9ourLuP50m0yrcJ4v8Fqux5AOTYkOCExVqtm6Yf2vdA+RHoAZzO2LFKYmDCz7UmtufG+b47q6GF71o0UuEzsnj95aPaL5+jSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762767932; c=relaxed/simple;
	bh=qnjBiMJkIXLvcN2tQ3kKtwe3MPoSDbfxMzyDw/IYIRE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bW36J39FhI52jZZL+j6cCN4SZBCvLT/Ta7oooKohBhBYAP//f12ZlmjMBelo0Xk8IpbNL5OZaed7Xl5UwwLSmbFwe5Q7IlOl63X1rdjGv+9gRHR83dGz6xD9ccQdnw9eoy3T4lRnYPt/rt/5x2Tn3Y4gwNMc7YhbBYQT5DCvMt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=AZ299r+v; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5942ee7bc9dso2621359e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 01:45:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762767929; x=1763372729; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qnjBiMJkIXLvcN2tQ3kKtwe3MPoSDbfxMzyDw/IYIRE=;
        b=AZ299r+vF5tZeeD9hkfovPHbhl1Vy4Jl4+QSx5dYTrd+Qjo6w7lVRfRJ0lPnql5eMG
         ulEV6tG6zT/8QvmT3kXOcM2FzeewH5fhEn5eC9fd/8fKG9sgoMTaK0SSORozp/0bzEbC
         fVyJwL9A66+ge+Ip69Z/sbfqd7irkd4Ez4lVhybXKrPxdBlfdCdQSydlzv41/8ILRfa9
         yvEmxWjCNaCTdnv6WsUGbfPhRTMeDeFFKz5htmhL2H9tfGxsrrGuXJ7KqqUUW0tLvIz0
         ChLhhpUFPuGV8ZB2KU9cGIygf6lhdRntOc+BMKH4YXGGhExCgMBfeVRqsKC8oRfgAJZ3
         1zrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762767929; x=1763372729;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qnjBiMJkIXLvcN2tQ3kKtwe3MPoSDbfxMzyDw/IYIRE=;
        b=txVJXM/L+rtbtmpFVTeEhxqwsYrqlYMvHoYZWIxOEA/wM82sVdkHDRFobC8EkBPVey
         +Hl4HsrVcvW/w6Kk0xH/HOw6AZrrOi3QmBwBQAbUaFk4ZB8JyrNzNb7zJ7shZRz6u+fl
         dbQFb0GOxLRnjrlsRqrBVT9m0WARq3T7OUN9SsDQHGLiIsftUM9eOcISzY3OMWSqnn5o
         ZtDN/1nZNpZhUPS7cSkWEY3FYNhePqT0BcBZoSTSiWtSV/OXnUPa5rQPaa1gE9ZevXJh
         xR5gPJLUpFBfK1514Q+I5rDALc6k7pUR53/xCf+l0J7tjttw26dvq0++S1g3sc0TyG5O
         gcww==
X-Gm-Message-State: AOJu0YyeegVqodWmb3Dygs/zlvbgOGxPXTAQhS2fnD8Q73d2faE8nxry
	VfVlbnMTfT8XsIXM2fyMHW2Jfcgp0GyFo6o4wdkkWJPz+7wiKXnMhqDZnoyvI+TydmjxYSH37tD
	ol9I2yThmma7cvA3DVSQJMzYXfBNiwai9hFRS9EzzHQ==
X-Gm-Gg: ASbGncv/sfHiqNwHG/6wIVqn2P4u6jgPii1tT9jcwMJM9SSVBhWr7QOSd05BKCH5fc5
	AHr/pTE+i2BNA2enrFLMoPzfkVe5HDOBDMA68I/nP5fcAXzVADXsGVqSi9iicYU9lzf9e5jjcqm
	VHJqzsCZZp5QbYK299cn8d4OezV7R/SgW5ySPUFTf3jJdcbduhU7crHgUZkBTrhRJrdxSw0dyKR
	bCdkQBZ2FsXxPOAGXqDUhVb9WxiRVSWamHAGI1fZ4aHJPUzazpUrhPUaGXXTuN5gOks9j4sbjvh
	DUD2WoWK++ocY+VOoefx6BruGb/e
X-Google-Smtp-Source: AGHT+IEwxaIWXFScRs1Hq0fBmK7fZkWPD+yK0SQzV2/fW2LGNYN/mL1YgGP/C9AUxAvecy0lVYjr0F0QSSJtuF4wUZo=
X-Received: by 2002:a05:6512:108a:b0:592:f315:852 with SMTP id
 2adb3069b0e04-5945f184ad2mr1435238e87.22.1762767928600; Mon, 10 Nov 2025
 01:45:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251105104330.111057-1-marco.crivellari@suse.com> <20251109164536.2ed7867d@jic23-huawei>
In-Reply-To: <20251109164536.2ed7867d@jic23-huawei>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Mon, 10 Nov 2025 10:45:17 +0100
X-Gm-Features: AWmQ_bmdK7CiQUcCbuYW8BTPklves8Rjv8AJG39X1Iz2zDNrUfEWE6A-sfVQUbk
Message-ID: <CAAofZF57ahp4FP_W=fTNwYqEL5y6bYkV+b6G0ScYQm5yQbKTaQ@mail.gmail.com>
Subject: Re: [PATCH] iio/adc/pac1934: replace use of system_wq with system_percpu_wq
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Michal Hocko <mhocko@suse.com>, Marius Cristea <marius.cristea@microchip.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 9, 2025 at 5:45=E2=80=AFPM Jonathan Cameron <jic23@kernel.org> =
wrote:
>
> I'd start these descriptions off by saying the system_wq is deprecated.
> Then people are already on the page for there being a necessity to make
> a change.
>
> Anyhow, I've seen enough of the discussion of other related patches to
> be fine with this.
>
> Applied.

Many thanks, also for the advice!

--=20

Marco Crivellari

L3 Support Engineer, Technology & Product

