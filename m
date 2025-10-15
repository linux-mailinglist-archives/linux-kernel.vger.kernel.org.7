Return-Path: <linux-kernel+bounces-855245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B88FBE09A0
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 22:15:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 517123B3167
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 20:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CD2E278E7B;
	Wed, 15 Oct 2025 20:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DTH4KOa/"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 530CC129E6E
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 20:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760559341; cv=none; b=cfcVnHHMwtykIkWbBWUmBR7VjmA02XZIvL7XEr6CkTgTKCVkzU7loK5gln2WVHqmKMw7mi8dxTBkq2vF9+OFMhrPXqlmoipoG/6BNyr2yzhXZay+WrHGUFIJjj2EJJlOgD4uAN9MKWcPNLLFGnMZcZH171GMUFRua5o1R1LovwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760559341; c=relaxed/simple;
	bh=f33sC8KOhgzfcrNG4Qj/bQ/QmwkdFKt6EmZ5R4Q0M7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qK/2JencJ4f5MTB8hVxP3aoAqd1NOhkuk7fg5mimOJh5ZMpWR5jDDgddlps6mPG4T0Seu3IQtcHozPEhG3U+BkS8/IpWSmUK/j+2rMtqyBhawsM99+31mb38Ke/SUxPU1DLq8kDtrvLLWpjwpvi3ATbeLCTEphDR9vkBDcL1iwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DTH4KOa/; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-78af743c232so28964b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 13:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760559338; x=1761164138; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ElqsTIdctQn66pT7wW61kkU/IWdghkzXe7gYLEQptw4=;
        b=DTH4KOa/DDFU/TgfmAH/4o59rAphEnx4hT5pApdwkRRY7B9o6o2249n/mIPaFYUXcU
         Dzi6AGfiOjpqTd4KrR58gIGnZ268Rjz0afQc8yiiEUsPlnTqfJYzDeI2Nim2Zgg1qaiD
         TYoQ/gwN4ytgryo8wm/RvKuiX89sNUx3OHjZmCmoGqXT41LQHjhXDRhX/5aGn4unmssa
         1YjiZ93kWF6H6EQwaBKXf4FYBKlfcI2PQKueTVBlyyDbWLO1Bo8lfL6mpB7jIYcq+Vc+
         s340WzUheOWfxVIQKsJirYDKHGer9HqxCrEjBIXzgBhEpZvB7ni3vGyghIlpNgz1gNKQ
         Zgkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760559338; x=1761164138;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ElqsTIdctQn66pT7wW61kkU/IWdghkzXe7gYLEQptw4=;
        b=d80nkhW+qzqpygCErI6LcsEEic7Vzxxixls+zUtJTv31YBlsALxLp5jULIT4Bvsl8r
         DoW54Xvpvua+2DFivvF+/nmlw6BIRz2OYkwcuLm+ozJ+jdX4ns+ZmpYre5L5z8EDUR1j
         y6nduYeW7rTkmWb47yLAxNROopsGJ2O3DsQGJY4EzfMW0/UlixhBuiMpfvAs12fxXrY8
         klg8Qnvfc1FT6fhtisiZT1+0Wlb0U2We9hMHQ9fKieAEk+Znj2oB7ExVmW/mFjFTShl+
         bCbD4PORTIy+YqA8oOsWt/YSkSNfo0xobPovdCKMKNYRUKiwjosuSGtiZ5ERlWyxSDCe
         lxAQ==
X-Forwarded-Encrypted: i=1; AJvYcCXWoPvfPS20rf9Dy/HGFM8EM8k1p9FcjcqxhP+oouW8F9xWZsfSrMwMIjR1EkXkRn9ZvoKKbaCK7QXTGco=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvXveoKJR2zkT7jXhfO3XcPGuEw6CjsI2Cd8PnqACaG0TONT1K
	23kWtHkJnZRVLIsxnmXvyK+lrAPkkk4m8wcX728x6z9lKark2bMYHCdn
X-Gm-Gg: ASbGncuTZ4Qtz9kJ79oZIkFEmwP5KF5wKAVHDJrzoGR2Pm19UJMipzFnKlqBT3DG7+X
	pttx+tsvI7OltVicgfhi7j9xM64uQEHAy7f/F84g9iYcjJpjmPtWoZiFUaR4tATgMdNPI4NuyB0
	XlHKLe/ekvfNyZ22RIG+1gHmlxTfgerlZY0bbw0xjZltND4SX6KdKkLayRfSgaJm7JjbDpUyzTR
	l68UL9s3Yi6LeJy1PgLxx1XpeyZYnaw3ZVHqkXUj0UI3pyAEXyQvfDzoG/+iqXyJWwxTz8rhrCc
	RQ/Ip3Oz1Y863VqVejW3iIekPgSZm16onJ7CROB4pJd9r/nx4J/prSsPWoWWxB3/iG/X3fxso/0
	dcAa9Tn8qGu3kLrpTmNeomgYOo0bRXR7tZ2ytTU6UMX/tA+j2+pucxP5FckfUnthkMN1fLlAF5s
	r8RrChj/CFSq0XI3g3E9tj
X-Google-Smtp-Source: AGHT+IG4uNV20f7gDW9o0Gz7678vJFvvBZRhbd7tYd24sy95B2AzjYbBxmFfDzt3FdOHxVCYDasAlA==
X-Received: by 2002:a05:6a00:4b8b:b0:79a:fd01:dfa9 with SMTP id d2e1a72fcca58-79afd01f231mr16240519b3a.6.1760559338302;
        Wed, 15 Oct 2025 13:15:38 -0700 (PDT)
Received: from localhost ([2804:30c:402b:1a00:ec78:db53:a246:207a])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-7992b06075fsm20183211b3a.17.2025.10.15.13.15.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 13:15:36 -0700 (PDT)
Date: Wed, 15 Oct 2025 17:16:40 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Michael Hennerich <michael.hennerich@analog.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	Sean Anderson <sean.anderson@linux.dev>, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/6] spi: Support multi-bus controllers
Message-ID: <aPABKMoIbpMhOzxt@debian-BULLSEYE-live-builder-AMD64>
References: <20251014-spi-add-multi-bus-support-v1-0-2098c12d6f5f@baylibre.com>
 <20251014-spi-add-multi-bus-support-v1-2-2098c12d6f5f@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251014-spi-add-multi-bus-support-v1-2-2098c12d6f5f@baylibre.com>

On 10/14, David Lechner wrote:
> Add support for SPI controllers with multiple physical SPI data buses.
> (A data bus in this context means lines connected to a serializer, so a
> controller with two data buses would have two serializers in a single
> controller).
> 
> This is common in the type of controller that can be used with parallel
> flash memories, but can be used for general purpose SPI as well.
> 
> To indicate support, a controller just needs to set ctlr->num_data_bus
> to something greater than 1. Peripherals indicate which bus they are
> connected to via device tree (ACPI support can be added if needed).
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
LGTM

Acked-by: Marcelo Schmitt <marcelo.schmitt@analog.com>

