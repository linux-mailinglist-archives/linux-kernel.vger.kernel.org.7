Return-Path: <linux-kernel+bounces-772037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 82F2FB28E1E
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 15:21:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC25F1CE11DE
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 13:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A15E2E5D32;
	Sat, 16 Aug 2025 13:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TBbPjok9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C95C82E7F3A
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 13:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755350418; cv=none; b=paxtCL5RAnM01dOMk7z0Ay/VIbvE8I8J674tNvkgZP2OhK5l7wCntqAqqp1JFs8ujgvsW+JCCQ1BMFmj0b7xl7wUIGW4nAnyf0EbrJIg8eik7sjXhVpp/+8XbqQ5zkqb15ks2eNkbFRqjR70y3md8AJjVMAF33nkI6fRKqNoWK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755350418; c=relaxed/simple;
	bh=4a4UkLWAzywoDLLPOv9OQ0BJA1ty0NVPTX6oHQuZ0/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DQ526AilnIIquIAd+ETMe/tVU5MJqqvDVVLELsfUVmTTNyfGZstf3v+Aye9gPlURHEl18wlo8DyFnzf9fnpXM99vy6XSPPv81DPCXvl2ZJYyj3JJXJdQPSeBr2dEA0XS8kAS3p4SzceCRR+08TW8JysSedVKIkEZECFoa4bGgg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TBbPjok9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F00FCC4CEEF;
	Sat, 16 Aug 2025 13:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755350417;
	bh=4a4UkLWAzywoDLLPOv9OQ0BJA1ty0NVPTX6oHQuZ0/w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TBbPjok9HI/V7jj/NTyLShma030jGXnB0hc5RhIb7tppnfW/Yl/Ln/2omN1T4kezV
	 IYEVJCUHEXzeql3tID96H4hKbsqXUqBAoJ2DkrLFxpyTz4L4xT1mICPbdj2nX7rbdW
	 Y4M17GXRpCElKFVJ42ndQCNXOS1U4ShcM1jcrB9WZbDCq/N3shJvokL1CDN/TqYg5Z
	 wxES7Hi9nXl9+mnCRMG5COrcUnSRmbOSSzumKUvB6e1Wv/GWKINsXWAaxXqYVkzxoy
	 iFHEpknm1i2iPrHlfPn4WzJjhI6vkCVn9yZz1BVjLFiHCqS+3F2RGZyNYhmXSvjNZF
	 xYYKdmumnveFg==
Date: Sat, 16 Aug 2025 07:20:15 -0600
From: Keith Busch <kbusch@kernel.org>
To: Diederik de Haas <didi.debian@cknow.org>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [BUG report] kernel warnings with Samsung 970 EVO 2TB SSD
Message-ID: <aKCFjzai3Y0RcGHP@kbusch-mbp>
References: <DC3TO97G0RMI.3KKUONOCLJHFB@cknow.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DC3TO97G0RMI.3KKUONOCLJHFB@cknow.org>

On Sat, Aug 16, 2025 at 01:40:44PM +0200, Diederik de Haas wrote:
> Hi,
> 
> I have a Samsung 970 EVO 2TB SSD and I see these kernel warnings:

... 
 
> I wonder if something can be done to fix those warnings.

Are you talking about this message?

   nvme nvme0: missing or invalid SUBNQN field

You can't do anything about it, but I wouldn't worry about it either.

If you want to see what the driver is reacting to, you can check the
subnqn from command line:

  # nvme id-ctrl /dev/nvme0 | grep subnqn

It'll probably be all zeros. The field has been required by spec, but
the driver tolerates ones that don't implement it. It's just a message
that the device isn't spec compliant, but otherwise perfectly
operational.

