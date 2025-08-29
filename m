Return-Path: <linux-kernel+bounces-791163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FE27B3B2B1
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 07:47:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B970B7B03CC
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 05:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF17221C186;
	Fri, 29 Aug 2025 05:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TE5t6oE+"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93FC01401B
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 05:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756446457; cv=none; b=eo9vlbnhAraAOyor2bh7ukaG4r4ssbBj8NDAZwgh0zV/dqnIYQH0GHPX42VFpuILJVx64qbyTBXEhY/u747ywwqMECZzn1hTyUAtA3iI7AQpJUzLk9EORHL2nGAuVBtv4odF7dg3kp1myrYVH5tj1QTx/ND42qO7jYyk8SI8i1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756446457; c=relaxed/simple;
	bh=Uc/dxRivCX32A5tn4YeaGlRsjiI0bzG6wUPU4K0jjr8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nJw+/gU4TIC87dTYouCezfTJEx/bEyyVFAAZkVOsWTga1LNOV8n7z+HMv5LHI9mJ/QdVKP5gX9HQdt/J16a2A58cCvdjXet2MQp95E81CR+9cgoYT8x5bUzOl8Tb/f64cGFSG+94ivRl731JnZaUiVaSy99KzcgOXbj2FhZ4KLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TE5t6oE+; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-32326789e06so1484815a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 22:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756446455; x=1757051255; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SVM2NB/+Q5TwegaC+cQ6efQn2fgkr/tPokgrfCaQZxo=;
        b=TE5t6oE+sSNp0wtZAsyN7SGkWm5OBrOZGJ2WSMgvlBpJ9J/mr+CTynl2bwrO2qcxXA
         yHg6RoGLseTsTCmhccPBImAAxoYTxkpNihWmAGljgrb7EBCFYrf5uFoLP/04vWt2Piep
         YGKg/6ww1CV4IPg1zWNLmMzvjufUI3HofaLMyqEM4tZxbeVUZJK7PllhWFLVJxVgS0f/
         yNRJ61OgazNG6G1MatJ/qNbiEhDE2hPMXYdUwcb5i9TDoLKd0EtZDhz/rL8SAIk4kt7o
         j2C0GfQPjlKUqnzrJczczOtZnGoAVIuJnI/8lOAZg1KMciVg1Iv29u40ZwbwApnmEF8l
         Q1yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756446455; x=1757051255;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SVM2NB/+Q5TwegaC+cQ6efQn2fgkr/tPokgrfCaQZxo=;
        b=TPVzHFUBAbvMNMcJA5+GJZ8G+0K2RYMV2wJLIYygD7rsmTxwFf1JtxRh0VqZhSnoYp
         jq2w8MLzRfvkez1YPjGuHwuqZLcbZb5e0Gs+ieldBlLjCfco8OnNb1KTz+pNNLiOjARE
         SFKZbnjOQRcOLPCb496kmqnElF8uE1XEzpnze/2WAeZna5hh3gtEv5aFd46Oy3+KCVvw
         oXPhQzCCHLJhgZjoOw7PpsSFwNaZdMlQUEYJ1+QT4LsmD7D/k1uD8jkcNqCCUiCkRF4E
         vlY1/qyF+Mn9ZHZiV8zzKDv8R50UIy77wOGkWOavjR8XIvj8wVPeItzLo7AEBPLPd8MT
         mx0g==
X-Forwarded-Encrypted: i=1; AJvYcCWH7T/atJqKYIwrJ+kUoFvtEE5/k+/Yq11fHubmQ12hLwrvdsE2KGNUIEynuyswtKvhlnCgiCP9ADmuWfU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0arq3FG+CukyTclqsOtwnSeWkvbkEcYfB6pv9QgOb2Hjrw2sw
	ikKieR5r95oiukrKZGBbQNpBoDdrgBgJWXAzks7ALalDVkZEZqHjjaHNXDGtltdd/pk=
