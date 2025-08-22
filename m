Return-Path: <linux-kernel+bounces-781238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98FC5B30FA2
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 08:55:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 799281660D3
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 06:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D106C2C327D;
	Fri, 22 Aug 2025 06:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YykTIPYK"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C22542E2281
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 06:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755845715; cv=none; b=Fab89mbtn0xCmy/hNNsPpzYqJny1gaDNiD3Hp72CZBdNZSxIkyaBI8ig9rdmUwUn6lmpTnyhccbffMXL2NaOXRzxWSjN6JNqEjHopYGJ10U1tgUG05kvPH/dOT2MJizVLS/IXGgBDkxRXwYzWAMVMXW3908Db837ElUKxInCFFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755845715; c=relaxed/simple;
	bh=EWHdzyRT33IHKlwkAtAepytBgh5e0kzufrx+qy60ECY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fh1JpTuk9FXgqnrS0PC7ckTEXnBBWF/elxKh17iEt9KHwyi/3LKkj7CaDTd5GO4BKwniwO/tCk7rZWC7kvSWX0P18cu1OI65tsGzkmoPB6vMafeJS48LIIpAZkPmV+CnicK/yb1eckj6ovsfz9KMfc1VX0+91NCdca1Dy9uvI44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YykTIPYK; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-76e2ea79219so2197547b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 23:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755845713; x=1756450513; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bjicZI/1Nbr8qAa/3VcUbv7hfNRQcnbsv7M4jPSglw0=;
        b=YykTIPYKV3nDmtOadZW4FF7zUtzPipM5DuFSrcLQZzI+iXYbd8bPHvItlkcBKVcNK2
         ZvRiSCbi8ykK1ixRIqNVVdD6v9mZGRO8uQDVG9fMoM21VUU2pHwZPO1V3X+V4prUAcI1
         EApeBiqvUT0UghRt5AtnghXMn1Ykm2iGXWADeUuf1/M4U/djhWNzfFszrtIyje+oB4hK
         2sULttvrecfJXDQwP9C37eH/tbHo57Fb6rj8cR+WhEoKj0io8juZVrVtcdDCdAUHkyRc
         /PpdjoRWuHS2z9IkZRl2EUrMawj4PDA/hzO3lFzOzQ5T2LiNz3+ryXRC6M50+PJ6jp7z
         3WGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755845713; x=1756450513;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bjicZI/1Nbr8qAa/3VcUbv7hfNRQcnbsv7M4jPSglw0=;
        b=miTY3P6ZAFGOBis9OntU3obS99SJjijxDsvuUdtXu1DOVfl+zvm55wT1owTSH70vrs
         Li3WPj6U6VwV2MThMo095CvnY7ux13WZWh8ocvq15nhNzhu90l8SJ/AWfsNjhrh5DpwQ
         1fGnbR/xrS+8YUfT93+FnNCFpdv2SMMU6DiCZ9HRHTXvtQ4deFMlP6xFPU7pK/fz8oH5
         11zq22bb5BKcLECD2vUA9dc0ESEZZNSBapig0Wwxw02Pzg6I5Ljd90BLQ5ifsOqs+8Fz
         rOUJGMTU68xw/3i4BOzSfEmLOzzJjtz35TmXLzJIRdiJ3jmD9wfky8DKovi8NLJP+xIo
         pS6w==
X-Forwarded-Encrypted: i=1; AJvYcCX4QxUZWq4+oIR29wKNyoyJOUAsCMDH0RySZuJiMtjwYXDVgpYsZtbdKy8JniTo75y8MnFguE9tyrrBn94=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIqnku+Q6OugDi7mY3nVWjmIG2SOrxnZLc+y5VATGddV5tWtHX
	zzL90UFrdv3ftnLNuV1JyFNPJlxCbPrB/AVaDHXfCctLIGLQqBcROXjEQcQ6ScsPtHI=
