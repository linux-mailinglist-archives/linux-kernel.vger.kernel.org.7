Return-Path: <linux-kernel+bounces-795138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 100C6B3ED49
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 19:20:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C46D33B1D78
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 17:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A523F10F2;
	Mon,  1 Sep 2025 17:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NfNy/ozD"
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB8E314B82;
	Mon,  1 Sep 2025 17:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756747192; cv=none; b=u5mQIj+cYNrtjbCQCIOnDiVxUQiPHe+h3Pf44uLNtxdgdVXHHm/cDmCgkb4heH67uDRFZ97lJNA8PySlgB9k5p19DH68LvB0N5PraYEkSMwu190YN5qdVJTeq4N3ts19w+BvrH2nVbOTu8o2Qa2SspJATki/ogRwktnwLeRs3KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756747192; c=relaxed/simple;
	bh=uttqUOM4t100YESwxVDANiQ5D5iHIkjc4YpoaCEcEOQ=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=cljFOqpHPRTgmk+4iDQb5q0eL4B1j6HscHUM9FPDQSee2ULCBzhfuMEIdmdKvr2ZudiAcR6cW8kTW0ldkjI8a296sCkg7pdT+fK02/1YMLgPbbQfikYO281gLK/QCtoBr15rdP6uhsAAnZT1xJE4EXjamU3uQF3PZhYcxGfQHUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NfNy/ozD; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e97021a3695so3412446276.3;
        Mon, 01 Sep 2025 10:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756747190; x=1757351990; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MCdLhHwAOZzd1sHfXyw7j9lNMlwcIlkxo40u1/PlOt8=;
        b=NfNy/ozD2LrjyWD/nr9UKpp4B7gY7QA8pb70xeJUm7syjcS1I2bo1B9QmuIo7fOXvQ
         JSzF/WJGdTlelsfJmeLMHfNJ0TH2V5VDWD44PUndblF/aE4HqLFVxdXpfkDA923rIf7c
         6Gvxeb9IO3Tsnp3I6gdpgx1RUBQFRfqnTznwJXnPZ78giFCcQL+w/qiUpxRY4lKZMPGD
         S5fQfZhs3/5g1yCO5gejRCnI/cOuzOxkqFslAoMUL4OIeHEsDqHXeJxWhgel4+nTsy1F
         htwzIxocIpJVxANKSmhZdHfGA58DjS8kByCQch6BxSP8UX7PnMt6VCx6UDiOP73fjCle
         ArWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756747190; x=1757351990;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MCdLhHwAOZzd1sHfXyw7j9lNMlwcIlkxo40u1/PlOt8=;
        b=Avk3Ala8VkywBgWiSWR42Bd5COr8fkJaZOuiowQtEikc8dxVnaTQnYAfxVrLUhw9ZB
         YlewbAidOG09Exz9gG8vwmaJJMe7cwHXuejTAGjtUG2GDYNAzzAzFxUyNDWC0VYY0iFx
         IfxaYUpF8jBE6krIQkF8sIpdpMvLRhMkIiP7jhf/PuW03SDUL9MBCB9rsEdT08YWk5rv
         ZvWQb+5u1r80ENbfyOwV7mtP4IQczwjTCEW8ZRhBRHoV39d37YBcJXqI2K9HZ6Jpq2YY
         vU7ewnApKxXJh1ie3GN4hzVDbhegSWkCtGGOeVHqWffnKBCGgwEJlGiPsFLkgQLkm+4A
         cjjA==
X-Forwarded-Encrypted: i=1; AJvYcCWLgtoQ0dv6xYO71H1hMnrlSFm6vNWdVmWSGreq590b1ZncbSzfDkPpOu5OLc2DBDRkl9PjBQbJ08aLuKa0D2U=@vger.kernel.org, AJvYcCWc68nIhXy5qKPlFSUTp/O6LUn9KZXxmUeBCwow22geAarIGsdxAfpdL/L9qK1n9PFjbGCZFTXMYMuz02Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy75bdKxMY8uUEghhhprFJM+eda7cNltgbytrq6MX5Gx6M0jIZx
	z0G3Ua/2f2F8l+xkoVEaZENWjM3L+Ym7CrDQ7nwpa4L9RCAvTAGo7VUW
