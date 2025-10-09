Return-Path: <linux-kernel+bounces-846337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EED9DBC79B3
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 09:05:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 472043E6620
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 07:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F6412BE7B4;
	Thu,  9 Oct 2025 07:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="AlFyrdTG"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 490291A23A4
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 07:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759993501; cv=none; b=sDyrVvAROJXqQNUf39ZwJ5xJPEfqfWM0sOzUcWbqsF70b8DC1S0FIjOSw2DNog3UNFDE4tP9SymOx8YD7pB3jgvG3uaA3uBKFWQAYd5BmifnkPgcmpQtdznqTi3MPI1uof4optpm+z/T8aEBUbOOF49gJr+lfRBzLaDwTuywoX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759993501; c=relaxed/simple;
	bh=X/A67aav9wnEVAviNgP8/3bMnmDDFoutZhBInzu4IGI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=etqYKWO+chkoa+pw2R3o1XdBBUwbgaM70RgS04r1SontJVklAlgRVfMmItZJ7SFQhZUuXo6rXTJ/kpsiduLY8NVFMVNnBachN8g/MKQexPT6YsHyjr9Pq5TpteZL2v7L7obmfoQnYXTcu/A25dxLJQkLerUcoLRHClYQxJsPqJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=AlFyrdTG; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-62ecd3c21d3so958298a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 00:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1759993497; x=1760598297; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=W4QKO1V1IaEeKnE/Y3uXu7YrKeGgjyQzfwEaf1mJzm8=;
        b=AlFyrdTGJGSHEHq8uLhzVCop4tK9onlj+hKmngruEblQHmx6pvsBdxTOKetCbC3Tr+
         8kSexQibzg8hqye6mwJvME6dQb9KsQY93sVzfKnIJm3ILBhvE3IDf9j3ks/a9eTM4nLU
         qa7dNxqceHb4ac7C92vF+6SKslBXsNdsYomJw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759993497; x=1760598297;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W4QKO1V1IaEeKnE/Y3uXu7YrKeGgjyQzfwEaf1mJzm8=;
        b=Sn+5v2ewGe8zWGhso5FMtIbB6NBc5IZglySVnJVKuiNSBLw01cU+m/wYxKz6WcTl3Y
         CHm79pYqZhDQKFOPojq7K0MklYXb+PkilaJUJ5sAif1SJoWcjAU1LuVsVgi3rwPht50r
         V/Vi1jEAjLYaigsc5YqND/wvpR3LbPYhPehQ8QD6A9nOYaKgpOeF3ainwf4WBIqyI8p7
         zZYLRbBSZigRMAYu8f+HTdx8lYJQsNPpVUBVDwN/6NmupqEqcXLWeBeWMiZ22noY0S+m
         hIA1xaR5ta5qUkVRSeS1WendrjTvitV42sYdzKQnsPTTu1vUMoYpyvAs9Ij4MM0Xk/8M
         9JBg==
X-Forwarded-Encrypted: i=1; AJvYcCVnC1luW+efaDTguarC3FPQK4qFDIfRyws9bv8Flwb6UQc8ryegMpD7c7gpxTuKl150+kMPbnOWOt4QZL0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbrdFZ6Wryz56O+XdIkBdUxytuMI8jZ8FNrCQevy9lF+8mpj2U
	/gmrwsXjO+pVYlII+8hBWWH21r0rw5E+ja0LXWRu7qHXdiAeHHNjR8jiD+uEg/5nG0VE8LHPPt5
	e0BYLk5sD2A==
X-Gm-Gg: ASbGnctIApS9t4fzRhO5iQzTFL7fNAbRcqvB6PFK0zMPWewU+7SlwHomHqOUXaFeIFZ
	fzcdPu9b9ZdZrdlAkbOS2ApxaHGzU+CpvsVi3/Dy097eOJH7f4ATSA7zTJAggWWxHasGX1d3azI
	jBjJJ9UhBqf7G6xZ7Y7jIlC5mIzLqcasVQoibnrB5yhcn92lwl1SlH4PgqZFeVv2VEu3U2EicO9
	6kjuvUh8jSCb1ulalWorSc/ypGK6tFlqRcJgFjNQrKi7wdfdCb7SEe60PbcDkL1GfztFKkFjFtV
	emw5lB+RK7w3s5817DAbwOoIjGwKFzbOTBt4MPi26GSGuoHQzwjT9BFv5IQvOC0FIeSavQLdpRE
	0qQwpF/bdSt8VPP/MhYRlexITXhseO3tPNV8ozhtMCyTNfIfFovLYLFDXQ0wrxghIyFdNHAscZQ
	N/kCFx9r+U+ewrykbY4KSV
