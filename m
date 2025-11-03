Return-Path: <linux-kernel+bounces-882197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B312C29DBF
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 03:29:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20A60188AE0E
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 02:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 453272820AC;
	Mon,  3 Nov 2025 02:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dax810Rp"
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0110F158DA3
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 02:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762136913; cv=none; b=qdl2CuBr/EM3aBWwrU8xZRJWvaYHhf87VT1UIgEGZVkTyYyyiZz15HT35xpuandWcR90BzzR/CKr34uCCnBixItl+14BWXSamlsfzRGwQFwAtER+dbUhCacgjQ5amo0ATSMTc0KcANGXRrSG/7cQQ311+XqHdimGcGzGvPZEAm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762136913; c=relaxed/simple;
	bh=wiyr5ZZl75Lfa/+EPqDHBz9yJzZ7Dh9+fBf91IEQM8U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PUfuJ8KbxTrg15WGcqQV4JnMRHLtXjDHeF+TcjTVlP68mKBgGAlvDBtINavrpZ6h34YKiPIZwmTDqpFRJ/d891WV3TXE8mjks2FYCETtAQ7UaOo+07sNjzLaHsMPNSRWX9UUgWasbmBzvm8rCiY1xkruaxoOl/xBNyJBffZBLpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dax810Rp; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-7866dcf50b1so6365177b3.3
        for <linux-kernel@vger.kernel.org>; Sun, 02 Nov 2025 18:28:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762136911; x=1762741711; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nMfJ5Y5GGur5h0c/aW8X7+pRDgjg9Cbc6huo+2E9Af0=;
        b=dax810Rplo9t5nJEOL7/hA+XWeWZ5Gn29KwewgfJRS4Sjoq2XnDGCkwSy7bRZyRhfs
         7ZEzOILiat8Wg4aga9uNU0RrFqGzgk42FcWjrQvqM+6t9tEut/vnTmuGyIETncylaqKv
         g5iVSBIBPGuk6vNKL5WgavUbpvLLvg+KHznPKX/P6DLifaSB33ZUsKXj3mXQRovtj81F
         UVw9M/3qDe1zSkRRFuhp6tLOy9SfAPRN8aTNFF/nFS6Kwx+6GY7x6uOr/5uoxceMdshs
         yZX8rUzOQgOnzo/VAgl8cs3BP9ON8/7Ml6z9sk+4Zf7RysC2tgJGZlco074MoYz3uWrO
         3Ifw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762136911; x=1762741711;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nMfJ5Y5GGur5h0c/aW8X7+pRDgjg9Cbc6huo+2E9Af0=;
        b=HFx70odiTXNpMj/lHZIhlxGGjyXwSuN3iXJaZuO0ch4YXc+vGVqs+Rdsic9VRbDFa/
         zztU1vHXgD80zsTj3bb3tgNwOp1qbLYK6At7iZV1ltOC8otEUeZmLhwcj0kIgNOyuW78
         qnvUhXqlLl5hfrWOnvA+jyfQkBYoTsp5+uDEEFTT0kfycxXpC+v4ahl/+1elPfYNe1rR
         Z3p4D0WTLaINPK5rKKG9V5druo1Jzz1SpsPdu8Pem8ulFWpbhjkiMrqhc34oxocMD4Ao
         JVC2CriHOKSeCGIMPwCzG/TwTv/rORPBnQaGG5B2PwfUT1Pp8F+yrIsO/EMDUlnpwKNf
         zt2Q==
X-Forwarded-Encrypted: i=1; AJvYcCWPdUa5+4N/+WaZxq5Kqc6qRj1/AtiXT6awyinz9fus6AS1G3wmyZShgiJaCJ2czqDmGzcEbA/VRzi6/no=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywpu4S/ChcfrsNXLTaGB4lC49yZMVlm2YyvIqy9LzJ/jCUCWBRG
	o1D55I3mpaVLTsn6UPnHmY2tfHEu3rA6SrMf/dEyPDj1dI2IMxztdobW5oX8RfdyzdO1lege3F/
	j3+9rXiToQ1PkJVSP9QJstJoCthLWKMk=
