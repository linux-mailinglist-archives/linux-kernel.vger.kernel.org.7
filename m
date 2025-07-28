Return-Path: <linux-kernel+bounces-748016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AAAB0B13B67
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 15:23:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7FC7189BAC8
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 13:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE6F6265CC0;
	Mon, 28 Jul 2025 13:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HP1gqMlM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D0D7261C;
	Mon, 28 Jul 2025 13:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753709002; cv=none; b=f2tI+zxKMSU+kk1PX9U8HpdcB4jHJbdTsJUPPopszFQQjXB8nkCcZis8qsUCb1pn4D3QYT4ZyFoJPT7RPCXT+e3fis59fVWaf8viPmHikwKwEObY7K5B5evXyQTVe3ush+Vdhorl6MDf2O7UTmgEYkJvTuKB9DKUjWYgSexvwW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753709002; c=relaxed/simple;
	bh=kxT5qQEdoccDCbNV4vcp4AYNP+/tytHZPwIBmcnm6kI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HJPSdL/WjmAg0fv6fDjJt4smBbS/Ahu1plskH/IG3nGFSnl2W5sLy+790Dpp6IdQrXjBGkdOTpvUAyrGmiw0KCYvs0mQFqMi4mWfjHvf+yhnHDunA6yUfgGq2bEpIYKYgOQymgmFzlvPY/saP/nXj2nMVVEodRjNK+mXWlr9Exc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HP1gqMlM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 679B5C4CEE7;
	Mon, 28 Jul 2025 13:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753709001;
	bh=kxT5qQEdoccDCbNV4vcp4AYNP+/tytHZPwIBmcnm6kI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HP1gqMlMNJx4VhqhivuQzgTFFtoNNtf15aiy+54/WmZqrayp1i5O2RicDDQgAD5Bi
	 UJYQXYYI8J58+/1upE1sKVxPDALievJ0CzY6LKX1zUKu3Lpo7oov1z+7V1rIEkhmLR
	 NQ8n1CmoAIROdMQYmHkaXSpMdRJg0phC1BdMbpRfO2nW+kQNlbqx7bH/wRXpQUaLNs
	 OfhfVy0vXAbwJ+TBhXIu9qFZTR1aRSF7Cw3/FYdiQfwTCQX3rE0eBcFCLLHDFdhkxS
	 5c/PgNKv+DkxLbnRwQ34/sX4ndWwhqGOkK5oyi+ZCdvfkIuZituUCQ+6w1NU4xZmfd
	 2bFBs01wTsWXQ==
Date: Mon, 28 Jul 2025 09:23:19 -0400
From: Sasha Levin <sashal@kernel.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Greg KH <greg@kroah.com>, corbet@lwn.net, linux-doc@vger.kernel.org,
	workflows@vger.kernel.org, josh@joshtriplett.org, kees@kernel.org,
	konstantin@linuxfoundation.org, linux-kernel@vger.kernel.org,
	rostedt@goodmis.org, Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 0/4] Add agent coding assistant configuration to Linux
 kernel
Message-ID: <aId5x_ocOiWICyZa@lappy>
References: <20250727195802.2222764-1-sashal@kernel.org>
 <7e7f485e-93ad-4bc4-9323-f154ce477c39@lucifer.local>
 <2025072854-earthen-velcro-8b32@gregkh>
 <df188552-c2dd-4cb7-9f6a-74e05e677dfc@lucifer.local>
 <aIdw3-G04QQPvJtU@lappy>
 <c4974be6-6076-4833-bada-3012d3660a8c@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <c4974be6-6076-4833-bada-3012d3660a8c@lucifer.local>

On Mon, Jul 28, 2025 at 02:13:01PM +0100, Lorenzo Stoakes wrote:
>On Mon, Jul 28, 2025 at 08:45:19AM -0400, Sasha Levin wrote:
>> > So at all times I think ensuring the human element is aware that they need
>> > to do some kind of checking/filtering is key.
>> >
>> > But that can be handled by a carefully worded policy document.
>>
>> Right. The prupose of this series is not to create a new LLM policy but
>> rather try and enforce our existing set of policies on LLMs.
>
>I get that, but as you can see from my original reply, my concern is more
>as to the non-technical consequences of this series.
>
>I retain my view that we need an explicit AI policy doc first, and ideally
>this would be tempered by input at the maintainer's summit before any of
>this proceeds.
>
>I think adding anything like this before that would have unfortunate
>unintended consequences.
>
>And as a maintainer who does a fair bit of review, I'm likely to be on the
>front lines to that :)

Oh, appologies, I'm not trying to push for this to be included urgently:
if there's interest in waiting with this until after maintainer's
summit/LPC I don't have any objection with that.

My point was more that I want to get this series in a "happy" state so
we have it available whenever we come up with a policy.

I'm thinking that no matter what we land on at the end, we'll need
something like this patch series to try and enforce that on the LLM side
of things.

-- 
Thanks,
Sasha