X-Gm-Gg: ASbGncuMYb4X4CfXrDBEqjF0bShBhfofy30MRljMhm0t/wPK0uFoAiamQ1RtvLU8Wfz
	mgnFaXpSTqtjEhQ3RhSCjD77TMG8xa++5O3zQXpARqEDJtOw2GBCVVHK/JO36BQNP6rJ4WaDQpG
	oVPahDcKU8Qc06bcmksjj+LYkTjUY991xxlxltN7ZM4HHsYRL8C5BE2S1M7Dl4W4i82JmruPY2m
	CJR65bPOu/0uZdM43uDLotL3sZjwNjT3GYprN2TZYKqDmsFg94v7EPOjRJXOKFMo4CBdylWmnn5
	uxRoIwCzZ8XkWPfA4KM0s8+B3rXEN1re3tTwnNzOrNCPK1r4DFb961HxQ+ZlCh0gAliIYZ2GCyr
	iyPiDyRpJjVVfb4oEG/q+z7Mp
X-Google-Smtp-Source: AGHT+IFqTCtn1vTBHrNEXFDiI/RKgrZ8CU3yklaDBqhgIBX1zop4EhNr7+iPGnFTdss9iSbzazknMg==
X-Received: by 2002:a05:6a00:2355:b0:76b:e0f7:42f with SMTP id d2e1a72fcca58-7702faaf381mr2736161b3a.19.1755845713053;
        Thu, 21 Aug 2025 23:55:13 -0700 (PDT)
Received: from localhost ([122.172.87.165])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e7d137dfbsm9903213b3a.44.2025.08.21.23.55.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 23:55:12 -0700 (PDT)
Date: Fri, 22 Aug 2025 12:25:10 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Judith Mendez <jm@ti.com>
Cc: Nishanth Menon <nm@ti.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Bryan Brattlof <bb@ti.com>, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH 2/3] cpufreq: ti: Allow all silicon revisions to support
 OPPs
Message-ID: <20250822065510.3vlbjwakt7ts75gk@vireshk-i7>
References: <20250818192632.2982223-1-jm@ti.com>
 <20250818192632.2982223-3-jm@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250818192632.2982223-3-jm@ti.com>

On 18-08-25, 14:26, Judith Mendez wrote:
> More silicon revisions are being defined for AM62x, AM62Px, and AM62ax
> SoCs. These silicon may also support currently establishes OPPs, so remove
> the revision limitation in ti-cpufreq and thus determine if an OPP applies
> with speed grade efuse parsing.
> 
> Signed-off-by: Judith Mendez <jm@ti.com>
> ---
>  drivers/cpufreq/ti-cpufreq.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cpufreq/ti-cpufreq.c b/drivers/cpufreq/ti-cpufreq.c
> index f7be09dc63e3..90c896d02649 100644
> --- a/drivers/cpufreq/ti-cpufreq.c
> +++ b/drivers/cpufreq/ti-cpufreq.c
> @@ -311,9 +311,9 @@ static struct ti_cpufreq_soc_data am3517_soc_data = {
>  };
>  
>  static const struct soc_device_attribute k3_cpufreq_soc[] = {
> -	{ .family = "AM62X", .revision = "SR1.0" },
> -	{ .family = "AM62AX", .revision = "SR1.0" },
> -	{ .family = "AM62PX", .revision = "SR1.0" },
> +	{ .family = "AM62X", },
> +	{ .family = "AM62AX", },
> +	{ .family = "AM62PX", },
>  	{ /* sentinel */ }
>  };

This got a minor conflict, fixed it as:

diff --git a/drivers/cpufreq/ti-cpufreq.c b/drivers/cpufreq/ti-cpufreq.c
index d6bd0d2dcf15..6ee76f5fe9c5 100644
--- a/drivers/cpufreq/ti-cpufreq.c
+++ b/drivers/cpufreq/ti-cpufreq.c
@@ -311,10 +311,10 @@ static struct ti_cpufreq_soc_data am3517_soc_data = {
 };

 static const struct soc_device_attribute k3_cpufreq_soc[] = {
-       { .family = "AM62X", .revision = "SR1.0" },
-       { .family = "AM62AX", .revision = "SR1.0" },
-       { .family = "AM62PX", .revision = "SR1.0" },
-       { .family = "AM62DX", .revision = "SR1.0" },
+       { .family = "AM62X", },
+       { .family = "AM62AX", },
+       { .family = "AM62PX", },
+       { .family = "AM62DX", },
        { /* sentinel */ }

-- 
viresh

