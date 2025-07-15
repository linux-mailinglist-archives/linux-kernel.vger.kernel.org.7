Return-Path: <linux-kernel+bounces-731907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E85CAB05BF8
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 15:25:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6DD71C21338
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 13:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FFE92E6130;
	Tue, 15 Jul 2025 13:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uEBwMwuv"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE712E54BB
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 13:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752585851; cv=none; b=U68X+LZ8ztOlpKUjzxyPXG+kCPneRxVCwG081/KKFlLIdSGRW/3/aEdtipOVnZ3OHqktgy6AsPkzsIId5AuFhZJMxQ+tpaRw9duh3GnNOiRqcCqAtSO2KIPOyIKFgq93ly8W8Wz/diAiOzQ+cQcC4BH5TwoAZzHYBfu2s60QX9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752585851; c=relaxed/simple;
	bh=xu71qnr1VwTZ4+bd4q94HN3+XBjexaGP2P8tok7p9Ok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l7MUodLex09bF4bWHqEQt86XX8vXiqxah9RgCK3YYrU5P5/Jt5UBDVHF0n/7QYtetk4oE/3RaZdBdI6Q6Ashe1DPsUUY93sQigC1hkhLhD8UMEONa+6/686+xpc9q4g/J5LjEqhECAeVCVI+Vzf3D8oAmSJ2oS5QkbWeAjzbCXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uEBwMwuv; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-455ecacfc32so17638055e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 06:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752585848; x=1753190648; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GOiczrZQ07TlImzuWhdRA1uRrJzdt3bEMH2PMY2Z0lI=;
        b=uEBwMwuvJT0MN4aDF61fLsG432xgTAadfknqPLD4BE4jGhvs0NBx12pjYPMxxKLP4c
         M4M+4TfhUxrGAqFen+tEGSJdbDlGvSkJeQH30Se+5kwaaR88kYZHgSLsQ1Y5Ah2jVnjt
         IYvC7BbieB4b3prdWg4V5IIUrTJkCdBku8xkxYIC+YyrJCHFwASy9yXs3ZiTJRt1iXOy
         DVaZZMFIUhe6gRuUURSq6DKcO0sBSyO8j/B3eueHeIB4zPZoldUOchAP42UDjYU77O4o
         WhGMIUucBSzMEl+ymv/+wmRm1guXip1f2geDDm69R2wxdFk958ZOFoY+7YON74aBAuAs
         KbKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752585848; x=1753190648;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GOiczrZQ07TlImzuWhdRA1uRrJzdt3bEMH2PMY2Z0lI=;
        b=OYtU3IZz6C+VPccU6UgXJ2NVxCxvKBUqnFVGK4PDQfWgelyhIcYPQufpeqDdcQLQhQ
         WQzcMaXPOPrg0VvcF/ssHKExEYeYvHd1ekHO157IJUrjLIgrVPv/E74TvAh39gt2l68Q
         oUgVEu+R06Mn+lMhPThY3ezMLYVS1VY8KKgrqvfl19nGtkEcmT8X7xGpMFUPegpqkMOV
         Zp3eHpJrFqqDaQiKB3lI0mTFLBz04PQdqleHHbTdkqzQExHrnuoJ3Bb/Irsb6dx9P8Ny
         /pWCC+/uCKms2+mbvu9kmi+nTeP+fycZz8DpXccZyFzRMMbfhTCFoiLRVaAgWbGZZnkD
         p99A==
X-Forwarded-Encrypted: i=1; AJvYcCWIO3pJDOi7DNNFmozCdXCVdgr/sMMQIHK4cgm4w6cFm2WntVGU8fP0uQrYlQ23M8KHoYUmtjroSubcWLU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6kzEqveFI3XwHb2h2bsXWOnegTjg0m3lpQ8DpOBW83U1pHrmw
	qleqFrxaIdbwqcUtP4Xucu5wQSE39hdYzYjWQvImT2cvFtR/Yp5wEnCN92DaxKHPM7E=
X-Gm-Gg: ASbGnctQHBY6O9Fm8QhAMEWbLbk4g40zJBhzVNIo65/CHHALtw4i9MkhnnzMPPBBM+X
	zlYkrIAN/OVPxlCU5HQDZKC/IKcW1q/HLO/aiKDfp93M0G6pcyFUUkTZ/6qIqEwWbMa1o47n4yV
	uqNFdte3KftsXr+OOV/QmKMg/38fJLn6nnDc2lg7lsKNvCn6vjiQ9OdeILd42Bre7QngB8gmyvL
	33y4F1ULlQVHRQ1xRibdZvikw/KqiDOaH1zQSrqr2LmVQKMY4y61VO1+7LZQAWQQToWwQCkVOo1
	XBBWeUYxCNy1BoChklG88nBGyvhs8Ml8eUCK8HO3oF0H7Z32wKm2zXoBup7D3vx/kug1nj1Ej6v
	Pt8a1sEqVDjiR7GEcrCOFAl7FChYnnoQnnewKQTMGeM4qI2N+FfCMa82ANSEu
X-Google-Smtp-Source: AGHT+IEs+ScYaBoPod0KS92i4ye+McpE9jOei8lbZ41OgzZYALXJoP1+s9eQ2gbL76aM01wUZbMIAw==
X-Received: by 2002:a05:600c:1ca2:b0:456:1a69:94fa with SMTP id 5b1f17b1804b1-4561a699783mr71744425e9.13.1752585847534;
        Tue, 15 Jul 2025 06:24:07 -0700 (PDT)
Received: from mai.linaro.org (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4561dd91072sm49780995e9.14.2025.07.15.06.24.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 06:24:06 -0700 (PDT)
Date: Tue, 15 Jul 2025 15:24:04 +0200
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: zhanghongchen <zhanghongchen@loongson.cn>,
	Yinbo Zhu <zhuyinbo@loongson.cn>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH] thermal/drivers/loongson2: Constify struct
 thermal_zone_device_ops
Message-ID: <aHZWdMSYDsjebRh-@mai.linaro.org>
References: <5f5f815f85a9450bca7848c6d47a1fee840f47e5.1748176328.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5f5f815f85a9450bca7848c6d47a1fee840f47e5.1748176328.git.christophe.jaillet@wanadoo.fr>

On Sun, May 25, 2025 at 02:32:30PM +0200, Christophe JAILLET wrote:
> 'struct thermal_zone_device_ops' could be left unmodified in this driver.
> 
> Constifying this structure moves some data to a read-only section, so
> increases overall security, especially when the structure holds some
> function pointers.
> 
> This partly reverts commit 734b5def91b5 ("thermal/drivers/loongson2: Add
> Loongson-2K2000 support") which removed the const qualifier. Instead,
> define two different structures.
> 
> On a x86_64, with allmodconfig:
> Before:
> ======
>    text	   data	    bss	    dec	    hex	filename
>    5089	   1160	      0	   6249	   1869	drivers/thermal/loongson2_thermal.o
> 
> After:
> =====
>    text	   data	    bss	    dec	    hex	filename
>    5464	   1128	      0	   6592	   19c0	drivers/thermal/loongson2_thermal.o
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> Compile tested only
> ---

Applied, thanks

-- 

 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

