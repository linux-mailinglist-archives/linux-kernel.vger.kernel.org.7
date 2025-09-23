Return-Path: <linux-kernel+bounces-828769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD77FB956B1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 12:24:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFE5C18809E7
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 10:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BECDA310645;
	Tue, 23 Sep 2025 10:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FQtuWJWp"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76A4A1F91E3
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 10:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758623089; cv=none; b=Cifqjd/ELA4507s4Dl7ZUrTH9fkuzYWClvo1e+ft+eerXjspr2DyhQVANS3EU34s7g3soJDjjFxZpFnTobX+e//F8p6PQyrVun/r51bgVzK8NlSQMzWmSaGRmuO5wb51D+IkjMtp3AuWMppC+vmEMz/UWOl0RMbowmN0jMhzss4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758623089; c=relaxed/simple;
	bh=hxWT8ALareBd0uA5cYCp5G3aOWs5UczcjQ4vrqSt5qs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FHf1/Bx9zOyxxtd4/I39pDuXpBI4ZHiMP/BA7R+2IPPYDA6iQ+Fzh2qoD7rw6/1q5EYTaKQ1CYm3mog+paZehS+fwAO5n290iaQGhnzjN92TRSbAadXs+VmKI/Gmpe8NbziK4Fp6bftcOwZHpBUWEPuwaqbPV4Evl9T6oOnUHAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FQtuWJWp; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-45df7dc1b98so32692295e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 03:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758623086; x=1759227886; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YGeK0L8OvYq8qeWwb8RivqQQZlN1zmdA7Hijul02Hfc=;
        b=FQtuWJWpj0HTJvDa+HVJ5ELcJyE8s5GInnkCtk7zifWlZpkhYnRPySlxqxAD20xNeX
         TELcd40jy3nSxkoRjtN2G3nLk7RqPdIpKSOvdwBh+RgdUcET3IJuU9fB7AHLBSPg/Nnv
         kyHuAhqajaaUQxzREvoW7TvxP5OcksFhKmIfsW6TQrL7T7jCUK2KgePeWiTrmaGegxhT
         cTE/cytgE5h+WRFtjpOyGrfP3gmfY8Ki1+FW7Zy+svYtjuhLQ35yvaR0Ej8FjdhougxO
         9M7Qwn7z/2/ShXBnQ6xMNnkeaeGmwhQ0T6BwAInchOBxsgnxOT5+oUpeNI/CGVM/gAUn
         9fxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758623086; x=1759227886;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YGeK0L8OvYq8qeWwb8RivqQQZlN1zmdA7Hijul02Hfc=;
        b=VxsOkJk7SqY47LU5INWXKH90tq5oxKdUhfoml/1978tR5HUsLmAo3CE7ahlNKxwdCJ
         SROxg9RpCJRJ51KY+gwsD4GP9xJzqmNVa5wD7R14+KZsZ2YwE+4QOAlsSCwOE2svXcqY
         pw5pPTBMwpHptJYkMbGrkcAHmdblodQtD2xvdLr4sr8WngX4uQdlh0eW75Sa0IkaxAWh
         1dNMN3p6iZTjjTuANp+ctKMNCmRRvyWZxQVwgoCBJ1LA6jkcQErn3qjEsPbcqmLPwWiX
         LRHIoNnKehso+AgBIpZbWH1cDMsc37whf7XxTvzxZxAZ0IqqA+iwfrGR2mmPbgojP1HV
         qD5w==
X-Forwarded-Encrypted: i=1; AJvYcCUtHEsHU+t6lQna2Ug5AtnFFPQrcnaMdo5gm86KR/vhYQpF/oQQdSnTQUDgzoJPZxYFN27XTU3uWKm/+DM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqY0hQgG4F7vfbQiWKVnO0Qks51R4kKSfLF9jHZfbyo1hQfTrq
	+uoprbg33zEJFFLUgZFqrvE1U7o7O2CU2o0vf9AJb9UbhoUvV0RN+yOU8bOgpzeGTJc=
X-Gm-Gg: ASbGncsQrhHjQ5AJ45k2iWB6zCN32rDaI1rpxhkAtcCKpRiUAVqM/KU3BAZtTshKwpD
	bl0WLvNWE/OH20hCl83PLXZE4RmBrItrNEIHgl019v6VONmRa4kV2Hiaffj0xS9iYl+7KSSkmU3
	uwHrp7dOwacR21PLw7rkeS1nBGBt3yvY0xV7gzeOF0R8hjHlbc8okZY5E1hSBo07qiKtdidWeDO
	6oE0f8J+F/MQeJDyRSQV9B/qq9DIVctXTyKuzNAX3z9Faz/+acZBQhwj2YMqDNX7bDR021qCsaS
	MK1RK7PBEQ7qFWjsIpbdx3VkOgANjEH7AVds8L5q+j+SnrXNrrccL8pcmSzV39gLaxUlbFRwIRz
	O4AJLzh3h+wXfam5Rd7GT8Tdp8Cy3
X-Google-Smtp-Source: AGHT+IFKEEA8sGrJ6WwW5PMsMgfTwp6SLTsv7UjN+mB6CB4NO4UVOagsDVZF3Kbx3CzAzehCmN3qWA==
X-Received: by 2002:a05:600c:198f:b0:456:13b6:4b18 with SMTP id 5b1f17b1804b1-46e1dae28cbmr21080655e9.31.1758623085755;
        Tue, 23 Sep 2025 03:24:45 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-46e2439a62fsm5181495e9.10.2025.09.23.03.24.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 03:24:45 -0700 (PDT)
Date: Tue, 23 Sep 2025 13:24:41 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: Kaushlendra Kumar <kaushlendra.kumar@intel.com>,
	gregkh@linuxfoundation.org, dakr@kernel.org, rafael@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arch_topology: Fix incorrect error check in
 topology_parse_cpu_capacity()
Message-ID: <aNJ1aY0AuATEKjDN@stanley.mountain>
References: <20250923072520.3964688-1-kaushlendra.kumar@intel.com>
 <20250923-spectral-rich-shellfish-3ab26c@sudeepholla>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250923-spectral-rich-shellfish-3ab26c@sudeepholla>

On Tue, Sep 23, 2025 at 09:40:28AM +0100, Sudeep Holla wrote:
> On Tue, Sep 23, 2025 at 12:55:20PM +0530, Kaushlendra Kumar wrote:
> > Fix incorrect use of PTR_ERR_OR_ZERO() in topology_parse_cpu_capacity()
> > which causes the code to proceed with NULL clock pointers. The current
> > logic uses !PTR_ERR_OR_ZERO(cpu_clk) which evaluates to true for both
> > valid pointers and NULL, leading to potential NULL pointer dereference
> > in clk_get_rate().
> > 
> > PTR_ERR_OR_ZERO(cpu_clk) returns:
> > - 0 if cpu_clk is a valid pointer or NULL
> > - error code if cpu_clk is an error pointer
> > 
> > Therefore !PTR_ERR_OR_ZERO(cpu_clk) is true for both valid pointers and
> > NULL, causing the code to call clk_get_rate(NULL) when of_clk_get()
> > returns NULL. Replace with IS_ERR_OR_NULL() which correctly identifies
> > only valid pointers, ensuring clk_get_rate() is called only with valid
> > clock objects.
> >
> 
> Nice catch, wonder how it survived so long unnoticed.

I don't think of_clk_get() can actually return NULL...  It's still worth
fixing but I don't think it affects real life.

regards,
dan carpenter



