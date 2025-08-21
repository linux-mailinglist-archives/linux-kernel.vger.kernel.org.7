Return-Path: <linux-kernel+bounces-780739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F9FFB3089D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 23:46:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F32B624424
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 21:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CACF2E9737;
	Thu, 21 Aug 2025 21:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K8Ah7uDh"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 267DE2857F6
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 21:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755812790; cv=none; b=gdJwMTfKg69DTo0D+H70DBwGkseF6msPIIFYa7yfJJ5L2TFmjluPjb4PqYyce6MpufnSHHfCT9NyOS2dPY64t8FElwMVW2MvuSZ1icYN0NmsizFog9UPGGZSy+rUO2+irAi2d8ME8C97me1WPKdnjaiEgYz0BtfVCdrxux5Taws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755812790; c=relaxed/simple;
	bh=WjMsQZzuysaDV6R+P3ZzyoCh1QHeYreJxscNPZJrjvU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=evfjIdGA4M1ohJ+43Wbdy1PxP2l67NeO9JV679WywMru64Qjz8NMuShQdMuijdLio6S1h7MChUZdlZbLgstj+jXqp8VjQw6eYF3YpICUrbljtrmAw/dZISPgVDb4MT0cuOAlD5Sb2NUAir8aOwW5SO8kr0URAeoiSb0t3tR8mvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K8Ah7uDh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755812788;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UOEidWIYFOcPQc5k2cWSdnWss7AqeJmy+kRLikq18m4=;
	b=K8Ah7uDhCPqerNmb4nVEJWvyZZyKKUflA1cziygM+Ve249/l3ZGLl0TvvteiC9CWnLSe/x
	vE1yJrRTtG2RgqcEjgiY67nZ95glF0HthDVB77wIeXy0mDgUlFPkJQaIfIJmP/+YdAd/P5
	9H53nhE9FSWOgdCF7WLqqo1+UpkJw/c=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-348-p8SLx1UVPtmE3TDZ8jIbEA-1; Thu, 21 Aug 2025 17:46:27 -0400
X-MC-Unique: p8SLx1UVPtmE3TDZ8jIbEA-1
X-Mimecast-MFC-AGG-ID: p8SLx1UVPtmE3TDZ8jIbEA_1755812786
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4b295536c25so28573461cf.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 14:46:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755812786; x=1756417586;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UOEidWIYFOcPQc5k2cWSdnWss7AqeJmy+kRLikq18m4=;
        b=qik2O7fcd9fVq2ZDaAY6aWnQn5Xwgr+gRy5I78DQYqgT5ooyoOKc+2J8zOyTcZNvbz
         Hgv6uQw23km8mP3t21k3AEZrNkBnqJBT+cfSdyVoSfwRdeqLN9gHBicpYFbfvwuqGBzD
         nD1kejG5Zopxtv1rHPsykkxcxkyB30bfo2+bB0QV7ZCk64eID717An4ZMzFyg/U1rRjW
         Qa/kFkyDyvf2zCXsEjBW+ouOXnRtPZ+Mlv4S/bDIkYGiVmL8K4+4n0uUoQZa4F19CPUT
         I/TK+vkU5ETj5hM8icg4r7cbuHqFb7/1DSDpVC9cZy304XHabihd6HmBhNm4oowQU530
         a6KA==
X-Gm-Message-State: AOJu0Yw820Wi+SWNtYGc8hY1QgOuiW6gW69cNe4bSn3q7QLAW04NmIqU
	OufGMzlUtSTQqXpSwsstlWhC+8iw4ElI7wGojq9q3IDM5CsKOO2flstwYBxAIBuYlfiNN3orzX9
	2PYNGEsNPhMi45cA5wgVU8HQ56wtVjM7+0zQLuzyrng0CXqByM5RA0eXa84pA2U20pg==
X-Gm-Gg: ASbGncvOOS4PFdEbzlHLPjBFtCMIo4EuQouDsBLWO3rs/syHOQWYvFj4e6eVzWEyY63
	IjoowUbpW7gYlZRRNNLmu/EsHe4Qk/1mhob7KQ6otTnRc6uTmuL/8aJfaH0BuNbGq1SVHMZK847
	HBnyfUOctaBuALd/l5d0iTaYjuCkqHbpUg3GLTuMU7g03kBTYqO+1Vob7ukuU6PXCNy6Bd0yJjM
	BVq6TbRV6kb4YEjP89dsNwc8CJjOklrjuJrER4bSADEvkN7j79A4UMbFtxYsx1VRZ1IKmJ7SEuj
	YSvHoaMC7iLxK6TfqRlV3lWDz9IUgyeCr+Ac8RiAEjOAfxqzXvjN823VpfLq0ARkdP0zMkYhrUn
	D9FUK+v1hWK7+reXVAm4=
X-Received: by 2002:ac8:5812:0:b0:4b0:73db:f81b with SMTP id d75a77b69052e-4b2aaa1a378mr10332791cf.10.1755812786475;
        Thu, 21 Aug 2025 14:46:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGM/f6AWKsD/uiuSUkJzb9jNkg9oqjjxZOXqxlVkr171nvQa2lEbcNla+IOhlEltLwBQr891g==
X-Received: by 2002:ac8:5812:0:b0:4b0:73db:f81b with SMTP id d75a77b69052e-4b2aaa1a378mr10332491cf.10.1755812786097;
        Thu, 21 Aug 2025 14:46:26 -0700 (PDT)
Received: from x1 (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e87e020514sm1201852885a.17.2025.08.21.14.46.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 14:46:25 -0700 (PDT)
Date: Thu, 21 Aug 2025 17:46:19 -0400
From: Brian Masney <bmasney@redhat.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Vladimir Zapolskiy <vz@mleia.com>,
	Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Drew Fustini <fustini@kernel.org>, Guo Ren <guoren@kernel.org>,
	Fu Wei <wefu@redhat.com>, linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-actions@lists.infradead.org, linux-arm-msm@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH 02/21] clk: remove unneeded 'fast_io' parameter in
 regmap_config
Message-ID: <aKeTq1lJ549a2jnQ@x1>
References: <20250813161517.4746-1-wsa+renesas@sang-engineering.com>
 <20250813161517.4746-3-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250813161517.4746-3-wsa+renesas@sang-engineering.com>
User-Agent: Mutt/2.2.14 (2025-02-20)

Hi Wolfram,

On Wed, Aug 13, 2025 at 06:14:48PM +0200, Wolfram Sang wrote:
> When using MMIO with regmap, fast_io is implied. No need to set it
> again.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
> No dependencies, can be applied directly to the subsystem tree. Buildbot is
> happy, too.
> 
>  drivers/clk/actions/owl-common.c  | 1 -
>  drivers/clk/clk-axm5516.c         | 1 -
>  drivers/clk/nxp/clk-lpc32xx.c     | 1 -
>  drivers/clk/qcom/a53-pll.c        | 1 -
>  drivers/clk/qcom/a7-pll.c         | 1 -
>  drivers/clk/qcom/apss-ipq-pll.c   | 1 -
>  drivers/clk/qcom/clk-cbf-8996.c   | 1 -
>  drivers/clk/qcom/clk-cpu-8996.c   | 1 -
>  drivers/clk/qcom/hfpll.c          | 1 -
>  drivers/clk/qcom/ipq-cmn-pll.c    | 1 -
>  drivers/clk/thead/clk-th1520-ap.c | 1 -
>  11 files changed, 11 deletions(-)

These all look good to me.

Reviewed-by: Brian Masney <bmasney@redhat.com>

Should drivers/clk/sprd/common.c also be updated as well?

Brian


