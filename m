Return-Path: <linux-kernel+bounces-828173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98E04B941AE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 05:26:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BB2D17728A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 03:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7895258CE7;
	Tue, 23 Sep 2025 03:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="B1WKYWjY"
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74D9725484D
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 03:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758598013; cv=none; b=U19+B8mtK6rUu/hmGiDAYEd5amlWZrESA7sELcAxNfLXx+aJ1KX+AjpXMFVNdjRzDxML/noGPpGqN8z5v9yHITRVrGaMm0dXuDRa0CnOLIuMW4/GPJrh8juoCOV0xvUHF1F5psy1ZLJe/tqvi52EwwSIigSt/5WTMKcvk8850Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758598013; c=relaxed/simple;
	bh=Vg9sLPfag+hclYKfgqP/HJ0ojo0K9cjFMBX7rdhllww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DjndOfJSCl1Rlscbro7VNQN2dew4aFx+rgjLO4+CScwK2Zk1ThReltNeWmKyG04Ah/RAnqeE0FiL8HAxowh5f16uKI8P1jygEWt6ANfmiwhMzZTTLBl6tGbsDJ7my6U1wmcoPqV8S1U/i9O9sLsj7UoYFz7ANSEDFCIOJVs4vRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=B1WKYWjY; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-88432e27c77so143136139f.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 20:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1758598010; x=1759202810; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Vg9sLPfag+hclYKfgqP/HJ0ojo0K9cjFMBX7rdhllww=;
        b=B1WKYWjYmy4gv+vzRyrLfjiU0MkSUOaLCyJd07WRH9KWZ2R/tDXidu21hNxwOzCFD3
         3rQ9VjykxqPt1+I+eOVreO/0x9n8cwVqERWQuj0tFvn//HyDx1Vf4NTTIpFtAMYdThAk
         O2fMDbiE6kjvSX9FUmrLwVXoVbl9LFlKnDeDRrbTGxCzHWparxb3VSWJZPCMVUY66lWD
         nvvgCAadww3QX1ezKbcU2k+U2M1YTLBbUgXgwO8EXYW+Qhol4x4Zuw5CBDiliNw6apXx
         1R3kd3z1LGDS+KLQWhpNMJ95gc28YXOE6i20jRRK8z7e2Sx8HecXvwoXi5HxflXahbCv
         1JKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758598010; x=1759202810;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vg9sLPfag+hclYKfgqP/HJ0ojo0K9cjFMBX7rdhllww=;
        b=EvHEibGhvtCvj7pKI5R54KHy1zmWB5CWyEDCQ+61V3Sr1iKkBFHoN/BjCTUzJNv+RH
         fmiPlRySFOiZYlogKpGNx7KlUmaylGusIgodOrKsjXVsJ4Txwj/S/gyk19dWxWbE5H4/
         JR+6mAxVqYGO0wJNqrhcWkwXnIUuXSBl8kEtYV7RqjLARrdXVUuiNLb3XAL6UdVS6whG
         SK08uI3Lkj6Oc+3rKY0lTtvjgBDzL65wo66k6VKkwEzfdIBfH8HkKTmBhiM6B2/+izCw
         LI4qkxhfdf2eRs/I7Gs+L7kjwJ4eBCmpleoGxeDSGRnHzj+5DWe6M3uBNad69gG2q66Y
         Hwrg==
X-Forwarded-Encrypted: i=1; AJvYcCXzI9Nd7vU3Vwlo0BBBDoz+8rlfDyHBQPF9QNclvIcrs64l8fg3Kr32frnYYajhRI8kR19SFE5sTcdgTh8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWCw8wHT4Xrsco2iF9J53IN9Vda/oXMr/kKNGIsTNV1H4sRimv
	zDYentZ2W05bj3/0gYXgmqFaFf8aAQknW1Wch74Bp2Xq+xb/FD782tlAncZc2+kR1fI=
X-Gm-Gg: ASbGnct7JQcZg76idaLPLGzo3tcVL5F1yajIh8jjPsnVnZucXtHn2Lw3XDW1TnbOBJ6
	1nEa2b9gbjghRFqzeetdcWx8OAD25n8y0+GD43XJ7Ys+Dk2L0Jl0w7YJGHWceYsfHEDkcDt3BeS
	bGs7tt4UMCBWclcPJ1GVEKNBtzrRA6tsseQTggSWScT3BeZerpHmJmxkjof/XYNEsbtOQMbYzLG
	UcCODppRjaZdZHL/Y8ffp2UGW0RXC+KCbaXbghK8+R9hBrlfedDCfBVu+lSv0pxiNLwEC497ZyW
	vUPnFmXTny8yphb1kHMci5X9nrRjaM0dODCUgRW1+IaZPf3PIJIDw/Y/0GQQ9mv7JTCUhjFRESt
	ki2dIjASESNzZ8uM88ZQ7KQmnjLqcV2vOD3NI/4vcvrGlTfYDZSVyFEYVbpjXvVTtRzmb0aBpNY
	I=
X-Google-Smtp-Source: AGHT+IEphIF7dofS5m1gnjIZO/Curkkg49/kjN7MyLzNTCf+HdWQIY62aCg1IDcJ2axM5gtNDYiQcg==
X-Received: by 2002:a05:6e02:1a8f:b0:425:6e9c:9443 with SMTP id e9e14a558f8ab-42581d47f08mr17907505ab.0.1758598010480;
        Mon, 22 Sep 2025 20:26:50 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (50-32-2-77.vng01.dlls.pa.frontiernet.net. [50.32.2.77])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-53d3b012b8csm6520513173.16.2025.09.22.20.26.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 20:26:50 -0700 (PDT)
Date: Mon, 22 Sep 2025 23:26:47 -0400
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
Subject: Re: [PATCH v3 00/11] cxl: ACPI PRM Address Translation Support and
 AMD Zen5 enablement
Message-ID: <aNITd1fXcBxKM5mF@gourry-fedora-PF4VCD3F>
References: <20250912144514.526441-1-rrichter@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250912144514.526441-1-rrichter@amd.com>

On Fri, Sep 12, 2025 at 04:45:02PM +0200, Robert Richter wrote:
> This patch set adds support for address translation using ACPI PRM and
> enables this for AMD Zen5 platforms. This is another new appoach in
> response to earlier attempts to implement CXL address translation:
>

For the series:

Tested-by: Gregory Price <gourry@gourry.net>

