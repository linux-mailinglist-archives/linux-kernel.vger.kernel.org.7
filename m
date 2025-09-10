Return-Path: <linux-kernel+bounces-811123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84659B524AF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 01:27:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 421A1467F14
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 23:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AB5F28C2A6;
	Wed, 10 Sep 2025 23:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B2wcCo+I"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6177F26F280
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 23:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757546873; cv=none; b=tFpf8TsTThrz7n9bFQvZ7NwCdFV69kBf2AiEqEC4a61hGe05687atDQ/7rJq0OrWfPwrWqzs/n+sqPKCdaNV7Mz7bDK8BtQqGiCtYMSVaHs5jbhwZU4jjjXvz8AxyME38QC3+qk3rr435X5BU8t1HqaoxinukqQ21IKC1v1VNpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757546873; c=relaxed/simple;
	bh=3edQ3wiuOkl5Ew2p1AsKKEjc24a+bOKfcgFFJgKaYyY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SNnzC3Gr9j79oWjyIyZPeidWC/VvvXiWYpD5nFYQ1xfPLU9zYvzCBy7fv9e8Uvn2E1hSlt+CT4N6RYBUKzwP8MGBJxVjGzIkIdRSNVRX9Z+dYPcbTRjC1X+hxUoafGKGb/ulwY1LakwSb+LYnqXyOiV3pwNeddRCkTxGj+68aJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B2wcCo+I; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-24af8cd99ddso1242075ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 16:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757546871; x=1758151671; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cBvz8G4X1Zkxg6w/J/7iMCCyjPI7vNKrmBzdJOfaZII=;
        b=B2wcCo+Ig5qbMOS/cw9vFoO3tNPXKdDlfivBubLZOkoMliZjXdNYvBo9eZ95M0Jcv8
         pboKT6a7jMacVJTVQBmGG9blA6psy+nTmw484RKh6qpc5pOaup9v/79lNm3uNpTPR/u/
         HByjBFhxW4McyXWM4adpkRfnrbgUU1irMG17N4XPA1vDjN1haxMPvRWKt6kEDnGin2RU
         eBJGJeXh4nrK7+HAT3wPYCWqwTvf1FiBoKeJdyHoCwxDgiuZ6Bnv08qtG14MUpmmbrgf
         hcvcYCW8jUsE1hTcTAgjY5kEtS+ArEi7bHJ9y9c4jH/euVaZ4isW8Ss4sMGbX7zubbh3
         e/Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757546871; x=1758151671;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cBvz8G4X1Zkxg6w/J/7iMCCyjPI7vNKrmBzdJOfaZII=;
        b=WGFGHfZY9BzuSPfkaHK6MhlHBjBRRrwjxK1krdspsRRg/GB/TOFU9gXcWqCxknDLzB
         B/X9utmVQs/KyBh+eKylYb+m99SQcOl/kMHpy3ER6jls0Oe6lKNHXc0hD2VxZMA7wzKl
         RROoSQyCtuLpVb4EH9fMYWeQpQcBXANztI+lwb5IJFQfLFt126Ja1LfB9CDZQyRQv1w5
         Uj8AM8uRnnBPEDuPw+naGteOO63ROFzdFWqeg2l67g1638uhsqlzsogVBqJ7EyIyCg+B
         F1fvjzrbOP1tX9D+m4/dCLCToaDVszMjj/bRbVk7FsgWTM4oiehlLyOpz8xgOiTda8W2
         FJRw==
X-Gm-Message-State: AOJu0YxkzvUenPC8McF1BdxKaloN1UswmIMJ1NnYyzih7URoRCTDuTZj
	JivMUZps9Vrs4x0uLFLySTTSR1q9KDYA8co+mG1k9+hjKPYd9qLyq/Ps
