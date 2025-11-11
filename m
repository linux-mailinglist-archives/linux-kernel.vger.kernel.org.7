Return-Path: <linux-kernel+bounces-896315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DF73C5016E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 00:46:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 095884E68E4
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 23:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C3552F60B5;
	Tue, 11 Nov 2025 23:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="NpqkHGYi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="m1/vwgrX"
Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 847642F5A08
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 23:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762904737; cv=none; b=mK/fZMXmYh+fTVc9X14ZdaArsXNHSERvIDsj/kfC/nVVgiHTBB+QJ9ZKnAATm4VS0+JhPDwIyG5s2vNK8Bt4SAJxFaqbH3gq3KXTDVh9ouWNIsWax/WYfGkR3EsR+CtbkR4a5vlsK7aOdISwPcwuoZPAOWxY1KfQ50Y00GEJq9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762904737; c=relaxed/simple;
	bh=fNzy7QxTGMBwNFwj81zofOjNvq8+j5yqZzJk30go608=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=RGEYIy46T/iL6HMu75DrrcFJ27SkhTwnxhKF5izLvjs8lgZuRixW8F3IZQ+yiCjaWhAgIpUHzjkf4MEcfQ7RtaYbqLHcKGXdi8d961ryzPdyaHsEqmE3FHjSG1AkbODAXH+aCSpDGJFfXLwRnmy9QnDoj8BBUq3zCFRcaujyY4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=NpqkHGYi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=m1/vwgrX; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 705597A014C;
	Tue, 11 Nov 2025 18:45:33 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Tue, 11 Nov 2025 18:45:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm3; t=
	1762904733; x=1762991133; bh=NgoH1lbWlqAIFYoQclOd4QJQtPmtqR39q8x
	4pTvb8/4=; b=NpqkHGYi4O4dU5S2egT1ZrEK6hVxCXhyfQKnV4EUfxxkDeVgUGs
	j/9KwdwPXVoR3Mr7FC+8ZsD/EpoAnoGMR1scyMBibB/FyuBdI6Zsx85ivW0lxu4w
	93BLlwglVIY0wT3Dr9clQqUz5Tf1hgiSBv1+2YIT+7QVNoBIq22TceTfNi/cPrqq
	kzfyzNYSlzZCFRhfZGp/QAa8ytsjaQ3xqaprU6ISrZrtCF2W0jgzX3XCNbWu9Xm5
	RQKk1sKIiTk3ywiwsg50kT2GRu/Ye/lMgnz7VDfq65b192xARfaKBAW6bb3gNcIO
	ELGan6Q9QlaPE6ymlGAws4zuwkJkYGbMCHQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1762904733; x=
	1762991133; bh=NgoH1lbWlqAIFYoQclOd4QJQtPmtqR39q8x4pTvb8/4=; b=m
	1/vwgrXvKdG727pPxaYProz0hwLrvys9fUL4o/KgATq+uYynKg4UierFAfZP39Cx
	JCD1j/lpAThZhcYDGKfWqqFqpSCXcnV5H1w9nUjlGCpQ5c5/7jnBQ++99F+kcN7F
	5y7KpHS5+2wRESoZRi45HzQf+QEYQSQx2TW8yXVbWV8C++oIThYW3a2WCtJNpung
	SJ8Kq4Hje4fjiufTuWdZ8ak1O2XFhsNGVdiWKR/+0h1gCBZF91+efmIfE/LZaDP0
	ybPRKIc0HtSf55XmAuhazQSLlBMJobdp3k8Ucvvj4idV3Fm1jKJqT2Uh8KV07n2P
	6zABlq0XWibODFRo0EEqQ==
X-ME-Sender: <xms:nMoTackWDaPK6cfLJY55alahy6d-JJ9DdRTtMXzfrAzgiKGWD7doCg>
    <xme:nMoTaaHPz-ALjvve-o96258wjOqxjHNv3bs_ri_ptk81g7Jkr1bAfxYrkeuyJAGr_
    reVfTjYc8pIvWxM8nr-QhfoIoLxDAHvzyAuUXGCHs99BJGmCg>
