Return-Path: <linux-kernel+bounces-799934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 803A0B43165
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 06:52:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7CCE177AAC
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 04:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B13221254B;
	Thu,  4 Sep 2025 04:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E7ws/55A"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F84423A9BE
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 04:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756961472; cv=none; b=NQ26dcrfMdIOyDrhFrREvYQ7cML3WQtOToVRlEvcVfJmL+XNSxt1j8bPeLtkDc91I65+Bs127t/ajzYSSjjbeTy07mwsq259tS5PmIcmeUgGyRQ+FNZW1H3Q7Zq+Atxci5qSmH6geF56u43eRTc/m6rtd+zZasBoAr2I7iZ5lp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756961472; c=relaxed/simple;
	bh=wjqjIiSphWPTyvtrvZeyKZpf4cqcuUdpwB5iI5kacjo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MtN063hY+BBltU8dyNe8ybm8u8BjdQW3L1M4vmhai3jfRu/Gt7cUZuxlUHOPmqZv05JyiWvmXm29AhoXzhtt8oTlBTAvDV30YjMUBb6o8X85iGX72/7NBIUB6Ofd/t8rCZTPs1JzqQiPAWs1pMSVyxEbuGEohf5Seo7J85Z3z/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=E7ws/55A; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b49cf1d4f6fso396290a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 21:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756961470; x=1757566270; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Npc2kRdoiAQT8Oq6xsDbKE8d7v4q00xjFvwRzwJUB5g=;
        b=E7ws/55AMyZm0/qk4+73N7RZTJwmW4fJN0Yr9mPd5UJj1V7f6YXAI9yXbjxPq6w8HY
         sMa/W+Dfob+uXVySkztVN6VtsBtvnnwPC7gd+CwFz22NHQAycNteHWaMlACvbWPHsLRr
         MvhNaXG8OXPiUAjbql4LaANf6I/RuNaAYz+RI4GsAf6rpdH/F3l9WoeCDUINAzD0QsS8
         gqxOnm+ps0UYdGOoPXA29kwL7pt4Lq/qwGE3LZw42kM+ScuBVOUB5gnAZuqR28JeBOuP
         NzgeaxpD3BfWM1PYYPb8sTQopNxxRZaYl1qNKgobaSg3BfB9YCd09Iaqjzvi9jkZ20S2
         gqzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756961470; x=1757566270;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Npc2kRdoiAQT8Oq6xsDbKE8d7v4q00xjFvwRzwJUB5g=;
        b=uiD05yYMwRZlo9Wh87XmItUxJZmgt8BiApNufU//4HYAkw8tbuEjGXduniqT6Lz3Vw
         afxxmqffxrfhkumqMh37Aojo1F7eGhufEXOpUysyr90356H1YSscADqbMqZHNIgwWOQ6
         bU6tifBO5AprNkWHkXOjOFfn32w737LpNl4uDy2jrt7j3guBnD0JZn4MN2nHUA0a+w7M
         ZTBis1XbEM4l+6q/pByy5JT8fLwIY/SSDxQEOpXMRBB9/5+B39AykKr/e/4GH6YA/ttB
         VAQsdTGqlyjsgmeJ0Q+7D6in1A4IOW9i/b1cBYnqipxdprABtcOICw7MwMQajAkmC+nC
         lClQ==
X-Forwarded-Encrypted: i=1; AJvYcCXkB6hm6XW48Ta0gg1qKf0JwIYUA9yXPqytymyLQWmhrtrGgeEhxeI43+ueXS8Ti0TKZXcdKgA4sCIIKLw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyD0l+LncTuvlrbkp1Dg5mP+ha8Yrp10UxGibXEa987Y0DeF3kU
	mBjMIGSBCCdS1/Q0O5rAA1kqGpzkJ/YcclsRv/6htIXYWVAbJi/ZJVOigtu+kLW0lzA=
X-Gm-Gg: ASbGncsL7ML6c+syx89ii+6JmuB7N8zl05pCV/dNeWDRMJgjaU4Tk4NWpE+sLB6V7wp
	8DJtBDXhMKcV/YxfdEbmZJhI8tft6uxz+7vCIZmNd+Gik8vngwMNPA69Iem9qlFi7A+L43MA3jb
	CQSypJJrhR+rQgIZFJaNAHGTmB/l6mBVZyzygXFKwMx83I4MGLiGxeLP+4sExyO6t/h+S+DiWBr
	kX/ac30u5OKZGlY+qbFUWcNfm4EH670HOknYYSRNwxmhfyqLV7EcDiYPK1aCzz3FLDBTw5effJ0
	r3DO9sSXpXPjApu2Vn90cLE6hfr3+D6B1ypOX9PA+upq+nQckHFWrgv3IuWBlgw+vwZqFL4ipVK
	H+D/DDfjbXrZ0UO3WE0ldEr9yINJ0IgmhbQI=
X-Google-Smtp-Source: AGHT+IE8fhkKtW59L/QwQVMzIGYIlMT+Sa1j2ECntDz+uUUuSYYnswDb8stymALrifXH0JUgm5Q2WA==
X-Received: by 2002:a17:902:d501:b0:245:f1bb:9bf9 with SMTP id d9443c01a7336-24944870959mr275858785ad.12.1756961469626;
        Wed, 03 Sep 2025 21:51:09 -0700 (PDT)
Received: from localhost ([122.172.87.183])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2490648c89bsm177058085ad.109.2025.09.03.21.51.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 21:51:08 -0700 (PDT)
Date: Thu, 4 Sep 2025 10:21:07 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Liao Yuanhong <liaoyuanhong@vivo.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"moderated list:ARM/Mediatek SoC support:Keyword:mediatek" <linux-arm-kernel@lists.infradead.org>,
	"moderated list:ARM/Mediatek SoC support:Keyword:mediatek" <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH] cpufreq: mediatek: avoid redundant conditions
Message-ID: <20250904045107.rweiwjv3glbehuwb@vireshk-i7>
References: <20250903121228.385766-1-liaoyuanhong@vivo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250903121228.385766-1-liaoyuanhong@vivo.com>

On 03-09-25, 20:12, Liao Yuanhong wrote:
> While 'if (i <= 0) ... else if (i > 0) ...' is technically equivalent to
> 'if (i <= 0) ... else ...', the latter is vastly easier to read because
> it avoids writing out a condition that is unnecessary. Let's drop such
> unnecessary conditions.
> 
> Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>
> ---
>  drivers/cpufreq/mediatek-cpufreq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/mediatek-cpufreq.c b/drivers/cpufreq/mediatek-cpufreq.c
> index fae062a6431f..00de1166188a 100644
> --- a/drivers/cpufreq/mediatek-cpufreq.c
> +++ b/drivers/cpufreq/mediatek-cpufreq.c
> @@ -123,7 +123,7 @@ static int mtk_cpufreq_voltage_tracking(struct mtk_cpu_dvfs_info *info,
>  						      soc_data->sram_max_volt);
>  				return ret;
>  			}
> -		} else if (pre_vproc > new_vproc) {
> +		} else {
>  			vproc = max(new_vproc,
>  				    pre_vsram - soc_data->max_volt_shift);
>  			ret = regulator_set_voltage(proc_reg, vproc,

Applied. Thanks.

-- 
viresh