X-Gm-Gg: ASbGncvmslEHbOgmW5Y+l5XRd09yZQa2kUyHNVnHLTmOsbTbv9VPF5JeCzDfK0MC28T
	+oiizJDrgWI+TBfdgXzHMsNO9BedaStzV5Gj2DFn5f18uxmT4I9s64j9oMMxbHGjReDb6eWgjm/
	Z4ogsTW/Q6sTl3oj0mo6s1BQwxpPR653E1pHz9knzNpecuD+TcjBqKgvYdmBCo6Z7EAbbTzqUCn
	W9uKg77Z3cGhQKSXduKPriddwaQ+VzeusYbA0HaGaOyLHl/z+V2KUjsZEMZom/B+VCDffKEcKbX
	iDigR5JJTVgahwpV9z+BnXlBUx8ROgkVb9Ad3LPpIkiPwtH7CGlPm8cR2XPCk7X4ugfH7Yy4nO+
	iekOUttXPE1lhj0kSKPm+HULB7H4sGLs92lfKfE+JyLD3OwuJrUlU
X-Google-Smtp-Source: AGHT+IEZ8EMPkHUraaN8N2Ftj2JKXXwZhHK6AIOPsA7PriSSOqQ557kpQqGWlv3cm91Il3PyctomLQ==
X-Received: by 2002:a05:6902:1204:b0:e96:dc00:300f with SMTP id 3f1490d57ef6-e98a581bf26mr7108819276.30.1756747189693;
        Mon, 01 Sep 2025 10:19:49 -0700 (PDT)
Received: from [192.168.1.209] (74.211.99.176.16clouds.com. [74.211.99.176])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e98ac466a13sm2171372276.14.2025.09.01.10.19.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Sep 2025 10:19:49 -0700 (PDT)
From: Asuna <spriteovo@gmail.com>
X-Google-Original-From: Asuna <SpriteOvO@gmail.com>
Message-ID: <b1734c45-42ec-46c7-9d4c-2677044aacab@gmail.com>
Date: Tue, 2 Sep 2025 01:19:42 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: RISC-V: Re-enable GCC+Rust builds
To: Conor Dooley <conor@kernel.org>
Cc: Jason Montleon <jmontleo@redhat.com>, Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
References: <68496eed-b5a4-4739-8d84-dcc428a08e20@gmail.com>
 <20250830-cheesy-prone-ee5fae406c22@spud>
 <20250901-lasso-kabob-de32b8fcede8@spud>
Content-Language: en-US
In-Reply-To: <20250901-lasso-kabob-de32b8fcede8@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

> For example, there's a check in the riscv Kconfig menu to see if 
> stack-protector-guard=tls can be used via a cc-option check. If that 
> check passes with gcc as the compiler that option will be passed to 
> the rust side of the build, where llvm might not support it.
If I understand correctly, the `-mstack-protector-guard` option is 
already always filtered out by `bindgen_skip_c_flags` in 
`rust/Makefile`, regardless of architecture. Therefore, we don't need to 
do anything more, right?

> Similarly, turning on an extension like Zacas via a cc-option check 
> could pass for gcc but not be usable when passed to the rust side, 
> causing errors.
That makes sense. I might need to check the version of libclang for each 
extension that passes the cc-option check for GCC to ensure it supports 
them.

> These sorts of things should be prevented via Kconfig, not show up as 
> confusing build errors.
I'm working on a patch, and intend to output an error message in 
`arch/riscv/Makefile` then exit 1 when detecting an incompatible 
gcc+libclang mix in use.

