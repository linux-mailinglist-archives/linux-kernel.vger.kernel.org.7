Return-Path: <linux-kernel+bounces-737047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45D2AB0A700
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 17:21:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63FF43B834B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 15:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 050762DCF7B;
	Fri, 18 Jul 2025 15:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hgUWtF3M"
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D38921D6AA
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 15:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752852069; cv=none; b=Uad4D5VU1zhlgvb06LO9IdGeI5kHy5g0J+FEHR35M/1Z3srVTI9iMAvc71ik2XJfxxBRnWhhulbszYwP19lcP/Dzl7aBPRkbCpxlT7oVoSOwqZgrezE/ZMjRCE0fubGy84KXqKfgLd6Hk5t2IEMMXb5828PE/E7Xls49Xjn1yKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752852069; c=relaxed/simple;
	bh=E3zelDCTh/t8II8UuBRX1FtcJbTydx6/K8VxkByBAQM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MWRT5qKUa1kLcBM69Wsmpq014BZqkT8AFpcVZ/3FUn9IFrzUfDFj7eEfngAz9IoSBO2Y+J86Y/XjLjnidg+GCzuCoqoQo6RCeL7L0vub9tvZmCx+DaJ49A2X6tGX077POz5i/xMGNGSMM6ZZPTJJ/Y1N8TVEEns/MCiW0S8L+c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hgUWtF3M; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-41b6561d3e6so1286063b6e.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 08:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752852067; x=1753456867; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qYuxKIpCYIcO+gJn+7H1gBQp96uaiFhZpQnHXL5+kYE=;
        b=hgUWtF3Mfm0AgUg49lFdH1vn1DZfqhL6WmRF8bl7NErejMDePl045+aleqjbEOHjuf
         LwcJGvMdr6MBbvTgDZYw+hTfvmpIRw3TvZnkGa/Cd6Mi7WDLlAdUMBohMo/otbv3z4SZ
         c5IdY9Pz+2XmXOOvMZJYZv81DNr1iy4Rj2XzBBbSit+DLjo1DnRlUroRS6x7vN9BNXbd
         H9iAmg7MiZ9+Xrur0l21pWrDmoTFciHDtX4mPpVWHBnvMC/N6kiTH3PF0mccIuY4OTgr
         pQViCteaTT9wsQOy7yEfseymiQchhLeRzwthRdYZIPRydZtRMHk8RyKo9gKKM2K/kHfL
         0EuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752852067; x=1753456867;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qYuxKIpCYIcO+gJn+7H1gBQp96uaiFhZpQnHXL5+kYE=;
        b=Y30qZLL6LrTClxpYnC91t1mey6wsg9B9noyIbcfsRK8hvTTPTXZNjpfAv6JRU4Rhcb
         3DjJk3MMS1o3C7PHtzCeaKkPX9ll0rRaG2C+VCV2wrK21IamHGNllf4D59XHjGAzIXPl
         IxAGafvmmWDD89t6WRaEzn57QuV3+72tqvB+swM/JqsODCTdJ2tNPvEtaIsz59KxY4QN
         fTKuUE63aHBPkDK7D8aQpGRarLjPFvPEbI9wLKyNgTYlR6c1+Ls9XXe+DzzFQY7sF6UL
         D55RyDNsmJ7rFqWwImb14+vx2gqQgWGptVkG8khYc9i8OZ8/MAZJZMqNYc2p4D2UcQXt
         1bJQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJMDgYx+f6TiqrZXmmFgtqjfI2a5Kt/r9+e2TtGozevJhL9YiIo2YYgidLB/SLHVdFeftkI+NjvDCAPv4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxf+KBd/DaqnYdrI4rGWsO2s23laLRLL72u2nK0p53PkgcoNMVQ
	n7B2Ri1jYnSFG8pcHZ03tRS+MrZ8UWBAFfvGDhtJZwatX6t0xsgY93tOwyAd1oPnIVc=
X-Gm-Gg: ASbGncuG7PnJWLWWf9GrL2GhkgFynHmTRFEZnuhMK7aOGsr3/DN87Oj+ZtXiGaw7/hQ
	nyd3axy0UpzKEqIjh7jGE+P5FtQKj3W9HpM/FocmHAZYDKIDuMjIrCg6olB/1xzs+HObxTQAUsu
	Sc8KnHt0UQdsSNiUC7hCuhkNEeXr4UA+KH43qZ1FMLdkPcbf2Mhps2DTjRSWOWz4EpB6u+SwVFq
	vm1ljmsSnhQ369Jc3bumKjyGP1uGLbHxKhVqjwfkebV9GKzNyOftAf6pzEu2dZj+UMXtiZgBRJr
	feR4yIEELguCEiE1UNE+OfEc4qWraCoE6ZTxjY5x7pUzz24oMU6iv/i0knhzdJIvVbarzP/imOa
	59rBfQSKkhtODSck9cC61lUQTeq3CQg==
X-Google-Smtp-Source: AGHT+IFHYUOrLnCL26v1j/YOSaFa73FuGV6iSj194qbCo/8B+uaKvogFvTM462nA+ygYaDPEodMSug==
X-Received: by 2002:a05:6808:1301:b0:406:7704:b2e9 with SMTP id 5614622812f47-41d036ec35amr7991928b6e.9.1752852063904;
        Fri, 18 Jul 2025 08:21:03 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:e5d3:a824:1a57:fcaf])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-41fd5951f20sm458273b6e.44.2025.07.18.08.21.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jul 2025 08:21:03 -0700 (PDT)
Date: Fri, 18 Jul 2025 18:21:00 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Xu Yang <xu.yang_2@nxp.com>, Chester Lin <chester62515@gmail.com>,
	Matthias Brugger <mbrugger@suse.com>,
	Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>,
	NXP S32 Linux Team <s32@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] arm64: dts: s32g3: Fix whitespace issue in device
 tree
Message-ID: <e4c5fe15-87c8-42d5-b4d7-09e3d1f7e712@suswa.mountain>
References: <cover.1752703107.git.dan.carpenter@linaro.org>
 <52960eb1-4432-436b-89aa-d50fc7da2c3a@sabinyo.mountain>
 <95b3a17e-a5a2-4d84-960c-2539af9d5450@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <95b3a17e-a5a2-4d84-960c-2539af9d5450@kernel.org>

On Fri, Jul 18, 2025 at 08:58:19AM +0200, Krzysztof Kozlowski wrote:
> On 17/07/2025 00:46, Dan Carpenter wrote:
> > Checkpatch points out that this should use spaces instead of tabs.
> > "ERROR: code indent should use tabs where possible".
> > 
> > Reported-by: Xu Yang <xu.yang_2@nxp.com>
> > Closes: https://lore.kernel.org/all/u7glt7mn33lbdeskbr4ily6tjjifvffy64llwpi5b2rrhx5tnv@y2h2y3oz3xc4/
> > Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> > ---
> 
> Patches were not merged, so this should be squashed there... or you
> meant they went with Greg USB? Then no, that's dissapointing, you are
> not supposed to send DTS patches to Greg's subsystem.

I worry that I have accidentally stepped into politics...

Yes, it went through Greg's tree.  I'm just using get_maintainer.pl.
Looking at it now, Greg and linux-usb weren't even on the Cc list for
the DTS patches.  There was probably some b4 magic which let him apply
the whole series.

How was this supposed to have worked?

regards,
dan carpenter

