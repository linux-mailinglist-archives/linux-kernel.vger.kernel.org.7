Return-Path: <linux-kernel+bounces-889600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6117EC3E038
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 01:49:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BF8C3A64C0
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 00:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C591246BD8;
	Fri,  7 Nov 2025 00:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="VxLJoM6M"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A4752B9A8
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 00:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762476535; cv=none; b=Jq3Us05AWmakavGyLn4egU4AZSnaSBoFDoB4TW6E82TnypPKbPx662gLNizYsMc7+pEXtOe2ZTCuHNkWTqGdfqocjoBBYExdf5/ZM3bHY9FrD+UCnqPPzg01v68TNHWTtiIrhdUawAG+Y93WoD5L9sDG+UAJ4/+2cJBjF1mg0dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762476535; c=relaxed/simple;
	bh=sn6j/WP+bd+jqgBuRpz17xz8i5sjTIQyCJWXHeB0/S4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ol4qfuP5na/TEkUoXJ9GeGtu+vkuBstX1WN2WVtCmJgQJmKKp/i+ryo20U4bhU8dBLmTzTQSsf0mY6lBkevwQkNQMrCly5gXYgsRTP23xpFjippDU3GBWbcxWBvizChC+vBHlmAZLGmO79mNDAC99ikmZsHJhV6bUrp0R87mMMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=VxLJoM6M; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6399328ff1fso373951a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 16:48:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1762476531; x=1763081331; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UJyXy2HPeNxeSWk8AJrSzQ9IAraFkis5RK31sTtcUcA=;
        b=VxLJoM6MH0mJHKj2SDqXcyCi2dB/t32iAYipnB565BpGVVHzHhgrZF7O3FqIFXrvYW
         QiwT/v9Xv3hrvHb9e0rNNRrD4EV+mbMZ4BjeMM3JShi+3TQsfB4oHODtp29IMypgm1qU
         f3Dl4SUgGfAdhKQHz+SrB5pDarAh/AwnzTEG0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762476531; x=1763081331;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UJyXy2HPeNxeSWk8AJrSzQ9IAraFkis5RK31sTtcUcA=;
        b=MUMy7nPhpYDS+/q+oKbcr86VAVv4OhgLJctHBfFjHuBPFkfZl9rZFORvZ42Bd+LjXj
         7SpD6B588IK3PrroPkepW0JO3BAZvQa9kVQc5aBmw0HeRelhDDAEvkQY85z6q5iBQ2Nq
         812uz3K/9sEJWjkHMGDunUYq+BRXugFiKxdxQqEB8XAV94oteg9lQGiMNk8KXYeI4jJQ
         PW7HRoHNUY/H+PE+o2XAdHg2EKfBVeHu1VDdK7ETGEPSVSPev9f6tP+VoHsRUztGBmnl
         pSNoysBnVjiFSFIMI0phZQu224gmN8pVwbAL0Yf9dayyvmnW8rPIhXnb7ixXl5dUkI+Z
         MShA==
X-Forwarded-Encrypted: i=1; AJvYcCWfUjh47/XEIliMNopzF+afIAuC2XR21jlJ5TOGF+HbgZINadL/9pB4BLE0S+NsSQPQ4wnmGc8gO3ryEc0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5Upj5giJ3/qQx5AYGCWbjhmD7bCg1KXfzt4p8lj8/tYANqyk2
	P4LRVOtklWXtC4ujd6Awt2xkc1qx1mPo4Yk5L7y7ljO4OVpY2OeYO6pxptGmye2QvN2aUkdwkWC
	LCRQiIwY=
X-Gm-Gg: ASbGncs+JesmRQMIMdcggL3qCK4bhOSBk8T/OigEuPDPoO50RIf/CSjcTBGV/mYzJcd
	UeNkUMIPhbpITQez4J9z8pbF/pGbIvotSfMOU0xgeS96O2bGRtxVceG/YuaauEcprxFlAIXemxq
	wyPH6bUbv+Ue1TTp9B+pcsu6Be/wn0dpYHXQbmL2AOmX5qbzTTncj49UlRDWawVWwyGEc1KiJ4G
	HmONhSZ+CvZB4NILJVcsGS+vWvevAgH9ibQbS9zdR6lo2R2PRNa8qagxCLHwz1jLXF6Li6HvwNl
	fsQluF9+Bs8hxvd4HhxJGw+sPEaiakmEgQZmmH24kr2hWQFSpfL9pX8UAYhFZDKTwDmx8F2jEwi
	utMxJC5s/WGepgN72/codQCi9tRpj9S7dnhZ5Yq99VH41Rayo70K1YmtgBftq4BJ3P9ChSMpM0L
	FKl4PAA1qLafe5bqHGS0YwJ3Fd2W6zefWWCSMDd8B1bbtoAT1tHA==
