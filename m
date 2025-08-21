Return-Path: <linux-kernel+bounces-779736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 624DAB2F7F7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 14:29:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67C633A4A7E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 12:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C9BF30E833;
	Thu, 21 Aug 2025 12:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dt47RlAC"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 575DF8248B
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 12:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755779349; cv=none; b=c5yxjNdwZeP27vi/LmGIIu7e5EtXYTKoqapHUnV0hVkSdJhAXrytaGDC8//VY634lpVMbvukXXosi+VMkVCqJWHQAJ0DY3AAjDqu++inNZO4VFZDSX1v1jztv0MsmfH8luZcUNMqr0kEHaDKQluD41HhA8tpfDN/UvzDOhEuNfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755779349; c=relaxed/simple;
	bh=ipyvJjqvXQZXiCECZcXAcXKFk38PARAX3ClkU4503z8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gJdkIqAm6dEVishTmx+UPhs3pYWJoIQRglusnBUgQ8d4fU+U4u+jI+Kdl42BJunp2+ypRR7hwwwxNylW+L/QF4Jwm6ZkqoCeHDXgx5UszmPv1N/sIryoojYeLVWkrSDMlVGrS3PXSlTLZYSnPf9K8aIr+jKiRo4m27rDzVm7cp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dt47RlAC; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-45a1b05ac1eso5432225e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 05:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755779346; x=1756384146; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uk+Gw1wsKmJ7CUTVerhhurDygK4Wa2zZgqD1NupOrg8=;
        b=dt47RlACZaACMEuspGRIAm0S+AhxBX+t7/xkvF7apLxB25qoDhgK5a3dIXw2g3AZqG
         ACdCiteUf/nc4jPe7RCqJjtA+4IENyFT3zvzmmuN1+n/EhdIBEHUVXUPHLx0zFH9Rfbv
         0E9EUqmiRVMnW5hQBUUSy8uEeiKMdUwY/2og8EhfBmdkSP0WFWjY+3LcCPpNdLkfWdsO
         Xs8hjmlnc+cH72q800mHkUfxLxWnu3DDySk5hMvgwfoJTp+1DMgCQyilyZtKNsgrCXGe
         j7hiRm6Ze5OgdpKS2kB7+FULaIsm3Mof1UvZBTSJGmQ9K0xv9MW6LBRB4vpFGKgQ7yvm
         M5pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755779346; x=1756384146;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uk+Gw1wsKmJ7CUTVerhhurDygK4Wa2zZgqD1NupOrg8=;
        b=GlQFv8dody6W5mfSv3T1OHFt9aZ1q6cveihQXLiWfKD9xcUnSoaGtfsf9xupvrIS8a
         oR5z8cQTzDzg48fg30nN53fyf/z8kC2M2u+eC9TyRix5+5TAjhOI/rIy39bB+7qFdY7u
         Wc1vPfhi7LiJgz9+MPrTdbhTsVTTBhwjvA2s3jzOftbFhALVT5j223XmkPs27OWHIx+z
         nBg2PfxGaAvBD9RRNzk0MSDEAnzUEIN3xt3IhC0CWoPHF5rRXaOaKfPe6n0jf2mWbR7W
         L53q6KBfpH4SPMipp829VwVocbq6ta3RAyOcPYtOjl7+LJJ4FqLowYehKm2PDMDuVX6b
         bR6Q==
X-Forwarded-Encrypted: i=1; AJvYcCW5Jic5wEhxxzB47sxk8n6BWkWUVsP1kSSms7ZplTePn+XEMTkrHF2ADr2L+1L+fbbhGOc76NMCuRCMCOo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmkSYYZZqGTSN3b+NMkN/C6DA1Ip5jLlpoh5VbUeE0QSuOYzCL
	NQ4NlQTJ7dmJ9rtVyMhdq7wS0PvxWKQQwJlnQfJn3GUGMeJaUzWhCL5ENjwSMisuf8g=
X-Gm-Gg: ASbGncvFlhd6jkWyF6pFnrGd7rMNV+crjx893cgD+2IKDZbmCFC8Dix4YOmL6kPxecV
	0ky2hO2v3p2ADjvkkFQgFB0uTwNacYYWBKgQQXfPZxvbKwdkfHvv+N2rBzCMKIcXzTjfVSzdUcr
	ZZEwOfz0pPIDTxGUg31q6cgj5dG/weM+BlM+wi6aLOVuR4ywvagbigtiqkvX7PCdLOWY3MpKOQC
	c+ps8nlhRuG+O8e6WRsQjl0XFzBk+IUKQQ8FhwB2KxFt1RsWEsph30PWHxPC+L6AK+b4FJ3XvGP
	dC8fo4XEUbSa/sPpPs4TeSg4jGdiew0EAuXmg63aHb04ywNYhhIVTVmKqeqO89LUjV1bXD3y/QV
	Qmz8Wla2dtfA67UG9aNkP1UdpE02Fa7FJLWNOVQ==
X-Google-Smtp-Source: AGHT+IGJrYKPC9BNmSR70F39FVaCXjHhbs3ESqGZ+t90Sf0UFy3gTnptWt8uEhlEoOhqqmoO/zvgsA==
X-Received: by 2002:a05:600c:4743:b0:459:d6a6:77c with SMTP id 5b1f17b1804b1-45b4d85db41mr19889845e9.33.1755779345665;
        Thu, 21 Aug 2025 05:29:05 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45b4dc25b04sm26193375e9.22.2025.08.21.05.29.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 05:29:05 -0700 (PDT)
Date: Thu, 21 Aug 2025 15:29:01 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Adrian =?utf-8?Q?Barna=C5=9B?= <abarnas@google.com>
Cc: Hans de Goede <hansg@kernel.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Andy Shevchenko <andy@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev
Subject: Re: [PATCH v2 1/3] staging: media: atomisp: Remove unnecessary
 inline declaration in gdc.c
Message-ID: <aKcRDWlRQ1gughvQ@stanley.mountain>
References: <20250821070130.2581766-1-abarnas@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250821070130.2581766-1-abarnas@google.com>

On Thu, Aug 21, 2025 at 07:01:28AM +0000, Adrian Barnaś wrote:
> Get rid of gdc_reg_store() forward declaration because it brings no value

The subject should say "forward" instead of "inline".  Also add a period
to the end of your sentences.

regards,
dan carpenter


