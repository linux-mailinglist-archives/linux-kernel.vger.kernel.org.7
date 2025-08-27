Return-Path: <linux-kernel+bounces-788825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 838D5B38AC4
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 22:23:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAB4C1BA6F22
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 20:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0EC92EA483;
	Wed, 27 Aug 2025 20:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="VfGp4OEP"
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 806B91DE4CA
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 20:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756326232; cv=none; b=hPpUNwa26ltWpj5Ob38G4eFS21JzwJlm7Tr9kgdX2UewNaO0acKfg9Tl5JY44bV9nr7xMKaA3QL57sPNvLtp4K90OAJuDRLlGpkplJ9d9YR3iQaefifLQWmb7zdzee14GhirIUGreqlcFunCsWuq7MWHC/0uTG724FqlvzgMQRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756326232; c=relaxed/simple;
	bh=ympLIfd6q2uz8sPjeGy9ikp10Y5W46lxVKN2uHOkeSA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lFNgqyS605pdt0GFRk82BmN0zJmBydV4WPxxyx5BjrgUgqo2iowzOKokXHP9/tb8eup4BIPcywAvFHM+7jOMnB02nlEvFP7RdVgLGB2MSyZOjC6j3XGKpan9lgDMlR3KGGrxHdkQw/8zTKAka+DRJOC8Im+S+UX7n5rANbRH7c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=VfGp4OEP; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4b109912545so3525371cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 13:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1756326229; x=1756931029; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tpOEDUkT9ltpYSIW5r16zrEEmzgxmIvdt7bvKP65LEk=;
        b=VfGp4OEPUkqUAXEYtqxtt5QpayX5o8O2Qr49ZnpVK0ygstT7Du8ecbeBB9mE4AO1B5
         eGC6fphf1mFXekjOpz7CjDWSV2WTkdr4tFwSBTuFzF8AnkAKdfsweaIGRp3U7f7Sbx9F
         wZJQYh+p+TZlqfksLeHEKQeyFpJnxce6Li0CsuvlrlhBxV6n8L/doHv4ylkUHM1f8OvT
         JfqrgBBMD/299d8taAhDGUfV4Bhi33P40ZvNfOtXEmaFCeZmVN/fRNhUuBgYb/MYvF+E
         TwnaFiUQBJi93l/fgR6iZrS49KT8O8Sbn5UM5G+S69Pn+7ZGseA72wKbhh2PIBFhWaKI
         IzKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756326229; x=1756931029;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tpOEDUkT9ltpYSIW5r16zrEEmzgxmIvdt7bvKP65LEk=;
        b=B1x5Sse4PsCelVGUk708xpEjqO43oA/BTelhFD/po2UORdctHNcCgDusdFBYbAHrIl
         RzEgO66T5UBGCjPc+tjCWiKqB5X0f9OPHsB4Uq/ksKJ5Vp9pCninIgG4wG87BqU4MLAU
         PZuSqihicagUlTyOmxedMl08czYDICbyg3jSh8+IHNywNPaB5tV2bSTXht5BcqHF5SvS
         h4ahouGj857Qrzk9eix65LYbHFK+QHaS0oTi6p5xEkWB8iC4Qx/M6xX3EEAuRroOx8tV
         5Z67C3iDR97HsFWt1MyIKSm8hN07K0BEZDqjnZ+N7D/KkHS76N1AhsM0oPm2IDNhab29
         Eb0Q==
X-Forwarded-Encrypted: i=1; AJvYcCXA4P49ACsx1nnGksWE30+11Szz0e1yaUeUxhp1LyN71fLH0PfabNlu5l2U9wysunkDF/8/TWfZzflzGg4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHT1NF0nJRqQKanym2q/cDg8vz9t9Nv/YEk55YXI/0gOi8GY6I
	ez/kUkLEpNdM6ZK0FhT9n34Bgu9ovURYt3iulqvqRo+IFzblQhamBgI+1frxp7+3bpQ=
X-Gm-Gg: ASbGncuT7zFyH39ZZ29JKWIRIBk1FMAfLwnNbu5gCxMz0GvM9GH6TNrYSH0E8Olst7a
	BVTnR5NusKIlErkFCrHyezd82+nNCx0q4mENYNzCjJnjfGPgSgPxLK6tL/381nyO78rJ0S45z+T
	HWEEodEJrr04HaDkMFZq2kHWHXFmzcrnJpA1gr2hwRoIvaOqlhiRaP6UA7pLVEfjsqnKBg5+ghP
	dH0YvXCeogcPLouNie0NWM/DISp63wDPkIk3/aOr26yT4/Uy4f3UpbsNi1JQayqiq56nv3gb4+Y
	PWCdfHSu+tD6P/YA8lXLdaOaI3bpzUXfW49zSruarulYcoM6RJRtPNxRGCbtQmHIKq+NWg7aui1
	0/yd1L/Ijwifcik//IAEAPx5XXxFkIAzCJ7HX6j9qgVzfHSMtjlTU2cOi1SDBNx6LDf+QawwXHJ
	3NSA==
X-Google-Smtp-Source: AGHT+IH2jvq0biwVj6G9Lb1igaYWxMehi3WpzeTMyFhLVTHvBbvwK5R7zTgvdDX6KlbQ3p+4Xa/pJA==
X-Received: by 2002:a05:6214:5098:b0:707:a430:e01b with SMTP id 6a1803df08f44-70d971f7608mr246666016d6.3.1756326229319;
        Wed, 27 Aug 2025 13:23:49 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-42.washdc.ftas.verizon.net. [96.255.20.42])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70da72ce510sm89559896d6.64.2025.08.27.13.23.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 13:23:48 -0700 (PDT)
Date: Wed, 27 Aug 2025 16:23:46 -0400
From: Gregory Price <gourry@gourry.net>
To: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
Cc: linux-cxl@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ALOK TIWARI <alok.a.tiwari@oracle.com>,
	Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v4] cxl: docs/driver-api/conventions resolve conflicts
 between CFMWS, LMH, Decoders
Message-ID: <aK9pUhETnNgs-7UG@gourry-fedora-PF4VCD3F>
References: <20250820150655.1170975-1-fabio.m.de.francesco@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250820150655.1170975-1-fabio.m.de.francesco@linux.intel.com>

On Wed, Aug 20, 2025 at 05:06:39PM +0200, Fabio M. De Francesco wrote:
> +
> +E.g, a real x86 platform with two CFMWS, 384 GB total memory, and LMH
> +starting at 2 GB:
> +
> +Window | CFMWS Base | CFMWS Size | HDM Decoder Base | HDM Decoder Size | Ways | Granularity
> +  0    |   0 GB     |     2 GB   |      0 GB        |       3 GB       |  12  |    256
> +  1    |   4 GB     |   380 GB   |      0 GB        |     380 GB       |  12  |    256
> +

This may be a dumb question, but... how is validation supposed to work?

Like in theory according to the above something like the following would
also be valid:

Window | CFMWS Base | CFMWS Size | HDM Decoder Base | HDM Decoder Size
  0    |   4 GB     |   380 GB   |      2 GB        |     382 GB      

(ignoring ways/granularity, i didn't adjust those).

The entirety of the CFMWS would be contained within the HDM decoder, but
with carve-outs on either end.  This would be "allowed" according to the
logic here.

This would effectively allow all HDM decoder base/size values to be valid
as long as one CFMWS is contained entirely within it.

As a result, wouldn't it then also be valid to have an HDM Decoder cover
more than one CFMWS range (two full CFMWS described by a single HDM
decoder).

That seems like it could cause issues.

~Gregory

