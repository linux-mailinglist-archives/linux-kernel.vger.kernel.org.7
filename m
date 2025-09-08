Return-Path: <linux-kernel+bounces-805252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DBA5B48609
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 09:48:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B146716400D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 07:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2389526E71C;
	Mon,  8 Sep 2025 07:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FOGG8cOO"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B1123371B
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 07:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757317610; cv=none; b=lLWrVcKX7FTmwv/DXH1JVXRhq1Ck+u1sa0E2Cpm3vMyYK/DeVqdnkB1O1BjgrZW0RR0/actUi10zjonj9B3uD8/w+MidKSflCTiomHqODRZH4obGDii7NTJzfkoXr6U4C/L1Awbg1kfIf6Plr7rqGNT7E43v9hGPDVU9acGd4fU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757317610; c=relaxed/simple;
	bh=ZcFAyaemeAk8JLn7DChgM2B0OJSSjzqszGRTvZ5/O6E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FQpmO6rqVTq2I0qHsaIviHRo24xvOF/3D5rzwSPCegeAD5SK2w+LLIxMNrEcEUbRc2F7fJqcetqcYUyZJmsI9tth0yr0zmvrx2bgSHuim9khk7ZrhYZ0/L+6JVBlQiVbleNlEHTsVOc5KQ31cYidMpFcSeMi74PUtu/Fpsw0URc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FOGG8cOO; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-45cb5e5e71eso19553285e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 00:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757317606; x=1757922406; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VNAsSRzsosPIy3ZkgGv5CY0H+l21flmMwlSKUZ7UsXk=;
        b=FOGG8cOOVsCah8WwvN9CDfBgQcnbfhJgdW+kEDW8Rvl5uZA1y+Z4nnbsruvLUwZean
         50pskndfX7jyFWWskMhYJkgDrdvEHXMOiUJxas0+iKhFpG4waElycPoX71lUQRI2uNFE
         7fuvzk3n1Y4DlolGRMS7N9hgM/gKu4pWZI6elgjYkX+Chw3d3vDoUluN9vD0C3l4qeUT
         uQcPymnKRTg5qzwRFTb90EkPpndNCFNKLiKVh+E2yNmDfDgdd0RJZvSpT3EFJ7uAFV+A
         gYhPhqzNyoSA1KscsD5e46VlyxqRK7MTnXiOZUFE3FwBLrTReReOX4hEognVrw5zaS4i
         vRCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757317606; x=1757922406;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VNAsSRzsosPIy3ZkgGv5CY0H+l21flmMwlSKUZ7UsXk=;
        b=Pz3LG2REylv+WAbLvkwu8Kfol+Dl7wDDkUcUp6mKe57hJ4qxgybyi+zEhxZtuuyh5s
         wWzjtv6Z3fX/p58bkw1qvMaNIfTHTOAGnz+hV0s/G+Kqs/eCSEBSU5sRXFxOcqoFPNYl
         cVWU3aBOKXxhTr0yB6jpX75xxU9tY4VjZilO7FXsMkBnmhVyFh1wIFfVzu4ZzQP5vf8P
         0NwgMiSFnYxZxajAh/2IfQBBHMhG+s7xdvOJxjyRZ5Yn4cgS9swGOHdWJ4e8bjLrKByU
         +YrdwGbWvcWUOehG7R2UwO3PkQ9Mvo+bY9XcgORh6KK0Wq5+u6dLYqcfIGQhIvWikwUD
         QB8Q==
X-Gm-Message-State: AOJu0Ywy5W1VpYViQX7OlSEK6uoucY3atgo4DA2WE/b7RRWlm+Wj1eZ0
	oe5w73yHnIoc5p1LbdDLa8c4IPVZt8t1RAWkPgcgA/uqRkSf3jQIhdAYFBDFPemrdzM=
X-Gm-Gg: ASbGncu/esfNtW+0/c3cw54MQSv73GUQwkMAFqU0O2/0QVoz0tyVMHgHc++gizHRQ7X
	LQdtZg7DSs73+n2ZhBJGrMxbT6zR6MzFtVGGbbsdvFnFN6IU+OQvjowhUxqcC+85GMcgEXGx/x6
	TqHXQpR3GFBB9P1YUex/8JpklsrXLXf8K9CaqLXcT5rVRxOJge0JlI4s6/1NfI2fbOBgFUFwvDR
	YCuAfPgGXzgaGl9TF5yxAwWqmMWp6zI4+WPENHrnPKRYo+OT29KPLZF2h6NjjDnxU87zfQYeLRh
	RWLDKgydvApt4T3PKcFHeuk3eBUXT25I6P8UjKatVVtJKDHFY1ZMtDk3uWis50US7SZK25O0gmO
	sIaO4QdYjNslY1NqvyrQCXk9y8mf0Tml2
X-Google-Smtp-Source: AGHT+IHn3jMawLrugAhLgtdrDjKbbgNOsVBJuZ/1bwRiJ8MlERu9wdEB+XckTY2iI9k7tkZoET5gag==
X-Received: by 2002:a05:600c:4744:b0:43c:eeee:b713 with SMTP id 5b1f17b1804b1-45dddebfae0mr61565605e9.20.1757317606013;
        Mon, 08 Sep 2025 00:46:46 -0700 (PDT)
Received: from [192.168.0.251] ([79.115.63.103])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45dcff67787sm181785435e9.16.2025.09.08.00.46.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Sep 2025 00:46:45 -0700 (PDT)
Message-ID: <33e80e92-d68f-4919-b535-e76836fbabd1@linaro.org>
Date: Mon, 8 Sep 2025 08:46:42 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/5] firmware: exynos-acpm: register ACPM clocks pdev
To: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Peter Griffin <peter.griffin@linaro.org>,
 =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>,
 Sylwester Nawrocki <s.nawrocki@samsung.com>,
 Chanwoo Choi <cw00.choi@samsung.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-clk@vger.kernel.org, willmcvicker@google.com, kernel-team@android.com
References: <20250903-acpm-clk-v3-0-65ecd42d88c7@linaro.org>
 <20250903-acpm-clk-v3-4-65ecd42d88c7@linaro.org>
 <700967d0-ad8b-471b-b2cf-6544727db26d@kernel.org>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <700967d0-ad8b-471b-b2cf-6544727db26d@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/6/25 1:20 PM, Krzysztof Kozlowski wrote:
> On 03/09/2025 15:56, Tudor Ambarus wrote:
>> Register by hand a platform device for the ACPM clocks.
>> The ACPM clocks are not modeled as a DT child of ACPM because:
>> 1/ they don't have their own resources.
>> 2/ they are not a block that can be reused. The clock identifying
>>    data is reduced (clock ID, clock name and mailbox channel ID)
>>    and may differ from a SoC to another.
> 
> If I understand patchset correctly (and your cover letter supports
> that), this does not depend on patch #3, so please move it before that
> one, so both firmware patches are one after another.

You're correct.

#3 depends on #2 and I thought you wanted the minimum dependencies listed
somehow, so that the clock subsystem doesn't pull extra patches (that would
be #4). I will move #4 in between current #2 and #3.

Thanks!

