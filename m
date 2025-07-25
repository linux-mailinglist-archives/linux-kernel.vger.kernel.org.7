Return-Path: <linux-kernel+bounces-745163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6E5CB115E7
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 03:36:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD850AA4AF3
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 01:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 710721FCF7C;
	Fri, 25 Jul 2025 01:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kerneltoast.com header.i=@kerneltoast.com header.b="Hvsmd8lv"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F59416CD33
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 01:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753407361; cv=none; b=H378wZoVkesMt9G9Zi3YJJ3ojyylfJOqPmJKWQXLuGlyUYsuZm489tjD1fLnROQoEconthyB9MW1ae/JLjR3Dt/mPBeV9aG1M2t1GsCY/OabWl/Wo+1WZGB+RzudOU8wqeLI3xUWCCtSHGh2O34E3o0d+45tbVeqPDCQgB/e0xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753407361; c=relaxed/simple;
	bh=+3pLCZ4SMur/eeBu3d6qYxeNxPFr8TFUr5342JtNzXk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qLRdbywoXIGDnYv9JH10cM5yQOrXjKe8p+p1nLErKzkK+JmKnPB20ttl41JLja3X8JkkSp69eK684+ayB4qcaUyhvJvcVD/JZAuaintD1+lBVZoDZvet1bOIF3RcD+5mAQCp0dPcR15ZfLjOzxTYie7BIxGWpmlyckNtON8gAfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kerneltoast.com; spf=pass smtp.mailfrom=kerneltoast.com; dkim=pass (2048-bit key) header.d=kerneltoast.com header.i=@kerneltoast.com header.b=Hvsmd8lv; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kerneltoast.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kerneltoast.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7600271f3e9so1444900b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 18:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kerneltoast.com; s=google; t=1753407359; x=1754012159; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LMeSZT/xp8mSZTumn41Z33GAONrSp2+tqVJkfIWyd60=;
        b=Hvsmd8lvY7wfv3doUmYISwn/zCv7pJ5+9d77cP4k/SXxX1bkLoh62NrtMJOQVAMCI8
         tQzs7WJOmALUWWbAsmZwOj6MPFiEN5y4IVbYFty4WWssOf04vDGHViWT9njKAAieGc12
         t4xVWmcNutUsiX54QUY6O+8wY0hnti10CXE1l789OgQ5eFKit1NC7RZsSq+yqr/Lfexq
         zkLAmNsQYTFCPIQ7s5HWwdvUa4Lu2FPSo31TRon9jbkdTP0qcVpIvCkyWtBDrpCeU3Zh
         CqTO3ogcN9F5Pg/Ur8lro6pW4JPT474W0g8l0BeY3Ps+1WyWfOdT2scjLuIHWPHN0t5N
         0n4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753407359; x=1754012159;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LMeSZT/xp8mSZTumn41Z33GAONrSp2+tqVJkfIWyd60=;
        b=s2Uf3vJzltZoUiDyna+7+RZLWkBq55m+dDiJRDvmMvgbaN2UAx7wlaAS+Nwjkv/O4B
         Sxfjz8M2+3vOp4ZsLPhv5CCWls9XY8nvkhSK88ZV69ozsdg779hc85IfQ1YKDDp3MbcE
         0Rr1gMI5bJdAqaBBcV4fGnVrDdfvlnXrT0Jan5b1khLNZTHpfmwCBkeKytBWnR00d25Q
         +aCNaKcNkfKlOjgTJtwGivuHTlpawx6lio0qgPbNnqXUIsLATHUcBf9q78XYljuhfg6B
         wmaWqdAycbi21DLGu3IxJzlxc3AgICntxhYLiyb1fJK/FRfiYf43A3OYTlXZAjf+4PX1
         30lQ==
X-Forwarded-Encrypted: i=1; AJvYcCXaCFFRGrk3ptYbOEofnn7ipbHMkPz+xHrZnWtUGctrrQLYacocTP4LrBdY20GPfPXpS5VL7NtRGguP4g4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeRbeTtb+w9A8F+H9vIBQUVXJI3n8iZI3+UbA0H9ufnDwVbqHT
	bNSok+8Hp9c3MRCCYb0WRjyGVkFqBPOJZif6szrIJ+Dt941wiRyasIvBrtW0EBm+l46H
X-Gm-Gg: ASbGncvfMq6Mc6wXg7BgCeIgcrxfRmjmRI56s/UOd9Zxhrw2CcUQmY6KxiPEhXCgEoV
	hMxlalfT+sKB44bLsF5P7BXMbfPB7YOcMt0HgI4BlBZo6LS3XjdFtKBGgsWpVQ1JqCzAd+k9gFV
	p0hS2avJ2K1GQkMKdgRC1WsHPoTiPVOvf5VeeR3aXBIPenSEVLKxEcEgyQELwZ4RhX3rF25mxVA
	Fy73lbNlAHb8yPumKefAMCF0pT/88paqqtYn013C1XHQNuRmXxe8fSVJ4IzSDPbkFPOgRq9IJn8
	DYnSFW0fZIvMoeDtloZB5zLRI0iWCpLpT1+7TTR/f5BoOZaWN6T4TTvYggXudPxBotJ+qq5HylJ
	yrAM15XhjbVJ7jLziHU1UL3E=
X-Google-Smtp-Source: AGHT+IFA3tRC9XK23Q+gCAkinzEN10zdeRX2dov6MnJnP0d1hmo0CpjXc6mkrOmcoPi/HBmXhSPCJg==
X-Received: by 2002:a05:6a00:3999:b0:744:a240:fb1b with SMTP id d2e1a72fcca58-7633266fc94mr423305b3a.5.1753407359443;
        Thu, 24 Jul 2025 18:35:59 -0700 (PDT)
Received: from sultan-box ([79.127.217.54])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-761b061a061sm2635297b3a.115.2025.07.24.18.35.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 18:35:58 -0700 (PDT)
Date: Thu, 24 Jul 2025 18:35:55 -0700
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
Subject: Re: [PATCH v2 5/8] media: platform: amd: isp4 subdev and firmware
 loading handling added
Message-ID: <aILfe9qaR49KGkcW@sultan-box>
References: <20250618091959.68293-1-Bin.Du@amd.com>
 <20250618091959.68293-6-Bin.Du@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250618091959.68293-6-Bin.Du@amd.com>

On Wed, Jun 18, 2025 at 05:19:56PM +0800, Bin Du wrote:
> +static int isp4_parse_fwnode_init_async_nf(struct isp4_device *isp_dev)
> +{
> +	struct isp4_subdev *isp_sdev = &isp_dev->isp_sdev;
> +	struct device *dev = &isp_dev->pdev->dev;
> +	struct v4l2_fwnode_endpoint bus_cfg = {
> +		.bus_type = V4L2_MBUS_CSI2_DPHY
> +	};
> +	struct fwnode_handle *remote_ep = NULL;
> +	struct fwnode_handle *local_ep = NULL;

[snip]

> +err_fwnode:
> +	if (remote_ep)
> +		fwnode_handle_put(remote_ep);
> +	if (local_ep)
> +		fwnode_handle_put(remote_ep);

Copy/paste error: the second fwnode_handle_put() should put `local_ep`.

> +
> +	return ret;
> +}

Sultan

