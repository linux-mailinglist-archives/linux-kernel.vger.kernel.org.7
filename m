Return-Path: <linux-kernel+bounces-777347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 28CC4B2D866
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 11:36:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BAED1C45F99
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 09:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70A272E427E;
	Wed, 20 Aug 2025 09:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R8r+wBI2"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 283132DFA38;
	Wed, 20 Aug 2025 09:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755681885; cv=none; b=m5pJ3A5DYo/quCanq9dn9cF/N+Dmahf5X982ZrXRLpXY2xTL7O9eT0Xt4sYADRIFVY7GfodVGJKBfmsN21kkv66gm6/B4ggVkVxnHiK1STYPAlBiK0zlcabihZzfrF5WPhFbmi+SxR6t4WrKX88ZnZe32DgIwp1VlPfK8t7JMEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755681885; c=relaxed/simple;
	bh=YsfcxELiFOAmXJc5KTYiZD/18VbXLmuSDnLx9YMu14k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oXw+/pfG9WuI2ZD6k9Ohe7MEz282jfGmehe0QkkJb0o5Q3x8mXcwals1B1HDRk/coP8pCvEO60O+25hL+Nb+KHrNM7QgteylK1WXYfHbiovNdiD8y+NNhy2v5aX+T9KDE8uNAVC1JIt12jDbTSWsnKJZ2QG1kV0+0SL9m9gySkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R8r+wBI2; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-45a1b0c82eeso51385005e9.3;
        Wed, 20 Aug 2025 02:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755681882; x=1756286682; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JLt3gt1qsOBWGIq0JApuia3SpB74W9+IWd3Q2SbhflM=;
        b=R8r+wBI2GsYIWNlGAXxwexHtmnbTQxXYkMR42vaUDj3K0G0fbxk0NR8VzRqKx9BUuz
         kCldALFPPq+wJ5JUWRXgdYjMKD7MHkaDRmhOxD5InnCEGWbWb95LAqzTVnIjiti8VoFK
         EIe88WZHZTCvDVhpFNp5hEUZxlfx/hvIBvQowm9ZHNYH3Ylyryas6MDF1NmW8bJybvUe
         ix2rG4tCzRU5s+yfjCMn8gh966dzpvjsu3rUHc2bmjjWR1J6YFy38rq/nD0OH80UItU2
         0yui64d5zWg1fg9j5VH1QW37d3466z+d5FBc3Yq/UikoBWSZ3z7G16n7ix5NfJz8LttW
         Rtag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755681882; x=1756286682;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JLt3gt1qsOBWGIq0JApuia3SpB74W9+IWd3Q2SbhflM=;
        b=iev6ffh4ytPVgY3fXbexk3Dojqm8w6fIKqSWEFDEyjJSGOzRXDVFUgerfVhowQFgJW
         QOiLPZ6o2iJ4WOz2FhN9C6ZEcnM2SdOfqDiXV3TSRSRdZzsB1ZmdsSIQIhRBEgery3Vu
         4dnqnkTScyNwBhXHnG38+junFOEPYpqt1lhMpmNdG7fzhpLMtLVVS16omGm0fz6jLrde
         PvZMqI7m9JS5Q2FVYR+9pmVTIemNygwLEzOffj4tW253hL0BUNl1WSViMhio9Dm+BA54
         ESGrPVJnukE5H1vk+8+gWMJwpTlLxmovDuHMHjwmLZN6/6NHkFp7tvXVwbNP6KzAXjqc
         SbrQ==
X-Forwarded-Encrypted: i=1; AJvYcCULI9/1lgPvmxUJSWPerYjgXGhc1+ElrNzTvMn64oeC1JPKPJTe3LANsmEZDX8Bzjz/645pSo7Kf2bRxFU=@vger.kernel.org, AJvYcCVn4x5WnF9CbSgTyco1uRStFTxrvJZvWIA6d1F83kAYqDihrua544tUSGPQQoyWPlVWIUT6PJkdSB9js/E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9/XNiDRBH6Fp1bystU4Kf32YdaloM2tGV9NyFaUfeSWWGVUo/
	j8VwuEPivVvY+Pg2jZZQIgJqyWlyFfBC3vqmDzVc20CNy75tY4G+53BA
