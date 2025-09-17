Return-Path: <linux-kernel+bounces-821598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86391B81B3E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 22:00:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74141588088
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 20:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7926D261B97;
	Wed, 17 Sep 2025 19:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="eERBNmkg"
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B6E2C0276
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 19:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758139135; cv=none; b=C9+oPz1iMZu6kg8uFq0Yemuf2WO4cqX47DPXZYJaeixDlnllB0LszcHlfB3WfRLowftz8Fi8CIAj5JGRTWLfjH5VATaD9BAtooEymtIlg9PQbtttesHoJLSd3iTy4+glfPzMrRhpa6DPKwLN8ZGIkui5Xmx6hKXZsxHyllTBNiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758139135; c=relaxed/simple;
	bh=dxkk8tG7hK5JdTJzWjjKydDl+hoVXSV6oyTVGZWUjEk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qkkmfwt6zlo012bhtsIsc03NwkiC0rCd1m25bKcFwljPE4fVCiKij1c0QYQKtvTUwr0gaUYP/WJKmdPkVMMGmUcwJCwrZ/v9uAIFZREk6g9r/w9BC2DN7PgjbN+rpRl4jrVsn4F7d01jhiL82jA7nrmtvCI2ABgPPp2IBh+lJ3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=eERBNmkg; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-82884bb66d6so23281785a.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 12:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1758139133; x=1758743933; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=58ejY8lKzPUFnBka1rlupB1Kz/9dcjqxS2QMacOwEpg=;
        b=eERBNmkgWA3cSVVsKGfw5IaOGFyIH/ym+gmi6zvoehP7+M2Ix647vDLZ2fUR5QLlkA
         A+gfMsD/Ega05PmHKTt+SrDvykiLtDd7HeN0oS9Q1MAQ2zKO2pKLbgLqU6wFR9yO1DGr
         wM5HiWk8EuCvX8ncyJ3esO0DFLBxvCSeYALyowpWX8L2FfdYLU1PFAovziSO0NQZUO5n
         2S13j07ZYT5F11UU4FAO+9hMTSysEqmqprZP+cx1JDEyuUFHi6uvDjnHeMl3+sJs877J
         O7+j1l9fyxG+VnVTYTXwZCFFUyxiFpd5q6HFw+Y3g9p92vuEPkShA0F7rPAt9k4flq6/
         p7Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758139133; x=1758743933;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=58ejY8lKzPUFnBka1rlupB1Kz/9dcjqxS2QMacOwEpg=;
        b=vVThMi44j2bqEWX7Lm6MCGdjOH5otxd00mvs6s+MNRRk6WarwmS3fu7tPW5IEFuaBZ
         j4wkZ4e493eIcNdrsIDl+yDWkBOgk+Xy9Dcqr2jjEejq8IS63yFouM2nUB7hYH1rKUdD
         EkajEwx27U6+R2xQxIJ1E4W6HFW4KpvAoc+6AfhTGeMELpqGIXUeTwPCq5rdDfCk37im
         xqe/xYQsbS3+bN2+giUnkF93xEMSCf1d5XcfYfe996Osa4W4VidaiQy3Nw2U7fuZRtVJ
         sU7aW6mEjoKkc6h7F/ALOTVQbBFVJZOTCxfl2kWHWlV15UrhbKkum+eH5wNU/PxudRNV
         5tDw==
X-Forwarded-Encrypted: i=1; AJvYcCU3s9OC/HdW+ErvKe9lA85l76yLcSa9uLMMfZkY0TpR3qrN3Jnap9jZAMk0RUSCbNKKV9UD9DEDWjECrs4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcD3q3p1lpP5kkyKde0Y68DuYCffwB7AXS1KnZDRxLwCa0rKcX
	3Xlv9TGrjaHYjFm/SXf3WNoEmXgdlCc0HcI/rzqvwYPu4uXvi/kWX/SOYB80Ss/Fd3E=
X-Gm-Gg: ASbGncswzBFAARa1KXI6+p0jAgluPw16RGk1P4SkT6uexJQEi2XGcZZhVb2UpVT5xes
	ymHfTeZOvPJQ/Da+3iUhSnUx2detpsU+GT+wuS+O5Md+tBxVsUNOFu/HVErmvncRS68BgLsW3Ps
	XezVurRK9cuqLyA2jNGPKqZVic6mOqtAURMLwxIZPdGJfwG0RuupkXkiRGV6YTxNpw2OyS48tgF
	dNyir/RimDMdbnYKLXoXk/s9NBhl52vwo9siWCQVTK0CEWu+huJxvm694eFFy1I/vkOnhuabBxK
	MWEdVZ6DSkVAwl8kYrCV3BOgGzWrupKZKO/5CJvbFamxBQpkULkUg1/SHH44V4dCqUh/UzwQQx4
	AH+NveHm9x9gQcVf1mXou5F4dAb3neCYO81YR8as5jSXmqLZVtHRlaeOuUsY9oKTzbxMqM9KPfR
	J0rJM=
X-Google-Smtp-Source: AGHT+IFo5mUXlgWJqSrwW3Ag53sh8YnNIU8HxG9er19Nkhdl6k6VD/pvyTugHUvkMVjI7UpywYGlJw==
X-Received: by 2002:a05:620a:414d:b0:808:2794:7c40 with SMTP id af79cd13be357-8363bf2f1e1mr123738985a.37.1758139133063;
        Wed, 17 Sep 2025 12:58:53 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-42.washdc.ftas.verizon.net. [96.255.20.42])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8363240f538sm34971585a.56.2025.09.17.12.58.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 12:58:52 -0700 (PDT)
Date: Wed, 17 Sep 2025 15:58:50 -0400
From: Gregory Price <gourry@gourry.net>
To: Robert Richter <rrichter@amd.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>
Subject: Re: [PATCH v3 02/11] cxl/region: Store HPA range in struct cxl_region
Message-ID: <aMsS-lJqZCmcDQDF@gourry-fedora-PF4VCD3F>
References: <20250912144514.526441-1-rrichter@amd.com>
 <20250912144514.526441-3-rrichter@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250912144514.526441-3-rrichter@amd.com>

On Fri, Sep 12, 2025 at 04:45:04PM +0200, Robert Richter wrote:
> Each region has a known host physical address (HPA) range it is
> assigned to. Endpoint decoders assigned to a region share the same HPA
> range. The region's address range is the system's physical address
> (SPA) range.
> 
> Endpoint decoders in systems that need address translation use HPAs
> which are not SPAs. To make the SPA range accessible to the endpoint
> decoders, store and track the region's SPA range in struct cxl_region.
> Introduce the @hpa_range member to the struct. Now, the SPA range of
> an endpoint decoder can be determined based on its assigned region.
> 
> Patch is a prerequisite to implement address translation which uses
> struct cxl_region to store all relevant region and interleaving
> parameters.
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>

Reviewed-by: Gregory Price <gourry@gourry.net>

