Return-Path: <linux-kernel+bounces-725242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3650AFFC60
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 10:32:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F16AA189D48B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 08:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6760628D850;
	Thu, 10 Jul 2025 08:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IdI27zCP"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E821228C86E
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 08:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752136141; cv=none; b=RGUXLXjaaC+m7H72TMKD3rnenuvW2yi0eFAVI8fNJsm8k7ndrkVhTgWk6C9pia7L96vMfSmqtCNPZSh7LiguQqV8+YStLRVpduOgzyggzxqvfNTCcWmV8m5ZvsUEMJsknc2glqI0ZzYKigQ3VHK6SxO7QBlIiBb91jKix9eME+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752136141; c=relaxed/simple;
	bh=5gs72OSD8X2xBF0PUccLQVo8CMzpQb4kbASHqWFDX7U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j544z02XECFoY8aglqrzU4KijSnMXMBCAknpDP7/xMfklirBdJVJTY+GCYwcwh0Lq4U+9ORGUrnYYV+8TjBuGt7pVhvhmvNxvE+99jB2JIc2xLq8fqQitayl6ovz0ST2PqBmwWw6e7OooMgrKAkaxhMY01P9mEsoWB9CjknvtWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IdI27zCP; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-60c4521ae2cso1219743a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 01:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752136138; x=1752740938; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=YZ7a5wxKov3XctJDNYsU1Y+3qqy9QlhBDvjublz0jdw=;
        b=IdI27zCP/oCZyoVt8CWdP7Nni8e8yX/HN9i2REggCjxPyO2xOqIEY/lmaLJ6EZrMbc
         jm0ofeBY99KfvNpsytaCjSyHx34W5XnEA8KEq5FBxpbfQJ42wACXdXJ1Drvj9OYjZ6Ol
         1ikq+R4xWqfja5QYDSMeexbvE4WTDkI6kD6QyFRGTfUV1vLrxE3ukLsAqAS0dBSmsMfi
         uSf7LY49PNdnYbl0hYkG7WXexAYYX4533MbqHZ0mEm9rnnLV1z1gHlJmUoeLrP4oBMRk
         +PxIe1AiE5DSD6wuFP499Q7VqUPoOEYY6wgVo6vnJI6GvpM6LuzIeFiVp7YyX2dMHlFS
         WbDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752136138; x=1752740938;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YZ7a5wxKov3XctJDNYsU1Y+3qqy9QlhBDvjublz0jdw=;
        b=Xo3JhM54EpLCTHv55O0TOP+FnRvDc2bhCS7yZ57dzJ8rU/VpMNuJ2K7SMuB4ZZBw2u
         J+9jpjJireEHbX4ZM+1z72qB0RuDmBlNFNeCNLBMIClNgLSVauakSMSUMWG+x94w9ltf
         t5ITNq9GedKtkbn2ZQfydHPe8+wJ29Ry5UC3a3WRv9mywlDTK/Fc9Z775sRs/e8g+acO
         GzhG3VENn1+erKcDsgp8sdtHKHLqs4hqGzTThh/+NM/Fb3XafUKd5raRmUwmu6rszB5v
         XMgHJ8sm7aBZGpEXBgqJYEPUC3ecCRcZYZzFK1exsf7nehjmPOkl0IqPdTsIfpRrPZSb
         HPig==
X-Gm-Message-State: AOJu0Yz+I7KcAiubMctMSG3XF3S8AKwl924csUCC+E/sOGI0wQ6FWX/E
	aibeWQTnzIjTZBE6uNuSnTyRLzjheTooUcNT0Yv5/AmEnhbbKvYpZlna
X-Gm-Gg: ASbGncsGEAQvYuOJWOLFKaEGazyBV/tvWLAgYXvCpOhDtE88TZajTGJTHnrK4YZBSkE
	gSmtyKyMb7v6OTv8xVtqAbbbIkzMh+0U9NOlEqylLXEk7CR45uvzPMtwKqeeRPV5uM7BdXGv5/F
	P7cc5PKpZMYTun23hDHVxjzAg4uJF1pygckSOpEeLqB65cdpd2Pufs6J6UGFwOph596eA2y+C8L
	kZE18JIwt8ut5s1WJ31/vfSnfzKAQlDkOfJrWKCD1qNHAAAYahMuIUeBXUGv/9tv85SXQ9NIc8d
	Ip/oFCENPAgVm3LO6sY1R/pI4qpocS6HNb5dWhXnkhfVPGnxErVLA6r+HVUBbKVBeoyEzVEeFte
	xTK2RP5nsJB8rJuiZGjpy
X-Google-Smtp-Source: AGHT+IHF010t9VV34/hZjJFBIxD6ohmpe910yVDqzmljymhVWQ3VcYBkGotu9f+dxKVp6Y9iTqS3WQ==
X-Received: by 2002:a05:6402:26cb:b0:607:6fd3:374f with SMTP id 4fb4d7f45d1cf-611c166cedbmr2345415a12.20.1752136137225;
        Thu, 10 Jul 2025 01:28:57 -0700 (PDT)
Received: from [147.251.42.106] (fosforos.fi.muni.cz. [147.251.42.106])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-611c9524806sm543200a12.22.2025.07.10.01.28.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Jul 2025 01:28:56 -0700 (PDT)
Message-ID: <1ee8338a-b19a-409a-bbe6-2068893b8abc@gmail.com>
Date: Thu, 10 Jul 2025 10:28:55 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] dm-verity: remove support for asynchronous hashes
To: Eric Biggers <ebiggers@kernel.org>, dm-devel@lists.linux.dev,
 Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>,
 Mikulas Patocka <mpatocka@redhat.com>
Cc: linux-kernel@vger.kernel.org, Gilad Ben-Yossef <gilad@benyossef.com>,
 Ard Biesheuvel <ardb@kernel.org>, "Jason A . Donenfeld" <Jason@zx2c4.com>,
 Sami Tolvanen <samitolvanen@google.com>
References: <20250709190902.49554-1-ebiggers@kernel.org>
Content-Language: en-US
From: Milan Broz <gmazyland@gmail.com>
Autocrypt: addr=gmazyland@gmail.com; keydata=
 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
In-Reply-To: <20250709190902.49554-1-ebiggers@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/9/25 9:09 PM, Eric Biggers wrote:
> The support for asynchronous hashes in dm-verity has outlived its
> usefulness.  It adds significant code complexity and opportunity for
> bugs.  I don't know of anyone using it in practice.  (The original
> submitter of the code possibly was, but that was 8 years ago.)  Data I
> recently collected for en/decryption shows that using off-CPU crypto
> "accelerators" is consistently much slower than the CPU
> (https://lore.kernel.org/r/20250704070322.20692-1-ebiggers@kernel.org/),
> even on CPUs that lack dedicated cryptographic instructions.  Similar
> results are likely to be seen for hashing.
> 
> I already removed support for asynchronous hashes from fsverity two
> years ago, and no one ever complained.
> 
> Moreover, neither dm-verity, fsverity, nor fscrypt has ever actually
> used the asynchronous crypto algorithms in a truly asynchronous manner.
> The lack of interest in such optimizations provides further evidence
> that it's only the CPU-based crypto that actually matters.
> 
> Historically, it's also been common for people to forget to enable the
> optimized SHA-256 code, which could contribute to an off-CPU crypto
> engine being perceived as more useful than it really is.  In 6.16 I
> fixed that: the optimized SHA-256 code is now enabled by default.
> 
> Therefore, let's drop the support for asynchronous hashes in dm-verity.
> 
> Tested with verity-compat-test.

Hi,

I shortly tested it with veritysetup too, also on 32bit.
And I like this patch (I wish we can remove the async thing from the dmcrypt too...)

Just one nitpick - could you please increase minor version of dm-verity target,
so we have information in debug log that it is a patched version?

Thanks,
Milan

> 
> Acked-by: Ard Biesheuvel <ardb@kernel.org>
> Signed-off-by: Eric Biggers <ebiggers@kernel.org>
> ---
> 
> Changed in v2:
>    - Removed the now-unused 'may_sleep' parameter from verity_hash()
>    - Fixed a typo in commit message
>    - Added comment in verity_setup_salt_and_hashstate()
>    - Keep SHASH_DESC_ON_STACK in existing place in
>      verity_setup_salt_and_hashstate(), to reduce the diff slightly
>    - Added Ard's Acked-by
> 
>   drivers/md/dm-verity-fec.c    |   4 +-
>   drivers/md/dm-verity-target.c | 183 ++++++----------------------------
>   drivers/md/dm-verity.h        |  22 ++--
>   3 files changed, 37 insertions(+), 172 deletions(-)

