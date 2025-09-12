Return-Path: <linux-kernel+bounces-814230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27E75B5513A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 16:25:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B688E3A8FA1
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 14:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71FA82FE06C;
	Fri, 12 Sep 2025 14:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PIlOPj4M"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBEE91F92E
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 14:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757686962; cv=none; b=hp9OdcfSRmrwxwx56K4ZsOak5WW8NdFXMe+f4q8mD8OshLd6motT23IGVNy/4qVhCiSHjfgQsf08UL0wOKHtyn13P9yXd0rad2mBGp1UhKdYaIhv4pRpAbZNfld/TELObvRHbLzoj/dhiHrIymnpI5Jb6B1vCuGrsxmd3Q0QRYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757686962; c=relaxed/simple;
	bh=I1qkXFCSlVu3qPLBDZD1qAP77Zo3e56q7EE8dy7zXbI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pPqmI60NEyqvWpFKCse5cs/THFYJBxGpFvZOVnAby3KWA3Eu1TA4iJGntHOvUIvqO07Do70ERPXyyoD503zb8EtNSMWcp8cStuxhA5sM30BxYu46bHE0z7ntc1w7IjVTjNJbykJBKYLEUu7KcFnLK03cZcWDPycSUaUwVz1RMS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PIlOPj4M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD8D3C4CEF1;
	Fri, 12 Sep 2025 14:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1757686962;
	bh=I1qkXFCSlVu3qPLBDZD1qAP77Zo3e56q7EE8dy7zXbI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PIlOPj4Mz2jUiNtRAcuoMhF9TMSVWPu8fsk7jOhATAiUWmytAlk+pOJTWTAeAzSKo
	 UxTLnDIGjM3JA8pT+O8fQHKgdJkKxyEMwgH/I0hbD2eTpOKGC+IVq1dUd9hBJ3WdrX
	 dYbqSAQstfmZ+Zuf+V7P45M+Aix8Su3pdz+5rJsk=
Date: Fri, 12 Sep 2025 16:22:39 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: srini@kernel.org, linux-kernel@vger.kernel.org,
	Ling Xu <quic_lxu5@quicinc.com>, stable@kernel.org,
	Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: Re: [PATCH 1/4] misc: fastrpc: Save actual DMA size in fastrpc_map
 structure
Message-ID: <2025091212-umpire-large-b601@gregkh>
References: <20250912131236.303102-1-srini@kernel.org>
 <20250912131236.303102-2-srini@kernel.org>
 <31a37e24-0044-4987-89a9-d891200592ec@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <31a37e24-0044-4987-89a9-d891200592ec@oss.qualcomm.com>

On Fri, Sep 12, 2025 at 04:30:37PM +0300, Dmitry Baryshkov wrote:
> On 12/09/2025 16:12, srini@kernel.org wrote:
> > From: Ling Xu <quic_lxu5@quicinc.com>
> > 
> > For user passed fd buffer, map is created using DMA calls. The
> > map related information is stored in fastrpc_map structure. The
> > actual DMA size is not stored in the structure. Store the actual
> > size of buffer and check it against the user passed size.
> > 
> > Fixes: c68cfb718c8f ("misc: fastrpc: Add support for context Invoke method")
> > Cc: stable@kernel.org
> > Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> > Co-developed-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
> > Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
> > Signed-off-by: Ling Xu <quic_lxu5@quicinc.com>
> > Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > Signed-off-by: Srinivas Kandagatla <srini@kernel.org>
> > ---
> >   drivers/misc/fastrpc.c | 27 ++++++++++++++++++---------
> >   1 file changed, 18 insertions(+), 9 deletions(-)
> > 
> 
> Please use correct CC list when sending patches. You've missed several
> entries from the MAINTAINERS file.

This is just to send these patches for me for my tree, it's not really a
normal "review" as that should have already happened (based on the
signed-off-by chain above.)

thanks,
greg k-h

