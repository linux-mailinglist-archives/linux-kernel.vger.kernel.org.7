Return-Path: <linux-kernel+bounces-737600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDC02B0AE3A
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 08:41:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61F931C27291
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 06:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB65822538F;
	Sat, 19 Jul 2025 06:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="s8FDAvQb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 173C21E521A;
	Sat, 19 Jul 2025 06:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752907262; cv=none; b=fm3Pb9cDrBFVIJRZyY529tYHZHcABV65D1OV1akRr8DenhN/kJErJ6KLTJu/aQuYoRjeeYW7yZ4zuTHpaa1ZispTmhnsSK56/fDHHCFcNmfnzblSsdY9cC/PI0LvtkU1I97FsFaG+e0hA4sSxMIk5NoV3BishU2Rp8PRRdSX4aU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752907262; c=relaxed/simple;
	bh=euroiPDIx1m5WaRTXjO77QBVQYv6Wt4M1iljqNe1n/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c7r4oPl4hCjANM80dCNU6Tt19GsWbmSCm2ePPkNPeMz81uXPj+O3fnVLxAK0rxyla9wYBuoKWLhngHLFvg3AwTqhFLx1z+0UsGonleNybgcOWAsZC39G8TXuxx82h20G+Tlw7g+1SxX4ohIiC2mRwY1q1GR4NGrYaW2CQVmTAek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=s8FDAvQb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 314C0C4CEE3;
	Sat, 19 Jul 2025 06:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752907261;
	bh=euroiPDIx1m5WaRTXjO77QBVQYv6Wt4M1iljqNe1n/U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s8FDAvQbQbEtApb1kxYkHMQnVdepk6xdRwBK2LAtmWQJ3QGdC1BB4jlUfUE1qLYCZ
	 0bLLLpSZUspNtdhKh2DxZhB/kQLCfR64zySCDeOe1PC/5hcwu/qM50quleI+GWMExJ
	 Mi8ThXNCdTSQMz6AgQm0ugDtJH5HDPMp7DDc+3As=
Date: Sat, 19 Jul 2025 08:40:58 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Ignacio =?iso-8859-1?Q?Pe=F1a?= <ignacio.pena87@gmail.com>
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: Re: [PATCH v4] staging: sm750fb: make fixId array static const char
 * const
Message-ID: <2025071951-igloo-stammer-572b@gregkh>
References: <aHq33vXh0F481FB-@MacBook-Pro-de-Ignacio.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aHq33vXh0F481FB-@MacBook-Pro-de-Ignacio.local>

On Fri, Jul 18, 2025 at 05:08:46PM -0400, Ignacio Peña wrote:
> Fix checkpatch warning for the fixId array only:
> "WARNING: static const char * array should probably be
>  static const char * const"
> 
> The g_fbmode array cannot be made const as it is modified at runtime
> in lynxfb_setup() and lynx_alloc().

Why is this part of the changelog at all?  It has no relevance to the
change you are making here.

And as Dan said, please slow down and relax.  There is no rush here at
all.  Take a few days off, think about what you want to do before
resending.

thanks,

greg k-h

