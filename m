Return-Path: <linux-kernel+bounces-865043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6111EBFC0F0
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 15:14:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77BEB1884550
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 13:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F0ED347FED;
	Wed, 22 Oct 2025 13:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="OTdjX9Ip"
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE108347BDA
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 13:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761138139; cv=none; b=DvsfWeKCK3mZf3yx3bLxKoHuD/wEsX0yBFTbM1F5RImH4wyD3vsDbhL0vAWu7hQntDFaxqrggqQOHOAa7dCm+RAm38HknN8NK1gXQwMALeJOiYFkHkKfCzCyQ+s5y4FHW7WJT0ei8H75dS+PZBOvkYeRFwFB/qs11eydvmtlTp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761138139; c=relaxed/simple;
	bh=lancp4F+gIJloseWretT9AZMSRcc8xPslAj7fQu0OfI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cr/2U3LrGNGVFrSyc8/x4cs64SwlMF5ZENLOr9pCuFWFCcuTp03oiHxsP52HT7G+7lZu2SL62+m4QGE43yTMJ8qvI3ag+yw3aXBP3XZcRPXeuJQ+4E/oABzUZ9Hu24Ns4jyTX9+y80tE355uOavmrKUkPsE6B+RwgIhePNNJQ4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=OTdjX9Ip; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-88fa5974432so894870685a.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 06:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1761138136; x=1761742936; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=q4+nptwg+b4cKjk/7eopK4TdMQlKGxJAx/ff9A8jy1A=;
        b=OTdjX9IpeyqrtY5NsIXVyy4/NNMoO/15SGkB752CL6RNiFDilySoKOcM5vP85qeP7j
         ePVY4fnMskzqfRw4fitQdPlkdyaNgdwjNQAhclLxkifNcnjogOWHcVwhXEegWCSE5PHA
         n1wnpmDiDS8c6GXosTGn6Lj97fgX+ApDH1sI60Qo2N/9ZpahbJMSSG9CIdJlbo+xve4z
         xSdoYi4r0B8ML4PDpZIMWVcXp0FewP64bILtLS4vIuCaKWT+sOfCufjhJkvCBKiEufxg
         GHfu/9na6a4qdkuwXzRLXVsm/025iLO130PWeP/+OXndbzrBNVt4dUOJ02Mzp1QkIhQz
         crpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761138136; x=1761742936;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q4+nptwg+b4cKjk/7eopK4TdMQlKGxJAx/ff9A8jy1A=;
        b=pj13AIRSB1oLj+lzu5WnviPNLsELglNBJvcjklMpO1mvQnESgpr5Pzy4Sq8/N07xnU
         xHT/XM3qyljrFEbn74sr9bcpFUV8O/l8MXKXlRqBqiGZUmvRPXzpoZPpoQ47CVImqxPC
         hV9bQ69cZyHIpXLpgyBBU9azbApJNGik/Fodxu1l7SfcXFK4b9OE7Pdl7HGSkILlacyl
         mTBADgrz++r+Rt9x76Updr4RF0XWrCd8HgjRZT2Bu1PkoK5CChxec6vBPDh9q/BahWa2
         wcKh00i3iJFmvRlAtbcHpD/rWtefU29t8G9QuKsgvPmjprhzahmEQVF/Z365oFDkPp0X
         txTw==
X-Forwarded-Encrypted: i=1; AJvYcCV8U0XY8k88GY+SPGQe+LWrCBBIssLyAxC7t5oIXaGmNfDawCrccsUDKDkvqS+QS8tAT4UeAsVaz+0XRVE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYhrnhvsFxub8SqY3GICUMHSmuQssqT+14LZlLPuTLkcpLAFdJ
	j60w/RkKsI7vM8UmEJELi/5mv8bwt42FHXxJ2VHhwoIJkrosW+PfcVvDN+TdBMYi1LU=
X-Gm-Gg: ASbGncuqvecpVd+AhaNdrXhudxM7QZVfoW4IsvkyCW/d6hjdn4l+M1fmGhuS5enS/qu
	TrWk+mBwrETfvQWS1C8E3Gtfn/6itRMhytjf2o4ipPW0w6r+CNHXGdU4n9la1EcjBq2HfHHAzI5
	kBsus2M+M3AFWXp4twxxZvHQ3UEdSFtXZxldDK567Kw4PjaLmTpPy0nPX0ceWH8Lu6ZQ7AeMo66
	55tchMk3UtuuX6u1oqAF71OCSgZgRLOVdhUNZcPFXt80nbjDOVsb0OZnI2GxVoSKcevUL48u8vs
	wAauEEiQqz5HB+nCoJNq0e6LCb7RNjfkChsdkENHo5PeURCfNZxTvdmDYiZSBuVV2Wn9s4KaBYJ
	6kQFSfBfdEzQTYaIOON29YcvccjuwuOEHcwYR/18bsHac041LlzPOFlGBAZ1tsuH9BZVHDLsUtT
	QLYoUFAqMr8lzDIAz+BW1W7IBfvl/ObQauy6PIa3V5Gc2fdQ==
X-Google-Smtp-Source: AGHT+IE1fp7nysFYiIihX3mwCtCavGTxjXwNOEmPOD6TCnzoLGlT2YOfHP4QDFq10IqJKetGapnVeA==
X-Received: by 2002:a05:620a:171e:b0:891:bde8:8120 with SMTP id af79cd13be357-891bde882e8mr2006535485a.85.1761138126706;
        Wed, 22 Oct 2025 06:02:06 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87d028a9a48sm87209396d6.43.2025.10.22.06.02.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 06:02:05 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vBYTc-00000001288-0pdQ;
	Wed, 22 Oct 2025 10:02:04 -0300
Date: Wed, 22 Oct 2025 10:02:04 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Matthew Brost <matthew.brost@intel.com>
Cc: =?utf-8?Q?Micha=C5=82?= Winiarski <michal.winiarski@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	intel-xe@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, dri-devel@lists.freedesktop.org,
	Michal Wajdeczko <michal.wajdeczko@intel.com>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Lukasz Laguna <lukasz.laguna@intel.com>
Subject: Re: [PATCH 26/26] vfio/xe: Add vendor-specific vfio_pci driver for
 Intel graphics
Message-ID: <20251022130204.GD21554@ziepe.ca>
References: <20251011193847.1836454-1-michal.winiarski@intel.com>
 <20251011193847.1836454-27-michal.winiarski@intel.com>
 <20251021230328.GA21554@ziepe.ca>
 <aPgT1u1YO3C3YozC@lstrano-desk.jf.intel.com>
 <20251021233811.GB21554@ziepe.ca>
 <aPgwJ8DHhqCfAdpk@lstrano-desk.jf.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPgwJ8DHhqCfAdpk@lstrano-desk.jf.intel.com>

On Tue, Oct 21, 2025 at 06:15:19PM -0700, Matthew Brost wrote:

> Ok, I think I see what you're getting at. The idea is to call
> dev_set_drvdata on the Xe side, then use pci_iov_get_pf_drvdata on the
> VFIO side to retrieve that data. This allows passing whatever Xe sets
> via dev_set_drvdata between the module interfaces, while only
> forward-declaring the interface struct in the shared header.

Yes. The other email looks good:

  struct xe_device *xe_sriov_vfio_get_xe_device(struct pci_dev *pdev);

Should call pci_iov_get_pf_drvdata() internally.

And 'struct xe_device' can be a forward declared type that cannot be
dereferenced by VFIO to enforce some code modularity.

Using strong types is obviously better than passing around pci_dev and
hoping for the best :)

Jason

