Return-Path: <linux-kernel+bounces-856756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7E9CBE4F8D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 20:01:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 974E01A63E77
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 18:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFC8C221F13;
	Thu, 16 Oct 2025 18:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="iC3bRjvN"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E06F19DF8D
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 18:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760637673; cv=none; b=NO5q2Slt9TYQd1kBYAkadupeo5Zxlfn/sL7MnBic1H+Z6D6d3dX+WBbZbtZWxFUmiE6i0WDCjAmrAZ3yJQlwp0DlyHKAfzzJTG7HtIvpp+x+3fGTgYjawZdY2xuFsnnNwP7C/vDm0SEOVBcvlGKq8ODjFGL3gJBd48hqPlpZWuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760637673; c=relaxed/simple;
	bh=UEZSqC8DG+AeJI1N/uJ8S8bsTsBgDQAckEkKFSw6cKI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BGTVTMNRdFY55fhhU5HbjO232pWYY0HCFABxm3oIUCgOCP2A+aAyk9agIdjte3FsQ/js67XV4Fg9isRGra52n2nYvn8V6wr3bjEwI9OVSuyHKTzozFQIX60TTKmHAWXTQXH4ClwBPauVDZcAR/tn1f+zhlRVpo+iefHg9rWmZ/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=iC3bRjvN; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-781db5068b8so930292b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 11:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1760637671; x=1761242471; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UEZSqC8DG+AeJI1N/uJ8S8bsTsBgDQAckEkKFSw6cKI=;
        b=iC3bRjvNIw5qwAVYBgZ08fEjEz17PEa3TTYPZrjQ8/K3f4iwECCE7lorl+2dDp7GGi
         lGBzjpy1TLzKFCTZLL1BF3AHsENRiK0LU3tetyXOfzQrDzIcwlN65bZ7/PePj9mjUZ/4
         B69D79oEMTtitzl0DeJgvcOWcPRhhqTNOkobPOTvDqLOEhF0EoqZxrWrYxlHa7FQWmZ/
         OZ1c6gWsUuGmseiQswL5VugeObDD4ILLM3ft6gDSazn4oNK/Xm47O2LncpzxSee5dnEc
         4knjapRngF8fxaa+UV+/C+V/SJ2AdrT6ccHSD/DbnEGmIvgJI8VNzjWnNygWYMqDW1qJ
         1K3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760637671; x=1761242471;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UEZSqC8DG+AeJI1N/uJ8S8bsTsBgDQAckEkKFSw6cKI=;
        b=J6QBQuBH8pApjD4g0HUM0hXdd884K4HWhJFQE2de6G+tUbHkUBuaHZhAHy46dN9X4d
         PQaxwme2jbqXk/UeG7t8QN8CZL60okFMHAJ8RgTGuJRLYD/pInFbpUVGwgtO6NsgPIRf
         y4JCGgc9F4RkFMgY/pfJew1FrBkL4nDUUuaHT9UO2ByehLQ6YqgjAsiGCUPdXlE2GPqJ
         14ntuwiawB7/4KkAtEB6xbB/oJ4aDkEqmqV/pkD7tSUHcjsqE/HFhOIOMPdo1R84PMgt
         qMbgN0udXYsOdoV/oW3ZhN1QcDTI81eZ/URfqKwQWEvKUfNUMnqeIohcOiJafgVbDMrs
         zG0w==
X-Forwarded-Encrypted: i=1; AJvYcCUoasnLZkY2PcQ5bAfvZerYmSrmh9sinaQLEpSbgYcBARfn0rYp6/fR4dw/CQRplB7gakUdaf7YqC17cUw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzh6LK9qAXge9S1UqFmJxtm1jrIoj+w6foX8tPQLTaqH84ESJKZ
	R7GF7xWqq5V/tXDfcI7JKyrPmIew/JV/EthGPALrnBQLuottRZUNoqcI3H5PXKGwdIY=
