Return-Path: <linux-kernel+bounces-863284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E62E0BF7792
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 17:48:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B13D648708D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 15:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10C1A343207;
	Tue, 21 Oct 2025 15:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="AjBw7L0j"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44DF47261B
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 15:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761061646; cv=none; b=qti/n6/Fuq7AjclXx1vb/FeFmvM/ojTEdJ4IdNWelmRZse/ghkATsGSnJ9eE02xuCxHaWb3A1sSmnM7yrWE1YRhhM8K9axyf7nyIrNJ5MKjKBb0XNQuVZVbjkFIO/jczsJkCAoWOxbhj+uKjSAOtFKlKhqgC9/avcI+q34zZsIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761061646; c=relaxed/simple;
	bh=v4DAAOopxPuDTS6b13jWhPwgY6rLi9/WRQVdYJEqclQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=behyqtLqtOKOxWGs5DE0Ns6AezVQuHeLoh/zGdTbn6XEpE0o7Qxdt9EW6A5ym6YWW8OUdyIvBiihPJChwsfH282Sf7cxLUQhJhciOKBSYR8i+XOxAn4pAB86Ed0dL9Ik8/TtxEr0VcNzyBD6GIk5nghc3PM5FJP8CWHpKD2fT1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=AjBw7L0j; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-63c45c11be7so6681009a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 08:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1761061642; x=1761666442; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=r9YHz5AJsTnbPUUFUzOK0b5SHXphkm+yoYDBq4kn6CE=;
        b=AjBw7L0jp8FRGKTWa5UBsDpVayen0l8U5MV4rViSbQKBqsINy5GoXeWZDX/y1uCFLZ
         6cpl3+CGuj+he0LIZ7NGjt1FEsXc4Blwe+Yk1E1Kmk5QvvVZBAkG9K4o09dksqtOJQex
         VNV8ZG2pxNt56bgb85n6qFO9bOp3p3g5boZM8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761061642; x=1761666442;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r9YHz5AJsTnbPUUFUzOK0b5SHXphkm+yoYDBq4kn6CE=;
        b=JbAMx758AzE3HGOsBuWqQ4923Gs3X2ukDRD4vefhkIyDAXUE2pqUDQejoxn5xMYt08
         NGe2G4LeKoBzjEp5XEktzikza269GVnfT4Y03ZTvGLGoU3MQBlbPPjAd0HmyJrHB5ppm
         vpOuZWDgQYOQeAtvB8gbnntASJhwULNxl+6/bCRgZR5e6XveQUt8Nt3EFOB0Co+01eYS
         vCQ5iAirt9wdrpH9uI2NaT5bxsDHjHS/ZLhOaGV0JoKAurc0cRgsl4w3gBDrrAUJIH5l
         GHJZ0/yOTecsphR3gMWghcG3Jyc7cM6TEuaMTsrVrTI5vZxdpYuSt+4lLRRG4WpT/dAX
         Uy/w==
X-Forwarded-Encrypted: i=1; AJvYcCU9PUrhb2dCQuLxi0Byuv2qwYxgry5nrWp8YsPDgREmh/GcgboF0jJcUvNjX2UFF7PC6QgLLB5T++iNgaw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzu/PKbor8CKW6hpm/KEsTOswZ86TYhcVJKFoVARqUx8MFqfsjv
	EJwlpQQ3iLAT04NDV2OJAGpCP5IMCf426GfjDDVE6ShFBoHsfF956s57QKpdVJxmm+KR5Lecrtm
	dvHs6+Xv0Qw==
X-Gm-Gg: ASbGncsuFVPZc3c8l/V8YITfzPJ532ItBGBJjnBnXiC5xs+LCy5SDjmDNZqASf/9lsx
	5YdTkA0030kRz6kQei1lMVQQKZgouNKQwC15GUiwm3ATMSe39d9roab9IA1lRovr2XV85HEXs65
	Xxs5B+ydekSHHvtQM/qKfBhBaqsaLBbClMgMAgc5FfRe+VSS9w2y7vzIVNkJDj7UDJWAbF92N4K
	vDRL+zZBCWGwMho9V3H0YBSn9ht7NA3wuf3L3I5XZPihD3rso4uEla67K+2nigy4yGwQFQAh386
	oTfKeZIxZww14VvO0t11WLH9wOWVabDGwPKGWvWTrFjwt7Ia6vZFeNjpHAQh9bjRCARmYInUzLx
	ynkVssnBYAxlChxvYOXIZHaIHFv/77y1DVgXMNlLTWuOsEpnElWAvUw48p8UcKBUShAhdtKYGLA
	5nli+DF3IRusfw5Oo6mzmeobls0HQ+s0uht4rFvlh/IInqSy5LF42O20FOYho7
