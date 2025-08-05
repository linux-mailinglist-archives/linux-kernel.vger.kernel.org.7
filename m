Return-Path: <linux-kernel+bounces-757077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC749B1BD67
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 01:33:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15AE216A6C5
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 23:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2BED23E340;
	Tue,  5 Aug 2025 23:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BuxcEWw8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12BA71C5D44;
	Tue,  5 Aug 2025 23:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754436820; cv=none; b=NoxO25sLPACTd/3AEko9JDOD17MCiHSUAmuZoTZB8o2aY1igrWQ8SH+2OlAeOCb0Xooxcx0avdgM89HZc1Qn915t8qCpeO+/Crk/tmZdhy4sm40mw8CK8NtLJr0aq0yafs/EhOO6K/WqFw5wPrzBgBGNb99VYLvtnlDv9xxnjvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754436820; c=relaxed/simple;
	bh=wxrqDkkL6fPpPQWfJd1nCMaA8HRkL9AhcFhln5p9sv0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WInEbCE+pr2RV88Fw7wkyVixqwnb0iTDSy4jn7PEvwYHgE/UwfvKvj6bgedpHZs4AjBc3lP1f3w2OVQjhotwdqfd9EqHCq8oS+DBc+Llk0duigbRLdv+9IS83uOnwVDXbqv/rRP7KsGiboa64KbJ4eeDhtY4m38egqgK+7vWTAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BuxcEWw8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 677D3C4CEF0;
	Tue,  5 Aug 2025 23:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754436819;
	bh=wxrqDkkL6fPpPQWfJd1nCMaA8HRkL9AhcFhln5p9sv0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BuxcEWw8iUgdH2Zf9IRrTWjBV5yoVJqMeHztvhxhb8Clomd9UIjQukYWMOyhx0rD6
	 LcbpIM80BHQcd+bz6FXByLFSJNCTBwkXF7jQV3Wvv/FaWrzL7H7yGZ6umRYvBRZjvs
	 ciLTqstr4izCq823DuwYry5BB29T2jlHi4Xf5T/N1YrlisfELg3LRmzyLKmEuR0u4I
	 Kqqm4aHNDt1OHR0ZPEiyziJj5SMM+9aLq28oV7RUxEUXwLMVHkBL29VqYH1QJKKcTc
	 AyLI/ZTifNQ6HvseSHxKO8JAnXNTN1L8BMI2ckspm/d/+2S9Vtap4PfTUJ5ujIIy4Y
	 77dG8KRvFwNDQ==
Date: Tue, 5 Aug 2025 19:33:37 -0400
From: Sasha Levin <sashal@kernel.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Jeff Johnson <jeff.johnson@oss.qualcomm.com>, corbet@lwn.net,
	linux-doc@vger.kernel.org, workflows@vger.kernel.org,
	josh@joshtriplett.org, kees@kernel.org,
	konstantin@linuxfoundation.org, linux-kernel@vger.kernel.org,
	rostedt@goodmis.org
Subject: Re: [PATCH 4/4] agents: add legal requirements and agent attribution
 guidelines
Message-ID: <aJKU0ajcG1Xtrqrf@lappy>
References: <20250727195802.2222764-1-sashal@kernel.org>
 <20250727195802.2222764-5-sashal@kernel.org>
 <771aef93-df3e-4a9b-b6d9-3a5057f77ddb@oss.qualcomm.com>
 <20250805231150.GD16330@pendragon.ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250805231150.GD16330@pendragon.ideasonboard.com>

On Wed, Aug 06, 2025 at 02:11:50AM +0300, Laurent Pinchart wrote:
>On Tue, Aug 05, 2025 at 03:08:45PM -0700, Jeff Johnson wrote:
>> On 7/27/2025 12:58 PM, Sasha Levin wrote:
>> > And below is the first test of this scheme:
>> >
>> > Co-developed-by: Claude claude-opus-4-20250514
>> > Signed-off-by: Sasha Levin <sashal@kernel.org>
>> > ---
>> >  Documentation/agents/index.rst |  3 ++-
>> >  Documentation/agents/legal.rst | 42 ++++++++++++++++++++++++++++++++++
>> >  Documentation/agents/main.rst  |  5 ++++
>> >  3 files changed, 49 insertions(+), 1 deletion(-)
>> >  create mode 100644 Documentation/agents/legal.rst
>> >
>> > diff --git a/Documentation/agents/index.rst b/Documentation/agents/index.rst
>> > index 354af3f025e5..982602db3349 100644
>> > --- a/Documentation/agents/index.rst
>> > +++ b/Documentation/agents/index.rst
>> > @@ -9,4 +9,5 @@ Agents
>> >
>> >     main
>> >     core
>> > -   coding-style
>> > \ No newline at end of file
>> > +   coding-style
>> > +   legal
>> > \ No newline at end of file
>> > diff --git a/Documentation/agents/legal.rst b/Documentation/agents/legal.rst
>> > new file mode 100644
>> > index 000000000000..67e6b2cdff9d
>> > --- /dev/null
>> > +++ b/Documentation/agents/legal.rst
>> > @@ -0,0 +1,42 @@
>> > +.. SPDX-License-Identifier: GPL-2.0
>> > +
>> > +===============================
>> > +Legal Requirements for Agents
>> > +===============================
>> > +
>> > +This document outlines critical legal requirements that coding agents must follow when working with the Linux kernel codebase.
>> > +
>> > +Licensing Requirements
>> > +----------------------
>> > +
>> > +**GPL-2.0 License**
>> > +  The Linux kernel is licensed under GPL-2.0 only with a syscall exception. Coding agents MUST follow this licensing rule with no exceptions. Any code contributed must be compatible with this license.
>> > +
>> > +**SPDX License Identifiers**
>> > +  All files must have proper SPDX license identifiers. For most kernel source files, this should be the first line of the file in the appropriate comment format:
>> > +
>> > +  - For C source/header files: ``// SPDX-License-Identifier: GPL-2.0``
>> > +  - For scripts: ``# SPDX-License-Identifier: GPL-2.0``
>> > +  - For documentation: ``.. SPDX-License-Identifier: GPL-2.0``
>>
>> I believe the agent has not processed the following correctly:
>> https://www.kernel.org/doc/html/latest/process/license-rules.html
>>
>> 1) C header files use /* SPDX-License-Identifier: <expression> */
>> 2) Contributions need not be GPL-2.0, "individual files can be provided under
>> a dual license, e.g. one of the compatible GPL variants and alternatively
>> under a permissive license like BSD, MIT etc."
>>
>> These two issues jumped out at me...
>
>And the text isn't properly wrapped. Also, compiling the series, I get
>
>----------------------------------------
>Documentation/agents/main.rst:3: WARNING: Title overline too short.
>
>=====================================
>Linux Kernel Development Agent Instructions
>=====================================
>
>[...]
>
>Documentation/agents/index.rst: WARNING: document isn't included in any toctree [toc.not_included]
>----------------------------------------
>
><irony>
>
>Sasha, please make sure you read the kernel documentation before
>submitting patches. We understand there's a learning curve, but we
>expect contributors to perform due diligence to avoid wasting the time
>of reviewers. I would have expected a human developer submitting patches
>generated by LLMs to have proof-read the patches, compiled them, and
>fixed those issues.
>
></irony>

I thought I was being smart doing that so only AI agents would see that
stuff but it wouldn't appear in any human readable documentation.

I haven't realized checkpatch would complain :)

Anyways, I need to resend this with the improvements suggested by Kees
and Greg where we instead improve and expand the README at root. Let me
go clean it up...

-- 
Thanks,
Sasha

