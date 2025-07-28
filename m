Return-Path: <linux-kernel+bounces-747440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B1CAB133D9
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 07:00:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D218B1895AB0
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 05:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A83C2215F72;
	Mon, 28 Jul 2025 05:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PLyYl+t6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097F429405;
	Mon, 28 Jul 2025 05:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753678840; cv=none; b=jYvsRLGScqY3GNaVH+Mn/1N5WRuN9Zmq11S+ZJj/vUsTzDO62GzwRXCQZ+98c1Xxqzzz1LYhhYJO8RYqAEJL8FTIRMg0Ld7bXWm11Bws+oq04qho1NhfZGVdZP1z8FKSqAw6bVD/d71bHtPZMxAVl/Uw48ktMkoKkNcyvg7aTTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753678840; c=relaxed/simple;
	bh=LzL5Ag5PNrHKY/Mp40yf7knkdNLYeopazYhALz7eskI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pcuPjNe5K0iuS2bPaXKn0xvVR+k/DmcysTXPmVDeUS44nbSgHf875VhN40jf6MEg/6DLlwfKxBw5OfeXhlV7e9Mth4di0Z2tZ8T182lJ4+CzqT4tbAAmKpQ/7chCnCH+EMdHmNP4SkvtgInEfYR6AyeoKaQiSxJ+YHOV7WDeb1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PLyYl+t6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 251BDC4CEE7;
	Mon, 28 Jul 2025 05:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753678839;
	bh=LzL5Ag5PNrHKY/Mp40yf7knkdNLYeopazYhALz7eskI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PLyYl+t6jVNUnrCGmNqFdKbe5Eb1T3djSsixkZOuQ/ooUcIFhZ+qdBfTz4ncRZXOK
	 UzbOS4J+4eXHkdYANWohSlZWFO3zGt7KHhCf3x7kQQ1ipV1Unzwts4GGSwEc3I+Ld3
	 qhP0bcCpkFenejylErCTBgNOOjDsKQ1CODcssEdAsUCinFj2O5SesoRQHaPkWccN+M
	 cmwvCRGx9zMP5/9cDOWMrad9XCbG4w9cgocIJ+eUCwAPDvbcSN1VGiDhkDFEmwWSDi
	 PSmN7i1pHJVpuZKBl+EsPxanEbruxGe/0CgXvdcgEwQ28arGDOrCpIbClpkWB1bZ7w
	 Q9+eEEeMrRHDA==
Date: Mon, 28 Jul 2025 01:00:37 -0400
From: Sasha Levin <sashal@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: corbet@lwn.net, linux-doc@vger.kernel.org, workflows@vger.kernel.org,
	josh@joshtriplett.org, konstantin@linuxfoundation.org,
	linux-kernel@vger.kernel.org, rostedt@goodmis.org
Subject: Re: [PATCH 2/4] agents: add core development references
Message-ID: <aIcD9f_52tlLgE-e@lappy>
References: <20250727195802.2222764-1-sashal@kernel.org>
 <20250727195802.2222764-3-sashal@kernel.org>
 <202507271937.EC44B39@keescook>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <202507271937.EC44B39@keescook>

On Sun, Jul 27, 2025 at 07:39:06PM -0700, Kees Cook wrote:
>On Sun, Jul 27, 2025 at 03:58:00PM -0400, Sasha Levin wrote:
>> Signed-off-by: Sasha Levin <sashal@kernel.org>
>> ---
>>  Documentation/agents/core.rst  | 28 ++++++++++++++++++++++++++++
>>  Documentation/agents/index.rst |  3 ++-
>>  Documentation/agents/main.rst  |  5 +++++
>>  3 files changed, 35 insertions(+), 1 deletion(-)
>>  create mode 100644 Documentation/agents/core.rst
>>
>> diff --git a/Documentation/agents/core.rst b/Documentation/agents/core.rst
>> new file mode 100644
>> index 000000000000..da171dde1f9d
>> --- /dev/null
>> +++ b/Documentation/agents/core.rst
>> @@ -0,0 +1,28 @@
>> +.. SPDX-License-Identifier: GPL-2.0
>> +
>> +========================================
>> +Core Linux Kernel Development References
>> +========================================
>> +
>> +Essential documentation for Linux kernel development:
>> +
>> +How to do Linux kernel development
>> +----------------------------------
>> +
>> +The comprehensive guide for becoming a Linux kernel developer and learning to work with the kernel development community.
>> +
>> +See :ref:`Documentation/process/howto.rst <process_howto>`
>> +
>> +Submitting patches
>> +------------------
>> +
>> +The essential guide to getting your code into the kernel, covering everything from patch formatting to the submission process.
>> +
>> +See :ref:`Documentation/process/submitting-patches.rst <submittingpatches>`
>> +
>> +Submission checklist
>> +--------------------
>> +
>> +A checklist of items to review before submitting code to ensure patches are accepted more quickly.
>> +
>> +See :ref:`Documentation/process/submit-checklist.rst <submitchecklist>`
>
>If an Agent needs the above list, then so does a human. Everything above
>should already be discoverable by the Agent. If it's not, then we need a
>better summary document _for humans_ that reads like the above.

Why would an agent read those docs unless we tell it to?

Similarily, why would a human read those docs unless we tell it to? :)

It's all there, it's all discoverable, but unless the agent magically
knows it needs to know something from there then it won't be looking for
it to begin with.

Just like with humans, the better context and background you give them
the better of a result you'll get out of it.

-- 
Thanks,
Sasha

