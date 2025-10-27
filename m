Return-Path: <linux-kernel+bounces-872490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 85369C114EC
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 21:07:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 31D61353612
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 20:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5FEE31D740;
	Mon, 27 Oct 2025 20:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OHDIhwxc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 493192E03EE;
	Mon, 27 Oct 2025 20:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761595621; cv=none; b=UuWY8P/dYhkt8BiIxu6N0SFpY/yn1swsudIXt6VwUAxOcEUmIs8EZb6znbt/XBKyPjyeQoFV2KSIKzL5MsshxwwDGY7B3KLp9AYAmDAyUj5d2Nk3+ROeKHS9WoLJiYAvccsEcpnggm47FuFWj3mCXkYvri/gHGLHInn84qWwWsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761595621; c=relaxed/simple;
	bh=7T837HAkVTjgYv3twz6/Xz7fukMmm77qYGWTsL9vqPE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C2ZgP5UlP0EHZe0kL/KeX2mfo9QjjzgmBO3j7suEvZXwA6HOzxhOxBL3R5W46CunFMwAodR9V05MYRr+sZquG0Tzg7pFDTKr/pJ3jxRDCoH+NaT4NnVTucRG3Q5vmlNNp85E2MTEHgN0f7TrZiqFgWNGCUZoLdMgQ7QrGn95+Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OHDIhwxc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67CD2C4CEF1;
	Mon, 27 Oct 2025 20:07:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761595620;
	bh=7T837HAkVTjgYv3twz6/Xz7fukMmm77qYGWTsL9vqPE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OHDIhwxcoBYVrLSw8ZO/7mw24fx/v9RHFZ+4ouU6bfLIeh6CvQJOXDAs0SDCJmzfO
	 H2GAlbWHFfZMDQaNVytH1loON/Jm5j92DnUoDNb66SEsxzjL5xqy9i//re5s53Bjzz
	 CTWTIYMtobFjtHY/qnM50FhDAQwjHcVJ6KFMRvtWQkvW47/9Qfs5nmrCRaYo28GFjs
	 mGAcQUI+SeSL6KqrY+FQG6+Iqu/4Mh2Vo3GBWEzmg7NnnHRL9jVTuJ2VqOjKgN0npP
	 iTsnXCPiKUAWeQv2S6n4z6LrSLuo5B+A/nQRoKubAbR3ZpHrHxdRiK3q+0jzR94T93
	 9XNksvZ8DNgFw==
Date: Mon, 27 Oct 2025 22:06:57 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Stuart Yoder <stuart.yoder@arm.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: Warning: drivers/char/tpm/tpm_crb.c:193 function parameter 'loc'
 not described in '__crb_go_idle'
Message-ID: <aP_Q4XCXnBw4Wv0N@kernel.org>
References: <202510241542.hFrped3X-lkp@intel.com>
 <e1d1ffc0-dda5-4501-8bd5-e4e7ea667f10@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e1d1ffc0-dda5-4501-8bd5-e4e7ea667f10@arm.com>

On Fri, Oct 24, 2025 at 12:43:45PM -0500, Stuart Yoder wrote:
> Hi Jarkko,
> 
> I have sent a v2 of this patch that adds the missing kernel
> doc info that triggered this warning.
> 
> Thanks,
> Stuart

You need to create a separate bug fix of it.

BR, Jarkko

