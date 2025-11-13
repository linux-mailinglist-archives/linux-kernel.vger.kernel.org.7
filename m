Return-Path: <linux-kernel+bounces-899665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 770F9C587CA
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 16:49:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 106EE502199
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 15:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F34652F6181;
	Thu, 13 Nov 2025 15:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="KZF6IMWt"
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E08C2F5A0C
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 15:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763047930; cv=none; b=kDZqA/HQr2z/GQ7iCJstg2AL9t1xhjt/SdZgpM/bZEqe74ygjFqrsGahp+iMQFUwEkB+ILzpw1tX1q2MktIDM64AAIGdsVoyDQ6thlU9q8uDZK7XyPEJ2Wgah3dwS/8d6BvVJMguLcnZ/5KGiSAmtSdxvf5Az2j1eVaVMny+UMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763047930; c=relaxed/simple;
	bh=VIFAibIeFk9BTaPwOLtgvXcIFgSN73xkX53R/rEjGQw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FK/g78pWt2wWQbz57TTACDV3i99lc8ofC+QkqI/woTsoruOVMEXyg+LZV8JLQN7CPlPet8ZGF2leGNp6FQ0u3E7MiBfzvTUFGyzjjpT83sVDZkoYeACAEVq6mnj9y8WhL6n/hUBEeaeN8s5mZmUiorV9nUwro+CepuO9yeoD1SU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=KZF6IMWt; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-8804ca2a730so12477536d6.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 07:32:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1763047927; x=1763652727; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RwXZ3QZb2iH/PQgS8t9fflZ6rAwJ6dkd/cv8rL8YNXQ=;
        b=KZF6IMWtHFkUghWYhdeKo3htyHsBD1Fk1W+dlM7eqWdG4hJ206SoHahS6MGJoxvmbw
         rMI1btmMn609nwPA1ODmAPKP5qigiLnCrd8esHnt3CYUP+yFI/dMLGw+ZBtHxI3QiCJA
         5AAjNQbt4ECOKEoG+d7XGa5/556VwHvSynxRho+CBCyyE5hZBDMzxQkIXXP7Oz0+YwNu
         iGI9Ojpdz0LybQkKBCzuOx4bHBZphYMpCXr25E8QvQ2iXd/uBI5UONtDlOZFXY95TqLh
         k2mDZY8U/u5EnVNXsTwOFmVYkPcwuBftuE1Yq40JJPL4MbhwxljMDfCzBM9or6qHd5hY
         vq9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763047927; x=1763652727;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RwXZ3QZb2iH/PQgS8t9fflZ6rAwJ6dkd/cv8rL8YNXQ=;
        b=YoTeldzbwSA89UOvMZEzlMcDVr95hG0MXa8fJGrWBjWPh1eI7uuNXtjn0VKFOB3reA
         qfj90fgRqQkYxNvyRY2hsJDHhtHzf+B0YROXY4PrcdDZ1sWlATBjqWUd8AlaHEleCkFp
         3pzbaBkAoC+iw3Q2Bs3+KIvn0QtrBMB7gCo7eUk7mTsZ5Vn0EsnP9nZ7Ozg8wgCg1U4+
         X6M4Ni9FnHx/OkOULzt7nWowTW6iAmm56SpbrmkJsknkW/YvFA12JCuM9ikEiu1LHfSS
         tTcXcYFL2QduxK07gmIW92i91Pm08MZraSWKRtZh8KNUQvF0Oo6C4j4+yrvjTt99Tx3A
         UhXA==
X-Forwarded-Encrypted: i=1; AJvYcCX1DR+eX62Macut75ObC49oiJrkNX2d9tYSZuoO/rRJR2N/z4VqJnC3O+jcKa1pELwDHecCJFNx/56UxsQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyVBfqd/U16F1veyvL0ioS6Y3yABBy4tlf3SxHN6Jin41Tjo6E
	r/4U+FtpwY0mB3drOEKCGnbM0YUU/tUsqXCpQdN8+jaoYry7H59Y1ewsrO3jrwt/AV0=
