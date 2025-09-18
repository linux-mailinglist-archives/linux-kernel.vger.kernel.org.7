Return-Path: <linux-kernel+bounces-823263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F62DB85F27
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 18:20:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5797B4A5B35
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 16:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 353D130FC30;
	Thu, 18 Sep 2025 16:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Fn1dEJE1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF0B30DED7
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 16:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758212395; cv=none; b=aJS40GcyBhvzeLlVLvDaukuOztqj+pxlYBrJHkzMyxHe1QNx++QIT0SrcA6yqq83TAFxi36YcKgQg5LJDjMo1yIMmsw6qzOnLAQEcy7c8i4Z2WlEgMIRVIiL6b7oUNn84ETYHQdJahMatByS0BLVTm9ulWcQzjNvInpxdFCWlSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758212395; c=relaxed/simple;
	bh=BCl2Y81AvA63jtmwL4iwpUPio3B452TBnre79Y6BoTM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RuVXbh5CRxT12+2LCIyD0R5KZWwViu4yuVn8HIyF4DOlzlphYRdIOv+XQcboW8ohHwSDJnItfYFsCQ+O5IScEIGLnh+rnqDTkZQ0KtO+Ia93oMYrHIe2kicC8KKktORtpek9r8rZJVEnkXhg/TI3s/0l5vzylk+vyZxZYvP9BZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Fn1dEJE1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2715C4CEE7;
	Thu, 18 Sep 2025 16:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758212394;
	bh=BCl2Y81AvA63jtmwL4iwpUPio3B452TBnre79Y6BoTM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Fn1dEJE1JXTiwUKpTUUDSOQ9cLWQEMbfnAfw1Z221Kp7lCtdum+nRYvnidhioJr5O
	 gPVncUauhmrPocCTfMl3c27/ConvtU8IhmMULYvv0ZS4zqeEsmWGBQRrSoApX0mWtv
	 ksSv/bTMUwZn6XXdiZaXiNFTo/ZQCno3FJtp3NxY=
Date: Thu, 18 Sep 2025 18:19:49 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Adrian =?utf-8?Q?Barna=C5=9B?= <abarnas@google.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] powerpc: pseries: making bus_type structures const
Message-ID: <2025091845-subtract-friction-37d2@gregkh>
References: <20250918140816.335916-1-abarnas@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250918140816.335916-1-abarnas@google.com>

On Thu, Sep 18, 2025 at 02:08:14PM +0000, Adrian Barnaś wrote:
> Current driver core properly handle constant bus_type structures.
> Both changes are moving bus_type structures to be constant.
> It is a part of tree clean-up from non const bus_type structures
> 
> Adrian Barnaś (2):
>   powerpc: pseries: make suspend_subsys const
>   powerpc: pseries: make cmm_subsys const
> 
>  arch/powerpc/platforms/pseries/cmm.c     | 2 +-
>  arch/powerpc/platforms/pseries/suspend.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> -- 
> 2.51.0.470.ga7dc726c21-goog
> 

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>


