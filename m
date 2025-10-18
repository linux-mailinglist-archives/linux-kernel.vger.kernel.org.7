Return-Path: <linux-kernel+bounces-859113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 48A9FBECCF2
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 11:53:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 268354E8E06
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 09:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 700832868A6;
	Sat, 18 Oct 2025 09:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RzQcs3IZ"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3773928724D
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 09:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760781210; cv=none; b=YJA5iRIESRfKd38w0DdELs3pi8PB6d3I8gLSq8a1ZasR5W4yS80D896v4i/Hx/klofCTjMLtk0XhzMH+LIiuVnhIe7LV5OMcVT10MYgXBP3SE9+lDoFiaN9q4ciO597KYZb0fONnaB0b8hzIawgGYu3It6G9mN12NtfvJhA0ZW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760781210; c=relaxed/simple;
	bh=jLj8RoSgzmMT2RBpQP/RNNqIQpG4p47ETDS+XypecR4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hEJCh9GEpZS1hvCdw4NkTAcsikq3BuT6SHEzpJJHBuRkgwJsgqNH8aL0OB7adT0d4+uSynJLPzm4MgpYYy7eQpC0Xv7FSvxP3anPI5TF0Pa8WriK1HOD5iF8uikKASRTsIw3BE3M17Io/7/pn6rU5Zvsu/ly7UVO8E8Qwrc4jno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RzQcs3IZ; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4711f156326so12968205e9.1
        for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 02:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760781207; x=1761386007; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YLcttbn5k16RAKKI+EzOZF6EXsPtXzfzb9zD7Ffua0E=;
        b=RzQcs3IZNLzsYNNaFFLWAojQdcRTdALXC5Y1Lwt376bv5iIP62cOMiMGGGiZYL8pPL
         Fks9AwNGse1GdPZ3Um96cYML4qU5NpRq0aY/HEt6skDmm5iyoGUt2yclyGyKHgr0Prmm
         yP0f78bLLIZaJvMmxQNWA+aXRdAe+LJq7cyKYCdHpZq4/chHidZF5uqyFwnTOCd1Q6qA
         SHXNTQwXpmcRefdbnuewarZlwKZbxxNlA2ZcYZr/7NwfH0udfkrzBybF4LtAOZ+EXXKr
         lVgEe1t/44XdB+35G4nWz5jqjUocXfoGWpRik+54ot5eZPCPNBnxCy/lezPPlSaxQelT
         Je3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760781207; x=1761386007;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YLcttbn5k16RAKKI+EzOZF6EXsPtXzfzb9zD7Ffua0E=;
        b=Zd17Mw7ZlwRTMY7fd1EOk8p6tAsX5A4OJblLzR4Kuy/4+LXOWKp6XQ8OuZDtguWrIc
         l00UVl57glaXMh+tAGu7gE1XrF2jxV9bu8yqiy3H6AQZM3OA7Cenaw8WSFDejOKPtGiA
         b9HuUUQSdf4IjcvrIshwdWVecErDKDQamsfFzTMXFZGiQWpo1PAiclegoVBeQWY9ClR6
         6LHMTXAWka2V5qTps5j5lLQtgGy3asufK4ohMXiviUklj1VQHss33ZUPVRvK/vu/WEZb
         Px1ganGGmp6xpnDXpQNgxu1lQWgE+lXqMRPXdrdJaUCdiLVqs3ByIQgX4w6jbOdwbR4w
         PQvQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZ+gmKHUFVXai8ZndE9O6lkekINytGsm0EFbYlSoeX+yk0815xhCOc3pRgj/kAR9DomsT5/CVIj1XZs9U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuRtuKGoRRjjCN2Pj+fl3riowrYEOHW0rkmkyX++yxfBkHULG0
	TD3dBTsF4ThIy0rNBgFPjV0CEqBFfCZVW95O0bexY1Wi28qG3BlBF/SJOnJSi1jZXZs=
X-Gm-Gg: ASbGnctR16bWuu3tujSgHpj2n3U8VWAFEtCGzgPGhZZpn7tF0UvS2EzgAF0KSI9T9Cm
	426ZE60TvhuiPoq1/thNLOGFn16lgrPZAmZxojmZwePy0O7zpVNqkuKKHLSaJ7E7M+JWOoVqOIy
	5LNefMRFih0mTHOj4c+HXK/Nf+89D3mKLjCIyD5dCJlOApGW1ytIc4Y0cUoKhIqiyEbiZ/cSSnZ
	zkYCZ6GNdU/yQ99USAsVBdklOdZUIw0+5s1mwzEEu7VpsOFsHDeNqn6dkIEzMBl+pdazmnTVoWc
	CioR2fm+Fxytitl9J/hH1Kwj2NV49idPb6n7GMo5LE9qe+9hAFve5RKJpGF57vLCJhVc440NTXP
	NV/15SGdG/CxLvwM+voIepsq0lGK1/f6KvG7bYNBCGNekVI7K8ybZvk8RjmGB/dnLBQFgOEQoeM
	1gLUMumlGuotzfZNGF
X-Google-Smtp-Source: AGHT+IE7qvTI/bg1JlFoj/mWNWosxLYB/3XVkN4l0hbhMw4Lq63sfmg28D78UCq3lmimATW7krx+qA==
X-Received: by 2002:a05:600c:34d0:b0:471:1717:409 with SMTP id 5b1f17b1804b1-471179071b4mr45155315e9.23.1760781207332;
        Sat, 18 Oct 2025 02:53:27 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-427f009a96asm4030365f8f.31.2025.10.18.02.53.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Oct 2025 02:53:26 -0700 (PDT)
Date: Sat, 18 Oct 2025 12:53:23 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Anand Moon <linux.amoon@gmail.com>
Cc: Vignesh Raghavendra <vigneshr@ti.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	"open list:PCI DRIVER FOR TI DRA7XX/J721E" <linux-omap@vger.kernel.org>,
	"open list:PCI DRIVER FOR TI DRA7XX/J721E" <linux-pci@vger.kernel.org>,
	"moderated list:PCI DRIVER FOR TI DRA7XX/J721E" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 2/3] PCI: j721e: Use devm_clk_get_optional_enabled()
 to get the clock
Message-ID: <aPNjkzrexmIyQXpT@stanley.mountain>
References: <20251014113234.44418-1-linux.amoon@gmail.com>
 <20251014113234.44418-3-linux.amoon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251014113234.44418-3-linux.amoon@gmail.com>

On Tue, Oct 14, 2025 at 05:02:28PM +0530, Anand Moon wrote:
> @@ -630,7 +622,6 @@ static int j721e_pcie_probe(struct platform_device *pdev)
>  
>  		ret = cdns_pcie_host_setup(rc);
>  		if (ret < 0) {
> -			clk_disable_unprepare(pcie->refclk);
>  			goto err_pcie_setup;
>  		}

This will introduce a checkpatch warning with checkpatch.pl -f because
you need to delete the curly braces.

regards,
dan carpenter


