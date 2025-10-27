Return-Path: <linux-kernel+bounces-872552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5ADDC116F4
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 21:48:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09B305661C1
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 20:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 426F2311973;
	Mon, 27 Oct 2025 20:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="h/mtSurW"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 555C8312824
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 20:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761598095; cv=none; b=s0IOyX1H0nxSEt0Jjd1psjEB8fpXUs9dpCsKU14cxQljtaBr0Hi89y19aHLPXoWeMGC1rEYu3juiGSphiXrYRuPQs4fH3WD27X2O2PWYn0k24JH9dqpFjqFpcXmY7k8X2k5NSk8IZVAy+ylzEMlp6Cmf7iV9ce2l40pJ88Fp2p8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761598095; c=relaxed/simple;
	bh=sJsw8YqC2+Q9Yy6z0L0bQIMoNW9TgEgn7bMgyzZD194=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Q+Dj/t/CatGpyQtyOA+GtFIsmjLFNGpg4aw3II9vqEXxZExYTbhZS7EIAlGLiXxUKzTySPCbeEqHSDGv9NUlPv2CgfSByt4NbrGMThh3SXjImswNcI1Hsbc676diB8H1xCD2VErGN9t4gGPCMKa073XPMWEFb3J7PREFgbvemS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=h/mtSurW; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net C02B0406FB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1761598091; bh=mJwyGX4PRVUBddS2gWM4fiDzzPkMQyE5o6Kn9o7cZjM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=h/mtSurWWV5w+2La90lLNfKPnda0gIAU48Re3xdYfQumhwGOvoJxWsP9moUgdccxx
	 kjWZSXskWVa4utmuMf0qSXuX3UXOm8PqB5Y12lDiTcnyDpyjYKF9UPZ61NAuY5uZQi
	 kVgdmmMN2+QJniFeppsZee/JsYJlwx/wFsYJ2qbvnSU2B6hgnNLU4jTK8P96YSY179
	 WwToXZw0Exmm/Pn0XRpwEiotUA9PhDTOr43J9nrZ+IcVUAZF0axI9Gji0Wy7wAcCsz
	 yN9M+byJ7pc+SO3Y0ELH7/nHp+i7krQjel6t87mhY1gZ8N7glMXVMo94oximfXfPZ9
	 UeIpyxksVb0Tw==
Received: from localhost (c-73-14-55-248.hsd1.co.comcast.net [73.14.55.248])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id C02B0406FB;
	Mon, 27 Oct 2025 20:48:11 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Dave Hansen <dave.hansen@linux.intel.com>, linux-kernel@vger.kernel.org
Cc: Dave Hansen <dave.hansen@linux.intel.com>, Steven Rostedt
 <rostedt@goodmis.org>, Dan Williams <dan.j.williams@intel.com>, Theodore
 Ts'o <tytso@mit.edu>, Sasha Levin <sashal@kernel.org>, Kees Cook
 <kees@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Miguel
 Ojeda <miguel.ojeda.sandonis@gmail.com>, Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH] Documentation: Provide guidelines for kernel
 development tools
In-Reply-To: <20251027201204.352890-1-dave.hansen@linux.intel.com>
References: <20251027201204.352890-1-dave.hansen@linux.intel.com>
Date: Mon, 27 Oct 2025 14:48:10 -0600
Message-ID: <87o6psm5px.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Dave Hansen <dave.hansen@linux.intel.com> writes:

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
> just reiterate existing best practices for development tooling.
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
> Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
> Cc: Shuah Khan <shuah@kernel.org>
>
> --
>
> This document was a collaborative effort from all the members of
> the TAB. I just reformatted it into .rst and wrote the changelog.

Generally seems good to me, but I have a few nits

> ---
>  Documentation/process/development-tools.rst | 92 +++++++++++++++++++++
>  1 file changed, 92 insertions(+)
>  create mode 100644 Documentation/process/development-tools.rst

You didn't add it to index.rst, so it won't be part of the docs build.

"development-tools" is a fairly generic file name that doesn't really
tell readers what they might find within it.  Maybe this shed is better
named "generated-content.rst" or something like that?

> diff --git a/Documentation/process/development-tools.rst b/Documentation/=
process/development-tools.rst
> new file mode 100644
> index 0000000000000..ab6596cc595ac
> --- /dev/null
> +++ b/Documentation/process/development-tools.rst
> @@ -0,0 +1,92 @@
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +Kernel Guidelines for Tool Generated Content
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Purpose
> +=3D=3D=3D=3D=3D=3D=3D
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
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +These guidelines do not apply to tools that make trivial tweaks to
> +preexisting content. Nor do they pertain to AI tooling that helps with
> +menial tasks. Some examples:
> +
> + - Spelling and grammar fix ups, like rephrasing to imperative voice
> + - Typing aids like identifier completion, common boilerplate or
> +   trivial pattern completion
> + - Purely mechanical transformations like variable renaming
> + - Reformatting, like running scripts/Lindent.
> +
> +Even if your tool use is out of scope you should still always consider
> +if it would help reviewing your contribution if the reviewer knows
> +about the tool that you used.
> +
> +In Scope
> +=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +These guidelines apply when a meaningful amount of content in a kernel
> +contribution was not written by a person in the Signed-off-by chain,
> +but was instead created by a tool.
> +
> +Some examples:
> + - =E2=80=9Ccheckpatch.pl --fix=E2=80=9D output, or any tool suggested f=
ix.
> + - coccinelle scripts
> + - ChatGPT generated a new function in your patch to sort list entries.
> + - A .c file in the patch was originally generated by Gemini but cleaned
> +   up by hand.

Might we want to use some sort of generic term rather than listing
specific proprietary systems here?

> + - The changelog was generated by handing the patch to a generative AI
> +   tool and asking it to write the changelog.
> + - The changelog was translated from another language.
> + - Detection of a problem is also a part of the development process; if
> +   a tool was used to find a problem addressed by a change, that should
> +   be noted in the changelog. This not only gives credit where it is
> +   due, it also helps fellow developers find out about these tools.
> +
> +If in doubt, choose transparency and assume these guidelines apply to
> +your contribution.
> +
> +Guidelines
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +First, read the Developer's Certificate of Origin:
> +``Documentation/process/submitting-patches.rst`` Its rules are simple
> +and have been in place for a long time. They have covered many
> +tool-generated contributions.

I'd drop the ``literal`` formatting so that the automatic
cross-reference magic can happen.

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
> --=20
> 2.34.1

Like I said, nits; the policy side seems to align with how the
discussions have gone.

Thanks,

jon

