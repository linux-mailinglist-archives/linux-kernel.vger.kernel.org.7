Return-Path: <linux-kernel+bounces-752732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3465FB17A4A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 01:51:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD64D1772E3
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 23:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40B6928A3FA;
	Thu, 31 Jul 2025 23:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RYxyy8Ak"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E9E289E38;
	Thu, 31 Jul 2025 23:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754005856; cv=none; b=rMjcqq+UGnermBWGRzvTbCo3lZGJn80yCjQH54KIy0x+SKAxbZJ0brJ/G9b0atlJJBNWFoixz120tTao8KB9JaoqY6JA5m6AiFOvBJbgE3UkeEI87G7lb8Qk/qqDm+5IqZ9zXvdbK70chLE5tNL+Z9ZY8CjC8BvA8dlYxTDp5Ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754005856; c=relaxed/simple;
	bh=n+xgTXiwxj/r0YnLofwy5BYwuD6vgPqqtA81raYpl+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KkARgTKqAXfpkgp8/WNbBEOmQaZFoocBmmq9UpUPuKiP2X8qc3CS2hoCJsRsuQVHyskeJEUKKJaf+Njt/cel86JtDmWeA0mKxSnTx9smhlCBn56r5pMlYqIuurfhBkTr9hcWHYSN0z3/lP1bhlXcWrgzRyPvxR3ydyTKhkjQtWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RYxyy8Ak; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b3be5c0eb99so910896a12.1;
        Thu, 31 Jul 2025 16:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754005853; x=1754610653; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kCCXuKCh3v8xE5+dUZx33Pv4uJhuT1czbkXgRduKzU0=;
        b=RYxyy8AkspXmNrFewyICv4sxko9CQRswG/F6C6iYivHZZDAzKvbxTduGOQnsiYKUDG
         mkWop2skIsgVFTsdp44POGpa4XycTycgGvY7RUlUda3fo6EsxQOUN2t492PQJieFn7oz
         oEZsAYCHzZj/kL+trynJbIC/AdYvVpyRnsy8wS+8r4lsZl/QmtvExGtf4fsZX8Wrvdje
         3U3yxqNCrAz7X0kLvtOdU8k68xE7K4s7EKnPVbnDpoT6gf9YtILzOiOF6VQPFystOTqO
         tUahxRS8P7U2grNbnUOsAI119ALWHry8bT2OPBx0LHLDi0pl4GSv/3L371PyWcqddaRE
         UdzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754005853; x=1754610653;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kCCXuKCh3v8xE5+dUZx33Pv4uJhuT1czbkXgRduKzU0=;
        b=QXiValSzS7PqU8Hw7haWqewtk2WkjGu7A6FmaFfwtd5yHyjt0TqzK4o9tKKKmG0uyO
         LYXW5sjbsqozK2UgQF0sOhZU2jFJp51xm7Q0BWaqxPPEZ+62Pw3qACtQS2IwbfWPS1c4
         rGIjIOttKu4B5ONDfP2boS0kDroRMAgLjW+cNcTuKUQw58sA/gipOj4MA2X6fk/wG8XA
         Ztm4Nr48tIpFH2skHgTGRzrMzXPfPuHlcbZDKHHa8zwHsLxGW4vpYG27q+puwmBp7L9o
         VfK14DvquihbqMsimRs1+fpGJvaK/gApYO+UkeuXiiCp1pbDPUqAGRGkiupoWYPBNWc8
         yCRw==
X-Forwarded-Encrypted: i=1; AJvYcCU/yhrr2ZGOFTCkJybCSHUXwmo0l+im4iQayMfw8ccyHdaTMYGYncw/mAlJAE3VJq9G2vnGwlQTPrg2@vger.kernel.org, AJvYcCVK9sfOOMHg+BaGIeo7jNgtS1aEs95am1rphjSRPfBM0iJY9FCsRJryuMnPbqsEODTou6qE/mL/U3sk72g=@vger.kernel.org, AJvYcCWPV6AP3+fVlsBr+J7TmKeWQ53/e9Ub9minPwSuM/r7JUvIoqCCw3bGJmFl0dEKNlIkVQM+EXGhODY6@vger.kernel.org
X-Gm-Message-State: AOJu0YwN9mHwRwXRppLkWck+x9ZywjsGapa1DqU/1kmuzexB2weeL1a1
	xYzZpFQgV5nVt/Dbzt8RW8/Itx57Gz1mnjWyOuU3i9FkXti17JRVC2uR
X-Gm-Gg: ASbGncuMaXy43XiTNyeCBHMs5PR2JcNCUiteYw6jLYNDarWpxGAObihdKbVaffgfMgI
	HRAlxcd4cDSPT/HHyO3dRwn4ZeXsHIZdUGwT3XxBaFXyrjdyGR6vOyUTURhQo67Ycb3JjqOfC+Y
	ez2F+gUwTGN7pVPxeRSHKc1/hSPMngkEpELC6rLDezXBGnWDLKR96d7fYP/8NmEa5T4KK81aYaN
	T4hYo/aqtvkFPSyh2aq7jpr8Ml+NWMu/bgwa4o5GWpnCHEhHR0JmjlRoQ6/v1IZcrHn2x+QMU8w
	WA7us80gePyYq+0GN1nCtuQ7H/naXzwGFurwRN0FfxkpYefMeTIYa3QXDf5MU/KLEWVOSxkwgCw
	w38SWNIdQ637ETKACvPG/bvJ1Ert5Ry8c2BQ=
