Return-Path: <linux-kernel+bounces-841384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CED7BB72C3
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 16:23:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 549DC4A0241
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 14:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FAEB23C4E3;
	Fri,  3 Oct 2025 14:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="t21BLodu"
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB48A224234
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 14:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759501398; cv=none; b=QQO+yg9BCeafYAgnYvfNvbv2b9UwIQthQuF37umMZWHiL6ygpUlR2CFQhkh6qFmoA9P3p/B6DcrrYFebdtryv7HBMXViFgYx31d0J9ol20YU9FD+uHNiZoPcSMlQPAvhXX36dsW2R49OuSB0TUorPnMiBk5AlkaqF4Mslbguk4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759501398; c=relaxed/simple;
	bh=ZNLnSKgncLVUeolihAdlLxpg3H+yQFxMlDR0Lih5oq8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MVC4/tloJBLzsZ6OeFNWMZWxxcCyCKxT5wiPk73S0EcV5/28Adpte/3HXTMQ5N/7aULahOY0oZMVYz8L60tFRDA+5u0uZDZ/vVK/N3aTDrk8qLpgZxL/qUJyekmFIA8RYPxQ5qPKlIfkmvDYWK17ny9a7SeAnPwuEpQ/qxThplI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=t21BLodu; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-85a4ceb4c3dso229803485a.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 07:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1759501394; x=1760106194; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TjshectPsoU5xexsh0W+Ld8Cl13e7LDyb1Q/bzYB9s8=;
        b=t21BLoduIcBkV6cwRIewUUSB/FR0EiQHy4rQgIBtmcdDTuzOSCJ3SHj8lBurq/rbnZ
         eSbTbMkLU8gcJFhBiLnJ9TamDAIC/nskd70L9Abrbztd/npm3Lq0B3Aj9Xt8fkE7rlE8
         cxag7qRKvhs/zXYp95CkoK+CE24K9+YpuUO3Szyctw4pE6HjE4E0sNH/CvRTruV83gM/
         FsFGWtjZ+2mwL/y/ONt4dih5kT1Fm745hyt1IK01tHK5lPrmViVWkaPw78+oEP5QPFDf
         PLu7O6S2IJjFeArAy5Eq9tYTPjwFMGSC4SYlzqTwjVhIidnmgMgsKLeQvYu65waPM1Rb
         Z07Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759501394; x=1760106194;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TjshectPsoU5xexsh0W+Ld8Cl13e7LDyb1Q/bzYB9s8=;
        b=piBwUypecUMiboW/Dajn46DYRnZqSLbHUibQxtVaP2Iqg8c1g3nAau18qJ9EVoP7fm
         JQexxklkldFw0l0YvZlnNeOsOYIokDosHTSTpkgP9AELUP7f6k5yXREza3MhHaID/+Qv
         RUHYIKnUXe6faLbSafS/y0N7+r/3+DwMSvpcMNY4G5MInGT0vtbpq13xGkZEARCS48+i
         aIoQuZa+b3cK/s6hypHpviIX4wTJz6AyP2PrIQFct1dy7Dj/Rrp042c3E0s6PIvH5OQp
         QWHLNsRYozSNsYqHDiPtasxI80B0JkwW9HVhy/hQGMmmkk1FZbUS2igiyFGS/BEC8NUQ
         Q4og==
X-Forwarded-Encrypted: i=1; AJvYcCXrWSFBphgcNE5lxLxX8X1ZbhUmNu1ic/a/JBJYhtTyqZXo3dcY7zGOQmBufASKpvM8LHN+3MEKFz4rBxw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJrHhdNco/VX4wjmrYY5OZB22jEftPUKkewfC7E1yrgWQqVwIj
	bGd21j8XX5Hhxv9chxaWI+ZGo1PtYS9wHWg8UxINtZ0nfxI7zUiqhDk7yP0njuNoyGA=