X-Gm-Gg: ASbGncuQs5ahLN2pB2RX1R3RuhhiGMf1OnAujEJbLvZ3TdfwvsFDxhXFvZfkP04Lkl/
	OCXiQ/izFrVkZ/V0d97d4Q+lEa78j2PLUCRbR4LGAOEs/OS9Bzj4dkLQTJdxvwJEWja+TUIK7R0
	pvA8IFxLOrMK8VqHabBkzOQy79PudM5HDO7QGIFIgp29+kPuva8q/K2RvB1bkhPD81lBOsNvoFN
	KQ3eB+b8Bi2fOmqqLzwdul1gQJE+xt/MrJhuNIW08acr022WWyFuS7QJgQIsfI1qagKPglenXPF
	AYFEQUBykk6eDIm5VZaK31hDpkMc/9spdgmbF+I8VbAYEjKTo4srcr409fo7w0sdLi13chkfN8v
	bc1aR+3uI+5EPeymU5KleGkOFSBC981cE3LusvaNqhTkIG5ghbs4OnaSvI+qC
X-Google-Smtp-Source: AGHT+IEyG6ZYu1U6Nn8RDvsAS7EbrXFkX0+ilZLMRwbsGIkqOYw1gFQPq6bGSrG6RDqNrcU0ZyKvdA==
X-Received: by 2002:aa7:9066:0:b0:781:155c:f9c9 with SMTP id d2e1a72fcca58-7a220accef5mr837410b3a.20.1760637670510;
        Thu, 16 Oct 2025 11:01:10 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992d0e275csm22976026b3a.61.2025.10.16.11.01.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 11:01:10 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1v9SHk-00000000xL7-1iof;
	Thu, 16 Oct 2025 15:01:08 -0300
Date: Thu, 16 Oct 2025 15:01:08 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Haakon Bugge <haakon.bugge@oracle.com>
Cc: Sean Hefty <shefty@nvidia.com>, Jacob Moroni <jmoroni@google.com>,
	Leon Romanovsky <leon@kernel.org>,
	Vlad Dumitrescu <vdumitrescu@nvidia.com>,
	Or Har-Toov <ohartoov@nvidia.com>,
	Manjunath Patil <manjunath.b.patil@oracle.com>,
	OFED mailing list <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH for-next] RDMA/cm: Rate limit destroy CM ID timeout error
 message
Message-ID: <20251016180108.GO3938986@ziepe.ca>
References: <CAHYDg1Rd=meRaF=AJAXJ+5_hDaJckaZs7DJUtXAY_D2z_a6wsw@mail.gmail.com>
 <D2E28412-CC9F-497E-BF81-2DB4A8BC1C5E@oracle.com>
 <ABD64250-0CA0-4F4F-94D3-9AA4497E3518@oracle.com>
 <07DE3BC6-827E-4311-B68B-695074000CA3@oracle.com>
 <20251015164928.GJ3938986@ziepe.ca>
 <CH8PR12MB97419E98111F553FCC117E36BDE8A@CH8PR12MB9741.namprd12.prod.outlook.com>
 <20251015184516.GK3938986@ziepe.ca>
 <49A8CE60-DC8E-43F7-9620-D4D5F8EB2A08@oracle.com>
 <20251016161229.GM3938986@ziepe.ca>
 <6244F8C9-2067-4A8A-8DCD-02A4A2D117F6@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6244F8C9-2067-4A8A-8DCD-02A4A2D117F6@oracle.com>

On Thu, Oct 16, 2025 at 04:43:16PM +0000, Haakon Bugge wrote:

> Well, I started off this thread thinking a cm_deref_id() was missing
> somewhere, but now I am more inclined to think as you do, this is an
> unrecoverable situation, and I should work with NVIDIA to fix it.

If the VF is just stuck and not progressing QPs for whatever reason
then yes absolutely.

At best all we can do is detect stuck QPs and try to recover them as I
described.

How hard/costly would it be to have a tx timer watchdog on the mad
layer send q?

At the very least we could log a stuck MAD QP..

Jason

