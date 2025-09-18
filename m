Return-Path: <linux-kernel+bounces-823008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87B85B854B7
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 16:40:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EF1C1686CF
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 14:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A987F2D7DFC;
	Thu, 18 Sep 2025 14:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="CMShhjfV"
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B4DC21FF23
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 14:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758206214; cv=none; b=AEJJnngldRF2CP69ti6fnWhRFl8kZJ2HrprEDuI2+zUX+VmYQhvfIUYWT8vshoi5tEC1Byb0vASvo3lqNjN+oeFDbGTdqPAUmxPkaq0tHWKbMCfXZa4qfAsK0X4OQxyWBkz8neMU7Yk2H7bYQBtvdTiOdI3bcsADlgrV3ILCIik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758206214; c=relaxed/simple;
	bh=5IK6dxmlUx1MjIUb26gztFgKXFnJCShruWZFcwG3LWU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qoPSkv1xKLdCGEdWeeg/M/X8sCu2z6Z5GHE3KJV97H25I1fMUgmOZSp9S5rcCxm2QlkUEIso7e0qRSSJbv4hftTXy9hxjorPkDOxtrQ603tJuuyCQRJWMFz+P7TIk5SnxZBL5p9dkyyuvQPhcOlYC5cjE24qHq+8Z3Sqvjh2QhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=CMShhjfV; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-80a6937c8c6so124363785a.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 07:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1758206211; x=1758811011; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zrVmh9WioYbmEoq4Y4G7QBMqeKPDVKPWX4R50WAG25o=;
        b=CMShhjfVNp9kSpIX9rW9KdF0yczTckBHGjFTwVf/tNXMLZUJEa+Q7KdGxVRz+nuPxX
         yeFDml5n8N103ba2j7Il3RPBwc4rlAxwqyQ3jHHjhMdKtuysM/1GskEJu7HE+vkpXKED
         WtKotS/6OOken9cIh+wGBuiFycGYGSQZ9e2xr0Lb2bHHun1MFJO8O3OJlJBZGeHG/qhW
         BgJxdEaE7LVr/dnugKty11vQRD/HaOcOxMjUkJnBZlwn5MGxahhEXdJrCqZ86rxZDrDw
         uOe7KIfYu3+VMATMhRBcYIh9vdJMAnsuHlpRjqDhsP4YRdM+SlGrEo3PJetsB/Gu7No9
         eAiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758206211; x=1758811011;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zrVmh9WioYbmEoq4Y4G7QBMqeKPDVKPWX4R50WAG25o=;
        b=Dv+/KJKYbRn4R9JyNOTRUQTCtU811pkR+lstqQnLul2Ke0fIOO604XyWgP9WVg8O6A
         KqIxlmxnTAuiJxxtFptyQLzk1VfEFUNAd5FLue5/X58Ao4c1XUUavxMZGRxZ6Rn9GRkJ
         /HnWj0fbtjyQOoDywU7IETyB9JktaTwVrTQffXXlSv2SXZKdK8azdpG1Zds0RpLIAj+q
         zG5/E3/IyXNENdXLlbPjWTKX3dLMJQr32cPENXEMcm4YG5wmILncRQvlJx135ylGPUg+
         DdCaoXJKHQpoiqZNfjBh+5BVFOALRx6FKPhTqlPPQUhK8Q8ZsMElXgSWq2FzELrcuVK5
         YCmw==
X-Forwarded-Encrypted: i=1; AJvYcCVggzeXwl9/TJhMHuAUmdSB/4tOdevARIBuxcuZB1FpNAZ49Ni8y2+eogwXQuFB1LCfWMqsmQOIy3a6osM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzdhsq1kpKwBSYkrbCS2CJrq6sWYwCwCNB5P5Z1FVyeLbaDkGf8
	NKYPBAh4fNycQFgVJ89ZHQdW42QRTatCHNbu4AOVCqmYy5VJJbBFimLqo7AKqnKRdj4=
