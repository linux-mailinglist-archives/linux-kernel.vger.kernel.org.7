Return-Path: <linux-kernel+bounces-768042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12D6CB25C41
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 08:53:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81FBA7BE207
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 06:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A6C025B692;
	Thu, 14 Aug 2025 06:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kerneltoast.com header.i=@kerneltoast.com header.b="joAau70V"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5778525A659
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 06:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755154414; cv=none; b=aIn43Vrlc9bMC5AcVW5xjPTOCgVr8TcfaPfzc38etWSli2K/jMrdkXQpukj+yuhQa1iF5/B5pjCaNcgrs0iCQrJ5YWi70ovOjF0odM7xoBuBsrRpp7ztTSaAi8d/iMnvzUQ9KW0xZJWFJPmDolmgEvGeaCoEsLcM2yOg+aSSoC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755154414; c=relaxed/simple;
	bh=I2f0Kmwx35GBfduIK/dxSt63Wr2nKS3YOjch7WOFfSY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OtY/NZSRQsIK9Ikx0+RiPefusU5XsXaiAqle1+rx2PaFTj54nLSnnVjBM3l+7lDpAiTfvtipP6UyDnFDrffESc0yK/S518NOv4t3MtkHX/Bi1CXleY3JdCoenwwRykbTUHGiRxGKUE0POafimG5SIqoHxV01gZzqb2tvlZGC6Po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kerneltoast.com; spf=pass smtp.mailfrom=kerneltoast.com; dkim=pass (2048-bit key) header.d=kerneltoast.com header.i=@kerneltoast.com header.b=joAau70V; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kerneltoast.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kerneltoast.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-76e2e8bb2e5so907397b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 23:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kerneltoast.com; s=google; t=1755154412; x=1755759212; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=I2f0Kmwx35GBfduIK/dxSt63Wr2nKS3YOjch7WOFfSY=;
        b=joAau70V52U2kzayZJ1Tqw6OfcCqevVwv1HFFRTDqaSQMrAw7JLU5citRaVT30hySB
         tTzrHohI5wm7+ebRCmoimP7JYoq5psnWV5fbrIp3T20K0J2NTUQ8lJh5IrNVvDjFaB9s
         Q9XmvcYv8sKWi4ZVIx/OANiJYjfw1+jLdAAk3nBcd0JRt+vWdjaNHPAmO6tNXXxRy14p
         8dZuZX7RBNRGst7HUqTNe7A6L1SH9zgY1squQozdEZOnNYHgDACqrK2XYtQ8/D0pY1UN
         Axr6ZZf0zmI/3Eg/fsxUu4+DJjTueNeoj0qxuB3/8xslwbhTMXljxQtrIlsFDm+INDNy
         Wmgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755154412; x=1755759212;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I2f0Kmwx35GBfduIK/dxSt63Wr2nKS3YOjch7WOFfSY=;
        b=fNHuNSs00c9ZLEBV3O70PeXKCJ7MkSOkHcfIHWniGH1rBm5vH92c/nHRTq0u8gFqP6
         cHokVtVHPLXL20i1IszOjvhpMQ2nr44VYW+x9hGkByRZ4tKXhzq3Hzqwn+hC59JeozvI
         6TIkg3e4wI7cbL65c6n20nKgGTN+U2ikVd/mmyD4venqA1Wpu4LWQ6DHfm8+DiBJA0Y0
         AgadnqSf0tSIjeFoO1CoTQrj8lhSsP1NVFPm1ek2WhtSQsj/TfIOLRoz3xeRRJixHN37
         96yCQ/R9361HbjAzN7XIlvlWIYiLKz1PimdSCczkD0HdXIwH6BZdrehbEguHlj5tmCFQ
         Xr+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVqDM3jHrJsOi6eo6yYJOVcCE6XJxcob6/9jQaueIP6yREKMiubCo8kPd15aFwrBFSc3pmHc/9V9i6A7aE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6gMuwVafw/rSRHh4yEhogjoCnKMzDmCK5k+a/+lJjQNC9kKqr
	8+uAc7NipIsyyKXswdwyw5NL0fOGL37qbXFCbh/vl2ncIFzmJnnw76QStZvl94vd5chm
