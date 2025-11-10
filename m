Return-Path: <linux-kernel+bounces-893773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B62DC484D4
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 18:25:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19D65188B2F6
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 17:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F5722BD5BF;
	Mon, 10 Nov 2025 17:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="qF/uyVzU"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D2F28466F;
	Mon, 10 Nov 2025 17:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762795523; cv=none; b=Hdq9QC/X0GhFoVHX7mNJ1nQb7LrJ4Q6RmLuj/K+WPOGmsU+d/szbpHJp05bK5q7IzkVk11o3PDyJrzK3gpkF0jybAVc6K4HOuiSmg3YtRhVxvBmoQQJ42aAnVgcOPhaEGUa0T51Q1SkgyczL/iNE95hBM8mgRCrls9Vgewpr738=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762795523; c=relaxed/simple;
	bh=z7+Jmlpa/GQqk9BxFvxEDpqbySg7ueOoxQOyubKCUmw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GN6F3k1l+tsrq29O2YyWBWD85NES++acIYlSeh8lK26PelqW2NEk4Uve4+QHfsYosy4d4evB3F8pnGhqvlaReO4iXYOrN78fYk2grBn2IgHfp7KV5W+S1opgUHWlPOQEVDNyo7GunlBUmSBRsY/PgCtH90A22PJSbXyHbTifpVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=qF/uyVzU; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (82-203-161-95.bb.dnainternet.fi [82.203.161.95])
	by perceval.ideasonboard.com (Postfix) with UTF8SMTPSA id B6BA7229;
	Mon, 10 Nov 2025 18:23:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1762795395;
	bh=z7+Jmlpa/GQqk9BxFvxEDpqbySg7ueOoxQOyubKCUmw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qF/uyVzUV1JwN8/edMousEqrUwi8gEAIqGOukxuYPpJl96kE/5gsgF9uffhJ0BGOF
	 48+1LYquZS3zWIlo5crCweeIQi+/7qQusHAU1LrN/XruaBrw5135nnkpFaLLZ1bjPb
	 SfsnScM2oH9NL71XkwoZd+5sU7aEr0vMlDasR6sQ=
Date: Mon, 10 Nov 2025 19:25:07 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
	Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
	"workflows@vger.kernel.org" <workflows@vger.kernel.org>,
	"ksummit@lists.linux.dev" <ksummit@lists.linux.dev>,
	Steven Rostedt <rostedt@goodmis.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Theodore Ts'o <tytso@mit.edu>, Sasha Levin <sashal@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, Kees Cook <kees@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Miguel Ojeda <ojeda@kernel.org>, Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH] [v2] Documentation: Provide guidelines for
 tool-generated content
Message-ID: <20251110172507.GA21641@pendragon.ideasonboard.com>
References: <20251105231514.3167738-1-dave.hansen@linux.intel.com>
 <653b4187-ec4f-4f5d-ae76-d37f46070cb4@suse.cz>
 <20251110-weiht-etablieren-39e7b63ef76d@brauner>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251110-weiht-etablieren-39e7b63ef76d@brauner>

On Mon, Nov 10, 2025 at 09:58:52AM +0100, Christian Brauner wrote:
> On Mon, Nov 10, 2025 at 08:43:06AM +0100, Vlastimil Babka wrote:
> > +Cc ksummit (where the discussions about this topic happened recently) and
> > workflows (probably the closest list we have for such things in general)
> > because nobody reads lkml today and this seems to have been going under the
> > radar until mentioned at lwn yesterday
> > 
> > On 11/6/25 00:15, Dave Hansen wrote:
> > > In the last few years, the capabilities of coding tools have exploded.
> > > As those capabilities have expanded, contributors and maintainers have
> > > more and more questions about how and when to apply those
> > > capabilities.
> > > 
> > > The shiny new AI tools (chatbots, coding assistants and more) are
> > > impressive.
> 
> This reads like a factual statement about "impressiveness" of the tools.
> Just drop that sentence, please. It doesn't add value to the commit
> message at all.
>                   
> > > Add new Documentation to guide contributors on how to 
> > > best use kernel development tools, new and old.
> > > 
> > > Note, though, there are fundamentally no new or unique rules in this
> > > new document. It clarifies expectations that the kernel community has
> > > had for many years. For example, researchers are already asked to
> > > disclose the tools they use to find issues in
> > > Documentation/process/researcher-guidelines.rst. This new document
> > > just reiterates existing best practices for development tooling.
> > > 
> > > In short: Please show your work and make sure your contribution is
> > > easy to review.
> > > 
> > > Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> > > Cc: Steven Rostedt <rostedt@goodmis.org>
> > > Cc: Dan Williams <dan.j.williams@intel.com>
> > > Cc: Theodore Ts'o <tytso@mit.edu>
> > > Cc: Sasha Levin <sashal@kernel.org>
> > > Cc: Jonathan Corbet <corbet@lwn.net>
> > > Cc: Kees Cook <kees@kernel.org>
> > > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > Cc: Miguel Ojeda <ojeda@kernel.org>
> > > Cc: Shuah Khan <shuah@kernel.org>
> > > 
> > > --
> > > 
> > > This document was a collaborative effort from all the members of
> > > the TAB. I just reformatted it into .rst and wrote the changelog.
> > > 
> > > Changes from v1:
> > >  * Rename to generated-content.rst and add to documentation index.
> > >    (Jon)
> > >  * Rework subject to align with the new filename
> > >  * Replace commercial names with generic ones. (Jon)
> > >  * Be consistent about punctuation at the end of bullets for whole
> > >    sentences. (Miguel)
> > >  * Formatting sprucing up and minor typos (Miguel)
> > > ---
> > >  Documentation/process/generated-content.rst | 94 +++++++++++++++++++++
> > >  Documentation/process/index.rst             |  1 +
> > >  2 files changed, 95 insertions(+)
> > >  create mode 100644 Documentation/process/generated-content.rst
> > > 
> > > diff --git a/Documentation/process/generated-content.rst b/Documentation/process/generated-content.rst
> > > new file mode 100644
> > > index 0000000000000..5e8ff44190932
> > > --- /dev/null
> > > +++ b/Documentation/process/generated-content.rst
> > > @@ -0,0 +1,94 @@
> > > +============================================
> > > +Kernel Guidelines for Tool Generated Content
> > > +============================================
> > > +
> > > +Purpose
> > > +=======
> > > +
> > > +Kernel contributors have been using tooling to generate contributions
> > > +for a long time.
> 
> > > These tools are constantly becoming more capable and
> > > +undoubtedly improve developer productivity. At the same time, reviewer
> 
> "undoubtedly improve developer productivity"?
> Am I reading an advert or kernel documentation about the policy how to
> use new tooling?
> 
> Please keep it factual without statements about what perceived value
> this adds. People use it and we have to have a policy for it. There's no
> need to celebrate it.
> 
> > > +and maintainer bandwidth is a very scarce resource. Understanding
> > > +which portions of a contribution come from humans versus tools is
> > > +critical to maintain those resources and keep kernel development
> > > +healthy.
> > > +
> > > +The goal here is to clarify community expectations around tools. This
> > > +lets everyone become more productive while also maintaining high
> > > +degrees of trust between submitters and reviewers.
> > > +
> > > +Out of Scope
> > > +============
> > > +
> > > +These guidelines do not apply to tools that make trivial tweaks to
> > > +preexisting content. Nor do they pertain to AI tooling that helps with
> > > +menial tasks. Some examples:
> > > +
> > > + - Spelling and grammar fix ups, like rephrasing to imperative voice
> > > + - Typing aids like identifier completion, common boilerplate or
> > > +   trivial pattern completion
> > > + - Purely mechanical transformations like variable renaming

