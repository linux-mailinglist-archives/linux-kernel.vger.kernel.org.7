Return-Path: <linux-kernel+bounces-844092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 55725BC0FCC
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 12:15:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 028F834DC40
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 10:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A71B2D6E64;
	Tue,  7 Oct 2025 10:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ymihRhD6"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC50A25A324
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 10:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759832136; cv=none; b=Z5S1/FHaDSJ/l0OKl6seG60vG+lGdTlKvhXMuP16iMIhk75PsMNU2kzIC5llqAlVkX2Wg3t9QNAR+B7Zc4uyqiGPBavBN+Xh049TFt3RaInJ18ObSpXw2Ca0ajNu9YRPiKSfQCtTKM201BFIHyN1z2NK2NIVcWO6vI8y7cB+v8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759832136; c=relaxed/simple;
	bh=A8Tf+OjdCf5lVPFHR2KREf1VuWMLVEm4o6QLanOAcuE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QgDj9OvDbebw8dwKTa9y4T0ZPNTOGmjQZNGeuj+H/4hnWqkMBR31srx6VdSNE31ss/no6mprljszARW0Vb7XF0I7NVchOH0Pl97Uohs/tyfz76CuqAQz3Asgh/oE/k4KOipMJ5sEMkmIOfwpO5B02K3LtCxcTLCiSSGwJazRG18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ymihRhD6; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3f1aff41e7eso4573153f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 03:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759832133; x=1760436933; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0yXg9AcgYPyqp7prkWmLpT+mSUIgyHjgb+sEzlSemMY=;
        b=ymihRhD69m51FzgakkdExKqJg6otUyION7gPUVcObiIOlod4Y7j2LTytTg/9Rs7qBj
         IJJNDZT2z9f/8zoEMMWqumdZlf3Vh5TvTNn4EHc3t/x+gDw/bQiPEBqyKumyBNtn+8DS
         e3VO3a0Ewu6s7aJGBXDsjERSxbqC1BDAjP60E0WQerx9MBQvLngdI9B4v+F8Ms9Zf6HH
         LxkXZzM8ctSc9jFJq+LvXXUZ7UZnfQNl9wMdXnpb3SuEuNTEYKPnuKAi1xANT3ZJfDig
         HIZi55xHdvcFOmQFFvTfOCLudOSbnA8LvoPo6Pkq/rVKcV6ivhYFvbEsHUf2KAVDZdSk
         9e8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759832133; x=1760436933;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0yXg9AcgYPyqp7prkWmLpT+mSUIgyHjgb+sEzlSemMY=;
        b=cvPOpXer0+rVNPOFR/S87kUe6cOj4qqfehIg19S8Yexov1i8/SSYF8wIWDPIlIBgm5
         /R6VTQbqN5BO7IiK0UhY6UVl81XLvwDNDIkOws300qzYfdM8j87gM4wyJHUASsyOyC0J
         o/pRis5t6kMDYQXE0arStubqpin1UCXI3AeWrqYz3x2nZvtnMGRHxTRQMWtrM8uu6y2Z
         9LIf8N/tLmIHdqAhwtgn//fCPAY9vn6iBTL3jvLuY5/jCu6lD2AaGjDq6C+rsY4SrPds
         bTmgZua1JcYlEkqs60Pl0B62bPV0eACGI0rJsXu9rbWFm2ju63u3lEBs4M4LMK9gh5Oo
         iMQg==
X-Forwarded-Encrypted: i=1; AJvYcCUTqiEkKerGaznp6C1VLuxTAUjAJlzuojwvQ9wmRnG4LhozHY/ksVk3Vx52YaTd3xEtrHGBOnpLYQN934k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHgua8r6Y/YN6R+JiLuy0AJZeA5BZdfCT8RxRxkNBj2pumJOho
	blEtTiaHd8nxD5hlo4IduqcQqglbGPQepFqxCGOCvSq5tqSiW23xJn4eGLkQ+emKYReRqdz3jSB
	rWplQ
X-Gm-Gg: ASbGncssLrTf7N3/d4m3HDMENYXviyWazcatjZxHejWJEO+mRX4NBMAsE85MoP7SGGr
	R4xmJhIx+/7uSjT2torgUq9T4zt/N4K8Kgh51Zo5zp8hMhUrMd8x0Js/KvoEo4rvsyqTCbRFu4M
	Mvs9aRb4MNfsu5d5RnemuVCcYXqzIk9k6aoNy63JdjDaDyvXSwxhvbeMUndKaiDEgGuHHIP4Iij
	kn4gZzgj/9pUneIMVmt5ShMSMn4w/ZTfCtAPt+joZSan0xekfcoLjgYlo+BUCLEk0Uqzn8X6cfz
	JbL9AlPSafUZt9xvfsXglgOHU6NnxZcSTbHyGydQ3etoV0p5++73IunGdMi5cBT3eLhvCNUGzf4
	p4f+D7+Hbh+pqniJScQMIE9ZxcIX7kI9BLE455WFUgHJEHIfX/Ir3dDXg
X-Google-Smtp-Source: AGHT+IEiT5FN1FKAizEpcgIVkRix673kPGjQ2cVd4EsFoPr5sDZw5EWuiYpkdxhZ49rGiJDXGIO3fw==
X-Received: by 2002:a05:6000:26cb:b0:425:8c06:b78a with SMTP id ffacd0b85a97d-4258c06b7fdmr80060f8f.59.1759832132912;
        Tue, 07 Oct 2025 03:15:32 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-4255d8a6bb2sm24248577f8f.10.2025.10.07.03.15.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 03:15:32 -0700 (PDT)
Date: Tue, 7 Oct 2025 13:15:29 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Rohan Tripathi <trohan2000@gmail.com>
Cc: gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/6] staging: rtl8723bs: remove unnecessary blank
 lines in rtw_ap.c
Message-ID: <aOToQUMOqkG8EDII@stanley.mountain>
References: <20251007091303.491115-1-trohan2000@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251007091303.491115-1-trohan2000@gmail.com>

There you go.  Looks good now.  Thanks!

Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>

regards,
dan carpenter