X-ME-Received: <xmr:nMoTaT9RwGpttO-MDOxY5tOuW1iWvy_Y2kMaTyIBNLr3nTn6BwbtBpinZG1pegi8k0jgvKntDMhZ9j3sGXSMeavyqwZKWoVwjT7uW2vqAeS6>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvtddvheegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurheptgfgggfhvfevufgjfhffkfhrsehtqhertddttdejnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epleejtdefgeeukeeiteduveehudevfeffvedutefgteduhfegvdfgtdeigeeuudejnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsg
    esohifnhhmrghilhdrnhgvthdpnhgspghrtghpthhtohepuddupdhmohguvgepshhmthhp
    ohhuthdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopehthihtshhosehmihhtrdgvughupdhrtghpthhtoheptgho
    rhgsvghtsehlfihnrdhnvghtpdhrtghpthhtohepghhrvghgkhhhsehlihhnuhigfhhouh
    hnuggrthhiohhnrdhorhhgpdhrtghpthhtohepuggrvhgvrdhhrghnshgvnheslhhinhhu
    gidrihhnthgvlhdrtghomhdprhgtphhtthhopehshhhurghhsehkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehsrghshhgrlheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepohhj
    vggurgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgvvghssehkvghrnhgvlhdroh
    hrgh
X-ME-Proxy: <xmx:nMoTabkE2rsamBvO-kJxDMEfZXo_HF3dgi-neCMqcyfZl7vNZKfxLA>
    <xmx:nMoTaeBTaXQHzbm4tgs-NtoyjyZ6pnAiVZHNTM6hlxs77zbXS-nHbA>
    <xmx:nMoTaUVh5YHWexvETWaqU5ETXZF6BhLSyZU3ZHG6K2nAhTncl562OA>
    <xmx:nMoTac-h-606mm2-e2X50_EtoI7MrnvsF8CH97_r9ThX7Au3r50cZg>
    <xmx:ncoTabpHArScz3xadyA1m5hj-pT10dYpWYpGnHxvIehM7RrENg_wx8pn>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Nov 2025 18:45:29 -0500 (EST)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Dave Hansen" <dave.hansen@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, "Dave Hansen" <dave.hansen@linux.intel.com>,
 "Steven Rostedt" <rostedt@goodmis.org>,
 "Dan Williams" <dan.j.williams@intel.com>, "Theodore Ts'o" <tytso@mit.edu>,
 "Sasha Levin" <sashal@kernel.org>, "Jonathan Corbet" <corbet@lwn.net>,
 "Kees Cook" <kees@kernel.org>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Miguel Ojeda" <ojeda@kernel.org>, "Shuah Khan" <shuah@kernel.org>
Subject:
 Re: [PATCH] [v2] Documentation: Provide guidelines for tool-generated content
