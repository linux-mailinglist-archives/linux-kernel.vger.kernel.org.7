Return-Path: <linux-kernel+bounces-724279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A3E0AFF0BD
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 20:19:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B3DAB40198
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 18:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBB422356CB;
	Wed,  9 Jul 2025 18:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="L8gyueRT"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 981FA22FDFF
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 18:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752085185; cv=none; b=bC/V/mvoSnmb2JnZAAYLXTHOWZc/4fuMFz1uvNJmzMl167d3YE7zzEBRo8VobQ9Xa/3i3SHWAEv32sz3FGVTpABzEj/Pb33QpCWQ7L1kNUWaaFTQ7jy0PzRiyHpQFkPxiF7/EKw83X27qi67vpR31cprExW7tBJYig4OGrHBmIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752085185; c=relaxed/simple;
	bh=FQsmjgohhRiKmXeIhJGldwnCwlJZnGi+DvE6RZc8wtY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B28eygwvD0zusMPOy/VFa0NZbqRbAY2wqzTsAqAaJGSdW9j2uc6AcAY1IgmG6QV+5s5BHmuSuvZh+ipBxy402ew6d8hbClbb+H4O3jkA/QPlbEsUAVlYbDFM4nTm+bPZLVYZpsqVLKuwKcd1SwoRON0oR9Wmzgj4tnalq7/lLTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=L8gyueRT; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ae35f36da9dso24024366b.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 11:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1752085181; x=1752689981; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=c+tEFiXZOPeNO8WKw10td+PRBgK9Dju5mF551/es1C8=;
        b=L8gyueRTkg6g/ARKzF1FFadf3HATwikXG8EfUEMWBNxJiFGKnfLLSpe7qYMATyvP1N
         TUUGbnrcy+em7gtoeLwt7PpDZ9pnsaHnwxct9ZVLb3KsGfVZcUtobxgBRiYRhIaoItNw
         Sdhx4okstLAIvJxpCjH8Qb6QMjlMkgYp1v+iw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752085181; x=1752689981;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c+tEFiXZOPeNO8WKw10td+PRBgK9Dju5mF551/es1C8=;
        b=BGkeM1mmB7p1YPKSZMcvPRkdYpGaOormzT1yXyuY1lMYfLW4JHalVnJiVy8DSzvYwQ
         OBRZ5PHER6fZ1l8u6/bsA6EChqSKB+dx8Jidceo5I+73Lcs8hotUrTszN1zpRoCzMOId
         cSE9/yp6KFeC162Pni5GENfWvLtYICJ2BshJP+d5pOav9Q3uLXA0bW1dquiT7yqEomkh
         vwAMH2g7u4i/X4TwN8EsSlRzZ1/dzyOLzYnNtfWEXmrezxL5MT0QTfJHKT5FJ2d+bca3
         9htznPZOyTRlym9eokzAh3/gm49WgG6R3ebFK/3RvppaS9UZAtdKuOXlat6MAsWk6YSA
         FEbA==
X-Forwarded-Encrypted: i=1; AJvYcCX1GjS2vAKuwzxNE8uB0287q47FgFBVfPivTkPjnFwdy8tqJBO4nFt+9zXWikwCRGDyqyXGCM8yK4wp1T0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5UeJGJCwfU6EJqVeQ+NZOWPHeBpuGPyfX/WkGpdzkyz0roIre
	No8fpnmBslaoVyhvbWG/+W1VJ8l+/1E+58gxhBijIgIT8uQwB2bwRIj56t0kUCD8T5tz6EfJrHY
	3mW5J6oQ=
X-Gm-Gg: ASbGncvJ/3VaCfuh+pXlTsi8WAxoggjza1nTI0BM/OlZAJQ2ZHxNERV+ITWApGCGkTY
	RITumFmuDoourOiBwFE2CiGgJn/HPmlzDzegXuK2Scv4rXB/t9VHBvnQlYbGtKY5apJLpH1DSbs
	gLYDvCkDyoT9iO4/u2fwSu2Lcls5Ngy7q0nQ1Q6xrwXsJ9mJiKvZfPf4i7t6Y9A42y1yI66pR2U
	4fLmfdrLu7FwxFFcO0J70dLFpPB7STnXLe+uqO/n+Tr5GAEmZWJzQdlZOEcXRIS2tAnDwiE/oBX
	cGFCPMhl1DVcBU2vVWm206cX5cCIe7AFhN70S/UzU4GUmtjYxgoN2XyaccEqWgAjGVr7P1nulHv
	VCBj4YBb3Da8jhTzHV7YznK/KPH6bFCbdVTRY
