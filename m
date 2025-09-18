Return-Path: <linux-kernel+bounces-821746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E4AAB82228
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 00:16:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7449C585D73
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 22:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 274342C21F5;
	Wed, 17 Sep 2025 22:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kQVel1Xw"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E05F13C8FF
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 22:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758147389; cv=none; b=irK+1ipZhga+tRRNZQmllcL5/BnP8wHPzQOTwE64yUGQt+kojQuGbcQf+8BNa9AY2Gpq83GEXIV2ikH9Ef4QsxCDgFTuuVdVoSxLQMV6EULqlUJcIR/r4JSilQm4Zb+nq6TqPNBMy/iAePwcXNi36zdTqj+dE/3juJsNAyUDJOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758147389; c=relaxed/simple;
	bh=6ZgxKrLvuuo3G8gENIcfg7B88hjTblttbBHQY6jR5eE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pyganrNiT0iBGVp30o1VwbuLNHQixAJJJ8/SDMrg/b5KQDmEwTEoMEtE6pmFa+gbrKZIfA7tjIe8V7gyfA8lqxhV9JdUaAgcJN9KFcHOrVZvGNfHLMRSgWyjaxdNYWxF6K+x92lc/TFkIV87AH8KPDYLSC4M2Jq2ezjSzPTT1z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kQVel1Xw; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-77d37d71967so22071b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 15:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758147387; x=1758752187; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tCBrVOzSVlr+ECZmfMJYTx78nkYuCRMwstFmbZ8a4mg=;
        b=kQVel1XwhrKSPC4KirKgf7cadL0o5Yvd/ax6+Z/3Hu2KB+YfqqHP4QHGoaWaDk+jrb
         BTQiOT6Re1fEtq2z9i/3PgyLuKg4Z5euFg5xs5ypXqGDFZTdsGFwLKuVZwtPFxa/Q/Oa
         FUM3WNAprzpeE6wMUH1wsyqsnW/vvmZzD6IZ6hq7QJlme5Ngoq9nZN1pXGstvMcVTLX3
         8YAZmusk9klFr+kTUMQkRj7F6TbUQ7ajV3GGhdlpaQwBzSM8d1hUQf0S6INUXbrBgmAY
         QV40kYPONSO3sNLIwZzex0nUyI3f02wd9bCw0SaoQJH6ofs0NIp4mNRCVE1scJjBcUgL
         pA5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758147387; x=1758752187;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tCBrVOzSVlr+ECZmfMJYTx78nkYuCRMwstFmbZ8a4mg=;
        b=drAXhLnABe3Z8wBjGfaumL+AIwvLelWKoKc8KCyASSbtzKJaXOQ24ai2Klm/+4/lK/
         MarvZDou5OPXDLGNTlx7uqJfFea1GpQXy4tGuRHDaRnYUyz9BcoCO6gEEj47rPlUVnoK
         g40ddWFsdFZcChy91up4kVOtyoFRahmClCdKrOsBQNVF5ugHi/bYvBRDCG6UMU9DD3X1
         9/QZC/LcgVM8G4q4PhxGIZv1AalPMZgFjkqHUn8ndKR2fBEdh1Lo7U4GF5u9nPysQ5oF
         mVEKHOBAB1GCKpJ+vscIT4uWlqlL7d8wuSWseaBrnsFQeXn/F5qtrti2wLqlH/3Xm3m3
         Bs9w==
X-Forwarded-Encrypted: i=1; AJvYcCXDZXjGIRLnul084m6RA4pNc05ajDJPjGnmakxs6XgIAW9gQoH0ffE+JjcRCzKsN9Qj7Jb8yiSXnJLYAQ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKupnQ62qyTgSg73TA3AKf238jPzLFcujhAnfuP4/mfCvD7znl
	oAls9R0xaF3DlDGNQ20cfrK3wFCqMOHiw1MdkMKp4vP8efyjZhAfpE7Vd5VL5lJspSq6gKU5imW
	p0jiwZBXD2ntvQ8LueqlcX7dBKgCKAxY=
X-Gm-Gg: ASbGnctnImCsK3VMmdbPbI58XIZyAkSZNHecfqDw+SKpxUzHFGe0TvYIQ7INJvS+nJ2
	Xx9dnW2C5hEAg4GroO3ugqUhMpRZHAS4CJXBitMD41L2+SOL5YSGj7wG+5p/L3IUc2Lg/sBSI+1
	j+Xn1kiOlY5kte+AjmopA5HTrX9+yZM5GSokkZKLoL3oY8zF1iCdX5kiomf7vYqpFU5/iM9rbxc
	iXwxzDgzxJ1ltgSQekiRgA=
