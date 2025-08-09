Return-Path: <linux-kernel+bounces-760926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62A96B1F206
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 06:07:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5670A18C81E5
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 04:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D415205AA1;
	Sat,  9 Aug 2025 04:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zmk8QCU/"
Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A052612B93
	for <linux-kernel@vger.kernel.org>; Sat,  9 Aug 2025 04:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754712442; cv=none; b=a7JL1IiaNgvG9yDpp/xKkWYt2gNgjMuomrUrloyUL5I0LJ3YYaJORsmiksfUUe0sZcYO3x0Oa/LDN7vstR/1txweJa6uoq8jPqSMw7T420zfTszXQohLh3UlaiiYFz3yfaQRd2n0opQ7fzi/C9A6Vcqcmu68GjwcSffOxsDdhsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754712442; c=relaxed/simple;
	bh=JnyL+EiaRaXHqjSKyy87zvlcoGxfSfvso3ivJEnIHYk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H3llt9OM8z9Mp4Jz+CzW6R5wvth6lfXflvsXLbjqmF3pQJaXVlS72QtlUjMFkxrq4p40hFMxPtb+IMqacMMG7suDIGIOgoLwCwpS1Hg3mZoFfI/W5p/jIWSaQz+uAlsWcq+xDIHmvUaIAPlz21D0bGgRQCXIb86Bwkv5h/bQ3sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zmk8QCU/; arc=none smtp.client-ip=209.85.210.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f196.google.com with SMTP id d2e1a72fcca58-76bdea88e12so2567699b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Aug 2025 21:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754712440; x=1755317240; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=epn+2ezPixNvNrvA//sjaeImGsDBAZz/BV3lNjr11YA=;
        b=Zmk8QCU/E5DJLhuZ5i9/fiaW/By8q+6Hn7FK39EK3mbO4iKoboqbmRffUjE+GtIdFK
         KvKev16o+8eNHhcB/iGMeJ0vaUENE79M+EKQ57aBc3IuJe3KzU587NedPHZa369uD9U5
         5F0k8iv4AK0iZBBE0n++Thv2dpE4CwigHyU83fOb5i/t63ENLl8XatrTYUOAOzsWuMYS
         sh9b82ZuhPr9SA3DdyFr7hkRXDCedj2fGBgu7qKfVj5HNmHDdZXoZtE2mpI9Z/7tuzJW
         uzPW930DWYO1xoQ2McVgxguuB0hbZoINcnQT/1q4tbZI4E2k5hU9/4p+vG+UoPQdfKxq
         EwNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754712440; x=1755317240;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=epn+2ezPixNvNrvA//sjaeImGsDBAZz/BV3lNjr11YA=;
        b=hNRkov787Rla5UTj7TLtE9EDFLpazy5lGYlJ96FPEPxY3hZfvn4vls+bAW7OCAp2tH
         iWD7xVP+r7WqX2inJe0zTg8X8pEQ6Z3DhlwBDVDcsKoyP6y0MGCXOVb1tATe7Xdgw0dA
         dzItk1MuzO8nrvgc6ju9HKQ+O3DtBewWBmiXyguvCdznSxb+capq8sGXs0xC+irARSco
         6JffhqZgqW8IoQ91nd02ukyAmAA6fxbzo69VPJGcg+BmqTpcRO6w9EwkbD0VC265WxvO
         vuswoL3+seLE1Xs2yRXBxRZ3fiktUVAiKtbVfv6qENUp4TYc3HoY7+YJL53IDeRTK7la
         uFOA==
X-Forwarded-Encrypted: i=1; AJvYcCUbm1vmUz9aoWHK1cnHurUop56KzrDXK0ELvwl7iVRb/S2i4TJymKbWeMQf5+B9xgHHx5bpn0fj0Ch1l2k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6nZMSx9wOJENh8z5kgOcIohRlCwRONpszliV6A+wWTphPBUcE
	Hz09H2cWw4ZWkgx7X1HDHFjmHx1a8WdtvH2ngRO++X5jDkjZk2SydDVO
