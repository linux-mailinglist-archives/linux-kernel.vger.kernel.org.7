Return-Path: <linux-kernel+bounces-897187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0679AC523D7
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 13:24:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E79DD422450
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 12:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B4D831B11C;
	Wed, 12 Nov 2025 12:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E8POWZ4S"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 325A631A813
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 12:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762949656; cv=none; b=WXImFr3042eDdzrljzFYmuRTENwGEdMrzI48Jay7mSxMeQ9Zyyxx2b1d9v2Hld0WSVb8d9VpNVRugRcKTXtSvo7Nkg1Rr+aDfKWpy621wV7wLBM3DpBh2RQMGrKsMaEkO4RKAxNTGMYu3YWZorfdoAjf0aqG/sygWZAxD8678ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762949656; c=relaxed/simple;
	bh=7uPcYg2lVHFfpp+yzhBu7ox/Uy6wawl4Hrvj0i9hYfk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VAtlNsOWdJxkHZkVbE9/OkOTiI0BB7iSh4OL9VywgvTUQ48y6g1NNZoQFxcFc5R0gelckK1DNqjzdT+6SJK4IbohD0Kkeh5W7NnXHbRrcYmdcTfzQAALbCKwgPnCJHqXQVIWDRCXCfitFbJxapX4oLFW38zGx+E2dn6DRH9/Ab0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=E8POWZ4S; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-477632d45c9so5566785e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 04:14:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762949652; x=1763554452; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7uPcYg2lVHFfpp+yzhBu7ox/Uy6wawl4Hrvj0i9hYfk=;
        b=E8POWZ4S1gqsLQ/VtHBqeaVnes5P7kDH+FtPQUwFBJ4eT2GcS7CJIRZg/JgIsimfYN
         eE7U9INocW9J6B4KZQ2vNivTIhMHptHV/awujlk2IzOr5o1n5K90hstpBInvXuWgVMZ1
         V8AvsAvuW4KZ7ZFTL81fLLXnk6Ji4hC5kZA1eSFtvdW2QO0qVhGhE0R4T82RQwpHGtUj
         YqVosqmQFO4g3w6VdYKe5YRMTRBrhBBEoEq2IFKDCPp6j/sgSmNobxIY8Nto4Qa8urBg
         5kDBvWxbUrVgBWsg5EQeCSsangSyLJZfz477x5ivLb1pWZr9OJGuYGAKpAw/ouxx5i7g
         NTiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762949652; x=1763554452;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7uPcYg2lVHFfpp+yzhBu7ox/Uy6wawl4Hrvj0i9hYfk=;
        b=eXKcC9FZFinstlrSCCYyTKhbQfNCrD6VFjfsZjeJwG5srLW7mf3oKK1rC1DwwG8y94
         4wEs7VsX8mH3MFIWGvl9nImNv9QQzpXoxBUSpQU5sbJTQx8co+E3/DVM4Fepmrrawn61
         rtJe4YQKbP7srTiCdj2MRkb/e0MCnZSspWnjE8SD8WZe4hJoau61jrFqRO6ASDEB7KsT
         VkMcMolkHbvrp1n+iiuosOvHu6ZBtr6jO3y1zG6DvYF+U+WhPp6m+jgVA/WsFOLGllUv
         svcze1Lb261D4sIY1aXUgFCMu8GmkOe9s1iYwzeZ/8bX/heCOyJhv+88G2HXth32rS2W
         QUyQ==
X-Forwarded-Encrypted: i=1; AJvYcCX9ikakArhZQutkF9rEIFT0k2gh+Yagb5JNnNqoP1Q0CtZzPYnXFd6kgvwFeZiV/GpDLLiw+FGELELvlSw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlMlkjH3/SCFBp/cH3kvUA1fxeAVGaRU+hMxufr1PLq+rLkzZX
	QvZW2CVwJxoow2nFmssQHfAbhXR+sWngLz9tzj6PucQpLXELVwXV3j8s72AgqDnKhCE=
X-Gm-Gg: ASbGncso6LoGPfuxO145p1E9Iwcuw931Y0EI4evGMK+ioeO8vbukli53Ae8YTzqO9Fn
	2b1B/4RehiSSfCg6b6tfnGpQMjEOXydz1WUrYTRjiHGqXc7lhGhCbUEY+OtiMGWxXchlhf15V2X
	rTGNM84nsDFszwgwjLVnMfzxz1w3rwyz7+kDeZt7sD/sOKE8J2V5VxHtTulr703u3xrek/jeh3C
	OSeoNqQ5I5nSEv+KqMB+gsQL1mVEE2N8RPevfVgG1kRimDV4FP+s/qYT312B4wZvZbZkKqJ9pQm
	aKF6fuqnNGJ4Xs9lK4VQyPNUvKd6OlOg/FjHEAW5i7GenEOGbESNfQ3sFF8X9Z3GA3pkkPZLiiO
	TDPa2UO+u00NPh6A2cIhhwZUJhuCb6sZEIiXlpssXVU4zqqpyfM2E/yKIs5uyAUxPxVNEEyp6Ge
	13dXY6+g==
X-Google-Smtp-Source: AGHT+IHE9gQcKzRZRfVJPwal2CO92YTTNKWhjd3PMe37ZiWw8lo0M7TWEe/XDmM7RYwtcvi4g7le8w==
X-Received: by 2002:a05:600c:3511:b0:477:54cd:2021 with SMTP id 5b1f17b1804b1-47787041346mr27268155e9.8.1762949652523;
        Wed, 12 Nov 2025 04:14:12 -0800 (PST)
Received: from [10.11.12.107] ([5.12.85.52])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47787e8f3d6sm31531675e9.16.2025.11.12.04.14.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Nov 2025 04:14:12 -0800 (PST)
Message-ID: <984524c4-e51b-45af-a775-477977df2695@linaro.org>
Date: Wed, 12 Nov 2025 14:14:10 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/5] mtd: spi-nor: micron-st: add mt35xu01gbba support
To: Haibo Chen <haibo.chen@nxp.com>, Pratyush Yadav <pratyush@kernel.org>,
 Michael Walle <mwalle@kernel.org>, Miquel Raynal
 <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>,
 Vignesh Raghavendra <vigneshr@ti.com>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev
References: <20251112-nor-v4-0-e4637be82a0a@nxp.com>
 <20251112-nor-v4-4-e4637be82a0a@nxp.com>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20251112-nor-v4-4-e4637be82a0a@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Super!
Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>

