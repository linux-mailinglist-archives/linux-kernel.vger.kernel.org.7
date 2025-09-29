Return-Path: <linux-kernel+bounces-835995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 956E1BA888D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 11:11:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82E7118966F0
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 09:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3551D2641E3;
	Mon, 29 Sep 2025 09:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FLkFKoN5"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20AD134BA41
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 09:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759137072; cv=none; b=YSzmhkj3YfNpGPQZyHzbkKBDnJKgeOXDqAlyhAnaUYl5skRHvJ7kJ/dp5gRvk7rGtlmed23Fbc8xPkeAVlC+7AkK1cTfMiFnfbjEzPQFFOoUBMN7KupiYIuQ4X7PMxfDx5Vwai2nyPdvaScAeUOkHN/8ZXSX2pPQZQUMESrz8ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759137072; c=relaxed/simple;
	bh=IzPi6YAga9PuMbnzG8is1PD6DWuMBpvZP4lMq4idAD8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W/clOaX4+Zci+GlefO4TRyzWKxbLf1ViLCjkriqyA9SQom6DZLfFwwmDzAbANzcjSvifW6XO4HZaUgQ943qmwh/PvoNLt7ps4ABlFk6y8LyrOMZNp03IucA/elTVK2dDOANE6ua3XOsFqpLZ9RbqOuWNiIAzhAHftI34c1aXv1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FLkFKoN5; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-28832ad6f64so10655985ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 02:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759137070; x=1759741870; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0UzoMEpxwYA11OgHMzNuzA/C9K31n+vXlsLGo3esRlE=;
        b=FLkFKoN5rgxTsIlilQWGcR1g1CJeqhrXE+hkdzjSpbYWiA3Wj85lLHRvb+BKXZbfn4
         DjKmUEjngS+KSrFPQRZGOhjtbGnCPdDMwNxCGTYoUWlD19wIhf4aXjF+09iQbuwc9NOa
         Cgu2faNfcBuUq0GS0jW1GrOpTPAAthhqdO/TedYv/GyP1HEiner8SYk5PsH/Gj0zmFfJ
         DZByhJwOrrIubNhFyNGk2xPrEneMJj8aRvHHQaxKXJ5ukCpJxw+h/fc7ofMSMikS0ttk
         4yBZR1QT8Dew1ad489L9ikp8q4q3snU9ujDP4ilr1/YvI4trwLWtFdgvNd9wUftbAcW7
         WeDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759137070; x=1759741870;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0UzoMEpxwYA11OgHMzNuzA/C9K31n+vXlsLGo3esRlE=;
        b=UZ4Z3eQQGgUA5HQZKqqHJY6iw4/55aXrlg2vYo1te08KqHNbjuARicuxFWG6JU6gwK
         9IISwxRa5vwd4mv2CVHsmCAnKgasNT8V9oNtohxdkMmjRm/FyOiyUfThx8SSfozv9tRb
         Oo3hIfwy+4qlxxuVrkV104nVpZDQ8iMvzjzWWclXNjNA8RKuI+ozvVjh/U5S7qp/FTxN
         rwbzkII9dKsZAMo5K2tyZ8ghdxuvIgrqXkLYK7G0gacVtHuaBc+0xredWgFEQkzhhHp9
         0WAyiY2SApj5nYBTPYoNPE8671nJ3P+028Hl+MY58GYXiiyvYVkbAiwcAid2bt9ICnsF
         DQ+w==
X-Forwarded-Encrypted: i=1; AJvYcCXcZPIGtU9Sk0DVS49oN4PtF7aLo7sK46uCEbgufXCnocGQRXbv4Y1W3szZp3pWz0yPFydoJ2MQinTBwnI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKFnsJEISF7rhHr9OH3LNM2m/Prr1xCRjjoov+pEFBnxR/uoeL
	zayjVM8lgDdwdtOFdfibepEg4hxuixfpZiniL4RGwyHGcRVgYFTWVMGFYke1uAFhbtA=
X-Gm-Gg: ASbGncvat9poPahOaeyrVvrFgsdfcDrlRS2DS03ZeG0PrtwOcOVA9RsvisypxpFaBFj
	CDBXP/ArBYdMpMM33dx9Hf+m1c0EiaxB/mrg9JF28A11+O00v+4PaxdVj9uy+WNZbn4jiLuGUOK
	+/Ssy9qOhO11DwfdPPKVWzHEe7T+qXtET4Ek39JrybqFtafmH88oZAyg9O0PK0iGN01+tty3MO4
	PZt5zL8oo69TTf1y0U6TQUw+KRQlVtJIGJ1pZbn0J9jrFAa1GXGMKqVbxUS2TqPowlvMJoIN9EU
	EbxxbITdGqCW7HPQgARbXzpEkJocrbRpeXYnvEMn5qdwhtT8hUxvg4ffCecIuDbNIAeJ3YWPmI1
	3gy0+0OlN7z7gQNqwI4t7Q8iQ
X-Google-Smtp-Source: AGHT+IE36qC4gdaY+djdCS+K2gAOuhROlHGPGFHjHQiGsIGh3DmF86iNkcqZhdF2hU44jns2gHjhyw==
X-Received: by 2002:a17:902:e5c2:b0:26a:f69a:4343 with SMTP id d9443c01a7336-27ed49df6acmr178971505ad.4.1759137070390;
        Mon, 29 Sep 2025 02:11:10 -0700 (PDT)
Received: from localhost ([122.172.87.183])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed66cf181sm125192125ad.28.2025.09.29.02.11.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 02:11:09 -0700 (PDT)
Date: Mon, 29 Sep 2025 14:41:07 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Johan Hovold <johan@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-pm@vger.kernel.org, linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jia-Wei Chang <jia-wei.chang@mediatek.com>,
	Rex-BC Chen <rex-bc.chen@mediatek.com>
Subject: Re: [PATCH] cpufreq: mediatek: fix device leak on probe failure
Message-ID: <20250929091107.4xltfrms2zdnhov4@vireshk-i7>
References: <20250909073819.25295-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250909073819.25295-1-johan@kernel.org>

On 09-09-25, 09:38, Johan Hovold wrote:
> Make sure to drop the reference to the cci device taken by
> of_find_device_by_node() on probe failure (e.g. probe deferral).
> 
> Fixes: 0daa47325bae ("cpufreq: mediatek: Link CCI device to CPU")
> Cc: Jia-Wei Chang <jia-wei.chang@mediatek.com>
> Cc: Rex-BC Chen <rex-bc.chen@mediatek.com>
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---
>  drivers/cpufreq/mediatek-cpufreq.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)

Applied. Thanks.

-- 
viresh

