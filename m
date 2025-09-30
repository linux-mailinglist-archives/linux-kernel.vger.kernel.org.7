Return-Path: <linux-kernel+bounces-836873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D68BBAAC78
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 02:17:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0E501C2ACB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 00:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B45F5142E83;
	Tue, 30 Sep 2025 00:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JKQPGwXO"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 727541A275
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 00:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759191444; cv=none; b=AfGUU+Bjxode4EE/d4cRvGEHCGYeFZE6s81HPTczPqiGeq0iU1acXSYJEEx7ZypjXkfrWmlHjn2UHmxqsFJSQ7kvDxC48F9ObfZndZD2v3ymdBf5JfB6wyJemoGE4qxYkSD/iIlffrF9aN6JqMZWPk7+dYgsuicd+WvoBE3icyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759191444; c=relaxed/simple;
	bh=R0YLBiUyp3YW7yv7x28H3CgeEQEOZJr3Y+k/HoiLimQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bhtg5gzSvTS/Ehi/4/nSzB7++U+EJuEJ1U2vSOvF1DUvEgXe2UjTuwm4pSwRmMwE8EL+b/5tbB3PQFYfS41uDbc7MVoknoFQq78FTbtpLy4xhHCFCDryPyrrSTypdss7FuRWmRJ1gpfEH8Bjr/KaiegnODw6w6BvdxZDVO9KLOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JKQPGwXO; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-46e2e363118so51074265e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 17:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759191440; x=1759796240; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XdEC/q6le7nfUpMwS8QD1mrWIXjjaEQSmDLATI0QjFQ=;
        b=JKQPGwXOroor2ZNT7QUdLk108fEYgFF8zdT+6rZBkktVM9+8+ZZkpiD4YWjZayfNWd
         dL134bFsUU1pdnJBeWlHHb3tu2pP4kYYrZhR5Ln65B/coBrEQkTeG8HdzKqOheDMjNHs
         s27ushuoRlb+r1Zt7OkzP1i2SLRuT11ux53i6pJx5WTIM2jBR76PKOaKRO3JgvQRw6MM
         Vy5CTcSBd0nbz8oObMXCfeHZHBNBVIaeGNj2cgD4B7m4XS+B/Mshte6yxn7l0pVsXSSL
         6EthYEs4+cGUPF++NT/8LZDhWvRask1jLmtuuKCZ2anDhkN6rKGeViJGcXs9oPLcd5Yt
         8gFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759191440; x=1759796240;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XdEC/q6le7nfUpMwS8QD1mrWIXjjaEQSmDLATI0QjFQ=;
        b=aqPAOYvuf1vXaYAK8+wZSOyIRK2SIuhlC3lgTYsJs1Ry09B3AlJm2Crb/IURU7eAFR
         qTSId13JuQJervAXhMwZzq96669ZOROhgxXIroxMSL93aAiQWbDRhfNPhSCSfKZ9IYZ+
         lOSGYB1ex6LL+wRANpjGLtBcUWnUxGIyW9g/YB2H+tQdZN9cWk+/r6bYYctmGbpzCV1K
         EnsP14NUPGFyQLXYvjLr4Ee8XKAOoFowTS0/nKWeHqSlRuJCmUXohG6+PtIxJPlUudcF
         Ub1EetTrLgozwSGG2qq3RHZjGYehF99maYN4Yi8HWYKwndscAP7uYrHXHfCIbaZ7H0vU
         f0dg==
X-Forwarded-Encrypted: i=1; AJvYcCWtEFycNom/zP0kXmgjwfZqmrUtxzPwFWojXnrTegMsf8eLYrrFN1ydCSDIEz/cjw+amfHV0SvIIaZrPNU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAv2a1X85r1fWmvxZTnecn4YX5/R6zDCO2zn2XucArfTTga6aE
	A4jASLbjN6Lqszs6txlmz/ZIN/L1xC1uJ3zFYOjJH8SOfmGBQy3tDCBG+nFuwwNc+e8=
X-Gm-Gg: ASbGncvrYoQWcdYvGVqoi/x4NFm64pPLRPkeW+CWy2QhMEc37ICqxoqg+sJz+l3oUKI
	xev5B47atPsnLc66HubDeglc0eHD1n+vvzPod23N45R7Swg6ot4IHO75gax8ogzW9SJpaTvbO5y
	4bd1m1qOnPhwjvNXNlKodE5GvHecA1ECKbyTUR3pvnY3H/J8ri8i49ISD9eL1qUnFfn6a3LiS3H
	03pR5sbgeObpl/N09FTHCI9ou+cKxWkFGKJolFqf6SRShDQHcXV/k35IKkM0mb1C8kzQuimGLXf
	paB/9VzSd2Xfqm+qkX/7+YgOJcPtPaEcIS3CVZ2E0ZoeF5FzarhMLPE9mWSBrM93Dc1LFpZdiBu
	ayTtdUDSd95CPT0D61JiWxA4mogdrgG5Zj5rewTBq2IjqTG96PWdbtmVzqW0IxfhFnp0dVcQkWf
	JlcB39bRLQAnwgDqYeo1wqBac60MBjt3c=
X-Google-Smtp-Source: AGHT+IF1NvJ6A8YUVxkdRJkfeGyVldxLeh1qdvb50sqvC4KYOgmP95PhemeRL1E+WA4Xb6qkHy3wsw==
X-Received: by 2002:a05:600c:1d06:b0:45b:9912:9f30 with SMTP id 5b1f17b1804b1-46e329a0d0amr156323085e9.6.1759191439753;
        Mon, 29 Sep 2025 17:17:19 -0700 (PDT)
Received: from [192.168.0.19] (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e2a996e2fsm266744585e9.2.2025.09.29.17.17.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Sep 2025 17:17:19 -0700 (PDT)
Message-ID: <3594bbc8-b063-4472-a294-117582f063dd@linaro.org>
Date: Tue, 30 Sep 2025 01:17:17 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 03/17] media: dt-bindings: add rockchip px30 vip
To: michael.riesch@collabora.com, Mehdi Djait <mehdi.djait@linux.intel.com>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 =?UTF-8?Q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Gerald Loacker <gerald.loacker@wolfvision.net>,
 Markus Elfring <Markus.Elfring@web.de>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring
 <robh+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Kever Yang <kever.yang@rock-chips.com>,
 Nicolas Dufresne <nicolas.dufresne@collabora.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Collabora Kernel Team <kernel@collabora.com>,
 Paul Kocialkowski <paulk@sys-base.io>,
 Alexander Shiyan <eagle.alexander923@gmail.com>,
 Val Packett <val@packett.cool>, Rob Herring <robh@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-media@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, Mehdi Djait <mehdi.djait@bootlin.com>
References: <20240220-rk3568-vicap-v11-0-af0eada54e5d@collabora.com>
 <20240220-rk3568-vicap-v11-3-af0eada54e5d@collabora.com>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Content-Language: en-US
In-Reply-To: <20240220-rk3568-vicap-v11-3-af0eada54e5d@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17/09/2025 16:38, Michael Riesch via B4 Relay wrote:
> +                enum: [5, 6]

Not required but nice to have is a comment like:

enum:
   - 5 # MEDIA_BUS_TYPE_PARALLEL
   - 6 # MEDIA_BUS_TYPE_BT656

Just for the sake of a reviewer.

Either way

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

