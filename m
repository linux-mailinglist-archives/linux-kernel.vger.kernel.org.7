Return-Path: <linux-kernel+bounces-750014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5455B155E7
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 01:22:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A13B7ADCBB
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 23:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A128286413;
	Tue, 29 Jul 2025 23:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="coHoJOXW"
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 343A92AE66
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 23:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753831366; cv=none; b=hQueu8Rztn3KBLqRtWqWjRX9J8Xn9GG6XRRm23cCVFY6zjcHcGVKCEWnn2dmW4En/8P+pygxug5Wl6IdSXMa09Mn/Ynphs3B6u6jxT942W3GS243La3ZnnBf98+ckyFf5QjarEOW0BaNxDYdjU+CIZY67XE1VgXjjrxJN8rYe3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753831366; c=relaxed/simple;
	bh=5+SxyYSHlUovT7nMO8KUUry70XX33hvq1YMeYnlBo24=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WBS/GNjaJVY/G7ZqBUlx+UYZNgKqdf5VTi6vQfGViAws9nUvfqnU5IIJTeYtTXOSXbsaYDsPK0G25oqNyK9x7YczxEIpUcrMxIebJ0G9WkTWNz6LC/0tq9nsjUiruYT63hKcs0PolhcARXWy4wgpIo23AzQEECfc3O2SBOz//LQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=coHoJOXW; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4ab61ecc1e8so48927871cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 16:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1753831364; x=1754436164; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=evOEy7fuRGdGypQDmd9QZXrLo8EABIsGfXRQCCvlWq8=;
        b=coHoJOXWAP9YmFUnuG+hSl/2tzfR1NsSPLc6VTr6Hel3vE896TjetO0zgl4vKS9pCI
         srDt5dotyXfW/EFBmiN7hLMOCZUBKxiUXcnulS/fHP+rPQt383WtK+oi1RO8W6fCDD5W
         7DXCRRpM/7ywfGIrGiTGZ615Ztle3BT901Donf57f3h2SsJ/KlzqsyNAalm+KwDbcDP/
         OWsFbCgqTZaFofNMX6yMuLcpnzV497HOHt0EvOP7xoA4tFpdxV30NDMdvJ59eSVtEgh4
         cpolx7hZWY9JJilDc3/5JnaKEwHkoGzdmCLVpJInpZLOZROpGbQ+gFK7i+HNyC6g0/mn
         rYXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753831364; x=1754436164;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=evOEy7fuRGdGypQDmd9QZXrLo8EABIsGfXRQCCvlWq8=;
        b=xOxWDA2/PgG9Xg2pElFEvIirKy/A3OQoxGdY35mniKzX4zV1MehcIw2ivP4gyI/lV+
         yFSthylwGKjsL22EMaU7Me1F2Xkp17TalqdrnfD9OmMVbchECc++/4lg+o1o5sdl6cjy
         yIrG7Xi3ifaz7mAxG/mcic54/JB/5ZT3QSG2A/FcKdyTZKcoCAvhtpcU2YxF7nHN+Nwt
         /lCv3SbyO62oDuk6aM/RtMB50rtgI1gqIqVlRdlPaTU2JfwzIhdO7axAu+TYkiqCB20e
         708pPrqoC5oWAWLdxrDOAUQ5ckLggE50gws7t/3aKvQVvPTLNxt+UWLA8hYQVFBO5Nz3
         HBmg==
X-Forwarded-Encrypted: i=1; AJvYcCWjE+Sxj/Fqp3YDFf6p3kYKYF2nsJfd1pVP8+eah9MSKQNd+J/7CDkTgQ4uKRQXh1fbM4Mv73KaxkGE3xI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWm9L5Y8gNINuVYTKuzP2l3rEX2SNZvQOWY7FEdV8jjVSFKPPG
	E6o6KvA+wakWFl+lvwr3R/M/+R+ZOBfYssHLK5ZA6ZozXOHeXxgSRVV8J+MDDxHYLtY=
X-Gm-Gg: ASbGncv4QEjbJxMcf66yML0BLScnCHI2O28xgI+u+a2R8hcwxZo7n/3YInGfYzAJrB7
	hdXMxATXiu51uRzj4fC/QHcCcnt5CR3c0nBijeXSrsHbQ4tQ9FFHKEq8pTIuNDFAlriaT2YvRzK
	qpX8nEjpvmBgkS/1X8cu5W0g1tI/c+eevTvhRTaWLC/ipuivKONTxUU+qF3BcvovEUwJvjkRD/q
	ESQVk6P8zGOusvbNWF2EYQMbUK3EgVeBRWyAe1GEWvXzD1FbXrIuPDIUt34ZncFv3YYUgdXMS8Q
	FMmyU5NIwyuMuMlmftapnTNjBVuHJ78L23q74lFrepU/QXXovksWB40jLhVJAUFi9gIKPPP5aGA
	arWZXu2io2wa8icQe5OF5orHAZTAyHFYIQa2XMlzJa1712OBRKftYLacvSP4kQ0pFzSV45yfQHk
	B10OE=
X-Google-Smtp-Source: AGHT+IEp29JmYKPTEUTfX9T0WcQPt09uHVFFYXFI1jbMPkfOwjEBLhDqzXpFec1njO1HN+oSVaPRoQ==
X-Received: by 2002:a05:622a:8f:b0:4ab:95a7:71d7 with SMTP id d75a77b69052e-4aedbc7919dmr24915231cf.53.1753831364093;
        Tue, 29 Jul 2025 16:22:44 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ae9951a6casm56688261cf.13.2025.07.29.16.22.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jul 2025 16:22:43 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1ugted-00000000MjD-0XUr;
	Tue, 29 Jul 2025 20:22:43 -0300
Date: Tue, 29 Jul 2025 20:22:43 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	linux-coco@lists.linux.dev, kvmarm@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	aik@amd.com, lukas@wunner.de, Samuel Ortiz <sameo@rivosinc.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Steven Price <steven.price@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>
Subject: Re: [RFC PATCH v1 12/38] coco: host: arm64: CCA host platform device
 driver
Message-ID: <20250729232243.GK26511@ziepe.ca>
References: <20250728135216.48084-1-aneesh.kumar@kernel.org>
 <20250728135216.48084-13-aneesh.kumar@kernel.org>
 <20250729182244.00002f4f@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250729182244.00002f4f@huawei.com>

On Tue, Jul 29, 2025 at 06:22:44PM +0100, Jonathan Cameron wrote:
> > +}
> 
> > +static void cca_tsm_remove(void *tsm_core)
> > +{
> > +	tsm_unregister(tsm_core);
> > +}
> > +
> > +static int cca_tsm_probe(struct platform_device *pdev)
> > +{
> > +	struct tsm_core_dev *tsm_core;
> > +
> > +	tsm_core = tsm_register(&pdev->dev, NULL, &cca_pci_ops);
> > +	if (IS_ERR(tsm_core))
> > +		return PTR_ERR(tsm_core);
> > +
> > +	return devm_add_action_or_reset(&pdev->dev, cca_tsm_remove, tsm_core);
> 
> So this makes two with the one in Dan's test code. 
> devm_tsm_register() seems to be a useful generic thing to add (implementation
> being exactly what you have here.

Pelase no, this is insane, you have a probed driver with a
probe/remove function pairing already. Why on earth would you use devm
just to call a remove function :(

Just put tsm_unregister() in the normal driver remove like it is
supposed to be done and use the drvdata to pass the tsm_core_dev
pointer. It is easy and normal, look at fwctl for a very simple
example.

devm is useful to solve complex things, these trivial things should be
done normally..

Jason

