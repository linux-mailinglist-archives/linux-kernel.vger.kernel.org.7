Return-Path: <linux-kernel+bounces-781071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74992B30D12
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 05:56:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30C31AC57E8
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 03:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FA6F286893;
	Fri, 22 Aug 2025 03:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kerneltoast.com header.i=@kerneltoast.com header.b="lFuSKbJo"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A770E393DE2
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 03:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755834971; cv=none; b=S2jriOl5y+LUzQTcvJMf+gXLl6HpIjCDJ+W7iuwqnA4LpCPE7ql/SFKFHOf7SAl96NpVGKI+tMh3pH4REuj6+k+f0J8r7E7T7+8ZY4Xp36/lf1nBhLHsRXb/4EFw/jUoqPxxf5jVsy2YLCblnKVOZt+TdSSpj7kgLN1nGLQjo6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755834971; c=relaxed/simple;
	bh=5p4ROGVZNnB4rzZq4BAPq4K/FmfzDbjHgmLIiCLca+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qfN+cW2gqnmb0H7JROgkyLQ5h0uGcd+x+Xg7gT+0vkrfOXFWakmCysUprbemSrhzTgzxvOwTbA/Y/yNPwoWR2Ig29L0+lm75Eu3M5guf4qRkoReQ7BdHr2OvCDnew05FOU/ydc1bsQZKLDKskilJzuE6pWCAeqqU4jaNQnDl55o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kerneltoast.com; spf=pass smtp.mailfrom=kerneltoast.com; dkim=pass (2048-bit key) header.d=kerneltoast.com header.i=@kerneltoast.com header.b=lFuSKbJo; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kerneltoast.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kerneltoast.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-76e1fc69f86so2053401b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 20:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kerneltoast.com; s=google; t=1755834969; x=1756439769; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6qpBz+mUG/W7+SuXK7yES9yGHSsanCxGvvT/MesdcNk=;
        b=lFuSKbJo/XTuRWdDvk17feV1nL6H30OZ9W+LjPt/W+GxXFAQtpBtCJwpqTHX6JrocK
         rOzkNIzLJpCqVK068yGfDoOLmywLwA5FRreeZZv6oplnvzJkLZNSaR7X3zUaHSkh6u/e
         n+X645V5Jw9b7qLglJ4bYW9NTrHfsd209YtNfTuOX1S3zAPVimi/XkgbzQgc0r71zZFa
         2RJFVdB3GjRKGWs84FiHXjAOgqkbkaG1V3gO9VvHuqw+e7xk3YWsG88K7R4aekkHYH3o
         SlFNlQh9jFlorTbzaEdBzZxQR7WGfDdzwCPtCynsqE3PfJDCqp6BFYXbv3CJ8idj11wi
         E+fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755834969; x=1756439769;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6qpBz+mUG/W7+SuXK7yES9yGHSsanCxGvvT/MesdcNk=;
        b=d1dUzndVMaExOU6PAgvYwi5CPaiJYvxzxLbcpEFOPgSvYbnP9gNgBLTFzKcZIbwOXV
         51RY7wvD83EhOUczqcLnZD+xgWvXxfwbD7ipCtoWFR5bB5BzLgEVW4f4yNJKCqoTDis1
         /33Nb/1FUeMSvkU7cHLtSS6zhBuhZoS/xNs7ZdsWs71vYIdM/gBFzlIO/O4NOZNXcWn0
         kXa0UHkePmhbxXmVdHI0VlXCLYi6mbnTnPbMe7/+VTQ5yhE2yQUZ0MWOjGh3xwDvEt3C
         VmUo0yf/2eXAUP/G2OrFFMEqx2tIfkiEeyMATNenBVBMkqArsAuEuK/bp0RjVCjLxYF+
         QXdA==
X-Forwarded-Encrypted: i=1; AJvYcCUsSX564rENY+03XLsTJVwKAqoe09u26UDv5+MKR1pXE/ekXFN0FXPlxj9/c4hDdctzBUaqlM2d0jLSYZE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRFWZ9fFIvdBgWz2Z7zgFW+9y+vPPCHEtGXcYsYeGjUoMR+zl4
	LD9F+kVuk5K1hsSs7J7GU1/lwPJ14bpsUGaHNsSBw5LiUayd74CN7E+dKJ8Z+rcVmzXV
X-Gm-Gg: ASbGncsrGIuRAwvYkSnqR6B/7E2oNJWhm3BmL8STzMcQ1tKAmPH3IVbmshHV5ERSEYd
	qLvShVzVbNlAIHYC0z8sdBLjj6COklVPVRDX5sHlHrbGT4arr2GmJPqtE0EW7Cv+jJBF6BFGGD9
	jHOZxe5eoEB0ll4a5O3dxxe1hM5LT4ovFeJhN1Fi2D7SoLxmWdUT7YB2lgI2m/Jzhj8humgpis/
	5qDaJ5TAJ/PNt1VEi9OzPkS4QTBlh0fsKmML+j16Rmx7HfShLs7qvvcq/FYkywKBv9XlH7UYPKk
	7uy3yIicH0H59DLuC6gMthUwQf8QKuToX1jWO1w3UOv39EVUAqOvYYC8dImf+34UWhX51BsLTKz
	WGzjYd6eBOIebNfVo7mg0LnTcyQ==
