Return-Path: <linux-kernel+bounces-731919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F3E1B05C75
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 15:32:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5A7E1C24273
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 13:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A92C2E8E1B;
	Tue, 15 Jul 2025 13:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MhoH53pH"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC0952E6D36
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 13:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752585994; cv=none; b=J3y3LESMkLOkVzW/f86Bps1YqDHGOdLG2F29fpCQdxBP1Swqp/fgGSns0wzjgj4zLciylRoml77LzevZ+KQjq9bahsulFxmUy3vxetfmGUPbTl4vdUsQ6GRLXNAmqyZvTZZZ7aMZQyVK6izC8fNq4tTRbZsw2+qW8F1Wd2Q+bl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752585994; c=relaxed/simple;
	bh=WsPqDkkR0w0NChv6i3skLUOm50mr+MhFYwPfQ2zF7hU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KV4fIqU6VV1dLJnF10z/u/LDeoazjqPXVP7RKgyfXuDxRO6/D64FySTnan9twAxVOv06SmAp8JHwKfr+58PbFSgca4lhg+MAJLtvJCKoFlX00xxfCHHCjvVmDixzz8kokcHEYZoN0B2LO9HLfrodunZVQ3WBbTchhgNdFW/4Zi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MhoH53pH; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3a54700a46eso3373745f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 06:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752585990; x=1753190790; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VvPKW23vcGHWbJZ7ulKit+LygcP46v08cpOClJit2gQ=;
        b=MhoH53pHIJrJbX8BlEjunSGwZ+hzVoWJCZZqS67xlw8v0Ohe9+eLWEV71ASxlWTKTi
         XgmwTPzgqoFNyAyDhogL5gkWp1k0M9GmpNlAveztgqsG75TBh1pnGo4XkzfDIEO5bpAZ
         zPfVNNWHA1Ax9OEjCmocRKbGiOuvVfo/jTlDjM4GjMIMeX8mzyZwIGZfdjKC1q6VpLOi
         5wUhuQfuYUgrmno0ZCA7UbBv4TLoq8sXO7JGALeeZcb7HswAy9LV6wtJYtaIv83tq5F7
         o3yBJlameDJZ7BKzJT3Tm3PiKaf2xGg2sVDOb3aCIg9F6xtkKxHRnkb5wSO7wud5wjX+
         n3bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752585990; x=1753190790;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VvPKW23vcGHWbJZ7ulKit+LygcP46v08cpOClJit2gQ=;
        b=gBkJN1sagOh88woZqiGwDENnn4cssNiegZelG5fi+fyv1opcutDU/Hac9uAT9V7hN6
         Cw3kAleVbqDYzhZG4s8eqNNm24IpzX4vg869BmGHkjvRt2T96DheL5F510dQAXoExAOe
         zLACFGgsT96wAV/bKqu0sXRGAJgAe+peNMQU9ehQPZkE44dH/uBT5VV7zTHrGwxTD9hT
         Qjyvu1Uu0YarnvHErYG4J+0u4u+ANLsV/+Q1WiSTj7ODLEq07Lcn9ZT2IK5dR9o6atzu
         NLaJJkvmS5wLLT2PWfo5oVFeKqcGtwIJwwdoLBVb4iFMDw7GCNJu+jlwuIgqTgvV4dqj
         VJEw==
X-Forwarded-Encrypted: i=1; AJvYcCXEEeSVzzUEwWtg5eMI0+QRnuqHW7vcCBL0o7NAkoTqsz/FX7woT9hhRZSHYOSui5i7D9SBen4vbVXGkgQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywd7Dj7f/1VjcbwOYJr5yXx4r45uHHJPn4bcqsOAydcWOJVjrLJ
	JrO6M6ya8s/xSgGDhMmKvTYBOC9nynXpb/cYQiXvJWT87tChtEI57FCbyq9mk2WlveQ=
X-Gm-Gg: ASbGncu5DC1TfEBwYCYIBXAAoiDTMR7OD3P9113bDBrekB3u40VFJynp6eE3hT2XtIj
	uSC8il5n0wNSDObBQUaC7S6TETrDzjFXZhvw5eaC1QV/5+Nmuc52unybnq5TmCBxVsaCNWeFbOa
	vkrci/roU7z/jOxPHhvaavfXVcQkcIqFFhtlHFLRUATQo+YHG03UnsUStxuOwVT78AgZYkgG2N8
	9c447ZWnIEcuryMjy+ubbjQWN7N69ThmSslUk2CVpjZiNqhtcn4cQW4AY0Z5nFtzdUExvkyI3CD
	l4keyV6YknjdepuYXUR8+wFmv9hpd/fDVxMpoL/+jgEg6niyHDzeL1QxIYDtHmPy0FKOgIBrb8J
	npBjSpEceKIPsGhWhPKfGC5EapjmTGiCDFVltBe3tTD1zTckVyAE8W5XQd9ZX
X-Google-Smtp-Source: AGHT+IE407KS8uKPTJWroRm8IILV/e+TMXBeoa0EGQKc6WbP+vL8QbjAW05nEN1glpgEAbE4/IV9fQ==
X-Received: by 2002:a5d:6f01:0:b0:3b6:463:d85d with SMTP id ffacd0b85a97d-3b60463d8eemr6451671f8f.11.1752585989943;
        Tue, 15 Jul 2025 06:26:29 -0700 (PDT)
Received: from mai.linaro.org (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8e0d872sm15337925f8f.60.2025.07.15.06.26.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 06:26:29 -0700 (PDT)
Date: Tue, 15 Jul 2025 15:26:27 +0200
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Support Opensource <support.opensource@diasemi.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Niklas =?iso-8859-1?Q?S=F6derlund?= <niklas.soderlund@ragnatech.se>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
	linux-pm@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-renesas-soc@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] thermal: Constify struct thermal_zone_device_ops
Message-ID: <aHZXAw08359qCBz2@mai.linaro.org>
References: <5bba3bf0139e2418b306a0f9a2f1f81ef49e88a6.1748165978.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5bba3bf0139e2418b306a0f9a2f1f81ef49e88a6.1748165978.git.christophe.jaillet@wanadoo.fr>

On Sun, May 25, 2025 at 11:40:04AM +0200, Christophe JAILLET wrote:
> 'struct thermal_zone_device_ops' are not modified in these drivers.
> 
> Constifying these structures moves some data to a read-only section, so
> increases overall security, especially when the structure holds some
> function pointers.
> 
> On a x86_64, with allmodconfig, as an example:
> Before:
> ======
>    text	   data	    bss	    dec	    hex	filename
>   28116	   5168	    128	  33412	   8284	drivers/thermal/armada_thermal.o
> 
> After:
> =====
>    text	   data	    bss	    dec	    hex	filename
>   28244	   5040	    128	  33412	   8284	drivers/thermal/armada_thermal.o
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

