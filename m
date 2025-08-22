Return-Path: <linux-kernel+bounces-781954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 622FCB31933
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 15:20:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95D5AA04D7D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 13:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 031BC2FF161;
	Fri, 22 Aug 2025 13:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="UXJBM0ok"
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC5C62FF14C
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 13:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755868563; cv=none; b=o0mYIb96x/Lq/Evxjp5aqEsUHk13WyrgdNIfSf/dKT6AfUHRXjP9nI6XIGf9CgawwpybFxNaP0z14lLF2eZ6k1QqRUFM3TKvbC9FLuxW9I/z9vcozZTeBawkGFuhWbOf7pFs37tC8UuqxmR68u/yiYKlvd0FWsB7UxE1acDjEGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755868563; c=relaxed/simple;
	bh=KqzjfU9exGm372xh2SmnIamkQk+2EkcsEAIzxMFuXUM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i25wGG+aevMm4p2qZzqafiEOu46BbRiAZNoPsZIbPYhsLPVegzQtKPcTotzrLoPF2MbX+zAoL6cwD08RPngZ3IQcwUi5TThuvurC2KS6sQGhX8j9DBpASxp3vqHJ2cl5WVIHSunMQj4Xcs1hCxkjnhn2kj2kaDPL1GO/phffzTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=UXJBM0ok; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7e8706c880eso225598885a.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 06:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1755868559; x=1756473359; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=s37UOICp/xqQ4nSDirjp8qG8uDt4MuU+DQwitFIuCMw=;
        b=UXJBM0okiUmwf+ZQnrouIJZYKf1HGld6Qc+A06Y21UukEPH5Rlg/N3lA2BhuOhupTV
         H9gRjapndRpMWNMU/wx0oWYNGeIskD4VWml0CD+5pCWwMC4iHXQiOa9R/oaRt13QUDlo
         X9vV77CVXkai8VFFNHhAlFDcLyqP2tZmFhDw2PwPx/4F/fVTe/zJM2NZnoEHSTXOVD71
         RfckhLWu41jE0xbHqHRlZpkeO/aMgHS2eXvqAGwiT/rhD3SgqLnDiCgooaMcjDxnOlXe
         r3vXrNILeqpJUX6me+HDaTCYB5myNULGIeES+F7za7Yfq8TzMyjJqHzXR2yMubWcYaP1
         +tUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755868559; x=1756473359;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s37UOICp/xqQ4nSDirjp8qG8uDt4MuU+DQwitFIuCMw=;
        b=EUTUFE1J+HH6dR68eOg8BcjQvuQX0QNYuxaPewWnmbIY0Is0shab+mzhUcj5gk2VZi
         G2waulkYLjqkjzSMuk1FI03v2lncdJJz+h8w8ggHqFX2cNzR1YoWBbITJvpEx63GCfoe
         5RRQ2eTCbiFebGQEEuZpWXUZQKWRr6kn6sF6vRqpgTUyFPplZdCrh9m7Cm72iIKLPmsH
         afbW3VHsMOfgTMEwOb38vmi6uSNJUb+3ZoKW1esrE12tnbMV4tQg946ZUsKpinMv9RPo
         PVDnBYeNCIDphOtUt0QG+TPBPV/qkUFiglxKrmlEDxc3QmLVV9+5esmmBRo/xKbKkYcx
         6wHg==
X-Forwarded-Encrypted: i=1; AJvYcCXVv/pmwTnSXpqgexRbabWUOYIAPk/lUDc6xSUqFp9vrmmbjatE1lOMuTk1DPdVC/1R7jJ9rlOQrpNKxQM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAgKpmBMKRa/VIbRq7ThR8M8JoPRIeOYV2GrJVIAoLKRZsyWeI
	q43cRc0s+KnLqaebFG/3owHB4MeAnPTKVJ3Q05saBKk4DlvwUWXqj5idJ04hdqNWqi8=
X-Gm-Gg: ASbGncttV9Te2QVDUwbUFJ7UR+GhvyYEP79al8zE/K8rjCioJUjiuUwGtuAz0Jo02cR
	yHsibqBk+gCh8BP9aLzx7S2MOaoi6s1aQDj0Skf8voPsmTNkCVFg5MFzBaB93Pq3ylpRtcCkqM9
	ULETlxwhRshx5qmonbqaq544f1TK6h4vCtfKf5Tyw99mhdss57JsMfzJ3OicOLDIp7UoE77FwpM
	4dwzTwjTIBL6ZBU+rt3kn9B5ULFMGNZNIVPI9Qf2ZW+0MxhzdhoRBBXmlbAg8niO+sFtlCiDkQF
	sX7bAnqgjKWJ102hutj55WIYp50VFvKEVcF2/JIeIeRD0KwlDjZaMedj6azvC+fKIm+0polGLsd
	G2kZ/znZLDy5RUzpdh5dLzUSUHJpm881vFCiWovvFz8qRRA97cf2XyAuiGoaNViBLFdHy0c4cdx
	v8soE=
X-Google-Smtp-Source: AGHT+IHXVX122s53JD2hegYs7ZXOgw+xA4GHO5CstWr4WwyvcMXYcMTvoaiFOvfo003P9S9/mapNNQ==
X-Received: by 2002:a05:620a:2697:b0:7e8:65c0:2a6d with SMTP id af79cd13be357-7ea10fef8a7mr330039885a.30.1755868559294;
        Fri, 22 Aug 2025 06:15:59 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b11dc1827esm122559851cf.11.2025.08.22.06.15.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 06:15:58 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1upRcb-00000005s33-3wRH;
	Fri, 22 Aug 2025 10:15:57 -0300
Date: Fri, 22 Aug 2025 10:15:57 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Liao Yuanhong <liaoyuanhong@vivo.com>
Cc: Brett Creeley <brett.creeley@amd.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	"open list:FWCTL PDS DRIVER" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] pds_fwctl: Remove the use of dev_err_probe()
Message-ID: <20250822131557.GA1121521@ziepe.ca>
References: <20250820124011.474224-1-liaoyuanhong@vivo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250820124011.474224-1-liaoyuanhong@vivo.com>

On Wed, Aug 20, 2025 at 08:40:11PM +0800, Liao Yuanhong wrote:
> Logging messages that show some type of "out of memory" error are generally
> unnecessary as there is a generic message and a stack dump done by the
> memory subsystem. These messages generally increase kernel size without
> much added value[1].
> 
> The dev_err_probe() doesn't do anything when error is '-ENOMEM'. Therefore,
> remove the useless call to dev_err_probe(), and just return the value
> instead.
> 
> [1]: https://lore.kernel.org/lkml/1402419340.30479.18.camel@joe-AO725/
> 
> Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>
> ---
>  drivers/fwctl/pds/main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied thanks

Jason

