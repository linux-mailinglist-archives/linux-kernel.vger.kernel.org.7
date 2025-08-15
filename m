Return-Path: <linux-kernel+bounces-770405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96B61B27A60
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 09:51:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 578FDAC7AD3
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 07:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AE3529D26C;
	Fri, 15 Aug 2025 07:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cwK3dEm0"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC6729AAF5
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 07:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755244304; cv=none; b=YkAGtV3zElwAmd+OO2SZvSTQTSX5a0smoBSkTwCjWOrXpQTGCLfMNnOjeYXcMa3Xld4qn7rTFOcorDz7xynG3C3jMuFywVpiLGvalmpEZlZ9OWOX+E77OfgK8cyldbntMFT3tuEuGWmXOlHPjlBn7kKLXZB298AYCK51MslhJjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755244304; c=relaxed/simple;
	bh=wM1U30RQbt9hBouuD0ezUDPgcheiH5LPKBmgTE1Ky2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aMxCaS/RC8VIndEuZBeK7wWl9qFDTJuDF6Z0rBWyuDIA/oMrgDZJ7ukDFEleKwpPPPJzv+xlLn5CCYEuiRbDk2+qRPY+/0/+iAk6Ms92iQlgiukTj+tHvQwNcAgGmQ6KHiEK7zX4/qzXHKE31Q9j1g5tigZTuSojvV879R+VKII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cwK3dEm0; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3b9edf4cf6cso1417120f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 00:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755244300; x=1755849100; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7m6KRZ644lLKsPQroVf0XIC4bXSKC2MeWxzfY2tyrfE=;
        b=cwK3dEm0J8ToNAu7/73elVZ2CRHijlXZxaEMLdAUAjVM4OWcJNV1syrQWrOlBIqfj7
         O2kRa/P4sKSQByEKMyt1pwr4/8Dm58L+rLc5mYiOsUCx65kNpuKw6GbuRvNkrHekQi/q
         /P0OFVexU127j+w3XftVsN1rW9hyjMY+qYop6VUI7tkMDZBywEJ4P9XVFkmK39SeT4wS
         UvKy+FcfutYMwXyJ/ze3yIuRuDcadiqsDjSQpO1NAPZkrpTef4B3dWyY8LkyuP1Ve1+T
         +ALQi64bcegzIruddJYTlD/njTkqORezTOF9qiwzIiGmUZfikTl/bb561kTi2ZCzTock
         mu/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755244300; x=1755849100;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7m6KRZ644lLKsPQroVf0XIC4bXSKC2MeWxzfY2tyrfE=;
        b=KJRSOJULp+96igyvLJ7XjeQNqVWXeerecyw7mjAmjslZMSzNTTGRThJxalTXIktiIs
         nyzocGXoq34i6B+NhB9Dbp4GpL6/8wvp4+NJblKbnpqhnzCBGUjIsf8eV7UqbgmoIdhN
         Fl1uC2v7qAD1xVvtWwjmffrA1M3UH6xkyHzyz2oyqoNNOGQiVc3VNKkwx4twk+AWdzAr
         JhqBqsXpwFKc+2zMC/gdAOtaf10e26vfsMfHrTNKL/Qal6yCFdePacKw52fnUp6PNGpE
         2IJaVtD3DuoPGBGafGo8Rb3ukqt7A3q+b6X3kQ12to2VqTZpHjunsrb17U7b3jlEdhFj
         qq8w==
X-Forwarded-Encrypted: i=1; AJvYcCVT4g7tfzEgkSbbmuU2zjqCaUYw34a4hZn3it/SnbBmN2tSSntK0K6Qy9j5F8mADFr9PObiI/62wN/U/H0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzG5Ix1920UEywGL5k5W0OkFFKBVFuaBons2J1Rc7BsL0DNHpxQ
	R2N/K67+VVlqFLbsaeCJ/qsu1oPUs3u/FhemmfRCcogzztj/0kzW3fO0Wot0zoyQHpI=
X-Gm-Gg: ASbGncs/cOdCQ9kuueuRqWTM+jeiyXsveGT1ZiBlrFe6ZlB71FR2kACvjpAk9U+L1JP
	/Q6p5oKZSSBmsS6U2bnWyG+JMIdZOZLtI4tImRISIdjjHhmAPhBq9PIN0GcilnAOr6DLw1kb8Nv
	qWLbP5MfpoRFrdVUDjyNkRAeSKXVnzviLIIElN41jvFW5Uej4MKaK+ub2oCQHxydSbZE1DJL22X
	aQY8xGpV50/qTLH+eYH4te1nlQGwwlr+A4qevrs2/yWQ25D3PrgHGyM2ujvtm3AQh18SK4Ck3O/
	2DdIbgnQOWzhe+9iLTTcKoISxwpTfJy6mTBEH/8i0Qad7YXGI9qvV63KHeNLGOy83j19yYij+mJ
	qyklhQ6uRJ9xuGkZIOmpIF1EuWdI=
X-Google-Smtp-Source: AGHT+IHGaYmTmAXRjZNxgrE/I/LGdmAsoAt1BCBaN3PbkpwZZAN5Rl0gISUa4t157xbfeVhA78qhSA==
X-Received: by 2002:a05:6000:430b:b0:3b7:9589:1fd1 with SMTP id ffacd0b85a97d-3bb68fdc587mr833175f8f.44.1755244300612;
        Fri, 15 Aug 2025 00:51:40 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3bb64758d27sm1004077f8f.9.2025.08.15.00.51.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 00:51:40 -0700 (PDT)
Date: Fri, 15 Aug 2025 10:51:36 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Peng Fan <peng.fan@oss.nxp.com>
Cc: Peng Fan <peng.fan@nxp.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Cristian Marussi <cristian.marussi@arm.com>,
	Marco Felsch <m.felsch@pengutronix.de>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
	arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/3] clk: conf: Support assigned-clock-sscs
Message-ID: <aJ7nCL0PS0DX8rtk@stanley.mountain>
References: <20250812-clk-ssc-version1-v1-0-cef60f20d770@nxp.com>
 <20250812-clk-ssc-version1-v1-2-cef60f20d770@nxp.com>
 <aJwnH2mlRdqp1K1u@stanley.mountain>
 <20250815071249.GA20726@nxa18884-linux.ap.freescale.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250815071249.GA20726@nxa18884-linux.ap.freescale.net>

On Fri, Aug 15, 2025 at 04:50:42PM +0800, Peng Fan wrote:
> >> +		if (modfreq_hz || spread_bp || method) {
> >> +			rc = of_parse_phandle_with_args(node, "assigned-clocks",
> >> +					"#clock-cells",	index, &clkspec);
> >> +			if (rc < 0) {
> >> +				/* skip empty (null) phandles */
> >> +				if (rc == -ENOENT)
> >> +					continue;
> >> +				else
> >> +					return rc;
> >> +			}
> >> +
> >> +			if (clkspec.np == node && !clk_supplier) {
> >
> >Could you add a comment for this condition?  It's strange to me that we
> >don't iterate through the whole array.
> 
> I just follow the logic in __set_clk_parents and __set_clk_rates, nothing
> special here.
> 
> It is just like to phase out cases as below:
>   node-x {
> 	/* node-x is not a clk provider, but assigned-clocks uses node-x phandle */
> 	assigned-clocks = <&node-x   XYZ>;
>   }
> 

Ah.  Great.  Thanks.

regards,
dan carpenter