Mechanical transformations are often performed with Coccinelle. Given
how you mention that tool below, I wouldn't frame it as out of scope
here.

> > > + - Reformatting, like running Lindent, ``clang-format`` or
> > > +   ``rust-fmt``
> > > +
> > > +Even if your tool use is out of scope you should still always consider
> > > +if it would help reviewing your contribution if the reviewer knows
> > > +about the tool that you used.
> > > +
> > > +In Scope
> > > +========
> > > +
> > > +These guidelines apply when a meaningful amount of content in a kernel
> > > +contribution was not written by a person in the Signed-off-by chain,
> > > +but was instead created by a tool.
> > > +
> > > +Detection of a problem is also a part of the development process; if a
> > > +tool was used to find a problem addressed by a change, that should be
> > > +noted in the changelog. This not only gives credit where it is due, it
> > > +also helps fellow developers find out about these tools.
> > > +
> > > +Some examples:
> > > + - Any tool-suggested fix such as ``checkpatch.pl --fix``
> > > + - Coccinelle scripts
> > > + - A chatbot generated a new function in your patch to sort list entries.
> > > + - A .c file in the patch was originally generated by a LLM but cleaned
> > > +   up by hand.
> > > + - The changelog was generated by handing the patch to a generative AI
> > > +   tool and asking it to write the changelog.
> > > + - The changelog was translated from another language.
> > > +
> > > +If in doubt, choose transparency and assume these guidelines apply to
> > > +your contribution.
> > > +
> > > +Guidelines
> > > +==========
> > > +
> > > +First, read the Developer's Certificate of Origin:
> > > +Documentation/process/submitting-patches.rst . Its rules are simple
> > > +and have been in place for a long time. They have covered many
> > > +tool-generated contributions.
> > > +
> > > +Second, when making a contribution, be transparent about the origin of
> > > +content in cover letters and changelogs. You can be more transparent
> > > +by adding information like this:
> > > +
> > > + - What tools were used?
> > > + - The input to the tools you used, like the coccinelle source script.
> > > + - If code was largely generated from a single or short set of
> > > +   prompts, include those prompts in the commit log. For longer
> > > +   sessions, include a summary of the prompts and the nature of
> > > +   resulting assistance.
> > > + - Which portions of the content were affected by that tool?
> > > +
> > > +As with all contributions, individual maintainers have discretion to
> > > +choose how they handle the contribution. For example, they might:
> > > +
> > > + - Treat it just like any other contribution
> > > + - Reject it outright
> > > + - Review the contribution with extra scrutiny
> > > + - Suggest a better prompt instead of suggesting specific code changes
> > > + - Ask for some other special steps, like asking the contributor to
> > > +   elaborate on how the tool or model was trained
> > > + - Ask the submitter to explain in more detail about the contribution
> > > +   so that the maintainer can feel comfortable that the submitter fully
> > > +   understands how the code works.
> > > diff --git a/Documentation/process/index.rst b/Documentation/process/index.rst
> > > index aa12f26601949..e1a8a31389f53 100644
> > > --- a/Documentation/process/index.rst
> > > +++ b/Documentation/process/index.rst
> > > @@ -68,6 +68,7 @@ beyond).
> > >     stable-kernel-rules
> > >     management-style
> > >     researcher-guidelines
> > > +   generated-content
> > >  
> > >  Dealing with bugs
> > >  -----------------

-- 
Regards,

Laurent Pinchart

