Return-Path: <linux-kernel+bounces-734068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA31EB07CB7
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 20:22:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F2EB1AA6E40
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 18:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 463B729B8E0;
	Wed, 16 Jul 2025 18:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HocqEg8a"
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 290CF293454
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 18:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752690109; cv=none; b=FZOaDNk/3VyLcLHArbKif4pdIl/KC1uVP/0xICyxRqBW5NNJ5yvv78UqDYNBUi7GG/SBlnPmmO/WLp5SzUbg4ub2h9SeHMU1Ob1S8KL1by6bqE+/2T+vlLfbF1TYbVdEoIqU64XV0QkF2ABe4NwmStocOCuSDzVW1HSHAyUK614=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752690109; c=relaxed/simple;
	bh=bSE6/htDCjhVwR/NENeM4sfjDZISV5OmZWcaU5WSJWI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lOVyDrjarVvg2jPvWQcSJcgPJvXJSzRrdyCUvusuf82MF8+wgqAq+FaT9J8C5vrmV6XxOcRNo8UnB9Hfxi5FHFF6Ff/oLKFt1shCBYwm8ytVhu3oqadhZsPD2vq8sHb1JJYPq6zyn7yyFZOiVsxU9evl43P3Y/37drDFvyWqJR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HocqEg8a; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-73b5350980cso908905a34.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 11:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752690107; x=1753294907; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+I5gJUMV6DaD5nZCZUo7tbib3WO9WKglwCazUnA13Q8=;
        b=HocqEg8asHDMeIAhNNuQnZr3gxbyGvrP7Pud7kQoH0JB8XENTqcNaWtnEZzgakY7Q8
         0xlcN8isvjCzyrLfj5in9y8Y7VZsU0hElTI6IDv5rtXxAQl6mi0wKE6/7u7v+3zpYWiG
         Vl9Zja7foRutSVweUDCz90yP/2Z7vxLEopburnAmMYhQNDKJDlFngxiE4KXg2kP8lHF+
         tc971gducyun7kLCNgWiXXNEUtNMD5orevWCVsh9e5KdhaoXSYLD+KiSAjXstE8YtISa
         Kxr4jRfF+JLLB0FtpAbrTZ6VqfOKBXW0MtmjCNj5uiGC5CSFwSty8FXyRfBteoqVNIkt
         YV7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752690107; x=1753294907;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+I5gJUMV6DaD5nZCZUo7tbib3WO9WKglwCazUnA13Q8=;
        b=ahWYzzBHMehfGWZmIO1RZm8AzFtKmWglnAPSKGOw/LHNIwQ9vm/ROANRIRXEGeouzs
         fj4lUI895zHxEKhhG/AxSFEq0hLUXmP19oAnXbncpC4orokpDutQxvjZTIV5ZHkoOh9T
         oq82Nx7/4YII8dyb38sgRS2mb02kfx0s0OdKGvazd9p46qO736hDyan3d6KaXg7U9XLV
         EyI2OJxheDeC7RbjNbGI83VfI/5CadJABTOXmhHDoZ+7Vqqte8CL11PzNwAKz71b/MDn
         Q0Rsv4mkIUtJx3pLCAngEZ8P7m3yJQy2C0Kkm7w7XDiAM/k7DqwCatbbvrI/JxNz4vjQ
         zs9g==
X-Forwarded-Encrypted: i=1; AJvYcCXNmN/JFIuxztHjxologF7PR67tu6KnvrMqoIuHhozWiJLigr/l8v4jh5Q+JojtorXwsCP3+yLIC0Nucdg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfvaRt+vupknlhAKby2oQlzqUF9erVFQhy3jCJIbz4mEgXUnHP
	gHF1K/jHIFI33fVphI/Q6XvXmDubdS9ami/n3f42d0i+0TvdL1SEpLF4axas+2rkXqE=
X-Gm-Gg: ASbGncuWkyPlvNDJFsjJ+cjoHw/GxBUPjJh8jjAT8yIiHf37KMLz5BIjbzvdUbe9BDj
	OUOScLbwjb/B15syTHxkVRLeG8/6F5z3RNzqHlPX/g5/WDMLTOKnCHpHHGcMx/iVawX6QswUyzb
	S1mgOuhdPyDa3PkRtRA5G5x/KmFRQ1pBdf9EWGNzA+5KG3rggqoZd837UefaviTuKfAqnhQl8PT
	ksrNqYhAybXfBHei46nxJuCSb7VxmjQisoS/Xqsb+h/chEQFv/ctGWh2aVXjJpOYrUKmTNFscH/
	afwFvq5+h9x/ktAv/zjOHzw2k5yyNV4g5oumVbbgI+/5axhR4OiVoIXAbQYwZHD2Z7GINR4du4M
	V2FakEI2wdmaxLLY1UJT6Fbr7ighY
X-Google-Smtp-Source: AGHT+IEhlTR1gjdZzQg8e3cObaKUeHfTFTkWMXpRkjEp1uVPcyn+zwVpRrjFN9tYQgLGPfOIHTNFDA==
X-Received: by 2002:a05:6830:4511:b0:73a:d3f6:8b22 with SMTP id 46e09a7af769-73e73219eecmr304837a34.11.1752690107122;
        Wed, 16 Jul 2025 11:21:47 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:2564:68a3:7d6:cb7d])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-73cf1064f39sm3187859a34.6.2025.07.16.11.21.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 11:21:46 -0700 (PDT)
Date: Wed, 16 Jul 2025 21:21:44 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Abdelrahman Fekry <abdelrahmanfekry375@gmail.com>
Cc: hansg@kernel.org, mchehab@kernel.org, sakari.ailus@linux.intel.com,
	andy@kernel.org, gregkh@linuxfoundation.org,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel-mentees@lists.linux.dev,
	skhan@linuxfoundation.org
Subject: Re: [PATCH 0/3] staging: media: atomisp: More Cleanup on driver
 AtomIsp
Message-ID: <eb7fd8f3-1d6e-421f-b5d9-f9e2d2992da5@suswa.mountain>
References: <20250712191325.132666-1-abdelrahmanfekry375@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250712191325.132666-1-abdelrahmanfekry375@gmail.com>

On Sat, Jul 12, 2025 at 10:13:22PM +0300, Abdelrahman Fekry wrote:
> Continuing the cleanup work that is being done on the AtomIsp driver,
> This series:
> 
> - Process the error inside hmm_init().
> - Unifies the HMM init tracking method.
> - move hmm related function to hmm.c.
> 
> Previously, These patches were sent individualy but they build on
> each other so i resent them as one patch series
> 
> Suggested-by: Hans de Goede <hansg@kernel.org>
> Signed-off-by: Abdelrahman Fekry <abdelrahmanfekry375@gmail.com>

These seem reasonable enough to me.

Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>

But it would be better if someone could test them as well.

regards,
dan carpenter


