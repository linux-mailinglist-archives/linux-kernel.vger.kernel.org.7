Return-Path: <linux-kernel+bounces-821111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14BC3B806E3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 17:12:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE249465355
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 15:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82293330D5A;
	Wed, 17 Sep 2025 15:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="UWSbpZI6"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4F32E4252
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 15:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758121952; cv=none; b=a6sVNo+3vUlWkz8tPYZe8reyC9O63VXvhTSyrRS6HH1xFImhlmliELzOVc1mfZnz4Qm1UbkWF5pzjUrmIebNbfQKMOpwGV3yKJrnQeC2wonrVFOYblo3hxLgFI/zF+xK1vXF1h3mRpbPAH5532Y2DL9uL5xwHhcJ8LakZdXXhnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758121952; c=relaxed/simple;
	bh=h6v2kwh9aCqVuAACkoCA8PKkGZBLiz00NE+3hnXmEXA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GyIqb8ZUtDrpJ4kN4c1mkdoOJZr1fLbKKuwSpMBp/C5kCHm15HqIthmef9+Cagi+i0gl6g+APtdf5LbBuNro5Hm6aUGFU4JxPOrZexaHQ2lWFTjystkVfH2WT9iRBbE93v9/F8lgSANeSHBUcigIvE5m3uCjIrX4985nZttHy4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=UWSbpZI6; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7723f0924a3so8300184b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 08:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1758121951; x=1758726751; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+AJKIKeH9Ov7o/0/GNjD5irRT+JXdZ7DlVMk9HGTIBo=;
        b=UWSbpZI6L7xaBoGuV7kZ1jj3ArgARHts1mmV2OoswoM4gH/DNe54Z6ew2gTfxdiK39
         84DbjVpAf8KEg0meHiOsn4/OTa8sineEVz4trT3p3UQI9P+v77OOG8YJF6iZ+ymBM6d7
         Sb91LjkkuQcHgOeKDFADBi4UCiOA9IfW2Ka+72IoTCRfNRMHladMg6EB1m4doKQlUnvM
         Rw2nWmri4UUZksOe9cIf8Djv88zKxXP/b/+LR9sUokECMU0EEDjZfpKUsHpGCDdJZ8Km
         cYuSxZjXOthKtlj5Nrxkn6HHSEasH0DFrCGb0K6Cs9lRXH+3ncEwG4QPirY7VKDuTs1F
         8b+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758121951; x=1758726751;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+AJKIKeH9Ov7o/0/GNjD5irRT+JXdZ7DlVMk9HGTIBo=;
        b=I6ZM8G4IYwxE6ZjU5ZhsctwuLfIKX2cmCuEQinnepilNrwCLxKuaLBUdJNPt7OBvz+
         UYUPGV1vFMfC+JGQHMZlhUzbd8IC2Krslb1akveNaqWemA336dG7V8FIta6CFpRhEWYz
         jB9YPYl0cLx0u96s3fbLm+SUmP7iuO/+P4+IqVFPilxr6qp83Y9choZTrAfkV1kZNBmI
         A9W8G0RwUFgYtYUlVLOyZaX2vh3Zwk4dLfargmTMHn8eewPYxcBL9ZoWhggtrhpkYu17
         MJaTfCcgI3dO9amlUeZ8OIitHvESrPZqI3gd8ulz5e/TucxfwK83j5wH8b6bcoUWau3P
         ktiQ==
X-Forwarded-Encrypted: i=1; AJvYcCUNuYUiToNSRJxv9dj35fvcXUs6flWWLjHa5LOR5RpXv7hUPLRqHtMoz3QFmt12z4U6SwauARwX96rA1jk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwC/ZtWAqfMqCmmPb4KNTOP4hlY5ZNyNGum8lAD0va0dlN429Ms
	cqRT6EgKzKmsOSXKXjp9ELvIXWeftfrtuhVbtJyWlpX6slZx6azpB+gzShz88VvkZHU=
X-Gm-Gg: ASbGncuhwrOSuXWZMXIdzrqlkltrJieHCXgqX+yv12YncrkAxpoImn76VuVFwpzcTOw
	Oa9EjLhab41mb3Zf9BMscRa389BaXsAx25/uHPbYsZ/u1XXbEK8DN9i2rVQHxOGTtEhRmJBBCfI
	g2o0MBrqHmf3F4HqnPOEFhQjqdIa40x9TtSEsOhyZg7eeDuSNbuqdPBx1DdIYrVv1L+8Rtk6d72
	4Zev7cvyEz4+ZNn+SDU+uIG7TuzGEACloFWpuPzwmRH9it1W9NnAe7+DEQscFuqycX8niCGMyD9
	qDmMb5hCEmnHEl8+g6hn/dLwXm9opmElhpVbar2gkqp1lQ+nluD4MCJKGtyPxxFIHx/0lOHF
X-Google-Smtp-Source: AGHT+IFwv5Y6ghMNjLXVJ5uzhdrxD6IGEPyRrLkyVncfpnURJOJiwJ9ddq2AN2EfDCMXbfZqVw9jrg==
X-Received: by 2002:a05:6a00:7096:b0:77c:d54b:8c86 with SMTP id d2e1a72fcca58-77cd54b9014mr150826b3a.0.1758121950555;
        Wed, 17 Sep 2025 08:12:30 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77607b346dasm19529175b3a.68.2025.09.17.08.12.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 08:12:30 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uytpd-00000008NgD-1FTz;
	Wed, 17 Sep 2025 12:12:29 -0300
Date: Wed, 17 Sep 2025 12:12:29 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Brett Creeley <brett.creeley@amd.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pds_fwctl: Replace kzalloc + copy_from_user with
 memdup_user in pdsfc_fw_rpc
Message-ID: <20250917151229.GG1326709@ziepe.ca>
References: <20250917150941.168887-1-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250917150941.168887-1-thorsten.blum@linux.dev>

On Wed, Sep 17, 2025 at 05:09:41PM +0200, Thorsten Blum wrote:
> Replace kzalloc() followed by copy_from_user() with memdup_user() to
> improve and simplify pdsfc_fw_rpc().
> 
> Return early if an error occurs and remove the obsolete 'err_out' label.
> 
> No functional changes intended.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  drivers/fwctl/pds/main.c | 16 ++++------------
>  1 file changed, 4 insertions(+), 12 deletions(-)

Looks OK to me

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

