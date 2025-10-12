Return-Path: <linux-kernel+bounces-849640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 04D91BD0908
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 19:58:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5634B4E8013
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 17:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B592C2EE5FD;
	Sun, 12 Oct 2025 17:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m3uv7OS8"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2EF02ECD0E
	for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 17:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760291911; cv=none; b=Y5C3AdsQJR273U/tsRc2RcuI39yH3C7ZW3Qvi6YuiBxbMizP6RTK4GrAos5zc+Df2ohTMf2NVOokoGcIfJ1BFKsL3tcawGgDoV07UB/sPNZNbWK6d1yC0OD/QHJ9zdqkUyARSalxA8o/Yh5Kkv0AUIeBjBonWS76N1qS5vh1k+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760291911; c=relaxed/simple;
	bh=4s+gF/J790Cn9pggWv1hmT2wDXmwcmgRyJfiSqUlECI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jYCaWBEJETG8VqhWA7l883ZcHi7FvD24iHGehUly6omKG0LrOijMhfxCk+xVavAtoFkH2nkixssg6yVFv4e8d8Rucd+J7Qi0WE1WgZk515qw4iZPrVhmmd07g6cGZWYJMl6AX+xjjTq4lnWXklCblxH/Le1MB5+oRP+6JZa8vQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m3uv7OS8; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-78125ed4052so4161365b3a.0
        for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 10:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760291909; x=1760896709; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=64F5r2tOG3BpkRMdKwJdv92rwanay9eWarkctmegkS8=;
        b=m3uv7OS8tyvmcio1IQhE6HcbyqDd82AHvFcQ2y87b59LVvf556zgrnJ0QquQjw/f2B
         E+04CMUPLw8bf5OXMyDb4C70ChEhRwQiM9lwAaUs80b+kSJgUUqhaDli1MUh0w2R7n8H
         J7QNKlqiHzpiawBvSJ7qs0tojcmE1D1Y3nXEafdNnfuFe+yTygXgQeMujn2wLFICEjaM
         s+RUiOZbx9QMCc9zVhsr929WlbV8b0T7d795D66F47XCOxAQ9A+m2jfc18SCHvnXtWo7
         rAc5y0ESHSRS2NhfTSdjBKz3sR4I8ftj8FsX1E8NDiMNqBGpQnV/ZiGMVtg5XMreo+YS
         DcGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760291909; x=1760896709;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=64F5r2tOG3BpkRMdKwJdv92rwanay9eWarkctmegkS8=;
        b=o8zsgsJ7cVEjkxd9c9Emyku8tiYyq1f3QhBuSCcxkXFPDEGXmI2cldsMNHoZlLFgPM
         m3XSAR5PpJSoea18DPLYo4YVFC6Y6xgKsaVSSPEVywuXdYwBBBMwemiEqSFhy5lqMIwe
         5KuRUZmfHjigC3TQGS7s0eDm6OY/wSp9GRN17K5ciHTZNLODJi0DGBWlAWooykUag01O
         dhSHrcrJn7LdSi3+xv+ImPjNAHiwFNq15x2ZjMag0u+yrC+f3RHN4IZSMekUfhsaiF0p
         QCtNz3fXm2kxB4gaMoQtOWnrytL6UftahPl71pQIuthBCS6+18qd5mPa6t+kBJ8GXUrr
         EgUQ==
X-Forwarded-Encrypted: i=1; AJvYcCVL0N7sO1N2wP2o7xtDmxxSckLfVJAvDH6CDHbsT6oUnxQ02WhvMVtu0QqH2yrfakt1bmJyAUAF35QF6sA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCyStCpUNUwl1eW9j+hA7IEyRLFHgvFYxF6xRKYvG/vvIiwEEg
	8ebQ65HW3qoTqyGME/jVD3xg0UykZmjh7qX+UhK8VqVllM7ZGuYLtd3yAzxdMw==
X-Gm-Gg: ASbGncu92ZhSnqEUs3FVABJIVx24VtXZVdyn3AR1oIY0oCVnSSI3KXPp6e12cTjKadM
	cQifWqWsDbQOVTrUH5zKKSHj1OKoX5QdRIg70IBCThxktc9ay6a1F+P1mxDsGuX/lccMxHKDIj+
	dkM3oudLsK/h8HmbNpxDwvWIIO6IZ32w+Rot2vpIPrEExufm/GVK4O3rFsA7rcUACtn8HbTzzi/
	F17mtSthCGnPti9Qd6VGLRulL/TIOAZYmdXqWQzPlzQ4+8kKdwy8XedMWJLKI0RZxtEEMtDpV5N
	hVWgg7MJxS0VfAVDpy7L8N9J4h1uOEAGkAW86GWOWQj+Uc+VRpO6JMLpC3WAVceja1mtTDG0WSu
	3unVacYNvm4d9/OWrWpzMTv7zD1dfBJq9Z000w75K88XErIjF3G4mvVnDJ/BGszvYslk2ZsoFbA
	Y=
X-Google-Smtp-Source: AGHT+IG8nnQxDxsBVYzafksaEJPul0aKzanbkeJ7dpfTmGPVKK73tgD+8/uxJvZAtfTfdi4C6RIOcA==
X-Received: by 2002:a05:6a00:1954:b0:772:2e09:bfcc with SMTP id d2e1a72fcca58-79387c191e4mr21395603b3a.30.1760291909038;
        Sun, 12 Oct 2025 10:58:29 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992d0e2c6csm8959672b3a.57.2025.10.12.10.58.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Oct 2025 10:58:28 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Sun, 12 Oct 2025 10:58:27 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc: Cryolitia PukNgae <cryolitia@uniontech.com>,
	linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
	dan.carpenter@linaro.org, kernel-janitors@vger.kernel.org,
	error27@gmail.com
Subject: Re: [PATCH] hwmon: gpd-fan: Fix error handling in gpd_fan_probe()
Message-ID: <f66fc8e9-1564-4c65-ad27-a7525a081aa3@roeck-us.net>
References: <20251010204447.94343-1-harshit.m.mogalapalli@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251010204447.94343-1-harshit.m.mogalapalli@oracle.com>

On Fri, Oct 10, 2025 at 01:44:46PM -0700, Harshit Mogalapalli wrote:
> When devm_request_region(0 fails to get a region regrion would be NULL
> and devm_hwmon_device_register_with_info() fails, best to propagate
> the hwmon dev to PTR_ERR() as opposed to region.
> 
> Fixes: 0ab88e239439 ("hwmon: add GPD devices sensor driver")
> Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
> Reviewed-by: Cryolitia PukNgae <cryolitia@uniontech.com>
> ---

Appied after updating the subject.

Thanks,
Guenter

