Return-Path: <linux-kernel+bounces-841054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F5AEBB624D
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 09:10:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1812019E835F
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 07:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1B0622D9EB;
	Fri,  3 Oct 2025 07:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UXJ3HpqY"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814601A3165
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 07:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759475436; cv=none; b=vB+a8fcsbktRgNI6ZirWVPDs+HQSZ/jYaDEY3cW9dB/D3H9XwytQpvHHnP+hzuetqnOcVIqVv7OECxHO+acO+elKnEwmqAt4ccBc7STH0RAYu0mjfTBHT5Enuc7WRA783kVN8iwwaIriM7uFHSPuIAqhA+OsyLAdbvn8n6O6H2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759475436; c=relaxed/simple;
	bh=tsd6LCwVXoBWfeuPShaVDWTPYeYbCB/+fp3ZoHm+AEs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MyhYwVIcV+LqjuW1bersN123Oe/qQRYVZC8+ag0zEzINlnS8CVX3Rr8iB/sZMqbzbRHJfDGruuP5Ox4LPdXWG4VyhJuLYFVR34GdNQERBvzAT8P9QUfquaOs7bdvuNrrixfAY9cLwm5Ao/d62rPlJM1QY3CA00+2/GD56+9xn8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UXJ3HpqY; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-46e37d10f3eso12640055e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 00:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759475433; x=1760080233; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4KPy/MaUI1T6LJVDJjF2ILhSPnvDqNZYew/YLG6etAQ=;
        b=UXJ3HpqYajwt7jM0a6x0XhX4f3dRrmJb1bGx057y2jEzBbRrLH6x7GedcdQKBbVKSu
         TlCUAYHCKUufaBYkxAj9OntbPUh+THoHc9s03bowR94p77lL+yOIqLmGWGZ6zZuGu5zT
         H3UCYDdMyKCbyHgwebMjsiCeU4t7OIQUsxIaLmo9jve5vfDLyKAFaKV8dOiJ9g1tE5WU
         qNHCyQMvViTZdMUuMRkC1LaN0d2DcgnXbCVtaAQZTAbrRL1kQw/Pqi2fFP949yLHX9VV
         HDmEpyVde3oHyMHwfOR7NmDjGQ2y48CTT8aLidHZtTpIbD4qYCjpifKqr3fERssu1Hnq
         Vgmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759475433; x=1760080233;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4KPy/MaUI1T6LJVDJjF2ILhSPnvDqNZYew/YLG6etAQ=;
        b=pbx//n5L/ihB2ZTwtqFY9ASrYJT64hnL/XTH+xHb/LvP23nepFwd872UMugTgha8ic
         +O5lVnH1IL8O1nRVXqJqydRgMi8HIQtHFdhH+/XRK7KyIJPrYSYS0bdP75BKq5fc92OY
         PuPRFsE2Y70vVV/uyC/fQPDgUU+0aFm28P4ztB8MPKTK/fjPHKZNamQeudJPKGcV94T+
         Af44YrnhiCCgCt1MpVWP/mj0op+cHiJAnShCLr7P2gkAnVaVlWfc2Ky6fZoyVgwQF7Lk
         or92kaEZgIuSVDE6ysOV/Rw3aHrGPyskqCUVzLO1meAvcDsQJ6Qipkh8hjYuqk45XF7z
         G98g==
X-Forwarded-Encrypted: i=1; AJvYcCV3twZlMxLtVNKujNfdQptblhj/8YPdixDWZoyOFtYctEll+WlKeHVBh5yqiORH2qfyMe3kxd0vhvA/eSk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSnozfd9ML+6MLo2OndIUKn+MdkbBAEYWpYOmYltH5Z9ELeq00
	Jj07u/8LsQmZsmbWJ05ruVMb2obKPwh24Xg3bG665FKqGYLToB+Ts2hHTiitN77aVNg=
X-Gm-Gg: ASbGncsB4mta42puci6rKnsoYfhoOqEAYGilZZOR1Aa2/WHIAvTshK5+So6dZwIMXHe
	Z/QGdccDb1fflxWpd2XO/dnO+u0GE5Y01aAtBGWTedPAFom5RPhbWyyKO0A6Y+/66d3m2cY3kTa
	IrypbeNOluWa1y31uVPhDZvdmX/gGEghAoNVY4btZEjMLnrkIC8ti3CgXj28bwnE96fVbXg3Uj7
	YjUvFcFJH0HQYlCILdeZ/P3DbXymbj1henPM+O+vHKSIJZ+05WsN0Sjt8aPydll6iMcP9OUw8iC
	AFpnmVRaq3rJC8v+sGhTdavvfaVH5n/JPvD9MGK/dmF8AyzsrgSLr+lzP8jVoy3GtYzFPsPLmK2
	2fs6Jiu6ql+SCUiYASIgtArl4qK2uKv4Q/9rbGRHk8lQYIcg1IYo0gCsiaP8RkQgojGE=
X-Google-Smtp-Source: AGHT+IGrprpeaPN2zsG3GLeeDlcPWzpaZct4FH883LRsib2xD+eagd//CjbhareJG/Mp7u+BFhq4lA==
X-Received: by 2002:a05:600c:354e:b0:46d:996b:826a with SMTP id 5b1f17b1804b1-46e7115d49dmr13480395e9.36.1759475432701;
        Fri, 03 Oct 2025 00:10:32 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-4255d8ab8b0sm6653233f8f.18.2025.10.03.00.10.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 00:10:31 -0700 (PDT)
Date: Fri, 3 Oct 2025 10:10:27 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
Cc: gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 15/16] staging: rtl8723bs: merge nested if conditions
 for clarity and tab problems
Message-ID: <aN924wqH--MgGEak@stanley.mountain>
References: <20251002172304.1083601-1-vivek.balachandhar@gmail.com>
 <20251002172304.1083601-16-vivek.balachandhar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251002172304.1083601-16-vivek.balachandhar@gmail.com>

On Thu, Oct 02, 2025 at 05:23:03PM +0000, Vivek BalachandharTN wrote:
> Combine nested if conditions for clarity and fix tab indentation in one
> place to match kernel coding style.
> 
> No functional changes.
> 
> Signed-off-by: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
> ---
>  drivers/staging/rtl8723bs/core/rtw_mlme.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
> index aa842905a467..f17b16fe8819 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
> @@ -1254,8 +1254,8 @@ void rtw_joinbss_event_prehandle(struct adapter *adapter, u8 *pbuf)
>  						rtw_free_stainfo(adapter,  pcur_sta);
>  
>  					ptarget_wlan = rtw_find_network(&pmlmepriv->scanned_queue, pnetwork->network.mac_address);
> -					if (check_fwstate(pmlmepriv, WIFI_STATION_STATE) == true) {
> -					    if (ptarget_wlan)
> +					if (check_fwstate(pmlmepriv, WIFI_STATION_STATE) == true &&
> +					    ptarget_wlan) {
>  						ptarget_wlan->fixed = true;
>  					}

Delete the curly braces as well.

regards,
dan carpenter