X-Gm-Gg: ASbGnctJYuGize/+XXoSdZlhq8XMldzJIFwD6WW+bxLRDgDW9aNqKR8wP8vVqPVGCiF
	VQk+MvBotFzAlROTQNC2tdjmkl5Z+etlwnQZeox8JXWxSUvw09O6aUPek4JSNXDo0iW3HmesEMw
	ORkJogROme2FK+OGyf/zSpZ5taS1x7Uxim+e3b/kTCbspQl/WyvVHzW5WP+JLXMAbFB2ZQqoQv+
	cwxYSbCAfPFlhoBFiUc0IktRRs0mJI9yWavWJMUTtDSrrqeJLkv2mUHrqdSdEbPg5hGU+mxGuma
	fceOtinIlEP43FKsP0KQ6nZ2V2UFqkHAJrh7LMaahw4mPpfaL8aqQI4Hs0fDnirNeaQsUeuLLSe
	kj2Gt/N2i6FYWhPClXth18QXMmvxpFr72ZAyqb9SvqjZ3WjNEmq1G3vDNJLpLF8TUqMyoqBcMHA
	HnJuMd3FHnrwgUeA==
X-Google-Smtp-Source: AGHT+IEw6OJxHhulxO5W0vyjKqEL9UiUEJnQ+QQ+8UVkxR4wstp6ma0MGrwjjjphA87JzXJdOl+Ovg==
X-Received: by 2002:a17:903:f83:b0:246:4077:455b with SMTP id d9443c01a7336-25171cbfb5cmr242343295ad.36.1757546865940;
        Wed, 10 Sep 2025 16:27:45 -0700 (PDT)
Received: from [10.0.2.15] (KD106167137155.ppp-bb.dion.ne.jp. [106.167.137.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25a2a924eeasm38717835ad.108.2025.09.10.16.27.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Sep 2025 16:27:45 -0700 (PDT)
Message-ID: <cd7cb4b5-561b-49cb-babb-393b608c98bb@gmail.com>
Date: Thu, 11 Sep 2025 08:27:43 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/13] docs: kdoc: a few more dump_typedef() tweaks
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, linux-doc@vger.kernel.org
References: <20250909204349.123680-1-corbet@lwn.net>
 <20250909204349.123680-14-corbet@lwn.net>
 <8ff91be7-7cb7-492b-b1be-2d03516c8386@gmail.com>
 <87segus9nb.fsf@trenco.lwn.net>
Content-Language: en-US
From: Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <87segus9nb.fsf@trenco.lwn.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On Wed, 10 Sep 2025 07:46:16 -0600, Jonathan Corbet wrote:
> Akira Yokosawa <akiyks@gmail.com> writes:
> 
>> Hi Jon,
>>
>> A quick report on minor regression. Please see below.
>>
>> On Tue,  9 Sep 2025 14:43:49 -0600, Jonathan Corbet wrote:
>>> Merge "typedef" into the typedef_type pattern rather than repeating it
>>> later, and add some comments.
>>
>> I'm seeing new warnings after applying 13/13:
>>
>> WARNING: kernel-doc './scripts/kernel-doc.py -rst -enable-lineno ./include/media/demux.h' processing failed with: NameError("name '_type' is not defined")

[...]

> 
> OK, that is embarrassing, not sure how that got through.  My apologies.
> 
> An add-on fix is appended if you have the patience to try it; I'll
> update the series before too long in any case.

Testing the one-liner ... , and yes it silenced the warnings.

I can't do any serious reviews on python code, but can do tests on your
"improvements".

All those noisy warnings current docs-next carries ...

Regards,
Akira

> 
> Thanks for testing!
> 
> jon
> 
> diff --git a/scripts/lib/kdoc/kdoc_parser.py b/scripts/lib/kdoc/kdoc_parser.py
> index 8215948dd548..2376f180b1fa 100644
> --- a/scripts/lib/kdoc/kdoc_parser.py
> +++ b/scripts/lib/kdoc/kdoc_parser.py
> @@ -1050,7 +1050,7 @@ class KernelDoc:
>                                f"expecting prototype for typedef {self.entry.identifier}. Prototype was for typedef {declaration_name} instead\n")
>                  return
>  
> -            self.create_parameter_list(ln, 'function',_type, args, ',', declaration_name)
> +            self.create_parameter_list(ln, 'function', args, ',', declaration_name)
>  
>              self.output_declaration('function', declaration_name,
>                                      typedef=True,


