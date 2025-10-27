Return-Path: <linux-kernel+bounces-870916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BB0A4C0BFA3
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 07:43:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DB02C4EFCC6
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 06:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F7242D6614;
	Mon, 27 Oct 2025 06:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=reznichenko.net header.i=@reznichenko.net header.b="ad57ETgB"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE6323B632
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 06:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761547293; cv=none; b=Ir4gqjkX3gkzWQejtHFcm0hizfSkGMlebKjkDTHSfnnksC3aQxRUwYM2uiXu+neXpusy+XUSx9VRz/J54f70oTwbBm5menpD5jEcxi0uJKm2kvu8Y3oM3FiJN853tIszi32SvCM7OlzBiluzg1AZfuqOfOsx1ENIT4mxN8tjUvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761547293; c=relaxed/simple;
	bh=NPMQeSnux1WgQoNx4rxVtVlmNiImFDKpyKy8ElUhOgc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G7D8agkVjYbO6RrudLfd16clhzxwssY81RhQaMMLk6HWkPh+Jv7U4wt/mWjzDJN0Nrj/Zdaf5gE9lxMkvJlRQC8ixLLqPA9IQCPWTWgN2pHsJBWQA9odB4xqw9iNKB0Sk3YjwG+UnMllGZibLuLen3+ciN0ceDQVqnxQ0JQMD68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=reznichenko.net; spf=none smtp.mailfrom=dpplabs.com; dkim=pass (2048-bit key) header.d=reznichenko.net header.i=@reznichenko.net header.b=ad57ETgB; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=reznichenko.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dpplabs.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-33d7589774fso4168728a91.0
        for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 23:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=reznichenko.net; s=google; t=1761547291; x=1762152091; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BNYKZ3q1Auj7hMkOKDK6a1DLo0lCG1SQUrXtOHXGU90=;
        b=ad57ETgBYBam3lMPV2kfwPCdckEBTejF9rB1d800BMCNlzO6inDfKMLuLA+eze7v5Q
         NJko8MP6zTZ865XM4J7h5F5bg3JLln8mx2/Sduau2Fqcv5aiG4bAXfYrTpca3+p3u0CO
         HjdCoYohJykQsJ2LVrT6spYk39HApfj4+CWn/O0uOeL+FRl2FJ8jWBI8i5CZ/cdgd+uS
         MTF38HsZFslgBfMDEeHP4ThrPqL0zgZC1z3WBwOsuM97VzuJPGmQ0bTT+OJRHZ1XGPo8
         l7yeVBgQTUV72V71MeKesPnB9EItaxHEdmsKnL4AyQo9JADbLQrealTy/Abln87M6SJg
         MNdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761547291; x=1762152091;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BNYKZ3q1Auj7hMkOKDK6a1DLo0lCG1SQUrXtOHXGU90=;
        b=p77jw/zODCSOKaRchDVUWgR6ijUsivOKpqfvjOdt1M84PQxl91vi606rHC0gTSRqfr
         rbWD+0krv2698NfJTq8Byda53pNA6Xwr//CmYFJ41sl2zo6xaBgJtg6+IXWROoa3gRSx
         kYbgIXmWVn9mwu6AiRRn3Y/YT1XF98vPxU+C5L9Fs5XyLkjVOTv5XyFPaPQBnrNhTE47
         Vi6k638Q1HZQc7wund9StovN1m4zE13vkevLWNjM/eFiH8Qk9TSVsTZwiwSSFMfz8Fhs
         lqetNECtbNFwRsL5qq+B92AHXb4gZm/pEHC/346xKvA6L0jzsYw4k5QScWDgt9vFwBf9
         pM8Q==
X-Forwarded-Encrypted: i=1; AJvYcCWnh5qSHBgNGYHaDCezx18AiY3fFEd9NbClqM8P6xTH9sDtmzIre4UOl+PdcbXRsjHXLScqKirUOOOKHso=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJn0nCviLYtg+bytd37Ql+eCeyLXRaEkwWX4yO1UBNBTRMCfIA
	DEmvT8S0e8CfiP7ac/J/a+cbvgv8AdRtjHKVPXkFuEOfVs95mtjOeYbWhTXgSEQU8Xw=
X-Gm-Gg: ASbGncs8Po0c5uZ9UDaZ1+rblenN17D9RyG9ilagLc2hVfm1pMILA+h4I1f762ajwgq
	hjO0f7PqoKQMQTGDYqZPwXYH9Omnd6MJYo5/dTCIZa2Re5cPdQHrI22W8re3uO3k+wKJ6581bEM
	3wJvoTyRSN2MicsGhoht/dXcGksjPB3LaJAve4X+VfyZkE56SCpXHM7736j6mBRemcIfzgKavhn
	RhRcx8ThcG7VXXjzNyy7GbTneHs/e30emgn1gL8bNjBHHHTzIAqi4o70NU9F7INueMKdGFbiTAI
	1WzBlwy5XVVT9EMJL3MgZOlhmoE+2Nrv1qvk614R75iFbgYvHTK43ebawAVUkAY0FSizpMNMaMr
	92uQx+7bd3Fybawwwvy2bIXQgcr/98YZbyUVzs4BMGtyIwq7MCk4o70pj2VZRMIy8TGalNlf70a
	dSwphPpq1fZI/hYuA6aOQtlBLUr/g=
