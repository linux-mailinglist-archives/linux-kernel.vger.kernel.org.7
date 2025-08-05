Return-Path: <linux-kernel+bounces-755797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B5886B1ABEF
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 03:12:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8645318A21E1
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 01:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E8C3341AA;
	Tue,  5 Aug 2025 01:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aJZ+NV3H"
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 201BF189919
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 01:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754356368; cv=none; b=U5dKiem7nmFZZ0Ua4RjeYQf6vnIId5u5YYnbsbgB8vilW/vRr7LFYvYwlHqyzKEYmGCCCrZXLFZnINGye79A9jJBmplxT55iwoY3+T64Xi3fSCA8bbEJknhpBpT7jbXcfZzIpa+i4qMeBrQEQ6UhluAWSjReJ8WIBT8A7Hf2RXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754356368; c=relaxed/simple;
	bh=IssW0J3YfD78mQWKfR9piPho3y+18KHinlVGttUM0Gw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g+xP8m8vJCM264xmOk3GE79cPZc3zz1G0PHc9p/84pdFXh8o26la5B2znkf5dm5tMDa7ZqYUK4lw2SaZcNshLPQkdjaeWxWTTRRaKm66Ehdu2CmYbo2AQacqKNcjNnYYskKN2tZm8wopNu6IDRZZ81gTM3XCdPlxIFzv0FZChR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aJZ+NV3H; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4b07a5e9f9fso211371cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 18:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754356366; x=1754961166; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1THODX6cXrJgsKrzLiWdmBkVFsg+xvhr1Laebx33cFU=;
        b=aJZ+NV3HrSkt8c0tQsnoWSbrv4Pb4Qt1ZctV0lkpUdWwzTM+25T0J4mH6ojyK5fAbi
         e+2p9MAAd4EYOB5AzAryHYPhwR5P8PsWEYRhIJhhaXV5WKkayV3N0k6KJypp9EYrjUTD
         7kLIpGcZ60mo9NamEGYJ2C3ncGPT2H6LZLtSffX9blrzGTgFjGVW+T+Xqn2UTOHzwOwQ
         BzqeMBOfs/rvSkWKo1opkMMq2lOBcGKtOm91YlMBlELunM/rZjWKa1J5vapkmF3mm978
         +P4g1IsyEuodX54Ay9EUQAPStPJmF/gBh6Z7X7DRWMiV186yGq6mTMl65j9YekxsoT+P
         Vx7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754356366; x=1754961166;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1THODX6cXrJgsKrzLiWdmBkVFsg+xvhr1Laebx33cFU=;
        b=rfAf44zhYlInszEwP1Ou0QmvwPujNfrcJKOheZlLGpCZkx150nM2eGudEY/RNkaOhy
         nbI01O1AxrCRbQHRyXPZJhWbWi3fi08DjQAROpV5NSxtsSRcm1+Rhpbj1gHK8b7HZtXF
         ykWrCslAO8b/cVqmSdajRSFvppiOlV1SAz6Ji0Lt9P+72kxBE6PZ9byUjpTa0wxXsPbk
         1nwRctyp/1MPq9Al4nik3YQjNsMzp2oHhhNK/Q+ieZDym6e1GrmM5DJ4zmH9huTteyga
         NRE05eKabVm83Khm+a9VyFAtIGkhnwqejpBqxQLmOVgp9r8kjtyYzX4Un+1RXg0RH90H
         PWGg==
X-Forwarded-Encrypted: i=1; AJvYcCVns49WVyre3IMIh9/NkqMzvj9nZzHQYFOcm1bLQ3qAs3RIiljearaSkloRGGe7ernN0gbwfy8mNTzYb0s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLgHpao8Tj9EtVKGzD4p7R6xwqfXI20vTuM3iguU8jzs+MKl4V
	Q6jWHSThTH7b4H7ghxcq/FuRygDvw7knjdkQGrmn0NOJVRiV3X7EnW8D4zxIUZCi9MtR0RI2kVH
	e9agba76qKDoUh0YeIR2EIl9w2rI8YWdrJDDP+Jps
