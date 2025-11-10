Return-Path: <linux-kernel+bounces-893889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BCFF8C4892B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 19:32:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 40A7A3481ED
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 18:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A04F832E744;
	Mon, 10 Nov 2025 18:29:10 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC3932E724
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 18:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762799349; cv=none; b=b4thn53RvOiGadW7binuZEuQa1KQ5Tz0K2qU/tHv1bG2tkJjDHtBfOgd4erFSPbNw/IH9GGLJDTnVJPhEbrbrrYJzANDSbxfAT4AFS8AZUgENz7rqvu48pk0NjCeVRH995dKsOwWQz7ZpInuhKFxZ76qndoWh5o6ZI1eC3pgrAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762799349; c=relaxed/simple;
	bh=+M+EpIhdhvTKy9ZSyJnKD8DebB4v3rTBt6IbCZocI6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FFH3nI8NvHyavIeoQPctFuKI4tDwsdQ/6GFsLdnxe3Xpm2qo2vYkAgUSkRZiprJ/y6urcoHlhCIIUHE6o1R6i7NXHYvMsqvCmK3A1f6LWp3gnq624ln/XXj7QZUabBu7jX5tPVzxbogzDKM4xQ7V8sp542A063YQhJaLD4pydPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf05.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id 4094616023E;
	Mon, 10 Nov 2025 18:28:58 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf05.hostedemail.com (Postfix) with ESMTPA id E90282000E;
	Mon, 10 Nov 2025 18:28:55 +0000 (UTC)
Date: Mon, 10 Nov 2025 13:29:04 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>, linux-kernel@vger.kernel.org,
 Dan Williams <dan.j.williams@intel.com>, Theodore Ts'o <tytso@mit.edu>,
 Sasha Levin <sashal@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Kees
 Cook <kees@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Miguel Ojeda <ojeda@kernel.org>, Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH] [v2] Documentation: Provide guidelines for
 tool-generated content
Message-ID: <20251110132904.2a74a48f@gandalf.local.home>
In-Reply-To: <11eaf7fa-27d0-4a57-abf0-5f24c918966c@lucifer.local>
References: <20251105231514.3167738-1-dave.hansen@linux.intel.com>
	<11eaf7fa-27d0-4a57-abf0-5f24c918966c@lucifer.local>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 98ekgzppsam5zbdaxgkubgb4bqodc1ko
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: E90282000E
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/q3llvVxyEa3FU9jEBNDJiOFyTl8Z0lmI=
X-HE-Tag: 1762799335-950934
X-HE-Meta: U2FsdGVkX19rgq965M4Dke9NmaU2iANE9fClW7x+YHniSBuTFhs3ZZXw7i7NTQNdG9da39tmwX31r6HspT3V9ko60uQemRUYr6cIv6tL4j3dMfQUAj5Y86UO7K5/43cywoFHvtkW9ALuSs6cWrnreiZMQJlwTnE2xSU8guyNGxvJe9MRQbqbjZsOISgfbqrQ2u9vz3EJRvwbU8ruvXgs8B4RuWAFNYm+a8vpkIHRJ6rA4Ga71smOXsUHdw3cJ3HEWuOaWuC0yN7viDPhvSJTWmw9MG+QPOPGSgial+f+SeQtsyZtpABKCFM27tI3HPwCPAYLxAADzbWjJX8HOzpEZ+WDpYUnDvTSQeNSivQrrZTVS9V4EjyB1cJTenW3mRXH7dIh6BbSiDPuUeVGqn6Za7forDUH6AEcu97rU3HbvtY=

On Mon, 10 Nov 2025 10:48:04 +0000
Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:

> I think it would have been helpful to ping those engaged in the discussion in
> this area in related threads, e.g. [0] and [1].
> 
> [0]: https://lore.kernel.org/ksummit/49f1a974-e1e6-4be5-864e-5e0f905e1a8f@paulmck-laptop/T/#m30873ef3dc9bd2c4c95547e81efff3085474f2d9
> [1]: https://lore.kernel.org/all/7e7f485e-93ad-4bc4-9323-f154ce477c39@lucifer.local/
> 
> I'm not sure what the process was that lead to this, but it feels rather as if
> the community were excluded here.

