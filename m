Return-Path: <linux-kernel+bounces-724299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D15F6AFF0ED
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 20:29:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D50047A7F72
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 18:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC7AB239E61;
	Wed,  9 Jul 2025 18:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="U7uMrJmh"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4074239082
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 18:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752085756; cv=none; b=iZkpG2E3z7Rm030qo7bFKeEri0ngl62Xzf8yKGfiLqPGxJluu1p/63iMDbwXykcpiTlYVLURsEig3dZnB/1199LBImkGha1AZwR0G1lDlKpbk11HWH8R1vTLxFPNYGzlmG7PxXy0wr6++Arniz3TBPy61UVW5QjV+Oywd7yQhP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752085756; c=relaxed/simple;
	bh=RUvxKtmLlgRQyhKMMGYzhgHjqRtHvDZnXgIgRz76fLI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t/cUuoJBKX3RmttiTbnWuE33XKbAune5XFNJKLDhPccHnddtm2jQmhZBPGYimoM65DuAPGJnHRv+fFbp9gNNm8eGnDXJMSnMdNugV9IbFlM2GEsoljiU8vR+rBYDHCUa+YCiouftpGirl5O+qX6KfDCxfAsQ/x2wuasdo4+80/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=U7uMrJmh; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-60bf5a08729so216271a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 11:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1752085752; x=1752690552; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/NIGbb5cwq+FehUkV1Hw5f7PayhEvmVx5aOiVnbjh7g=;
        b=U7uMrJmh3moIfT/VSRKeB4i76pBfm5c3AG7C2zJWNsKXcTeomxdEZIrDBDzWPGGOoy
         xxPmbDcUceSxTplH6hmuJmELT3IBrqRMgTUTZ7O0fHK+Tzo2T7CKYovYMzrNFWMSkhoC
         87yQNr6+GIVGH5oC9RxlpKJGFBrzrAnSnkSl0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752085752; x=1752690552;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/NIGbb5cwq+FehUkV1Hw5f7PayhEvmVx5aOiVnbjh7g=;
        b=NdrUWaKgZ1HSXYSXzEiM2cMsPLlFkaMCPeX4JTWSY0NtjeZ/ZcQiJ652YgcQRZJdTv
         u5nA+LVCuXxP+Sd72enVtACyKWIZkzRRf4BXJYdwgAv/+TQmD4sq7etOm+w0vSmLn1St
         ZvtjkmZlTWb0ncJv1S0/8JRs2pKEW4r6B2ZcUrTvOdMOvzdahDHvRyeqMK87bDyFF7HD
         Pdm7Efg0p6zmkhnA56XyWfBT9WgOp3tDWNi1+yybHVLlexZrwq8aMJjRQZCZByILU94k
         kxdq71KyEP46L9CDHWHM5NK6O1pnPaLBxto26FcNv62OYF8X2OCjD4eIttnAyMOjXjgo
         6crw==
X-Forwarded-Encrypted: i=1; AJvYcCUBZB+pd9l3lBBxBot1JQY93Y9iD00HLugKgG8PhlRNCeS8s4tWR3gGGofwx6MSehhpxQmiXoUIofHrUBs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+fTY6BVCTh5n2ZI8gEv6piGaZlcU3ktJy1Yt5xN8M5OY3NJZ7
	5AnjGyInh94zWFJMBM4phLKIIeZUDbbjLIRH1ZJSaN3ujR6tY2gyu6RtF3+P61sRBj7VyJrH4Ky
	THDd5Kk4=
X-Gm-Gg: ASbGnctiLj4Vy3UTTixUsy2u9lRpEEpcsGCa1iD9RVYVEbJuFVXviHFEnab1aOdadm+
	2V8yrHG67ygUpTGph0hqQ0TF9LsFu+FnCrCx/GTaPGLOCEMIX3YzcfvYcRsucOiwE69MJyzKGWK
	q1BKb2f8TrJuZv/DrRboNCUGuGqa9dssckb5JN/oubmTYT6TbUI9dCboqXUJxZrtxwcxXkvn6p4
	VIUZWSw9eCNz189PjxY3NkgPsse5lvTjsQCIXcWRluc/8C2KtSZ1vBf8bgVa0WQ4tbdwUSBzrgx
	ORoUNy9Xramp9a4ReiZN2F9MWm0+NQ9DWZvqKtF723dKgtv/Cc6/gWtcaXpF7K6w6HEsaAGMbR6
	5L9HZnL/wDdsV3dEUNI9Fxp2CbRoKu6wXysElWFcyKYiUYjQ=
X-Google-Smtp-Source: AGHT+IG0Tc42z0jJcXxBYporjtzBaK1d6UPL+nKQFaG1u4+3kH3p7OS+Kb+cKmcqgt18kD06Y3DD9Q==
X-Received: by 2002:a05:6402:34c4:b0:601:dc49:a99f with SMTP id 4fb4d7f45d1cf-611a6626cf2mr3370899a12.18.1752085751894;
        Wed, 09 Jul 2025 11:29:11 -0700 (PDT)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60fcb2f3122sm9108630a12.57.2025.07.09.11.29.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jul 2025 11:29:10 -0700 (PDT)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6099d89a19cso177446a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 11:29:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUca0UXEbvCsg30F7XO9vs/C6BWjoS9iBqm2OvwSe7jFYMtzeq4/uUi9ncWCsk9rtCW0AqunbGA4F1ihaI=@vger.kernel.org
X-Received: by 2002:a05:6402:5c9:b0:60c:3a73:a630 with SMTP id
 4fb4d7f45d1cf-611a6551cbemr2585913a12.9.1752085750363; Wed, 09 Jul 2025
 11:29:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250709180550.147205-1-longman@redhat.com> <CAHk-=wimw8A1ReDPMyAVPrB3rEzenkk-u21RN123BGmnGBwjiQ@mail.gmail.com>
 <CAHk-=whVBKwK83R_7+52qzZb3DpFWGG8L=V5bDG6VS44e3=1-A@mail.gmail.com>
In-Reply-To: <CAHk-=whVBKwK83R_7+52qzZb3DpFWGG8L=V5bDG6VS44e3=1-A@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 9 Jul 2025 11:28:54 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjT5Y36Xs1zdE1OdM-AwxUMcC9fQC=8r1_GvawP1oqC3Q@mail.gmail.com>
X-Gm-Features: Ac12FXwDUNreF-nXSKhy9M8DutIiIMOwonvP4v9KvxHXFK0RYQLn0JkxqMOUTuo
Message-ID: <CAHk-=wjT5Y36Xs1zdE1OdM-AwxUMcC9fQC=8r1_GvawP1oqC3Q@mail.gmail.com>
Subject: Re: [PATCH] locking/mutex: Disable preemption in __mutex_unlock_slowpath()
To: Waiman Long <longman@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Will Deacon <will@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
	linux-kernel@vger.kernel.org, Jann Horn <jannh@google.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 9 Jul 2025 at 11:21, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> And I suspect it would involve the exact *opposite* of your patch:
> make mutex_unlock() actively cause preemption after it has released
> the lock but before it has done the final accesses.

.. sadly, I suspect we have a ton of mutex_unlock() users in atomic
contexts, so we probably can't do that. It's not like you *should* do
it, but I don't think we've ever disallowed it.

You can't use mutex_unlock from interrupts etc, but you can use it
while holding a spinlock.

           Linus

