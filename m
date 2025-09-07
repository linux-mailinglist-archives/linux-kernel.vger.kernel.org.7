Return-Path: <linux-kernel+bounces-804684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B14BB47B8C
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 15:18:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51862200C17
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 13:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C13A275854;
	Sun,  7 Sep 2025 13:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q8MmHjLz"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28EF272E7E;
	Sun,  7 Sep 2025 13:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757251098; cv=none; b=SZcMFlpOz3ZPGvKA4YoBwz4PczsIdhwkkEBa7YeLODHAKtWXYrFD0vHPR10CoZwXqb+b99gLnQka4WOE7zb/Q7rzbT6LyGLEk5L7idww1sJtqDLJSqCldrp7CN6CVgWHjEFFxKusjHdj0sXNOAauG+Xig+z0b1iO1m3IQdu7rGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757251098; c=relaxed/simple;
	bh=lb0Gamf3L9Htxml+MpLO6L958jGJdocBgqKrw8UmFIo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S2GNLPxXFKNHzdKMTaunVBwGu4V5fchwekjISaJorBNlswOEIhgbsrGsoPZpy3oUllI4TCbuMBZONzPsgEK3OvrS1jO8s2m98ZRppq5xfsqc8HK+lv+phP0r3v3ps8ZIm17qgNk5plUXUVhNny6++K8BFceVxKFssQLqb9c1epc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q8MmHjLz; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-77238cb3cbbso3770646b3a.0;
        Sun, 07 Sep 2025 06:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757251096; x=1757855896; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RenAXJccVRZykldVMIQVWlzKvm/7Gyr+4s8HFewX4V4=;
        b=Q8MmHjLz3dU2VDjaWxVLNU4F0CKoMtwqF6NBiXMtt4SzfA/+VtiZbwGjR+RBLp64VA
         unJ8hJCUxr8XKBYL33CqyrpL72NqQodcB5x4w1bj1hDTDQZvCec7spnszPS9KB/cOhiF
         yNyOqcz0o+iLg2i4oXrYx9pAg+gVwODLnhX54dMUvykD9Jenl+Tf+Tatqh+mUFP5yaBY
         hEoF8XlNEG8yMsDIiluCiG+Z7iO55UFR7oPpst9iCpCeo/ucclVlP2jfIgTF3+QqBkrc
         yKHUySqaSRAB8jvr5OTESkQlfGDknHm21J3GzWEWJvJq0u2fu5c/6h1IrrQ/KSxqHJpV
         gFsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757251096; x=1757855896;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RenAXJccVRZykldVMIQVWlzKvm/7Gyr+4s8HFewX4V4=;
        b=nY9jVKsNNjmLqciaSfVFVeP+twJqK5p38GF1gqFWMbAC1gHjSvaRmi27e2axGQbfsE
         6ocQpNr4YdPMmSxJUEMNvCILIlUXBrCkWXv702CtHqjgTPCJJXK0IbnJtgjn042Abad5
         xDDgNEIQqkhVwwWdJJfsmvKWNMOtUeP8iRhu1vDs8qwCIufYAFIYXr+67P9nkkgxKKQF
         s4n4ZkcfAoyL4fgUPrO8EVmR5osbVC9c4AiXqQhW75q/zt4z274YVSZot1uJ/Pgi3xoK
         T61pRh2EcJ0DJzKno9z7hIFhmmvn8OHrTfs5QHHDAmJL/CR7o5L1jtdMpqvLuPYpoCSX
         iAhw==
X-Forwarded-Encrypted: i=1; AJvYcCU+plfVCEkT5qm0D4zWh9zGK164I5vW+Cq7zleqTorpdTlob+W4vcUFwmZNl9lcrly/YjjGm7D8Bul+7sGUMtg=@vger.kernel.org, AJvYcCUQ32MQVAyfrEgK0u8xkm48Qj8FuCbnTIm1g+thpcoh6ivb4yki4zAtue8ivrY5ZanQo2ulKDgNxqIymIE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMiyMdEY8qyux0mo6oN1/boarHE1QNNLsBpjfIrThaei1T2Le6
	LmqZIA++yy2+xdM2n1DvRGF9di5Wham7JcWcUFBiISGZVoa5GMe5TURB
X-Gm-Gg: ASbGncvfaQ3mq+S9J83HsFU9G2+e95n9DZbAeX/0bBOr7xa5gkTgIIbahfrzv6dalvT
	2Fgbd5ujRaW5Q8OmNfZOD4Oak86/F4SFK7FXuHrMWHqO6wSMkXOdx9XPZWrLIgcsNaN0XOP7062
	ZQmTRQnXa7L9xru3PeRnYv4B6aNjaKDZ4Wt38VXHKiy4QZEa1jkLTtD9xWWBlFGoCYVDJuLQMSF
	GFnT/fubuXc67FHoQFtBsJP0qAxUCteM/NGoxgDwBhCkNx2AlaohMU0P+xft/V1x4Dq1yz/Bh8x
	mBpyRI6BhknhWjaQdjJmfw/RCgHSj3Lj9f32hsobDfFIwk+3RxByFlULEOeF6fLYgd8kzYQXbVS
	4nKcnuJeSyghilGH+V66yapDLZEWTlQE9AG8=
X-Google-Smtp-Source: AGHT+IGCt9IyOrURHk4JApTs7razMOagmxVWgsLPWYBcPYs/hqlhfeymlRccA6IlJCQkwV8MXj0xwg==
X-Received: by 2002:a05:6a00:21cd:b0:76e:8cf4:7bc4 with SMTP id d2e1a72fcca58-7742df22ee8mr5064345b3a.26.1757251096055;
        Sun, 07 Sep 2025 06:18:16 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a501a94sm27027949b3a.93.2025.09.07.06.18.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Sep 2025 06:18:15 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Sun, 7 Sep 2025 06:18:14 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
	linux-hwmon@vger.kernel.org
Subject: Re: [PATCH] hwmon: (nzxt-smart2) Use devm_mutex_init()
Message-ID: <ec09e583-7a07-4ff1-8682-3ef783dd7dee@roeck-us.net>
References: <f51fac0871ec7dbe4e28447ee4f774d028a53426.1757240403.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f51fac0871ec7dbe4e28447ee4f774d028a53426.1757240403.git.christophe.jaillet@wanadoo.fr>

On Sun, Sep 07, 2025 at 12:20:20PM +0200, Christophe JAILLET wrote:
> Use devm_mutex_init() instead of hand-writing it.
> 
> This saves some LoC, improves readability and saves some space in the
> generated .o file.
> 
> Before:
> ======
>    text	   data	    bss	    dec	    hex	filename
>   25878	  11329	    128	  37335	   91d7	drivers/hwmon/nzxt-smart2.o
> 
> After:
> =====
>    text	   data	    bss	    dec	    hex	filename
>   25551	  11257	    128	  36936	   9048	drivers/hwmon/nzxt-smart2.o
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Applied.

Guenter