X-Google-Smtp-Source: AGHT+IHE9PQEuoTH9UOWqvGGCSU8C9Ruq9AfI/ggNvlQijrcc1X+/GCrqq4sZ3Di/VYSKgFclTSqxw==
X-Received: by 2002:a17:907:3f02:b0:b4a:e11a:195b with SMTP id a640c23a62f3a-b72c0d5c41cmr119233266b.44.1762476531435;
        Thu, 06 Nov 2025 16:48:51 -0800 (PST)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bdbc9656sm90837566b.7.2025.11.06.16.48.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Nov 2025 16:48:50 -0800 (PST)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b7277324054so31666966b.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 16:48:50 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXPsunz/71zUzs5JN6Tw+Npocmz2uH9w/vJCfGO1FlycKS1Zd7b2vLzImW9b8RrfL4S+nxG5ZrgzCYX2+o=@vger.kernel.org
X-Received: by 2002:a17:907:d8e:b0:b71:fa4a:e16a with SMTP id
 a640c23a62f3a-b72c099753amr152181766b.28.1762476530309; Thu, 06 Nov 2025
 16:48:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251106210206.221558-1-seanjc@google.com>
In-Reply-To: <20251106210206.221558-1-seanjc@google.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 6 Nov 2025 16:48:33 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiJiDSPZJTV7z3Q-u4DfLgQTNWqUqqrwSBHp0+Dh016FA@mail.gmail.com>
X-Gm-Features: AWmQ_blj82Vcahx3SOa6MtKIrMn8wu7jk2421gv57pbk7yInk5N0KSx4Ebh8Ack
Message-ID: <CAHk-=wiJiDSPZJTV7z3Q-u4DfLgQTNWqUqqrwSBHp0+Dh016FA@mail.gmail.com>
Subject: Re: [PATCH] KVM: x86: Use "checked" versions of get_user() and put_user()
To: Sean Christopherson <seanjc@google.com>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>
Content-Type: text/plain; charset="UTF-8"

On Thu, 6 Nov 2025 at 13:02, Sean Christopherson <seanjc@google.com> wrote:
>
> Use the normal, checked versions for get_user() and put_user() instead of
> the double-underscore versions that omit range checks, as the checked
> versions are actually measurably faster on modern CPUs (12%+ on Intel,
> 25%+ on AMD).

Thanks. I'm assuming I'll see this from the regular kvm pull at some point.

We have a number of other cases of this in x86 signal handling, and
those probably should also be just replaced with plain get_user()
calls.

The x86 FPU context handling in particular is disgusting, and doesn't
have access_ok() close to the actual accesses.  The access_ok() is in
copy_fpstate_to_sigframe(), while the __get_user() calls are in a
different file entirely.

That's almost certainly also a pessimization, in *addition* to being
an unreadable mess with security implications if anybody ever gets
that code wrong. So I really think that should be fixed.

The perf events core similarly has some odd checking. For a moment I
thought it used __get_user() as a way to do both user and kernel
frames, but no, it actually has an alias for access_ok(), except it
calls it "valid_user_frame()" and for some reason uses "__access_ok()"
which lacks the compiler "likely()" marking.

Anyway, every single __get_user() call I looked at looked like
historical garbage.

Another example of complete horror: the PCI code uses
__get_user/__put_user in the /proc handling code.

Which didn't even make sense historically, when the actual data read
or written is then used with the pci_user_read/write_config_xyz()
functions.

I suspect it may go back to some *really* old code when the PCI writes
were also done as just raw inline asm, and while that has not been the
case for decades, the user accesses remained because they still
worked. That code predates not just git, but the BK tree too.

End result: I get the feeling that we should just do a global
search-and-replace of the __get_user/__put_user users, replace them
with plain get_user/put_user instead, and then fix up any fallout (eg
the coco code).

Because unlike the "start checking __{get,put}_user() addresses", such
a global search-and-replace could then be reverted one case at a time
as people notice "that was one of those horror-cases that actually
*wanted* to work with kernel addresses too".

Clearly it's much too late to do that for 6.18, but if somebody
reminds me during the 6.19 merge window, I think I'll do exactly that.

Or even better - some brave heroic soul that wants to deal with the
fallout do this in a branch for linux-next?

              Linus

