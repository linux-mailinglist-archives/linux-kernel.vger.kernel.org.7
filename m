Return-Path: <linux-kernel+bounces-899260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6649EC5738A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 12:37:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 342334E5A1B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 11:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6163634678B;
	Thu, 13 Nov 2025 11:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20230601.gappssmtp.com header.i=@cse-iitm-ac-in.20230601.gappssmtp.com header.b="ytC2ch25"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AEBA33F362
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 11:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763033730; cv=none; b=KTf4i5LmSVgO9pyApAIwzOsxbETD2t/I07WXghZenLxT25v/IC/3bUSLtwjmArb/l/q+2jqPeQ3YWPVvTq/RFBLe9+5Dyrn0y+4qe8M7c2EChqb8Jg4ceRxhlscr6x8TVqm+AECbUE7Lw+WF03C0hfJGa9lXtq6XLj2x6Zn1fF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763033730; c=relaxed/simple;
	bh=RLt/g1eKCjH1BEyBQCkqGMQlKMdtXYKQ/D5F5qhGG4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hlrf/PiEw2Xd9Rs29TyClSF/ibj9mIztXWr8BVSZ4nu+pzuP9HnVRlzA0X58XjuWjXgvjLwf2ONng6ApTrnMdB03NdbwigqXaWhh0BS/u+fbEmBjk4L5Bji4/Prg/IoF3v2SJKRtiw1/+nYaAS/SWLYpiU0Ndg5ynuofFESwCr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in; spf=pass smtp.mailfrom=cse.iitm.ac.in; dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20230601.gappssmtp.com header.i=@cse-iitm-ac-in.20230601.gappssmtp.com header.b=ytC2ch25; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cse.iitm.ac.in
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b6329b6e3b0so1351595a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 03:35:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cse-iitm-ac-in.20230601.gappssmtp.com; s=20230601; t=1763033728; x=1763638528; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SKIWHZkw4wzPqvspNYAsUDFqiMYvu0clyWfYDDrRD/c=;
        b=ytC2ch25hHlT5cQh3lDz/+NeYUqvZXCEYYFFMgqSq4hF6ryXBJo5zWtgqH3N/Wmjha
         pD2T67KmbowlsdgLXf/Q8UfLKz9qNdZkEdflxEHfXDXRtq33R7o11/q+AyHCIv+AAzpI
         qBFMMU3cARp8+tjRt/Q19ZWy6kyGgicTHm2vI02lc87HsSXq+7r0/68FAmTGos/ekG64
         wV16yS7Qy8HA8xbgvBIRBzlokuHsWivZUseikM6+x8LwC4A1lSv7FKPFRJdnp26EM1Tb
         cuvwMAT6glEOMdw9pDdluXOhX8pCPkFCatG+KLWEwL8zHGifIMTa+LZYa6OW2FeAAR5s
         GCpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763033728; x=1763638528;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SKIWHZkw4wzPqvspNYAsUDFqiMYvu0clyWfYDDrRD/c=;
        b=rTpF+KrUj8Z0WKTf4yVRZoGmzstYxaVmy+t+Yds1VywcK471X4/mKUGlIMEQCojJ56
         e2bRLBev5rPaE4Fzl0sVlNYLyfjrD8gWv2iyZOdbf5DUZ8NwTKoG6j5xosQS760QKSwk
         stSNdDJKP6gDWz+rhQPIpSi9pJKXByAha7USc1C1igAr2Qt4s8yCoER1VQRmE0LSTGuw
         KMnSadDtfNSZC5jSYmudzvB0vd34tUVxLarwazNBxhUdLMsC4aAcw3oiSOpt1jmQEhu5
         Exi6GpyUDv8J3KwHlYMQeYnRnDlRKmpGlarCgWvWnHg49ehI2yQo5QZmV1QZzDCSfIU+
         SMMw==
X-Forwarded-Encrypted: i=1; AJvYcCUiEd5ix3eu3TboMWSQzdzYF98nE1NwiF+fbH9RoKyDKcRXmlxBSGq/y+wm6wVsqzdqZfvOKahAW8e8KaQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3GMyqiWWO5/Q3LvruAJP35GdhQ/sg6PrIpn/lZN7Pu6Vjdc+o
	YPWw7cNPbiAA+toGma8Z8njkbmk4o7bSlkGkIFXYEeF7XeMFcC+tlnuIhJZFhX5nB9g=