X-Gm-Gg: ASbGncv2FA6BSAFVYqueJl0pCsGDXhLuW0i8FS1++36jbZH2XUsAkDAOfD7dM7vRN7U
	ydVZJ9jbbgrVlcQ+5IdumYpZj34vaYk9NHmWEzgwAn/h/b0sHuMx1bahPO60Z/Kb6bb+l55tl0y
	qkJDJJ4PnQYMm7rVlDfpjp6Vw/HoQvGGPMGoTrm9HhL/PTr4sO9yOAoRiyATQaDPjwhwKAsJ9rH
	yy2SnfAS8IoqoqT7DJ3FKVfvPns9wRXeIhwhr5V6EzECH0QLDlF7vh1Wcs+dARTdwzyL3hTeOBG
	li2CmeTvpOe28evvAuCngFLi6sJYuP7JY6d1KRr/PWmyAC9pWbjj44OwNFDlT2x22Rmq6yGSQno
	07zbmib3dbZgBr7y0KdXTbGwG/DrY8ap7ieHAMuMqrrs2r5zVhtaKyAQfMCanxYrUp8jfpIOLiS
	gnBoOBnrvH4wg=
X-Google-Smtp-Source: AGHT+IE8/5Ud/i8k8I1bre3zwyW5lDIdJBqEnB52NPRTieNqwTGZ6V2Ab0vPLtj2VgmwLHtb5fpg9w==
X-Received: by 2002:a05:620a:4152:b0:806:a07:9fc5 with SMTP id af79cd13be357-831085ab77fmr631920785a.24.1758206211361;
        Thu, 18 Sep 2025 07:36:51 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-83633b04dadsm168450785a.64.2025.09.18.07.36.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 07:36:50 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uzFkg-00000008wHU-1PaB;
	Thu, 18 Sep 2025 11:36:50 -0300
Date: Thu, 18 Sep 2025 11:36:50 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Will Deacon <will@kernel.org>
Cc: Mostafa Saleh <smostafa@google.com>, linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, maz@kernel.org, oliver.upton@linux.dev,
	joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com,
	catalin.marinas@arm.com, robin.murphy@arm.com,
	jean-philippe@linaro.org, qperret@google.com, tabba@google.com,
	mark.rutland@arm.com, praan@google.com
Subject: Re: [PATCH v4 22/28] iommu/arm-smmu-v3-kvm: Emulate CMDQ for host
Message-ID: <20250918143650.GQ1326709@ziepe.ca>
References: <20250819215156.2494305-23-smostafa@google.com>
 <aMQroI4NDu74PDGT@willie-the-truck>
 <20250915163858.GK882933@ziepe.ca>
 <aMl_5j8G3IGulAC6@google.com>
 <20250917123601.GA1326709@ziepe.ca>
 <aMrNTny9jgZJd_Ef@willie-the-truck>
 <20250917151612.GH1326709@ziepe.ca>
 <aMrS71vQ_MaVonzi@willie-the-truck>
 <20250917155931.GI1326709@ziepe.ca>
 <aMveas3QWXUk6xpm@willie-the-truck>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMveas3QWXUk6xpm@willie-the-truck>

On Thu, Sep 18, 2025 at 11:26:50AM +0100, Will Deacon wrote:
> On Wed, Sep 17, 2025 at 12:59:31PM -0300, Jason Gunthorpe wrote:
> > On Wed, Sep 17, 2025 at 04:25:35PM +0100, Will Deacon wrote:
> > 
> > > Ah right, so the driver would unnecessarily issue CMOs for the structures
> > > that are just shared with the hypervisor. At least it's _functional_ that
> > > way, but I'm sure people will complain!
> > 
> > Yes, functional, why would anyone complain? STE and CD manipulation is
> > not fast path for anything?
> 
> Won't it also apply to cmdq insertion?

Oh, changing CMDQ wasn't on my mind..

Yeah, OK I don't know what the performance delta would be like there.

However, to get peak performance out of pkvm we really do want the
SMMU driver to write CMDQ as cachable, pkvm to read it as cachable and
then copy it to a non-cachable HW queue.

Otherwise pkvm will be issuing CMOs on fast paths :\

If we convert the slow speed stuff, STE, CD, Fault to do CMOs then we
could make a fairly small change for pkvm mode to force the guest CMDQ
to be cachable without CMO. Some special feature triggered by pkvm
detection during probe.

Jason

