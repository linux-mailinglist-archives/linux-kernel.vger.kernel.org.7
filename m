Return-Path: <linux-kernel+bounces-858045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BFDCABE8AB9
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 14:53:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ADE5E4F0E19
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 12:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9801330323;
	Fri, 17 Oct 2025 12:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YtzqUJ84"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1CAE32B9A1
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 12:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760705587; cv=none; b=Ly3rV/Jm8vN6q7KUVvygBNCTLHRUL8o/YwPraC90sVVrLcn+vA5maFMC0ZYOT6efQ33BuIMIYxo4NYcvq+L8tXsvYh/2VffSA0CWBnkIBBQoKEwydP1DUj6S0QBu0mTzlgYfFbujrttOt0JUSm56fmX9Bju5ZzE7TyR4Pta1IeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760705587; c=relaxed/simple;
	bh=q0dKvcJXcIqsz8kbuZxRuCwTz45q3VYiBczF46lCmoc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rxg3k5iDkAhrDe5G2gd4b8TrWu08HB2Bl9up+v4PavUkzG3e5P8Nu0nPJ87RTBdTjbN4Ma/e+39z7/rgP5xJQVUv2K+H7fDQVxJjtAKj4GBzv/4NrrI/mOoVWOKSCmKgud2t7EyNgs532hL57iYPvxMtdRERxFYzZhtMEjKb9Z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YtzqUJ84; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b6329b6e3b0so2205814a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 05:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760705585; x=1761310385; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4KPuy8xanc30aUC0NeAjXkSoXgg+j9Yhzu5edLPhaAs=;
        b=YtzqUJ84tsEAWC7vW200fU3xiSBeMscuRWsJivrTjT1Wbdp8veOATJptoFoxMakSTe
         2CEOPdYJRN0gFJby7f+6oMQW30Mm7f+O5ZsempqwDtXMekhOF9aIAyjf9TFgff6PpFd0
         RQRN9IguYcbbfXC95Usy2J5qX9SIBhCWoEODNcO4iyLyXH0jaPI5UHDtx1x91jbgqsan
         2JsRx76q1EeRKAYpfuUggyJgx8mxan+5Gmnrn4RT5xIHimwSEOAhNyvNMsRNl0vQvFFt
         XqewDnbnEvoMHeWttQF+FhWwmbDwfqik+V5p5unEP/naY2hjqb7BL3OXbvQZ1OdsAiVg
         eQCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760705585; x=1761310385;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4KPuy8xanc30aUC0NeAjXkSoXgg+j9Yhzu5edLPhaAs=;
        b=w//Z0u3YHgUek0RA0Fle1rxnloaZ9wW+J8bK7TMANeSHH0cZn7f97wdluEXilWzGA5
         ErOdkzVvpk6Uav7hWZ/qpfliJTsLRVut2KR7MyU6EvGQpW33IeWFulpoPoc3u059l3Sj
         fbZqzwOvGZ3VU3mYcQrOoaTutL/vU7TqK3bHxtM+c+peV/ItZabF7fWON6xw9J8DuFeD
         G+tXTdSPqHv5tMTGf4S8b/iFUOlywhLlt8k5jxMLBHbF3AOLQVM74zttMlCVHK6q8T8C
         HWbOQfHHsElOZ96z3pI4lBBUdFZad54/Ik+bUUhhzviw5myvLm182+AMgiK8InVow7ei
         g+Iw==
X-Forwarded-Encrypted: i=1; AJvYcCVqlkbxwznP0FbEAEBHIIfRlqxDXLQjC8gry0Em4+xoErhd/piaPAocJ/ppjRodkhGrGn/SMkbJNicM8QA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAT2SMI01t3/UauptFpt60sZoHzPF5VurR0IJUbRPt9mhj5Dyh
	Xed6ys8NPesOjzN8cFP8E4WBXwpUJx0fu92zJ48QYBGb8vDQlrhHmrRC
