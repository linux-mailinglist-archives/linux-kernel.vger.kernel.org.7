Return-Path: <linux-kernel+bounces-841241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A8555BB6978
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 14:09:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B80BB4E92B8
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 12:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F8C62ECE89;
	Fri,  3 Oct 2025 12:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="cQMnkVjz"
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D181DE4E5
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 12:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759493381; cv=none; b=iBoIOZU+x+mpKGsfnmwernnMbxenkoJh+VmEYnBbdFucspKdfY1qq+156CFkHh8fyCTD8PlizjKu3pCebhjQhXanUCs5ZZs03t29jypz93d80V2CGsibLixncuMojfCYIsqkIr15Rczx1aL6xpzB/xuZXRxjMbVSaLROpcV2hEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759493381; c=relaxed/simple;
	bh=IGPBqNUyobL1TuTPpcRMGIWaY8QqCGlZoxv7ahbDfro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IKXo52zuGf0jJt0A8tU7y3hZ3+aJhJKR4yG3C2JueHFvXyDeGLIe9iL9TSjCGSvtaUP0wpMnYiZLQ6vGJe9mWHqquPDQ30E5aU0IEADYlhOiDj5XUAuOzW/zeReAz2xHX6kYaW/eedF8nBZqDfgN1q8r4XEMsGnA+hIZOIKhZrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=cQMnkVjz; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4d9bcc2368eso26204711cf.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 05:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1759493378; x=1760098178; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zhGKQmLihhqwED1FmckHDQNVWwmhyauTuFXOfWk0260=;
        b=cQMnkVjz8CVl+/otKOua+sbtSPvAO4SN5JyepytGIN4AjhiFjmBopJFRmQJm1BXpxP
         8sduTY0rzNdGoKozrjChicUbOVsJNp+LEaOFCx9IrNA/VslXkgJdy9tJKRMbwpLVQM+a
         /UjDhcUSuYOqcBzp+UziR1GzUoR96UqtTRf5Q4BgznvWo8ZT708+ZKU3dL8FIHcc7DRd
         RS67hBkKpLB1FuHd/vR0+hb2ZTrLPisMCzw1cKB4yv00MS1RniTe8b/Xt2fNlTPOgL7r
         7A/jqReWB+rwqHxjop7U5Dm+OLYm7pEyWTA2a1pTvOWKpp/trVjo2Tm3oob6B1pb3HDO
         ElcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759493378; x=1760098178;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zhGKQmLihhqwED1FmckHDQNVWwmhyauTuFXOfWk0260=;
        b=oWcP6dl/TDuFwU1P7e8EOo4GpVsl4OAWBCECMzBoykuYgQot1opLHNFo+PTqXZItzg
         0aQEGpCgqPFaWxoeVqW5PAqmxS4T1QA2gOxfTjwNzZN3RGlNZDYfTOFHdX6qMSDtBhan
         gBattan5L2eyCPiAt783O6xK10MBMQITFXRXEDXFQnAn/rqxwxs5rndOrTAe3V7/AKFg
         EPlMlQsztMkTN5TtrUfS0RZoo+UZpFbz/B5jTUOYPB72yyJtrdV9xuzX7nA2IX0IT2uG
         Wlx1AQFkOion0Vbx0QiuydOLdOHg+9ikWrXFFME4QTwl/m9ssdSpr6vF1v0HTfz0nD4t
         rwPQ==
X-Forwarded-Encrypted: i=1; AJvYcCWtGzFdy6GGCziFVepV1+DvjYtq0Wne3vpom6tnu9u9upQCY6FYKjc8k1UORd6m/oh1wN255Mi5VCrPluE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx70R49hdfDJoWsr6Jhf2DeIOP/4ktmVmxyHH2MhCfTpKSRjkT4
	5TGL6yhUxzv0rRdPgGnBIva9yaDc6c31WisZVHOZA4ZZyxhAhFI3fgmWoCqcSU9hq8U=
