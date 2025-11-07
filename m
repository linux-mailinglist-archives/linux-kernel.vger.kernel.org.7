Return-Path: <linux-kernel+bounces-889835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 753B8C3EA50
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 07:43:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2CC3A4E38AB
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 06:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 077212FCC16;
	Fri,  7 Nov 2025 06:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="mGD1ZB2V"
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ACD6280A20
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 06:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762497829; cv=none; b=TGM51gIdX0khvZQ/Gb5dLyQqBNp/APS+Vmk5xRvwr90sWMaAJRgFIUdo0hgNVljoJIo2DLzLHeMs07+xSyLcycx49WXDsM1B9T2OYaWPRXVDK15r15Pp3s+lyTtr2x7/YjPDURF9JdgoHvYvMy13uiD++IossyA1i/K1nQqWxHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762497829; c=relaxed/simple;
	bh=QlnseWgE9VkLnfgPPydMkc/XoZxLIdS+ECn5ce9XIJY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=bj4zIG0Jj7Sy7jP6vx0gzeuTGjmcfpXg1Je76Me1b/G5KFIUYm3VKMGpRGEjw6XxBgqrn9v5s8uIWOR45Q//av8sPk4tJ6ho8aNVY48eneBB1oMs36EjA4FTfHy4bUXUoTCcqsW2ZPv1IG0R9eudnycP3dGdgCyrKXOJH0n/WaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=mGD1ZB2V; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1762497816; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=RSCzbPN9cdwbT1ymwtr7qizeNrAGA1scXH9J2DjCw3A=;
	b=mGD1ZB2VEzAdwJ1mziUuo/7VAFqjX5hkWxi5C3Wp9KeOWPqbsPh6UZ9+ls5wubgs+Srl2acaN6jULcbyqNNkEC7m0Yu8IPRWSTTlb+4IrPeQxEhk+T84Uji33GFH34Zemr724885qq3HNAfz8a/Y5AHN+GbemC1G2FKBzDs+plA=
Received: from 30.74.144.249(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0Wrru8xo_1762497815 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 07 Nov 2025 14:43:36 +0800
Message-ID: <f435dac0-eb2c-407a-a01e-767addc667b8@linux.alibaba.com>
Date: Fri, 7 Nov 2025 14:43:35 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] clocksource/drivers/sprd: Enable register for timer
 counter from 32 bit to 64 bit
To: Enlin Mu <enlin.mu@linux.dev>, cixi.geng@linux.dev,
 daniel.lezcano@linaro.org, tglx@linutronix.de, orsonzhai@gmail.com,
 zhang.lyra@gmail.com, linux-kernel@vger.kernel.org, enlin.mu@unisoc.com
References: <20251106021830.34846-1-enlin.mu@linux.dev>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20251106021830.34846-1-enlin.mu@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/11/6 10:18, Enlin Mu wrote:
> From: Enlin Mu <enlin.mu@unisoc.com>
> 
> Using 32 bit for suspend compensation, the max compensation time is 36
> hours(working clock is 32k).In some IOT devices, the suspend time may
> be long, even exceeding 36 hours. Therefore, a 64 bit timer counter
> is needed for counting.
> 
> Signed-off-by: Enlin Mu <enlin.mu@unisoc.com>
> ---

LGTM.
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

