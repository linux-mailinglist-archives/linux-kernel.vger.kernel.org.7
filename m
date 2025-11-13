Return-Path: <linux-kernel+bounces-899032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A591C569F5
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 10:36:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D99894ECCFD
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 09:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C33072D9798;
	Thu, 13 Nov 2025 09:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hU7cUOsA"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 786AF2D77E2
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 09:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763026084; cv=none; b=HvYsedPTWJA3xP90F4gSc6pF31S6r6uWxKKa1kDB4e5S6KXNcvaiDltSA1l/TFxDK/174nbPVRbY5qjnxfiOeaY5rE08dqOHajhAAdaa58oUvhjvyPeyIMo6gkNPK5pp8yF+zX/T4tTfUEADOZqqHBUmpdiQAJ5kAkolB0ng6Uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763026084; c=relaxed/simple;
	bh=HMyGCJqQYh9ujkqmTBAdu4RGNFwSTELIZpj6aYBe4go=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GN1x1Vf0GzxIsQUX0qQUB5bQrjGV1qjTwdfh+ajuQ4nFaaM9DS4zaId0NTQUe5K697ZTWlc+oShC57Bg/sj+sQEAwrzgGNuW+I9jLfqrouXhj1UMKzOYBT0vF77OeQiBfgoYJgfFOdCpbQjBapU+u2/MbnD7fCjYkdGFSUcsizQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hU7cUOsA; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4774f41628bso8850105e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 01:28:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1763026079; x=1763630879; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GUQ8rfJZk6stmc9Nrz3QsiJ1sN+nWeofSODQ5AvFLg0=;
        b=hU7cUOsAMH4e6B81GtNyfTRHKV4ib1Hv1JlOZ3xrNriVG+s67XNrQcyRSnZAl0vuX6
         nJt+9+lWMyoHna4b1KEtDnKlhFNfM3NUxfmehzGnO/vAzrE8Sv5Uh4N7cWb3PAlJhKVW
         XGW+G+cVgYexV3gbLvYCQVGfjv745ebCofeKhPvqTKPAEkKoLi7+w9srI2Yu86u6vIlD
         Zp6X1q5dNd9yO7l3Gr4aJO0kB03Wrfx77sq0NIZ64FcJhDJypM9byecx+nIsG+QUQn02
         nL2kxARBNUoZ89Wf0ARRcQSSyxybjSXU5PyAbXksc8zuk4IxFfWDhP7nOWqp8W+fkIvJ
         j/7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763026079; x=1763630879;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GUQ8rfJZk6stmc9Nrz3QsiJ1sN+nWeofSODQ5AvFLg0=;
        b=Jf9m0Je5Ig9S9P9O5X+SbKhYRF5VJvSuIMMcqaz499sucY6nW1ic8V+VfoKTy846Xb
         PI4Xw6pQVq5tzg19mDtBo4zoWzmGOWwGngtEW296VJEQvAJewWp1TfC/CmvfRWfffeyQ
         zXyIqK5wPhZ2hlhtrsPVDVqfZJjIRJyeE/dJAbTrbc4kbYTJsnSvBu2vEVBdVz7UjNWx
         xm8IirdHiDdtxABONFlcLyAlgvBUq26/fzevE1wEqqx6u+jNoMXrq8aQrWS1HwKN0gDV
         UpTDmeB//0BVRiOpQ/xHxnc+Hc3XCTf11Y6zyh6V/0+A6kguQPn9tfwh1dDDmYNfYio5
         b//g==
X-Forwarded-Encrypted: i=1; AJvYcCVOVK6UyGiEBD3KjF/ZB78n1ZghMS/cQeVkC72PfN9fvXtEdknCs468VelBq1SDO7ExCC8C/BCIZlhjJaA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXZ+N+iI9U1ngcuUBxUll9OtSvuy9XXD+ADfaDy9dSwh20nOqh
	MAqF2XJmGUBqhOagPVsvFXJvkhQzp6cPMJjwQT8naLQJXKzNeZGhU6Zx9+BaKfsSUZA=