X-Gm-Gg: ASbGncsNb6GuMUnHAA5lCl8CWROgSJQIPATgsNGkH1QHW4OB2l8FEuSt3qBnKOYOPcn
	Yf2MgAxrulQYNuaDBn/4c/CVO2hf+R1X7Wq62OCW0GJaFwGGuBnhCWv69Knqe7qSMd/CtnkVMai
	uT+EDbZT4s6BQTXcf69z7uikK8AePC8Xp3117kHD4D7DrnuA7NDsolrLZTJdwjdYAL+PduL7+/4
	47GLtWWuuIHTMyR98dvHS/TzgVsuEvcT9IXaSBJf0dGBhNS7/XjEJMkuzlZZoGIdi4fmpLnhAor
	4ejfeX+lMtjCtKbBdRcBV8KVi6yUjJKRGRck+VY9GWu+gq129s1B9qKUu1+3//ZiQhECdkdNHvP
	aa+zgbI5PVSmQX5DBLRJtG+q5angquCp6mXmWoPyLy0yrliUkq2yEZyyosdlZ5zb7mj77FuRiIW
	+/cSuHw9PU00J/1aY9
X-Google-Smtp-Source: AGHT+IFLcg1ywpHVdK051SrZ5/A9Wb7YpArYuwRz7ad7HjSe533gqbs0gQO57Kylg3jXc3KFtz9WxQ==
X-Received: by 2002:ac8:6f14:0:b0:4dc:82dd:5611 with SMTP id d75a77b69052e-4e576ab8ec9mr34330421cf.48.1759493378126;
        Fri, 03 Oct 2025 05:09:38 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-87771129f4csm410395085a.12.2025.10.03.05.09.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 05:09:37 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1v4ebQ-0000000E4oz-18oI;
	Fri, 03 Oct 2025 09:09:36 -0300
Date: Fri, 3 Oct 2025 09:09:36 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>,
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
Message-ID: <20251003120936.GN3195829@ziepe.ca>
References: <20251001114742.GV2695987@ziepe.ca>
 <CA+CK2bAvnTTz+vPg7v38_1dajRZQHyPQ8iDmziiW8GFUqy6=Ag@mail.gmail.com>
 <20251002115712.GA3195829@ziepe.ca>
 <CA+CK2bAudSHq2t5NZPBKDC2wfzsF6SSxTF7aZ2kxueOTzWYcfg@mail.gmail.com>
 <20251002151012.GF3195829@ziepe.ca>
 <CAAywjhQGQx2_2X8r0rf3AgMDbJj-9C=9_1a3xgiLwuzKLAvXCQ@mail.gmail.com>
 <20251002211217.GI3195829@ziepe.ca>
 <CA+CK2bBJ_RoRuCxiHuraDH4Gya-ZON3S6PE9PgPfsxObvBRY4w@mail.gmail.com>
 <20251002225834.GJ3195829@ziepe.ca>
 <CAAywjhS77-Kw7GVgksimZ8-Oy+kSvCPpL8xQfJt0eQHwf=WH_g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAywjhS77-Kw7GVgksimZ8-Oy+kSvCPpL8xQfJt0eQHwf=WH_g@mail.gmail.com>

On Thu, Oct 02, 2025 at 04:56:57PM -0700, Samiullah Khawaja wrote:
> > So if you have a notion that finish is disallowed and when it is
> > actually finished maybe the order doesn't matter?
> 
> I think FINISH for FDs in a SESSION is not atomic. If a dependency
> memfd gets its FINISH call first, it might make itself mutable before
> the iommufd FINISH callback fails because old HWPT is not replaced
> yet. By then, it would be too late; the memfd has already become
> mutable. That is why order would be needed.

I'm thinking of having an counter in the session and the iommu_domain
holds it elevated until it is destroyed. Finish can't even start until
the counter is 0.

If the counter is 0 then it is fine to unfreeze all the remaning
objects in any order.

Jason

