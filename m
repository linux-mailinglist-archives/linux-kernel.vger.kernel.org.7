Return-Path: <linux-kernel+bounces-811918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22DF2B53010
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 13:22:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F1D2A8421A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 11:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B49E1314A94;
	Thu, 11 Sep 2025 11:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="x2mx97Jb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076D123F26B
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 11:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757589695; cv=none; b=Yf3ehQ/cnc3lbIyFUTSOQKGjiHKn8YQNTavF2MKw7izT38AgFnIOSwdsGNyum7Rb3lXtuNl9mJMiQXa6xyIzHDRKknjDIdhGt8XBpFlfXlSyiMPY2ANAOu3zVD7VHfXUyb9bBmw7AJj2r1OIPNoTq5FSZeyuhMrEc+MpyK4r2Rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757589695; c=relaxed/simple;
	bh=K+E9/yeGsKbPhGfqZ6gZJ2YNepukT/TA+KQzMcGNGUw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HAIT02K7kdtMbxtCy5TXVpAQjq+/dipWYhvCHbc/TqF5SwGjRob4oKg5kpmuC8/2QBF6FV6ll4NDm8Tqc/ImhLUBgvMTTnm9NzGJkQ9oRk64z7801i08ZaH907VW/Io/L2J9nZp/sxfaEmuPqTwFeO2kwTzlM0McVLYl+MdE/rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=x2mx97Jb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 297BBC4CEF0;
	Thu, 11 Sep 2025 11:21:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1757589694;
	bh=K+E9/yeGsKbPhGfqZ6gZJ2YNepukT/TA+KQzMcGNGUw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=x2mx97JbkuP9s+pduAzZ6iKIwTM9omOBVgFUZmDgkJbLb2p54LjaVpsnfo42H9ET5
	 CcuZQGAduD8rGZdjMMMZCtTIseKsaeTAFZquREeSQkpJdtBss+phCyiUKDz2Cy6lFI
	 OBio14vVk6seCQ/Tgw571QKNCMGdVaWFaU5tCwuM=
Date: Thu, 11 Sep 2025 13:21:31 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [GIT PULL] w1: drivers for v6.18
Message-ID: <2025091122-squire-anagram-7578@gregkh>
References: <20250909181534.101604-2-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250909181534.101604-2-krzysztof.kozlowski@linaro.org>

On Tue, Sep 09, 2025 at 08:15:34PM +0200, Krzysztof Kozlowski wrote:
> Hi Greg,
> 
> Just two minor improvements.
> 
> Best regards,
> Krzysztof
> 
> 
> The following changes since commit 8f5ae30d69d7543eee0d70083daf4de8fe15d585:
> 
>   Linux 6.17-rc1 (2025-08-10 19:41:16 +0300)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux-w1.git tags/w1-drv-6.18

Pulled and pushed out, thanks.

greg k-h

