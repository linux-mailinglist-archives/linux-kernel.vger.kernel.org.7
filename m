Return-Path: <linux-kernel+bounces-871946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0CE2C0EECF
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 16:23:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3692188C100
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 15:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 332F33090E6;
	Mon, 27 Oct 2025 15:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hYK+Lbqm"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D857A283FE5
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 15:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761578269; cv=none; b=NvqAwVLLo8NbmGlYjrEbJmVj58HNNzP0Q0XwKRR15ouyYbCd41wsLbj//w8/TE7g7QKJMiElXlreTga6t5CiAedLBC29+SHuKG8ZWHCNXkHqASMm84RExo5MD0Xbk2DCx1OB4aJ2a8K8d29dE09XdeNF2xIvUJ92blUn4+F+XN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761578269; c=relaxed/simple;
	bh=j7iaI6dMKBMwEA/p9J76DQJqd78/n7N+OXj7MgdoWU0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dath9Vj2tjQBipczmjp8NkrgFHGG28QCTr3uxtTDfO/UD+4OVBDWG86/krSThE2aIb9ASQN0yqsBkuRnYGngnpm4giMyTQTHaJZMnoAPntRIwtcpypgKGNb2E6Nuk+pxohwaPe49XEYnlOI60VRcTj4K6RE829UO603KolgB000=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hYK+Lbqm; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b3f5e0e2bf7so1073272766b.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 08:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761578266; x=1762183066; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+RhaaAECagc9DFp9XYeX6cR74fQi362tPJsuNQfwUA0=;
        b=hYK+Lbqm8F4EWCYEXc5zzo57bvJUDMeXeM8P2cem3hFG+dxv4es9Xdiz+m5WacCk9M
         dkZSNTBy7LtK7RNcsBbOd1pZI9KtdHdl1E+Af5oDgnPTaADYTALvQ7kN6Llrf02BlFdb
         5bpQ9m97qxwHxusgsaxqyLPuYiJRaX7KE9D30a3MbJR6CWhkpyI2B2oGogSZA7MhfaFt
         omsIv0LlnZLC0ycfKHT9SviJw8LJBWq3YHnCxY5+j/5tzgvSBZATaT8JkcH7OtXRbQNu
         llJOIbS9FEgLctmybGdtGA5ZjQJNm4tLowhEQhp2wqjqcQeEgHj0r2LLN2uGFp162Lkq
         Zz6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761578266; x=1762183066;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+RhaaAECagc9DFp9XYeX6cR74fQi362tPJsuNQfwUA0=;
        b=gqGGS/KXi0c2vpT+ICC4KdFS76cNMI+1F9u1iV7RQYKTZ3nKurhcmmQNdljbrqW19v
         j1vxBV7zAcwCra0i442RBrvqnJxex9LWiYr/YMEpaiynxHeJufsT4JzJ/oIE9Z/mrmmX
         C8hVkgZJkmSU53oHE2w9xDdnYRyu9VNHJGtse8gaG6toXmMjNjxdNTAgRUNW7uHEY1EB
         HQIApJ3k+6UJKK/2X/YliRI+x/yFILSdCup4zi3iuN4ZFea72DkZWy6XIBl8XcHP1O1P
         Yqp8lxLQ9GV9WMh/Dz2SjdnhxmlnLJMTv+dnwDWE9dUXGX0H3jo7i1/gJhy9D8m/zqqX
         DXJA==
X-Forwarded-Encrypted: i=1; AJvYcCVUkHqNZP/1IEISBX4vNalTMLh2a854+COeiq6SCvbmT+wQrrBzZFMKPgmEzvngfrlpHZwp/dwJ0RE5+KY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEJsig1+tQcV3DqDiBoc/q7S71OjK4Nf/8NMdvgh3zzpgOYjDA
	gXCltHJGbbSy5h7Yq1J5I+x+HtsszZx+tngUFMcyYHA5OvhxUE8mEin+
