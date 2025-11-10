Return-Path: <linux-kernel+bounces-892924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A0061C46204
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 12:08:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 832E44E97FC
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 11:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56341307ACF;
	Mon, 10 Nov 2025 11:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZOP6MOQ8"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01BC03090EA
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 11:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762772879; cv=none; b=oOx9FNYFUp8cIor6+K8kp9f4Ybpx7FKABQu5xeRQaz7IByKD3UK67tlHM+YRxRRZXaZHHON6v9TzFodW6V4vEoxD20kFl72UirV77BojUi0W2W61/B0OOe3LVtlWBPc4sARm4zK7JvqxuFrkSlOeqkM98557nVdt5Nc5tYsao7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762772879; c=relaxed/simple;
	bh=PV0nu9hpPV+PdL37EjWKyESOoKW7BglfhP4iUdE0IM8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FFynPFthD4BDqnjmpp0z8k45uwYYz8sh9YS7dLm+LoD6jaF6ffmsKhyxDVEuvRgjgN7jg7EsYcaKSZTFrd52L8I+vCu8ABuoc7XQfsdqrhlAuunkdH25IKLYY2S6ePCo3TfCHRDPHG1IemVqOgwV1Rp6zIKgTHqMgsTjg43X/98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZOP6MOQ8; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7acd9a03ba9so2026923b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 03:07:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762772877; x=1763377677; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1teV5v5SqS6pFrvXlRn/4yX/VJMz/VkOekGlZHXTNkk=;
        b=ZOP6MOQ8viMXp+whHMIuW+CMg2hu0pQXkgyYI8k3GLd+x8dAKuwj139adqiERa7q2z
         Kx1XSXD0qcGppkvALKE5yvXAy3yWZM+SWUEfT5pM2cvFMjpwgMgJogSVv5JhK/Utpm6N
         3RCqf9kscgsLLaSAkbf1oAoNGVtnVLkoOBn2PxhmoduepLzAFxwNsf+5Z4as3RJHqnQm
         5CcX/esJPeIG/EDFgix2FsucaBn6sdzTcvwlNlyjVuNJTYrSCdtaC8ARSE72pTFyILXi
         ojlsxRFMznyD2xp9VNm8+3mWde8tfTY+bR/UTg2M3N3y3qLxoeUjJQdgQLrndqUpCnZ1
         AS4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762772877; x=1763377677;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1teV5v5SqS6pFrvXlRn/4yX/VJMz/VkOekGlZHXTNkk=;
        b=BnxdlBKO7APyY5GFfCTUf5hEt//lTQVVI0l/e4CB0zq1pFTORL64W+FXCgly477vzi
         s0KuUHT63PZ13pZiYDf9hynLld221Zrl9IWw3NaRcvcPHY6lfrat10PbrkxxR5/HMwUr
         cFjFjbt2gF9EoeVP7heiVK6c86vuQAv5eahOnNCAdpVjUxfnga2Y4sjPV7hFZea1VP0s
         ooqxSA+RMv4r2pAwqCu6ka4AHide+0/NvdDNOxdq6AMgzMXsYWSPJbHgewCMqk/VfNR6
         qJQ37yRHn6qlzdDrNGcwkLvbq3y6aphONsVWvyprLSQHv94YiT8/CFgfqBYgPdTEmWK3
         7QYA==
X-Forwarded-Encrypted: i=1; AJvYcCWc0vNl5kgOKkyeIUH46TmUf/I6uZV+RW9XMAdOmtx5fNhmtGkGnMVMoAIWY52uA+E8EC8WAfAU0fOkzVQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2mu/WKvXD5sonhLKzBkom+7TfzKbzdAZFvPjpJpD1GGmhKesu
	02GzozNvoWE3pmG9GlCDz4o/l3yYDY4DcUYytOBy6u1hQdKTkntg67fNldaldvU38uw=
X-Gm-Gg: ASbGncul45yrjE1YbLslYwBNfbxJxdVjGdZwA+vLQLX5Ugoy3I2s6GbjSH+AQTaXGGv
	5WsWLJYns2jLxBwFRviXsCGNVLcI/3YlENDmpijIWrrXeMxnMUmzjOH8k77E+DYykZvWlkK2IMS
	98pgDr6BVPER87Q3HudNIWyp9XVZHfk240vR5IfGQU7FVYNMLqyEzqJbWvuSbrYYyIVQSxgyi0t
	gXwzMs4FjJvGxYdETF+h+QlJBxerZptyaCk5+cchZKe7aCPKaMMNvvPOr3HN7/pvS5D7nCdV+CM
	gNa/nA5hMflwyvb3BuqQEPnwO3Tuqesyv4Phl+FNAFHZk0HuBE8Nxey+oonvCOTb/PBNinhx6Qw
	rQSAN67vwbWQthZ1g3QGVW0f1KIuTQDx+qMdLN9xXbZF5mfaeOHexk2jrQiuACdmwYVE03vX15+
	6vTfnuSK5rqDw=
X-Google-Smtp-Source: AGHT+IEI5dvtjpf7UreD77ujcsma8Qc91uG0xXgrZUKvQ1Ri3S/fmPHsBQ3EzHdR5mFgTf1mYnto9Q==
X-Received: by 2002:a05:6a00:1990:b0:7aa:2d04:ccf6 with SMTP id d2e1a72fcca58-7b2232f8c80mr9070041b3a.0.1762772877004;
        Mon, 10 Nov 2025 03:07:57 -0800 (PST)
Received: from localhost ([122.172.86.94])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0c9c09cd6sm11397368b3a.23.2025.11.10.03.07.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 03:07:56 -0800 (PST)
Date: Mon, 10 Nov 2025 16:37:54 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Yangtao Li <tiny.windzz@gmail.com>, 
	Chen-Yu Tsai <wens@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Samuel Holland <samuel@sholland.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Nicolas Ferre <nicolas.ferre@microchip.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	Claudiu Beznea <claudiu.beznea@tuxon.dev>, Maximilian Luz <luzmaximilian@gmail.com>, 
	Hans de Goede <hansg@kernel.org>, Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, 
	Jonathan Hunter <jonathanh@nvidia.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, linux-sunxi@lists.linux.dev, linux-arm-msm@vger.kernel.org, 
	platform-driver-x86@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH 04/13] cpufreq: sun50i: Simplify with
 of_machine_device_match()
Message-ID: <awphoxojc3benzdam47mcx7pqty26ohrwpgv46kimg7nl53rqc@szq3aqjqsbrc>
References: <20251106-b4-of-match-matchine-data-v1-0-d780ea1780c2@linaro.org>
 <20251106-b4-of-match-matchine-data-v1-4-d780ea1780c2@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251106-b4-of-match-matchine-data-v1-4-d780ea1780c2@linaro.org>

On 06-11-25, 20:07, Krzysztof Kozlowski wrote:
> Replace open-coded getting root OF node and matching against it with
> new of_machine_device_match() helper.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