X-Gm-Gg: ASbGncsV1AkAVrvlaaGv1csBqaH9joMPFdeGGKqaNSW2bBYntHwAzpv0uAox8+ROR+D
	Mr8bJqJ6RFpuRoGF0ucCeYDxb68KNsTxDAjlQpmnquI6H8/DmatGsrtinCQLGfgT1B1qPEUOt47
	9tio7V05a1BjzBacHz0EdQQDT3eutrv1lCuwqxoijZeRRYq+VFMWNbo38+FBSAiIbkSmYWC5MDk
	S+1kM1M18nyZu6kW3Rr7xjJa9Z9a/AubNu+D5LNkUp0AAsyVjRpsVaGY79DMI23ZC2VKgctC5cU
	qxQPAAHuV6P5G2e6RVRSGadCTIhtc4P9U+VpOlPHkd+VWalpCJp4lQtgM36iTCSplFwmCk2J3cY
	Wi7Zy71ODyZaHdAx1MWUAO+wen/7bCGFSatE=
X-Google-Smtp-Source: AGHT+IFGFRX8jr8klOJHgeApacbbUnrvb94Dt+QaaXsozbhIjGsZDvjH/LL4aUVoWgpbErAkB6CKrg==
X-Received: by 2002:a17:90b:3c0e:b0:327:dce5:f635 with SMTP id 98e67ed59e1d1-327dce5f897mr3153327a91.25.1756446454625;
        Thu, 28 Aug 2025 22:47:34 -0700 (PDT)
Received: from localhost ([122.172.87.165])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-327d93547f4sm1536101a91.11.2025.08.28.22.47.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 22:47:33 -0700 (PDT)
Date: Fri, 29 Aug 2025 11:17:31 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: "myungjoo.ham@samsung.com" <myungjoo.ham@samsung.com>,
	"kyungmin.park@samsung.com" <kyungmin.park@samsung.com>,
	"cw00.choi@samsung.com" <cw00.choi@samsung.com>,
	Chun-Jen Tseng =?utf-8?B?KOabvuS/iuS7gSk=?= <Chun-Jen.Tseng@mediatek.com>,
	"rafael@kernel.org" <rafael@kernel.org>,
	Project_Global_Chrome_Upstream_Group <Project_Global_Chrome_Upstream_Group@mediatek.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH v3 1/3] cpufreq: mediatek: using global lock avoid race
 condition
Message-ID: <20250829054731.utl6pmgan6sg4mfn@vireshk-i7>
References: <20250219054209.erwfp7sgzchaiuds@vireshk-i7>
 <e8337c5eee0cadb797bacf26b00f1ca303c5147f.camel@mediatek.com>
 <20250321045624.mwm2mnkqeow5uids@vireshk-i7>
 <2a73b5ca35692c8ffa68c9ff0df73e24a592967d.camel@mediatek.com>
 <20250321060148.adhxjexpnm4dkpnt@vireshk-i7>
 <e1c2c12bace22d1803d16ecbfb32129518d87157.camel@mediatek.com>
 <20250324054333.sgwwksawnybx3lp4@vireshk-i7>
 <06356a55cdb3c34dfc716349d1967f95655b0ab2.camel@mediatek.com>
 <20250416080517.feansrkpycsynk6t@vireshk-i7>
 <CAGXv+5FyR8bt16nLvS0V=_YRWM6G7V0OOpxctA+_4hVnnCjDtg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXv+5FyR8bt16nLvS0V=_YRWM6G7V0OOpxctA+_4hVnnCjDtg@mail.gmail.com>

On 28-08-25, 15:26, Chen-Yu Tsai wrote:
> Maybe a different set of eyes will help. I talked to Chun-Jen offline,
> and I'll try to explain what I understand.
> 
> First of all, the issue lies not in cpufreq, but in the CCI devfreq,
> and how the passive devfreq governor is linked to cpufreq.
> 
> The CCI hardware unit on the MT8186 is sensitive to frequency changes.
> If the performance level of the CCI unit is much lower than either
> of the CPU clusters, it  will hard hang the whole system. So the CCI
> devfreq must always take into account the performance level of both
> clusters, or in other words the settings of both cpufreq policies.
> 
> Since the cpufreq policies only serialize with themselves, it is possible
> for one policy to change and trigger a devfreq update, and when the
> CCI devfreq driver is doing its calculations, the other policy changes
> and causes a big deviation from the assumed performance levels, leaving the
> CCI into a non-matching performance level and causing a system hang.
> 
> So I think we need to handle CPUFREQ_PRECHANGE events for the frequency
> increase direction, as well as enlarging the devfreq mutex to cover
> the CPU frequency tracking bits in the passive governor.
> 
> I hope that makes sense.

If some sort of serialization is required in the CCI driver, then a
lock must be present there to prevent the issues.

-- 
viresh

