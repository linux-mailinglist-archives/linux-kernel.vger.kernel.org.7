Return-Path: <linux-kernel+bounces-837916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA510BAE0B7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 18:31:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D5193B24A5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 16:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67BA8246795;
	Tue, 30 Sep 2025 16:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="daQi9CXa"
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11DE123C4F9
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 16:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759249877; cv=none; b=N5T2tTTp7ehL/9UrT6Mm9pjo7Orc4pGfEfelJOhik4DxsqTeE+hVHSLX9LcJ1Ax7Ch+z/gT3KibbVk8K0U5kzVwSPyWSkWpu8ChwHo2LEMgIV7GMLmGnxrvbZjVPlp7vsct+65ZRqdCoEiBM23U0dq/GohjtD1Mvt6/9g09FA3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759249877; c=relaxed/simple;
	bh=bl1+4UO2YH4eadKjVmkxJlFLlt/h0Ai1S/IS40fyeLw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tLfUOBmtfEzhJwJMJrJwp2Av4L0nrKNCNn0baUuuvStwZ6l+7Ec9MUM6hIucsf9R99jWTgMsor8q7BlnaCU8gUrGiXRzd4vVsaqXcd6lp5zni0easKCe/mRedZ2Qz+seAx4LKUDEa/80OMm/a8R1NiJchW1F71MQ1VY6e6ijFjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=daQi9CXa; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-85b94fe19e2so600892485a.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 09:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1759249874; x=1759854674; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bl1+4UO2YH4eadKjVmkxJlFLlt/h0Ai1S/IS40fyeLw=;
        b=daQi9CXa9QSJY4lk8VA/jEsP5XdZvuyMqZVMOcTUFIDeFflUchiD82GZdV7eSXaMtf
         REoQC6u4DyGF1mIwH4rCjU0DPAGFO0z0CvHhok2b7Zo1R/mCKQd1dWsquvfS7WB8B6tz
         Y5bmJLkxMw9EWlVWnx836i79uoXJQIogDrtsswODjuPiW14OG6xlqKrVoCuI6jZL39xU
         hby9b9dSj2QI7l6NhMWIguAQq6RZyIWqeK8z+r5MLajZq94uzr4ROSmf+2xfLUdjbgM7
         0d3mrqnWZ2KCieYl7YQj/kJar3u8794aqfRTGkZHpHZR8m8yK5rjrNoEUiZaQ5psWIJv
         Boyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759249874; x=1759854674;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bl1+4UO2YH4eadKjVmkxJlFLlt/h0Ai1S/IS40fyeLw=;
        b=EzpVDkuLWa3J8IciyIpLj1oIqXB/qsOATpZh70HUfpJdlSAjhuy1+MsdKqc0CaHryE
         vWSNdcTWmSR4FKH3ECtJJ/OFbIoQy9f+B0c4qkkQ/OGzMTmASU+en+At8Kj+HioHCdEj
         Xj9xexvca4NIPdsOQZ0vtnIxfuF/fgAghzHDRS39KEbQ46+QWbdi7OwZ779CuKV6JI2d
         Dnhb4DWbPihIT7caCGVM5xPiKRl25sbvGHF8tOc6r/CDvrVxAGNy4EL1moprIXAAg7RT
         Twpk2lRJuZT1ltDCPzQGUqtI77AvCu+R7FLUKp9pd+870PFfWLtt7d1uwfLqa9k7p8jK
         Cxkg==
X-Forwarded-Encrypted: i=1; AJvYcCV+f73AIri3k8DyPqEwXjjv5di+8KSNgcovk9OohFE+9+rIDwBrgnDNmZNM0z7yUc58L4ki7KaZ/QCHsdM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+CWXxP2h5DWaDhVSDGR7qG9wFnrVP6PBlI/YbkB3C6fEcpwBx
	uNJMyLn3mcGwsyQGmzQMNboJuVTE5wU30UgNyfEd+Nqw2O8klRP7Y/iDWkNh2DYPAyw=
X-Gm-Gg: ASbGncvlCmAxjS7MLc69a4o0PrY/z+/T7YqCJSbJZKqginr+c1dvYGPGroAznwKZkqb
	6OYTHsOeGDirrkcl/dU6gLFfYtMxbOkeHql99KjXOn1GZQFeCi+074VzbKOQZ3TpG1ag7Cr3/V4
	EkPyrEEWJBdqj70n7sUraDGRTERzPJv/qOdXnpS4GAeqy2V/IVDmQ+TGwqQ2/sWaDckVQGS3kE+
	bKXQgctdwSbFhAA0ir848zIxpfoxM05AqyEp8vSib6hjO4zgazFknyHpfrAKzs5XldtdazsaTUo
	DaBtcBLskQuhTrJlu9Ak+aST3PkdEMd84kRzjFpKdKtPeipye+YmCunLlbZJnngz3Q/6mkQO+ei
	YhLBxAH3/aWzBx003gF2Xbn+BrLvBBV8=
X-Google-Smtp-Source: AGHT+IH3hKfQMkGyBhWJplHqI/wO+SMQBBmIDfXW13DSmBhYOOBjbfVAPIN5KYq98JehJB0mqC4QEw==
X-Received: by 2002:a05:620a:178c:b0:849:2a77:5612 with SMTP id af79cd13be357-8737021aba9mr61213585a.17.1759249873639;
        Tue, 30 Sep 2025 09:31:13 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-85c27564344sm1068086185a.10.2025.09.30.09.31.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 09:31:12 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1v3dFv-0000000Cbak-3AGw;
	Tue, 30 Sep 2025 13:31:11 -0300
Date: Tue, 30 Sep 2025 13:31:11 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Samiullah Khawaja <skhawaja@google.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, iommu@lists.linux.dev,
	YiFei Zhu <zhuyifei@google.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Kevin Tian <kevin.tian@intel.com>, linux-kernel@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Parav Pandit <parav@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>,
	Vipin Sharma <vipinsh@google.com>, dmatlack@google.com,
	Chris Li <chrisl@kernel.org>, praan@google.com
Subject: Re: [RFC PATCH 13/15] iommufd: Persist iommu domains for live update
Message-ID: <20250930163111.GO2695987@ziepe.ca>
References: <20250928190624.3735830-1-skhawaja@google.com>
 <20250928190624.3735830-14-skhawaja@google.com>
 <20250929160034.GG2695987@ziepe.ca>
 <CA+CK2bDqDz3k0gXamJEbKUL7RPBLVjaA5=Jum=CF84wR+50izA@mail.gmail.com>
 <20250930135916.GN2695987@ziepe.ca>
 <CA+CK2bAtChLRVyQftBMN18SKt2o7FcV0q-YUcPS9ZKn2qD87mg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+CK2bAtChLRVyQftBMN18SKt2o7FcV0q-YUcPS9ZKn2qD87mg@mail.gmail.com>

On Tue, Sep 30, 2025 at 11:09:59AM -0400, Pasha Tatashin wrote:
>
> The way LUOv4 is implemented, "LUO sessions" are always participating
> LU. Once a user adds file descriptors to a session, that session and
> its contents are automatically carried across multiple consecutive
> live updates. The user only needs to act if they explicitly want to
> remove an FD and opt-out of preservation, or close session. This is
> consistent and convenient for long-running VM that should survive by
> default.

I don't think this is a good idea. Each kernel should decide on its
own what and how things get included and manage the labels, from
scratch.

If you do this then alot more stuff becomes ABI and I think it will
turn into a huge PITA.

The userspace already has to have the code to setup the luo if it is
on a clean reboot - what is the point of not running that every time?

Jason