X-Gm-Gg: ASbGncvxkHLYRygzF+J2wSglF+QofhwB1x1E93SKanWCD7YcQTbNFBUnt15p3yo2fcn
	j5mIU2S/KgBAd9C4ZoGq4GYthjEKs+1Cn+nHOxN4FM8n5SWEZne+oYq6qvjYubUHis4NyPylqKm
	qYGn28IpGetxkRWSlXoJ1NM7Z/qWevbnRHNWFMUnfcD+7EjaqnrxnJtk8jzpdfmQHTmq/Y/xso/
	jKos666jG9ZwSjc3uvb5QtF9tu1zrxPa6eaWRAaSNpkgPdqJY+n1uEgF6W9b2gDBi+BY5zqKAM0
	yXaiPSdD6JqCXHPJkCFC6atwVmbKyHceR4eVskk+RQMAx3YO1zRBT9GFDzdwqQiQyqmA7neGTKb
	RPZmdaF2Z5VD9P3nZ7TwI2Dj6in3rIT5eU2pQI/ZfLDnmJvZd3DWKrxvPbFwTInhLeN4u3mcBM1
	MNzSFD24ZeFUKQ4ZbQoAO2udC46siaRw==
X-Google-Smtp-Source: AGHT+IFwRk45A3Ur3DKKqB7hUJTu/XpniiqiGgHDiWfPN2WS4tjYIiwIglRdwwwXDeEdp9t66AD1SA==
X-Received: by 2002:a17:907:97d6:b0:b45:60ad:daff with SMTP id a640c23a62f3a-b6dba49c6d1mr31539266b.28.1761578265848;
        Mon, 27 Oct 2025 08:17:45 -0700 (PDT)
Received: from [10.25.208.2] ([128.77.115.157])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d85308cb0sm809592766b.9.2025.10.27.08.17.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 08:17:45 -0700 (PDT)
Message-ID: <feba1845-5f2f-4716-950c-9abc7c4594a9@gmail.com>
Date: Mon, 27 Oct 2025 08:17:40 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/8] dt-bindings: clock: document 8ULP's SIM LPAV
To: Peng Fan <peng.fan@oss.nxp.com>
Cc: Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Fabio Estevam <festevam@gmail.com>, Philipp Zabel <p.zabel@pengutronix.de>,
 Daniel Baluta <daniel.baluta@nxp.com>, Shengjiu Wang
 <shengjiu.wang@nxp.com>, linux-clk@vger.kernel.org, imx@lists.linux.dev,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Pengutronix Kernel Team <kernel@pengutronix.de>
References: <20251017112025.11997-1-laurentiumihalcea111@gmail.com>
 <20251017112025.11997-3-laurentiumihalcea111@gmail.com>
 <20251022140841.GB11174@nxa18884-linux.ap.freescale.net>
Content-Language: en-US
From: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
In-Reply-To: <20251022140841.GB11174@nxa18884-linux.ap.freescale.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 10/22/2025 7:08 AM, Peng Fan wrote:
> Hi Laurentiu,
>
> On Fri, Oct 17, 2025 at 04:20:19AM -0700, Laurentiu Mihalcea wrote:
>> From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
>>
>> Add documentation for i.MX8ULP's SIM LPAV module.
>>
>> Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
>> ---
>> +description:
>> +  The i.MX8ULP LPAV subsystem contains a block control module known as
>> +  SIM LPAV, which offers functionalities such as clock gating or reset
>> +  line assertion/de-assertion.
>> +
>> +properties:
>> +  compatible:
>> +    const: fsl,imx8ulp-sim-lpav
> This block also contains QoS registers, General purpose registers, HIFI
> general purpose registers, and others.
>
> I am not sure whether need to add a syscon fallback here. dt maintainer may
> help comment.


syscon programming model is NOT compatible with this programming model.


If you need access to other registers (not covered by reset/MUX/clock APIs), you're going to have to either go

through a subsystem API or manually create a device link between SIM LPAV and your consumer and then use

something like dev_get_regmap().


Either way, you need to make sure that you're using the same lock for register access.


as for the interconnect QoS-related stuff: can't really comment on this as I haven't worked

with it, nor do I have an use case for it ATM. However, the binding does need to be complete so

suggestions in this regard would be much appreciated.


>
> Regards,
> Peng

