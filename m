Return-Path: <linux-kernel+bounces-855370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E9FFBE108B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 01:32:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 869B619A6CAD
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 23:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D34E23176EA;
	Wed, 15 Oct 2025 23:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KpVCN8fg"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 518102FFFA1
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 23:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760571142; cv=none; b=rd5R5NRRy46kVeP95W9rk2EXSFSMh38UJibhS+XgdcK7fWhrXTekp8mABt6MtZltOwA5eL4Rs3syd8FvOPEJb8CAPikdQn8RfK3FO6Gk4WncRVvZgZ192JPcYB4ZSy1MgGduuxrscDLqUgWZ9DGvd3keXNMrN+TF8GocpTwSrNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760571142; c=relaxed/simple;
	bh=E+hpu09ROQFdd1Em57oWayPsfVLzQBtFlkrFf6LFmYU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fOwmE84QjQL9Afk+qVF56JpjbYlM8EasehN59mxhLlEqzm3uAG8UUIFpWgAymicDvnyTmRH5uLgLqBroHLKdrVw6IrR1PN/S8IRswJuZIbKbBH7l/1lhYDHeZBH2uxMwmQPNQDH+jRkuOSsb5BLmCkVyW3h3OAY12OwhmQGuu8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KpVCN8fg; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5848a2b3c8aso20671e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 16:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760571138; x=1761175938; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bpPxh0gcuqDsiBGhGT8nfnZ05AHmMsVAlwdJ8sk5caw=;
        b=KpVCN8fg0eKg+zdhFi9pvlUG710HlDdM9sObq1jqHgTkTO3Ygjm4sKpnY8I63B2aaI
         QX6BGdY0/A/RfprOLYqyuaCrIfVE2N+tpQZ89WJ7BOJUuKOFqBQt3LoXpr5plqKcIk/v
         YBZ5vpfrSOTY4V4JlM2uEqtny6WW9AKCHbxUOniJliz3Aa/4cMgkFk2DUpNuLnUwmc/G
         l1mgpnWyH9J4UcRAy9M8POCKBihBmKBAkG4hqv3BiFYxV0VG6J5sRThHoRwuMZnqiCWF
         j9N6eHE6pf/KM/iuFgf+5bGbCUFiOAhyafIXlYEtgmmRXOkYP7cwAEpSoeoO6jFcx0Ha
         OVZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760571138; x=1761175938;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bpPxh0gcuqDsiBGhGT8nfnZ05AHmMsVAlwdJ8sk5caw=;
        b=S+1FLgIWQfKdk6LqxjyFGVlZaD2mva6NawPER4A4+NWjStiY0F0CBSERJ3ZjcFODxt
         PKw8vldEgQUgYJV1fLti6fMgQgnciie3A7O117vFmopxPDh5OqG5sQOZC7MG54OjFeLe
         3LvHgNUhqcNHoGLBT8DMCB0ETRy03iQhkLJUXG+SNsKxmGD2EGsdTs/rJAT2IiPKOTUB
         DXMKXAx0zcPZNJdNy27d6svZzw8/x5UmBgsnAyBR4I6s+cx1BN2ou6a3yfdMxcvBSxQr
         AcMQhsijRtROG8PEFgFsyKek1+m+3OvQbxgcWQfupmeOZCpFUww+yxjnEajZZaPO+t6N
         I8CQ==
X-Forwarded-Encrypted: i=1; AJvYcCXI1IMDyy7FCplbOsPnVE9eSKOU8F1hT2TyyhXxSnvAqvwaQFPgC2+w0PhTwwKYFHPb1C1fjE2iqCWprjE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxySYPd2u7SBPWpbnNuFa6fTSuw1ADbkLmaHQt3kQaVMBDN/9JW
	p8PuakNdZNxsc8rcpPSj20/JVUap4v2VfUbeBBy2VzrbiQEQjIXgnIort50jw2ZJjeI=
X-Gm-Gg: ASbGncs+yHusjaAcDzpFA2N4C6F9y7xOj9c2QeVq1nBe8VyIp1vf5PN7b7Vyddak8Or
	ShpkXerc4rZyOpSzYncKAx63AXfQGdz6c0fq+HG8pDEivU/DjEduhlTw0itzJg9O9YLbyxMzu46
	zAahzdZoQxTk97Fd/bMaow7AE0M0mAWcP8rdNCn1NXhf/TCPGJ1+ff5EHB1XrN9KuP+6/+kkXap
	2JKPn/DLpxsPAy03BG9kE5fWk3/k1DrfWcbOADbPBNwmNmhe/bSBNSDurGUN86Z2HX3PsrNn+V/
	0FuM8/6BhR1PZew2OyttROTEl8NagVMvFFU5pVo4OeA3+Jt+tqoSIq4GYdJrPBrX0tEOpqCc7cx
	JzDb2jscpbOn8+qJLTBXg8U+bCxjXcrmQzShZGlu5E1CyDsf69XkzKTTXashxWhbJmR1WF2jfg7
	sDwbufhFpUkgpSe6YkqJMN/QNz44k+eDCXiHrbBZ3HzJlacvIhwZNPvNj5ws4=
