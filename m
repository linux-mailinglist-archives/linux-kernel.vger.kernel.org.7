Return-Path: <linux-kernel+bounces-844821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 27CFFBC2DA1
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 00:19:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 307F44E7966
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 22:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD35B258ECA;
	Tue,  7 Oct 2025 22:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kAj2GqOl"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32AA617D2
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 22:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759875394; cv=none; b=fN9Y/CAxdfXsGiODmgoUN5ImSmSGgMAfTKwN25yg9ErXXsuT4P2zZ9L4KYGsoy+t9i6tQs7YHk16WsKY/wf1HyMzNu7y+Im6YUFxenuYlpRwfvk5CzStw5H1yitCKSBeCylYbNZKtaGjlnVR8IEULi/zx/+yN2aJp6D1R3J1pu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759875394; c=relaxed/simple;
	bh=pMHeIuQx2q4EHNUQvUoEFemD+88dJQKlLGcjt4nVQGk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=chnvj/yCW2CLBS1l0TrNNTA3djmRpP9H7K3gd3cX46/iJWdgGJp+9WQGaPiWF8O9Fd4ip6Mm55ogc54OtdVzNZ9dbboYGEkrYiwXiEdytFdPF1tlg8DWR4aZ4G+WtENOp+grVZo19Cl/6DLgZ8rmRp7Z6C1iX88ZkBG2TaMRfFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kAj2GqOl; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b3e7cc84b82so1173960366b.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 15:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759875390; x=1760480190; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bjhcAIDF8/EQN2DtNJznmQGOwXEZTQMeZUXrCuISBG4=;
        b=kAj2GqOl6HhgV5mNBcoTW4pypt842MkO02/gULfWx/Kr4vpxUhL5oxbndpxCS5B7Xq
         3nfxJgz6PJF8AAqveUym2jFM28rAAnfY0IsQDZBe1OD4jG3U16IheEvyIcu8TlYJmSnW
         dFRRaO80CQwx8ViXQeF3Z6sSFdJHZeEu86oEQhCxwDbgSpklQsUGM85rhi+oypbItX6W
         ZW4nfuq+P1KddlbJbgGvxN4Wy8UuHwk5JhhiA9a7jRK+3+xpdDrJFK+JNoQQ5tjlCWM6
         aSsdlqBL3ulipU04pkfh0axr5HCg69ZqVxnftNG/FcfiCcvFCWp+uFhhAQ/q7AaBdHcY
         67zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759875390; x=1760480190;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bjhcAIDF8/EQN2DtNJznmQGOwXEZTQMeZUXrCuISBG4=;
        b=Sf/KPAUqsAi/KtKpR7nW2wzVtY7khT4BpUjO8RZZoxqT0A3zoX/+KTh+vqTUq/6xd5
         ovL5lEHZ+m7N5SPzaiN3c7iJ4/U3oNFpfhyUgKz/5ANZF5F+BIe3ForS3bLMHI+L8Bg8
         R7uVRENJcc/8V2YzFbLBj6eR3+HNY8H0XbqPoRBgIKpCJBPY6CPrv7NlOXS3u2SjCc6f
         znDMFb74yy1P/2DYWew4CkkG+n9zbVaaQnewHcf8V7pMBh37wxX1HYZd3kw2UdxZqktB
         y8u3zTA0lxP2YGHmzWcJ38HzMEaL+8+h8s1OFITX/lfcLF2Emw1aLNBxY1Lv8VcJPN0J
         35uQ==
X-Forwarded-Encrypted: i=1; AJvYcCW2NdbZU06cfEhNBZ6HuLpo7smNXx5poyujY9Jar54jm05xlTMdKgXVpjoDiYL0qaLAKXFJ7OPTwmwUX+k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoOjM0/1Swx4Ai5ggMqwQshHp/w9sQnQFwoYwRDmce5FgepOiD
	i4h4NHCeR3D6c/cQFMN+gJGTtIg/UChlr8g8ybS8v3NeDhs3SYHH/5DGReZO8zaMcxM=
X-Gm-Gg: ASbGnctSUdcFvK+u3j+Lp8Ly2nfBqCJvtmt+aRFfPBr8Y+UxVpC3OgXy3cT9/qR06lI
	Aa9dDqnOKhcuPbvx1T/B7T8jHJ6ro3DVdMIy6OC8DS0WseO5xnwnagGOS1MdrhcqRWzxJjdOAXO
	Npn4CIMGMMN/S0i6BwjAfuTle3E26e8FtWzIT2mlOBUC5z1z1USKdO/lJ5xEJ0+Y5fMY9kNZU0d
	Rkvk4zAqnGUjTwwQZ2KBMGJTE0UMVY8FrFcUs9forLp8cUZUX0yrUDAKVAJIK5tUpurIyYiKu7S
	WkyuugiscBLBrDVYm2ZF3PzPt5m9+tIh0aU9sODTrzgtMh/rr6ryxuEINbNTlqcQ3moLl+OZVKj
	sdoYwK/ruEFYFVL6Zi8dcaoVV+w4egGtKzej1McMbNr8Id7Sp/6Vacsk0eQayM64iv1lM7hAqBd
	8ubBiS+DrSxmsDdcK2
X-Google-Smtp-Source: AGHT+IGYcPbzACIE/5EMswc0+sjA3tFOGQiH/oXWXnWgAeZoMqEYeVqq1umjaIwNpexDiKcPAtxL+w==
X-Received: by 2002:a17:907:c02:b0:b2e:6b3b:fbe7 with SMTP id a640c23a62f3a-b50a73c4cd7mr128513066b.0.1759875390421;
        Tue, 07 Oct 2025 15:16:30 -0700 (PDT)
Received: from [192.168.0.19] (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b486970b32bsm1530188666b.50.2025.10.07.15.16.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Oct 2025 15:16:29 -0700 (PDT)
Message-ID: <45eb9c5b-bc8e-4866-bbaf-5afaed9fda21@linaro.org>
Date: Tue, 7 Oct 2025 23:16:28 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 03/12] firmware: qcom_scm: Introduce PAS context
 initialization and destroy helper
To: Manivannan Sadhasivam <mani@kernel.org>,
 Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>,
 linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251007-kvm_rprocv4_next-20251007-v4-0-de841623af3c@oss.qualcomm.com>
 <20251007-kvm_rprocv4_next-20251007-v4-3-de841623af3c@oss.qualcomm.com>
 <qqjynnzjhpe6elglh3xb4ghbtesfkr4ssxyq5flhcy7a5jp6ym@3viy7jyesamq>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Content-Language: en-US
In-Reply-To: <qqjynnzjhpe6elglh3xb4ghbtesfkr4ssxyq5flhcy7a5jp6ym@3viy7jyesamq>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 07/10/2025 22:23, Manivannan Sadhasivam wrote:
>> +void qcom_scm_pas_context_destroy(struct qcom_scm_pas_context *ctx)
>> +{
>> +	kfree(ctx->metadata);
>> +	ctx->metadata = NULL;
>> +	ctx->dev = NULL;
>> +	ctx->pas_id = 0;
>> +	ctx->mem_phys = 0;
>> +	ctx->mem_size = 0;
> Why do you need to zero initialize these fields before freeing? Are they
> carrying any sensitive data that warrants zero initialization?

Mukesh, have to say I don't think adding my RB to this patch is really 
warranted.

I gave review feedback that the above looked odd.

https://lore.kernel.org/linux-arm-msm/9139706a-708c-4be6-a994-120cce0cd0e6@linaro.org

Could you please drop my RB here, and fix the above in your next version.

Also please add me to the cc list for the whole series.

---
bod

