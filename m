Return-Path: <linux-kernel+bounces-895974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44DA4C4F65F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 19:16:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98ECD3BDFB4
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 18:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01D162D131D;
	Tue, 11 Nov 2025 18:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pp7R6GHM";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="EWT3Tfvm"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1878D28468D
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 18:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762884890; cv=none; b=qSxvXgu+MNstlvmgz925EfwsREWGWPzx8QPOOHwRlWnS5j/OOoUUTTQB0vdD/JmZSrIQ1IRR8vm6mGXkC5Uuf03GTZbFMsPBrXMl2cc2r+9Otev8eis/bwHhYToYA/zDiGjBBErbGwYmEzzOeNhyY9cdmGNZ6CNRTPsMGCR+dYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762884890; c=relaxed/simple;
	bh=fjzkIKleHETgnvP4mpcyCEH4StUorlz7426aNCCVdDQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gbCTq1NTMvoaNV/6xQq56zMceXrtA07kzeUSwLxwcom45O27vajoqQQ5uV77EiA47vviLF1RLP6mh5Vn7TBzbc2cBgJ3aFbkIOnLJSVJrKKd9SCRWs/FYWBbLL1zTUiwIbzknpEMhXIGb6aB/cMUHBrAtOqQaMJL3Zs7pxZtIl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Pp7R6GHM; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=EWT3Tfvm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762884887;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=XGonUkVU9GzwbNAYzZZD4KT8uaQRpiz1tcUeJPvRi8s=;
	b=Pp7R6GHMwQfHA9h0AoLXljMinQ63NXCcyvEqwfZszll7R6Q0m7wa7NJ56swMP5VdXQPuG3
	0JD1F7j3WpsTWD5CynCqwu3GMTjwaCCy9naI6PoNwfGBf2IgrsUvrCm3SuGkqURj6jO1lZ
	WU17jcEYOSCiR+nU5/2fR+rBqW/hVIo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-505-Vd5IGDG3NUGF6c6EYrkRNg-1; Tue, 11 Nov 2025 13:14:45 -0500
X-MC-Unique: Vd5IGDG3NUGF6c6EYrkRNg-1
X-Mimecast-MFC-AGG-ID: Vd5IGDG3NUGF6c6EYrkRNg_1762884884
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-42b2b642287so1814233f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 10:14:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762884884; x=1763489684; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=XGonUkVU9GzwbNAYzZZD4KT8uaQRpiz1tcUeJPvRi8s=;
        b=EWT3TfvmifWdrb0cXhmfstRZ3s7ciUuXq0o8UEZ2YXMvsiGI7dPHH5VljrK9+uGgPs
         cfN8Ev9zBlVqXs2Inpb3rutxTBWEYFaY718/PfrStaGJzWkIycl3LB/rwfbIcbb8Jn4e
         rzyfSz/C5LAyHs1kLm0vRA3M4bEZNfPpB9Hwio2A+Ywrtn6lhJ/nGVRQ+nF9q8UMLWBK
         ZCtfPCoPu2nTWfzr/EgYDi6fq1sjRjLrPzRj+sRJXikfnJylGJ8h5JxYS8ycZWxMF29/
         9YuJ00bmHZfgliLqDdXtz0VSna+NdNkjEV1YFlAFY8Eg5P0qs0vTGOsfnkafv7s5pdEg
         nqkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762884884; x=1763489684;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XGonUkVU9GzwbNAYzZZD4KT8uaQRpiz1tcUeJPvRi8s=;
        b=WpnGtoRuh64TB2ht4GbzwvL1dTK7dl8WqO8+n/pvLzigG1br1XsgK6GnN0kBKidw9v
         xVrNUzO14eUj496UvxKf1+bqjibUoKxpxqlWzn3w+mBk1c20X+sRLOuy24PsZUW2lVWY
         Dmv1L8thbjFx5e64I6eEXX5ExCDU1Z++Te50+DU7jPmhL1hWOqhx+Y3nUIXwR30kVVk7
         ew5P8kQWJFQOCdK+oneKsj1XVCVLwD7MM4pcO/hp1XAuYfJqltR+8NVmLvhWP2QIR/1h
         WP7BpYFX960a2lVRp7jn7WWP40b/YRSgvn40j1xl3gQz9PF9m8DMkUG1V5uKoXu3kJ04
         ZQdA==
X-Forwarded-Encrypted: i=1; AJvYcCWgyD4kE6KfA/7U/91Xto86vyGl+jkavSwnOf5U1ZIJWpjPZcZ6MeUgzGLu+TvrGsflgB7EzINLCOBXcWE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKUhEf8P/bVSRaRO7Lu0glsVrksIW+zyknbmq5sLDPGNKtlLf/
	EVXHCpjGuRhRrDkM863Oc3bdGm25qdEf3+2MEJv+MYzSnRlytedQafOlmN5AKFeY6aYV4dGFVfG
	93xkF1V2FXGonu3vUYan/xlxKI9tV3Cj3blZm6WJdyAPCjWxYIHQkZ3iM7XnNO019Mg==
