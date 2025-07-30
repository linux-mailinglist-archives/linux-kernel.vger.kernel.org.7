Return-Path: <linux-kernel+bounces-751190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB796B1663A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 20:29:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B77B93B6417
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 18:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE6E92E1723;
	Wed, 30 Jul 2025 18:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gYtAi/8s"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D0231DE4E7;
	Wed, 30 Jul 2025 18:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753900162; cv=none; b=D5wTK3silASK8ivRBTljAqfWRscgteyXE1NRz8uMFK9OGoyJTWnDNFV81ZCsoIMVxv7qK/S7hC3lx0ox0wn/2xW0S0sKcnjRQzG20yAkJJB2OcOt4XCtUajKax8aYbz4hiUDjD7p5HmZclmuJasAIZjQtC++/LKj5alJe5llGfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753900162; c=relaxed/simple;
	bh=VBXH58C+eg63hc0NJ0PJEvas9hinpXcnOplDom8r77g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mjtQ2LZgNkMtAmsMsdh5PVtQoGLzxMzTtztRTn3Ymen2Q5I2DdV1AippNe3wAeHpXy5YrWluicYZ2BRcRN2l7RuLifQsNSXCH2N3AesYDNlRFf4FKYeMgXRGvGvxWPqXTwAYN6d2uZkipFOb0aKRmSECl19QZZ+aUVClVceUa0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gYtAi/8s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63EF6C4CEE3;
	Wed, 30 Jul 2025 18:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753900161;
	bh=VBXH58C+eg63hc0NJ0PJEvas9hinpXcnOplDom8r77g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gYtAi/8sIE6PzS9dLRwxTZm2Cq8D+cIxHo1nPyfNX5+h6gZwvuJiPgM7bDHTfCQyo
	 7kPWtCN4iMzXS5b0TQ/WZLkgvi4J6h3KepmH+MUpIZZij8+pmRa7gwx6kv6//oAAXq
	 4oqeaiGnqPzJQURNU5yLK/qX3Bjx3sGN86OPFKR8+Re5PGwtvdFhRYlIbyD8MNaekB
	 NoIf2UaZ+WQWp2VNUHasq0XjDKqk6mwH8fCxWlQfEv4KqVbHagPNbo9c5DhafyYwr/
	 TxUgvzwV7Sd1ifWFKvk7xzg+ohyCQFvMI9XsJ8QO3rlTbkc8k0Grq0Q+3GOVSZBsV/
	 dvEUgMi8aj9hg==
Date: Wed, 30 Jul 2025 14:29:19 -0400
From: Sasha Levin <sashal@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Kees Cook <kees@kernel.org>, corbet@lwn.net, linux-doc@vger.kernel.org,
	workflows@vger.kernel.org, josh@joshtriplett.org,
	konstantin@linuxfoundation.org, linux-kernel@vger.kernel.org,
	rostedt@goodmis.org
Subject: Re: [PATCH 2/4] agents: add core development references
Message-ID: <aIpkfxjMJ9IGEo_K@lappy>
References: <20250727195802.2222764-1-sashal@kernel.org>
 <20250727195802.2222764-3-sashal@kernel.org>
 <202507271937.EC44B39@keescook>
 <aIcD9f_52tlLgE-e@lappy>
 <202507272203.BECE244@keescook>
 <aIcRzndNUdh-9R18@lappy>
 <202507272310.FCB96F5E93@keescook>
 <aIpHhR8AhPJZE2Rp@lappy>
 <20250730173528.GN222315@ZenIV>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250730173528.GN222315@ZenIV>

On Wed, Jul 30, 2025 at 06:35:28PM +0100, Al Viro wrote:
>On Wed, Jul 30, 2025 at 12:25:41PM -0400, Sasha Levin wrote:
>
>> Critical Requirements:
>>
>> * License: ALL code MUST be GPL-2.0 only (see COPYING)
>> * Signed-off-by: Agents MUST NOT add Signed-off-by tags
>>   (Only humans can legally certify code submission rights)
>> * Attribution: Agents MUST add Co-developed-by tag:
>>   Co-developed-by: $AGENT_NAME $AGENT_MODEL $AGENT_VERSION
>>   Examples:
>>   - Co-developed-by: Claude claude-3-opus-20240229
>>   - Co-developed-by: GitHub-Copilot GPT-4 v1.0.0
>
>  * for any patch there must be some entity capable of usefully
>    answering questions about that patch.  Legal certification
>    be damned, there must be somebody able to handle active
>    questioning.
>
>And no, it's not the same as with human submitters.  If entity
>A sends a patch to maintainer B, who passes it along and gets
>questions/feedback regarding that patch, B might have to resort
>to passing the questions to A, to confirm their understanding
>of the situation.  And from what I've seen, LLM tend to do
>very badly in such cases.
>
>IOW, defending any agent-originated patch falls entirely upon
>the human "co-developer".  IMO that is a critical requirement.

I agree. Elsewhere in the thread I suggested that a maintainer should be
able to require having tool generated patches come with a Reviewed-by
tag from a "trusted reviewer" (similar to the guidelines we have for
academic researches).

This way you could at least have a human you trust be part of the loop
until you trust the author of those tool generated patches.

-- 
Thanks,
Sasha