X-Gm-Gg: ASbGncuXoJ42DJRCMgxu9gNNH9lHZkgH+3/cDR4MJhy7t/yRpq+Gsr2lyjNtvElN2f4
	41RWkNpnRqU7U/i/rTvSVCPXf4EuVlb0mclTZuqrPHK7rDH+q4GQSp4jZmZF+kmz0IpOEaDplFt
	bT5Yda8Qf/Xhu0JA64otE6fvq1pFpx6ZEKUiBBFkhosSquzoEdaLUJxCCHNO1BoC4E9FJS2lAHq
	1yqDhAWWWWNEfKVSl7Xz/UXoLnlyAhma+x0Ta/usg+bPcQbVQe4ooA23WzgjoDH+TbYRoVm4e/l
	Uiqy5EwdepN/+o1RtMp5tgdw1MXz0L3KPdRKFPYn24Gt9eLhvgfJa/OrxQBE48Q4H52xjJuiXSw
	+35HgJv7hsh8bt2aX5yONobt8Wn1zDlNm593phpScyX0DafGJGJ+S
X-Google-Smtp-Source: AGHT+IH5j9I9BsuiDB4eW6lfpM3vvVtUVN1w7L5oWM23S/YVqneeQAa59hnt3PjHkjIaRVUxTMhhTg==
X-Received: by 2002:a05:6a21:32a1:b0:240:1204:dd2 with SMTP id adf61e73a8af0-240551af604mr9060363637.26.1754712439798;
        Fri, 08 Aug 2025 21:07:19 -0700 (PDT)
Received: from [192.168.3.3] ([27.38.215.165])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bccfbce4bsm21390749b3a.77.2025.08.08.21.07.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Aug 2025 21:07:19 -0700 (PDT)
Message-ID: <0dadd6c5-3790-4887-a370-69cb7f0cc0b7@gmail.com>
Date: Sat, 9 Aug 2025 12:07:13 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] watchdog: Don't need a definition of the perf
 fallback-attr
To: peterz@infradead.org, linux-kernel@vger.kernel.org
Cc: mingo@kernel.org, akpm@linux-foundation.org, song@kernel.org
References: <20250727032516.10063-1-wangqing7171@gmail.com>
From: Qing Wang <wangqing7171@gmail.com>
In-Reply-To: <20250727032516.10063-1-wangqing7171@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello,

PING.

Thanks,
Qing.

On 7/27/2025 11:25 AM, Qing Wong wrote:
> From: Qing Wang <wangqing7171@gmail.com>
>
> The 'hardlockup_config_perf_event()' only overwrites the type and
> config of the perf attr. It's wasteful that redefining a big static
> variable to fallback. It’s just a matter of simply fallback these
> two variables.
>
> Signed-off-by: Qing Wang <wangqing7171@gmail.com>
> ---
>   kernel/watchdog_perf.c | 17 +++++++----------
>   1 file changed, 7 insertions(+), 10 deletions(-)
>
> diff --git a/kernel/watchdog_perf.c b/kernel/watchdog_perf.c
> index 75af12ff774e..08b9acbd2aa4 100644
> --- a/kernel/watchdog_perf.c
> +++ b/kernel/watchdog_perf.c
> @@ -92,14 +92,6 @@ static struct perf_event_attr wd_hw_attr = {
>   	.disabled	= 1,
>   };
>   
> -static struct perf_event_attr fallback_wd_hw_attr = {
> -	.type		= PERF_TYPE_HARDWARE,
> -	.config		= PERF_COUNT_HW_CPU_CYCLES,
> -	.size		= sizeof(struct perf_event_attr),
> -	.pinned		= 1,
> -	.disabled	= 1,
> -};
> -
>   /* Callback function for perf event subsystem */
>   static void watchdog_overflow_callback(struct perf_event *event,
>   				       struct perf_sample_data *data,
> @@ -114,6 +106,12 @@ static void watchdog_overflow_callback(struct perf_event *event,
>   	watchdog_hardlockup_check(smp_processor_id(), regs);
>   }
>   
> +static void fallback_wd_hw_attr(void)
> +{
> +	wd_hw_attr.type = PERF_TYPE_HARDWARE;
> +	wd_hw_attr.config = PERF_COUNT_HW_CPU_CYCLES;
> +}
> +
>   static int hardlockup_detector_event_create(void)
>   {
>   	unsigned int cpu;
> @@ -133,8 +131,7 @@ static int hardlockup_detector_event_create(void)
>   	evt = perf_event_create_kernel_counter(wd_attr, cpu, NULL,
>   					       watchdog_overflow_callback, NULL);
>   	if (IS_ERR(evt)) {
> -		wd_attr = &fallback_wd_hw_attr;
> -		wd_attr->sample_period = hw_nmi_get_sample_period(watchdog_thresh);
> +		fallback_wd_hw_attr();
>   		evt = perf_event_create_kernel_counter(wd_attr, cpu, NULL,
>   						       watchdog_overflow_callback, NULL);
>   	}