X-Gm-Gg: ASbGnctFngpqpLvs2NpuJJryYfQiiPkR6Vdiwsu2O5B+py8U1QoRXG6PMeyKRHk0jyl
	ImlCN9qQT28UJeoqk/RjerzHf/HRhZsJmRbsPFBDn/8AS8y6gCwFSJc6ApTNCkYPjCe+If8KXdP
	J3j3sWiS1w+Ym496wsgg0mmea5e8ZXwafbal9PnLVYigQU+I/WLpzk+ftsJnSRfJNZH/KfgYpwE
	wkJeZxFZAXOh8Cihi7HMinogv8kSsUspC1SuedNILlt9dd9ixonDGeOYhBcZLLZwFLHRKHl5TnF
	mwrg/cub2Nx+m7+4WVmaIwOm9n6fA1k/f+g7+PGzXwISNqCI0tGjI05BIdwVisX0Eu2SzFeto8v
	ivde+okfEw7oNW/UnEfFCfsHOvFgOQaHME/y7BFoeFvNdtBkrc/Zq5fj2eXWzBh4TFyQ=
X-Google-Smtp-Source: AGHT+IHgSLjAruFqH03QqbLJ0b3qEmlsuf16ZHsrM8o39GRq+nDhJORjJ79qMmtrHznDMAlXFc7tYg==
X-Received: by 2002:a17:903:2c06:b0:295:4d97:84f9 with SMTP id d9443c01a7336-2985a520ce3mr31347875ad.26.1763033727765;
        Thu, 13 Nov 2025 03:35:27 -0800 (PST)
Received: from essd ([103.158.43.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c245007sm22755875ad.31.2025.11.13.03.35.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 03:35:27 -0800 (PST)
Date: Thu, 13 Nov 2025 17:05:19 +0530
From: Abdun Nihaal <nihaal@cse.iitm.ac.in>
To: Cezary Rojewski <cezary.rojewski@intel.com>
Cc: liam.r.girdwood@linux.intel.com, peter.ujfalusi@linux.intel.com, 
	yung-chuan.liao@linux.intel.com, ranjani.sridharan@linux.intel.com, kai.vehmanen@linux.intel.com, 
	pierre-louis.bossart@linux.dev, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, 
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: intel: avs: Fix potential memory leak in
 avs_pci_probe()
Message-ID: <ryt5qoanum7x4ylmnx7plhmuykp5xxu7m53xwrg336hqfr2kfx@ol7pq2m5px2n>
References: <20251113104121.79484-1-nihaal@cse.iitm.ac.in>
 <18c161e8-974b-4a4c-9ef2-c2cacef481b5@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <18c161e8-974b-4a4c-9ef2-c2cacef481b5@intel.com>

On Thu, Nov 13, 2025 at 12:14:30PM +0100, Cezary Rojewski wrote:
> I'd suggest to be strict, no need for lengthy message when addressing simple
> problem. Your title already answers _what_?, the message shall answer
> _why_?. Example:
> 
> snd_hdac_ext_bus_get_ml_capabilities() may fail when allocating LINK
> resources.

Sure, I'll shorten the commit message.

> > Compile tested only. Issue found using static analysis.
> 
> Well, it's good to do at least a simple functional test before sending, see
> below.

I don't have the hardware to test it.

> >   	snd_hdac_ext_stream_free_all(bus);
> >   err_init_streams:
> > +	snd_hdac_ext_link_free_all(bus);
> > +err_ml_capabilities:
> 
> Don't believe that's correct. -ENOMEM may be returned when allocating
> resources for an entry N>0. Skipping snd_hdac_ext_link_free_all() may leave
> things at status quo - memory leak.
> 
> >   	iounmap(adev->dsp_ba);

Yes, I missed that. Will fix it and send a v2 patch.
Thanks for reviewing.

Regards,
Nihaal

