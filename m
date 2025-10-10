Return-Path: <linux-kernel+bounces-848178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C4EBDBCCD0D
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 14:02:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 464154E6011
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 12:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87462288C2D;
	Fri, 10 Oct 2025 12:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IHIaMYOQ"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230B02857F6
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 12:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760097720; cv=none; b=m64wUdudloVOqnyJFvQYhik62mweg7fmAFMH3QJmwMWjp2ypnf+OZxePSRRJLSN0bSf2Je0+D0pPfS1LrzXqfBK7U4ZsUlS3HN8mKgbi1zwxPUNrpACByzr0fTuXeZjKEkIURS7pP2S/713qmGQyCoIWX4aw5zHLQ4jxThR06fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760097720; c=relaxed/simple;
	bh=kPRMI+tX+SAktSw62vIiHfaL8Bu0DpE6vapi2eb3NmI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BKv+yGiKlh2VwMB1I8K3RHMxZz6Ec062JsrVZ0PS1AvRPUiZwv4GX3Rc/Z2BbG8CH9Ruw2vO+RDLJLPIVx/qYeS7rpyojxPXfFWdlsuEfVJgBZhFiE8ljm6BF1v7I4yxsIWgt5oKjqACHyjPlvranVso/ZmG/FbQ00kFWP0Tz6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IHIaMYOQ; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b3d50882cc2so373692866b.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 05:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760097717; x=1760702517; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s90KB/NTrY2uO7MTlr/2on1AH8hzlT2J0wqk/Ex7Qg0=;
        b=IHIaMYOQnTcz0uhyYwn5zMFmwYnGKbiFAkMusqnePKqLNuwhGft7skvVjxu1BvBISv
         cUEUNOhfjMBX4P7MC4fkutJkvPtXx/N0t2aB+SdJXld2v/962q4/6g+GyRgUSTIwawqk
         /+llb4GiSS3Dqf5QgZPm453wGL9imy48skja9desvEOosu/LWhEzk5GD1ECyZs3SjTvE
         6qtnL3jhOwrkP1GlCJOazVR09MV/aRyqNYgprzJfwuH7Vp/2UcG/JvYIuAbpEBYDdyS5
         EFJDZOz8wc3W4IqPWxwvI4l6SYQDblahHfh3k4biDSwFbdBBETRuz5CS11jcLXEA4s90
         tNNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760097717; x=1760702517;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s90KB/NTrY2uO7MTlr/2on1AH8hzlT2J0wqk/Ex7Qg0=;
        b=f3aRGrBQKD8pFpU9eHGrouLxEhCa2VegvrW8pIqfOLKKAhPOh4BfeDfeOJtBaN+/bZ
         AtIkUmzTZo3ArDd9NPzrP7bOHieHbZ+A3et67HohXR/3DVxTC2mcg3gpoQN29A+OLqi4
         904S4wTndicqMvDIRg0Cp+XlHnaSWveuRnzNk8cn4hgEyyAqyg7cqKeZQEiuNCyJoZVo
         weqODpL+Nsa8p+IfjZILu72Z7YkbzWJXoWSFI98NWJn5535Ou2IDULxF+xBF431j7sQp
         K2G1oZXdUwIzqKrxThdFx5mFd9BVZafZd2233325tG6Y9lq8Fo+PlhQ4Ug5tF7tvgMuV
         Ju9w==
X-Forwarded-Encrypted: i=1; AJvYcCWrwNektgtiRSIo/+om18R06NMK8zW7gmnhQmgqRD+264A9kj8vYTqL9uVaB8r8psPMdxVrgFPCw2f94Hg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSYrxLp3O16tB9iX96LeQzXJIw37zAcX6VivtHTfsGcWDQWd+G
	/vUA/76DbgP2n5novydnPQKvXSdE4PhnOe5XEPrpj9KfQoJfHA8HtlArYlRKfHnRX5w=
X-Gm-Gg: ASbGncu7bMyDlH4cbUXDkwGg5YhlIoPlggGo5PrQaPi7JS26kZegReJOmdJzOWHCXoZ
	br+9raNUg2zjTfDvXFcFzUuhRPDLeZIXZ6i/xWOcR/ifZgxxrVXeXZTHnEoSv3uWR3VxrNIsgz2
	ptGoWFubA320j2nHGGik1TYJWvCOATp/+7B5eNr5MLHmbiSFAUfZtLAq2NYIpVL5f+8Ho4AFWT5
	MkY8EbtedT/c9EtHP6U3WvAXqAvL4TbIfRDKnhdS8jquj6sCnDHNVB8U+NUE1KlJsk40kEcBf9V
	hqf0E4Wm7YwJqyAUi0w75FbeFK6ev5BTd9Frn5hKQzoF0zg039suh2bxwotRcDO/pl9VHr1NOKf
	qnLY/h98SRXu/jTBEHPlDd9q6dwDVwk6n612LoN+0PwWbxjij7b2AE1EEGCnAFe43s4VnXxnW82
	4gwusDiBUHVdU=
X-Google-Smtp-Source: AGHT+IHFEbOgc0ODAF0VuKf0ziv5aS2t3f+mpFW0dy7lOT4Bfjw96VQjQByGIVRZZDYAlQhb3Y/lvg==
X-Received: by 2002:a17:907:7f0b:b0:b3f:f207:b755 with SMTP id a640c23a62f3a-b50aa48d873mr1107494166b.6.1760097717302;
        Fri, 10 Oct 2025 05:01:57 -0700 (PDT)
Received: from [192.168.0.19] (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b55d5cada4fsm229334066b.6.2025.10.10.05.01.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Oct 2025 05:01:56 -0700 (PDT)
Message-ID: <f71052d2-8969-436d-9109-d5abe70b81a4@linaro.org>
Date: Fri, 10 Oct 2025 13:01:54 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 06/17] media: rockchip: add driver for the rockchip
 mipi csi-2 receiver
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
 linux-rockchip@lists.infradead.org
References: <20240220-rk3568-vicap-v11-0-af0eada54e5d@collabora.com>
 <20240220-rk3568-vicap-v11-6-af0eada54e5d@collabora.com>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Content-Language: en-US
In-Reply-To: <20240220-rk3568-vicap-v11-6-af0eada54e5d@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17/09/2025 16:38, Michael Riesch via B4 Relay wrote:
> From: Michael Riesch <michael.riesch@collabora.com>
> 
> The Rockchip RK3568 MIPI CSI-2 Receiver is a CSI-2 bridge with one
> input port and one output port. It receives the data with the help
> of an external MIPI PHY (C-PHY or D-PHY) and passes it to the
> Rockchip RK3568 Video Capture (VICAP) block.
> 
> Add a V4L2 subdevice driver for this unit.
> 
> Signed-off-by: Michael Riesch <michael.riesch@wolfvision.net>
> Signed-off-by: Michael Riesch <michael.riesch@collabora.com>
I've been stealing ideas from this patch series for some time now.

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

