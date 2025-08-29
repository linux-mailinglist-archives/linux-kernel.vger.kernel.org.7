Return-Path: <linux-kernel+bounces-791774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52704B3BBCE
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 14:59:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA8CA7A3934
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 12:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1BC831A056;
	Fri, 29 Aug 2025 12:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="T6hXfMb5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 576651EB36
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 12:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756472375; cv=none; b=mIfi2s4LfiPFfCvsi7xWn2ZLN/OtXM7eI+mtwQiUVWz2zLKnTJ2gmxjBNONmK9pxa5rqQARjd06wykjE8CKTASpzmcJZkjleHzGvJm2Dyl5C9aLoabFM1X27o8JWgSYYvOl/11X/tr+1FF6FOqLaLAlPfSUUMJNswDkss3I+OmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756472375; c=relaxed/simple;
	bh=wKLwAaatVuawwgX4VZr5eDDAPSUu3FZl1wwkTtrtsy0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eWMFgVYWCfNoTtBLvrseaAmuRnlYTGmHSY0RWNFNcx6KK6gzL1GlXGg90qAV8SjXfUY6yuV7KdBcuvTkK7e1BuGRwX5VUYkyTAjBOajgiv1kNZc6kEiUX6Epbvk9JCznK3z64HohzfpsD36fUO2GFHUbTAaSI7raOotRC9CMnNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=T6hXfMb5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52181C4CEF0;
	Fri, 29 Aug 2025 12:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756472374;
	bh=wKLwAaatVuawwgX4VZr5eDDAPSUu3FZl1wwkTtrtsy0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T6hXfMb5bYn7IWB82cTdE3Lz/3IcLWwWb4ymP2x+ooS7udAN4zgW90uS/cmBkq/CW
	 6ZilIx2xF3VTDrbBSr73CTlydetl7+KQwzaHVHvv743yDg+2QnjEDsitWJU66GN8pA
	 2n98vIwmxRDub97zjB1EEn1Mub19xUmUm51wpHx8=
Date: Fri, 29 Aug 2025 14:59:31 +0200
From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To: "Winiarska, Iwona" <iwona.winiarska@intel.com>
Cc: "openbmc@lists.ozlabs.org" <openbmc@lists.ozlabs.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] PECI changes for v6.18-rc1
Message-ID: <2025082920-ozone-starry-8675@gregkh>
References: <26c72666403f2718409d903957ddebb3984f4ed4.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26c72666403f2718409d903957ddebb3984f4ed4.camel@intel.com>

On Thu, Aug 28, 2025 at 09:51:37PM +0000, Winiarska, Iwona wrote:
> Hi Greg!
> 
> Please pull PECI update for Linux v6.18.
> 
> Thanks
> -Iwona
> 
> The following changes since commit 1b237f190eb3d36f52dffe07a40b5eb210280e00:
> 
>   Linux 6.17-rc3 (2025-08-24 12:04:12 -0400)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/iwi/linux.git tags/peci-next-6.18-rc1
> 
> for you to fetch changes up to e27f158cf1e98d9a541282ef4b36dfa4427bf361:
> 
>   peci: remove unneeded 'fast_io' parameter in regmap_config (2025-08-28 22:43:23 +0200)

Pulled and pushed out, thanks.

greg k-h

