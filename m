Return-Path: <linux-kernel+bounces-747424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC466B133B3
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 06:25:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D7EB3AAB9F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 04:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAA9821578F;
	Mon, 28 Jul 2025 04:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ezpkl/hn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 288F21C36;
	Mon, 28 Jul 2025 04:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753676693; cv=none; b=oEuwLBL+Ncfanl/AM1LbYk3OE0szYtKI9ubhuuKiOh+EdDTTRCqBCcT3+GJFu+l+ws2NCNR9j/FQJFnHBlJkSy5a44wNvvtiT5UHH5PJiXsUAPbu/M2KrxbQmuW7AYvMYzC5QE7pJ+lIg+X/Qr/OSJWI8R7hm3CLMyQ+Xz9JzwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753676693; c=relaxed/simple;
	bh=wIs6UTtylqnFTXYKYzkqoiC66IXr0qN9GkHXwam0AYY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bqk7FL5/pkSuXXvyfejMnLPCr4RtT2Pfg2vk3UBFmA73tEn9jr1KHEbRhva4m4Vd+VWfkYUxb6vtkkfsXgWXQrvLaCEEj02wxsD7KR5u1eBm73bjeUG5vxrOt7gcaro0akU4gdtv3PaA2hRYhUiLypvoYfP52y15YTlSAdPFbLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ezpkl/hn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05964C4CEE7;
	Mon, 28 Jul 2025 04:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753676692;
	bh=wIs6UTtylqnFTXYKYzkqoiC66IXr0qN9GkHXwam0AYY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ezpkl/hnOzuPh7IyQANeZuw+AO2fKWmwTwzqBfQA8TTP7C1QSkbA7CVvIjN47xrrQ
	 xbCiWdu6PJNtwYAVua6KLg1zQsRE0ad+WDxOKGwbZtKeQoO36LEJ7EBLGNWcLswBfT
	 01TEbSPMKtCSZAn7D9Royift0LBhzSu/uVeU3GuU=
Date: Mon, 28 Jul 2025 06:24:44 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Sasha Levin <sashal@kernel.org>
Cc: corbet@lwn.net, linux-doc@vger.kernel.org, workflows@vger.kernel.org,
	josh@joshtriplett.org, kees@kernel.org,
	konstantin@linuxfoundation.org, linux-kernel@vger.kernel.org,
	rostedt@goodmis.org
Subject: Re: [PATCH 2/4] agents: add core development references
Message-ID: <2025072825-gotten-cupbearer-449a@gregkh>
References: <20250727195802.2222764-1-sashal@kernel.org>
 <20250727195802.2222764-3-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250727195802.2222764-3-sashal@kernel.org>

On Sun, Jul 27, 2025 at 03:58:00PM -0400, Sasha Levin wrote:
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  Documentation/agents/core.rst  | 28 ++++++++++++++++++++++++++++
>  Documentation/agents/index.rst |  3 ++-
>  Documentation/agents/main.rst  |  5 +++++
>  3 files changed, 35 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/agents/core.rst

I know I can't take patches without any changelog text, maybe the
documentation maintainer is more lenient?  :)

> 
> diff --git a/Documentation/agents/core.rst b/Documentation/agents/core.rst
> new file mode 100644
> index 000000000000..da171dde1f9d
> --- /dev/null
> +++ b/Documentation/agents/core.rst
> @@ -0,0 +1,28 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +========================================
> +Core Linux Kernel Development References
> +========================================
> +
> +Essential documentation for Linux kernel development:
> +
> +How to do Linux kernel development
> +----------------------------------
> +
> +The comprehensive guide for becoming a Linux kernel developer and learning to work with the kernel development community.
> +
> +See :ref:`Documentation/process/howto.rst <process_howto>`
> +
> +Submitting patches
> +------------------
> +
> +The essential guide to getting your code into the kernel, covering everything from patch formatting to the submission process.
> +
> +See :ref:`Documentation/process/submitting-patches.rst <submittingpatches>`
> +
> +Submission checklist
> +--------------------
> +
> +A checklist of items to review before submitting code to ensure patches are accepted more quickly.
> +
> +See :ref:`Documentation/process/submit-checklist.rst <submitchecklist>`

Why isn't the agent already reading all of this in the documentation
tree?  Why must it be told to read it again?  Do we not properly index
this well enough in our documentation tree already?

thanks,

greg k-h

