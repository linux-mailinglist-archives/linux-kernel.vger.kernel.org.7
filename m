Return-Path: <linux-kernel+bounces-732626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C80C6B069BA
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 01:07:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 341951AA7846
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 23:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F3582D1920;
	Tue, 15 Jul 2025 23:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J378feV4"
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0FB7261D
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 23:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752620833; cv=none; b=rNPGkR/rgztJj1eDRNHy9vHlTv8hdLAEccNnW5Lj1ZI7Hvj9mZ9G6AdO1PVoN3nd+sK7LMowPZc3v4iLR1bhuhX9JlfPjBWtGrzt1uZZ2gn5qw4OyoFnzt3EGIeGpi5jbtMNx2+BrQm3r2B1OyOe0PSWqcqo0KIPLduYkM61ePU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752620833; c=relaxed/simple;
	bh=TdwRQ8hBs8RNJ0rWvmW48ICtfaJmKpknY8G8u7R1u/k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CIvm5pDHhP2zI0RkUw6NKivvifKLIkq9mzTP864Y1FzfHZRrhgjEUC3CIdCDPoHa+W2xN0BhN9a3Id20YHkQaVTI7BoOq+8AMy/82knxX9pEwAzhI8GA8CSRru0XrZBmmibROaAOxXEzvvmC+0sf/bPnY/W9/4wNfnBUFbTcoSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=J378feV4; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-2eb6c422828so261760fac.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 16:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752620831; x=1753225631; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=T8/xCeqyZt2wmgn8IDHS3lAPNn8HdJhxhAcP0TpDRFQ=;
        b=J378feV4cgAFNX5QsKthkgAGxJUjPWPa5Idk2mpVcHIZ9fW5hR7C/mbd2x5mllmcYa
         ntBJ1fjXSY54CbhL+7or5SBzOy7tBY0KpXd9kFTtRaSaWTjI/lrsAW1ZueI15HRh9mhv
         TsuQ/v+TzpPf6BT1se90xaQMeOGBxG9GJeNI9jBkvGACsfFi7jhTTjj/G2Ha+nyVmNms
         Emwpw7UVtF3GGu9IzAhT3YVMk5E8xiBjkmzPZpof8g0/gTy9IhlpNlobcIoC4qh915yg
         pBw7RnmZE865dQ7RAqAc0gDp+HJAg9+yFgTDFrb5mBd8gWrqEp1gLSTYF3qVD4wCM9Sm
         AMBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752620831; x=1753225631;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T8/xCeqyZt2wmgn8IDHS3lAPNn8HdJhxhAcP0TpDRFQ=;
        b=MVi2yJQJBh9LNCp2qycMHNPNKjAqhg+q+G8rk55n5bgBbGKayAyB9DPwg8747tFE2z
         0FDUYkguKP4to3I1OyZVHqx+LVtHmB5gbPNPRFwN0iGeRc/s6XwFTKG9SP9W832htGWd
         C+VrQqNPLrzm/WWg8CaCqqrzWSofX0spWFBW0sT5vFBc9mIN4k99HEtrIIrrcLmO0u6g
         ld/wV7P8jk5GecR3s3dZE2JcodA3ozCuo9a1rNjVaSd6nzWidFaQn08BxYwPzfV9lIK7
         hi9PcsY5q+8zkZxboc4taBt3qMi5cgO8BS9ADEBpai3UDysIF88/dzg/it8Jaq862SgN
         eW7g==
X-Forwarded-Encrypted: i=1; AJvYcCUdoXU/RBciIwtXMqHa5ALCfxRR74Ss4LIh5jKgtrS4jZAPrPPhHXu57b7QQJ1vDa1wfCnfwRR4BisRusM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPUIe3uqqsb8kcdpR1oIkqkRRMXkaKzleLn6/WF8qYJzMGsXsO
	lkiJBPw3ycShblqJH0ndPePgsiP4wiANvtwSJ2TA49NMfUUN5C3z61HzrQfVSZkY0iw=
X-Gm-Gg: ASbGncvJGIcM7OhOIfnf2j8unTjxzo+kY6E/x0DGV42a6+Z14LLEYiINeIro95dRWoy
	XpMYSMpGwGK+sxERFAAuAv/qXvRXqtrLOBUWXZDEhnPVBhsAfaBXjYfaMBHsCpfdR+8Dm2sYhNt
	FGpjU9xsNImlKf5NgYYVVqOi9aebYp6DkZ+y7f5/i+PI8267YVvKKhwC/lqF7gQCNuhTLHt2Csc
	sdZr3jWO+IBjmDXjPMzwAepTx1QbTgr8S7jQZfJkTcCXoTatM/3uq3WHkImGmzKm3xedyTohp7g
	keuwnfMuONfuJhMQJXG87OL/jZZPFv7jK95qYvTpW1rbI1lMrrdhPKIhJtL4Q0SAUh3PZhZScvK
	/6Q9OBCsxHrgQBvErCp7bxz+izhya
X-Google-Smtp-Source: AGHT+IH6Iw8x0Ssmy6W7B2jmVJ1SqRlf9P0FregO7tqkNLu6G0HHdGAJ2aG2ptJl+JKWDH/D9aKSFQ==
X-Received: by 2002:a05:6870:3c1b:b0:2eb:9fe5:d06c with SMTP id 586e51a60fabf-2ffb09a5173mr834588fac.3.1752620831387;
        Tue, 15 Jul 2025 16:07:11 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:a172:6205:b5e:43cb])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2ff116d3541sm3036132fac.35.2025.07.15.16.07.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 16:07:10 -0700 (PDT)
Date: Wed, 16 Jul 2025 02:07:08 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Ana Oliveira <anac.amplar@gmail.com>
Cc: gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org, ~lkcamp/patches@lists.sr.ht,
	koike@igalia.com
Subject: Re: [PATCH] staging: rtl8723bs: os_dep: remove blank line before
 close brace '}'
Message-ID: <588099c8-98a6-4d89-b638-479c7ee1ca07@suswa.mountain>
References: <20250715112513.4541-1-anac.amplar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250715112513.4541-1-anac.amplar@gmail.com>

On Tue, Jul 15, 2025 at 08:25:13AM -0300, Ana Oliveira wrote:
> Fix checkpatch error "CHECK: Blank lines aren't necessary before
> a close brace '}'" in sdio_ops_linux.c:309.
> 
> Signed-off-by: Ana Oliveira <anac.amplar@gmail.com>
> 
> ---
> 
> Hey, this is my first patch, I appreciate any feedback, thanks
> ---

Looks good.

Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>

regards,
dan carpenter


