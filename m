Return-Path: <linux-kernel+bounces-777014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F621B2D415
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 08:31:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0321188FFEE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 06:31:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E08C12C11D7;
	Wed, 20 Aug 2025 06:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A8brhnrO"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D248158DAC
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 06:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755671482; cv=none; b=kfzv3pZvKXKCgadIFdkJMcvUkwlR7+yjFB6bTVMWrcbtfPf7i25fe6ghNY/HXsu5j/1UInXIYFZwYhYh18FljMqhxWJorVgr4Pek37zK/K99sgJm54pJJ77LS4yNWb8uV6WVbtEO8sQSAJS5azKxAa83b/1ATlSryfwaDphMM7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755671482; c=relaxed/simple;
	bh=/zY5PMOi310ktVYGpnYfeiQf9K4srfJWKah+xam5yrY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BdwJ9NNnxBfFxxMHzc30pfRAbINVBxHZIzwCLsj3w0dNpJsizLm8LGXv1juUU4d1UwAQJW6hDDX9sIyq5qD6IHZf/q4PjtkuSNkzx9W0r/S3jhFzhdfNLjM8q9lG4DCy9yo3IGm9seUnLKG2JcjbYqWMDlrpLSvf0UYZ4K5GMU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=A8brhnrO; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-45a1b0990b2so33903555e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 23:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755671479; x=1756276279; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zm2V1odyqTiqeUQ144+lcYOoX8xxycxwVvudsLtseZg=;
        b=A8brhnrOQxnEZFyuTyfbF7e48dRJyo6tdkw8dfDNYcC9AQT3dnQLwpAj+wP888IXW0
         7f004OI1t4NHmPO4jtu3CmWTA+vKsawnXSk5fpMqjk2nWT3Pz8GB8mLPknVh75h2Rx69
         jSI9TJSJntxHayXZ03tlHDCAzgEDrIW/HJLnmWLGsvNDsvYkr3LAUYPa+ipoJzilJpVT
         940/copLF9WrQKGIhxDirVBOOj2GMps58SmaIQcQKE6aA0NkGlpE/fOtMF2h1GhPvXnG
         cgxbhhYNjvUIhSv28p1vnC93nciRU6dOcYXL9rOdgbfVV8Hkl4IBCEpIPZQW9lbyPz45
         iU6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755671479; x=1756276279;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zm2V1odyqTiqeUQ144+lcYOoX8xxycxwVvudsLtseZg=;
        b=IJiDbofEj5dL08PjDHleQ8jS7+YK9hCusM24cD8lr0XzTTVTIBUoUW3OQRHBKCJmpG
         UCvUGQALATK4QBuGtbF+OSrqelzqICqNaWdxZpgdcywhzaFjljrwO9ATujTi8N6Cqg7O
         1DY5jWZssK1dtMCpK6iW25P5txs7MifNfA6Hcq6l7+08785lGuLagPScwV9qR12rfR+Q
         hbYUfE56TUrAnPfulckoih60IXWCczojIbo4U5IflvsH80egKyZBuCCS8yopeBG/ZxDA
         NoJExusBzmlLCs//CHS2OO+lvOYbliogo4oND+UHwynmnyTG3yxdxcvW4CBtMFBe4gEP
         u+XA==
X-Forwarded-Encrypted: i=1; AJvYcCXtSUiy8zNfq3qlsIBXBV/qF0G6n9T7BMQz7MVnZ4QFWgvXRndakjRhGnS07PZofw7RKRbpR0ZEsViuNQ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPWKT9GuNWqhju8Dr6aGw/l/i104famVPosZVB0yISVAIRSYfs
	ImgJkedgC0CinvBnH6wnE2MMhbZFMrlxqJVV23ftmvxIdYfAdHkiO3fJ9X0Lcmi0KCk=
X-Gm-Gg: ASbGncs4p01rojCXzCTp8drBMfuB84dQHqcV817XfdSD3+snE7T349CBkMezR7wS2RQ
	l3eAgrUfGxRL49c9tclrZyqakKyTG9z2TvSoYIU5RSbB4Qexy3YbXEPwa96xOMWHS+3IuMN2SMf
	v3Nfey/V8cJtmZBFVcZmZjPSNP944+hMY8MlyqOcXYeGAXRYV7vRh7I5JMyRKDbQ8qLxwG6jHOa
	H0LTVdKwQERnOVT4lB8a5KGZ8hrTLkUDwBI4MHc25asTyy8+QHMYQFyaKR8zBhHMVzEUXaAFORz
	HUPfucOoaMOraxkd1xjpvXxTldF4IiDw6wrEQG4eZDsc4yoVshfiRZH8SQZjxnipcIlIcaf3Jxr
	M3GDLCSecOBWrMsJ3pfCkK1G/5cwpIeac0QL1Fil/RCZSX3gj+Ee7ow==
X-Google-Smtp-Source: AGHT+IHD67e0X5QiTWO18n/Hjm63pK2HXsKittHH1LjgztM5w2vz+Tz+Iiy0mNFamv15+XzTSBAF8A==
X-Received: by 2002:a05:600c:4fcd:b0:458:add2:d4b4 with SMTP id 5b1f17b1804b1-45b479a3e26mr11414505e9.12.1755671479001;
        Tue, 19 Aug 2025 23:31:19 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45b47cac162sm17779485e9.20.2025.08.19.23.31.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 23:31:18 -0700 (PDT)
Date: Wed, 20 Aug 2025 09:31:14 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Mohammed Guermoud <mohammed.guermoud@gmail.com>
Cc: marvin24@gmx.de, gregkh@linuxfoundation.org, ac100@lists.launchpad.net,
	linux-tegra@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] staging: nvec: Remove unused NVEC_PHD macro
Message-ID: <aKVrsrvMrTEgAY4R@stanley.mountain>
References: <20250819194430.4525-1-mohammed.guermoud@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250819194430.4525-1-mohammed.guermoud@gmail.com>

On Tue, Aug 19, 2025 at 08:44:30PM +0100, Mohammed Guermoud wrote:
> The NVEC_PHD macro is a debugging helper that is only enabled when
> NVEC_PS2_DEBUG is defined. As this flag is never defined in the kernel,
> the macro and all of its call sites are dead code.
> 
> As suggested by Greg Kroah-Hartman, removing the code is the cleanest
> solution.
> 
> Signed-off-by: Mohammed Guermoud <mohammed.guermoud@gmail.com>
> ---

Thanks!

Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>

regards,
dan carpenter


