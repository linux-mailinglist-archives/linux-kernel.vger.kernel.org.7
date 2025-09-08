Return-Path: <linux-kernel+bounces-805075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF014B483BB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 07:46:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 781E43A6BDF
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 05:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4167F21C9E1;
	Mon,  8 Sep 2025 05:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OKOJTUdZ"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9560745945
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 05:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757310359; cv=none; b=Kma1WU2bccEwqfgUZ/JTWyU3vUxyWXWMgRmc60lTJ6zE5sIWAUpWgclUSflYMyL+tF49KHsbfo2GgcQRsIV+BbkxgvVrbZD4sLKzkxDnOStU1SsgS08QxdxRzVdrvOUSOktVJjWmQNU4jwEDGKK/lFfyD6OH65SKWoFxhnIqrnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757310359; c=relaxed/simple;
	bh=Z93EEMLZ8bdepan4BINitcyJFnBNPlN2fw5mo9Yqvos=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bMBm1OATf9WGVM2T0lKDvM0OM4mZ3s7MZJ9BvCYm98fv6q2qwuwkdZR+cmLwVRzXQfMTiBk9OmNAg8lee79U2bPiC4kR6k0EXkHcszXD7RDCYfCPvEwwlJu8TTwxOBee9i8CmosFrRvr+BU6nw7k8SzkDguHIw+1o+sQtiW6+C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OKOJTUdZ; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-45dde353b47so5132195e9.3
        for <linux-kernel@vger.kernel.org>; Sun, 07 Sep 2025 22:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757310355; x=1757915155; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=G+fMI7jrlec1AYc5iE/AykLzEwl5evDQP4qBoNzK6d4=;
        b=OKOJTUdZK48uCdEZXPshpcq6dnuABq4T0+zoIRi4Mcasj2dQatRjPSppit/FT4rRmc
         5ERA5fJMqX6om6iVFo6KN5an613f7HVq7vkoR1c2kcc/E4FXDWUZVQqEVevFwqZKn+ty
         vzhTlmtfiYkbEisxeyNhGWwLXxBA5BxlmG/n1jOsPLFCk6MTnL+rzBgiGAm2GqJGMakv
         z0kJr5h9+/+HMHg2dQbrUd8rrK8crIRosYXDOXcxyUdUUtRAj+wF0XsR6eeeKk6lo9He
         +dNtMsHswgd1DML1dC9PGMQc1I+A8mJxbe2uLJgcGwe1A89ljhTdU0J5k0qcRPkseo4i
         O/oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757310355; x=1757915155;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G+fMI7jrlec1AYc5iE/AykLzEwl5evDQP4qBoNzK6d4=;
        b=FeNsEs3VoWkVcpiZk8jnSjuKhbQaAmyz6z0TWSnIHRZuPodaetk/eEaEoisYdIxYdt
         zJDGfQa3bg0AArOIZkF6mJKQzK5sEu2Gz4ztFx738C2eDdc2i4pIjkFGAb2ub6xKBBjW
         yrMUmzf7lQIW9lqk/zMgaQ4lSrN/iuE7Y7CCulJhDv8aJNzdZW04IM66PqUs9Bgy6DJK
         BHm27Q6rXYWDhVDF4zyOkJ6hnVEO1cIAhZobs2uKQDXE9vb1A2AmjXz7GDHBle8maHLr
         Zs7CeZHbNVkCiITX3xrGBI1PkzuQs3bIfpqHBTQ6u9Oea/NM/tWuXhOF4EFr1jaSHU/m
         BukA==
X-Forwarded-Encrypted: i=1; AJvYcCVP/gKYkNKHnElA6HJOHcSfW/rYf/VTE+WT5zTCwSrlphi2LlQARR1sxgjfZ+yh9FI2Ya3u7aD9LNjhCgg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4b5eT4lKpqVl6IEi/Y5BbIsi4GoUbmcWu1jhfQ4sIGtgMn+d1
	N8usrLgRi1NF5f38k1xS1hZYLfXXUNgeGlP/IJXNTbQGY80yoRFmjrWamt4aROEzRbI=
X-Gm-Gg: ASbGnctux3oXtHnGSi4G/jb7JwAu2NhvyO6axIiFCljf0DDLDEIQ45gclk4oA1oZneB
	GNJ913HYqjVH+2MQX7+AMotioJvn4UI3g/rRuTm9QOINB1W87wHL7iwPs1PkS09uMaZqZfOOayB
	fH2xbXZC8bm1baScnMzNjL9YoOWcL/1gTEbTfA+rkRH5OQ3fZU6cafcY5boozDTgzFGka8jwXa2
	tIL3G7Q0y7IpgWUnGj1k5vSNvTrdb4Ww1H4O9IMgTmx+jWPg1LUm3fVOKGYagjGcfKT+Pb6gjxg
	Gp8VSTyDzOJ3bbCRRTuhblnvaHc6wt3AI1HouwUSHrgBFBaznqebvk1nVJJcLjd02QsQjqSn/by
	Pwtk1Ah3p6wZ3vWaY78clrAJZOok=
X-Google-Smtp-Source: AGHT+IFrY+W8Zw7FZwKYzK8IHAxbMi7aFqUaLDdeIhsBhJpxTXZZW2/teY75/VCxA00xqU8hHX5z9g==
X-Received: by 2002:a05:600c:1f90:b0:45b:8f11:8e00 with SMTP id 5b1f17b1804b1-45dddee8f49mr43141705e9.37.1757310354706;
        Sun, 07 Sep 2025 22:45:54 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3e74b2e0511sm1114669f8f.62.2025.09.07.22.45.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Sep 2025 22:45:54 -0700 (PDT)
Date: Mon, 8 Sep 2025 08:45:50 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Yiming Qian <qianym1996@gmail.com>
Cc: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
	gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: sm750fb: fix coding style issues in sm750.h
Message-ID: <aL5tjv_2YkvHPs5C@stanley.mountain>
References: <20250908052133.8888-1-qianym1996@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250908052133.8888-1-qianym1996@gmail.com>

On Mon, Sep 08, 2025 at 01:21:33PM +0800, Yiming Qian wrote:
> This patch addresses several coding style warnings
> reported by checkpatch.pl:
> 
> 1. Replaces CamelCase variable names with snake_case:
>    - dprBase -> dpr_base
>    - dpPortBase -> dp_port_base
> 
> 2. Removes unnecessary use of 'volatile' qualifier
>    from the lynx_share_struct members.
> 
> These changes improve code readability and maintain
> consistency with the kernel coding style guidelines.
> No functional changes are introduced.
> 
> Signed-off-by: Yiming Qian <qianym1996@gmail.com>

You need to split this into "one thing per patch".
[patch 1] remove volatile
[patch 2] rename snake case variables

regards,
dan carpenter