X-Gm-Gg: ASbGncuCQqRKZuE/U8v7VqQ8VOFtctjXlJum2ohBZ/upGK+voS8uAMGgPRwLn+FRCJb
	fjjgH26868cWBt/UmZI6rhwKxtyzdKuG4HBplEMyFknuFOdb6ZyuxXYOQDn0SOdYcTlq+WmKf9j
	1h3deMLd3njiiyIfcspasIi8eiAOTQqOCPYGJxs++RaxW5e+EvxckqX3cqa2cgtsQwE0mxWWAZG
	QgmXbKAavtsDsSS
X-Google-Smtp-Source: AGHT+IEyQD2Cezy8/wkC7XfHIjoY6NUMH1DmfY+dK1PsKlX8IdWynIH9pDg2WV4yx3/wQ4+hxzBWtv2hVfDrwdNcDnI=
X-Received: by 2002:a05:622a:180b:b0:497:75b6:e542 with SMTP id
 d75a77b69052e-4b084f11753mr397691cf.10.1754356365735; Mon, 04 Aug 2025
 18:12:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250730032312.167062-1-yubowen8@huawei.com> <20250730032312.167062-3-yubowen8@huawei.com>
 <20250730063930.cercfcpjwnfbnskj@vireshk-i7> <CAFivqmLkLn-92rMow+c7iEADCdh3-DEapVmtB_Qwk1a2JrwwWw@mail.gmail.com>
 <9041c44e-b81a-879d-90cd-3ad0e8992c6c@hisilicon.com> <CAFivqmLr_0BDkMhD4o6box3k9ouKek8pnY7aHX36h1Q9TaT_HA@mail.gmail.com>
 <7a9030d0-e758-4d11-11aa-d694edaa79a0@hisilicon.com>
In-Reply-To: <7a9030d0-e758-4d11-11aa-d694edaa79a0@hisilicon.com>
From: Prashant Malani <pmalani@google.com>
Date: Mon, 4 Aug 2025 18:12:34 -0700
X-Gm-Features: Ac12FXy9xyakfz6nU1zTVwjcHt0kVuVHngyBTkjBFJgF_Kl_APh9mesLw2n5bqQ
Message-ID: <CAFivqmJyYJ+d+TH4qYBKf_5t-AqWZuzgk2H_4nHmynTjoUHnYQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] cpufreq: CPPC: Fix error handling in cppc_scale_freq_workfn()
To: Jie Zhan <zhanjie9@hisilicon.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Bowen Yu <yubowen8@huawei.com>, rafael@kernel.org, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linuxarm@huawei.com, 
	jonathan.cameron@huawei.com, lihuisong@huawei.com, zhenglifeng1@huawei.com, 
	Beata Michalska <beata.michalska@arm.com>, Ionela Voinescu <ionela.voinescu@arm.com>
Content-Type: text/plain; charset="UTF-8"

On Sun, 3 Aug 2025 at 23:21, Jie Zhan <zhanjie9@hisilicon.com> wrote
> On 01/08/2025 16:58, Prashant Malani wrote:
> > This begs the question: why is this work function being scheduled
> > for CPUs that are in reset or offline/powered-down at all?
> > IANAE but it sounds like it would be better to add logic to ensure this
> > work function doesn't get scheduled/executed for CPUs that
> > are truly offline/powered-down or in reset.
> Yeah good question.  We may discuss that on your thread.

OK.
Quickly looking around, it sounds having in the CPPC tick function [1]
might be a better option (one probably doesn't want to lift it beyond the
CPPC layer, since other drivers might have different behaviour).
One can add a cpu_online/cpu_enabled check there.

[1] https://elixir.bootlin.com/linux/v6.16/source/include/linux/cpumask.h#L1233

-- 
-Prashant

