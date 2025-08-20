Return-Path: <linux-kernel+bounces-777591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A8208B2DB50
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 13:41:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 94BB34E1B60
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 11:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1476C2DFF19;
	Wed, 20 Aug 2025 11:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dGZ0heH2"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374A121CC71
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 11:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755690053; cv=none; b=ukbg5XaJHfYyyLlb9aK6dz1U4kPNekvwNLFIr2iI1oMhAwHwS+pV6iwxLoV0LvxTUKoa4F1oW8XMiI3UvoPFlL87iC6hO1OzkyHVG396Y68dSHGxcF9gRjeugOJGvEaPv2491uVn/1aCysqiQepP5337xI50J09zO5P3lSbIlAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755690053; c=relaxed/simple;
	bh=JjhHjJfwbaeN+Rcd9I9ii1W+H6PAnjqDFDKeLrmQKQw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=isJIQ46ullwFZMtgZy/CHuI1qA7Ua2TFarIodlqJlE3HbqxzOYdb2z25rJLQPe7l6OZ+LpBRmnTRAjX6DUbjpRRBNGJycJVdXs4mmc0Ba7Mb91CiZSQFQsm6CtHeTVSf1xsYmcFwUik0GYCFUX7rjjm2MfQ+uOLg4k7iNffLYhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dGZ0heH2; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2445826fd9dso75537165ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 04:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755690050; x=1756294850; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=26dVySXraRVWkX1dA4A+YxZnuQpE5T+9coDuoubCcC0=;
        b=dGZ0heH2LQQi8eQAbV8lNOr7sVRFT12WGnSiAlf+QwAeWgu0iFY5yV7YawGTXnVXnv
         y7JfoX6Ndri7vxhx/cc+sA8/FkzmR+3BRttuLUhC91m4h2I+HFl0sIukGtGeT5nZeIWj
         YZmq3CmCcnXAFWoKb9kcGWFMNVSQCdqghm/crh1HqUONJ/TKlktIOXW1PSKKuAHXqOUL
         K9sGj6CK3dP77XC0Fhv17t5+rszpdJt1s+rwm5271pmHgl6Jsn64voBIgLRHfdxVljRv
         tJyqQ7e1CbR1nK7SDvvt4zcAq91YWXiym4RxIymV3zvm+cxZEnJj/+L+Joa3oLYb2idl
         LJtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755690050; x=1756294850;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=26dVySXraRVWkX1dA4A+YxZnuQpE5T+9coDuoubCcC0=;
        b=GR3+wKgHIxeTmtGijd74pFWDAwMWN6TJQfjf7GRpznc528WQhQBRz9M8P/shaia5wd
         luBX2OaS/35kOvAOzHkRk+XNhOuheb9+UlY9TTDd9opnjstLWxJg5UZ1ijZoK1Zy7QXd
         2843Zy0hrYrAwfFgB6eSrbs50Ktl1WPKuVUJCc643HqRIg9F4U3kXl/up1AtUtG7/9Nx
         XT+Wq1wBDRA74cKbAGy3FVMeYoxktrxw+uvSGR9nJk3T+bUr16vL7E11PGgcEZnu6fdv
         KFZkQMqUI1EJxplceJGOfMf00C9h9Bopp8mZmmGYdSwwkELWqYCYX8OEf/+QD8a8xT8j
         +Owg==
X-Forwarded-Encrypted: i=1; AJvYcCVA+yp9CynqcL04uMTPkiNnhJQMyfOYQlwYUbtkI2IrhTln7EDXQ2+9yvFep6xZUUuh8RResDwQ3GuGHDM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzI8u73gaWxMdQHu21hfFytGSSaUigf6Cgzi7/Ykt9w8YIcC+az
	2/VfREXvkZgPPZl/OKphKIVuPh8YYJdoEdFQZt17J6aCPlwf98iQZ53Bh2GpB6Oto0ra7sZOcEN
	Pg+kdAFvdSKZcxXNvvImkRhUyeW3yo4RP1kH0G+ub4InpooUEybW5Dnc=