X-Google-Smtp-Source: AGHT+IHZP5vpLYjoG2db9CKFqk59UicpNqI84lwWQUFNl7O/CXSKg8clVq+Ai1asQhK5rgcd0aNObQ==
X-Received: by 2002:a17:90b:57e6:b0:313:d346:f347 with SMTP id 98e67ed59e1d1-31f5de58642mr12343818a91.35.1754005853333;
        Thu, 31 Jul 2025 16:50:53 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31f63f0bb79sm5700324a91.31.2025.07.31.16.50.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 16:50:52 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 31 Jul 2025 16:50:52 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Lakshay Piplani <lakshay.piplani@nxp.com>
Cc: linux-kernel@vger.kernel.org, jdelvare@suse.com,
	linux-hwmon@vger.kernel.org, corbet@lwn.net,
	linux-doc@vger.kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, devicetree@vger.kernel.org,
	vikash.bansal@nxp.com, priyanka.jain@nxp.com,
	shashank.rebbapragada@nxp.com
Subject: Re: [PATCH v2 2/2] hwmon: (lm75) Add NXP P3T1750 support
Message-ID: <e038b18c-4a14-4caa-9922-23ec5ea55f1b@roeck-us.net>
References: <20250728041913.3754236-1-lakshay.piplani@nxp.com>
 <20250728041913.3754236-2-lakshay.piplani@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250728041913.3754236-2-lakshay.piplani@nxp.com>

On Mon, Jul 28, 2025 at 09:49:13AM +0530, Lakshay Piplani wrote:
> Add support for lm75 compatible NXP P3T1750
> temperature sensor.
> 
> Signed-off-by: Lakshay Piplani <lakshay.piplani@nxp.com>
> ---
> Changes in v2:
> - None. Patch unchanged.

Alphabetic order applies here too.

Never mind, I fixed that up.

Applied.

Guenter

> 
>  Documentation/hwmon/lm75.rst |  6 ++++--
>  drivers/hwmon/lm75.c         | 13 +++++++++++++
>  2 files changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/hwmon/lm75.rst b/Documentation/hwmon/lm75.rst
> index c6a54bbca3c5..84e690824fee 100644
> --- a/Documentation/hwmon/lm75.rst
> +++ b/Documentation/hwmon/lm75.rst
> @@ -121,9 +121,9 @@ Supported chips:
>  
>           https://www.ti.com/product/TMP1075
>  
> -  * NXP LM75B, P3T1755, PCT2075
> +  * NXP LM75B, P3T1755, PCT2075, 'P3T1750'
>  
> -    Prefix: 'lm75b', 'p3t1755', 'pct2075'
> +    Prefix: 'lm75b', 'p3t1755', 'pct2075', 'p3t1750'
>  
>      Addresses scanned: none
>  
> @@ -135,6 +135,8 @@ Supported chips:
>  
>                 https://www.nxp.com/docs/en/data-sheet/PCT2075.pdf
>  
> +               https://www.nxp.com/docs/en/data-sheet/P3T1750DP.pdf
> +
>    * AMS OSRAM AS6200
>  
>      Prefix: 'as6200'
> diff --git a/drivers/hwmon/lm75.c b/drivers/hwmon/lm75.c
> index 9b4875e2fd8d..979057f02748 100644
> --- a/drivers/hwmon/lm75.c
> +++ b/drivers/hwmon/lm75.c
> @@ -40,6 +40,7 @@ enum lm75_type {		/* keep sorted in alphabetical order */
>  	max31725,
>  	mcp980x,
>  	p3t1755,
> +	p3t1750,
>  	pct2075,
>  	stds75,
>  	stlm75,
> @@ -229,6 +230,13 @@ static const struct lm75_params device_params[] = {
>  		.num_sample_times = 4,
>  		.sample_times = (unsigned int []){ 28, 55, 110, 220 },
>  	},
> +	[p3t1750] = {
> +		.clr_mask = 1 << 1 | 1 << 7,	/* disable SMBAlert and one-shot */
> +		.default_resolution = 12,
> +		.default_sample_time = 55,
> +		.num_sample_times = 4,
> +		.sample_times = (unsigned int []){ 28, 55, 110, 220 },
> +	},
>  	[pct2075] = {
>  		.default_resolution = 11,
>  		.default_sample_time = MSEC_PER_SEC / 10,
> @@ -806,6 +814,7 @@ static const struct i2c_device_id lm75_i2c_ids[] = {
>  	{ "max31726", max31725, },
>  	{ "mcp980x", mcp980x, },
>  	{ "p3t1755", p3t1755, },
> +	{ "p3t1750", p3t1750, },
>  	{ "pct2075", pct2075, },
>  	{ "stds75", stds75, },
>  	{ "stlm75", stlm75, },
> @@ -920,6 +929,10 @@ static const struct of_device_id __maybe_unused lm75_of_match[] = {
>  		.compatible = "nxp,p3t1755",
>  		.data = (void *)p3t1755
>  	},
> +	{
> +		.compatible = "nxp,p3t1750",
> +		.data = (void *)p3t1750
> +	},
>  	{
>  		.compatible = "nxp,pct2075",
>  		.data = (void *)pct2075