X-Google-Smtp-Source: AGHT+IGhD1bNzefFJl3fs0tdZ1yCW33HlnDn2RStsZC3d/RJWbHmwVP0ABSBF5+eREiUtKI2cLkQ++f5ExEMsaI8HHk=
X-Received: by 2002:a05:6a20:a127:b0:24d:d206:69ac with SMTP id
 adf61e73a8af0-284522d3d4fmr1632099637.14.1758147387259; Wed, 17 Sep 2025
 15:16:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909163223.864120-1-chen.dylane@linux.dev>
In-Reply-To: <20250909163223.864120-1-chen.dylane@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 17 Sep 2025 15:16:15 -0700
X-Gm-Features: AS18NWDA3lS8DubHQQVsleWA8P2HpjbI4ravEkFyymxj2lyF55857JlHMOQRdLA
Message-ID: <CAEf4BzZ2Fg+AmFA-K3YODE27br+e0-rLJwn0M5XEwfEHqpPKgQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Add lookup_and_delete_elem for BPF_MAP_STACK_TRACE
To: Tao Chen <chen.dylane@linux.dev>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 9, 2025 at 9:32=E2=80=AFAM Tao Chen <chen.dylane@linux.dev> wro=
te:
>
> The stacktrace map can be easily full, which will lead to failure in
> obtaining the stack. In addition to increasing the size of the map,
> another solution is to delete the stack_id after looking it up from

This is not a "solution", really. Just another partially broken
workaround to an already broken STACKMAP map (and there is no fixing
it, IMO).

When a user is doing lookup_and_delete for that element, another BPF
program can reuse that slot, and user space will delete the stack that
is, effectively, still in use.

<rant>

I also just looked at the bpf_stackmap_copy() implementation, and even
lookup behavior appears broken. We temporarily remove the bucket while
copying, just to put it back a bit later. Meanwhile another BPF
program can put something into that bucket and we'll just silently
discard that new value later. That was a new one for me, but whatever,
as I said STACKMAP cannot be used reliably anyways.

</rant>

But let's stay constructive here. Some vague proposals below.

Really, STACKMAP should have used some form of refcounting and let
users put those refs, instead of just unconditionally removing the
element. I wonder if we can retrofit this and treat lookup/delete as
get/put instead? This would work well for a typical use pattern where
we send stack_id through ringbuf of some sort and user space fetches
stack trace by that ID. Each bpf_get_stackid() would be treated as
refcount bump, and each lookup_and_delete or just delete would be
treated as refcount put.

Also, it would be better for STACKMAP to be a proper hashmap and
handle collisions properly.

The above two changes would probably make STACKMAP actually usable as
"a stack trace bank" producing 4-byte IDs that are easily added to
fixed-sized ringbuf samples as an extra field. This model sometimes is
way more convenient than getting bpf_get_stack() and copying it into
ringbuf (which is currently the only way to have reliable stack traces
with BPF, IMO).

So, tl;dr. Maybe instead of pretending like we are fixing something
about STACKMAP with slightly-more-atomic (but not really)
lookup_and_delete support, maybe let's try to actually make STACKMAP
usable?.. (it's way harder than this patch, but has more value, IMO)

What does everyone think?

P.S. It seems like a good idea to switch STACKMAP to open addressing
instead of the current kind-of-bucket-chain-but-not-really
implementation. It's fixed size and pre-allocated already, so open
addressing seems like a great approach here, IMO.

> the user, so extend the existing bpf_map_lookup_and_delete_elem()
> functionality to stacktrace map types.
>
> Signed-off-by: Tao Chen <chen.dylane@linux.dev>
> ---
>  include/linux/bpf.h   |  2 +-
>  kernel/bpf/stackmap.c | 16 ++++++++++++++--
>  kernel/bpf/syscall.c  |  8 +++++---
>  3 files changed, 20 insertions(+), 6 deletions(-)
>

As for the patch in question, I think the logic is correct :) I find
bpf_stackmap_copy_and_delete() name bad and misleading, though,
because it's more of "maybe also delete". Maybe
bpf_stackmap_extract()? Don't know, it's minor nit anyways.

[...]

