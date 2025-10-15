Return-Path: <linux-kernel+bounces-855102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2B08BE03C0
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 20:45:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1DCB4202EF
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 18:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 215F8271456;
	Wed, 15 Oct 2025 18:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="ShH/wgpT"
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92A919E81F
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 18:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760553921; cv=none; b=q4mTmsXhyvG3chfKACV9Lqamzn0wYhlaUbgy9DMEF9E5E6lXLEh1WqCQTkOtMRG3SBGmhpbCny9UsF49um2pz6BiNKOEPa4Dk2Q0a9L4f5Zhj5iBnUDzrHmr2t52skYRcBIHrxBbE/r3PJlrGoc6cNH91/XiMrtyGmLG4tjZXIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760553921; c=relaxed/simple;
	bh=JkmncYfreq394vWt7ZW3yfWNhxcq0/WE0DneeTjszWM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FcDgPugi8CdPAUg9hyu6ZYi+Gxi1TvQcq6V+gACnrzh0DTwR/TDiOgJFva2kJq0Z5Hd1L1kKgoNZiPlYyDMmoal7fPmxySQ6/8mz8zxwbA4H8Eu3w9VeGuP1+P5l16muqFTX1nlnrLRJ5+CJXCY0FBlz6mi+LbfKtUCMIyHTExI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=ShH/wgpT; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-855733c47baso1336419485a.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 11:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1760553918; x=1761158718; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VEYZOuGRfIDWR2T00/XK+SOB6yyfdCwjHBg36UpvTHE=;
        b=ShH/wgpTHzEWsLVS+762gZcuoEsPWR2smZvLqRhUumeP8GMWoY6oFWmM4rOKIXmXgn
         CxdVYHznXtS0Owp9dKn22XUxWl0OdzzpfnRBWYfv+2hd+Hk9wdLPiEzju6q2ZRGkxAbp
         QqwwPBI/1XWRyUND8bGbm1XntPRm4YITBeKJywqO+MuDOa0U2loBXjmx4o7LYc99px10
         pAQqpB7Y1CiNaDKVQA6SpPLZ7qv3eSNAu/nuTE8yIWzZb6RABiXcDNfNby3jeFKMAomp
         yAgAeyTEKSVwUYzmQ4iiYBhqQoOXS8C9H5kzhLZxfxp8egnA617S1iIzr0B/awdFFAd3
         fC9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760553918; x=1761158718;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VEYZOuGRfIDWR2T00/XK+SOB6yyfdCwjHBg36UpvTHE=;
        b=QpIOjcwvx3avu4mELASeXKCSaPhLfGcDP34AFWd5lpKC2qA1kq9EcLMxcy7GzqcDcu
         4p59kRhJbQjiOWuV6v/5cQVjPxKBLdGFZnUPqM2vj+kZJ00zvB+xl2O1XLV1YFK87D2l
         t+Nyg964/mOmaTb+6tIDEIfY6WJBbndoFxkCkmWFQSe7VZWD8ApF54qQ468LoVJlGhL2
         CuBcGuMvmMlnwi2FjdVgCDRGwv/Eyd9ZigawSttt9v0JY1gdLf+fOZI3/f7DXHMY3G9P
         MkQ0ujqh6/FO2E1x2CQNItJ8t1qDhebqH4R3HwKaGdUwCiuxW1s83xc7iwoTfC8NDR5E
         8IWQ==
X-Forwarded-Encrypted: i=1; AJvYcCVb/6TvHlBaNk7FUZ62Wn34wCuS4KlE+rg7J03tVNk7SWmieOuj+61tWtdIT03a5D91ZaiG4KPbLW7hHyc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiJ87RUERDRlg9URRnvwn8m9vZMztCByaNXi5v9WVMwVWatWSy
	p1U/Rumf5kO6LqAtlcqAMJfYJ37JAdBIz0MCOecDO64gqRsN5dZqZOZsQdKcQ+YV53g=