X-Gm-Gg: ASbGncuVlJVz8MdvVCMSAv4UKobJfDXoGj++EP/VKXwtz8Rw2zfXUTga2ca5tbMuLDP
	Bb8JSCybMa/kEf0bhCIf+m3pJJAVKRkqBJBMHwm/gi/U+SVpGOG1CGK3hG282eS+4qg7HxJImtU
	UoQJ9yfFmmdI8srcap7V8eqimqHJ45rZpo+tvauYfDUzBayHTfnO/n9UZB70Bw2I639hv1KioSn
	siB5RcwTSG6Mp1Wx5jzoVcdi5frqxhDOGYA8idj
X-Google-Smtp-Source: AGHT+IF8AmOWHIAq7OQoSlww7khUMix7+VlH6RDk4aiFzmID1OwQtiwCZOi9WHpVW5C0l6kM2GONs0FeQiAhF1yLTi8=
X-Received: by 2002:a17:903:110c:b0:23f:c760:fdf0 with SMTP id
 d9443c01a7336-245ef25bb45mr33670985ad.45.1755690050527; Wed, 20 Aug 2025
 04:40:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250819122834.836683687@linuxfoundation.org> <bb8ebf36-fb7c-470c-89e7-e6607460c973@sirena.org.uk>
 <2025082058-imprint-capital-e12c@gregkh> <c6232128-6bc5-4f84-af15-43e2fce6d619@sirena.org.uk>
In-Reply-To: <c6232128-6bc5-4f84-af15-43e2fce6d619@sirena.org.uk>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 20 Aug 2025 17:10:39 +0530
X-Gm-Features: Ac12FXwfvMit070C0xIS0xD7Ba2mGdVD4TnOncv3FB6dUHXIhTLgwE-oFgQbp-E
Message-ID: <CA+G9fYua4gFQeXs_SwnRFv=KtAu2o8es7kjA8KRq=KySap1A9Q@mail.gmail.com>
Subject: Re: [PATCH 6.15 000/509] 6.15.11-rc2 review
To: Mark Brown <broonie@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org, 
	patches@lists.linux.dev, linux-kernel@vger.kernel.org, 
	torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net, 
	shuah@kernel.org, patches@kernelci.org, lkft-triage@lists.linaro.org, 
	pavel@denx.de, jonathanh@nvidia.com, f.fainelli@gmail.com, 
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de, 
	conor@kernel.org, hargar@microsoft.com, achill@achill.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 20 Aug 2025 at 16:49, Mark Brown <broonie@kernel.org> wrote:
>
> On Wed, Aug 20, 2025 at 01:14:14PM +0200, Greg Kroah-Hartman wrote:
> > On Wed, Aug 20, 2025 at 11:57:57AM +0100, Mark Brown wrote:
>
> > > # first bad commit: [3b03bb96f7485981aa3c59b26b4d3a1c700ba9f3] eventpoll: Fix semi-unbounded recursion
>
> > I thought the LTP test was going to be fixed, what happened to that?
>
> I have no recollection of being looped into that discussion so this is
> still exactly the same LTP image as I was running before.  Do you have
> any references, is this something that's in a released LTP?

The following patch merged into LTP master and it will be available from
the next LTP release.

syscalls/epoll_ctl04: add ELOOP to expected errnos

Kernel commit f2e467a48287 ("eventpoll: Fix semi-unbounded recursion")
added an extra checks for determining the maximum depth of an upwards
walk, which starting with 6.17-rc kernels now hits ELOOP before EINVAL.

Add ELOOP to list of expected errnos.

Link:  - https://lore.kernel.org/ltp/39ee7abdee12e22074b40d46775d69d37725b932.1754386027.git.jstancek@redhat.com/
- https://github.com/linux-test-project/ltp/commit/e84f0689cf7a8a77478a0e70aa62560f66c3bceb