X-Google-Smtp-Source: AGHT+IGPOZkUMw2Nc69/sM9iulaHOfFOqOTCA38TC1w1TC85nFLQMmszDYsPmcw+RxYrWBgOq7ukVA==
X-Received: by 2002:a17:907:7290:b0:b45:a03f:d172 with SMTP id a640c23a62f3a-b50acc2f5bemr732686066b.57.1759993497239;
        Thu, 09 Oct 2025 00:04:57 -0700 (PDT)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b5416dcaa11sm230200866b.51.2025.10.09.00.04.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Oct 2025 00:04:54 -0700 (PDT)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6394938e0ecso937090a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 00:04:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWj5138d9VzkNS16E2fBiCP02dwLsWrKEGYrPKtz1Ps80UWhGzIUxAomsfI0N3Sdf1ZTvJvbvXQ6XdQbJI=@vger.kernel.org
X-Received: by 2002:a05:6402:5241:b0:636:7c68:6e30 with SMTP id
 4fb4d7f45d1cf-639d5c36a7emr5706814a12.21.1759993493766; Thu, 09 Oct 2025
 00:04:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251008123014.GA20413@redhat.com> <20251008123045.GA20440@redhat.com>
 <CAHk-=wjozC9_JCdEW9K_uruJqzTLzhtcVpgDk1OuqErNRUS7Mg@mail.gmail.com> <CAHk-=wjuoFm9yZur_T4VOnX2iyDYD6T_gDRXE5ms9538W6Q35g@mail.gmail.com>
In-Reply-To: <CAHk-=wjuoFm9yZur_T4VOnX2iyDYD6T_gDRXE5ms9538W6Q35g@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 9 Oct 2025 00:04:37 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiHbN+_LCmSj2sHswDRJ0yG3kkjptMvCXcMwk7jWK1F=Q@mail.gmail.com>
X-Gm-Features: AS18NWBchGhZOYJ6zw6Au_d7AD0BGkNJJfUDWdDkMAR9OttIiePZPEqryMlcWrE
Message-ID: <CAHk-=wiHbN+_LCmSj2sHswDRJ0yG3kkjptMvCXcMwk7jWK1F=Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] seqlock: introduce scoped_seqlock_read() and scoped_seqlock_read_irqsave()
To: Oleg Nesterov <oleg@redhat.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Boqun Feng <boqun.feng@gmail.com>, 
	David Howells <dhowells@redhat.com>, Ingo Molnar <mingo@redhat.com>, 
	Li RongQing <lirongqing@baidu.com>, Peter Zijlstra <peterz@infradead.org>, 
	Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000000146760640b46b55"

--0000000000000146760640b46b55
Content-Type: text/plain; charset="UTF-8"

On Wed, 8 Oct 2025 at 22:31, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> But that hackery shouldn't even exist since it's all handled naturally
> and much more cleanly by the surrounding for-loop.

I'm batting zero. I still think it's true that this logic should be
handled by the for-loop, but the *seq=1" hackery did actually do
something.

Because it, together with the 'lockless' flag, enumerated three
states, not two. It's just that the first state didn't _do_ anything,
so it was kind of easy to miss it when I read through the code.

So the three states are

 (a) before anything has been done (lockless, seq is even)

 (b) the "we've done the lockless, we need to end the loop or take the
lock" (!lockless, seq is even)

 (c) we've done the locked, we need to unlock and end (seq is odd)

and so relying on just a 'bool lockless' in the loop isn't enough.

I do still think this could be done at the for-loop level, so that the
compiler can statically see the stages and unroll it all to not be a
loop at all.

But I think it means that "lockless" would have to be a "phase", and go 0/1/2.

And I did get it to work that way, and did get gcc to unroll it to
generate really nice code. IOW, I can make this code

        scoped_seqlock_read(lock) {
                asm volatile("TEST");
        }

generate this assembly:

.L12:
        movl    (%rdi), %eax    #* lock, _25
        testb   $1, %al #, _25
        jne     .L14    #,
        TEST
        movl    (%rdi), %edx    # MEM[(const volatile unsigned int
*)lock_6(D)], _70
        cmpl    %edx, %eax      # _70, _25
        jne     .L15    #,
        ret
.L15:
        subq    $8, %rsp        #,
        addq    $4, %rdi        #, _74
        movq    %rdi, (%rsp)    # _74, %sfp
        call    _raw_spin_lock  #
        TEST
        movq    (%rsp), %rdi    # %sfp, _74
        addq    $8, %rsp        #,
        jmp     _raw_spin_unlock        #
.L14:
        pause
        jmp     .L12    #

which is basically optimal, but I have to say, the hoops I had to jump
through to get there makes me suspect it's not worth it.

(Note above how there is no sign of 'phase' left in the code, and the
only conditionals are on the actual sequence count state, and the nice
default action of no sequence count problems is all linear
fall-through code).

The irqsave version looks the same, just (obviously) calling a
different set of spinlock/unlock functions and having one extra
register argument for that.

But to get there, I had to use not only linux/unroll.h, but also make
that for-loop explicitly have that s.phase < 3 test just to get the
unrolling to actually trigger.

I'm attaching the test-case I wrote that does this. It's not
*horrific*, but the extra unrolling hackery makes me doubt that it's
really worth it.

So I suspect your patch is fine as-is, and I was not just wrong on
relying on the (insufficient) "locked" boolean, but the more complete
solution is just too damn ugly.