X-Gm-Gg: ASbGncvn6/q50GY+Sk85ybf5EZmxoyu1+6Le9QM0Sy7+6o9NUv4+YExBFdsbDLRFUI9
	dxuGiPVwvhUk8KIBG95XLjLPqZANHQ3uGsHCsuDot+iiM8La3sk8vE1lOjxY+hErVreZK5peULX
	ypdq4bClnv9DIaFqc5q6g86KDK3BpP051l7iN0W6whkGi2IxkkeANteK3EqUD0VO2CjK6pwdc+G
	3dX+7OlT4uKHrQg/o+7rT3dwwNQZmfD3P2RKE6sLxkfEBLu79Qqq0sbTWKhyE7iMPAVYmcXi2k2
	JNoBNq4x4Q9sdBQ=
X-Google-Smtp-Source: AGHT+IHLrHOzvNAokMB1WbxB3gJAY2GfR94UQgKc5aQuYuGXPTzrOGeNvX8ZsL33JxhJZTCgkZ3zL0L7/ZwqDEsTyqc=
X-Received: by 2002:a05:690c:3606:b0:786:59d3:49cc with SMTP id
 00721157ae682-78659d36afdmr72041127b3.7.1762136910786; Sun, 02 Nov 2025
 18:28:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251029045327.2035337-1-alistair.francis@wdc.com>
 <9b8d8baf-022a-49a9-b8b9-db699125e064@suse.de> <CAKmqyKMH4dNGP0aW1ufkHKXuzNGjixAQrMwFd0QjCy9UT00KTw@mail.gmail.com>
 <72c291ff-8295-4bef-b368-68c24aa983ec@suse.de>
In-Reply-To: <72c291ff-8295-4bef-b368-68c24aa983ec@suse.de>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 3 Nov 2025 12:28:03 +1000
X-Gm-Features: AWmQ_bm0033VA11fAAliIqWqNlgaySqgCy5jRslUcbH5deTIdxZpTm8NuB4pXQU
Message-ID: <CAKmqyKN=XmcsAh2M_ocpbZAWKf5OuK0YvTLE_0hb1QpMhw+pqQ@mail.gmail.com>
Subject: Re: [PATCH] nvmet-auth: update sc_c in target host hash calculation
To: Hannes Reinecke <hare@suse.de>
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me, 
	kch@nvidia.com, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 29, 2025 at 9:33=E2=80=AFPM Hannes Reinecke <hare@suse.de> wrot=
e:
>
> On 10/29/25 12:20, Alistair Francis wrote:
> > On Wed, Oct 29, 2025 at 6:10=E2=80=AFPM Hannes Reinecke <hare@suse.de> =
wrote:
> >>
> >> On 10/29/25 05:53, alistair23@gmail.com wrote:
> >>> From: Alistair Francis <alistair.francis@wdc.com>
> >>>
> >>> Commit 7e091add9c43 "nvme-auth: update sc_c in host response" added
> >>> the sc_c variable to the dhchap queue context structure which is
> >>> appropriately set during negotiate and then used in the host response=
.
> >>>
> >>> This breaks secure concat connections with a Linux target as the targ=
et
> >>> code wasn't updated at the same time. This patch fixes this by adding=
 a
> >>> new sc_c variable to the host hash calculations.
> >>>
> >>> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> >>> ---
> >>>    drivers/nvme/host/auth.c               | 1 +
> >>>    drivers/nvme/target/auth.c             | 3 ++-
> >>>    drivers/nvme/target/fabrics-cmd-auth.c | 1 +
> >>>    drivers/nvme/target/nvmet.h            | 1 +
> >>>    4 files changed, 5 insertions(+), 1 deletion(-)
> >>>
> >> I've already send a similar patch for this, which actually should
> >> already have been merged.
> >> Can you check if that works for you?
> >
> > I checked master when I sent this and there was nothing applied. Is it
> > in a different tree?
> >
>
> https://lore.kernel.org/linux-nvme/aPl4-6WQ940kUso7@kbusch-mbp/T/#t

Thanks.

Your patch is now in master, but doesn't fix the issue for me. I still
get failures with a secure concat connection.

My patch (rebased on top of yours) fixes the issue for me

Alistair

>
> Cheers,
>
> Hannes
> --
> Dr. Hannes Reinecke                  Kernel Storage Architect
> hare@suse.de                                +49 911 74053 688
> SUSE Software Solutions GmbH, Frankenstr. 146, 90461 N=C3=BCrnberg
> HRB 36809 (AG N=C3=BCrnberg), GF: I. Totev, A. McDonald, W. Knoblich

