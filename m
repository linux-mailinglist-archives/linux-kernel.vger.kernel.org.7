Return-Path: <linux-kernel+bounces-780457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99165B3021B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 20:32:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E2B21BC33EA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 18:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C73A2EC55C;
	Thu, 21 Aug 2025 18:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KdTQnqvO"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB4C025A352
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 18:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755801168; cv=none; b=BO1r5whowFBeTVg4l7NDJX+G8LHWk07ESqCcFg0cy1cnpu2BntQZ9xOVHqdwYlEJUQhYX26RXVedEjNim8WgquvVzKj9B/CqAAyqv5mfl02gyrc5gn6KpvV37VMkVp/b+QQFn86Z9HJVu8w3fxB2nifsLe5pDKPfZfWmZf6xw4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755801168; c=relaxed/simple;
	bh=xmFoegaHOnErQaDfGoJTZzEBXqlmEwNm+xf91HfBQDo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K80/EYEyxE0hMInBcBrMvy9elmI5IHb3lePsXAzZf0WMklpuPh159rZzOsfr1098fIzhE94AVAT4SE7FXS3FoZ5uD0GkDP0+GJPfMpmA6fojYgB+ZU2p6LBM8nyoYThVjjwFHH3NR3cDgK8UA3Nlo4oJ/AYQ6m3CWXQyagQE6r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KdTQnqvO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755801165;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KON+Q6whUKmJdJeXPPkBBlZNmW3IaSDriSZEFUK+R2Y=;
	b=KdTQnqvO/YQ+ueqFA2tkcWwHwUNk5Xe/8/XwrzqKxIF5LVHMJ/yqS4yZiMQKuftIlFVl4K
	OvDa0GXQSEtHW2toMcqhHnX4kNnI95gkY9SXQtUtnF9lkGBdjr/TJkZh7wrFONitIQgi1a
	KNDbCXIGjZP+0kFJm3U9RIntmBIMQhI=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-HomrRgpENWOi7YiHnjmFtQ-1; Thu, 21 Aug 2025 14:32:44 -0400
X-MC-Unique: HomrRgpENWOi7YiHnjmFtQ-1
X-Mimecast-MFC-AGG-ID: HomrRgpENWOi7YiHnjmFtQ_1755801164
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7e86499748cso646136185a.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 11:32:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755801164; x=1756405964;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KON+Q6whUKmJdJeXPPkBBlZNmW3IaSDriSZEFUK+R2Y=;
        b=M2+Fr8nUa6ah6b0NtE8gtxvKGfhFVNeVHH6ilB/tE0L4YDGheW+nxXDtZ1Np6dV8XV
         DhWfqu0UJys1ntfa/fS3WEIJbUcPWayemuyBcaDC38F3sJ7QoTbvAv/WytJNA8FPZSYZ
         TqH5rKc/w3b088r8V7qxHiBpiLMrUNa5TrNFH0ejYKv/dVGHD+vh8hmR89lBpgI5Wive
         86Q9rS+vjpHzca75sKe4lUYEAaEOXTUxHYUY3brdEcUm0t8cTspAKizs5Si3UXPsXx72
         WHgnTUv44/Px9GmzLEm9ZEGYOexGP9RCfyFDRqu8ugbiZe+hgmVs0ctoXzuci0ZQScAv
         OsDQ==
X-Forwarded-Encrypted: i=1; AJvYcCVc1bo+2pKur6RdgHR8Lx7ePCY3cOZznImsN2Di+Rb2apGBL71TLW19fpI0iLU4ox2f/5LTOKZzkFZxy/k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1ngX6Kd8UeWBW/Zy0BIc0R5FMqZRr3TpogOTGXE6FriMBuSUl
	h9B6X6v0CQ6oGV3dVZJwlJUIEUUSjRwWwy16jcmTM+uHnVcpbcVoY5unDaPXBiWmnIO0mlvy9ap
	QsCqOaSf9ELcz2K0F2glDeS4i0VHTuUpgcH9GpZsvHSmxo9P+lAmvQ8z+8sE1HXI2hA==
