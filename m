Return-Path: <linux-kernel+bounces-889458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABE7AC3DA79
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 23:43:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 549B03B22C7
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 22:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6501D346FC3;
	Thu,  6 Nov 2025 22:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GiUUpja1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6F82F657E
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 22:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762468995; cv=none; b=LirKu96V/kbq8wImbc0as4z41n0MYlFu8zJk4ZhcSFJP70MJWL1vQQbUYbFrKP+L5XP2SN+mO7w4z4XlT197SNU5LvryN1+EIZsLNGex3W4WHDQjQ3FaWvQdJJRLjGxCUorZblt1gE1U67Vxuun+uXPIwaZTsIzu7YCySLR7Cnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762468995; c=relaxed/simple;
	bh=wPrSjRTU/rk7PWgWUYjZPAmIdmkxenW1izFmfl27rjk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D6CwQqRpakz4hHG0owIiV0m6Q/askPe6H/GoDgTuy+hojTUxckfY0ljPIwtdch0MYyZBx2t2rjlCT3Y0EDR5is909CgHxlsUvwSjXDfhKcBebJjqX1XiQNIJubh9X2pcvWrV8q3MRy5a5DzFmJDxu52IXLRQxltCWvJPHGMvJB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GiUUpja1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A9FBC16AAE;
	Thu,  6 Nov 2025 22:43:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762468995;
	bh=wPrSjRTU/rk7PWgWUYjZPAmIdmkxenW1izFmfl27rjk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=GiUUpja1WYa6/E8ZfvGmqlBRg1LMwy7fzFl/0NBZGPqyJOlyFZYXlcPcmdsZHobk2
	 dKHOmT3Gn3d1WshQZH0tqaZSawPO/b4YRoof2/EakWfU+ixPu7htxpPI4qI9s/Zxf6
	 iy/eomdPJvgMIjhkaqkVFwJTsNeMUTPsXX+mX2Cjj+cfYQsbjonTI8+MVcayeO/NAu
	 4A0kxOTfPOwYULxmEMWAXg2OBSqWQ/rJBek4X65GvgzCvo3dQI9gE1n0EuJ+MU4yj9
	 WAmQoVuTcPhyaCO0RsDXwiRJfZwDS/511ODKGawAE3k9NQ83tLUOx2ybAF3pDhK9kD
	 rcBQ3lsJKHuIQ==
Message-ID: <c548835c-091b-4714-a0bf-46e50c08f7e6@kernel.org>
Date: Thu, 6 Nov 2025 15:42:51 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] [v2] Documentation: Provide guidelines for tool-generated
 content
To: Dave Hansen <dave.hansen@linux.intel.com>, linux-kernel@vger.kernel.org
Cc: Steven Rostedt <rostedt@goodmis.org>,
 Dan Williams <dan.j.williams@intel.com>, Theodore Ts'o <tytso@mit.edu>,
 Sasha Levin <sashal@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Kees Cook <kees@kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Miguel Ojeda <ojeda@kernel.org>,
 Shuah Khan <shuah@kernel.org>