X-Gm-Gg: ASbGnct2Bmk2NCXnIOQNcMqs4FGU+8sKY4wV5U7VqQTcoH6FbtEw2TJ6L85/pullu6d
	6ob1mxlzNwxPf+Z5LRj5ppwIzFUON+6VJ+Eg0lth0LITwm+tFK0X9pk1fu6DlVwKc8hZk6hc2RV
	XT3xIjugdox4na+8uYlniYP02e18wAZ9VZ4eSK8wTxsGFChIa6FkeOoNro3QLui/hn2e3scatIk
	O23LeBPGogYGpJihBj20xcCUB4OayUI7YO/BBiNiM/XWz+WO0wMGE/T+qRURvYkw/Xt86nJwIzO
	eibM7eQTHn2HiVzC9MdejP/trpiYqH3QjVY+tFUrwtKyARORyeagLKp+4OmauTMUpoVgVNewisw
	8pYeTL4Mqd8wYm6g1rwrGTvrZCmNma1ugraGs1klkGY4i/HwNz6RJoXWk8S+dbCjxzG8Jt7Zv55
	QVxpYODTiIsch7UQLoSPfioVj8xOYANC20sxYwrgQAL+xW+YgOdMym
X-Google-Smtp-Source: AGHT+IHw7L3XGmJDpxEV8oddbi9Yd4/43abEC2dbuAVSkqiGZ0o9fEeGz0V3OqaYUe1ZOfohrMWy9w==
X-Received: by 2002:a7b:c350:0:b0:45f:29eb:2148 with SMTP id 5b1f17b1804b1-4778ca11b6cmr8011965e9.7.1763026078746;
        Thu, 13 Nov 2025 01:27:58 -0800 (PST)
Received: from [192.168.0.21] (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4778c850ca6sm23687815e9.6.2025.11.13.01.27.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Nov 2025 01:27:58 -0800 (PST)
Message-ID: <b1dc3644-8df0-4147-94ae-1cfed835b9a0@linaro.org>
Date: Thu, 13 Nov 2025 09:27:57 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 2/8] media: qcom: camss: csiphy: Introduce C-PHY
To: David Heidelberg <david@ixit.cz>, Robert Foss <rfoss@kernel.org>,
 Todor Tomov <todor.too@gmail.com>,
 Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Luca Weiss <luca.weiss@fairphone.com>, Petr Hodina <phodina@protonmail.com>,
 Casey Connolly <casey.connolly@linaro.org>, "Dr. Git" <drgitx@gmail.com>
Cc: Joel Selvaraj <foss@joelselvaraj.com>, linux-media@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 phone-devel@vger.kernel.org
References: <20251109-qcom-cphy-v1-0-165f7e79b0e1@ixit.cz>
 <20251109-qcom-cphy-v1-2-165f7e79b0e1@ixit.cz>
 <26bc458f-1db1-44e3-937a-f3ee7c1027be@linaro.org>
 <cf9fcb8e-b346-4589-910f-09bbcc58f9b7@ixit.cz>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Content-Language: en-US
In-Reply-To: <cf9fcb8e-b346-4589-910f-09bbcc58f9b7@ixit.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/11/2025 16:15, David Heidelberg wrote:
>> Should be an integer from
>>
>> include/dt-bindings/phy/phy.h
>>
>> - PHY_TYPE_DPHY
>> - PHY_TYPE_CPHY
>>
>> this should be indicated in the dt and latched here.
> 
> Would it make sense to rather use the int from:
> 
> include/dt-bindings/media/video-interfaces.h
> 
>   - MEDIA_BUS_TYPE_CSI2_CPHY
>   - MEDIA_BUS_TYPE_CSI2_DPHY
>   - ...
> 
> ?
Maybe, but surely you need to get the mode of the PHY from DT ?

I'm fine with the MEDIA_BUS_TYPE but, I do think the logic must be DT 
driven.

---
bod