X-Google-Smtp-Source: AGHT+IGfY4vRh3qDDXHZNNHwW5/Hnl1Alz1htHAsSas+zsmtJPilOQAAUS49YeH0o5TAfVz0FxYAvQ==
X-Received: by 2002:a05:6402:5191:b0:63c:4f1e:6d7a with SMTP id 4fb4d7f45d1cf-63c4f1e734cmr13623686a12.19.1761061642134;
        Tue, 21 Oct 2025 08:47:22 -0700 (PDT)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63c4949bfd3sm9573945a12.41.2025.10.21.08.47.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 08:47:21 -0700 (PDT)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6399328ff1fso9745049a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 08:47:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWjISNcn99qTsHuarWjGY9ai0x1Iiv6VKimrLVeh0qKFQUpqEXFSf5AlzM8d/GHO+wjy9XkIXdkeJtjil0=@vger.kernel.org
X-Received: by 2002:a05:6402:26cc:b0:63c:1514:67cd with SMTP id
 4fb4d7f45d1cf-63c1f6da983mr16912137a12.17.1761061639455; Tue, 21 Oct 2025
 08:47:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251017141536.577466-1-kirill@shutemov.name> <20251019215328.3b529dc78222787226bd4ffe@linux-foundation.org>
In-Reply-To: <20251019215328.3b529dc78222787226bd4ffe@linux-foundation.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 21 Oct 2025 05:47:01 -1000
X-Gmail-Original-Message-ID: <CAHk-=wh62OxWsL+msmks7=VdBJHz7HvRYoPDckkAEAwsgrmjew@mail.gmail.com>
X-Gm-Features: AS18NWAv_MfH5FLOB6ldL8Zj3hG-nJtcm__9IX9yFQBhtiHusUcNpFwx2FU0x0Q
Message-ID: <CAHk-=wh62OxWsL+msmks7=VdBJHz7HvRYoPDckkAEAwsgrmjew@mail.gmail.com>
Subject: Re: [PATCH] mm/filemap: Implement fast short reads
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Kiryl Shutsemau <kirill@shutemov.name>, David Hildenbrand <david@redhat.com>, 
	Matthew Wilcox <willy@infradead.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Kiryl Shutsemau <kas@kernel.org>, Suren Baghdasaryan <surenb@google.com>
Content-Type: text/plain; charset="UTF-8"

On Sun, 19 Oct 2025 at 18:53, Andrew Morton <akpm@linux-foundation.org> wrote:
>
> Is there really no way to copy the dang thing straight out to
> userspace, skip the bouncing?

Sadly, no.

It's trivial to copy to user space in a RCU-protected region: just
disable page faults and it all works fine.

In fact, it works so fine that everything boots and it all looks
beautiful in profiles etc - ask me how I know.

But it's still wrong. The problem is that *after* you've copies things
away from the page cache, you need to check that the page cache
contents are still valid.

And it's not a problem to do that and just say "don't count the bytes
I just copied, and we'll copy over them later".

But while 99.999% of the time we *will* copy over them later, it's not
actually guaranteed. What migth happen is that after we've filled in
user space with the optimistically copied data, we figure out that the
page cache is no longer valid, and we go to the slow case, and two
problems may have happened:

 (a) the file got truncated in the meantime, and we just filled in
stale data (possibly zeroes) in a user space buffer, and we're
returning a smaller length than what we filled out.

Will user space care? Not realistically, no. But it's wrong, and some
user space *might* be using the buffer as a ring-buffer or something,
and assume that if we return 5 bytes from "read()", the subsequent
bytes are still valid from (previous) ring buffer fills.

But if we decide to ignore that issue (possibly with some "open()"
time flag to say "give me optimistic short reads, and I won't care),
we still have

 (b) the folio we copied from migth have been released and re-used for
something else

and this is fatal. We might have optimistically copied things that are
now security-sensitive and even if we return a short read - or
overwrite it - layer, user space should never have seen that data.

This (b) thing is solvable too, but requires that page cache releases
always would be RCU-delayed, and they aren't.

So both are "solvable", but they are very big and very separate solutions.

               Linus

