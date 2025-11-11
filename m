Return-Path: <linux-kernel+bounces-895929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 244B4C4F4AC
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 18:41:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4CF2F4E50C8
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 17:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3DA53A1CE8;
	Tue, 11 Nov 2025 17:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4eUnBY3T"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E8B7393DCB
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 17:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762882872; cv=none; b=q33xP179a6VCOLIdTz7MUWR2twcjueOQZzBRoLA3uOpYnNlXfVvad0yGpdXNDvPTmqPnNsBwRMx9cLIgKwUwZc2XT2/U/yzakBxyhvUEBVL/eNgJOQwPHPjMt/TT9s3uTqhbEEPkj2+1I20hs2pyyjk+bCFSe5BzBG5tzEuAmy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762882872; c=relaxed/simple;
	bh=A3dCqptOcTzRgXrYKY6arq6dn0GyZOmvKu8eNBYqvO8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JsvfrrczFmNR1VJwPWHmznoL2X2/koJ1bpaZdUTRC0LHOvCSr5heCg6W/6B5j2PqzIALCVyZJoNDnJSi2cHSfcDP5f8v+YYQEPqCV9KhMMnBqD61DGd+zVp8EDUYXPSFfWzXYLM3upViSGdZDwm9i0/1FHdeyDOcVM7ZUPmuudc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4eUnBY3T; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-340bcc92c7dso1134643a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 09:41:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762882870; x=1763487670; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VLML9QIDCd2Nh7IkEnXTPWZwGZyyJRn46il9NEEMgiQ=;
        b=4eUnBY3Tv48SXNCChjsA/6UurtICmK912BAqLI9N/gYaRZP4b2s2OTqJVCrwAILIwJ
         lZ7sPs0vXV1HjFjnLt3S71ay0yLteC78S/GVb9h7ingpDjRqKcrSbq1/7pPDfmwp/oC5
         R1pjRLcFDeAEKQef/KB+RxIav7XOZWt/v6W9y9r0wiWVlDuF3t40ffRxUhWpuakian+s
         ndos/9ESG08mVK0Y4nwZxv/Se0U44Tunm7anjV3KK+mW6GwPmvFJjG5ABHlqYnAWMAtm
         +lczxEvHo5J2O/pcInvwEjJac/eVQyG+inVIhJfheV8LWNUhbkkN6ODZLMxnjL16b2tx
         a1Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762882870; x=1763487670;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VLML9QIDCd2Nh7IkEnXTPWZwGZyyJRn46il9NEEMgiQ=;
        b=r362nMkX1AUCU1hlC0j/Y0IG4TSpaAGCRBUlpLhoGPqdPqplXzo+wkHMmY1yz1kGzt
         GzvX+CljBl0WBuUj9MIGTKrbsJ2/kwmvP8C6TEl891DQbz0Ue0agAhldbOv3c1Zo7jbo
         KjhfOCTVxNHPPB9SiUHvPPFyHCrwiYPPg+U5y6dtarIZuYfVdcr02lLlUJifTQK2kj0z
         8N/kuHjP7DFN5j4Ix9ZmYSWgjPoaGqeqfOhPHYLKWIH3+BlzQ8sOZBUcbzAF8lj9KXEL
         v7tH4TMQ/BAEuKwZKU0+kU7hxKwACDf8NmPPSbfveT6p7qd0Xh+Tpyee++GQxE7xOuU1
         ykcg==
X-Forwarded-Encrypted: i=1; AJvYcCUkXjvvpGKYuT8uCVWQ7tv7BtEhXB/oaC4Yt5tP5OTIjZz0+KNloxWbKHwN9sVp5IiSXlv+NvJr75sLkCg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwP7oz+LiwN/tLQAWtbIPptai11QwP1gsCJBfDH6c9sRrzC6dO3
	2xGhH2I9RKyAHtQdjIup5P6LxpteK1hKyF+E/KRMElCGVADFQ9+zjGCYvTp6wfJ97A==
