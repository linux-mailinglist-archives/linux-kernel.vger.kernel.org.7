Return-Path: <linux-kernel+bounces-835962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB6B7BA8748
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 10:51:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2011718976F8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 08:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D72A27C872;
	Mon, 29 Sep 2025 08:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oLazq0Cr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC2C27C150
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 08:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759135860; cv=none; b=CILEyM1Jhyk84oC0xkyDqzPAhG5Y3iAWkuU7sr7BXOIH3tDFBxwIVVDu8W9t9JbP2cu2b5rq3S3xBT3JkFPo05otae/nDDeGhhyS2OFypItip3SS5OwhyGWNAHdEpw+UsedSd4c5ppireku20Lg38L2dW+094ATNnVyeAXsljSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759135860; c=relaxed/simple;
	bh=z656pk0U9J4SIr5lgnOUcjftm27BactAF0AdrrMlLPM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LuoVU8oSuOpc97910EZ9Jex9Pio1/2Q9rLRIYbhXGYs/YpNJCcztzxeExLCQdx5cTMs5+8OT0c7BeXEkW25T5jDpepyt8uCX9FmCmoeQggYxFp1LRdO5ebzFSu2eMErQ+3HWbZXh2naFX4FXAzeNjlEs2kVHm8R9gZViPwpSBzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oLazq0Cr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B49C0C4CEF4;
	Mon, 29 Sep 2025 08:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759135860;
	bh=z656pk0U9J4SIr5lgnOUcjftm27BactAF0AdrrMlLPM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=oLazq0CrZPaNo8R+9N68YBC/LJregQYpA8jbbvkmkx3m4fLltRQ9/UxAgVVK7V7NW
	 Ac1x55bD3Qtv05L73sE4ARBelNtQkpkFjttpY63v5REuiQeAs2FqGvsr1qKDRw1Y4g
	 E5ktwOthDYFfqF1FSduwstnV5lAFmHd8o31A1XoJURxBu4L5U2jnZ4rBwacWKFjMtv
	 7Wp7vYX0kbXdJveArpHUFZVbi+e1QS2BQ14ZvAIa23l+CttOXwAnvy+9dL8bhrbBhG
	 hHPjnqnjaKdzpk5sJlnQ04MmqsmZDt8HP/q+oLkMzG9ZHIC05yoWtVBUtFqdmoWkBG
	 bQIXBkP0CXfXQ==
Message-ID: <15ca65ee-6a2c-419d-8ef3-bca2c44bc42c@kernel.org>
Date: Mon, 29 Sep 2025 17:50:47 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] locking/local_lock: s/l/__l/ and s/tl/__tl/ to reduce
 risk of shadowing
To: Vlastimil Babka <vbabka@suse.cz>, Shakeel Butt <shakeel.butt@linux.dev>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Alexei Starovoitov <ast@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>,
 Boqun Feng <boqun.feng@gmail.com>
Cc: linux-kernel@vger.kernel.org
References: <20250925-local_lock_internal_fix_shadow-v2-1-d3b85ee775a4@kernel.org>
 <6c49739d-6f2a-4c49-a04b-9774f10a6925@suse.cz>
Content-Language: en-US
From: Vincent Mailhol <mailhol@kernel.org>
Autocrypt: addr=mailhol@kernel.org; keydata=
 xjMEZluomRYJKwYBBAHaRw8BAQdAf+/PnQvy9LCWNSJLbhc+AOUsR2cNVonvxhDk/KcW7FvN
 JFZpbmNlbnQgTWFpbGhvbCA8bWFpbGhvbEBrZXJuZWwub3JnPsKZBBMWCgBBFiEE7Y9wBXTm
 fyDldOjiq1/riG27mcIFAmdfB/kCGwMFCQp/CJcFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcC
 F4AACgkQq1/riG27mcKBHgEAygbvORJOfMHGlq5lQhZkDnaUXbpZhxirxkAHwTypHr4A/joI
 2wLjgTCm5I2Z3zB8hqJu+OeFPXZFWGTuk0e2wT4JzjgEZx4y8xIKKwYBBAGXVQEFAQEHQJrb
 YZzu0JG5w8gxE6EtQe6LmxKMqP6EyR33sA+BR9pLAwEIB8J+BBgWCgAmFiEE7Y9wBXTmfyDl
 dOjiq1/riG27mcIFAmceMvMCGwwFCQPCZwAACgkQq1/riG27mcJU7QEA+LmpFhfQ1aij/L8V
 zsZwr/S44HCzcz5+jkxnVVQ5LZ4BANOCpYEY+CYrld5XZvM8h2EntNnzxHHuhjfDOQ3MAkEK
In-Reply-To: <6c49739d-6f2a-4c49-a04b-9774f10a6925@suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/26/25 11:16 PM, Vlastimil Babka wrote:
> +CC LOCKING PRIMITIVES maintainers. Looks like local_lock files were never
> added to the section, should we?

Shall I resend with the correct list of persons in CC? Or is it OK as-is?


Yours sincerely,
Vincent Mailhol


