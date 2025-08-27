Return-Path: <linux-kernel+bounces-788598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C95E7B386FE
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 17:52:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 679A7688093
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 15:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 760F027B4E8;
	Wed, 27 Aug 2025 15:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I6IGpQum"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685BE271444;
	Wed, 27 Aug 2025 15:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756309939; cv=none; b=HcTpepPCmn6GFdC+0Sl2JXQa1tX8syZzBxHa0dkgE8SOokvOXziAmalfgVfFODitY47ttywXXqpyvwlZfHE1xoE5nc6rT26cnKoTN+VWjwhjnqOU+tJV80xk7eesmDtUg8CGMUr3Xg36VSS4Bphyf/D1DhfhEfFCQnNoFfbi8xU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756309939; c=relaxed/simple;
	bh=mxEDOxEUG8uE0LxS50vZIUnB7mT0gj+7iog+IuhZxpI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h8VzRrlEqRhDTeSpBeB4gUWfv1h2cNRFX2S+h+2EyRD0LvnHRJXlnIGecnwzhpv4EUWIHx7aVS8bvJti3d4rkl/SUeS9EfwcnETMS0dDYSyglvW+Vr7Nzc0vdLwh/Yts3lD8iZXV9rUGYPVCaYC/wiuSlM80dQ8R2sb6zaftX2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I6IGpQum; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7720c9e2900so43624b3a.0;
        Wed, 27 Aug 2025 08:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756309938; x=1756914738; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YMtBi0kWjMCd2K78TZRBVYc30InI1Bze5Nd5aWCJ+8A=;
        b=I6IGpQumdqjrs5/98L41+d88zj4HfdqH5OxD/g0CXefVNBFveYtCrxM5k93Q9JvBUm
         7gmP4unUz5FtcUzo1yrZcwvHA33mvATd4ZnaTR0cKCHfPJjwQg8s5KkdgYfRguYcb74E
         9SfSnQY4I+MuzbrqM9bm8xs/M1wcIx9V6bau1H5OxCv8YDR3oYX/nJwUW5s6/HF4ZnkQ
         G9Rpy88o+JMfsMPWC1W5V1wNmM3WcA+Rw3FGBeaMaIGduuefYbHYnsXlnEK/1NoMV9yk
         AgyByVghqn+T4wjPt7iwqaXR6snSchF09beD9oE37DKcddNcjmTD5TOOhtnUjidRbFnD
         sZ/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756309938; x=1756914738;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YMtBi0kWjMCd2K78TZRBVYc30InI1Bze5Nd5aWCJ+8A=;
        b=Cy05jGNRgOzSiasNAcj15/n4BApZCSLUGtUEowa5ggKB4wnkBzvHQkIyx6+3tyBES+
         oMAhNfNbMHHRFjicVKuQzLpwg41fQNzwR+Hnevx0x1LUWZ/sRUdy7POdPSbEORnpYzrK
         Atvi5m7UIhGraD6H04YfdP5jz2FHCd/gdR9FcWzvNcr7EjdX0tnFfIhdgTgSOMlWJ+B8
         SwGQXTrzkMr5XiInmSL1Ni/95DstXhNrTwMPvJztonHmXM/cCId/8fun5omrXHgdte5j
         jmuoDRqvJvruzqEIAQtbJclk46y1maLdt7xZLjWrLd+F8o9AhYecqz+IvVck1sKkR6DN
         0RkQ==
X-Forwarded-Encrypted: i=1; AJvYcCX+jMLGcQIWwiSrIeVDRCSqur9f22yQ9ff1NrhvnT28wUjhbs4arHcNqsvufqe7TAPPKgooLSdEbl1MytHs@vger.kernel.org, AJvYcCX1EcdypfG4dWn4OzccyPsKAv4OzJhXbVcQKRtgAKaQ40lRYIW6UxZY3TUAYRbNMZReRbuPsV9IMs3q@vger.kernel.org, AJvYcCXWOHtf5iTfHEV84PWw1jyrrvOoa3Se/Nh93TjAaQET0pHmHF5Ye8vpq89qWJpCj38/HroeXFjYFcit@vger.kernel.org
X-Gm-Message-State: AOJu0YxxHC7NKANb5Yj3UjXZ4DTPQa8GSWCebNQ3dKRQWIUf3mqh6ny5
	mBN7vX7BHHPF7q3QCiZE/MXEPgDkymYqB75IurtZ6Cxw0H5grxpIq0kVbnVpog==
X-Gm-Gg: ASbGnctVBGJ5nrRKrW9WkcPbYodQq9VVh6GIghyCrNFm8Ea6wIjYhLi2OthXmCeP7Nf
	/UiYGNzOmlenpRTJqrOiRWTUhLWyF7FGsR9/L3Qe6mdD1BlDoV3saV2QSajEZ26RVa44QwWBKfn
	nsMYWSd4rrXDwycVw6WxIoroSm4lRvaY34XkbI54LU3h96W5clEya8qtVdj/QrOVWdcwLsfSU6+
	CsD6l1f+4xiFafB7gydq+V1xeII+quiY5IQxDkmS3F4UHCxXccLk84NdSRsy6hOV5UPc3XP7rh1
	wO8tW3C+mubhB36WDXN92ZntsyIlV8SdQBkEJj4qXQehJ89a3rcPCt22D7WFVPL6EQSjllBcJow
	nTnW0z0TP7QnWU8T6/JH1eXIORYjUyd2hjs+41b1o6n9eJg==
X-Google-Smtp-Source: AGHT+IEuVbrr4rGYhb348Gb0Qtu4Ekt90MHhjQuQTjw9kt/nWBhIpke2qshPYvLuQ1DpnQjMYzqYzQ==
X-Received: by 2002:a05:6a20:12c1:b0:23f:f7ae:6e3e with SMTP id adf61e73a8af0-24340b5b1cdmr30863460637.24.1756309937646;
        Wed, 27 Aug 2025 08:52:17 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7720f609cbfsm1049985b3a.13.2025.08.27.08.52.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 08:52:17 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 27 Aug 2025 08:52:16 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: ChiShih Tsai <tomtsai764@gmail.com>
Cc: linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	jdelvare@suse.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, corbet@lwn.net, t630619@gmail.com
Subject: Re: [PATCH v3 2/2] hwmon: (pmbus/adm1275) add sq24905c support
Message-ID: <a8c87cc4-257b-41bf-8761-a608a78a3f9e@roeck-us.net>
References: <20250806223724.1207-1-tomtsai764@gmail.com>
 <20250806223724.1207-3-tomtsai764@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250806223724.1207-3-tomtsai764@gmail.com>

On Thu, Aug 07, 2025 at 06:37:24AM +0800, ChiShih Tsai wrote:
> Add support for sq24905c which is similar to adm1275 and other chips
> of the series.
> 
> Signed-off-by: ChiShih Tsai <tomtsai764@gmail.com>

Applied.

Guenter

