Return-Path: <linux-kernel+bounces-735449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 618A9B08F79
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 16:32:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E9E55A3533
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 14:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 526482F94A5;
	Thu, 17 Jul 2025 14:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vDzz2foR"
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF322F7D08
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 14:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752762617; cv=none; b=epFHaYj2AvM9tYUayOZT+V359t0KESgfpLngXlF6aymFDtLdp6vIZVB7QDZjUTQKu6sODU9nHaPZRojYvb4M+lggL8j8T06CTzZni0w51U+H7SM0LrBsQWHtCR4z9DnxUhkgt+V4mbf/cagUk396RG5h8eZsIqv7XXEw0m39Fw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752762617; c=relaxed/simple;
	bh=i4AOCu/t+teVCBfAnuyDW57wdR/g54HBsrTynSNwcfg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e09PweGnnZ5Fdo2DlMlmQO5AqVvr9dsxT52Z1hBmdsV95xahWWnTexBgCRRCVsFOppAAzgqIKEayG25gbtJ0dX4J4TDKx5kh/ShsGye3Z6FmQJNiGNvNGfcEWO9nwFYsbNscetjQmao1F1b5EyqQp0/lJJryu1xglhfnwW6DcHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vDzz2foR; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-73e65d29fe9so488290a34.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 07:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752762615; x=1753367415; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=c9WyUNURTxDjhSFlDNytarMEzB5jWv8rhBlf3egCP8I=;
        b=vDzz2foRwHzND18Zywo9jDRGzq3vPnnSb96CeJQnpyTno0+Ncin4Pzw0aJ7CNaaZHv
         xElAxPek9G/q/a537D+cxP8h4O5Ky6fDycs/vNYvbQIkj2SFl/E+uFpqx419J/6YjYK8
         S3lOWuD/Ao0uP6ysg1AGJTsQ9PqEi5Hkh1dOq/eunmgG3qysq1doK0jf56UIqR8iRn1I
         SucWqp8cXLuKb6FG8kv32WrqW+KZ0cdZtgpw+1VQxuuhS+yejzkJhTZfSCXJfaepR6ZI
         D91qp+mkOYolecCbOZtMV/gxmLwFa8rDrDbNHBY82+K4atfYq6US+xdVDQ2sqfS7EYg1
         buXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752762615; x=1753367415;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c9WyUNURTxDjhSFlDNytarMEzB5jWv8rhBlf3egCP8I=;
        b=HCF3/KfZ6NTLouqJylysSaqRJIZ6rrVeFy29/aU5uI99yFG2MFNcG5ZeUkpFBHD9G8
         WmMuFUFfceyUDqzrA9kdba94O1Cyae9qWJH+XagXuoeqqoYybIeIQFIVNHZlPxZ3LWiF
         tkEg6Rm8gTFjC92CD1CX7f7eeq57s1WNyHr11gSQOqH9KcpT/XnEvwNaqwZ7hx4wI3zt
         tB2jaqX6Z5aq3XO3c4lEVjMSzf+1I5jPotRvrbYi57zBhRU/j+H8/ReSU/Nd1lBXMeYE
         qoTn4rzpqYzixm+5gMQf0l5PtSxRP6+hh/LNQ8G101C0j1U39cUMNe2FstV0eedYogu+
         NNsg==
X-Forwarded-Encrypted: i=1; AJvYcCWwyInOu3eA46ANznUqPeIO74VB6KIl7pVPHaqzqzDRijFmfjjxQ5NFoD5nw+ddJZSs0UmgnQEngknhm6g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEvTq1MO+v6lXrx0juu9b8hwFkGnLnwDZtCIiAoYUTj9DdLYJA
	etu1iW4cIzzzFAcSoUJBcDhb+pVoalgyiGzUns5zTJSCgb2qbMxvMfitaZmJc9l+xNU=
X-Gm-Gg: ASbGncs5rKeZulN6nUHQTTdm8khwS0rt9eMd9yJbDLjCpVmXbTymFx2DatObB5jHs5Q
	PFWeeH0bpl4eu0zOpmw53DhH5xSMW0npMD+84k8bqMek0276NlBK+ljByn3P/UVRY1fUCkzqvjm
	oQ02B0ZYxqCe++YTTA04/iO3VLyhA3bfDtyt4qJrS56z/vgYWSRsES+nWFkgCIx1DtMKELBIisy
	gZFbJX+48hun7050ZQNWFiC3d6PMyX3UIDFhhNKn2nKcUIGjILc8BNDedyFoBA1kg6eHWd42i4L
	8kZuBsekB0GlauDVrQ9+Xc2KL1l+/ggiG/2KofmWaCMA225xuGQuWEkyxZ57lNbMsbZyplfADG7
	/5h1OK3ejxI+pXWoHuE9/N6aRAxb/
X-Google-Smtp-Source: AGHT+IHk7/gc9YLubk1Cjji23IU9exbggTb4A51g9DQ8a5fEshA2ox0UCblR1EaUtTw1t+IxEkNNCw==
X-Received: by 2002:a05:6830:2113:b0:73e:6bd0:ff93 with SMTP id 46e09a7af769-73e6bd14111mr4602096a34.12.1752762610529;
        Thu, 17 Jul 2025 07:30:10 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:2c38:70d4:43e:b901])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-73e5d9028c4sm2024909a34.59.2025.07.17.07.30.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 07:30:09 -0700 (PDT)
Date: Thu, 17 Jul 2025 17:30:08 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Abdelrahman Fekry <abdelrahmanfekry375@gmail.com>
Cc: hansg@kernel.org, mchehab@kernel.org, sakari.ailus@linux.intel.com,
	andy@kernel.org, gregkh@linuxfoundation.org,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel-mentees@lists.linux.dev,
	skhan@linuxfoundation.org
Subject: Re: [PATCH v3] staging: media: atomisp: add missing mutex lock in
 atomisp_s_fmt_cap
Message-ID: <3b926b78-b95c-440d-846d-bc9d95aee714@suswa.mountain>
References: <20250717124234.24572-1-abdelrahmanfekry375@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250717124234.24572-1-abdelrahmanfekry375@gmail.com>

On Thu, Jul 17, 2025 at 03:42:34PM +0300, Abdelrahman Fekry wrote:
> The function atomisp_set_fmt() modifies shared device state and expects
> callers to hold the isp->mutex for synchronization. While most internal
> callers correctly lock the mutex before invoking atomisp_set_fmt(), the
> V4L2 ioctl handler atomisp_s_fmt_cap() does not.
> 
> This results in an unsafe execution path for VIDIOC_S_FMT ioctls
> (e.g. via v4l2-ctl), where shared structures such as pipe->pix and
> pipe->frame_info may be modified concurrently without proper protection.
> 
> - Fix this by explicitly locking isp->mutex in atomisp_s_fmt_cap().
> 
> Fixes: 4bdab80981ca ("media: atomisp: Make it possible to call atomisp_set_fmt() without a file handle")
> Signed-off-by: Abdelrahman Fekry <abdelrahmanfekry375@gmail.com>
> ---

Thanks!

Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>

regards,
dan carpenter


