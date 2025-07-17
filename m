Return-Path: <linux-kernel+bounces-735271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 49061B08D0F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 14:36:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FF1E1C26028
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 12:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D2B72C325C;
	Thu, 17 Jul 2025 12:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TiCozNXC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA6891F92A;
	Thu, 17 Jul 2025 12:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752755744; cv=none; b=bZLz8yyziEz1OC0lMEnC7zadJzmqew+hVPBOEGiHqLULm2mBOtVn/tqvSA/FvFkFrdKWEVC1r4AdcZgmgiMMfmXF2CFqK7GE00JqlyMk7lM0QaYjpPbEEg1eKM4372YDdRypOP6K8ClyhLrca2wxDv55xPkmwBad+2zj21kafyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752755744; c=relaxed/simple;
	bh=AHcTcKKUu8KDov9gTO6xkGmCubcKnuV2v81QroUn3GU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l6D0/l9mJXP57UrOwxyiEpokDnfvuBuQTHh8FFQsVcH3LholJp5vlFUr2SzviTQUlg0p+I+XImem31tnrCQR1ve0dbeDqI24mo1yXzf/lwUKghX3M6oLefu9JILVLL1kr73pbfvv+yJIRFJPuYUZ8TVaemDyKKft4dTC7TDxLCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TiCozNXC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E222C4CEE3;
	Thu, 17 Jul 2025 12:35:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752755743;
	bh=AHcTcKKUu8KDov9gTO6xkGmCubcKnuV2v81QroUn3GU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TiCozNXCxPjuBcBLKSR5RWok5y9WLEM0hjZGfu2ipp7MZBkdh0+NAB5M+gR/0Ps97
	 K0tiWVQkEBiJOjJEcdQ3rWMmPJIJz1Qw1BNvC4iLaZYsyMFTPZhgZd6W+mq/eZ7mm5
	 VJBBmTNGO/93D7uyhlqYJo3QMU07FN++4JWFSf8JOe9R4dBcLDc+XBjEkWyb8s1qvG
	 XWPLRhEhKz20EZNfs3XNQPfT17qFZ9+K6gGp4R0E+qLHnwLw+Yf8k8J3kOZZ5U5f+J
	 ZxOZlEeaOo84M/bYHgOwYtfPsNiAg9gWw58AsXZSggju87ljnPaHeZMH5Pk6UwXKQC
	 qaufYz4PuSVVg==
Date: Thu, 17 Jul 2025 13:35:38 +0100
From: Simon Horman <horms@kernel.org>
To: Hariprasad Kelam <hkelam@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kuba@kernel.org,
	davem@davemloft.net, sgoutham@marvell.com, gakula@marvell.com,
	jerinj@marvell.com, lcherian@marvell.com, sbhatta@marvell.com,
	naveenm@marvell.com, edumazet@google.com, pabeni@redhat.com,
	andrew+netdev@lunn.ch, bbhushan2@marvell.com
Subject: Re: [net-next 3/4] Octeontx2-af: RPM: Update DMA mask
Message-ID: <20250717123538.GD27043@horms.kernel.org>
References: <20250716164158.1537269-1-hkelam@marvell.com>
 <20250716164158.1537269-4-hkelam@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250716164158.1537269-4-hkelam@marvell.com>

On Wed, Jul 16, 2025 at 10:11:57PM +0530, Hariprasad Kelam wrote:
> CGX/RPM driver supports 48 bits of DMA addressing. Update
> the DMA mask accordingly.
> 
> Signed-off-by: Hariprasad Kelam <hkelam@marvell.com>

Reviewed-by: Simon Horman <horms@kernel.org>