X-Gm-Gg: ASbGncs+sIYdxObAZnJqoVRBfsLDhTczV4pBpuQ7IozreLeKI/YFtLHfiAECW4lQHJD
	oH7WGofrpB7Kp6s0H1+RQe+1fjR1+CQGpkHSbm3zJ2csyrY1tu75iveZDLlE7Y/tBDNOrOLOZ4Z
	JJhapKH0ZtKQMAvHvwpeuDepajeOrYtB9WkvQsURzzhy7u2KQVkyrjkfz2gJ/C1JhU3qUpq5knx
	kaD/0EDsyBte2Ncq+DtBbHeG90FfJDQuKWC0/1eIgY+btAbozVV0ofOequJ3bY4nTupQvMZxbF+
	5kwexhN7OlcBwdiIrMwyvHX9DNp0l9Wn07Mc73ei8OGSvLFQg1bwsrDcPaxFvKA=
X-Received: by 2002:ac8:6f14:0:b0:4b1:1109:6090 with SMTP id d75a77b69052e-4b2aae2cc8bmr2120651cf.4.1755801163666;
        Thu, 21 Aug 2025 11:32:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG8u9mZep+thwTChGyaQOwVjhjsZ4znq9OEsEjARCqM1Fbessm7gFZ796HVd8qGyD2EqIFVpg==
X-Received: by 2002:ac8:6f14:0:b0:4b1:1109:6090 with SMTP id d75a77b69052e-4b2aae2cc8bmr2120031cf.4.1755801163034;
        Thu, 21 Aug 2025 11:32:43 -0700 (PDT)
Received: from x1 (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b11ddd693asm104533501cf.37.2025.08.21.11.32.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 11:32:42 -0700 (PDT)
Date: Thu, 21 Aug 2025 14:32:40 -0400
From: Brian Masney <bmasney@redhat.com>
To: dongxuyang@eswincomputing.com
Cc: mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	alex@ghiti.fr, linux-riscv@lists.infradead.org,
	ningyu@eswincomputing.com, linmin@eswincomputing.com,
	huangyifeng@eswincomputing.com, pinkesh.vaghela@einfochips.com
Subject: Re: [PATCH v4 2/3] clock: eswin: Add eic7700 clock driver
Message-ID: <aKdmSJtTrs6n7ZXI@x1>
References: <20250815093539.975-1-dongxuyang@eswincomputing.com>
 <20250815093720.1088-1-dongxuyang@eswincomputing.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250815093720.1088-1-dongxuyang@eswincomputing.com>
User-Agent: Mutt/2.2.14 (2025-02-20)

Hi,

On Fri, Aug 15, 2025 at 05:37:20PM +0800, dongxuyang@eswincomputing.com wrote:
> +static long clk_pll_round_rate(struct clk_hw *hw, unsigned long rate,
> +			       unsigned long *parent_rate)
> +{
> +	struct eswin_clk_pll *clk = to_pll_clk(hw);
> +	const char *clk_name = clk_hw_get_name(&clk->hw);
> +
> +	if (!clk_name)
> +		return -ENOMEM;
> +
> +	int index;
> +	u64 round_rate = 0;
> +
> +	/* Must be sorted in ascending order */
> +	u64 apll_clk[] = { APLL_LOW_FREQ, APLL_HIGH_FREQ };
> +	u64 cpu_pll_clk[] = { CLK_FREQ_100M,  CLK_FREQ_200M,  CLK_FREQ_400M,
> +			      CLK_FREQ_500M,  CLK_FREQ_600M,  CLK_FREQ_700M,
> +			      CLK_FREQ_800M,  CLK_FREQ_900M,  CLK_FREQ_1000M,
> +			      CLK_FREQ_1200M, CLK_FREQ_1300M, CLK_FREQ_1400M,
> +			      CLK_FREQ_1500M, CLK_FREQ_1600M, CLK_FREQ_1700M,
> +			      CLK_FREQ_1800M };
> +
> +	switch (str_to_pll_clk(clk_name)) {
> +	case CLK_APLL_FOUT1:
> +		index = find_closest(rate, apll_clk, ARRAY_SIZE(apll_clk));
> +		round_rate = apll_clk[index];
> +		break;
> +	case CLK_PLL_CPU:
> +		index = find_closest(rate, cpu_pll_clk,
> +				     ARRAY_SIZE(cpu_pll_clk));
> +		round_rate = cpu_pll_clk[index];
> +		break;
> +	default:
> +		pr_err("%s %d, unknown clk %s\n", __func__, __LINE__,
> +		       clk_name);
> +		break;
> +	}
> +	return round_rate;
> +}
> +
> +static const struct clk_ops eswin_clk_pll_ops = {
> +	.set_rate = clk_pll_set_rate,
> +	.recalc_rate = clk_pll_recalc_rate,
> +	.round_rate = clk_pll_round_rate,
> +};

The round_rate clk op is deprecated. Please convert this over to use
determine_rate.

Brian