References: <20251105231514.3167738-1-dave.hansen@linux.intel.com>
Content-Language: en-US
From: Shuah <shuah@kernel.org>
In-Reply-To: <20251105231514.3167738-1-dave.hansen@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/5/25 16:15, Dave Hansen wrote:
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
> --
> 
> This document was a collaborative effort from all the members of
> the TAB. I just reformatted it into .rst and wrote the changelog.
> 
> Changes from v1:
>   * Rename to generated-content.rst and add to documentation index.
>     (Jon)
>   * Rework subject to align with the new filename
>   * Replace commercial names with generic ones. (Jon)
>   * Be consistent about punctuation at the end of bullets for whole
>     sentences. (Miguel)
>   * Formatting sprucing up and minor typos (Miguel)
> ---
>   Documentation/process/generated-content.rst | 94 +++++++++++++++++++++
>   Documentation/process/index.rst             |  1 +
>   2 files changed, 95 insertions(+)
>   create mode 100644 Documentation/process/generated-content.rst
> 
> diff --git a/Documentation/process/generated-content.rst b/Documentation/process/generated-content.rst
> new file mode 100644
> index 0000000000000..5e8ff44190932
> --- /dev/null
> +++ b/Documentation/process/generated-content.rst
> @@ -0,0 +1,94 @@
> +============================================
> +Kernel Guidelines for Tool Generated Content
> +============================================
> +
> +Purpose
> +=======
> +
> +Kernel contributors have been using tooling to generate contributions
> +for a long time. These tools are constantly becoming more capable and
> +undoubtedly improve developer productivity. At the same time, reviewer
> +and maintainer bandwidth is a very scarce resource. Understanding
> +which portions of a contribution come from humans versus tools is
> +critical to maintain those resources and keep kernel development
> +healthy.
> +
> +The goal here is to clarify community expectations around tools. This
> +lets everyone become more productive while also maintaining high
> +degrees of trust between submitters and reviewers.
> +
> +Out of Scope
> +============
> +
> +These guidelines do not apply to tools that make trivial tweaks to
> +preexisting content. Nor do they pertain to AI tooling that helps with
> +menial tasks. Some examples:
> +
> + - Spelling and grammar fix ups, like rephrasing to imperative voice
> + - Typing aids like identifier completion, common boilerplate or
> +   trivial pattern completion
> + - Purely mechanical transformations like variable renaming
> + - Reformatting, like running Lindent, ``clang-format`` or
> +   ``rust-fmt``
> +
> +Even if your tool use is out of scope you should still always consider
> +if it would help reviewing your contribution if the reviewer knows
> +about the tool that you used.
> +
> +In Scope
> +========
> +
> +These guidelines apply when a meaningful amount of content in a kernel
> +contribution was not written by a person in the Signed-off-by chain,
> +but was instead created by a tool.
> +
> +Detection of a problem is also a part of the development process; if a

It is good to emphasize testing is also part of development.
How about rephrasing "Detection of a problem and testing the fix for it
is also part of the development process;"

> +tool was used to find a problem addressed by a change, that should be
> +noted in the changelog. This not only gives credit where it is due, it
> +also helps fellow developers find out about these tools.


> +
> +Some examples:
> + - Any tool-suggested fix such as ``checkpatch.pl --fix``
> + - Coccinelle scripts
> + - A chatbot generated a new function in your patch to sort list entries.
> + - A .c file in the patch was originally generated by a LLM but cleaned
> +   up by hand.
> + - The changelog was generated by handing the patch to a generative AI
> +   tool and asking it to write the changelog.
> + - The changelog was translated from another language.
> +
> +If in doubt, choose transparency and assume these guidelines apply to
> +your contribution.
> +
> +Guidelines
> +==========
> +
> +First, read the Developer's Certificate of Origin:
> +Documentation/process/submitting-patches.rst . Its rules are simple
> +and have been in place for a long time. They have covered many
> +tool-generated contributions.
> +
> +Second, when making a contribution, be transparent about the origin of
> +content in cover letters and changelogs. You can be more transparent
> +by adding information like this:
> +
> + - What tools were used?
> + - The input to the tools you used, like the coccinelle source script.
> + - If code was largely generated from a single or short set of
> +   prompts, include those prompts in the commit log. For longer
> +   sessions, include a summary of the prompts and the nature of
> +   resulting assistance.
> + - Which portions of the content were affected by that tool?

Please add:

How is the change tested and tools used to test the fix?

> +
> +As with all contributions, individual maintainers have discretion to
> +choose how they handle the contribution. For example, they might:
> +
> + - Treat it just like any other contribution
> + - Reject it outright
> + - Review the contribution with extra scrutiny
> + - Suggest a better prompt instead of suggesting specific code changes
> + - Ask for some other special steps, like asking the contributor to
> +   elaborate on how the tool or model was trained
> + - Ask the submitter to explain in more detail about the contribution
> +   so that the maintainer can feel comfortable that the submitter fully
> +   understands how the code works.
> diff --git a/Documentation/process/index.rst b/Documentation/process/index.rst
> index aa12f26601949..e1a8a31389f53 100644
> --- a/Documentation/process/index.rst
> +++ b/Documentation/process/index.rst
> @@ -68,6 +68,7 @@ beyond).
>      stable-kernel-rules
>      management-style
>      researcher-guidelines
> +   generated-content
>   
>   Dealing with bugs
>   -----------------
The rest looks good.

Reviewed-by: Shuah Khan <shuah@kernel.org>

thanks,
-- Shuah