X-Google-Smtp-Source: AGHT+IEb15cjcGFqgPzh3MiQoVtwmHOGOGXyAF0T09rtx0iWtJjfFDlace6CPfM9bd7iXgQSSMZSEg==
X-Received: by 2002:a17:907:f1cc:b0:ad8:9e5b:9217 with SMTP id a640c23a62f3a-ae6e128ad9fmr81857066b.45.1752085180606;
        Wed, 09 Jul 2025 11:19:40 -0700 (PDT)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae40eaef164sm934113966b.136.2025.07.09.11.19.40
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jul 2025 11:19:40 -0700 (PDT)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6070293103cso158726a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 11:19:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVXSygImswxpaAjMF/HksZas4NamYQTmMQPeY53lBxUO1Jb3w7SqjJq3UJTK9H6I4O8P0N7hUJpULdMsAc=@vger.kernel.org
X-Received: by 2002:a05:6402:2074:b0:608:f54b:5c81 with SMTP id
 4fb4d7f45d1cf-611c0d46cb2mr428865a12.1.1752085179736; Wed, 09 Jul 2025
 11:19:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250709180550.147205-1-longman@redhat.com>
In-Reply-To: <20250709180550.147205-1-longman@redhat.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 9 Jul 2025 11:19:22 -0700
X-Gmail-Original-Message-ID: <CAHk-=wimw8A1ReDPMyAVPrB3rEzenkk-u21RN123BGmnGBwjiQ@mail.gmail.com>
X-Gm-Features: Ac12FXzemcNqQOVILVfG2tEf3Dblt14QdVRb7uqdXOXi5rqD1CixyRZehOwSh3I
Message-ID: <CAHk-=wimw8A1ReDPMyAVPrB3rEzenkk-u21RN123BGmnGBwjiQ@mail.gmail.com>
Subject: Re: [PATCH] locking/mutex: Disable preemption in __mutex_unlock_slowpath()
To: Waiman Long <longman@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Will Deacon <will@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
	linux-kernel@vger.kernel.org, Jann Horn <jannh@google.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 9 Jul 2025 at 11:06, Waiman Long <longman@redhat.com> wrote:
>
> This race condition is possible especially if a preemption happens right
> after releasing the lock but before acquiring the wait_lock. Rwsem's
> __up_write() and __up_read() helpers have already disabled
> preemption to minimize this vulnernable time period, do the same for
> __mutex_unlock_slowpath() to minimize the chance of this race condition.

I think this patch is actively detrimental, in that it only helps hide
the bug. The bug still exists, it's just harder to hit.

Maybe that is worth it as a "hardening" thing, but I feel this makes
people believe even *more* that they can use mutexes for object
lifetimes.

And that's a fundamentally buggy assumption. Locking is about mutual
exclusion, not lifetimes. There are very specific things where
"release the lock" also releases an object, but they should be
considered very very special.

All objects that aren't purely thread-local should have lifetimes that
depend *solely* on refcounts. Anything else is typically a serious
bug, or needs to be actively discouraged, not encouraged like this.

Even with things like RCU, the lifetime of the object should be about
refcounts, and the RCU thing should be purely about "I'm going
asynchronous lookups that aren't protected by any locks outside this
object, so I may see objects that are being torn down".

I absolutely detest the notion of "let's make locking be tied to
object lifetimes".

Note that locks *outside* the object is obviously very very normal,
but then the *lock* has a totally different lifetime entirely, and the
lifetime of the lock has nothing to do with the lifetime of the
object.

Please don't confuse the two. This was eventpoll being completely
broken. As usual. We've had less eventpoll breakage lately than we
historically used to have, but that's hopefully because that horrid
pile is not actively developed any more, and is slowly - oh so very
slowly - getting fixed.

I'm very sad that io_uring ended up with eventpoll support, but that
was sold on the premise that it makes it easier to incrementally turn
some eventpoll user into an io_uring user. I certainly hope it leads
to less epoll use in the long run, rather than more.

             Linus

