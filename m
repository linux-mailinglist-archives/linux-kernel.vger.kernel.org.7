Return-Path: <linux-kernel+bounces-898271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B953BC54B93
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 23:39:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D2D53A39A4
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 22:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A50422E2663;
	Wed, 12 Nov 2025 22:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="dAIRctza"
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB1B262FDD
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 22:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762987022; cv=none; b=SCWY/KpctLPDgC0Mg6YCz9TjS520fO3gg2aCr0eCndPv10ewPIxX7CiKiEEL1RpBnH9mZrp5Vg4WqDoK84gxwtEQJsSD/NB7rrR/jmTLkdRoxlS8pRt6Wb751DkgpYyJEN5gVosjA7P2NOeel7GMEYEPLSLh1gX+EUeKIFRkwgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762987022; c=relaxed/simple;
	bh=LPgsBEvnoEonnFLOfBv5HuddMkcPnZVrPmEkV4l0TSA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GjTroM8rsm+6i3mI4WMKLuGRT/6p18nqeJkkW2hAYaXICdGfDImMnIVikCHGX+8ZHDuYALEOpeOe3hVDXwawEwsgSSeIdwZoqRdsxLij7j2+ZefIkRU78wfOleLDmfwrH0Yzd5zq51QbyIjvIxj6ZU4qsHtPmdA+/D1w/b/7erI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=dAIRctza; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-88f2b29b651so21158985a.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 14:36:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1762987018; x=1763591818; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cMNytqbDI8FzAjDManJ+YKoSJvcJrL+l2+VA087X3a8=;
        b=dAIRctzadCTgkKoFxZKeSSaiOCXQESCDhRTyBVEZzUmwmrjSyIQaXzMdVKy5auGTUT
         FOKAtrbXcPtC1mPBoGD1bFFOVkPSEotwIdcPbjuTu0px8U2k3ozeSXNL+a90M72/E40B
         moUvKwKcQbmpY/wXIMhcU0HuxNqYRIC+6UEzTN40/lVJ7yZjahtzWG/XsKbxc7A3CnIq
         NMFhpRj3MYd8kLAWDa8dzyOchOslIcSaqj8BtoFO/UEvI+1GUxlw/R12DweyHcF5G2JP
         F2DiG1k1Rr6CtXywG+CV4t+sn29zY3KMlxtohSVKyZy3o3obPgLOaOS2hnwpgKC1q1GV
         2v4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762987018; x=1763591818;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cMNytqbDI8FzAjDManJ+YKoSJvcJrL+l2+VA087X3a8=;
        b=DjFEn12lr23sOVcCS4U67NfTeoYX3ckZKlm2PFCsgpgn8WtYmyiJDFk2f7NHp+by0J
         6mfXHuwZx2zmjI6+vL2UtIUTEFZVQpIoyk9z0gNrFrlapx3SXEGxtrg+eEhcBdtX9hgf
         z1ey8n0a8nUg7M66G6uuSI9FSYR7Wbh9fnL3AcqDVZ9vVygGc4f3w/Ymkh+WH4Ub1DTi
         8Hg0DYjdZgeuk4FCG+DTjIXvMcOfxyhVAnzi0pY03huvN9ZYqKKfnKnatkfkQXBw2ord
         8C4lKIachIXh4gAaPLPMN8Z9Vj2wGt9v/p0eBJxOh939pejHPEQejnTnxZh3dwmi95gE
         vG1Q==
X-Forwarded-Encrypted: i=1; AJvYcCWLeDV1D1GwM4VPstdl7MVfpjkMzATFIfdZqcE/Iyx9Rb2UN4m/2RRJYrxI1vtqfG47pSLn+8lLi5/iEVY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/azFmTzzpwyhhQvjnLgvCNi6/vPtEkZgDW5oXp+zBileng2t9
	ef++VWFRPuIU7Zn18YsBId6o0QbBGWWz0tjXs2AMMuMPIvYbZKQmGWEtrapxamRhY0g=
X-Gm-Gg: ASbGncvZTOsl7Ph2qoC5qUtg58qISfk4vQlLoXln4j2ab9H1ad+zLqWjIfEQdSvlCaT
	z0UGVH3T04ro9oXKgbDqAcQptyJ53VlzFy2i8pVQcoc7w0h//+j6E4uEoL1tfgIzZzNoz9r9dnR
	HA1HA+RM6QG9H5CrWl5k4wbdHeOuXurf6Jyf9nn72ksPO+J3v8H2q3NDBA6Gt0YHuNTHw2Eg8q4
	pL0FidSJLD4xbQdAXvrDioVrvup9Ym3hPw4KHqYUle1gMwSF4lmHh6M5Euz/jF3FG7FU+7856Og
	tZXRZlQUCMb9Hbw+jf1+05LLeod+8wpQ/vc0kwEZcEXGsf2wVEKK+9U7qd4BCouPanFQRO07hd+
	7IrsCrgtTCoMQ0Tp4hpx0mQhHocZ8SPGw6YnC3HTVUfT/z6ifRJ+9pN963CFIjVFUuggrW4s4G0
	+lNSN/ZfTnhQZXGhYFp41/K8w0twmxLmwhIL6lRyzqBuuwJFXoVv5gpbrTkJg=
X-Google-Smtp-Source: AGHT+IHSKjX9RCv10XVLOYeIj8kPKt5WTLdPspgyQ2/nAWVDl9dZp21csLPMcO/goytGE2kWAR0jbw==
X-Received: by 2002:a05:620a:2915:b0:89e:67a9:fced with SMTP id af79cd13be357-8b29b97fc99mr599752485a.66.1762987018035;
        Wed, 12 Nov 2025 14:36:58 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b2aeea0574sm11729385a.6.2025.11.12.14.36.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 14:36:57 -0800 (PST)
Date: Wed, 12 Nov 2025 17:36:55 -0500
From: Gregory Price <gourry@gourry.net>
To: Robert Richter <rrichter@amd.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>
Subject: Re: [PATCH 2/3] cxl/acpi: Group xor arithmetric setup code in a
 single block
Message-ID: <aRUMBz8wl1ePak8O@gourry-fedora-PF4VCD3F>
References: <20251112205105.1271726-1-rrichter@amd.com>
 <20251112205105.1271726-3-rrichter@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251112205105.1271726-3-rrichter@amd.com>

On Wed, Nov 12, 2025 at 09:51:03PM +0100, Robert Richter wrote:
> Simplify the xor arithmetric setup code by grouping it in a single
> block. No need to split the block for QoS setup.
> 
> It is safe to reorder the call of cxl_setup_extended_linear_cache()
> because there are no dependencies.
> 
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Signed-off-by: Robert Richter <rrichter@amd.com>

Signed-off-by: Gregory Price <gourry@gourry.net>


