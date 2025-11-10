Return-Path: <linux-kernel+bounces-892626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA509C457A4
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 09:59:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 382E33B424F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 08:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D18882FD69A;
	Mon, 10 Nov 2025 08:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NhSwtW1x"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE9B72F25F1;
	Mon, 10 Nov 2025 08:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762765139; cv=none; b=Xc4ZM+mt2KnhvHSFSRJmnCphL2l000ZXH9xcwRCPLZv6fX+13x7dosGYeI9+jwOeO4O05MB1uIrJI4EtwN62DmECiGdKQPV4u18Qfrcw6hNlulqBk805N03VTbCuJkTqeWmnKn7ALxE3iBMxZzvaSsbHdk6bPAB18/l8hsyP1bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762765139; c=relaxed/simple;
	bh=Dp66+7boe67i5Zv6FJ1pNRKMSo27kcvieX/kJUrwVNE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kZ9e/FhYUEmOKGIBkv8Wj12gEFCrBZK6j7xSeAeJMOf4kda2Z0LPrr101SnJ+a3wlztVoEvZIHouWFXOH/gzvuvNbAqKlVowlna/SQKeN9l+5e1Wa6k2ShraQyAQ7nkV5gauOR+joM0fDbGNtaB8J0UNJ2+AS9kUDsdStbtYLYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NhSwtW1x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C4F9C4CEF5;
	Mon, 10 Nov 2025 08:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762765138;
	bh=Dp66+7boe67i5Zv6FJ1pNRKMSo27kcvieX/kJUrwVNE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NhSwtW1xD59ms+XW3PzW8CGXfEc0O7hBpSZwiudX6P6UC3HuMNK1EHcFERdH7l+XQ
	 5EJyxN8N62ElPB0NTyiENQxOTYQRLEhVYXcjttwKnQODW4W6QDYEA1dKSiYcDWlR17
	 jyo8BJxGEcs0jHrkVbHdagmN8p03Be208So/LDj3YIgf5oDahxk15E3prXEhbY8vgj
	 WE+bYHo+SNtHdE9t/iXoM+4ZwAEZZoxh/5f0kJscL4E3mF85wwW1CemLhumJy6SrPJ
	 SJjgWgOZxEr7x4rUTPSAgkYGHSN+CsinLdpONvyMVxAt2Ji3wKLL9wCYIgSAred8KN
	 G4ESvY5NuVgYQ==
Date: Mon, 10 Nov 2025 09:58:52 +0100
From: Christian Brauner <brauner@kernel.org>
To: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org, 
	"workflows@vger.kernel.org" <workflows@vger.kernel.org>, "ksummit@lists.linux.dev" <ksummit@lists.linux.dev>, 
	Steven Rostedt <rostedt@goodmis.org>, Dan Williams <dan.j.williams@intel.com>, 
	Theodore Ts'o <tytso@mit.edu>, Sasha Levin <sashal@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Kees Cook <kees@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Miguel Ojeda <ojeda@kernel.org>, Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH] [v2] Documentation: Provide guidelines for
 tool-generated content
Message-ID: <20251110-weiht-etablieren-39e7b63ef76d@brauner>
References: <20251105231514.3167738-1-dave.hansen@linux.intel.com>
 <653b4187-ec4f-4f5d-ae76-d37f46070cb4@suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <653b4187-ec4f-4f5d-ae76-d37f46070cb4@suse.cz>

On Mon, Nov 10, 2025 at 08:43:06AM +0100, Vlastimil Babka wrote:
> +Cc ksummit (where the discussions about this topic happened recently) and
> workflows (probably the closest list we have for such things in general)
> because nobody reads lkml today and this seems to have been going under the
> radar until mentioned at lwn yesterday
> 
> On 11/6/25 00:15, Dave Hansen wrote:
> > In the last few years, the capabilities of coding tools have exploded.
> > As those capabilities have expanded, contributors and maintainers have
> > more and more questions about how and when to apply those
> > capabilities.
> > 
> > The shiny new AI tools (chatbots, coding assistants and more) are
> > impressive.

This reads like a factual statement about "impressiveness" of the tools.
Just drop that sentence, please. It doesn't add value to the commit
message at all.
                  
> > Add new Documentation to guide contributors on how to 
> > best use kernel development tools, new and old.
> > 
> > Note, though, there are fundamentally no new or unique rules in this
> > new document. It clarifies expectations that the kernel community has
> > had for many years. For example, researchers are already asked to
> > disclose the tools they use to find issues in
> > Documentation/process/researcher-guidelines.rst. This new document
> > just reiterates existing best practices for development tooling.
> > 
> > In short: Please show your work and make sure your contribution is
> > easy to review.
> > 
> > Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> > Cc: Steven Rostedt <rostedt@goodmis.org>
> > Cc: Dan Williams <dan.j.williams@intel.com>
> > Cc: Theodore Ts'o <tytso@mit.edu>
> > Cc: Sasha Levin <sashal@kernel.org>
> > Cc: Jonathan Corbet <corbet@lwn.net>
> > Cc: Kees Cook <kees@kernel.org>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: Miguel Ojeda <ojeda@kernel.org>
> > Cc: Shuah Khan <shuah@kernel.org>
> > 
> > --
> > 
> > This document was a collaborative effort from all the members of
> > the TAB. I just reformatted it into .rst and wrote the changelog.
> > 
> > Changes from v1:
> >  * Rename to generated-content.rst and add to documentation index.
> >    (Jon)
> >  * Rework subject to align with the new filename
> >  * Replace commercial names with generic ones. (Jon)
> >  * Be consistent about punctuation at the end of bullets for whole
> >    sentences. (Miguel)
> >  * Formatting sprucing up and minor typos (Miguel)
> > ---
> >  Documentation/process/generated-content.rst | 94 +++++++++++++++++++++
> >  Documentation/process/index.rst             |  1 +
> >  2 files changed, 95 insertions(+)
> >  create mode 100644 Documentation/process/generated-content.rst
> > 
> > diff --git a/Documentation/process/generated-content.rst b/Documentation/process/generated-content.rst
> > new file mode 100644
> > index 0000000000000..5e8ff44190932
> > --- /dev/null
> > +++ b/Documentation/process/generated-content.rst
> > @@ -0,0 +1,94 @@
> > +============================================
> > +Kernel Guidelines for Tool Generated Content
> > +============================================
> > +
> > +Purpose
> > +=======
> > +
> > +Kernel contributors have been using tooling to generate contributions
> > +for a long time.

