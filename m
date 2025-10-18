Return-Path: <linux-kernel+bounces-859332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA987BED511
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 19:24:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C64814086C8
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 17:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B061258CD7;
	Sat, 18 Oct 2025 17:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Aau/TK8n"
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D90224DFF3
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 17:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760808094; cv=none; b=fUL/sARmUNKg+4jArH73uaFH/0i5RHXJRsltnYD7zxoi7zy3RehSq7K/SeMXcqYcD28rSgceuzWXCn6T57ofgNJOh4chUOplX2KvmH0eR/F0g+wseAvPPPFm1Kwv6uZCWwvnDV5+WM+b+SQF3oSwoHRBfL/yLnyN8d0grQBm0oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760808094; c=relaxed/simple;
	bh=hZrk3e0opmcmsfCNG/ct5rR35QVye1I3kOj+BonLMs4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UGFHryN2KpDUT0E1lnW0FoC1jS6+aK+YWDIAMGkpu1r+r1rhPIG2FSYStNHa6Murx6GQE010TrzbmMyfHiuVUKyIbbiuCSBcqtJbrH3iGlJsZefvepoK52LFjFR6IZSSUIw12TxrbbhN33k6j55i3Hr9q/n4tDE+Lx7+SUHvih8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Aau/TK8n; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-88f2aebce7fso448591185a.3
        for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 10:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1760808091; x=1761412891; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KtwlgrrpxMnfWC2+fWrpswQ73U5MXdKBv2JvDR0km/8=;
        b=Aau/TK8nGWOeUX+MxJFZw9gtVtiHPNFci3SjM8Dik/35zy/eDhFQj+15OzrR2mIhN8
         dMMCgaJ0GBVcYe4ImLhqfFHtHXdnWxHnkNNTUtbeuBd8tITFsABVrHAS2AwrbcdDhNqq
         nAMK2J2R2FILaeH24kLsfd7zgSh1Bwv/lDAI7g254NB5oLKX6As7IIx9jlRS/6BobzMt
         AKnwnj3TSQg6ZeGcqtANqXos1GAkuLwbG9mFt++pKblTFWIlF4OierPVgcFqLhtpsbNo
         A0KOZYWvdg3Y5HORB5cdmLv6g9HL8nzLUBeO2P7+gr9Vg4sN7+bWVbQvwHTJIW1Pd3jc
         haXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760808091; x=1761412891;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KtwlgrrpxMnfWC2+fWrpswQ73U5MXdKBv2JvDR0km/8=;
        b=hQIE/ZheOB1o3PlI36BqB8b1gyMscDUlexnjamXsjNnBZIeyWy7PfeSFXEof/+FxAo
         bZwjzqKUoQMQfbQjh+AGHSGY2MR3My1kSCFRmAuQgPqayRWApnYyAGesfuxTgD5FhXLC
         O4xrbLX1yQ7PTXGmDhO4UZvNcGqme+/qLrDk1JJnMDLp07d3eWT4R0HwRWGT6lRWktJT
         Sk1PnFLtj0J0jyEdTmPb3bd+VN8FYn5WK/1omrkGYPtc3LHRWU77wjN2EHX2pPRZK5XZ
         +fQLhrylq49KZ4n/2CMOwx7TEzlcVQEXFcrPsW35rL5pwoUF6PJ6gxFXHUgj8fv1MqRF
         hRuQ==
X-Forwarded-Encrypted: i=1; AJvYcCUxVBu/LVOj+hN7Tv2lMqg+fqQPskICznJ81Bn77acLo4SENktDU6j8UtQqpB2WzUCtTNyuV4wzimbNydk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwayzpGySTgsahptd5aTtHS2WB0/cq4mTQgMXGrtLRBVXIoUX9x
	OnPFNCZBqqWhlnjiLlt7a3dnjHkdBPmEbV2M5dwcMMazKzphku1ER4MR5kPClAfOlU4=
X-Gm-Gg: ASbGncviy2FxyRYbQP38Zhnw8H+U2NoD6TkTWktAPZ0n1HFs2RKibivWSnjbhPXdUfQ
	H8m1Nwkz4gvm15H+KIyO7IGlLcZar5T4PLtqK+D8wLUocMqzL5BOVFLHhs7jTTr39MtUhHp7NdN
	kt4OS2eJRJ/FmRWWXuFiu+u+BcMD2YJenMWJvhkNstMp+9ag7YfD9w/MzdOLiqukjI4LKYE3WuC
	TQbXRMDbNX80kdH7rMLt4FCLs5dw9mtVVgKXwMWcw2Nh1eUN5VEOOsM+2V9v3aTsYbdeYQk7uo+
	zBLN2BadN67b7PrVPnCuRM70HmsQJcDZvADQeh6TgkQQe6cMBi+dX4uRT/Y+CEM5rNNbMhGZW9d
	UVpz7VonXvGv8ZHozAS98hpXQoRQriM6OgiwDyzCU1pxlJ24UVA==
X-Google-Smtp-Source: AGHT+IFQ4YhonL1Z5Tyw8LFX7yPB+Yhbxw1duCMQ0dgn9fIzCTYhm3XLOpH05ZT1col0ISYsgvgJDg==
X-Received: by 2002:a05:620a:2952:b0:851:cb50:c5d0 with SMTP id af79cd13be357-8906e2ce114mr1080860285a.12.1760808091392;
        Sat, 18 Oct 2025 10:21:31 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-891cc9cacd0sm201601485a.3.2025.10.18.10.21.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Oct 2025 10:21:30 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vAAcU-00000001Z3Y-0F1E;
	Sat, 18 Oct 2025 14:21:30 -0300
Date: Sat, 18 Oct 2025 14:21:30 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vipin Sharma <vipinsh@google.com>
Cc: bhelgaas@google.com, alex.williamson@redhat.com,
	pasha.tatashin@soleen.com, dmatlack@google.com, graf@amazon.com,
	pratyush@kernel.org, gregkh@linuxfoundation.org, chrisl@kernel.org,
	rppt@kernel.org, skhawaja@google.com, parav@nvidia.com,
	saeedm@nvidia.com, kevin.tian@intel.com, jrhilke@google.com,
	david@redhat.com, jgowans@amazon.com, dwmw2@infradead.org,
	epetron@amazon.de, junaids@google.com, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [RFC PATCH 00/21] VFIO live update support
Message-ID: <20251018172130.GQ3938986@ziepe.ca>
References: <20251018000713.677779-1-vipinsh@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251018000713.677779-1-vipinsh@google.com>

On Fri, Oct 17, 2025 at 05:06:52PM -0700, Vipin Sharma wrote:
> 2. Integration with IOMMUFD and PCI series for complete workflow where a
>    device continues a DMA while undergoing through live update.

It is a bit confusing, this series has PCI components so how does it
relate the PCI series? Is this self contained for at least limited PCI
topologies?

Jason