X-Gm-Gg: ASbGncv9Lo3VU04idea55vpB5kR8uYUgyY+jk0tryowuemzcj9c+byUlCDSKeLd5fA1
	2WJ8Q5c9DfdnGvxt/gNdEVjNwITcjeFptoFfCGCFlX+CqtBtOfvNlDNUd0+xS4JtBxdc2RKhZA9
	eUmKtmc+wJHDkSg+28QNJR/jjM9/sjUyImBfAHtI5/0V5zivDCs7XPa/3dd4Jmtnfj6bKbKFT1h
	Cd1cnn25uE9BVtNRjB3v/iQmpNK2bdHGgcGG5RxHgPQymKAkfp0efeCmhkaCs4TicKcxQub+ciu
	DfYXvvY4hhO+1MgvolBBSisVGx4eB69MHA3TT3g8GnOJxCcbvNDTLp+swY32braqmDovrmYHmeC
	qWpYwNJ5yyi2YU359y7NhD/GruQeRhzz8uvuLv6UYezpwAhrZ/4PSX2IkJ5u4jC+TzskFQRO6ay
	FP7OcPyA==
X-Received: by 2002:a05:6000:310d:b0:42b:4061:23f3 with SMTP id ffacd0b85a97d-42b4bdb7e14mr100002f8f.44.1762884884320;
        Tue, 11 Nov 2025 10:14:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHX10mBGqJmcA+Ixtz//hWuBwgTdHZb2g4oj54Ltp41deVDOeK5dRTAjKH9fLw0RDHK37cF+Q==
X-Received: by 2002:a05:6000:310d:b0:42b:4061:23f3 with SMTP id ffacd0b85a97d-42b4bdb7e14mr99986f8f.44.1762884883887;
        Tue, 11 Nov 2025 10:14:43 -0800 (PST)
