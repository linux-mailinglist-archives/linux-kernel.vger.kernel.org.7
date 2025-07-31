Return-Path: <linux-kernel+bounces-752352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CFF4B1747C
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 17:59:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 074C0189C1C4
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 15:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50BE6222587;
	Thu, 31 Jul 2025 15:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PmwsOCgM"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA04225A31
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 15:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753977547; cv=none; b=intexznzpkwFLtboF9vRDkiAULO2nFJVLPqKwagflPz9vOX5KpBmBH5risxhf8i0e1XrBR/PCF3O8ll6IlHS8dk6HfzXstLOnd+OnqzFowDRZAo9L45wLMN1n/iLgGzXcJdJUVUiMyFh5W9nIKkmc9+TfPNtfV8iSWJKb908UvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753977547; c=relaxed/simple;
	bh=EGUB34VsUmvG1Zb9ZRJWC5Cb4aXm/XLM4GSFfCMKf1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nC3eRCZkYkLXla+S9cPDV0QYFuVCfGYAVXMIWL5FgX2l4BIgF+wyQVn9E0W30dXrgGsesFO5qJGbqspR27WcMIme8fgz7Pbg5M11RJQxWJIkeku+4RtOHlbRk7thN0pZqcIFdVRUMTEKTc3xuB0/dnlhH2d37zQ9g/F+fEwrV7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PmwsOCgM; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3b79bd3b1f7so385228f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 08:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753977544; x=1754582344; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=17RO5tj8wCg7IBKuIfx2NeFRjK89caraONSxCkuBGWc=;
        b=PmwsOCgMq194Tm/MOH5GnmONFv319lr25Ot7MhUiHv279uYdAeVfG1fB8OpiMwp9ai
         lC07HqGhxt60OS6tvjK2tfN4YM/Lt9omNH4hP81gN5hIBR86wEOXVCrW/au0OTGemuvd
         j3HHL15nBUhvzbkO5IFEGI/UEI+1sqNliMeWYMUFoSp9/W83DgN98vcGC/++OUxHjL4Y
         0JadBqKjC8m5Mft16UJ2wjbhi4EeRWaZlpYB7dZSODrkdqJWiDJgSJMs8LxbVmpfliJO
         7ORTcZ5wlVZwD2XhjDboB3beKsovv6RIsnNGcGIL/QbVqqMlLosY8OUHX2rXlj7F/Zux
         i5RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753977544; x=1754582344;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=17RO5tj8wCg7IBKuIfx2NeFRjK89caraONSxCkuBGWc=;
        b=hQpB90CHKPtqd0NdEYiVtGrDObV6AOtwBILB2CHuyr2j9uBQ2scdqWXDfQYAf0jzuq
         Oq9+bxfgjcTNUb9lQCSRvnrxWPcES/NNmEwpjjNVRPXgwIPRHWxfNhT4a9O7D6tYta61
         EGgw3mD9Xt2FBBt7L4farerfqN9aoNsBsk2vj0z90yoHQpyiesG7RlXsY1jv8Kft2lkP
         /RpaANLUZneR5JvK458v7aJQOxhxmUzmXAgj16qlhvZFqQ+5A15AYa6y73i1SH7Ob4vs
         DQCz6oDWA/92g02ZhVO4HFlNdJ6e3Kg7js1MENuGTuXSA0lq9E5msQNtOu9Tb/PQPkEz
         GcjA==
X-Forwarded-Encrypted: i=1; AJvYcCU9OCfdWkgz7Msb9t0q3jKDtpqQEyfS/EzgUNIaw9RNaSutzmvUiI8P77ebIGn/+N0Xqzg+MZ6CraXma7w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2p97Y5Xl5isZdl9orOrOb9/qKe/MSgWTzL0jbGPMRpPApzFlQ
	XqnhyhA/vmcYtgbgvRwKDAQoShW/WErR6Ofx5UJ8NN8dQrPaq4qK21lthXbAsqeEaFU=
X-Gm-Gg: ASbGncsJ9W3TYnNm6Qn1+/IdsI+DUqktBCQsGQG0iminkbOTRK/EIMvAsqBVMYg+36W
	AcH3VJAlIfOiYXUg9o4A4oUByNbyu4LDbtD4aCsFIHcmbkHWPl81WILZ56kpYZaxuAJtfz7EgEe
	AqB3h4Sq/fhfBvUG4jr+EAL7a2pJ+ZGQgtLh8QMGMyFTvRxUNQKvZRV1LI8JadzlyaTk3HcSArZ
	OnzsCqyeDYmxGD/wASPHr+KKwJy1H1tZczAkwtn/nISMVXpK9hYNjgLpFzeh5Ki0miCHCGOhewW
	LXKiUh/1RhX4kmmpDH+P65R8z0yCGbCEujVqPwVjC68r/YL79X02aIqxvz7oFI1rMOJtpX/aiPg
	Ws3jZ86rW1LFYm69vAHR599G/8HI=
X-Google-Smtp-Source: AGHT+IGi5XSwe1WlINYSaZIl9PD30Bv4d1ucxiE0q9IdFf/Di5Lqoo+8RUJufu6hF+pT8D6IwS4/tg==
X-Received: by 2002:a05:6000:2481:b0:3b8:4da3:cace with SMTP id ffacd0b85a97d-3b84da3cfb4mr2016313f8f.29.1753977544176;
        Thu, 31 Jul 2025 08:59:04 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4589ee621adsm32429795e9.30.2025.07.31.08.59.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 08:59:03 -0700 (PDT)
Date: Thu, 31 Jul 2025 18:59:01 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Michael Straube <straube.linux@gmail.com>
Cc: gregkh@linuxfoundation.org, hdegoede@redhat.com,
	Larry.Finger@lwfinger.net, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/8] staging: rtl8723bs: move rtw_init_mlme_timer to
 core/rtw_mlme.c
Message-ID: <05bc4742-ef57-482b-a2af-23a7f238fd69@suswa.mountain>
References: <20250730104501.150270-1-straube.linux@gmail.com>
 <20250730104501.150270-4-straube.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250730104501.150270-4-straube.linux@gmail.com>

On Wed, Jul 30, 2025 at 12:44:56PM +0200, Michael Straube wrote:
> +static void _rtw_set_scan_deny_timer_hdl(struct timer_list *t)
> +{
> +	struct adapter *adapter =
> +	timer_container_of(adapter, t, mlmepriv.set_scan_deny_timer);

You accidentally deleted a tab here.  This should have been:

	struct adapter *adapter =
		timer_container_of(adapter, t, mlmepriv.set_scan_deny_timer);

regards,
dan carpenter

> +
> +	rtw_clear_scan_deny(adapter);
> +}

[ snip ]

> -static void _rtw_set_scan_deny_timer_hdl(struct timer_list *t)
> -{
> -	struct adapter *adapter =
> -		timer_container_of(adapter, t, mlmepriv.set_scan_deny_timer);
> -
> -	rtw_clear_scan_deny(adapter);
> -}