X-Google-Smtp-Source: AGHT+IE8qvj8HBsTwz5HGw5OIU28tMFtEpb+ccgQfqfh/iRW6PjNGYH658OE70RjYaYmTrjBpzvyzA==
X-Received: by 2002:a17:90b:2690:b0:33b:b453:c900 with SMTP id 98e67ed59e1d1-33bcf8e3d67mr49587249a91.19.1761547290681;
        Sun, 26 Oct 2025 23:41:30 -0700 (PDT)
Received: from z440.. ([2601:1c0:4502:2d00:599c:824:af74:2513])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fed81c9e5sm7276917a91.17.2025.10.26.23.41.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Oct 2025 23:41:30 -0700 (PDT)
From: Igor Reznichenko <igor@reznichenko.net>
To: linux@roeck-us.net
Cc: conor+dt@kernel.org,
	corbet@lwn.net,
	david.hunter.linux@gmail.com,
	devicetree@vger.kernel.org,
	krzk+dt@kernel.org,
	linux-doc@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	robh@kernel.org,
	skhan@linuxfoundation.org
Subject: Re: [PATCH v2 2/2] hwmon: Add TSC1641 I2C power monitor driver
Date: Sun, 26 Oct 2025 23:41:27 -0700
Message-ID: <20251027064127.648712-1-igor@reznichenko.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <d3365f32-dc92-4a55-91a1-c4a446558c5a@roeck-us.net>
References: <d3365f32-dc92-4a55-91a1-c4a446558c5a@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

>In some way this is inconsistent: It accepts a shunt resistor value of, say, 105
>even though the chip can only accept multiples of 10 uOhm. In situations like this
>I suggest to expect devicetree values to be accurate and to clamp values entered
>through sysfs. More on that below.
>
>> +	return 0;
>> +}
>> +
>> +static int tsc1641_set_shunt(struct tsc1641_data *data, u32 val)
>> +{
>> +	struct regmap *regmap = data->regmap;
>> +	long rshunt_reg;
>> +
>> +	if (tsc1641_validate_shunt(val) < 0)
>> +		return -EINVAL;
>> +
>> +	data->rshunt_uohm = val;
>> +	data->current_lsb_ua = DIV_ROUND_CLOSEST(TSC1641_VSHUNT_LSB_NVOLT * 1000,
>> +						 data->rshunt_uohm);
>> +	/* RSHUNT register LSB is 10uOhm so need to divide further*/
>> +	rshunt_reg = DIV_ROUND_CLOSEST(data->rshunt_uohm, TSC1641_RSHUNT_LSB_UOHM);
>
>This means that all calculations do not use the actual shunt resistor values used
>by the chip, but an approximation. I would suggest to store and use the actual shunt
>resistor value instead, not the one entered by the user.

By "actual shunt" you mean defined in devicetree? Then does it mean disabling 
writing value by user via sysfs and making "shunt_resistor" read-only or leaving it
writable and clamping to devicetree value, thus discarding the user provided value?

>See below - clamping is insufficient for negative values, and it is not clear to me if
>the limit register is signed or unsigned.

>Also, the datasheet doesn't say that the limit value would be signed. Did you verify
>that negative temperature limit values are actually treated as negative values ?

SUL, SOL, TOL are signed, I verified. The negative limits for current and temperature
work well based on my testing.

>This doesn't work as intended for negative values. regmap doesn't expect to see
>negative register values and returns an error if trying to write one, so clamping
>against SHRT_MIN and SHRT_MAX is insufficient. You also need to mask the result
>against 0xffff.

I was under impression regmap would handle this masking correctly when defining
.val_bits = 16. E.g. in regmap.c:973 it selects formatting function for 16bit values.
I can mask explicitly if it's required.
It certainly doesn't throw error since negative alerts work as mentioned.

>Why did you choose lcrit/crit attributes instead of min/max ? If there is only
>one alert limit, that usually means the first level of alert, not a critical level.
>Raising an alert does not mean it is a critical alert. Please reconsider.

I used hwmon/ina2xx.c as a reference. It covers many similar power monitors which
have single threshold alerts and defines only lcrit/crit. If this is a wrong approach
I'll change to min/max.

The rest of the things are clear, I'll fix those.

Thanks, Igor

