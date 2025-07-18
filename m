Return-Path: <linux-kernel+bounces-737356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B899B0AB49
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 23:12:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5009A3BCCF3
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 21:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CFC921CA02;
	Fri, 18 Jul 2025 21:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sSbX0DET"
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3713B21B9C0
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 21:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752873129; cv=none; b=UWFjKeZkGUBofxKf5l0rmN5BnyNqevnhMqzqGzfawSzaAVCJYOxJxpuTGx5UFenxLP2LIJsVvVLyFon0LEvKRFO2at2mPmvrYY6XL06BTSCNbqH3AEWvdJYwe5tCJN3x28Okj4+pyooWwaXc12m5vqAWXPqp8cQjJ0imwkOoRSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752873129; c=relaxed/simple;
	bh=9dgfKP/iy5R9KcD/n7TVWQtvSbAp2EUBG6qftKhW+hc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iuZpA7OxhRmWsEFBrTnYxwzXxnLuLZ+rBDoi/wo7fiFnhcen3N5vUWDsBnRTCWEQHVYgra/71ej3s1Obm3TS5JYsubeO7ztTKoqTzXuASyJdkn8D0CJ6fw/lwoCceFRFsDsNLioO1JFdOyA6tf8OoHjYZtdslAwM3M+2BwtmhFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sSbX0DET; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-73e7e4432f5so1143574a34.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 14:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752873127; x=1753477927; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YUtfg98t453I6/7H5HyoflaxgBnLbiL3E3jIi0OyuQA=;
        b=sSbX0DETZsF8Uy4JGV189ZbMqXTRQTeAuLDyRdPrUKv0IjgqRzfHgqAGX1TBO5qVrx
         z+AB46APNjTZSIFQJxqzV0EmmgRSBfqKH5xCQWx54XgV9d8RK4kf6XKLpQkDrN5s12RE
         TKCd3qpPtTDQr59rJfr8KIV9QBQ50J9pKr5nO7thEtywHUQd7XSuQzY3eFvFg39duwTL
         Lfnbf2BiACf+OZHAOaKfres/1I5fBz/0Qjd/PpjkxikItzPeh9ILTupcUG//UMKbe25j
         uIkZGNpMbsF3xmzrKPB0tKpXO1oKWOPZYcLrWdw426Wfp/1s7TERN+Ey7RPqB6qJu71M
         KkJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752873127; x=1753477927;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YUtfg98t453I6/7H5HyoflaxgBnLbiL3E3jIi0OyuQA=;
        b=PsL+N2z/nxu2G/36eKdVhLYApB6pfew51EENIceFXd70hFim2mZCmp7BLFiFwtScsX
         QYaNszoTGK1GUJUbTePnb0jzApBhl8cPHABZZYNzdYX3/BC1lD2eLlyD1H0eirRcLx9S
         ZfgvO9w+B3EIDd26UzlnGkeL0PutNM3pTQiVA+JX00VIKefD741EtBdR+l40MPVMLQic
         8d2kxOtdxTlRTKKZ4HUCTtJv6MdCrttZb8m9edrY3jrnxFyKxSmBqEYrGX7G2AszDtci
         KZehKSMdUykZ7hb58almVCfxMLbIUZqo4l2i/ly/NtQ1JDL3wK1bwrGWV0FPSeATeknQ
         R6+w==
X-Forwarded-Encrypted: i=1; AJvYcCWpXvjTEmyRh/php4ZUmhh85lre2OX1afrxrx+ua5rncHb1+CzSSCI1vjWtIBRDOKTjUcHoxjqwapd8xGc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYx3h5KlV7R/dg2q65h3HXs8BSySnxX/HnNHHKdP4Re4XAMqc3
	qWFDa4apgz1mDUF3YF/QDhUde16gsUfVT60+iZ/GCdmzaAvihOgjsXCppdplNs7UFhA=
X-Gm-Gg: ASbGncvz9v9dqFeboz76BJVlKE2+kEVXhIaRoZPj7MRH566h3V4ul8ozvpYlm0cxm7s
	Wshn+nkHV6oI7p8RtxkakcJRvUDmqU9PQh+Xq7qV0ngeL8uG+WnElppGJ4fuSVK9tXffo7T1yYA
	otLIuO9X3tkdU42DMLRaDTyoJrZHJEE1/109EWF8lgYKxcL98YGl4m3wu0/U2e33HHeW3PBEmYJ
	LSUjQvJcWb4FRXThWHiy803nTz/20utvuwQ6jSVPlUDyvM8kKSdf+RKA/x68K5+Ar26C3y8O9vb
	+Srt3glRtZW/Pi8XpIzPwK74/jor5BCdIf7lGM9jVwVRXhfxi34R3g7H+xJo6ph3lcLaUSU8n50
	AR9ICBuPmaffomrgPjBQ9szhD8YloRsKTSd4chtwr
X-Google-Smtp-Source: AGHT+IGRM4r0A4qeTWIEM0Q1ZLaT7ecpPl20SkJjChvcxhfMeFp5A0MKAP/uo2amAlDndWCGrrlp0Q==
X-Received: by 2002:a05:6830:64cb:b0:73b:1efa:5f6b with SMTP id 46e09a7af769-73e661b524amr9973424a34.14.1752873127035;
        Fri, 18 Jul 2025 14:12:07 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:e5d3:a824:1a57:fcaf])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-73e83b0e55esm933388a34.42.2025.07.18.14.12.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jul 2025 14:12:06 -0700 (PDT)
Date: Sat, 19 Jul 2025 00:12:04 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Ignacio =?iso-8859-1?Q?Pe=F1a?= <ignacio.pena87@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] staging: sm750fb: make fixId array static const char
 * const
Message-ID: <a3813841-7639-4686-98e3-9c43af2dd287@suswa.mountain>
References: <aHqzFn6CfgWLNa0A@MacBook-Pro-de-Ignacio.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aHqzFn6CfgWLNa0A@MacBook-Pro-de-Ignacio.local>

On Fri, Jul 18, 2025 at 04:48:22PM -0400, Ignacio Peña wrote:
> Fix checkpatch warning for the fixId array only:
> "WARNING: static const char * array should probably be
>  static const char * const"
> 
> The g_fbmode array cannot be made const as it is modified at runtime
> in lynxfb_setup() and lynx_alloc().
> 
> Signed-off-by: Ignacio Peña <ignacio.pena87@gmail.com>
> ---
> v3: Apologies for the confusion. v2 accidentally included changes to 
>     g_fbmode which breaks the build. This version ONLY changes fixId
>     which is never modified.

Heh.  No.  The patch marked v2 was fine.  Either v2 or this v3 is fine.

Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>

regards,
dan carpenter


