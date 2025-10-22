Return-Path: <linux-kernel+bounces-864700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 59650BFB604
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 12:20:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 269614F96AF
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 10:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFAA930E83A;
	Wed, 22 Oct 2025 10:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q5eXYtvb"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC2D3161AF
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 10:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761128443; cv=none; b=db8yXKPw22peiTrQl3C8fxlF/xt3LEJOdjiXMqT8lZJQfJAP8GKRdvuUUUtpeDwnksEmlUsirC665VPONc4g46RrWutGnRlCJdiTmm72vZtIkcKzpPTlpU/88Z0+JtfC4f5dweX0MSTGwx4klEaASNyeu6S5E5FJDTYgQE8uAy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761128443; c=relaxed/simple;
	bh=bsLcKTPJEYIr6iWd2hSD2/QqBkscjLQjYwtElmBwUuw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ppvFl6HLNeWwfJTD7YAovDoUbYDYKlBH0RPaqugLniS91KOQ2xLbl3WhNT/5AAwG1sfS5MeyywV2jfmvQ5ZR71YZR68jSB9UwlcHZkwKyHsw9ZqjYMxQdrvmD+Ks+ftCDuYKMnkvknaxIB7ZX2ZXdlmrGy1HGYquRr5muagcZW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Q5eXYtvb; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-33c4252c3c5so4841820a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 03:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761128441; x=1761733241; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=v+BERCfgvcR5X/QpiR51/cu4DL63bwSFg1M/A5GNtaI=;
        b=Q5eXYtvbRn1VEpYB+ckss1F1GCQzUuvuD/3fl40yNikmpxtheQ7sMn5qQvpyDoulT+
         NuvQXfh9fYXtofOxyEbl6d7RyO70TDEpg64rLRY8Z4vUP9uKQlEXiNkM1M+iM6F81x/F
         ua9PH5RaMRdzQEV2yy93eyH5PdcySO3Av4XbIIZheaM0qTCVtAjaw4K1QPiveyzwKtZk
         IHMzU7jBq7zstnoUb6xfZhwSbD/kOa0yLlP1eyBnchlHBEhyO1/otNkfaRLrm8zT1jgP
         a1tsraAlVachrcTJG4BJNiELwejevit8YN2V0suucIcaXRrV24RUpbMYkEFrEBAwVusc
         SddA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761128441; x=1761733241;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v+BERCfgvcR5X/QpiR51/cu4DL63bwSFg1M/A5GNtaI=;
        b=RLpWsrRTP4dZwX5f4fs6lrxzaqpuyxVBxDblArA/q0MqNAPFqhVptzh3D2J31Gfmzv
         /aOApR0N0i8ehTVSWgZpXytnifq6gtuRG/PKQKqVEDAMuEPemnOxWCUTaNolfwY2az0U
         b5Ll+prwKj0mi898KinOtlBKXKQ2XvD4Nn0UCP0+SNOBInA3NxptOGmu6c/+TcQ1Q4Bw
         0OlzWkEjQpTSK3bUiUrABR0SNm6x5bEdjFL7ulxQF4PLf8DsLe+yrX3fxd0THljrzTFh
         vbUTbmA5XWbioLXcp5AQjFjqjum0IyqxxV73GABZOKKbtMj3+gx/Fq0bPvWRm7yW/dVz
         Y3Aw==
X-Forwarded-Encrypted: i=1; AJvYcCWpK1TuiE8SXn73G2G1vdIoC0Wv0Su3ez/yXmNMb/AAwV7rfwsIwDOe6UDf7a8UOGz/7GPkw6pb21w8z6M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZs1m5T5586l66ItEauDnLW2mAcdufW6DSDjLYw4et5i/4YhmN
	rLwDSeDaBJBDMUNdORrPIwtJBfpbnC+C/s9mU2Bl+6ZZ2QeBIluTMWo2VFQlyumirGY=
X-Gm-Gg: ASbGncuNVQhuvHzZzIeIkmiSfGFPMZvKw/62W4jjzzTRmfWn1Udzh+seU3bK3MIMlTm
	uG6+ZItpY6XeuGL13jRclfJ0/7xGBQOIfmtKr4ChxVXrhyjWegK8zCu+G64/x4FXC+MwBXluhYB
	g6BlpwJDelLE1MLmNQgFO0xdUYoLj8uqGymQi7GvsJ2SPAwkgPnWOi283FvbEz5NSS5zy4ofdg9
	ZuJrNIn87/M/eJh2S87W7vsJDqiExMOJ3Qc6y8VHzMuRWRkBkrOgBPJKFhCgWqNT11CEQ57Wbwa
	gohyKdpNAfNPmZ6pbQ656TRcuSOhsBBE3JRiZzAkqiaOyQ6S+Su662f5rGUukTxD1RZ7FiiJ2+A
	49fuCeAIyU/nXwAIizwm9OkKW/457TFjvUcd/JRTgTj1jYz2XdKmG/DnLqHyC21+hYk4NulxcML
	4j8ET77pHBKye8
X-Google-Smtp-Source: AGHT+IEPudXWObjJLDv2XWqM26sgZsiKQXdb5QBSpUD/P+viWtBD0+IrqTmFx+e1SWZr7yyFfz4vMg==
X-Received: by 2002:a17:90b:5105:b0:32d:dc3e:5575 with SMTP id 98e67ed59e1d1-33bcf8625b0mr23541723a91.5.1761128440788;
        Wed, 22 Oct 2025 03:20:40 -0700 (PDT)
Received: from localhost ([122.172.87.183])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33e223f0124sm2159272a91.11.2025.10.22.03.20.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 03:20:40 -0700 (PDT)
Date: Wed, 22 Oct 2025 15:50:37 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Joe Perches <joe@perches.com>
Cc: Ally Heev <allyheev@gmail.com>, 
	Dwaipayan Ray <dwaipayanray1@gmail.com>, Lukas Bulwahn <lukas.bulwahn@gmail.com>, 
	Jonathan Corbet <corbet@lwn.net>, Andy Whitcroft <apw@canonical.com>, workflows@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Dan Carpenter <dan.carpenter@linaro.org>, David Hunter <david.hunter.linux@gmail.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, 
	Stephen Boyd <sboyd@kernel.org>, linux-pm <linux-pm@vger.kernel.org>
Subject: Re: [PATCH] checkpatch: add uninitialized pointer with __free
 attribute check
Message-ID: <a6yf3ms7smzjfcm54z7khg6g3zpepqwxcbhwzm74dk33famolr@s2at2tnyxoed>
References: <20251021-aheev-checkpatch-uninitialized-free-v1-1-18fb01bc6a7a@gmail.com>
 <5e11f1bacb6430e1331f02e3e0e326a78e5b0d12.camel@perches.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5e11f1bacb6430e1331f02e3e0e326a78e5b0d12.camel@perches.com>

On 21-10-25, 10:06, Joe Perches wrote:
> There are many uses in drivers/opp/ that could be updated where
> the initialization is done after the definition like the below:
> (I've added the opp maintainers to the cc's)
> 
> drivers/opp/core.c-unsigned long dev_pm_opp_get_max_clock_latency(struct device *dev)
> drivers/opp/core.c-{
> drivers/opp/core.c:     struct opp_table *opp_table __free(put_opp_table);
> drivers/opp/core.c-
> drivers/opp/core.c-     opp_table = _find_opp_table(dev);

https://lore.kernel.org/all/45a64ff434a027c296d1d5c35f442e51378c9425.1761128347.git.viresh.kumar@linaro.org/

-- 
viresh

