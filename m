Return-Path: <linux-kernel+bounces-830885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 51A3DB9AC94
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 17:57:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 156C5189B5CB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 15:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 992773126DA;
	Wed, 24 Sep 2025 15:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D7B9H7dw"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC8E3128CD
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 15:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758729427; cv=none; b=CfiBhVp79p0virGXDQlopWbV47PYfjrMx02vgabH1REu5zHTl67+I+7W5jCgN3Oahchm0iX4ddIdgyRKj62pg4RrY3jeEWB/sHObjuC8+NZ3TQKok5sQMTLppUhCjP+06/2vG1FMTNfX8vcmVrDVecmcMg+/tFLPVQJ0rHdG06Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758729427; c=relaxed/simple;
	bh=W0TpT8Re8zEvNdcOFlrSerjKhi4ru5BnujJu72RiUyo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r65xWjgxZW/boiBa+iaR7gV+HmV14X5d0uGqB1McJuA952U+1X3rmDcCOPqPUZdFGBjO+zIqbcc9QlVRGQiF+MHA8B0HQBfT6GO0UQy5K+bASi/hUqEZ3LchmYnSrQMSk2aJm8Q9MKWs3Zy6Xw/n2pBcNEjTVEm77p/UaS3xQag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D7B9H7dw; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-77f32d99a97so3385697b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 08:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758729425; x=1759334225; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q0NQpLAHxIcZklHB5SuD326usfKg/QXFllwVnvOnGGs=;
        b=D7B9H7dwLYDywWYpVnoKzixWI5VJvO2UIpjcFHu8Hpv1rGSx5+TmTXWHls+DtCxnsG
         Fmw4CwVQB4gEGuQaoFyvFv2Mq0OSW3OvteCafq8mYPS8y3PupOt+wBUyEtxmQ6Zaj0rE
         EqT0HzoXmcM4pweoG/IEJ3uVP8AjvtbleXGbi4orHsOwwKH50Qzw2xk/qJer/qajeYQi
         ULmhH2hkyoVS/DEYUKwtD++j6swIpUn/ZpK4Nw/wPdBerBxjs1Ul4EQf73zFVRMS9Vdg
         j2UDWm6IIArXQjs+IEPM+s9SkiGZd903DU+4sAvtqhQjg2Q44rumCl6Md6jA3MZXLRPr
         kQJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758729425; x=1759334225;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q0NQpLAHxIcZklHB5SuD326usfKg/QXFllwVnvOnGGs=;
        b=eK0/e0T00VkiFGxVe/DUh+aFZDMhVB2r2GhIwVqWfr8JU23yeH35SeSnKbqbZUN+dp
         V9cFHQGniAucqAOQjtMf9I7T+zxutz1BkmWgPE+W3+X/y130Kcec7KOkjfNXArhIt1lL
         QIhy0zsjxB01+GvcvjhhK8tngzz1hpv7907FKt4YEXGWLjx9PNRzjTZ4B9CBTRoi6Vqm
         oAm6WPWbmlS030+89yRsLtM5vpwkfJSy5pULKu1Zn0WNRpAhWg6i0J/8uNBbI7a/y4S1
         pkKPVT70Hah/x3kJ3mFAIFWqV+UfhU7Zy8XkxQQgCceuUWkryil4ALuSSnl6XUDp7uRm
         u0fA==
X-Forwarded-Encrypted: i=1; AJvYcCVE6CYbP3Zr+orMWKqZamuLDgGipfy0R19cBwpYXn/Yw3h1l380U0ZN4TmWPgObG/6zZ+K4+/45aHjC9UY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6I0FM7agI7KSWS5JEDPqzOoR286dxuVyH3AmCjY00iBK87L4X
	LG7mlBQTS8gNc49m7NcrWeoi6j23cHVAEY/PIIQsDAc1zmh3hR2Nc7td
X-Gm-Gg: ASbGncuXzH1UjUhocemsq46p1pd26jWxFVhE4LfFUUYPpEURZs5CwdnsFi5PorebqyC
	e8/0L15uFBKV7ja0UCrLNCyhaPJqEHQwQ1BkMwwIRr/vXOt46oEtdc01Sk5S3jF+bFe1oIiatyP
	xlP73CRR/wg7fmKZKRfvP/temeo/izkpVrrpx7FiTqG6BwmiYCaMKFCZab2JDzin+0ZrIRdcigD
	5VSmIAceCxJd/w3xjjnTprBaCc5+ZK5hEkxEjY1rouesBTuRKXzU01/XN55GyV6cFZIRs+6RDsW
	7Om61fVHR6nwhXahmnpYjUNliGDADzprZ64ZphPGpdoXlWa2g+vAoyvQRIfufFMGJPD59tT82+N
	YeAAqmoc6nRk454x2wxHBJ64B6QRzFvaJ0x0=
X-Google-Smtp-Source: AGHT+IH2mynAyO0z3pd5SH7iz3XlqDdNIzCuXVUVABS5OUSwkQYfwep+60Yy8aTy35z0xTBi39gWAA==
X-Received: by 2002:a05:6a21:99a5:b0:2e0:9b1a:6429 with SMTP id adf61e73a8af0-2e7c508fe00mr160845637.8.1758729424848;
        Wed, 24 Sep 2025 08:57:04 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77f0fc4cfbcsm14373088b3a.61.2025.09.24.08.57.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 08:57:04 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 24 Sep 2025 08:57:03 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Eugene Shalygin <eugene.shalygin@gmail.com>
Cc: Mohamad Kamal <mohamad.kamal.85@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (asus-ec-sensors) add TUF GAMING X670E PLUS WIFI
Message-ID: <bd032e11-1da8-4555-bdd7-39ed9e818650@roeck-us.net>
References: <20250914084019.1108941-1-eugene.shalygin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250914084019.1108941-1-eugene.shalygin@gmail.com>

On Sun, Sep 14, 2025 at 10:40:10AM +0200, Eugene Shalygin wrote:
> From: Mohamad Kamal <mohamad.kamal.85@gmail.com>
> 
> Add support for TUF GAMING X670E PLUS WIFI
> 
> Signed-off-by: Mohamad Kamal <mohamad.kamal.85@gmail.com>
> Signed-off-by: Eugene Shalygin <eugene.shalygin@gmail.com>

Applied.

Guenter