As others have mentioned, this was brought up in the TAB a while ago. In
fact, it was started when I found out that Sasha sent me an AI generated
patch without my knowledge and I only found out about it from reading an
LWN article[1] that covered Sasha talking about it at OSS. ;-)

At that point, I realized we needed some rules to come up with some
transparency and I brought it up at a TAB meeting. Sasha, who is also on the
TAB, agreed with this, and said he should have been more transparent. This
started the conversation about how this is going to become much more
prevalent in the future, and we need to have some kind of documentation on
how to address it. With the idea of solving the transparency issue first,
and *not* covering the acceptance of AI in general, should help you
understand better why this document was created.

> 
> It also seems slightly odd to produce this in advance of the maintainer's
> summit, as I felt there was some agreement that the topic should be discussed
> there?

As Jon mentioned. We should start the conversation *before* maintainers
summit. Everyone needs to full vet their opinionated view points before
they arrive! ;-)

> 
> Obviously there may be very good reasons for this but it'd be good for them to
> be clarified and those who engaged in these discussions to be cc'd also (or at
> least ping on threads linking!)

Agreed. There was no mal intent here. Just simply forgetting to do so.

> 
> On Wed, Nov 05, 2025 at 03:15:14PM -0800, Dave Hansen wrote:
> > In the last few years, the capabilities of coding tools have exploded.
> > As those capabilities have expanded, contributors and maintainers have
> > more and more questions about how and when to apply those
> > capabilities.
> >
> > The shiny new AI tools (chatbots, coding assistants and more) are
> > impressive.  Add new Documentation to guide contributors on how to
> > best use kernel development tools, new and old.  
> 
> As others have pointed out, this is strangely gleeful, can we please drop it?