> > These tools are constantly becoming more capable and
> > +undoubtedly improve developer productivity. At the same time, reviewer

"undoubtedly improve developer productivity"?
Am I reading an advert or kernel documentation about the policy how to
use new tooling?

Please keep it factual without statements about what perceived value
this adds. People use it and we have to have a policy for it. There's no
need to celebrate it.

> > +and maintainer bandwidth is a very scarce resource. Understanding
> > +which portions of a contribution come from humans versus tools is
> > +critical to maintain those resources and keep kernel development
> > +healthy.
> > +
> > +The goal here is to clarify community expectations around tools. This
> > +lets everyone become more productive while also maintaining high
> > +degrees of trust between submitters and reviewers.
> > +
> > +Out of Scope
> > +============
> > +
> > +These guidelines do not apply to tools that make trivial tweaks to
> > +preexisting content. Nor do they pertain to AI tooling that helps with
> > +menial tasks. Some examples:
> > +
> > + - Spelling and grammar fix ups, like rephrasing to imperative voice
> > + - Typing aids like identifier completion, common boilerplate or
> > +   trivial pattern completion
> > + - Purely mechanical transformations like variable renaming
> > + - Reformatting, like running Lindent, ``clang-format`` or
> > +   ``rust-fmt``
> > +
> > +Even if your tool use is out of scope you should still always consider
> > +if it would help reviewing your contribution if the reviewer knows
> > +about the tool that you used.
> > +
> > +In Scope
> > +========
> > +
> > +These guidelines apply when a meaningful amount of content in a kernel
> > +contribution was not written by a person in the Signed-off-by chain,
> > +but was instead created by a tool.
> > +
> > +Detection of a problem is also a part of the development process; if a
> > +tool was used to find a problem addressed by a change, that should be
> > +noted in the changelog. This not only gives credit where it is due, it
> > +also helps fellow developers find out about these tools.
> > +
> > +Some examples:
> > + - Any tool-suggested fix such as ``checkpatch.pl --fix``
> > + - Coccinelle scripts
> > + - A chatbot generated a new function in your patch to sort list entries.
> > + - A .c file in the patch was originally generated by a LLM but cleaned
> > +   up by hand.
> > + - The changelog was generated by handing the patch to a generative AI
> > +   tool and asking it to write the changelog.
> > + - The changelog was translated from another language.
> > +
> > +If in doubt, choose transparency and assume these guidelines apply to
> > +your contribution.
> > +
> > +Guidelines
> > +==========
> > +
> > +First, read the Developer's Certificate of Origin:
> > +Documentation/process/submitting-patches.rst . Its rules are simple
> > +and have been in place for a long time. They have covered many
> > +tool-generated contributions.
> > +
> > +Second, when making a contribution, be transparent about the origin of
> > +content in cover letters and changelogs. You can be more transparent
> > +by adding information like this:
> > +
> > + - What tools were used?
> > + - The input to the tools you used, like the coccinelle source script.
> > + - If code was largely generated from a single or short set of
> > +   prompts, include those prompts in the commit log. For longer
> > +   sessions, include a summary of the prompts and the nature of
> > +   resulting assistance.
> > + - Which portions of the content were affected by that tool?
> > +
> > +As with all contributions, individual maintainers have discretion to
> > +choose how they handle the contribution. For example, they might:
> > +
> > + - Treat it just like any other contribution
> > + - Reject it outright
> > + - Review the contribution with extra scrutiny
> > + - Suggest a better prompt instead of suggesting specific code changes
> > + - Ask for some other special steps, like asking the contributor to
> > +   elaborate on how the tool or model was trained
> > + - Ask the submitter to explain in more detail about the contribution
> > +   so that the maintainer can feel comfortable that the submitter fully
> > +   understands how the code works.
> > diff --git a/Documentation/process/index.rst b/Documentation/process/index.rst
> > index aa12f26601949..e1a8a31389f53 100644
> > --- a/Documentation/process/index.rst
> > +++ b/Documentation/process/index.rst
> > @@ -68,6 +68,7 @@ beyond).
> >     stable-kernel-rules
> >     management-style
> >     researcher-guidelines
> > +   generated-content
> >  
> >  Dealing with bugs
> >  -----------------
> 

