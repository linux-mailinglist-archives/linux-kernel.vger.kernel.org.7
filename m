Return-Path: <linux-kernel+bounces-876906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D5FDC1CB4B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 19:11:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A38B84E21D3
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 18:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D04E33557F3;
	Wed, 29 Oct 2025 18:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PV/xve4K"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7016E30F804
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 18:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761761450; cv=none; b=dZHEWL9xpWfJLAzY6pC2sOEiPEl8pcQMWhXUXLJspCQAZFSUrKOIpQQjoB2jq4Tk/BfTZYbbn9a+Kaov9EqP/WjCwsl6rVnwnZEvBqmPtNgYZ7SbdtJV3dDTqR53pGhQXAZ76ayrQEZ7Xkt0sul0fjZeSRlcyBQMzH10uRn6CXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761761450; c=relaxed/simple;
	bh=T1dDe4fF+Gy9LcvzjbTF78eafwB4w168lpzpr6gvaC4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dqX9jachUfyLtbFj+EXZvESnni179baW9FDKh7bEu4wQQvlzHgqNJwLs4Bufv4ihmQm+rzxs77CLZHovrSpm8zsqQfoYjdM3ywc8yTx0j7N1TXl6gMwLgln7Rp1gawZx/zvqB1k2JFJ/ZEtYmF3b0ii7NsTsVc42eS5nR2hHcyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PV/xve4K; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7a27c67cdc4so203773b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 11:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761761448; x=1762366248; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=agJFytMuXaOzzx9eJ7GjTw67SZ3daSqUTCtci+2uLtM=;
        b=PV/xve4Kv2VqBQFNxT6v5eWFw3bNkdIZBKjd/Ds0PBuIsQT+dy17EquEg+gKCLjbXa
         upFlDcG+SgpKbjCk98yUcfCOuUu19aGOovAg/obPTv+hzaRZfkaCbl9sXoM0QxKLq3d1
         hfC8Sb0NYBZPNBLCeU+IMTM8jPpxl8ks6qzYq6PmpWXFrB1xfbq86tHM8WsvyCePS6SB
         1PZ/xwURPDQKT+A1xUnUQ68MgNYvmCbqpmWF4S54Aunb71Gr0bzlNtyI5NXNrRyQHtmZ
         USZOoya9ppLX+A3DD4U9AmjtRrWToHpyMzQLusnJoqyBQbsktX3xoQuMTlXW+aqhcCjS
         6oiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761761448; x=1762366248;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=agJFytMuXaOzzx9eJ7GjTw67SZ3daSqUTCtci+2uLtM=;
        b=w/OlocbIrfLHcsn583fo1UMpdUBKbQ08fmZi571DB72I8DIwxGf3D5xR8P4sTf4Tjg
         VQNKViEu/xIHUIGmLxPqjWQnXgPRoInCosPkuD7coI3u8hfrS3SW8bWXGiiMFDZvd1oH
         g3N3+R0+Oz/++wAx8kH/DfdVTJoOSsCOQiyqMp79G2Cn9Jgyjyw9bIJOeUdaGrahxWz1
         IzfMy0g+0HdgQBdSe1rNr6WBYkcc+wxi0gcQo0k0zIw+AQusc+2egt+cVdct8Zy+m/dq
         dB/CRj9+krYLaVRQQeqnbvtf5kP6Ae8tma8N1waxlfcnlvEOwGwoG01Ls2a9XkIYKoEz
         UwTw==
X-Forwarded-Encrypted: i=1; AJvYcCWD1lqKzeIlD72B8axXmw+J1zN6yr+0MRChRgoGbcxf4UGYUmMTPxtHVOOMNA0d9WSUMc3kd2kwR4zOJ+c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsAtv3bL5YDfsw4fmX/Qq556wZstgWYOLcBTLlvg8hOiWAr8ty
	jBwcO/+V9IEadbsV7ICV0cOdrTmBVRiqBErBsCiHS28dSG9cC8kG2H34
X-Gm-Gg: ASbGncuuELpojGUJ4FBiYm5/JWMs7fAwHa0XqOFjtYM6nxc1cxlwgMRWZ1zX+v+SrVY
	OfjrDOawOkb0XFn0BOHg9yEKMUqMi7/0pnJBRBiBmLYwPOaLuPYTVDamxeZhjqpnU2zHrim6IOO
	zJgjOYUWMabL8Dzhkz3Z7ctLRrK3YndyLokCOV2eSS/Gs0FVltND1KXnUuCPPUjetjKPDYLQyAE
	ztHcZCK8p48D2aWJill+HCI+G+zbNYETnZ/AjOQ44QwpT3DVb/KzG7zm8ku0r2sOMaeKiBfDcxQ
	8IxcRy8K8HGIy8LKW1MNmmcBSXIEiMrr+kMiojtuWFF6DS2gJ8OTPT64bDk4TXoJGWMFv3AyyGo
	L+bIDwfEE2hrzkKMfrFLxgHyHMqhTJx8rpcXsnbhtKEeyG9gLMaqwVphJA+w9UlnH/wNJNsOkgz
	p3RGNr+MppPA==
