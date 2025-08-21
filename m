Return-Path: <linux-kernel+bounces-779963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CDDA2B2FB9A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 16:01:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64578622C18
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 13:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 382622DF708;
	Thu, 21 Aug 2025 13:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Vq+mtYly"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD13E2EC55B
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 13:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755784458; cv=none; b=IZRjX4rADak52xNU4yh+KPpEoQC06SIkevugfPy3RK994UNu3WrVcAGCNigES1nINhaT62MZMv6AVqOMqsF20RUHVp0WfZJD2vJa+677JJ8sWMUL1tXS+ihVAXChjleB7UvKWEKnk+VMqQZ1UXFIQ0X0Ghp7uMbIsEtQyl50DHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755784458; c=relaxed/simple;
	bh=zC7C7olZcUe9Z8cx+F7Mg0Zp4tUGSbUZ1HeIK5G/2j4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qml8nSEuzVg51J8jmnuRAwUAEi19SXZsEZPrs/GttooGLg8e537fHAaFVOU/5JvN2UBBqa99XSucT6itZxMTirtJy3IM9FuyzpKlgJicghM4uREf77yY8BygVf3uzNPOjH/+avFNfAVwKASgBNHkus1PZ5AKhcwnRqQ8blxMUMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Vq+mtYly; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-45a1b0bd237so8062895e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 06:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755784455; x=1756389255; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+3RckpGmvYMoNZtx01O704Cre8/z3CXAKxswJRZI57k=;
        b=Vq+mtYlydc4DJS3Wh8vI6AkjUANpazuFOYPc8s/WtPjyTdYtH5sT6E44B1T44P4o4e
         7n40aZo+lwKT9FQbFjXNSfXevC1u5thmFiv9skaltmPxMJhvXpN3C3CofA0q2srkD4HB
         RCghNBuS9F+xSABmnj1t1Eoi0bQLuA26PJcIe3JuyeBa5NbJYS0hpT62tYyWPOc5cv1w
         EmtVXrooDDIwY9EXNhElfZzFl45IHR91NXPBSESWNxnao7nQXINv7DTxJg9c9yRsdZ4p
         xXpx3xVGZtNYvUQItc3bE+rP/RCpwqXyc+ub3SbUjKxwKfwbibVcj81wivkyh++5/L98
         sM0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755784455; x=1756389255;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+3RckpGmvYMoNZtx01O704Cre8/z3CXAKxswJRZI57k=;
        b=Xc5DhBMgtwHMQZ9ZvzP6GlJ76UF/HGbdQL2todvKLcabne8/7ueKeEr6UXKeVRHegK
         5FamEHDJQSiTT5f8SvmQLtNUMdREKfjjltqSGJH5Y//VSGlVYx+WgVala/BH5E4chTE+
         3uGWOIN68oxDK2RRN1DddOO3u3dDZU6uT8tcGKJT5N5RoUlk6Bbb9je70P3bSt6wsEQR
         Fmb7c4L2KCsO230NqBp6fWGEwsvPxi0m49VA0uKop05/+VvVYhCf9ZshRCvFE92g6Kj9
         8L0+RVUCNkTV40zuOQI521LkOFfcFM+5Ck3bS/VNAeDkuDePM/25O/zyG4C1DIwZbtbG
         Y9Gg==
X-Forwarded-Encrypted: i=1; AJvYcCXgV8ADaVSuuqyTAsi9Dtqtw9a0Dgmiw7ivtA+1UfVyau3qijSwcuEqTxfN7T0Hwt19Mbm/AeNvLyOhoVw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBpALnLvN0AsukX7QFa/NQKHOSdXx5kKtsHOKjE6RZuEUEnFnS
	OBpv9di8LwL7yZb+DeiCJbIvz8CdZEv/TiszKzPG0lqW2Ya/XylRcXClrsid1wZPWag=
X-Gm-Gg: ASbGnctsDUswcBkrgrw2cWCJ30fpclVK7HQJ6/HGAPHPaoyDDyt8mvevblDQ6NiGw+V
	JCPf5Bjfbw5vbraV5AUsq2ol0mod2SQ1wiD1JI9rg64+be+waseCq+GRMs2zmalB/R3ZJFJCN/F
	X4kbNXw9UmNpL8Fxmh67KFnq5+XY5l5SqwhCr1PIAVum2EiQ+vMLs5PDl+pV2aJ4WEMPRP1R2Ht
	BX85pQfmBiG1yDgvqyRRtfZKhucslhTecMOTJy2aZKRfcig9/PKyYTK5uIsVayHrNeipAv0mqZN
	qJ85mtPK30smzAGWtMh9a9KxdzFQNEyaAvO+4H+zq+X13KerU06OwA1MxjGv54QSzXCPtppU8p6
	XDvRQ+IfqCOjYLrHnc3Kdhy1FAxY=
X-Google-Smtp-Source: AGHT+IHiR4UgXlDVbxv/WGTxxHwGZcE5uF0kFr14Nzs0vJdVHWLv9FD7z21HRn/vBRYJKN0FFsSjWA==
X-Received: by 2002:a05:600c:458a:b0:43d:fa59:af97 with SMTP id 5b1f17b1804b1-45b4d85d764mr20115275e9.32.1755784455144;
        Thu, 21 Aug 2025 06:54:15 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45b4dbfe2ecsm28935915e9.13.2025.08.21.06.54.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 06:54:14 -0700 (PDT)
Date: Thu, 21 Aug 2025 16:54:11 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Adrian =?utf-8?Q?Barna=C5=9B?= <abarnas@google.com>
Cc: Hans de Goede <hansg@kernel.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Andy Shevchenko <andy@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev
Subject: Re: [PATCH v3 1/3] staging: media: atomisp: Remove unnecessary
 forward declaration in gdc.c
Message-ID: <aKclAywjKpHBd7QR@stanley.mountain>
References: <20250821133521.2665734-1-abarnas@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250821133521.2665734-1-abarnas@google.com>

On Thu, Aug 21, 2025 at 01:35:19PM +0000, Adrian Barnaś wrote:
> Get rid of gdc_reg_store() forward declaration because it brings no value.
> 
> Signed-off-by: Adrian Barnaś <abarnas@google.com>
> ---

Thanks.

Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>

regards,
dan carpenter