But hey, I *did* get gcc to generate nice code. So you might look at
my test-case below and decide that maybe there's something to be said
for this.

                 Linus

--0000000000000146760640b46b55
Content-Type: text/x-csrc; charset="US-ASCII"; name="t.c"
Content-Disposition: attachment; filename="t.c"
Content-Transfer-Encoding: base64
Content-ID: <f_mgj2o6o70>
X-Attachment-Id: f_mgj2o6o70

I2luY2x1ZGUgPGxpbnV4L3NlcWxvY2suaD4KI2luY2x1ZGUgPGxpbnV4L3Vucm9sbC5oPgoKI2Rl
ZmluZSBfX3Njb3BlZF9zZXFsb2NrX3JlYWQobG9jaywgcywgY29uZCkgXAoJdW5yb2xsZWRfZnVs
bCBmb3IgKHN0cnVjdCB7IHVuc2lnbmVkIGxvbmcgcGhhc2UsIGRhdGE7IH0gcyA9IHsgMCB9OyBc
CgkJcy5waGFzZSA8IDMgJiYgY29uZChsb2NrLCBzLnBoYXNlLCAmcy5kYXRhKTsgcy5waGFzZSsr
KQoKI2RlZmluZSBzY29wZWRfc2VxbG9ja19yZWFkKGxvY2spICAgICAgXAogICAgICAgX19zY29w
ZWRfc2VxbG9ja19yZWFkKGxvY2ssIF9fVU5JUVVFX0lEKHMpLCBfX3NlcWxvY2tfY29uZCkKCiNk
ZWZpbmUgc2NvcGVkX3NlcWxvY2tfcmVhZF9pcnFzYXZlKGxvY2spIFwKCV9fc2NvcGVkX3NlcWxv
Y2tfcmVhZChsb2NrLCBfX1VOSVFVRV9JRChzKSwgX19zZXFsb2NrX2NvbmRfaXJxc2F2ZSkKCi8q
IERvIHRoZSBwaGFzZSBhY3Rpb24gYW5kIHJldHVybiB0cnVlIGlmIHRoZSBsb29wIHNob3VsZCBn
byBvbiAqLwpzdGF0aWMgX19hbHdheXNfaW5saW5lIGJvb2wgX19zZXFsb2NrX2NvbmQoc2VxbG9j
a190ICpsb2NrLCBpbnQgcGhhc2UsIHVuc2lnbmVkIGxvbmcgKmRhdGEpCnsKCXN3aXRjaCAocGhh
c2UpIHsKCWNhc2UgMDoKCQkqZGF0YSA9IHJlYWRfc2VxYmVnaW4obG9jayk7CgkJcmV0dXJuIHRy
dWU7CgljYXNlIDE6CgkJaWYgKCFyZWFkX3NlcXJldHJ5KGxvY2ssICpkYXRhKSkKCQkJcmV0dXJu
IGZhbHNlOwoJCXJlYWRfc2VxbG9ja19leGNsKGxvY2spOwoJCXJldHVybiB0cnVlOwoJZGVmYXVs
dDoKCQlyZWFkX3NlcXVubG9ja19leGNsKGxvY2spOwoJCXJldHVybiBmYWxzZTsKCX0JCQp9Cgpz
dGF0aWMgX19hbHdheXNfaW5saW5lIGJvb2wgX19zZXFsb2NrX2NvbmRfaXJxc2F2ZShzZXFsb2Nr
X3QgKmxvY2ssIGludCBwaGFzZSwgdW5zaWduZWQgbG9uZyAqZGF0YSkKewoJc3dpdGNoIChwaGFz
ZSkgewoJY2FzZSAwOgoJCSpkYXRhID0gcmVhZF9zZXFiZWdpbihsb2NrKTsKCQlyZXR1cm4gdHJ1
ZTsKCWNhc2UgMToKCQlpZiAoIXJlYWRfc2VxcmV0cnkobG9jaywgKmRhdGEpKSAgCgkJCXJldHVy
biBmYWxzZTsKCQlyZWFkX3NlcWxvY2tfZXhjbF9pcnFzYXZlKGxvY2ssICpkYXRhKTsKCQlyZXR1
cm4gdHJ1ZTsKCWRlZmF1bHQ6CgkJcmVhZF9zZXF1bmxvY2tfZXhjbF9pcnFyZXN0b3JlKGxvY2ss
ICpkYXRhKTsKCQlyZXR1cm4gZmFsc2U7Cgl9Cn0KCnZvaWQgdGVzdG1lKHNlcWxvY2tfdCAqbG9j
ayk7CnZvaWQgdGVzdG1lKHNlcWxvY2tfdCAqbG9jaykKewoJc2NvcGVkX3NlcWxvY2tfcmVhZF9p
cnFzYXZlKGxvY2spIHsKCQlhc20gdm9sYXRpbGUoIlRFU1QiKTsKCX0JCQp9Cg==
--0000000000000146760640b46b55--

