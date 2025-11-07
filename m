Return-Path: <linux-kernel+bounces-889990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 832A8C3F04E
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 09:47:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CCDCB4EA629
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 08:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 546EE2741AB;
	Fri,  7 Nov 2025 08:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QyKQbmp3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF0923817D
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 08:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762505233; cv=none; b=cDoGlA8Etk8TJqePNaKYHWnPxBn3JlQfkheUYu1OwDSyusQgmyq1+rEmoCIREfBj5slfdE+7S0et7AvQQFfeACix/TwxlQRKrURnYUmhDnLL9TbdvDfhOQwq77JiiHUX0Ufl74YcU7PI+iRw1tABOFCjdg6zWZXjjwTgaXk64zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762505233; c=relaxed/simple;
	bh=rlz4Ix95/wvthzhaA+UZwuWPxPYvh2h8yZrSysLtOFA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o/KTt8rzN7z2Uw6tvUdX3PRQ/3xTxEH5fJ8cDEEGnbKdruHObtWk1yTaCn6+mJ4dqpiD8ZubNQ2T48Tfq/C6k2ioNr6iNiNiYZbVEvi50GdxyyqQXzkhfxVEQ2gHN4ZkbHOp/15K2wvy+Qxx6ClAWB9XGbbDu3Ws0hBvdjOwqls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QyKQbmp3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B693FC113D0;
	Fri,  7 Nov 2025 08:47:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1762505233;
	bh=rlz4Ix95/wvthzhaA+UZwuWPxPYvh2h8yZrSysLtOFA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QyKQbmp3DM0E3eVpRfVQudKGnTFA3fo95xvE0VHHiSP8ByLzQa1VvjktWL7X/r0ei
	 ADRzK6I9m7JJY7bLXU+6sb3LXJWrTMxAI7gr1oP7VzvjlwoVMvwEVxL1rdFTCqqxq6
	 nAkDkeZz+rsxQ7RYiw3wQVyGSWlCGrpnspyUEoN4=
Date: Fri, 7 Nov 2025 17:47:10 +0900
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Dave Hansen <dave.hansen@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Theodore Ts'o <tytso@mit.edu>, Sasha Levin <sashal@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, Kees Cook <kees@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>, Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH] [v2] Documentation: Provide guidelines for
 tool-generated content
Message-ID: <2025110753-affront-antarctic-8695@gregkh>
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
> In the last few years, the capabilities of coding tools have exploded.
> As those capabilities have expanded, contributors and maintainers have
> more and more questions about how and when to apply those
> capabilities.
> 
> The shiny new AI tools (chatbots, coding assistants and more) are
> impressive.  Add new Documentation to guide contributors on how to
> best use kernel development tools, new and old.
> 
> Note, though, there are fundamentally no new or unique rules in this
> new document. It clarifies expectations that the kernel community has
> had for many years. For example, researchers are already asked to
> disclose the tools they use to find issues in
> Documentation/process/researcher-guidelines.rst. This new document
> just reiterates existing best practices for development tooling.
> 
> In short: Please show your work and make sure your contribution is
> easy to review.
> 
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Theodore Ts'o <tytso@mit.edu>
> Cc: Sasha Levin <sashal@kernel.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Kees Cook <kees@kernel.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Miguel Ojeda <ojeda@kernel.org>
> Cc: Shuah Khan <shuah@kernel.org>
> 

Looks good, thanks for doing this:

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