X-Gm-Gg: ASbGnctC15w2wuo+jPas4Q64SSXICcwGorCuT67RwV7jVi19mTGCG01jlLz2TJGA5aD
	JzVDPifF4nlWXl87j03Jym1oxm6QoVccOw4mosbtBNsw6MdaQljMF5WhVLMO4maB7sp7w4qz42M
	xZG2Z+mcYHp3ytwPoBsZ1hNU7c4xF6HZONWW7CuxNmlZfqqLlAQmNMQuuljDlJNJgcCNv4RAOrd
	WFDYDKM9fCPur8Q3UCzcdbwXHRxIrb7cI71lniMZF9Us7SQ4vBwurot9FSkg1EnJU81IskfkVy7
	cuEbCNtFy4Skf/vJukbObSlTq+XLBdUfEoEJmmdPdksJe3Mmw/QXpK/HldI52QU/j9O/njIMykZ
	SXqS52Ndi0zGocP1fW0QJbQ2YlA==
X-Google-Smtp-Source: AGHT+IGvRd33xzKg/pe8y/fTlz3quAUsTO77844G78vPlMhID8A1Z/AcMV21WIDU2QS3X1+7OdOc5A==
X-Received: by 2002:a05:6a20:3ca7:b0:240:2234:6835 with SMTP id adf61e73a8af0-240bd241613mr2844646637.27.1755154412485;
        Wed, 13 Aug 2025 23:53:32 -0700 (PDT)
Received: from sultan-box ([142.147.89.218])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bccfbd656sm33719534b3a.72.2025.08.13.23.53.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 23:53:31 -0700 (PDT)
Date: Wed, 13 Aug 2025 23:53:28 -0700
From: Sultan Alsawaf <sultan@kerneltoast.com>
To: Bin Du <Bin.Du@amd.com>
Cc: mchehab@kernel.org, hverkuil@xs4all.nl,
	laurent.pinchart+renesas@ideasonboard.com,
	bryan.odonoghue@linaro.org, sakari.ailus@linux.intel.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
	pratap.nirujogi@amd.com, benjamin.chan@amd.com, king.li@amd.com,
	gjorgji.rosikopulos@amd.com, Phil.Jawich@amd.com,
	Dominic.Antony@amd.com, Svetoslav.Stoilov@amd.com
Subject: Re: [PATCH v2 0/8] Add AMD ISP4 driver
Message-ID: <aJ2H6CIyZvN8W2sS@sultan-box>
References: <20250618091959.68293-1-Bin.Du@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250618091959.68293-1-Bin.Du@amd.com>

On Wed, Jun 18, 2025 at 05:19:51PM +0800, Bin Du wrote:
> AMD ISP4 Key features:
> - Processes bayer raw data from the connected sensor and output them to different YUV formats
> - Downscale input image to different output image resolution
> - Pipeline to do image processing on the input image including demosaic, denoise, 3A, etc

BTW, another problem I have which I would love some help with: may I get the FW
commands for setting basic 3A parameters?

It seems like the default AE mode does frame-averaging, which is really
unsuitable for video calls on the webcam. My face is really underexposed as a
result during the daytime because there's a lot of ambient light in the
background.

The webcam on this laptop also has a very wide field of view, which makes my
face appear small and shows too much of the background. This also exacerbates
the AE problem.

I'm thinking CMD_ID_SET_ZOOM would fix the FOV problem, and then either
CMD_ID_AE_SET_MODE to change the AE mode or CMD_ID_AE_SET_REGION to set the AE
ROI would fix the exposure problem. What do you think?

Thanks,
Sultan

