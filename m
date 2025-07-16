Return-Path: <linux-kernel+bounces-733491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E06BDB07557
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 14:11:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15DFF4A31E4
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 12:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 489F92F50AA;
	Wed, 16 Jul 2025 12:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="NXbw7B8D"
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 167D92F49F2
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 12:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752667844; cv=none; b=YujRBWkyMN7BhIB9VdTdMM2/rdtWoHmaxV0s3Q+NjlQR7uJcsynKDI+R1RLWZ6QLilM57gtGYOtA42W2pnOjF2syNke03GF+GvCVJwKok+N35JjLlTFudBmki9IGTOtl63lgnMZlvOmgPeglC5t+mo4sfB26LtxHH7rgQPdi94g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752667844; c=relaxed/simple;
	bh=DqrxxRzNrVElQiSFybdiqSTB8zLMpM9xyST4z/mLO2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XUBsPwxnxL0O52U16q8xME9rHZZlzTppBbi/1FeS3wuTaHdwktxifI2lrzPHYB373o5FK5e0ZBUTEd/G6vO5yfYxYynIrEEXw/0ETK0TxaKceDr4oqih4s4TP9zIH5KRmp852wu9UgoZe2agu9slMrcE+gyeo3296yzCy1v92Zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=NXbw7B8D; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-702cbfe860cso61151326d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 05:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1752667842; x=1753272642; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WIP3ya1BLuzxXr6bkJRT0LOoJh7qbBYpTnmvsHp5Va0=;
        b=NXbw7B8DwUBhfMUH17Cyz2zgE6kHg4vP1f/G+kjMWkL1imyVEzI18mrUVwVZTzvifU
         H0f3U+cgmGzXyGD8v9qIPNKSbF/WskJCsEdOEpYC1JUgOF67gcSEzeHRI2qhJsVjkR4N
         5POR77yghfIbjNVwCJJ/x8lcCndosm+fno1YHPt1RZAYJUZjsbKY9MFSvoJPcxMV8koq
         hYAh5WWlnL9NSr7D/+3k6RkZDd7pOB5iMnTGLSsngFrMykj45mq1DxALw3E4JkPLwrHc
         NcIX+flLMipvi/uz1LaCFIWGanTPRzn+VxwUg/Lpgd4TYX/Mfg49E0s4A60SK665mCZJ
         0z1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752667842; x=1753272642;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WIP3ya1BLuzxXr6bkJRT0LOoJh7qbBYpTnmvsHp5Va0=;
        b=WrINfOq/PFSDUpCJSKIiyky2/vCsgw/o1ysHXVz8ef3Wfg1rt07GEmmldTn9wG3gZi
         53Bzq++PXz5BLSaVQ9n+rWv1Motnbe/CrfGGVt8fwsW5Agzx/h1QhdGDxP9NY8g0xf+c
         TJP5sr0LGmpdCnxohobp2x0tr7s9Y4N6ALl4z69+EHOG2/twd//zRrh2ShTFpXKH82lW
         5e3k+10hmcPSu6M3fdjYwnzxran8iTIwOSict2tJz5GMApcZDpccqbqc0AegZZf1hDbY
         xk8IeLO3IIfKGh2RYNOMhUPf2GvvJWF6uEP0VHaDA/Q5JLiQRZ8q4PcRSoiqG0T+n6JU
         c7GA==
X-Forwarded-Encrypted: i=1; AJvYcCXamNfb/XIN1zizTSw/RAxWcyOJgjcP8wJBl/q8lljwOoKJcLFws3oky0kWHNb1lntFjQUG+h6zSNc4EVg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdG5/iuph54KUAN8/qzwIW4LBMZCPORv76q+b/iWDX3DNiKk8V
	NfMIPanOCEXWMcE14dxyuDraoMlwwKP6ogx3Ti0XcrAZcoJ+Tzr1QjOPd0tc+aawEOE=
X-Gm-Gg: ASbGncserpuDC7q08ulwFbPYohGS5J+g5N6pUtJpNfvXRB5plujA6c3eqIqQKRFYiS8
	vxFZwnWpQVrVUJ+TFyqTtJFvSYdMVHODTwc3mC181P5u88NPDrMAslooEKCi787w8IkQd/zrKae
	/eObot46kFjJF14olWSjLOIK6VlOo/QCoVvTr02pM1LO/BZcJeW6kGJLPUHSkxkzwOi1H8nRWF8
	a6F5jS4DDyv5jn/fyEFMrKNj84bkzTCLUCkJx/5IDTY6HdIRhtbxVHLhYi81iCgk/toaVBKwGLL
	PdAUph1Z2bKpnwFXFQRv3s+XqhISE/KP2z4qezFubd3udSeTk8c3w7a6uDVuma2JSPg8i4ssxNA
	CYkksZ22RwbGLOsK2jUnb3Han46QY5nJu3uAPC5AFggobXL4UWCV7qx4XSSBKFX+IcR4npWsj9A
	==
X-Google-Smtp-Source: AGHT+IEaMMoAabKIvy/6hUm3Pz2Mj624nFTDoPAXqr71BGISR01CFU/2f0dv9kGGDC6bv7sfs6TmXA==
X-Received: by 2002:a05:6214:4283:b0:704:7df7:c1a0 with SMTP id 6a1803df08f44-704f47fa4bemr46732856d6.7.1752667838252;
        Wed, 16 Jul 2025 05:10:38 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-56-70.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.56.70])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ab3d44b3d6sm51417661cf.56.2025.07.16.05.10.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 05:10:37 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uc0y4-00000008xUh-2T4l;
	Wed, 16 Jul 2025 09:10:36 -0300
Date: Wed, 16 Jul 2025 09:10:36 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Temerkhanov, Sergey" <sergey.temerkhanov@intel.com>,
	Dan Williams <dan.j.williams@intel.com>
Cc: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v1 0/4] Implement IOMMU SVA page fault processing error
 notifiers
Message-ID: <20250716121036.GA2120051@ziepe.ca>
References: <20250710134215.97840-1-sergey.temerkhanov@intel.com>
 <20250714145658.GH1870174@ziepe.ca>
 <MW3PR11MB46813837E82395797CEE39AF8056A@MW3PR11MB4681.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MW3PR11MB46813837E82395797CEE39AF8056A@MW3PR11MB4681.namprd11.prod.outlook.com>

On Wed, Jul 16, 2025 at 11:07:50AM +0000, Temerkhanov, Sergey wrote:
> > -----Original Message-----
> > From: Jason Gunthorpe <jgg@ziepe.ca>
> > 
> > You need to come with a driver using this as well.
> > 
> 
> There is an OOT driver which would use this facility do report and
> handle possible invalid accesses (e.g. mismatched VMA permissions)
> during the SVA operation

Upstream a basic driver first then ask for iommu changes to enhance
it.

This is normal stuff, we don't change the kernel to accomodate OOT
drivers.

Jason