X-Gm-Gg: ASbGncsownQ1KqMGZfqqO/Ih0gZIEPynucsDlMM26CqISLxpiXx8LlYTP8CCU7eVGJD
	PSlG4lLcIt5nODZBfi3iNk+Zr+rFJZ2a83yhY1UQEPm5pvA4by7hKllBEa/ER6k5LDVNmNeqsdE
	GDZWfWR0Ewzxh29Ys54tb2LH2dNw4blVjPYKBub6IGtcbRzTC7PWdhf8pQ6/7S887D96ioUtItM
	OExv0GnJJzRpAPUO0ZkK9w7fAhMkGUZnlO00cc9+ve5lPjd879Zk4qh7/iOyk1bZHFqt4J9PCIu
	4dNYnNUnct6JLczmm4aSHwSURTUsrrvnaFFmKA0lUwNzSR4sz4sxHjZLwt6YkT1vwkgqGPQlrrx
	tlkKILAtG4UKRhKAlYjNGFKuJQZ4eLWCP2TnrfRgvJHK2/8trwN0Nyw==
X-Google-Smtp-Source: AGHT+IEdVvSfP6hR5d/NgsKUNuBQLvsUVo4gp5lpQ1tZqbTBQDyAyiU5nZrefErtKOVZia6oMgAdHg==
X-Received: by 2002:a05:600c:4706:b0:456:27a4:50ac with SMTP id 5b1f17b1804b1-45b479f3499mr16501435e9.23.1755681882203;
        Wed, 20 Aug 2025 02:24:42 -0700 (PDT)
Received: from [192.168.1.129] ([82.79.237.20])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b47c8e98dsm25578115e9.14.2025.08.20.02.24.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Aug 2025 02:24:41 -0700 (PDT)
Message-ID: <00984350-97d2-4aaf-96c3-091f15ec1254@gmail.com>
Date: Wed, 20 Aug 2025 12:24:40 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ASoC: SOF: imx: Remove the use of dev_err_probe()
To: Daniel Baluta <daniel.baluta@gmail.com>,
 Xichao Zhao <zhao.xichao@vivo.com>,
 Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
Cc: lgirdwood@gmail.com, peter.ujfalusi@linux.intel.com,
 yung-chuan.liao@linux.intel.com, ranjani.sridharan@linux.intel.com,
 daniel.baluta@nxp.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
 shawnguo@kernel.org, s.hauer@pengutronix.de, kai.vehmanen@linux.intel.com,
 pierre-louis.bossart@linux.dev, kernel@pengutronix.de, festevam@gmail.com,
 linux-sound@vger.kernel.org, imx@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20250819112654.588527-1-zhao.xichao@vivo.com>
 <CAEnQRZB=fq7=ahMkFWaQ58SR_yftSTYqZKFBh7YEXz2M7PyXsQ@mail.gmail.com>
Content-Language: en-US
From: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
In-Reply-To: <CAEnQRZB=fq7=ahMkFWaQ58SR_yftSTYqZKFBh7YEXz2M7PyXsQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 8/20/2025 10:04 AM, Daniel Baluta wrote:
> On Tue, Aug 19, 2025 at 2:29 PM Xichao Zhao <zhao.xichao@vivo.com> wrote:
>> The dev_err_probe() doesn't do anything when error is '-ENOMEM'.
>> Therefore, remove the useless call to dev_err_probe(), and just
>> return the value instead.
>>
>> Signed-off-by: Xichao Zhao <zhao.xichao@vivo.com>
> NACK on this.
>
> Quote from dev_err_probe documentation:
>
> ```
>  Using this helper in your probe function is totally fine even if @err
>  * is known to never be -EPROBE_DEFER.
>  * The benefit compared to a normal dev_err() is the standardized format
>  * of the error code, which is emitted symbolically (i.e. you get "EAGAIN"
>  * instead of "-35"), and having the error code returned allows more
>  * compact error paths.
> ```


AFAIK the kernel logs are verbose enough on OOM errors, which makes prints

such as the ones removed by this series unneeded (have a look at [1]). Normally,

you'd get a warning from checkpatch but I think these logs slipped through the

cracks because the error messages do not quite match the expected format?


[1]: https://lkml.org/lkml/2014/6/10/382