X-Gm-Gg: ASbGncu0rx3oCF7r58O8zd5CXHp25wV+PpIyUOVALn0RTxUrW6ZSezutBAc0N/o0C82
	ZEWwm7IS1b6UBD5gVValgCT/6gicYDthpQ2fTpPhElmY8N9fM0nXfo4HbQoaRqyVb0pdAairiV+
	uGbkqxh9lc6OvSkL2pHycR1xkdoKHQ1LllxccW2csKFc/5sVvZkmZLo+Z57oUNcu9hJ/X5m3NVk
	NiPWalW4ChT6HReQ4GZsydA/TuopXLoS7smmg6gCOf8hdYwa5I0J+AuBtAjNSUeMfe5NCYxXLYW
	2fwZxDWjVfNYrNvgwIWR3tsBnQOAi0b7MpS/0Fsm3hUbU8Pazvw5leB6gU30+Ohf5UCdCVlVT1P
	zA2i695hHE9bO8/XO4R5b9hlPfgwstEdRqdxws7Jqf5lYHR5RD/0oJ7jZMCZ9lJMLMGa5F5e9kP
	vE+Xzg7W4Q49GyVG3T08boF0M=
X-Google-Smtp-Source: AGHT+IG5O3uFCStwtBtYTlo/Za7+Ei3oHkieQstV+E+Ni78R3C1MS3A0qnauKtcp81RiP5MMdGWSXg==
X-Received: by 2002:a17:902:d58d:b0:265:b60f:d18 with SMTP id d9443c01a7336-290c66d9f6amr39830685ad.1.1760705585006;
        Fri, 17 Oct 2025 05:53:05 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2909930a999sm63835595ad.9.2025.10.17.05.53.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 05:53:04 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Fri, 17 Oct 2025 05:53:03 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Ankan Biswas <spyjetfayed@gmail.com>
Cc: corbet@lwn.net, skhan@linuxfoundation.org, khalid@kernel.org,
	david.hunter.linux@gmail.com, linux-hwmon@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH 3/3] docs/hwmon: Update maxim-ic.com links to analog.com
Message-ID: <07862286-4e65-41ab-bcbb-ad9b8432ef71@roeck-us.net>
References: <20251017105740.17646-1-spyjetfayed@gmail.com>
 <20251017105740.17646-4-spyjetfayed@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017105740.17646-4-spyjetfayed@gmail.com>

On Fri, Oct 17, 2025 at 04:27:18PM +0530, Ankan Biswas wrote:
> In 2021, Maxim Integrated was acquired by Analog Devices.
> maxim-ic.com & maximintegrated.com links redirect to analog.com.
> 
> Update maxim-ic.com & maximintegrated.com links to analog.com links.
> 
> Signed-off-by: Ankan Biswas <spyjetfayed@gmail.com>
> ---
>  Documentation/hwmon/max127.rst   |  4 +++-
>  Documentation/hwmon/max16601.rst |  4 +++-
>  Documentation/hwmon/max1668.rst  |  4 +++-
>  Documentation/hwmon/max197.rst   |  8 +++++--
>  Documentation/hwmon/max20730.rst | 16 +++++++++----
>  Documentation/hwmon/max31722.rst |  8 +++++--
>  Documentation/hwmon/max31730.rst |  4 +++-
>  Documentation/hwmon/max31785.rst |  4 +++-
>  Documentation/hwmon/max34440.rst | 24 ++++++++++++++-----
>  Documentation/hwmon/max6620.rst  |  4 +++-
>  Documentation/hwmon/max6639.rst  |  4 +++-
>  Documentation/hwmon/max6697.rst  | 40 ++++++++++++++++++++++++--------
>  12 files changed, 93 insertions(+), 31 deletions(-)
> 
> diff --git a/Documentation/hwmon/max127.rst b/Documentation/hwmon/max127.rst
> index dc192dd9c37c..5ff2f64f9daa 100644
> --- a/Documentation/hwmon/max127.rst
> +++ b/Documentation/hwmon/max127.rst
> @@ -13,7 +13,9 @@ Supported chips:
>  
>      Prefix: 'max127'
>  
> -    Datasheet: https://datasheets.maximintegrated.com/en/ds/MAX127-MAX128.pdf
> +    Datasheet: Publicly available at the Maxim website
> +
> +	       https://www.analog.com/media/en/technical-documentation/data-sheets/max127-max128.pdf

Text or link, but not both.

Guenter