X-Google-Smtp-Source: AGHT+IFhmCfc/iqqM/lx8OD9acToPRRAMIUni22wMDWOAc8jc/Nu4v4J+9jAJJcyPXA90FdVyjEthA==
X-Received: by 2002:a05:6512:682:b0:57d:c562:1f78 with SMTP id 2adb3069b0e04-5906d8ed17dmr5015764e87.5.1760571138323;
        Wed, 15 Oct 2025 16:32:18 -0700 (PDT)
Received: from [192.168.1.100] (91-159-24-186.elisa-laajakaista.fi. [91.159.24.186])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3762e77cc6asm50763801fa.2.2025.10.15.16.32.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Oct 2025 16:32:17 -0700 (PDT)
Message-ID: <a0d9389b-67a5-458a-858b-ffdd95f7ccc6@linaro.org>
Date: Thu, 16 Oct 2025 02:32:15 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/6] dt-bindings: media: camss: Add
 qcom,kaanapali-camss binding
To: Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>,
 Loic Poulain <loic.poulain@oss.qualcomm.com>, Robert Foss
 <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Todor Tomov <todor.too@gmail.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, aiqun.yu@oss.qualcomm.com,
 tingwei.zhang@oss.qualcomm.com, trilok.soni@oss.qualcomm.com,
 yijie.yang@oss.qualcomm.com, Jingyi Wang <jingyi.wang@oss.qualcomm.com>,
 Atiya Kailany <atiya.kailany@oss.qualcomm.com>
References: <20251014-add-support-for-camss-on-kaanapali-v2-0-f5745ba2dff9@oss.qualcomm.com>
 <20251014-add-support-for-camss-on-kaanapali-v2-2-f5745ba2dff9@oss.qualcomm.com>
 <dce1018c-6165-407c-8f3d-40859cb36b11@linaro.org>
 <0b6c157a-3d8d-4251-a704-31f8369f6a4e@linaro.org>
From: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
In-Reply-To: <0b6c157a-3d8d-4251-a704-31f8369f6a4e@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/16/25 00:43, Bryan O'Donoghue wrote:
> On 15/10/2025 20:45, Vladimir Zapolskiy wrote:
>>> +  power-domains:
>>> +    items:
>>> +      - description:
>>> +          TFE0 GDSC - Thin Front End, Global Distributed Switch
>>> Controller.
>>> +      - description:
>>> +          TFE1 GDSC - Thin Front End, Global Distributed Switch
>>> Controller.
>>> +      - description:
>>> +          TFE2 GDSC - Thin Front End, Global Distributed Switch
>>> Controller.
>>> +      - description:
>>> +          Titan GDSC - Titan ISP Block Global Distributed Switch
>>> Controller.
>>> +
>>> +  power-domain-names:
>>> +    items:
>>> +      - const: tfe0
>>> +      - const: tfe1
>>> +      - const: tfe2
>>
>> Please remove all 'tfeX' power domains, they are not going to be utilized
>> any time soon.
>>
>> When 'power-domains' list is just a single Titan GDSC, 'power-domain-names'
>> property is not needed.
> 
> Each one of these TFEs powers an individually power-collapsible TFEs.
> 
> This is also so with the other xFE power-domains on previous SoC
> generations.

This is false, for instance there is no management of SFEx power domains
in SM8550 or X1E80100 CAMSS in the upstrem, neither there is no management
of SBI, IPE, BPS, CPP and so on GDSC power domans given by CAMCCs.

TFEx is no more special, if it's unused, then it should not be added.

> 
> You'll need the TFEx power-domain to process any data on TFEx with the
> 'lite' versions being tied to the TOP GDSC.

When it is needed, the documentation will be updated accordingly, right now
it is unknown what a data processing on TFEx looks like, it might happen
that there will be separate device tree nodes for TFEx.

TFEx power domains shall be removed right now, unti; a usecase in the upstream
CAMSS appears to use them, I haven't seen such code at the moment.

-- 
Best wishes,
Vladimir