X-Google-Smtp-Source: AGHT+IHf6Ntu1u45GJaKvFGYSzxs1o9GISkf1oG3NJOqQEEeoFqWuMAdBjEKefriWui4az6AIEE7kQ==
X-Received: by 2002:a05:6a20:3c89:b0:240:792:e87a with SMTP id adf61e73a8af0-24340b581f6mr1987029637.3.1755834968873;
        Thu, 21 Aug 2025 20:56:08 -0700 (PDT)
Received: from sultan-box ([142.147.89.218])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4763fbe626sm5973542a12.6.2025.08.21.20.56.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 20:56:08 -0700 (PDT)
Date: Thu, 21 Aug 2025 20:56:04 -0700
From: Sultan Alsawaf <sultan@kerneltoast.com>
To: "Du, Bin" <bin.du@amd.com>
Cc: mchehab@kernel.org, hverkuil@xs4all.nl,
	laurent.pinchart+renesas@ideasonboard.com,
	bryan.odonoghue@linaro.org, sakari.ailus@linux.intel.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
	pratap.nirujogi@amd.com, benjamin.chan@amd.com, king.li@amd.com,
	gjorgji.rosikopulos@amd.com, Phil.Jawich@amd.com,
	Dominic.Antony@amd.com,
	Mario Limonciello <mario.limonciello@amd.com>, Richard.Gong@amd.com,
	anson.tsao@amd.com
Subject: Re: [PATCH v2 0/8] Add AMD ISP4 driver
Message-ID: <aKfqVNk_WSEeBxlz@sultan-box>
References: <20250618091959.68293-1-Bin.Du@amd.com>
 <aJ2H6CIyZvN8W2sS@sultan-box>
 <ed9deffd-296c-465b-ad8a-314ed0968390@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed9deffd-296c-465b-ad8a-314ed0968390@amd.com>

On Fri, Aug 22, 2025 at 10:23:48AM +0800, Du, Bin wrote:
> On 8/14/2025 2:53 PM, Sultan Alsawaf wrote:
> > On Wed, Jun 18, 2025 at 05:19:51PM +0800, Bin Du wrote:
> > > AMD ISP4 Key features:
> > > - Processes bayer raw data from the connected sensor and output them to different YUV formats
> > > - Downscale input image to different output image resolution
> > > - Pipeline to do image processing on the input image including demosaic, denoise, 3A, etc
> > 
> > BTW, another problem I have which I would love some help with: may I get the FW
> > commands for setting basic 3A parameters?
> > 
> > It seems like the default AE mode does frame-averaging, which is really
> > unsuitable for video calls on the webcam. My face is really underexposed as a
> > result during the daytime because there's a lot of ambient light in the
> > background.
> > 
> > The webcam on this laptop also has a very wide field of view, which makes my
> > face appear small and shows too much of the background. This also exacerbates
> > the AE problem.
> > 
> > I'm thinking CMD_ID_SET_ZOOM would fix the FOV problem, and then either
> > CMD_ID_AE_SET_MODE to change the AE mode or CMD_ID_AE_SET_REGION to set the AE
> > ROI would fix the exposure problem. What do you think?
> > 
> > Thanks,
> > Sultan
>
> Thanks Sultan for the suggestion, sorry for the late response because we
> spent some time internally to discuss the feasibility.

Thanks for looking into this!

> Yes, it's really good suggestion. Because current V4l2 doesn't have standard
> ioctl for like region setting, to support it, besides adding FW command, new
> customized ioctl also needs be added and no existing APP can benefit from
> it. So our idea is not to add them to our current upstream driver, but we
> would be really glad to help you to enable them locally with dedicated
> thread, suppose it can help to improve the IQ with correct input setting
> like the correct ROI region, but we aren't sure because we didn't do that
> before on Linux and would really expect your test result and feedback.

I'm happy to help develop this and even help write the code. :)

I think a lot of useful functionality can be put upstream just through V4L2,
like V4L2_CID_EXPOSURE_METERING to control the AE mode.

For advanced functions that don't have a standard V4L2 control, maybe we can set
some defaults in the driver to improve the experience for front-facing cameras,
i.e. webcams.

Depending on the features exposed by FW, maybe setting a ROI for AE isn't
necessary. Is it possible for the FW to do face detection and set 3A according
to the face landmarks/ROI?

Thanks,
Sultan

