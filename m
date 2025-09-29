Return-Path: <linux-kernel+bounces-836513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2008BA9E73
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 17:58:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D81B19225D0
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 15:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C13230C0F8;
	Mon, 29 Sep 2025 15:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="aX4aEQaq"
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 468E01FBC91
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 15:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759161513; cv=none; b=D/T6dynGgM8+kkm4fKIXujasTww2d4OqfK/6OaK4WOkU2SAG3SUo0FJz84CPI4CFVYdY62Kv7uEHpYfSxImh1nHJHjAJV3ijNd1FrVthSLYyvyOpnbgQE3NaLsLkTTIiLLlYDIvE7ghtLktfyDtINOBj2Tc3nN9wKnUQpaDxMmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759161513; c=relaxed/simple;
	bh=P6iSZrEA/YPYWO+UCPUFvza9CXfBeI+xdProSqT8BsY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fwD5Atwi56bmVUySZlMsL9z9uOZzkmfAmpID9KK/SS1YR/15qX39rvxYaNpDjDti3Q+S8Jo1H8EJF7wCnTjZVchbrrwX0jMacyYZ/VDdmWJpev50fRerjCo0Zco9DcDG+Wg/r8ITRmu6cih/ocpK9spALCPFPVe0/n+WvxCCIMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=aX4aEQaq; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4da7a3d0402so59689491cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 08:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1759161511; x=1759766311; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dxJ0qKWOx+cSASEP9w2+fK7+laPa94t64M7wh97we1o=;
        b=aX4aEQaqFhNb6RB779eQj8C3JmOV4UgZ4RVkzdNbwcGm4h2LA72v1i6vKoFM07N0h2
         BPDEcf+20x43Ht//gKTGNzBMCbZdX07DzsgzUEDQI35hMDn//pLMr8O/VF2O9q4gGEc6
         6J1KJAQ2IDwse/46t7ySF1A8fRT7lbRwZn22Hw3qO2okf+r/Fa9Qkb8VlLXKos+ioRCz
         jmTLG5+feXBMUE7XUK4EPARUB3ZFsSAP1e7nrk/h9FTw8SVWVKDryJP5XLeIXdwMJqmp
         x7GO0K1FcQgqyO0uDy3X8LvYq8mRvmLnC87gUj3bEcK0m4bDgoR9X3jr5sDzSQsNqKxc
         3gaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759161511; x=1759766311;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dxJ0qKWOx+cSASEP9w2+fK7+laPa94t64M7wh97we1o=;
        b=o14jYIu0YyGuWfM1FNcrsBLEdD/yQpjX3KrGvGmpO5be2BF2EYcpufVJNiz+qTACFI
         zQ1TI72Hoa88Cz3cODmu+cK8cB7oD5axBZm2OkrccnIxworqovbmpIshDkh4m3gmpWQD
         1Rs1vRhe+CIn7ROv80CRtGQ2VkkHFjTSC/bCMvtFVf/y/hsi/+huHBzrllbxiljW92ML
         Fw1DIwwGt62YY31y/NUw+xvP4nX85jPq3qKkiipNCMA37nWBTFkE4eSwi9BDfHS5asIf
         Ac1XVqH6X1TiJYtN9MP9qJDG2Ou0H5voHI/OXkucyUf07dH7cPVw3rrOz+8daQi2maf7
         2T0A==
X-Forwarded-Encrypted: i=1; AJvYcCUFyP8K0lCKHU9nUUp1gcmhS6DYCA9uaE7I0R5nvPDZ8HxmwuttvY2uPUpA4LLs31/TSaRPtyk2mcuVrrA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfbE5NvAOtPBS5k9ChVwrPQCAPrCbe8CQrPkxtLYWSpM5I4txM
	pjbK3/7rE97czkwzoPtbPMOm3ZxbjOL7g+evsnC85+L7Ds6kT4XR0HuDDb4mIETMu4E=
X-Gm-Gg: ASbGncvysQdHFUWhnrfeMc5OybmPBjebfblDmoEoS/kNmzyX3C/gzmNp/zidIjqA04k
	NFyaBhcjx75ba/r4gUz/dYRxppE6W/TqidYQLNkWpC8oOP94kgQ+NETBQt2GuSLUMJkXzi39PlL
	yhFeOnIWLfpLCrpvxTxVA+B5dTB4p+UXhDVaf/dnCZkart+OA9yKZy/HWLQOhe1QxCJaAUDxUb5
	8k3kNPml1jK4F1Ub7vD2LOfGEXzs/z6W5QB9wQv+PZAievNsgt+yVFL05DQ/QTCAsRdrDGzwUY2
	E0JEYtcxrg4e9Lv1Ki5anh8pYt5wPW4+Rvn+i1Rnh2xCykr3qV6wcAU6DdxoQVCZTH6QxLOE
X-Google-Smtp-Source: AGHT+IHNnZXawXbmz8noNW8yGj4C8jUeWu/3D7WDH7w6uaVVY5Fc3SwyDdgjyOZjCL0TmpCccKGgKw==
X-Received: by 2002:ac8:574a:0:b0:4d1:3dcc:ad36 with SMTP id d75a77b69052e-4e2800bf8f7mr13336021cf.40.1759161511025;
        Mon, 29 Sep 2025 08:58:31 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-85e95e91765sm779413685a.46.2025.09.29.08.58.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 08:58:30 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1v3GGj-0000000CM6Z-3Hag;
	Mon, 29 Sep 2025 12:58:29 -0300
Date: Mon, 29 Sep 2025 12:58:29 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>, iommu@lists.linux.dev,
	Robin Murphy <robin.murphy@arm.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Kevin Tian <kevin.tian@intel.com>, linux-kernel@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Parav Pandit <parav@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>,
	Vipin Sharma <vipinsh@google.com>, dmatlack@google.com,
	zhuyifei@google.com, Chris Li <chrisl@kernel.org>, praan@google.com
Subject: Re: [RFC PATCH 09/15] iommu/vt-d: Add live update freeze callback
Message-ID: <20250929155829.GF2695987@ziepe.ca>
References: <20250928190624.3735830-1-skhawaja@google.com>
 <20250928190624.3735830-10-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250928190624.3735830-10-skhawaja@google.com>

On Sun, Sep 28, 2025 at 07:06:17PM +0000, Samiullah Khawaja wrote:

> +static int intel_liveupdate_freeze(struct liveupdate_subsystem *handle, u64 *data)
> +{
> +	struct iommu_ser *ser = __va(*data);
> +
> +	ser->iommu_units_phys = __pa(ser->iommu_units);
> +	ser->devices_phys = __pa(ser->devices);

Why didn't this happen at an earlier stage? It makes no sense to some
hacky naked __pa

Jason

