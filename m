Return-Path: <linux-kernel+bounces-833881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87304BA3476
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 12:05:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DB071B274CE
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 10:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A928428C009;
	Fri, 26 Sep 2025 10:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qYlQVQQ2"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD9826AA94
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 10:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758881140; cv=none; b=DYlch0xcoOSasjBKYmDRZtffxnbz8Ql24hcBSfd5LeHh2maXPD+9qELSBzG9v2D73x23z0S4Is/76U/V6jQpCerqlTQs83mzp37jkmqyA64Pkm1E1YXjzsyB7tzco7LhkrPrWWcwUlkj5te0Elj8/RqquDONJ1rgltRqc/+ox/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758881140; c=relaxed/simple;
	bh=3REdHx/KKotzvl8TMWA5jPYSfqjRSnb9uCS5jUDAMGg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r0adSJ5Gni2VMS2qGt62wR8NyMompHXTtPLVZNxd67KAPRJcWMknmE4xr+MLca4/dE5x74CQStP/J7ESL2UCoyGg/Fys268F2fCzyMCPC9dQG8NrysT+508vwijE9UAQHXo85pLvmqhq5rldgBAFiQ+JbAMUyBJowMk8kfEBZcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qYlQVQQ2; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-329a41dc2ebso1558279a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 03:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758881137; x=1759485937; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=miMbC+wFOoOlKiV7MAf6dHd1ZDQUknKrGY0xfQXgt9Q=;
        b=qYlQVQQ28wqbXhurE4h/JZowpGS8BWWrDtQHAK5OetmN04nkpVviEPMA+s9b0oF2zD
         81cnh2cxl2APg5fn3BookcduCETQ7m1N3lnd4mB7beFvo8osEkYLKeknAtN1D9MezE1h
         E0haFS0Th0NGR2T7IRtGJDqtBbvO6poIjeLkzlXjyBxJf8iwocVvYtZccRB4yfA9Oc8S
         3TjKg7gItE8ei/pR/9rY5+T0huv7MrBDpAiTHAqKiRWH8jr9qJp20AfEU63SiFjdN2B9
         r9+3u1UYMu1wjMiu9w1aywXXzqCUfTAIBB4bRfU2qsMm/IDAsWmQh4xidt7NtS0H+Xnu
         k5fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758881137; x=1759485937;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=miMbC+wFOoOlKiV7MAf6dHd1ZDQUknKrGY0xfQXgt9Q=;
        b=nGKoDWLJWkcO02fKWkBBzwmJS6Ptg9BicZCjqetW5D5yilpbI/5XMLyukUdaX52U9v
         DPFr1hThaqOrW2sSX9L9NgqVZWTZcF7dL3QK1rpZm6r7zHkbhXStPvreivpdRHH58/BE
         +PuD26RCUcJe2qmfVEJHOYWVBuck95FEjL9cbLtmTpJTaxHOK8Xt8tUfFpr+sFfBcULb
         uloPs01b0fNn0dxRPqumDCRYuBAw6N7qTlcDicQbbegKlV9zpoB85WG3lyfj4a2IzH0y
         gf8u447Eqy/1ks1shtACCvgDpIVRwImqc1mkSB2s4xCAE5E9Ax/TjhrsvYdmFoMRP4zo
         gWNQ==
X-Forwarded-Encrypted: i=1; AJvYcCWwq34ry/SM6p+Mk3GcFX1Tq+EvA4zH3wfXgO9PlJsu11+Ervhm71HOpFjFrqlwjpI0hH5XqjlMyDME32I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIrOz3p0VWMOIARbU2nvTH9olZwHoziZowYMhNL5Zt+Cc7hCzj
	vrHEmK7W5BUZgTCuJEVI29USm/Af5jvB/lFOldnDIyW1XpS5eOxBJ1A005ymRPh35e0Vs20xwA0
	6HW8n97WJ5B2ZeYRGBwPhQEXIJTP8W68rrKIaX+j/8g==
