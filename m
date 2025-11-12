Return-Path: <linux-kernel+bounces-896802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EB5C2C513FC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 10:02:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B754D4E754A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 08:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 730792C026D;
	Wed, 12 Nov 2025 08:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L9n5zMRs"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 106622F5302
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 08:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762937935; cv=none; b=tK1rgsTW0BAhb6lbOu0MjEW+1l3rV29fBg9UcGynlc81q2ceJPoLG7N3IB9bf9dYRKQ8BDpnULYV7UoCZuG6dFvdEbfRzzGhAgs7ObcQoKFsC+3bvYDuufnQVjGFUx4Qs063gSxu/X2tkj1cVOB9AnvB4QN84uv+Nh/Zuawa2do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762937935; c=relaxed/simple;
	bh=BvJ9QOK1WudzEqe/mVP9Qch6KeES8Cz5wJTG2FvjEcQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k6oRaro/1tny3k/iD3xIF+tUze+nq2bqBzzFta5f465XVjaoit92X9AT0uDFPpIj04FkNERjFHO6F6LtZVhxv4MM5DLqlyM4vq/8pcPOG6JvdXRIUym393nBJBmC+0Yicd/ENNOgJrwkfOB15IDpkRXmaRmDydEduwxcQo+KOig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=L9n5zMRs; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-47777000dadso3648635e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 00:58:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762937932; x=1763542732; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2PM3V5SUOmIRwUEw+SelsziXLyJorncDb0vBfck6mjc=;
        b=L9n5zMRs+o+zZfxlG77C4v/E7UOyD2TnHRPNuFe0C4f9WeJGTI8wP75Qs+Tnry2TaC
         uKpy3WsT6pPvvTdMbfScfHNj6BWQdl6svZ4gnDBl6HBQ7TBbVnnMm1Yuu+FxEoZvltwO
         J6BVRFp2jKAKKaqSq0nCBjFxP+psQhJ7hVCPb6s8gYcK3oYQ6WGtyCBUnW4pjaykbwyC
         DrCRsA8s85f/i08GV5vp7FoKsg0uU4YsO9CzX8GYSRfOygifXkiPGJmgOeWwkN8H3HKU
         abQnoXZbrwVGXsgiZ9QkEtU50RzoxQiYEMDPWJz75CzJp/2FjERA9xelnNQ7uN291e3e
         a9hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762937932; x=1763542732;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2PM3V5SUOmIRwUEw+SelsziXLyJorncDb0vBfck6mjc=;
        b=SGnccI0YXpNGkvngY3RjMHdWp6SEOq3xUV32ln+vzZnwig8V3YwpIBY7Di/Dj8xTVC
         3sNup9uDC7d1zRbtH1Joe4elNijd1jR2adVt11qTX4coavLzunwuhC/1zdCVF7CmqWiM
         xyODKJiZ6Nk8ZiIcozCJnI8lvR9SawItWQeWdR9gnI5cs0Yfr0Oa2tnRcY8KGkEd3hBu
         LgtQ9E/1HZK5E5S2DxsT+6LtQVJCzy9OCQZ0H7LnI+MZpvXEkhCD0AAREK2cfW41uT3O
         TASfOGB8sB+JFtqOe0stdpONHQzJLzPMR25fkWhJFw6CFmj4Hx91qxMnZRz1jhHrHVR6
         TGew==
X-Forwarded-Encrypted: i=1; AJvYcCWEl9WXNtUXsfDIMv4BTD5ETW5h3a4AsOwyOYXPwvDCSbTDFseVxZdoOCiz7yoJlmLTl4Fyid9q3fRTE50=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6+OH6S7R3TqAu4kBJaIcfeuDulrogYKliEu5Q9HJ3P5ifXQWM
	8FZXJgspWtMe3xlpOdtth6zoV96TNYB3f24BjRM2I04srBP9eSf07bXHovVzC/TIY4c=
X-Gm-Gg: ASbGncus5qLO/oeRUd6QFpyYvTg0VMAO3rhzYfJSLXPBwK4rslc0ujPeuAbnoRUySf/
	Nu70ghW036zVKtCaOTEkLRQ/pzF7n579t1zBKq/GOQOvAZbQBN+NeArJjvu4e55Ju9uStEv9t+S
	a/+dCOeVu5HjyhjuZwG+Xs8PUiNqxZu2KKZ0CHPvrlO5tAvjuPmTWG6BC15j/zuhcYkOE69VkNO
	wJyZHUbbgAHpPaRxEQoHp23UFKws0dr41xFt9yIZrWwRC4JTdj6ZhKIV+KnN7otYhPQcHKmHZbg
	BufJNe8VoNrSTudVzRihJwHmyk2kLsm6iG7wF1k4kVxohDxebK8ua0UWJFDz4KLF/wl3gJrvBRP
	zWkn99gwo1nyzK7YjI/mHYuMs7NfIVbG8/YQKttyvC+nj3JJ6OgiPuSvdajBuB1sJIz1sErar
X-Google-Smtp-Source: AGHT+IGGVYvDUcqcUiPZLSUtoqDWfq0dWOAgjoDY5T7sj0q34JOuNXmckY/tBFbuwEb7ShY09sMSJg==
X-Received: by 2002:a05:600c:4703:b0:46e:506b:20c5 with SMTP id 5b1f17b1804b1-47787086800mr14036335e9.26.1762937932076;
        Wed, 12 Nov 2025 00:58:52 -0800 (PST)
Received: from linaro.org ([86.121.7.169])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47787e48853sm23640245e9.6.2025.11.12.00.58.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 00:58:51 -0800 (PST)
Date: Wed, 12 Nov 2025 10:58:49 +0200
From: Abel Vesa <abel.vesa@linaro.org>
To: Haotian Zhang <vulab@iscas.ac.cn>
Cc: abelvesa@kernel.org, mturquette@baylibre.com, sboyd@kernel.org, 
	shawnguo@kernel.org, s.hauer@pengutronix.de, peng.fan@nxp.com, kernel@pengutronix.de, 
	festevam@gmail.com, linux-clk@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] clk: imx: imx95-blk-ctl: Fix clock leak in error paths
Message-ID: <y6ospgarjnretdsankhgtudttqqjfhltjyt2u6hnejgeufbkcb@yhk7ejuexvr5>
References: <20251111114123.2075-1-vulab@iscas.ac.cn>
 <20251112023025.793-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251112023025.793-1-vulab@iscas.ac.cn>

On 25-11-12 10:30:25, Haotian Zhang wrote:
> The probe function enables bc->clk_apb early but fails to disable it
> when bc_data is NULL or clk_hw_data allocation fails. The cleanup
> path also misses pm_runtime_put_sync() when rpm is enabled.
> 
> Switch to devm_clk_get_enabled() to automatically manage the clock
> resource. Add pm_runtime_put_sync() in cleanup path when rpm
> is enabled.
> 
> Fixes: 5224b189462f ("clk: imx: add i.MX95 BLK CTL clk driver")
> Suggested-by: Peng Fan <peng.fan@nxp.com>
> Signed-off-by: Haotian Zhang <vulab@iscas.ac.cn>

Next time, please do not send the new version as a reply to the old one.

Everything else LGTM:

Reviewed-by: Abel Vesa <abel.vesa@linaro.org>