X-Gm-Gg: ASbGncuWX6zLe07ztbDXGFEzgaFwUCZ+ur9p2tvZAq/XvKoO4fzgysXO8Al+s/Q3Xlf
	TmCimMsRxfArjhDC5iWgO0IyzUbJVAdxBD/e3UtFOH6lKw0IdmAAecUsDYrmj8BH3N/9LHCkkWQ
	xPDiMQ+gSqi0OhccMRo+mSM1Hm999kE3rDJ2gUKtNCV4qJrgjU/gyQ65r/sdkYziHpn6gFuiQuk
	UUD5l16dV5AzRf4IBqCMXCuqkEzVlz/UGaiUhN5Uvua29Ln2GIP0tikcALxeo30rwp9yx2n5W9q
	4eE4k2LNLystyt+Wz+e01VlPeo921fPRWc14Q1qgMIz2zc12V9DcR0WOWAsSVTKIcYraOvP/FiR
	1zjVZblS9Dqy/ZR41OCfv2SLi+ZnD7ZRRb59A9qXiEdeaYRAD0j4tYwl0h6XyRgRuqLUPsa7mZ6
	2qHmnPiEXbkLY9A9HRFRFAhcYVozW9mj9xxHYHroqs5CTYYaFjaCPL
X-Google-Smtp-Source: AGHT+IEvwmOPuxLIG6g8YJxuSY1Ag9QNyhIsSAktbkG66XXY1WuAd5qXvp+4W0YdAckfJVsZ/Qdviw==
X-Received: by 2002:a17:90b:4a89:b0:32e:3592:581a with SMTP id 98e67ed59e1d1-343ddeec98cmr150863a91.17.1762882869455;
        Tue, 11 Nov 2025 09:41:09 -0800 (PST)
Received: from google.com (132.200.185.35.bc.googleusercontent.com. [35.185.200.132])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-343705c1354sm11607638a91.18.2025.11.11.09.41.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 09:41:08 -0800 (PST)
Date: Tue, 11 Nov 2025 17:41:04 +0000
From: David Matlack <dmatlack@google.com>
To: Alex Mastro <amastro@fb.com>
Cc: Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>, kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/4] vfio: selftests: update DMA mapping tests to use
 queried IOVA ranges
Message-ID: <aRN1MKrfm9GQZpzI@google.com>
References: <20251111-iova-ranges-v2-0-0fa267ff9b78@fb.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251111-iova-ranges-v2-0-0fa267ff9b78@fb.com>

On 2025-11-11 06:52 AM, Alex Mastro wrote:
> Not all IOMMUs support the same virtual address width as the processor,
> for instance older Intel consumer platforms only support 39-bits of
> IOMMU address space.  On such platforms, using the virtual address as
> the IOVA and mappings at the top of the address space both fail.
> 
> VFIO and IOMMUFD have facilities for retrieving valid IOVA ranges,
> VFIO_IOMMU_TYPE1_INFO_CAP_IOVA_RANGE and IOMMU_IOAS_IOVA_RANGES,
> respectively.  These provide compatible arrays of ranges from which
> we can construct a simple allocator and record the maximum supported
> IOVA address.
> 
> Use this new allocator in place of reusing the virtual address, and
> incorporate the maximum supported IOVA into the limit testing.  This
> latter change doesn't test quite the same absolute end-of-address space
> behavior but still seems to have some value.  Testing for overflow is
> skipped when a reduced address space is supported as the desired errno
> is not generated.
> 
> This series is based on Alex Williamson's "Incorporate IOVA range info"
> [1] along with feedback from the discussion in David Matlack's "Skip
> vfio_dma_map_limit_test if mapping returns -EINVAL" [2].
> 
> Given David's plans to split IOMMU concerns from devices as described in
> [3], this series' home for `struct iova_allocator` and IOVA
> range helpers are likely to be short lived, since they reside in
> vfio_pci_device.c. I assume that the rework can move this functionality
> to a more appropriate location next to other IOMMU-focused code, once
> such a place exists.
> 
> [1] https://lore.kernel.org/all/20251108212954.26477-1-alex@shazbot.org/#t
> [2] https://lore.kernel.org/all/20251107222058.2009244-1-dmatlack@google.com/
> [3] https://lore.kernel.org/all/aRIoKJk0uwLD-yGr@google.com/
> 
> To: Alex Williamson <alex@shazbot.org>
> To: David Matlack <dmatlack@google.com>
> To: Shuah Khan <shuah@kernel.org>
> To: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: kvm@vger.kernel.org
> Cc: linux-kselftest@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Alex Mastro <amastro@fb.com>

LGTM. And I confirmed this fixes vfio_dma_mapping_test on HW that does
not support IOVA 0xffffffffffffffff. Thanks!

Reviewed-by: David Matlack <dmatlack@google.com>
Tested-by: David Matlack <dmatlack@google.com>