X-Gm-Gg: ASbGncuWaWO0NlHmil75QtGD10GOGRyimLw7j+v23em2Q2tHd/vBfxh3sMojeMK6kje
	tCQ4id/nz5lnHBhIHgkWMOTvuYPMvPhnQKnT6hoEk8dAur+DhgsfSjHkwABT/Zh/96kPI2cabfw
	hoDjFKGqGFJQHToQupUSqmfKPsyYWzSBIcbLvS6rancOF129HokjAWdqkZwXVIhKMHePtF8HoVJ
	LTZt2bCUcsulp5guhOXKPnnnI7QTWL9GcJ8HwYffo7l+FVoDhEEl982MAj4ri9K7qEydqKf3W0o
	Hd3NWixWq/YnnXti6jZo4bSwSEoXUuQp0Yv+leodJeiN6KbUusyYBbRDIaOHneWPlBHQNHZp1HS
	3U0hzN2vMPodyle/c4fX6+vJnJSQE+54KEF9563JNZv2nc0qa1A8eLCUZrZfdsYomDnBKpSoUlD
	zQI2b0MroA3UU+lVMFcZWlsoc0VpKShN8x7Tvi8fWP
X-Google-Smtp-Source: AGHT+IEGOuseBzlPlNuROJrG6WSd4huQymSIrENqcNpGScmGjW7j99oTy4VgsNRVtRatqijlGlv6iQ==
X-Received: by 2002:a05:620a:1a8f:b0:818:dd40:405 with SMTP id af79cd13be357-87a38377379mr466910185a.64.1759501394537;
        Fri, 03 Oct 2025 07:23:14 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-87771129f41sm427021885a.3.2025.10.03.07.23.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 07:23:14 -0700 (PDT)
Date: Fri, 3 Oct 2025 10:23:12 -0400
From: Gregory Price <gourry@gourry.net>
To: Vishal Aslot <vaslot@nvidia.com>
Cc: Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Li Ming <ming.li@zohomail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Zijun Hu <zijun.hu@oss.qualcomm.com>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cxl/hdm: allow zero sized committed decoders
Message-ID: <aN_cUPzzwUy-s36n@gourry-fedora-PF4VCD3F>
References: <SN7PR12MB81316C958DF0F4B10369B928BBE6A@SN7PR12MB8131.namprd12.prod.outlook.com>
 <aN4SSEmaCaxbeiwJ@gourry-fedora-PF4VCD3F>
 <02a4b5f1-ad29-4825-9040-ff96e328f674@intel.com>
 <SN7PR12MB8131EE31375531673BCF0C62BBE4A@SN7PR12MB8131.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN7PR12MB8131EE31375531673BCF0C62BBE4A@SN7PR12MB8131.namprd12.prod.outlook.com>

On Fri, Oct 03, 2025 at 01:03:16AM +0000, Vishal Aslot wrote:
> > ________________________________________
> > From: Dave Jiang <dave.jiang@intel.com>
> > Sent: Thursday, October 2, 2025 10:32 AM
> > To: Gregory Price; Vishal Aslot
> > Cc: Davidlohr Bueso; Jonathan Cameron; Alison Schofield; Vishal Verma; Ira Weiny; Dan Williams; Li Ming; Peter Zijlstra; Dan Carpenter; Zijun Hu; linux-cxl@vger.kernel.org; linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH] cxl/hdm: allow zero sized committed decoders
> > 
> > External email: Use caution opening links or attachments
> > 
> > 
> > On 10/1/25 10:48 PM, Gregory Price wrote:
> >> On Wed, Oct 01, 2025 at 08:37:26PM +0000, Vishal Aslot wrote:
> >>> @@ -1210,6 +1210,11 @@ int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm,
> >>>                 rc = init_hdm_decoder(port, cxld, target_map, hdm, i,
> >>>                                       &dpa_base, info);
> >>>                 if (rc) {
> >>> +                       if (rc == -ENOSPC) {
> >>> +                               put_device(&cxld->dev);
> >>> +                               rc = 0;
> >>> +                               continue;
> >>> +                       }
> >>
> >> How do you suggest actually testing this? I briefly poked at this in
> >> QEMU trying to commit decoders, but i found myself incapable of
> >> exercising this path.
> 
> I tested it locally with our BIOS (UEFI) where we commit and lock all decoders and
> all except decoder 0 are zero-sized.
> 

Ahhh, so are you saying that you will only ever observe the following
(as an example)

endpoint decoders...
decoder2.0   ->  available and can be programmed
decoder2.1   ->  size=0, locked
...
decoder2.N   ->  size=0, locked

or are you suggesting the following is valid:

decoder2.0   ->  size=0, locked
decoder2.1   ->  available and can be programmed
...
decoder2.N   ->  available and can be programmed

~Gregory