X-Gm-Gg: ASbGnct67GhogGfFCVyVeiZ+pnMcHhK1nwbvP5DpJsPAnX9v4bwKKWmeiE9A8vvJhrS
	utrBWWThxtCzVVO1nq2CHEY2BRzU/0eHKx+LOuXiQ+3vKGEzeONH/PrFcfIxn6a0RShEnk3YzJr
	t82jFmBKYgcac92gxwTNSmr5ffGfs5o+VUheGhxmqSE4C8rGdhb8nzy2kD1BJYEiaiGg1mV2vnG
	oKSbrgnU2DqfIsTznxcJiS44fvLnnVlrsmf42T+E0qnmpHUFvf0ElH3IgoQDrj8tbyinqyfph9x
	JdcSg+XbvZWrpOQsrki2vvufj095zu6c9KNYfTOmjeaZHMRNBy9xtsPjdaTnsd/ywzMFNi4ABOF
	rlXJ9MlG+NnVEn/hNaI3TnvkZhQ==
X-Google-Smtp-Source: AGHT+IFBkVAUF1g083sZyATHZ78uF6leTHl2rEl39CAtMYTJs+M5ig1i8oiIrUDdOJKt4GeIzWVdbg==
X-Received: by 2002:a05:622a:6088:b0:4b3:748:a75b with SMTP id d75a77b69052e-4e6ead91fedmr454909881cf.74.1760553918198;
        Wed, 15 Oct 2025 11:45:18 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4e881c76bfesm23610181cf.10.2025.10.15.11.45.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 11:45:17 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1v96Uu-0000000HVrZ-1h9I;
	Wed, 15 Oct 2025 15:45:16 -0300
Date: Wed, 15 Oct 2025 15:45:16 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Sean Hefty <shefty@nvidia.com>
Cc: Haakon Bugge <haakon.bugge@oracle.com>,
	Jacob Moroni <jmoroni@google.com>,
	Leon Romanovsky <leon@kernel.org>,
	Vlad Dumitrescu <vdumitrescu@nvidia.com>,
	Or Har-Toov <ohartoov@nvidia.com>,
	Manjunath Patil <manjunath.b.patil@oracle.com>,
	OFED mailing list <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH for-next] RDMA/cm: Rate limit destroy CM ID timeout error
 message
Message-ID: <20251015184516.GK3938986@ziepe.ca>
References: <20250912100525.531102-1-haakon.bugge@oracle.com>
 <20250916141812.GP882933@ziepe.ca>
 <CAHYDg1Rd=meRaF=AJAXJ+5_hDaJckaZs7DJUtXAY_D2z_a6wsw@mail.gmail.com>
 <D2E28412-CC9F-497E-BF81-2DB4A8BC1C5E@oracle.com>
 <ABD64250-0CA0-4F4F-94D3-9AA4497E3518@oracle.com>
 <07DE3BC6-827E-4311-B68B-695074000CA3@oracle.com>
 <20251015164928.GJ3938986@ziepe.ca>
 <CH8PR12MB97419E98111F553FCC117E36BDE8A@CH8PR12MB9741.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CH8PR12MB97419E98111F553FCC117E36BDE8A@CH8PR12MB9741.namprd12.prod.outlook.com>

On Wed, Oct 15, 2025 at 06:34:33PM +0000, Sean Hefty wrote:
> > > With this hack, running cmtime with 10.000 connections in loopback,
> > > the "cm_destroy_id_wait_timeout: cm_id=000000007ce44ace timed out.
> > > state 6 -> 0, refcnt=1" messages are indeed produced. Had to kill
> > > cmtime because it was hanging, and then it got defunct with the
> > > following stack:
> > 
> > Seems like a bug, it should not hang forever if a MAD is lost..
> 
> The hack skipped calling ib_post_send.  But the result of that is a
> completion is never written to the CQ.  The state machine or
> reference counting is likely waiting for the completion, so it knows
> that HW is done trying to access the buffer.

That does make sense, it has to immediately trigger the completion to
be accurate. A better test would be to truncate the mad or something
so it can't be rx'd

Jason

