Return-Path: <linux-kernel+bounces-796103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BB49B3FBF4
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 12:12:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CFF71B240DC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 10:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E25D42F0675;
	Tue,  2 Sep 2025 10:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UXLBwiIi"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2CAF2EF677
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 10:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756807965; cv=none; b=fYdxeOI+OeJCt90+rqA2/3gkY8YfE7/oh+cI9Qz1OBs9OCv8L6r9GjUIWE+uyp+x5nrWs1juKmF92FnOfpu8kZg85gbnR+inOyeIghWvkJXrp+A8sSz725Lim88FiS5XPG4dFPi49qNthulXM2GUhrAmIJFi1OxwHtLdNA91oh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756807965; c=relaxed/simple;
	bh=SjEO5Mf8trw66bSMBZcBAX0fSI45BCBQMiqBnD5W/yU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d/Cm9o3SxPBQWK8MwtaKudbZhf8hQtqDyN4OUVy90QRNkiCqTWefdGmZgydWCdbSizMJ/s9q20et06bK/P/J/GUhT6E7D/WW1VK4KSMRQ5YvTi0w1iMHQk+DgI4DyB9HZ2pwNqhM3ZzJI/cMA/ngIRE2vPAMIkbYwhAUO0OnzYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UXLBwiIi; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-45b9814efbcso4020325e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 03:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756807962; x=1757412762; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JnYStx1tmY335G9wa9Z21vYW/Hu/c3l+9Jg6zw7X6p4=;
        b=UXLBwiIirDlfoKddPJDl47evb11RbgF/+l0hyMaIef3mcWwz+pDKj/nRjEemcm6JUx
         oAjsdoPqVmzZ3OyZEPJPz7dMh3pkMe4T5FbA5Qr1dtgZB+U4mwkODFzuoJKD/6Dks+2M
         mAqgbZeBqCGyRIsFHoRBJ597P8toNBXy1rsDf6SMPyJ7QCckVN5vaQ6MQvAGej/pwcLh
         thlqoZ24dxjjol45jJNAgpv8W4mrdntScZPQiuS4+vOadbnCkSGUeMN5b/c3W3yUrXkF
         9V6z9epvxMiRY9IkwYVw9Tr+gEa0wZIHjp+1POsvWNUHPIKrC4nXC3DyjTi5+OCvQtIc
         EsEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756807962; x=1757412762;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JnYStx1tmY335G9wa9Z21vYW/Hu/c3l+9Jg6zw7X6p4=;
        b=RjDgZ0UEzLVSNs4c3unZm967jXnHTJ88B9X82KV7nbPUTcKs1igU6HV/gSLQiu3z45
         ncRlnnVVCExpphvE6k7iJzxzh/+esr+fidLUbLZUyZ5iP2DD0XE7VMEs1VXFJCmlSKze
         2nix6XKjX8MamOoi8Ya0c9J6UQkOvF4fSS+wC+MiZON+C/sPIB3Ghtw8acueH+2NZfoq
         6sDgaGw2mbcqXeyK77SfJWCblyyuTjUno7jpc76T8eZP1bOd+y84+mxm5yCbzCwqkxs/
         88zzNJ5OKbwnNKDXM/ieaC9SrH4097d2eoPWIkXbSk4cHdYCTVkDtPaCMqjOnav9MD3m
         yniw==
X-Forwarded-Encrypted: i=1; AJvYcCUmQ/xEPa4wtUnNgc/l/Q2mGCPVRjMhK2uNrXQ65B4+Y0yW7GhWSzQRJLIBhNXh93sru2Tm6VYSxpg3+dM=@vger.kernel.org
X-Gm-Message-State: AOJu0YytzY894bhMYr8FXbjBDWUmnIfDVIJDNojtmQHML5CqD93DcP5P
	jkD4B9j+fMNZ/sZkuALqeyBytVeBuqXMf8xYNk479XmHRxy8D8rIT8QrtbMe6wUGCAw=
X-Gm-Gg: ASbGncvhhK0B/XVdWCbOBG41nc0q1T3SCK0aj7a8Ej7bVa68p9M80J0qYUg0gn2w4aZ
	9yV0nZeL85LkfjWJpeR9KlR9ZvXcdyjS57tkULKHKIu/FuJgJJVawd+7hw8UNEeTRuMNc6Zgnu4
	/1Q+QCgmzzGQG1FGydqaaF0//5+ZJ7P72x6wYaAIIdXSWB3oOoRZR1jD2+Aw3IjcCc9sZy3w09h
	/M6B10vdQ6WLEoH3kLtZyRQ6CO7RKR85ROzvz4TdiD09bEYwHgMQqXvdzLmWXujjx9QeGCzpEVj
	rKpWM8VoJUBoZhZN+BnM7G9UwndRKzn7fXPpPGYgwB/6Zl3eTCiCQif1x+jGYoSN5TVtM8jfmg8
	qjQeh0h28vL1NhmYdIBYsgHBooLUTtZ58d3xXrw==
X-Google-Smtp-Source: AGHT+IHG6eBfdtTOEZxcXAbASopPkY4+xwB16XZCz9dFBdFmkVcioRx8F/ATKlllEq5D5xx6npvGpg==
X-Received: by 2002:a05:600c:1f96:b0:45b:7510:4042 with SMTP id 5b1f17b1804b1-45b84c65642mr105053935e9.17.1756807961803;
        Tue, 02 Sep 2025 03:12:41 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45b73c52735sm254121465e9.22.2025.09.02.03.12.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 03:12:41 -0700 (PDT)
Date: Tue, 2 Sep 2025 13:12:37 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Adrian =?utf-8?Q?Barna=C5=9B?= <abarnas@google.com>,
	Hans de Goede <hansg@kernel.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Andy Shevchenko <andy@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev
Subject: Re: [RFC] staging: media: atomisp: Simplyfy masking bit logic
Message-ID: <aLbDFcaqzJtZUdCB@stanley.mountain>
References: <20250902073841.2338568-1-abarnas@google.com>
 <aLaypTjukJJloGuL@stanley.mountain>
 <aLa-1GPJDxpX-soG@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aLa-1GPJDxpX-soG@smile.fi.intel.com>

On Tue, Sep 02, 2025 at 12:54:28PM +0300, Andy Shevchenko wrote:
> On Tue, Sep 02, 2025 at 12:02:29PM +0300, Dan Carpenter wrote:
> > On Tue, Sep 02, 2025 at 07:38:40AM +0000, Adrian Barnaś wrote:
> 
> ...
> 
> > >  static inline hive_uedge
> > >  inv_subword(hive_uedge w, unsigned int start, unsigned int end)
> > >  {
> > > -	return w & (~(((1ULL << (end - 1)) - 1) << 1 | 1) | ((1ULL << start) - 1));
> > > +	return w & (~__GENMASK_ULL(end-1, start));
> > >  }
> > 
> > nit: white space.  Add spaces.  Remove parentheses.
> > 
> > These are supposed to be opposites, right?  Subword and inverse Subword.
> > You could dress them up to make them look more opposite.
> > 
> > 	return (w & __GENMASK_ULL(end - 1, start)) >> start;
> > 	return w & ~__GENMASK_ULL(end - 1, start);
> 
> The problem is (and actually with the (end-1, start) above that it might
> generate a really bad code on some CPUs, so I really, really prefer the way
> when _at least_ one of the parameters is constant.

Ah.  Okay.  That makes sense.  Thanks.

regards,
dan carpenter