In-reply-to: <20251105231514.3167738-1-dave.hansen@linux.intel.com>
References: <20251105231514.3167738-1-dave.hansen@linux.intel.com>
Date: Wed, 12 Nov 2025 10:45:27 +1100
Message-id: <176290472743.634289.7009461719971062344@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Thu, 06 Nov 2025, Dave Hansen wrote:
> In the last few years, the capabilities of coding tools have exploded.
> As those capabilities have expanded, contributors and maintainers have
> more and more questions about how and when to apply those
> capabilities.
>=20
> The shiny new AI tools (chatbots, coding assistants and more) are
> impressive.  Add new Documentation to guide contributors on how to
> best use kernel development tools, new and old.
>=20
> Note, though, there are fundamentally no new or unique rules in this
> new document. It clarifies expectations that the kernel community has
> had for many years. For example, researchers are already asked to
> disclose the tools they use to find issues in
> Documentation/process/researcher-guidelines.rst. This new document
> just reiterates existing best practices for development tooling.
>=20
> In short: Please show your work and make sure your contribution is
> easy to review.
>=20
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
>=20
> --
>=20
> This document was a collaborative effort from all the members of
> the TAB. I just reformatted it into .rst and wrote the changelog.
>=20
> Changes from v1:
>  * Rename to generated-content.rst and add to documentation index.
>    (Jon)
>  * Rework subject to align with the new filename
>  * Replace commercial names with generic ones. (Jon)
>  * Be consistent about punctuation at the end of bullets for whole
>    sentences. (Miguel)
>  * Formatting sprucing up and minor typos (Miguel)
> ---
>  Documentation/process/generated-content.rst | 94 +++++++++++++++++++++
>  Documentation/process/index.rst             |  1 +
>  2 files changed, 95 insertions(+)
>  create mode 100644 Documentation/process/generated-content.rst
>=20
> diff --git a/Documentation/process/generated-content.rst b/Documentation/pr=
ocess/generated-content.rst
> new file mode 100644
> index 0000000000000..5e8ff44190932
> --- /dev/null
> +++ b/Documentation/process/generated-content.rst
> @@ -0,0 +1,94 @@
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

"critical"?  Really?
If I use "sed" to create a patch, it might be helpful for you to know
that, but not critical.

> +
> +The goal here is to clarify community expectations around tools. This
> +lets everyone become more productive while also maintaining high
> +degrees of trust between submitters and reviewers.

I like the mention of trust.  I think that is a foundational issue here.
I wonder if it could be emphasised more.

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
> + - Reformatting, like running Lindent, ``clang-format`` or
> +   ``rust-fmt``
> +
> +Even if your tool use is out of scope you should still always consider
> +if it would help reviewing your contribution if the reviewer knows
> +about the tool that you used.

I also like the focus on "helping the reviewer".  That too is
foundational.

  When submitting a patch you will benefit from efforts to build trust
  with the maintainer, and anything you do to help the review process
  run smoothly will help your patch get accepted.  Some guidelines for
  how this applies with respect to tool-assisted patch creation, and LLM
  (aka AI) in particular, are below.
??

> +
> +In Scope
> +=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +These guidelines apply when a meaningful amount of content in a kernel
> +contribution was not written by a person in the Signed-off-by chain,
> +but was instead created by a tool.
> +
> +Detection of a problem is also a part of the development process; if a
> +tool was used to find a problem addressed by a change, that should be
> +noted in the changelog. This not only gives credit where it is due, it
> +also helps fellow developers find out about these tools.

I'm not sure about "Credit where it is due".  We stand on the shoulders
of giants and listing all those giants could become burdensome.
I'm not sure we have a duty to help fellows find out about tools, though
that is certainly a valuable side-effect (If you find a tool useful,
write about it for lwn :-)

I think keeping the focus on helping the reviewer is best.  Knowing the
motivation of a patch is often useful, and that can usefully include
details of tools used.

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

"choose transparency" is a good default.

> +
> +Guidelines
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
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
> +
> +As with all contributions, individual maintainers have discretion to
> +choose how they handle the contribution. For example, they might:
> +
> + - Treat it just like any other contribution
> + - Reject it outright

If I find that a maintainer might reject my tool-based submission
outright, I might be tempted towards less transparency.
I don't think we should legitimise this sort of response by listing it
here.

> + - Review the contribution with extra scrutiny
> + - Suggest a better prompt instead of suggesting specific code changes
> + - Ask for some other special steps, like asking the contributor to
> +   elaborate on how the tool or model was trained
> + - Ask the submitter to explain in more detail about the contribution
> +   so that the maintainer can feel comfortable that the submitter fully
> +   understands how the code works.

This last point contains an important idea that I think could be
highlighted more.  The submitter needs to understand, and be able to
defend, the submission; both its motivation and its content.
"A tool generated the patch" is useful information but never an excuse
for not understanding it.

Thanks,
NeilBrown

