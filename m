Return-Path: <linux-kernel+bounces-737353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3111B0AB43
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 23:07:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59F301AA6F05
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 21:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EE5A21C9E5;
	Fri, 18 Jul 2025 21:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RPPOW+KQ"
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01EA821018A
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 21:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752872826; cv=none; b=nASnMhI5UCdjE7oQnCjOVJzIe2mCnLIgV5ubBZ/OVlNCKqELFUfx2fyJxJczqYyAISEVJxTOnfM4sbPfRFz6RBq8Iq6IxulpylPRoidpAJuoCGseWdg9V2UTkDMb2KmaBa5GiscQcMdIvYbgPkgBIU7SmR9kOYJYYQNsQ/8o9Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752872826; c=relaxed/simple;
	bh=5TwKigiH08MXi3g8F9YV0r2S2yH4dRD08h/ffr23QEs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rtGkK2ztbRiDi4IlPHUyEkWy8g47mThO/hq9WgFhEHJKTOypOo0pJHsBB6XGnJe1s2jg0P9evwN6DkkzoycdsJ60MfcdOHpJOlVfVP1KUR/4qCz/rPMA0oT/EmyjpQsF3ZpH6FpKGuu0qI12kKsPceT69l7ueWwngR2ANSE/9hA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RPPOW+KQ; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-73e58d51060so650576a34.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 14:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752872824; x=1753477624; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IDq7oOQ52kdbaZwGEtTLrjH3q1ZZE7Dja6w1bzcer4A=;
        b=RPPOW+KQSsKktMhjnf8XFz/9iHhlzqwvDCe45/SKJ6bqajLWu3nugWKRK/vHiz3XWY
         IPHFRG98zPANFjYrTNwpoPJhTy92ZYpjpCQrCHZvCzq63CMkU6FUcvPRZ09c94Jt3M9M
         /VYYFBTFueh0phEM5PdlFDKSF3SW/LfHtNL1B1uBpGShQsn72JSUmMRHaFNKc30bixMD
         wWOLSknFxE6RFEKPo7tK1051q7DAvm8zAnn+OmwLeGuLfhdZ5Ed5LgF32Vqoa+205ViI
         mpeBrjtrP3NgFr9lhODY4Y376Kji93LxSMD3dRJxEkHHllL/TrAEYo6LQIkFbyui+Wag
         MWFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752872824; x=1753477624;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IDq7oOQ52kdbaZwGEtTLrjH3q1ZZE7Dja6w1bzcer4A=;
        b=v584gESXTD4BSUUW4C+fjKSLhRzMLXlf/nTZmhLplKHK7Sfwa8+EuVrUhaJwPqxMSY
         TzJIwhiAsfA8JR2EaeGdcfSpPiUPzwB0GIsJg7WNigF7Z5S3lwsuG5VI6IfOtu6lGxR2
         GY8LyX9teAjUtCOp2VxLGs4mTm2L9J4K3MQqFc+KSEGZwjZgxvnysZtJNxC8acRpTBoJ
         5ggFZlY+MjMVCY+5ugakXp4Ajw9vI6a8gWIZgHBrh2n0S+08mQsXmv+4bOhbrcd/QLYl
         qlb2qIwlM6yJsJrbj30RN2y+AV+dDRuPAHHstpXVcSzubl588fsELs1ZNDcRSK2SLshK
         RDNw==
X-Forwarded-Encrypted: i=1; AJvYcCX3EhiJzjqQrJnOHXk+D0SANjs3sreTAegokCD6hgrvjYuEtzsDGunGMhowA7LU0VuZhQJ5LIjAlvK9juI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxI8e+W4LJziqf/IG/eSWXIG/+h/Jk43g9bFPVKIzUE47vCKOxa
	OC7/xZIuehJI9C98raSd+mXUKvOOPA5fKs2TN6gijZrNB5Qh74xswldLpjg5J2AE2HY=
X-Gm-Gg: ASbGncuoe04c2pqEtl7nPpUDCKkszvqRNLk5wVHzyok+JQYLGTDy2WobprzolvA5PRV
	1C9MBGw8MOwf5PBukvGZ9o3WlFaQvlLBvxtmWI6Ss8DF8P8B3GP6GILTjT5PGzzLell801esxWS
	XMZEtqF7sJHRNZvKHZ1joZNVCa0WVn0lNN8LXXBpJvnVrTAMR1GccibhyAdiqTVjmCHwSMjfjff
	2o7Rj+Tx/q7wnSTYo9nGaq3xp6kYh+zE5UAZhryQ7ETxQOW/lf5aXM6vE+zQM+7elyQMG+7RHGZ
	IwuFhKEZc4iVFcbjmWJZl6ABI/90nDlswrrow1A1uBth/Q8CNI51ljt1Ppm7rxybIyR5NjHJAaB
	G3LKwZtdc6hSWV1ZZT9UCb1B/7yQUoA==
X-Google-Smtp-Source: AGHT+IEj/fNcFQQTUD8tJFDiwFrmLtonsc1w1R/cHms01UPIzSBjuIHwW08BPvsQyp9RY0wnRv1veQ==
X-Received: by 2002:a05:6808:2e45:b0:41e:a422:390 with SMTP id 5614622812f47-41f99941b7amr2869684b6e.38.1752872823962;
        Fri, 18 Jul 2025 14:07:03 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:e5d3:a824:1a57:fcaf])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-41fd10c22a3sm698017b6e.8.2025.07.18.14.07.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jul 2025 14:07:03 -0700 (PDT)
Date: Sat, 19 Jul 2025 00:07:02 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Ignacio =?iso-8859-1?Q?Pe=F1a?= <ignacio.pena87@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: sm750fb: make fixId array static const char
 * const
Message-ID: <01f7bfc2-284a-479b-b73e-40907dfba387@suswa.mountain>
References: <aHqvUrXtxwf_k9sI@MacBook-Pro-de-Ignacio.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aHqvUrXtxwf_k9sI@MacBook-Pro-de-Ignacio.local>

On Fri, Jul 18, 2025 at 04:32:18PM -0400, Ignacio Peña wrote:
> Fix checkpatch warning for the fixId array only:
> "WARNING: static const char * array should probably be
>  static const char * const"
> 
> The g_fbmode array cannot be made const as it is modified at runtime
> in lynxfb_setup() and lynx_alloc().
> 
> Signed-off-by: Ignacio Peña <ignacio.pena87@gmail.com>
> ---
> v2: Only change fixId array. The g_fbmode array is modified at
>     runtime (lines 786, 788, 949, 953) and cannot be const.

There you go.  That works.

Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>

regards,
dan carpenter