Received: from [192.168.10.81] ([176.206.111.214])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-42abe63b7d7sm30063513f8f.11.2025.11.11.10.14.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Nov 2025 10:14:43 -0800 (PST)
Message-ID: <5fe5239f-f042-4960-b180-9b9144ee02b8@redhat.com>
Date: Tue, 11 Nov 2025 19:14:41 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v1 00/20] KVM: x86: Support APX feature for guests
To: "Chang S. Bae" <chang.seok.bae@intel.com>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: seanjc@google.com, chao.gao@intel.com, zhao1.liu@intel.com
References: <20251110180131.28264-1-chang.seok.bae@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20251110180131.28264-1-chang.seok.bae@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/10/25 19:01, Chang S. Bae wrote:
> Hi all,
> 
> This series is intended to initiate the enablement of APX support in KVM.
> The goal is to start discussions and, ideally, reach consensus on key
> decisions for the enabling path.
> 
> == Introduction ==
> 
> Intel introduces Advanced Performance Extensions (APX), which add 16
> additional 64-bit general-purpose registers (EGPRs: R16–R31).
> 
> APX also introduces new instruction prefixes that extend register indices
> to 5 bits, providing additional encoding space. The feature specification
> [1] describes these extensions in detail.
> 
> The specification deliberately scopes out some areas. For example,
> Sections 3.1.4.4.2–7 note that initialization and reset behaviors follow
> existing XSTATE conventions.
> 
> That said, there are still some essential elements to consider at first.
> 
> == Ingredients to Consider ==
> 
> With guest exposure, the new registers will affect how KVM handles VM
> exits and manages guest state. So the extended register indices need to
> be properly interpreted.
> 
> There are three relevant contexts where KVM must handle the new 5-bit
> register index:
> 
>   * Instruction Information in VMCS
> 
>     VMX provides instruction information through a dedicated field in the
>     VMCS. However, the legacy format supports only 4-bit register indices,
>     so a new 64-bit field was introduced to support 5-bit indices for
>     EGPRs (see Table 3.11 in the spec).
> 
>   * Exit Qualification in VMCS
> 
>     This field also carries register index information. Fortunately, the
>     current layout is not fully packed, so it appears feasible to extend
>     index fields to 5 bits without structural conflict.
> 
>   * Instruction Emulator
> 
>     When exits are handled through instruction emulation, the emulator
>     must decode REX2-prefixed instructions, which carry the additional
>     bits encoding the extended indices and other new modifiers.
> 
> Once handlers can identify EGPR-related indices, the next question is how
> to access and maintain their state.
> 
>   * Extended GPR State Management
> 
>     Current KVM behavior for legacy GPRs can be summarized as follows:
>     (a) All legacy GPRs are saved on every VM exit and written back on
>         re-entry. Most access operations go through KVM register cache.
>     (b) The instruction emulator also maintains a temporary GPR cache
>         during emulation, backed by the same KVM-managed accessor
>         interface.
> 
>     For the new EGPRs, there are a few important differences:
>     (a) They are general-purpose registers, but their state is
>         XSAVE-managed, which makes them distinct from legacy GPRs.
>     (b) The kernel itself currently does not use them, so there is no
>         requirement to save EGPRs on every VM exit -- they can remain in
>         hardware registers.
> 
> The mechanism to read and write EGPR state will therefore be commonly
> needed by both VMX handlers and the instruction emulator.
> 
> == Approaches to Support ==
> 
> Given the above aspects, the first step is to build out a generalized GPR
> accessor framework. This constitutes the first part (PART1: PATCH1–3) of
> the series, laying the foundational infrastructure.
> 
>   * New EGPR Accessors (PATCH3)
> 
>     Since EGPRs are not yet clobbered by the host, they can be accessed
>     directly through hardware, using the existing helpers kvm_fpu_get()
>     and kvm_fpu_put().
> 
>     This model follows the same approach used for legacy FP state
>     handling.
> 
>     The design choice is based on the following considerations:
>     (a) Caching EGPR state on every VM exit would be unnecessary cost.
>     (b) If EGPRs are updated during VM exit handling or instruction
>         emulation, synchronizing them with the guest fpstate would require
>         new interfaces to interact with x86 core logic, adding complexity.
> 
>   * Common GPR Access Interface --Unifying Legacy and Extended Accessors
>     (PATCH2)
> 
>     Although legacy GPRs and EGPRs differ in how their state is accessed,
>     that distinction does not justify maintaining separate interfaces. A
>     unified accessor abstraction allows both legacy and extended registers
>     to be accessed uniformly, simplifying usage for both exit handlers and
>     the emulator.
> 
> Returning to the remaining key ingredients -- VMX handlers and the
> instruction emulator -- the necessary updates break down into the
> following.
> 
>   * Extended Instruction Information Extraction (PART2: PATCH4–8)
> 
>     Currently, instruction-related VMCS fields are stored as 32-bit raw
>     data and interpreted on site. Adding separate variable in this manner
>     would increase code complexity.
> 
>     Thus, refactoring this logic into a proper data structure with clear
>     semantics appears to be a sensible direction.
> 
>   * Instruction Emulator (PART3: PATCH9–16)
> 
>     As noted in Paolo’s earlier feedback [2], support for REX2-prefixed
>     instruction emulation is required.
> 
>     While REX2 largely mirrors legacy opcode behavior, a few exceptions
>     and new instructions introduce additional decoding and handling
>     requirements.
> 
> Conceptually, the changes are straightforward, though details are better
> handled directly in the patches.
> 
> Finally, actual feature exposure and XCR0 management form the last stage
> of enabling (PART4: PATCH17-20), relatively small but with a few key
> constraints:
> 
>   * XCR0 updates and CPUID feature exposure must occur together (PATCH18).
>   * The current enabling scope applies only to VMX (PATCH17-18).
> 
> == Patchset ==
> 
> As mentioned earlier, while the number of patches is relatively large,
> the series is organized into four logical parts for clarity and
> reviewability:
> 
>   * PART1, PATCH 01–03: GPR accessor refactoring (foundational)
>   * PART2, PATCH 04–08: VMX support for EGPR index handling
>   * PART3, PATCH 09–16: Instruction emulator support for REX2
>   * PART4, PATCH 17–20: APX exposure and minor selftest updates
> 
> Each patch includes an RFC note to provide context for reviewers.
> 
> This series is based on the next branch of the KVM x86 tree [3] and is
> available at:
> 
>    git://github.com/intel/apx.git apx-kvm_rfc-v1
> 
> == Testing ==
> 
> Testing so far has focused on unit and synthetic coverage of relevant
> code paths using KVM selftests, both on legacy and APX systems.
> 
> For decoder-related changes, additional testing was performed by invoking
> x86_decode_insn() from a pseudo driver with some test inputs to exercise
> REX2 and legacy decoding logic.
> 
> == References ==
> 
> [1] https://cdrdv2.intel.com/v1/dl/getContent/784266
> [2] https://lore.kernel.org/kvm/CABgObfaHp9bH783Kdwm_tMBHZk5zWCxD7R+RroB_Q_o5NWBVZg@mail.gmail.com/
> [3] https://github.com/kvm-x86/linux
> 
> 
> I would also give thanks to Chao and Zhao for helping me out in this
> KVM series.

There are a few bugs, but most of my remarks are really just stylistic. 
The next version, if you base it on the emulator AVX support, should be 
pretty close.

Paolo


