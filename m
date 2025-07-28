Return-Path: <linux-kernel+bounces-747372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BE53B13315
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 04:39:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FD65172B5B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 02:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D5621F5846;
	Mon, 28 Jul 2025 02:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tPPqcJCG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FBB55464D;
	Mon, 28 Jul 2025 02:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753670347; cv=none; b=sKCJCJwnTeNIwab6a+3lYdZQjouWW8chMm13xR8uUUamZQ+rkKuZLcOQYWygjkCQKgnYcpb1+o5WjynbT3mtqY09Nz5vqjlPvHjyJr3/E62INq4pI0SoIY4/5zpjKx73G0cMGHVLuUvyVY/P/BkK6nysKqLd5KkDNIwI5uXHbn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753670347; c=relaxed/simple;
	bh=e62/XjtUKhcPhKap7aD4kuzNFQHO73F+2esJTd/l78Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=po7TlMjSPvpZFq7STJlBVjByPOaGWv3Ey2XOld+YJz4QYu085hfDpcRUSm3obCa9JszlHfRCqKlGapdjwzTcc/89L7ctEVo2IKRjU9fzjn7LB/FNl78a+EGst3Y5Y+Md5omf4vLhvIYszH/sJGY8sQqJyzc4jDflL2x35u1mtD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tPPqcJCG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 165B0C4CEEB;
	Mon, 28 Jul 2025 02:39:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753670347;
	bh=e62/XjtUKhcPhKap7aD4kuzNFQHO73F+2esJTd/l78Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tPPqcJCGdkXs4D3B4pXClyG0iQlR9XgVK3IW54Gx4PHknz6UWR+KmNYPKi9Rl+PPS
	 YEsa3WPC8TBk86z5eR6AeK7jiwohOom3ZGRqN3XxYy5OfETw8rfION5vMBHITDF3mx
	 7LkOa7wMcnDAG7YUxoLRL4B8g2F2bj4ZiOOV9wgNCqXhf/lYwCzugqwZSuK7De2ony
	 /gj6tKxp5jc0B7DzVvp/uKbuQmWxL59E63qHzzW6c5R9GvhMpyCd1JQaoZ2UeB3872
	 VQeStV+m1rVom8S4iU2fgK6WDVVyKgMjm0c2v4+u2LWFkUG999+q7aLzLkjyRN9tIW
	 eGZVmNNVH1QjA==
Date: Sun, 27 Jul 2025 19:39:06 -0700
From: Kees Cook <kees@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: corbet@lwn.net, linux-doc@vger.kernel.org, workflows@vger.kernel.org,
	josh@joshtriplett.org, konstantin@linuxfoundation.org,
	linux-kernel@vger.kernel.org, rostedt@goodmis.org
Subject: Re: [PATCH 2/4] agents: add core development references
Message-ID: <202507271937.EC44B39@keescook>
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

If an Agent needs the above list, then so does a human. Everything above
should already be discoverable by the Agent. If it's not, then we need a
better summary document _for humans_ that reads like the above.

-- 
Kees Cook

