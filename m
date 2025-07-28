Return-Path: <linux-kernel+bounces-747910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13215B13A1E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 13:57:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B03C174E97
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 11:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A82F8261586;
	Mon, 28 Jul 2025 11:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RqfwJbyi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BFC0218858;
	Mon, 28 Jul 2025 11:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753703842; cv=none; b=RMHeEu46aFf5iVo4r3TwJ1XMcNN3siYsIlKBK7wHOaDAxeCovRFSOnj5OUijQVQ5BzVkfrryWW3uud8NbxTUrES0Y9io3+3KFR4UYHJj3JIxOChu5sBDYwP846EPDwI8DiKqOUaHqq0KLBUa9iS9F8SRSJ98Uk+UK+ti6oNwfuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753703842; c=relaxed/simple;
	bh=KwknBtm3rG8DZ9E+8sUrsu3OOrib3fyBjqPLFr4ycAs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iNGHeH2t9hG1N0/KT2dCW3xi8n7OTIoToO+JSnRk2jQKmx5GyIpVsnRuiOrmhvejga+VtLccbsRGDqHbJWgsm2NacWPb2E6rNgqwyE2CgGlhvsXXR97qJ4bRuYz/naLSgDFrdCsvy0fzURYcgXbkAxoSnsIn4ep6aEGNam0eHiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RqfwJbyi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A28FC4CEE7;
	Mon, 28 Jul 2025 11:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753703838;
	bh=KwknBtm3rG8DZ9E+8sUrsu3OOrib3fyBjqPLFr4ycAs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RqfwJbyixeU0CGFFCnQZPxoYw0lIQjtYHTfeCRbeKA4fVeubMfZRtZOMK5vibGMIi
	 ZAhwSX2tIHBJlEebJNoQONALCqV4XQXU4EhG1TmAyee9dGXtbIflgBrVE1tUG7aIK+
	 YltsV8lPTR5rKPj1EGlsoYzgIegsz0/kAlCC9yNIAw2/0LtibcC71eDLVF/8hK7YzM
	 E4xsh27AI2ipBu12xiyMTmdvpuQf0VMOta3+t5kAxZPd1tKONDtMDHq4WVcrvBBc9U
	 FUczJ2bVLW8egOnL6VpKUvhB6od74ihSwOv+Xwoif3T2umZMdU05z10s+X6MVbzTRP
	 sjoA9F7Jyxgmw==
Date: Mon, 28 Jul 2025 07:57:16 -0400
From: Sasha Levin <sashal@kernel.org>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: corbet@lwn.net, linux-doc@vger.kernel.org, workflows@vger.kernel.org,
	josh@joshtriplett.org, kees@kernel.org,
	konstantin@linuxfoundation.org, linux-kernel@vger.kernel.org,
	rostedt@goodmis.org
Subject: Re: [PATCH 0/4] Add agent coding assistant configuration to Linux
 kernel
Message-ID: <aIdlnHcNHvOxVxGF@lappy>
References: <20250727195802.2222764-1-sashal@kernel.org>
 <75d86e96-cb18-4996-998c-da7ac0e97468@suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <75d86e96-cb18-4996-998c-da7ac0e97468@suse.cz>

On Mon, Jul 28, 2025 at 09:58:44AM +0200, Vlastimil Babka wrote:
>On 7/27/25 21:57, Sasha Levin wrote:
>> This patch series adds unified configuration and documentation for coding
>> agents working with the Linux kernel codebase. As coding agents
>> become increasingly common in software development, it's important to
>> establish clear guidelines for their use in kernel development.
>
>Hi,
>
>this series seems to me somewhat premature. I think we first need a clear
>policy wrt LLM usage for the *humans* to follow. It seemed this thread [1]
>was going into that direction wrt usage disclosure. BTW I was quite shocked
>by Steven's reply there [2] that he learned from the LWN coverage of a
>conference talk that he had received a patch fully written by LLM without
>any such indication. Now I'm not naive to believe that it's not been
>happening already from e.g. first-time contributors, but if that coverage
>was accurate, the patch came from a very seasoned kernel contributor and I
>really wouldn't expect that to happen.

You mean that you had a concern that the same person who wrote
hashtable.h was using tooling to convert open coded implementations of a
hashtable to the API provided by hashtable.h?

I've been doing this since 2012 (see 42f8570f437b ("workqueue: use new
hashtable implementation")) with the various tools that the we have for
mechanical transmormations of code.

I understand Steve's point of view on this, and this series is here to
tackle the concerns raised both by him and the rest of the community.

>Also I don't know e.g. the copyright and licensing implications of LLM usage
>beyond, say, a smarter automplete are clear? (again, such as writing the
>full patch?) The thread [1] touched on it somewhat but not completely. If
>that's clear already (IANAL), I'd hope that to be also part of such policy.

The LF already has guidance
(https://www.linuxfoundation.org/legal/generative-ai) for this type of
contributions that was created by LF's lawyers.

Clearly we can override, expand, or affirm it if we want to, but just
like you, IANAL.

>I know that your series has patch 4, but that seems to be part of what the
>LLM is supposed to include for its prompt (does it make sense to call it
>"legal requirements" then?). If it fails to e.g. add the "Co-developed-by:"
>there seems to be nothing saying the human should check these things in the
>output.

Right - as pointed to later in the thread, that part is already in
progress.

The approach in this series would be to cover the technical aspects of
supporting whatever policy we end up with.

>So without such policy first, I fear just merging this alone would send the
>message that the kernel is now officially accepting contributions done with
>coding assistants, and those assistants will do the right things based on
>these configuration files, and the developers using the assistants don't
>need to concern themselves with anything more, as it's all covered by the
>configuration.

Note that at the current state of our policies and documentation, if you
were to pretend to be a developer completely unfamiliar with the Linux
Kernel project, the conclusion you'd reach is that the project
"officially" accepts contributions that are in line with LF's policies.

If anything, this series clamps down on that.

-- 
Thanks,
Sasha

