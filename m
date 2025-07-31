Return-Path: <linux-kernel+bounces-752727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 184A6B17A39
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 01:47:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A1CB1C81CFA
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 23:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C16D028AB15;
	Thu, 31 Jul 2025 23:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MJiudOwO"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B05B828A71B;
	Thu, 31 Jul 2025 23:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754005615; cv=none; b=bieLevJe446ZjgD4amx2JGMv/fW0pAJD3FRpXaAYDLXpo9+EXqaOWF8VNE9UbuicPE2A8okvJ6oaLjrvw9oF7Le2dhRreFJbbbpLurM+5wh+0adnXWY7+H9F/UmMQ0rY0yA7qCnBlDkdKmFficjrnofFS5SEoXbmBqx7DDcuFqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754005615; c=relaxed/simple;
	bh=Yug7uksLsunQakB5cIZgmQU/Ii+OZwe3OXkOw4l+/kw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u7a/lbfcvE2UOmqlI7qo7xyJcvgwJsKlekemGuajiz6c0RjVDaL58poa2TjEu5dKcHlnRI//fxjPq2MK2HQnbBRYMkLaiYhM5e3ldixhFE1ZuH1/j+gdYcIKfK9pcCQ4Hbs85ZTg30w7R71MVpIBIzvYzC+owMkmeZAPkQqXmnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MJiudOwO; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2405c0c431cso15870295ad.1;
        Thu, 31 Jul 2025 16:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754005613; x=1754610413; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XAK6Csb62EgwNNMrznCzrPFQaMOJ2VvUjGuwNeV6/Sc=;
        b=MJiudOwOiReowmxLAQi2ySWdskdj4bBLdYd8SDZQmhJ/ml0ZpgTb1JoDJXbsRVloOs
         WSydcJ6ELE1meed7k565hviCctHlNk5zN0pwyq5jD9aj2P8WNS6rMuj2oPV601rkPj25
         btO3SctmMlfVKKuAeQAUsFNCXCFTJ5ymj5R8nsjVqTUigySBJ5JSaUhwSgl6beFbLY3F
         n4KnH8yrHf5UQzFzcqUZSQ/9KwKgj6DyXgwQc6TJn/hnvgo1x2odhUMPRWX32dT+5XcS
         ksq8LyJS+op0ZQgrLWdbvKt/liYOfjHg7D6dVD59AqE5zho39LS9QbNChh2O0j6N/+hf
         2I2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754005613; x=1754610413;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XAK6Csb62EgwNNMrznCzrPFQaMOJ2VvUjGuwNeV6/Sc=;
        b=A7NNrg0aEWXkJBk/JeT2UBiqI/6F927F1md8oeFpPyV5Z7PhMyWCLpt9w8hGgEZaS5
         ZJxrJ8v7gW4ivqgR1chutu1txTztpkQoTJtwbTt1ntB600qGL4CbIlLAZqajTg07Eh0K
         3wcDM5TXsP9M16K4PzZgQc1peUhw+2NpxjikgcE9skw73MMUB3PIurJq5u+LKZZ6RoWP
         6NCiP9L1e35dZbXzyXq09+kymAYb4ujeMcgo/sniubX4RFUqE+qOnuSE8qM7fFlAbLl/
         fyOzR5oB18q5QM5EWQawe6Axj1pQtj5UKqXyb6CZkUM+t060f/KTpsaD+TGMb90BZp2E
         QCnw==
X-Forwarded-Encrypted: i=1; AJvYcCULDMxME4gYHUvfghozGtZLxkT32n+YJbD/4zud+5znZGkzlwrhvPX8hAvkVeSWtqf2wre8xuGysmw9/BE=@vger.kernel.org, AJvYcCW3YHalOyWiLs1eH4VWkQtqbGkuA38DS9dJjYt1OPqAZyCmeZg1nawpVjFg2oE96WDXeojaZM5MW8dQq0d7@vger.kernel.org, AJvYcCXz8WiUZ7+3LfuOHnUk7GI1EwG1c6m3Z5mLhEV6d4mB8Cop+aZ5wplKTDFgals2YCaj+Speg8tTkqM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfO7a877SSRMyy8ADm0F2QY3YCT/cu/ib3cYx7cZcpvZNcl2Aa
	5UTwoWMaqGfhbfA9LL1sq+Z89BTAyL5GbE2U2L8cL/i2I7CXatFFmA9Y65ZcyA==
X-Gm-Gg: ASbGncvrooelaenmFtcGlGK9Qo6Tj7m9wh3mHDLFQBzoZerporOnl9O7sv6qsZ8QcAZ
	DCXmuX4XeOP9S/CLaQDDTTtN92Y7TUSRiFC0GZAqQxBKRfjAojp3cST/+PV9K0f6VI7k4D5wfDU
	tomywTVdrikVampVLfBD2LGFOmjKlvuEiSPbcyQNBCJ50i1mxWWP4tFPcgAhEFxBQDiFehjsqq8
	8HJvdxX2Kz4ywL6jVu/Yth3YrLWJpR3bI9Bt3FDBKFsk3W9Xp5vXUmya6e4mJQ8uTEJ7ZCXgd9w
	/LrXf23XF+SWhwdxsCwzxEPlbEBRbK9doGmbHs2KekOMKxr/Qfgfs9cnzP3tRfizA+1/QdQF0PM
	ID/7KGf8ygeX5Y8qUG24t63jU6rUoFiWyTraAZNf3eUpRVc7fzFw6Mxt1
X-Google-Smtp-Source: AGHT+IFP6wJ5294hUeBOxB3kreUTcf6T+yFRz5w6iCmh/9MVhvT7Kt1KP7UKWQOfZp2QkUV97kd5Ow==
X-Received: by 2002:a17:903:2446:b0:23f:f065:f2be with SMTP id d9443c01a7336-24096b03dd7mr119403925ad.26.1754005612928;
        Thu, 31 Jul 2025 16:46:52 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e8aab185sm27998965ad.164.2025.07.31.16.46.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 16:46:52 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 31 Jul 2025 16:46:51 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Eugene Shalygin <eugene.shalygin@gmail.com>
Cc: Nicholas Flintham <nick@flinny.org>, Jean Delvare <jdelvare@suse.com>,
	Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] hwmon: (asus-ec-sensors) add ROG STRIX Z790E GAMING
 WIFI II
Message-ID: <9887dcae-2f93-44bb-801e-f2746e9454ad@roeck-us.net>
References: <20250728205133.15487-1-eugene.shalygin@gmail.com>
 <20250728205133.15487-4-eugene.shalygin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250728205133.15487-4-eugene.shalygin@gmail.com>

On Mon, Jul 28, 2025 at 10:49:10PM +0200, Eugene Shalygin wrote:
> From: Nicholas Flintham <nick@flinny.org>
> 
> Adds support for the ROG STRIX Z790E GAMING WIFI II board
> 
> Signed-off-by: Nicholas Flintham <nick@flinny.org>
> Signed-off-by: Eugene Shalygin <eugene.shalygin@gmail.com>

Applied.

Thanks,
Guenter