X-Gm-Gg: ASbGncvA4pKT3/Ueq9hH6JoswNKCohwUgOQzHmOhOHoOEdoGI/4ei9WgZ/eR63PP77G
	4oDTKVmX6Bot7bqrZoqhT1GnhV06mDnD4NsnSRLV6WzPGPxI+7+a5mvLhdBP3fl80thhSL0QifX
	mnh5oVvT9bVU2pnCpWnz7PHU2SzJI23bGtOKHhuFIUlB5DgSdkjbtfdTXtNkLkdlMJuNCTUebqv
	uGGaMdlvtZz0Sf5Pz+UeOKCVfLCWrQ5RDK35t+eRG0WpoCF0z5fuVx1G9z8rP2LRPPb25o/9jc+
	j1DmRDc52GOa91OBAwuu+hVhBwrUZKhU5rqSmuUahlKqZGIIc5QzPb3bkMuIeKlk7MvBasCE+eq
	+l2ZQBkeypFziUK3eGe/9QPTAkUoBimWFLfiKIJGf/GZpnDlUfAqRjdBiyd4TasnB++YvIqjly0
	QbkeLomr7nhVtwpSmdNc5ST5MTjfF8YlelucHd837YMivababSuZpxE3rQCpp56a09RUgedg==
X-Google-Smtp-Source: AGHT+IF9bU4eg/VyjhOJgUKQHU3c3vXBSWjhuCVC64Widl9iAlPrHF5pMHl/JQjFydCbvLNKLyPN1Q==
X-Received: by 2002:a05:6214:410f:b0:78f:1312:2d94 with SMTP id 6a1803df08f44-88271a4402emr113638886d6.56.1763047927323;
        Thu, 13 Nov 2025 07:32:07 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88286314656sm13735666d6.21.2025.11.13.07.32.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 07:32:06 -0800 (PST)
Date: Thu, 13 Nov 2025 10:32:04 -0500
From: Gregory Price <gourry@gourry.net>
To: Dave Jiang <dave.jiang@intel.com>
Cc: Robert Richter <rrichter@amd.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Davidlohr Bueso <dave@stgolabs.net>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>
Subject: Re: [PATCH 0/3] CXL updates for v6.19
Message-ID: <aRX59JpZJa18QfoQ@gourry-fedora-PF4VCD3F>
References: <20251112205105.1271726-1-rrichter@amd.com>
 <db9e4d27-057f-4bf1-9d74-008ffeb0dbc8@intel.com>
 <aRW6h127k5Tzns8R@rric.localdomain>
 <f0285498-810f-44aa-8577-e28641e97d56@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f0285498-810f-44aa-8577-e28641e97d56@intel.com>

On Thu, Nov 13, 2025 at 08:20:59AM -0700, Dave Jiang wrote:
> On 11/13/25 4:01 AM, Robert Richter wrote:
> > On 12.11.25 14:45:28, Dave Jiang wrote:
> >>
> >>
> > Additionally, patch 3/3 (@inc variable change) of this series also
> > depends on patch 02/11 of v5 (store root decoder in in struct
> > cxl_region). If you chose to pickup some patches from v5 first on top
> > of cxl/next, then all this 3 patches should apply cleanly.
> > 
> > Since 02/11 is one of the first patches and it sounded to me some of
> > them will be applied as well, I would prefer that order to avoid
> > rebasing and resubmitting a v6 for that. Let me know if you want to
> > handle this differently.
> 
> Hmmm....maybe I should just take the entire series hopefully next cycle when it's ready given all the dependencies?

As an active user of the Zen5 translation patch (I've been carrying
backports Zen5 support for over a year), I would greatly prefer not
to delay the Zen5 series for the sake of this series.

~Gregory