X-Gm-Gg: ASbGncs9AuoCMOZYEchEbV7jM8+PWFt0+7ir72m1GX4OQ7jxkxE08a11MpFzs5uJ+Lm
	x7VM7rBeCgIY7DW4Ou3LApEeCgRBExSXYZ1A5mz5+yKWmDCCySp4lumM8YoryxxRrXGZSGHfF4f
	v2EOqNre5BnxB7YXWHs1IcheaSSG7rH70I5Vqgff7tZ7+pPWiI984F3dTAWwj7Smf9RxHw8Cxtt
	d6XCWTt
X-Google-Smtp-Source: AGHT+IEMalXyUAnyGSz62XZRT5YFJWbI5kdvTffoImyStrvRVjF3+40V1XYpBrzribrK2v+XrhzX3WPi4NoLw9+2PrM=
X-Received: by 2002:a17:90b:4f8e:b0:32e:7270:94a4 with SMTP id
 98e67ed59e1d1-3342a22f5c5mr6887375a91.14.1758881137573; Fri, 26 Sep 2025
 03:05:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250922-fix_helper_data-v1-0-905e8115a24e@oss.qualcomm.com>
 <20250922-fix_helper_data-v1-1-905e8115a24e@oss.qualcomm.com>
 <874isuo0m2.fsf@rasp.cworth.amperemail.amperecomputing.com>
 <f7be3833-9b33-4935-b821-a2e0000a2557@oss.qualcomm.com> <CAJ9a7VjaUE+iy=FFwPhCdfXgoGR3rP9WSx-ZkKYeCHhqJ2yzMg@mail.gmail.com>
 <3b16607f-8995-46b1-aecf-c6aa79f66f9d@arm.com> <635ba698-d7a9-40d0-9285-4ec108d4a536@linaro.org>
 <20250925160440.GD7985@e132581.arm.com>
In-Reply-To: <20250925160440.GD7985@e132581.arm.com>
From: Mike Leach <mike.leach@linaro.org>
Date: Fri, 26 Sep 2025 11:05:26 +0100
X-Gm-Features: AS18NWCbpLCP6YCuwI_-fvwo1ZyLR7pxEbvV2zcB8LL4Hx314A6kIEBoWPgSxQk
Message-ID: <CAJ9a7VgvWHO5h9-VbSruAqLfgocbkRjzsY+THPHVbJT2OXUO1w@mail.gmail.com>
Subject: Re: [PATCH RFC 1/3] coresight: tmc: add the handle of the event to
 the path
To: Leo Yan <leo.yan@arm.com>
Cc: James Clark <james.clark@linaro.org>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Jie Gan <jie.gan@oss.qualcomm.com>, Carl Worth <carl@os.amperecomputing.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Tingwei Zhang <tingwei.zhang@oss.qualcomm.com>, coresight@lists.linaro.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 25 Sept 2025 at 17:04, Leo Yan <leo.yan@arm.com> wrote:
>
> On Thu, Sep 25, 2025 at 11:10:51AM +0100, James Clark wrote:
>
> > > > I would suggest in the csdev (coresight_device) structure itself. We
> > > > already have some sink specific data in here e.g. perf_sink_id_map.
>
> [...]
>
> > > I think this data is specific to the session we are enabling the
> > > device(s) in. e.g., we keep the trace-id in the path.
> > > So, I don't mind having this in the path structure.
> > > Instead of modifying csdev with additional locking from "etm-perf"
> > > it is always cleaner to handle this in the path.
> >
> > Yeah, and perf_sink_id_map only "needs" to be in the csdev because it
> > controls sharing IDs between multiple paths which can't be accomplished by
> > storing it in the path.
>
> This is a bit off-topic: do we really need to maintain an id_map in
> every sink device, or could we simply use a global id_map?
>
> I might miss some info; anyway, consolidating trace IDs is a low
> priority for me and not critical to this thread. But this might be
> benefit for later refactoring.
>
> Thanks,
> Leo

There is a limit to the number of IDs that can be used - using ID map
per sink means that IDs can be re-used in different sinks.

This was added to overcome this problem in large multi-core systems
where there are more PEs than Available IDs.

Mike


-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK

