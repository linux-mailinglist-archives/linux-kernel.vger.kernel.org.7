Return-Path: <linux-kernel+bounces-776475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D5EC3B2CDB9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 22:21:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA2A4520063
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 20:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3380E3112AF;
	Tue, 19 Aug 2025 20:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="YnL3c4Lw"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C30102848B7
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 20:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755634900; cv=none; b=pPlepKJSXHGp92/wecqNmi+XzZD2trHfXUXb0L9+EenFrc1vubjJqhsEHq0mw9MTaOeIfkabcrAm8y2MjMW1DqOtuL1+NYceS4VLG+Ve2OI8Prswmel6MBMgJd6VgQiIERFi3s1Q9lkyXp4hHQcZfZJWV6JaGwsifbSxkM6nDyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755634900; c=relaxed/simple;
	bh=t6V2ad1OwdulENyOC9PYXyXtBqYf+EzAG72UncH2CTU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EMkBSOReEORpWOCOQbaYQj1qAx+PdrywOIQgnmFh9uXvgKdMR9NGP571AvusgdGw3RmQGarVnGOhGbpynmLTEUPYwfoIoR0gI2VCrXqyA5p/zm2pRmV4NT0uyKIv4BXUHx0WSlzThOviMHyfd6yhH7meU87/KKfuKyTLvOHfim0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=YnL3c4Lw; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3b9e418ba08so3158181f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 13:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1755634894; x=1756239694; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=t6V2ad1OwdulENyOC9PYXyXtBqYf+EzAG72UncH2CTU=;
        b=YnL3c4LwxyCz5z/9LB9Dr7cunitlmtUdPatOSfbzaK1xBojisVPGBK0PR125eWfa9X
         TLlBKMkor2h+z1GTVGk4POE2R/4RbnjfHv5H+G21b0znubY3u/QtCaBMwbLjGlxy865B
         loJ2d44acGOqwjyGyGhHcA/Xmn2Lelz1brAlc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755634894; x=1756239694;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t6V2ad1OwdulENyOC9PYXyXtBqYf+EzAG72UncH2CTU=;
        b=TXVy2w156MxXATBSXI4et582ng65oQr01aD9MPthblUHhVQFv+ja3EVTbW1HR+EJF5
         0KN9OdWbOcXRNgOg/Pp3oZ5bUSmiyHBiEYjrPhLSuj6XRYOL/14FKkYQ0fbbVaC9L8qV
         jqLtpN2fMrF3BRLdpfdhm145rM+WlDz4cCfILAItNWjIDlV45GmSP5hLMBrqXi8hvGpA
         Et4uW0Jj30xn+K5ba0tdpeMgs9PmHSmpEXD3q8juuQrJxkvzZpqlfUX/q+Xkgki81c8t
         JAYBwAK5j1Eqg9lq5/+laWRHAuDLwXH8RRiTwphreyG9UoVHBx3xjjb7T4R5dAxOyuAb
         5e/A==
X-Forwarded-Encrypted: i=1; AJvYcCVlbW1dov9tuKDcWV/HIRmPYLQ9pgaHrcyEYzhqM1n/Y3L+SYvk5fspP2KUyZH3gZTdPbP2JsO9jzbe5n8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaJw2Xr2z5kS0cBLe0A2kWnwQpQJTQkEpFlLQS9ZUF8VEuFf0k
	02yi8XCsBLjnPHSrfThxtO8zkj+dHwKekRQHQEKoeBYri73fxrxhQ9k0ZLaJH+PCPPs=
X-Gm-Gg: ASbGncu19cmtcWMJ9sXjiTpC+mlXkEDMeFFzD0JAgTJMbQr/CSyRqx3vzp+I+Yfau3q
	ZEpbVv0I4Sj3/0Etk4n8twqWEuXcugtPEXN7KggLH35KK3gc2jahG/OdVjL5Vnm0OKi/Gc43Gm9
	uZLYAJThcnsVrILRVoESvgEnaPRHWm1KnwYdFLxQRlnxGbssGha+zJOdgmkoZhG6WyMus8YP6EZ
	hY6wOLqFUogyjKFJ9aaJLYDvHOjoG2Hx3MfG+E161+KHHug8SqD4RKeROsHA8BH8BtNBu5JUij9
	1vYzcA/Vo5p7TQ1TzDFMupb1TdMS3AXQXxw1F4v27b4XPNaKL0BCYJ6j5uig4mYdfFkWoDLxSWt
	LO5YuAZjL2s26lB+0kFW0NkdwPBBhARiPjQ4SS0bjlk1VDQcxUUhP3H275bBXfZ0BBAlA
X-Google-Smtp-Source: AGHT+IF2FtVTrCPiEaIKkK14KA0vjqZ4roQRU0CBjEoNAnKzPXmUbCZeC5iP86PcIZTHWiLThpQtHQ==
X-Received: by 2002:a05:6000:1a8c:b0:3b9:148b:e78 with SMTP id ffacd0b85a97d-3c32e413fd0mr225384f8f.53.1755634893962;
        Tue, 19 Aug 2025 13:21:33 -0700 (PDT)
Received: from [192.168.1.183] (host-195-149-20-212.as13285.net. [195.149.20.212])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c0777892f8sm4816194f8f.53.2025.08.19.13.21.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Aug 2025 13:21:33 -0700 (PDT)
Message-ID: <71430bdc-6ea5-43cc-a231-e72aeec43866@citrix.com>
Date: Tue, 19 Aug 2025 21:21:32 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] x86/microcode/intel: Refresh the revisions that
 determine old_microcode
To: Dave Hansen <dave.hansen@intel.com>,
 Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: Sohil Mehta <sohil.mehta@intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>,
 Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
 Nikolay Borisov <nik.borisov@suse.com>,
 Alex Murray <alex.murray@canonical.com>, linux-kernel@vger.kernel.org,
 stable@kernel.org
References: <20250818190137.3525414-1-sohil.mehta@intel.com>
 <20250818190137.3525414-2-sohil.mehta@intel.com>
 <20250819051940.sqdjdvwupvocuf7w@desk>
 <0bfc7329-e13b-4781-a331-9f8898110b5f@citrix.com>
 <20250819182840.ajjl5txvooe47un7@desk>
 <f47826f2-9cb2-421e-91b8-fd5a435dd531@intel.com>
Content-Language: en-GB
From: Andrew Cooper <andrew.cooper3@citrix.com>
Autocrypt: addr=andrew.cooper3@citrix.com; keydata=
 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
 6+ahAA==
In-Reply-To: <f47826f2-9cb2-421e-91b8-fd5a435dd531@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 19/08/2025 8:07 pm, Dave Hansen wrote:
> On 8/19/25 11:28, Pawan Gupta wrote:
>>> Alas, these deletions are documented as well as everything else is in
>>> the changelog...
>> Should this file reflect those deletions as well? As an example, if an
>> ancient part gets removed from the microcode repo, it may still be worth
>> for Linux to keep the record of its last microcode version.
> <sigh>
>
> There's even a "Removed Platforms" section in the microcode repo
> changelogs that gets copied and pasted for each release. But it's not
> consistently updated as platforms are removed.
>
> But, thanks to the magic of git, we can just look for the removed files:
>
> 06-55-06

CLX B0 stepping, notably gaining MSR_TSX_FORCE_ABORT rather than
MSR_TSX_CTRL.  It was a giant muddle for mitigations.

> 06-cf-01

EMR.  Stepping 2 still available.

> 06-8f-04
> 06-8f-05
> 06-8f-06

SPR.  Steppings 7 and 8 still available.

These are weird.  06-8f-08 has two blobs in it with disjoint platform
flags (this is fine).

However, all 3 blobs between -07 and -08 all have sigtables covering
everything back to stepping 4.

Arguably that's a bug for the intel form of the microcode (which is
indexed on stepping), but it's just some extraneous metadata.  The rest
of it is suggesting that SPR steppings 4-8 had compatible-enough
microcode for them all to be patched by the same blob.

> 06-ba-08

RPL. The repo has steppings 2 and 3, so I wonder what RPL stepping 8 is.

> 06-86-04
> 06-86-05

SNR.  All steppings dropped, although it's apparently a mobile
basestation only, so I guess it's not running Linux.

~Andrew

