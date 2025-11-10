Return-Path: <linux-kernel+bounces-893011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E715C4654F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 12:41:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7AD734EAAA1
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 11:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA1AC309F00;
	Mon, 10 Nov 2025 11:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="v6AIftcw"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 666DC2FBDF3
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 11:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762774808; cv=none; b=TcQMdn+sLXItzD6XuKtTBoQ1AVsDknJpoByAwYN2NzVpjN+RaNzl8+CEMeuypAtn/z346f4wY6LDVhaT/L8D4sPgnCNzsy5mqFBSt1vxOFrC9v5k+SGqpRb/37sFxPkY6+DjQK+x1CRgRS2LfY02b/R6qrv+dlIMzkaZrQguJ84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762774808; c=relaxed/simple;
	bh=54NkSaWzKBnhmYKVhYAafCeDsl+Vi7l2IbYdsfjy6rY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M1iRrAEmwQGxN0CHbUyQv/Pe2JTEvRqzNQsJI+udPS4SSp0mfq9p2t/pw95LC3DSWDyLyVzPeh1QwdFVaviNAmxGt/gXC52io4B1B3r3TbUHWjV+1nioLzSedT45xQsbzXJRDX+2MfqtMXYL4/R5G1Gp6YpVUTE5eVfa6YdXMNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=v6AIftcw; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-42b31507ed8so1527201f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 03:40:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762774804; x=1763379604; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/8LJLkQlhnVDYB5WFdSOlgPUhT3qQ6T/PIi1MnL8a34=;
        b=v6AIftcwQ1ywkxLSX+uPqASz8T39pooRv69YFV1yTl5CvajDJ0hgWiE/hXWtrPTy22
         dwgpp3dRIxV/g4dJALmCl8V+AK92J+Vx0o9IMbrqwfnHycHPFFi3/SmwA2twiZX0pKSH
         mZKQjuMWQSn/KBCGFiKjr6gZhIiTuWmEWd0hl/MLyUdELWmNU+txhYzbFu7ju7PDJp6Q
         tmrrSxvC7/3Jc0Zr3NVCg0dXMouJj5e8lV+nGoaG4Rw4+w/4BloJB+VeqtXPWbkXHMdu
         V1T5h2I4cAXtV49mz0NZ7EHZK2ndRDwxK+kln0/sn9YKmOfN9Ra2feWsDg6l/ruxEuhw
         ANQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762774804; x=1763379604;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/8LJLkQlhnVDYB5WFdSOlgPUhT3qQ6T/PIi1MnL8a34=;
        b=OQL1U3ZjJ1EQyL4MN17s6FMryB9LBKaEEm7IFgLVZr/XjukY6oPG+YGk5MOFe1KPj6
         IZQeyGTZJHT7DwHb4qyUP8TkV2LdTc/jEx3W6OLNAGUyMbJ7cjuTeFFztIK4pRVemZTA
         aBUQgivF0rfCB+INE2nRYRp/rMpxT5Jpza+kZsUul2vjkhwdIBdcZ4RrjokTXc7BuWfJ
         1bFKpTDzlSVsV6Cac5zCzJlXYKPUwt3eMc8lQhPFuKcX/ENsqKfalMlap8k0hjlgaEEF
         CxW46IsvOIRKxhuybEObZWy9JR0SZiUxS1kXLpCBRnwb2LM2HUaRw6F2yi2YTM3af3VU
         mvBQ==
X-Forwarded-Encrypted: i=1; AJvYcCWmtQgz6Xnn4M1GJPktwYMl5vZcceXxTYHK11RNtWQg7T80+GMidLmSb2Wjyr1z46/xK8pclIyEitJoyiE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMMLxRZsKWEwYZslYdF0zygacfV8cns5ZiNtZ4Z9UMq4UqbQC7
	SIq7G6CIU/n3SjkqERJxd7JbRcOUqhvZOhiV8IKa3NLPD1qRD5ARTcs+3pB4lbe4BbE=