I like the word "shiny" as it does represent how people feel about the
products here (even if it's a bit sarcastic). But the word "impressive"
should be removed. I think it can be replaced with something more "factual"
(like what Christian brought up). I wouldn't drop the sentence completely,
but would instead state that they have become much more advanced, and needs
to be addressed.

> 
> As mentioned in the msummit thread I have a great concern about how the press
> might report on this kind of change, as I fear that a 'kernel accepts AI
> patches' story might result in a large influx of AI patches from enthusiatic
> people which will have a direct impact on maintainer workload.

One thing we did discuss in the TAB was that we didn't want this document
to state anything "new". As Dave expressed in the change log. The goal of
this document was to articulate the current process a bit clearer. Perhaps
an "RFC" should have been attached to the subject, as expressing the
current process most definitely requires input from the rest of the
community.

> 
> I don't think comments like this help in that respect.
> 
> In general I feel that a more restrictive/pessmistic document that can later be
> made less pessimistic/restrictive is a better approach than a broad one on this
> basis.

I disagree about the "pessimistic" part. I do agree with Christian in
making it more "matter-of-fact" and less about what is accepted and what is
not. The goal here was transparency, not acceptance.

> 
> >
> > Note, though, there are fundamentally no new or unique rules in this
> > new document. It clarifies expectations that the kernel community has  
> 
> Hmm, I'm not sure the conflation of pre-existing tooling which always required
> some degree of understanding vs. a technique which can simply generate entire
> patch sets with commentary included is justified.

I disagree. AI is really just a more advanced version of the existing
tools. Articulating the rules we expect from existing tooling will help us
understand how we can deal with the new AI tooling.

> 
> While I _do_ like the idea that basic principles that already existed still
> exist for LLMs (that's a powerful notion), I wonder if we do in fact do need
> some new rules here.

New rules would need to be decided at the maintainers summit, and is out
of scope of this document.

> 
> I think saying this also pushes back on the concept of maintainer-by-maintainer
> policy as 'it's just like it always was' doesn't suggest that it warrants a
> higher level of scrutiny.

I like to keep things more "like it always was" and to update the tone if
it becomes apparent that we need to.

> 
> > had for many years. For example, researchers are already asked to
> > disclose the tools they use to find issues in
> > Documentation/process/researcher-guidelines.rst. This new document
> > just reiterates existing best practices for development tooling.  
> 
> Ironically that document is considerably more strident and firm than this
> one :)

Not "ironically". That document was a direct result of the UMN[2] incident.
Where we were indeed addressing a severe issue that had occurred.

This document is addressing something that "might" occur. Which means it
does not need to be as firm. It's goal is more of helping people understand
what to do when AI is presented.

> 
> >
> > In short: Please show your work and make sure your contribution is
> > easy to review.  
> 
> I wonder whether we need to be very explicit in stating - please do not
> generate patches in large volume with no involvement from you and
> _emphasise_ that human involvement is _necessary_.

I agree with the above, but this document is still more of a transparency
document than how to cover AI submissions.

When we add more about AI rules (I hope will be discussed at the
maintainers summit), it should be stated that all of the AI generated code
should be totally understood by the submitter (or someone that added their
reviewed-by tag).

As the focus of this document is just about transparency, I think that part
is out of scope, but was partially addressed in:

+ - Ask the submitter to explain in more detail about the contribution
+   so that the maintainer can feel comfortable that the submitter fully
+   understands how the code works.


> 
> In discussion with kernel colleagues who use AI extensively, there is a
> very clear pattern than a key part of usefully making use of this tooling
> is for there to be an 'expert in the loop' who reviews what is generated to
> ensure it is correct.
> 
> I therefore think we either _should_ have a specific rule for LLM-generated
> content or should (and it really makes sense actually) have a broad
> 'generated content' rule that - you _must_ have a thorough understanding of
> what you are doing such that you can review and filter the generated
> output.
> 
> I think stating that we will NOT accept series that are generated without
> understanding would be very beneficial in all respects, rather than leaving
> it somehow implied.
> 
> Being soft or vague here is likely to cause maintainer headaches IMO
> (though of course there's only so many who will read a doc etc. being able
> to point at the document in reply as a maintainer is useful too).

Again, the point of this document is about transparency of tooling, not the
rules on its acceptance.


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
> 
> Not sure repeatedly using coccinelle as an example is helpful, as
> coccinelle is far less of an issue than LLM tooling, perhaps for the
> avoidance of doubt, expand this to include references to that?

My feeling on this is that most people are familiar with coccinelle, and by
using it as an example can help people understand this better.

> 
> > + - If code was largely generated from a single or short set of
> > +   prompts, include those prompts in the commit log. For longer
> > +   sessions, include a summary of the prompts and the nature of
> > +   resulting assistance.  
> 
> Maybe worth saying send it in a cover letter if a series, but perhaps
> pedantic.
> 
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
> 
> OK I wrote something suggesting you add this and you already have :) that's
> great. Let me go delete that request :)
> 
> However I'm not sure the 'as with all contributions' is right though - as a
> maintainer in mm I don't actually feel that we can reject outright without
> having to give significant explanation as to why.
> 
> And I think that's often the case - people (rightly) dislike blanket NAKs
> and it's a terrible practice, which often (also rightly) gets pushback from
> co-maintainers or others in the community.
> 
> So I think perhaps it'd also be useful to very explicitly say that
> maintainers may say no summarily in instances where the review load would
> simply be too much to handle large clearly-AI-generated and
> clearly-unfiltered series.

This is something that we discussed in the TAB, and that was to say if the
maintainer is not comfortable with taking code that was created fully by AI
(due to whatever reason), they still have the right to not accept it. At
least until there's a concrete decision on how we handle fully AI generated
code.

Just like today maintainers can blindly reject checkpatch or spelling fixes
to existing code.

> 
> Another point to raise perhaps is that - even in the cases where the
> submitter is carefully reviewing generated output - that submitters must be
> reasonable in terms of the volume they submit. This is perhaps hand wavey
> but mentioning it would be great not least for the ability for maintainers
> to point at the doc and reference it.

I think that is out of scope of this document.

Thanks for all the feedback. It most definitely helps with the discussion!

-- Steve

[1] https://lwn.net/Articles/1026558/
[2] https://lore.kernel.org/lkml/202105051005.49BFABCE@keescook/

