Return-Path: <linux-kernel+bounces-746455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52BC6B126DC
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 00:28:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBD2316CC32
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 22:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0BC32561D9;
	Fri, 25 Jul 2025 22:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="phPiCYiE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B5C4A3C;
	Fri, 25 Jul 2025 22:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753482500; cv=none; b=MVatbKEhBRNCWWRXhjToShUamONVRqfQMUJLV/HUrg7sKsyAxTA8CYo3x6sSl0cROzpRIBih1kddqsp0og6RmdJB5c/wggxAILUKyZ3+TO/f/+aR4J4MaT+SuUch7OQxSF+OmEu3+Vhw8ss4ZcyXaGbZov2WLLzWE9zpUW91EbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753482500; c=relaxed/simple;
	bh=IA/3Rq/lSRQOIAbyCx490JQ2nR5mykmx1PNVdvpm3YE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hyjzoNRl2sz1Gl0RkeqiaX2HWXEHOf0oeEJsK4KR0dU0KUACl7VOsknlvgbo7WFUAboK7um+byp6wb0arXtqnqxKTLrAO5P7Zas5/CN33057EB9/Z2LtxAO5oiICCtPrEd75aVMKvfCWO4CDn2idPsWr1vk5KwT7YFpS8L5RIGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=phPiCYiE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F479C4CEE7;
	Fri, 25 Jul 2025 22:28:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753482497;
	bh=IA/3Rq/lSRQOIAbyCx490JQ2nR5mykmx1PNVdvpm3YE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=phPiCYiEjwPtja53/yXoBS4mduXjOJx8hils6W/D7BjugYsE9rwrPaO6w+0QNpox4
	 DnBYTipdalJCfft1DmElQKAzQl65t9rfVm3r2FHQlm/2oehAeiz2VBy+MlPKuyfhqw
	 70SYpcd3C3RQZ/FepwHu5/IqQ2AJUkju7piYcseo+w8ugnVKJIjo31eOwH3i4kCKei
	 W6xnHWj7XYykUEkZq7To61Xcd+l9Sis4xBNGoEgJQouDvLkUuu/aIGrFxCJQ6wt3ol
	 I1RSqksnEGK0LeT7dEp2gspKN8raK+9+NjJUAYMZrDQc3ONz1v+XuyhJEnUT5vioeq
	 RCswNWQAUBcCw==
Date: Fri, 25 Jul 2025 18:28:10 -0400
From: Sasha Levin <sashal@kernel.org>
To: dan.j.williams@intel.com
Cc: Jakub Kicinski <kuba@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
	workflows@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, kees@kernel.org,
	konstantin@linuxfoundation.org, corbet@lwn.net,
	josh@joshtriplett.org
Subject: Re: [RFC 0/2] Add AI coding assistant configuration to Linux kernel
Message-ID: <aIQE-hkg5ehHaSZi@lappy>
References: <20250725175358.1989323-1-sashal@kernel.org>
 <20250725114114.3b13e7b1@kernel.org>
 <20250725150046.3adb556c@gandalf.local.home>
 <20250725125906.1db40a7f@kernel.org>
 <6883ea58b5685_134cc71006e@dwillia2-xfh.jf.intel.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <6883ea58b5685_134cc71006e@dwillia2-xfh.jf.intel.com.notmuch>

On Fri, Jul 25, 2025 at 01:34:32PM -0700, dan.j.williams@intel.com wrote:
>Jakub Kicinski wrote:
>[..]
>> To be clear, it's not my main point, my main point is that
>> the information is of no proven use right now. As long as
>> committer follows the BKP of adding Link: https://patch.msgid.link/...
>> we can find the metadata later.
>>
>> We never found the need to attach the exact version of smatch / sparse
>> / cocci that found the bug or "wrote" a patch. Let us not overreact to
>> the AI tools.
>>
>> > Also, I would argue that it would be useful in the change log as if there's
>> > a bug in the generated code, you know who or *what* to blame. Especially if
>> > there is a pattern to be found.
>>
>> This touches on explainability of AI. Perhaps the metadata would be
>> interesting for XAI research... not sure that's enough to be lugging
>> those tags in git history.
>
>Agree. The "who to blame" is "Author:". They signed DCO they are
>responsible for debugging what went wrong in any stage of the
>development of a patch per usual. We have a long history of debugging
>tool problems without tracking tool versions in git history.

And it would be great to avoid the potential "it wasn't me, it was the
AI!" or "whoops I don't know how that exploitable issue ended up in my
patch, must have been the AI".

-- 
Thanks,
Sasha