X-Google-Smtp-Source: AGHT+IHmC5Yrl54xcDnexWsIAzQgtJ1USAgaMzHIOfEboyM5+j4bp63GVlKTN5o/1wavfr3co1WYBw==
X-Received: by 2002:a05:6a20:3ca5:b0:33e:6885:2bb6 with SMTP id adf61e73a8af0-3478580e749mr390734637.23.1761761447662;
        Wed, 29 Oct 2025 11:10:47 -0700 (PDT)
Received: from localhost ([2804:30c:1653:6900:3b53:af9d:48d6:f107])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-b7128884e0asm14495232a12.16.2025.10.29.11.10.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 11:10:46 -0700 (PDT)
Date: Wed, 29 Oct 2025 15:11:57 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, michael.hennerich@analog.com,
	nuno.sa@analog.com, eblanc@baylibre.com, dlechner@baylibre.com,
	andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, corbet@lwn.net
Subject: Re: [PATCH v6 8/8] iio: adc: ad4030: Support common-mode channels
 with SPI offloading
Message-ID: <aQJY7XizVWbE68ll@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1760984107.git.marcelo.schmitt@analog.com>
 <3fadbf22973098c4be9e5f0edd8c22b8b9b18ca6.1760984107.git.marcelo.schmitt@analog.com>
 <20251027140423.61d96e88@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251027140423.61d96e88@jic23-huawei>

On 10/27, Jonathan Cameron wrote:
> On Mon, 20 Oct 2025 16:15:39 -0300
> Marcelo Schmitt <marcelo.schmitt@analog.com> wrote:
> 
> > AD4030 and similar devices can read common-mode voltage together with
> > ADC sample data. When enabled, common-mode voltage data is provided in a
> > separate IIO channel since it measures something other than the primary
> > ADC input signal and requires separate scaling to convert to voltage
> > units. The initial SPI offload support patch for AD4030 only provided
> > differential channels. Now, extend the AD4030 driver to also provide
> > common-mode IIO channels when setup with SPI offloading capability.
> > 
> > Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> > ---
> > New patch.
> > I hope this works for ADCs with two channels. It's not clear if works as
> > expected with current HDL and single-channel ADCs (like ADAQ4216).
> > 
> > The ad4630_fmc HDL project was designed for ADCs with two channels and
> > always streams two data channels to DMA (even when the ADC has only one
> > physical channel). Though, if the ADC has only one physical channel, the
> > data that would come from the second ADC channel comes in as noise and
> > would have to be discarded. Because of that, when using single-channel
> > ADCs, the ADC driver would need to use a special DMA buffer to filter out
> > half of the data that reaches DMA memory. With that, the ADC sample data
> > could be delivered to user space without any noise being added to the IIO
> > buffer. I have implemented a prototype of such specialized buffer
> > (industrialio-buffer-dmaengine-filtered), but it is awful and only worked
> > with CONFIG_IIO_DMA_BUF_MMAP_LEGACY (only present in ADI Linux tree). Usual
> > differential channel data is also affected by the extra 0xFFFFFFFF data
> > pushed to DMA. Though, for the differential channel, it's easier to see it
> > shall work for two-channel ADCs (the sine wave appears "filled" in
> > iio-oscilloscope).
> > 
> > So, I sign this, but don't guarantee it to work.
> 
> So what's the path to resolve this?  Waiting on HDL changes or not support
> those devices until we have a clean solution?

Waiting for HDL to get updated I'd say.

> 
> Also, just to check, is this only an issue with the additional stuff this
> patch adds or do we have a problem with SPI offload in general (+ this
> IP) and those single channel devices?

IMO, one solution would be to update the HDL project for AD4630 and similar ADCs
to not send data from channel 2 to DMA memory when single-channel ADCs are
connected. Another possibility would be to intercept and filter out the extra
data before pushing it to user space. My first attempt of doing that didn't
work out with upstream kernel but I may revisit that.

We could maybe split the driver into two. One for supporting two-channel ADCs
and one for single-channel. Though, we would fall into the same issue when
handling offloaded data for the single-channel driver.

