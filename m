Return-Path: <linux-kernel+bounces-761889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E503B1FFA8
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 08:53:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B844189C0D3
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 06:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13B2D2D8DAA;
	Mon, 11 Aug 2025 06:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AxAknPmB"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 089942D8793
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 06:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754895212; cv=none; b=FnFh0RQT/zmmcVBQjKyItryHa4vmO4L5BNrWmftiAyz+W4La96onHxl9sNz81waipujApNPsDszfgUBDwZyHka2mrahortQE0VOxrwmXEDTe0/vS3fr3JoMLkmfqMZSCzkXCLufyMAQGfX4VwUTe5nXCrYTlbKZnQEU5fIi8qKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754895212; c=relaxed/simple;
	bh=s67MicxTyFJvpq6HlkPwIjp6fTvRqRqA28FzYgVvHjE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XP5yy8PeBEdZFe85fbLcoV+SiIjYhrg9A7WjRg/+nmN8G2q6q47MdDRBFB54gWKcpsjXEbHsz898hicVweQc0NQCuTreUNdnaJ9uGIji1vpZNpqz2o3+v4gNVJ07X8TbBWSyjzVq8o3yf2c2Djaruofk65jvURuxAhb5M9SoHEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AxAknPmB; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b422b31b1c0so2425550a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 10 Aug 2025 23:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754895210; x=1755500010; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=H0BX64TErFoIWs1t6Evpyt8styxu8dJRt0rrYpLp44Y=;
        b=AxAknPmBnmprw+42nnM7Adria8U8ZmLHvGRRRMMD+bLERAL8jfI23ZpJaTy1k9PmPK
         ZVi46TmUO6hlCsi+VIvmc0Xfjnr+EUUEnOb14dxzx+Flx9rvJNPTPmfprg/E25u3Uws3
         8qydAxapuw2Q3xgZd7jWHFzcznPc8CoT68Zae6LZmx996sTXOxfzN4UpDMzfzYjEo3SE
         caXdApj/3WUwwgx4KBNs2YxDP2h6zXOcxsA3wRvlqO1Yj6ofYIRsHCsM+VSzr25ltC6l
         Sf0BP11wtBbpy3ULxR4Sx8GPPpZzEdq5oKgZHxBtEmpbSVGbEq48SkYbwOVplZ5q1vxa
         UfdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754895210; x=1755500010;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H0BX64TErFoIWs1t6Evpyt8styxu8dJRt0rrYpLp44Y=;
        b=uNd4RYDIfelNDJTq9Pi1xmQs2QlAMcSQANSPknCjvH25f0na7VITYGNJ4E+0IHGalq
         jiIJOO9HU8UV5Z7y/BZLC4qnG9f/RBrzMdDhtiu+0yUQ1bmnZ+WKviY3iBojn/Wtok8A
         nY5Xmc/SdsXPtZAx0tFEOQ2iEdVj6HsVhHbqkHkmcnyTAuCOwcjkUoHBDizse79u/5rr
         b28iFVEtnoGRfF7+c/JiExEIuijo1sJyXEjlV3sy+DqcmzP49Vo1FyGIPvgVO2EypBBm
         XZYuf+cJQ6vJIH4BfmqyHwBxcZXJez6GFkjWRxBIGysjHvnZJ1RsEAviwWPh7bP2Cb89
         w72w==
X-Forwarded-Encrypted: i=1; AJvYcCWO7nSKJDwExr051S6K5nEVmJFyvkFxRfPfQDkWAZyar/MGVOjkXesqnRex1mGuXAtXJSwdWCc6uLDUmtg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMQfwxS+3iqQRBR4eO0pKzhrLWJzWPR2OI8eV4TTD14BjV2B9f
	jeNbgQrKPmHlwR0/xbyLutfcMOuWyqBnVFS8t0gWtOcm/D5wXNNDpAcRR4hrwOjpeV+1qfEgGB5
	LwLH8
X-Gm-Gg: ASbGncv6khpj7eIiEa8a1LnwfNv9S5N+nnpwT+H0iSd9OvOmLSrn2jbEFnv/qINhs/J
	JMemkou5RBV7IpQxEsnD7/vmHqpdUd6ZnXu9GAHgenomuupu3GXWmjCAi4+2/ltQ1ve3KyIrNHq
	g4HygmLrJ2T9zkAT2ejrferwgVN5HvBFOnDRJP9tdxHhXfhlVW6o72gYjgqL6AQunX7T9Tao5JF
	dk/SbE3UaPygq9+OV8QbhTXOKUU02Owyy7Ua2y3sWaZsMIP1CRssVt1v/FCfgHCCwKadMbL5PKw
	Kj9uLexibTEM79WC0KDosCMMeWjHL7TGFvlO7KjN3XPY8X+rfSVCHfIn/hcHWnorptQD7UvPkNh
	QnR6OyiEdmwIkQ9brelB3xmHG
X-Google-Smtp-Source: AGHT+IEIl0S/VOqDSLXuBI4x/e0A22S456H8IOsSLzikWZ8KM0Gi2SPraGYKilSTYjzIMK0FS+Uavw==
X-Received: by 2002:a17:903:3c30:b0:242:89fd:48cc with SMTP id d9443c01a7336-242c224ccb3mr163220875ad.50.1754895210360;
        Sun, 10 Aug 2025 23:53:30 -0700 (PDT)
Received: from localhost ([122.172.87.165])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1ef6bcfsm266721525ad.5.2025.08.10.23.53.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Aug 2025 23:53:29 -0700 (PDT)
Date: Mon, 11 Aug 2025 12:23:27 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Akhilesh Patil <akhilesh@ee.iitb.ac.in>
Cc: andrew@lunn.ch, gregory.clement@bootlin.com,
	sebastian.hesselbarth@gmail.com, rafael@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, akhileshpatilvnit@gmail.com,
	skhan@linuxfoundation.org
Subject: Re: [PATCH 1/1] cpufreq: armada-37xx: use max() to calculate
 target_vm
Message-ID: <20250811065327.m7hz3676vdzivktn@vireshk-i7>
References: <cover.1754747830.git.akhilesh@ee.iitb.ac.in>
 <26e67441fd3e91beca47fb4b6fb2accbe1088c79.1754747831.git.akhilesh@ee.iitb.ac.in>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26e67441fd3e91beca47fb4b6fb2accbe1088c79.1754747831.git.akhilesh@ee.iitb.ac.in>

On 09-08-25, 19:46, Akhilesh Patil wrote:
> Use max() macro while calculating target_vm to simplify and improve the
> armada-37xx-cpufreq driver code.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/r/202503251256.rrl65HgY-lkp@intel.com/
> Reported-by: Yang Ruibin <11162571@vivo.com>
> Closes: https://lore.kernel.org/lkml/2c55fb07-b29e-43e0-8697-f75d1f0df89a@vivo.com/
> Signed-off-by: Akhilesh Patil <akhilesh@ee.iitb.ac.in>
> ---
>  drivers/cpufreq/armada-37xx-cpufreq.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied. Thanks.

-- 
viresh