X-Gm-Gg: ASbGncv/4kyzKLNAt5Uhp47WBlTQledxWkxv4WBW3k9cOSKe+4J7F9RsDbNti3kb2ed
	WyBJP0OKfZCrv4rbrMW7v88+sw+BccSWuTm5t1ePwJgMyH5tahx9q3/jkXL/B/tPPVJcXttURkS
	R4iEPwKoxCjEOIt0wi039bAmKZOTlJsvnPlC8FDgfx7TilKQJ5GdNV7ngf+mhUjGv3eVbufQsYN
	U6hIZVgNctEP8BdBdNJgdEmIZPcP3niXhGu7a5Pi5lwTV2UPbBL0FwGnSHcRJfVpkZ6sGrN6GFf
	lQwgTgyav9VSluRvubPfebHDuIy55VxFC4dRjSs7y3NZ+hOjPYFTEUVolRQyJNAxkmJDM0fFzDO
	CMigzakbSZaDdy1Y4A0tlz/qjCgpT1H984DpoCzGQm+OCVHgCOPI2zpNX8MUYGcmUu0bW/i6OzR
	GvNqZDU+cMXKVG/9uT5vhXFKMT3rikOwVv1736KpOzcbJcQ2g60AjmYq5so19ccRM=
X-Google-Smtp-Source: AGHT+IHc0y0L/IlFkDJCuI/XoUBdec6Dc+v/BCPlZFQShA4ijfqtxDc6+cizrEb5ne5sPA0PgA8OEQ==
X-Received: by 2002:a05:6000:657:b0:42b:3907:a38b with SMTP id ffacd0b85a97d-42b3907a591mr3013836f8f.44.1762774803631;
        Mon, 10 Nov 2025 03:40:03 -0800 (PST)
Received: from [192.168.0.21] (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42ac679d544sm22562080f8f.46.2025.11.10.03.40.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Nov 2025 03:40:03 -0800 (PST)
Message-ID: <f48bf868-29df-43bb-b1f5-d27f8ffb9d8e@linaro.org>
Date: Mon, 10 Nov 2025 11:40:02 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 6/8] media: qcom: camss: csiphy-3ph: Use sdm845 C-PHY
 configuration sequence
To: david@ixit.cz, Robert Foss <rfoss@kernel.org>,
 Todor Tomov <todor.too@gmail.com>,
 Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Luca Weiss <luca.weiss@fairphone.com>, Petr Hodina <phodina@protonmail.com>,
 Casey Connolly <casey.connolly@linaro.org>, "Dr. Git" <drgitx@gmail.com>
Cc: Joel Selvaraj <foss@joelselvaraj.com>, linux-media@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 phone-devel@vger.kernel.org
References: <20251109-qcom-cphy-v1-0-165f7e79b0e1@ixit.cz>
 <20251109-qcom-cphy-v1-6-165f7e79b0e1@ixit.cz>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Content-Language: en-US
In-Reply-To: <20251109-qcom-cphy-v1-6-165f7e79b0e1@ixit.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 09/11/2025 09:39, David Heidelberg via B4 Relay wrote:
> From: David Heidelberg <david@ixit.cz>
> 
> Enable the 3-phase (3PH) lane configuration introduced earlier when
> C-PHY mode is requested on the SDM845 platform. This ensures the proper
> initialization sequence is used for C-PHY operation.
> 
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>   drivers/media/platform/qcom/camss/camss-csiphy-3ph-1-0.c | 10 ++++++++--
>   1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/media/platform/qcom/camss/camss-csiphy-3ph-1-0.c b/drivers/media/platform/qcom/camss/camss-csiphy-3ph-1-0.c
> index c2adbde6b4e0d..03f5c4676e89a 100644
> --- a/drivers/media/platform/qcom/camss/camss-csiphy-3ph-1-0.c
> +++ b/drivers/media/platform/qcom/camss/camss-csiphy-3ph-1-0.c
> @@ -1103,8 +1103,14 @@ static void csiphy_lanes_enable(struct csiphy_device *csiphy,
>   
>   	switch (csiphy->camss->res->version) {
>   	case CAMSS_845:
> -		regs->lane_regs = &lane_regs_sdm845[0];
> -		regs->lane_array_size = ARRAY_SIZE(lane_regs_sdm845);
> +		if (c->cphy) {
> +			regs->lane_regs = &lane_regs_sdm845_3ph[0];
> +			regs->lane_array_size = ARRAY_SIZE(lane_regs_sdm845_3ph);
> +
> +		} else {
> +			regs->lane_regs = &lane_regs_sdm845[0];
> +			regs->lane_array_size = ARRAY_SIZE(lane_regs_sdm845);
> +		}
>   		break;
>   	case CAMSS_2290:
>   		regs->lane_regs = &lane_regs_qcm2290[0];
> 

Assuming the bool becomes an int derived from the define instead...

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

