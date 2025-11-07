Return-Path: <linux-kernel+bounces-889745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 233E9C3E62C
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 04:42:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C86F03AE394
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 03:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 452FE287505;
	Fri,  7 Nov 2025 03:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e/vMfOUZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE3618027
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 03:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762486856; cv=none; b=uj9+JFZfyt32t//5u8jVPaKkUpF4M1xenGfZsEsBkzXJ2VF8whF1RueDRwvZcr9HwSFvWGtHPa+rshlLJuJpZmt6N0pFlVhWaeR6t03wYx7aOhk9OAmPkGibTiwp/KzohV04i7zHwarbK+yNbHz/301vHTRrdyrHE8yjUW3YhWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762486856; c=relaxed/simple;
	bh=fmE83Cc5TipFhFp+aiwoeCyP9ZYqRuYlH3CxFA0rJOg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NCIqMDICZX8Rr7kZr3ciGGlvzVjZCHdgGkV/6yKkU7prL2trh+xsQpNP4pg8NYVRgUErQTjAPI0clzHg11bf9gM2F/pONKR706EPHXy/cLLECHpgn3UR5XcdsEJZyDCwW7mo/dcx7dk6NN/Yk5RtxCtsXKxtcXMstxvz/2fmOf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e/vMfOUZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22EFEC4CEF8;
	Fri,  7 Nov 2025 03:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762486856;
	bh=fmE83Cc5TipFhFp+aiwoeCyP9ZYqRuYlH3CxFA0rJOg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e/vMfOUZphykJktl5RQ7Cf50tpxAa2g2BvEbcEqM5ySAQ+w9tJ4dIQ8WlnU1cmlYv
	 4oLrE20QZb+fb6UTOmAe00h8UtlnGLpedn/0eweNCPTGYsBLbL+f+ioVvBkftQykS5
	 yJch1T7uHFsnwgfcWcJiAsimA/EFsxus606878YPRweY2hNpyeKv1s2NDD3eZum/59
	 oEZONyivM7myCkvdEmKdh2ro7+NbyXYmJeBDkSMfnR81qAJUIGNfTeURjwX60XN0Ot
	 PHesNvk5quxgXjHWQN0GhLeja1u1X1xwbDSc6drhjKaCNihfhIxmZFgzuygwpdAnuN
	 QhHEHPa6WvaNw==
Date: Thu, 6 Nov 2025 19:40:55 -0800
From: Kees Cook <kees@kernel.org>
To: Dave Hansen <dave.hansen@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Theodore Ts'o <tytso@mit.edu>, Sasha Levin <sashal@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Miguel Ojeda <ojeda@kernel.org>, Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH] [v2] Documentation: Provide guidelines for
 tool-generated content
Message-ID: <202511061938.6E84EF7@keescook>
References: <20251105231514.3167738-1-dave.hansen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251105231514.3167738-1-dave.hansen@linux.intel.com>

On Wed, Nov 05, 2025 at 03:15:14PM -0800, Dave Hansen wrote:
> In short: Please show your work and make sure your contribution is
> easy to review.
> 
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>

Thanks for getting this into shape!

Reviewed-by: Kees Cook <kees@kernel.org>

-- 
Kees Cook

