Return-Path: <linux-kernel+bounces-874983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE0D9C17F15
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 02:42:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85E171AA8310
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 01:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 115382DF3F9;
	Wed, 29 Oct 2025 01:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="RRuC46km"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76371A5B9E
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 01:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761702168; cv=none; b=Moe5R+RnLGgtMEhRhS71S6ApmwuzIPXUvDjjxvSxKcyLYednFB+91Ejs2GMCssDk5HcTON++78EX1Rg3yecRGjz//SD7hMoJoRthg7io4j1C7Aq7vEjcwV3ck48zNpgjrVUQt+U4wfU1BZ2jtvtwe3M/XsYPri53ygUMn9YE2og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761702168; c=relaxed/simple;
	bh=EWYacNbOuERW4OojK9bgZfknBThRIQSN+JVixz2GaWY=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=ioKPTjXmGkbcwcS82DgNxdGOrLO3z/7HHOZNobBC6vnPRvdkxQ0sgXLWGzOQN6W8LcqiHGHbO7NiI3URFZmGxl+k1HG3nZY1u6OC43axOl2dYYDtB6j4sM4h8ShNvYMUQBsYXGzNgK/EUQNAB2ictdly5IZHhJTRa0JUiJZlP6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=citrix.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=RRuC46km; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=citrix.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-47112edf9f7so42947475e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 18:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1761702165; x=1762306965; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:subject:references:cc:to:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=EWYacNbOuERW4OojK9bgZfknBThRIQSN+JVixz2GaWY=;
        b=RRuC46kmadmr231SiX3ifYQdfxv4RdMqBBA0g//QPSvYK9cKpmHPzigDpQ+vVCHX5X
         lCPV9BbNgpukE3jgkd8OPLy0IFavu95TGOAi7c5/le6THMgIeZVyD54rh5Wa31/FZ+o6
         5MO4nxpR1jYLiWGPDTdk2h2JtagujFT7/lvhM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761702165; x=1762306965;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:subject:references:cc:to:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EWYacNbOuERW4OojK9bgZfknBThRIQSN+JVixz2GaWY=;
        b=RyJD95rTHN7+peucq5YTj4XQYQU0B4A2e37+vHFxrR81ogIjdEr91VtLoKlx9eGtJx
         2a0b34YgjShNydellecW4ukUjnrPI/MwHUAM3oqqUETkkAA1mODylxGj+42bioTJ65l4
         KKrJ1p21vji/ksDaVRvgznE+OOjZrCZ/jPDIxAeYdJytU3ox4M3qVYV/5EDqcN15Dv/w
         u3EhN1ldbpHMqYonQUQqHR7gvJAxkQVxYXPCHxHbUSQZBM+GR0akC+r1xvThuyI1nuiI
         4fE9OAESPU9LFSRJw/JlrZ3OewhnC1Hi8bfmQIFfqmef/QZC6HFD0alYpCqrj17MAORp
         7ZnA==
X-Forwarded-Encrypted: i=1; AJvYcCXciTR2164HF7N4Rx3+ZSUsklpmtgCPBbYaJ6m6eNcKFmBJHQ/OiEsbFL9A1l8zj7NT+riLTJqkDnTMnaM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQyKPQU3f5ksThrU+99R03e5zPpeorYjkOrSDOqEDzSdDTCKPW
	nUWOu3uioaE5mTzfMrf9ljXutjeUhVT+dGdOp9nRuaghy5zBtVxoiupbIaTt7T4FZf8=
X-Gm-Gg: ASbGncvtKnRphNmHDp5Mgm545YSvdhTko+Yuj6lgUdUc0JCzirGbd8FAgR+e1JBs0gD
	FpewCG2ytti7bb+GXUtCQksM+AwmXSPkQK3vVN3fJ+EWXBhCYozC/DCCm/Z19+CUKHTOZPERjjm
	1sipT+WfF/8f9blfn9mbnNOAy6F/gbq9QiI8inUs8NYAPXDDDdi/DIZVwwHA3UIixc+wEJHLVtP
	zUHaWNND9Dn0tuO5ocYxctnggOGc/B3eIOjC9CA72vZIIwFKMVaT4CMJgzpJmUAeBJ0TcJwHYWX
	9/Ur8Dw7aU/8ur1xgiWg1JE5+EbLiYaq4GFNrtccOX3m9btsCIFti1wi5WWJvLZSUj0+TRt5lux
	9Il2js5ecYRwcFabrwpkaQqwnJn2H2JGMy0YQuYlpnexuND42CkjUTm1MBsUoVQOQHyQl9Y3GUX
	SG3oVIkeTjx518YsKgrh+G3Fot64Z+TQb+kJAHsQZagg==
X-Google-Smtp-Source: AGHT+IGqI9jtOex3Utdbx/Z1nQq99SV5FMBT/ydoR0q3MNA+77+i7Qo+Sb3m9MO+Mv1x7c12EQbYmw==
X-Received: by 2002:a05:600c:3b1d:b0:475:dd9a:f786 with SMTP id 5b1f17b1804b1-4771e1f4075mr10435015e9.40.1761702164908;
        Tue, 28 Oct 2025 18:42:44 -0700 (PDT)
Received: from [192.168.1.32] (host-78-149-11-196.as13285.net. [78.149.11.196])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4771e196b27sm21805305e9.8.2025.10.28.18.42.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Oct 2025 18:42:43 -0700 (PDT)
Message-ID: <5bc35f89-1b77-4c0c-b6ea-fe9b2cb74870@citrix.com>
Date: Wed, 29 Oct 2025 01:42:42 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: torvalds@linux-foundation.org
Cc: alex@ghiti.fr, aou@eecs.berkeley.edu, axboe@kernel.dk, bp@alien8.de,
 brauner@kernel.org, catalin.marinas@arm.com, christophe.leroy@csgroup.eu,
 dave.hansen@intel.com, dave.hansen@linux.intel.com,
 david.laight.linux@gmail.com, edumazet@google.com, hpa@zytor.com,
 kuni1840@gmail.com, kuniyu@google.com, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com, mingo@redhat.com,
 mpe@ellerman.id.au, npiggin@gmail.com, palmer@dabbelt.com, pjw@kernel.org,
 tglx@linutronix.de, will@kernel.org, x86@kernel.org
References: <CAHk-=wiTN=1Sm5DVnXDtQ-tSiPuz-7QVpgP2vt6LgaEnhbubfw@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] epoll: Use __user_write_access_begin() and
 unsafe_put_user() in epoll_put_uevent().
Content-Language: en-GB
From: Andrew Cooper <andrew.cooper3@citrix.com>
Autocrypt: addr=andrew.cooper3@citrix.com; keydata=
 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
 6+ahAA==
In-Reply-To: <CAHk-=wiTN=1Sm5DVnXDtQ-tSiPuz-7QVpgP2vt6LgaEnhbubfw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

> Yeah, clac/stac are horrenously expensive on Zen 2. I think they are
> microcoded - and not the fast kind - so effectively serializing.

AIUI, Zen5 is the first uarch capable of renaming the AC flag.

This make STAC/CLAC "lfence-like" in practice on older CPUs, because of
an implementation constraint of not being able to execute speculatively.

~Andrew

