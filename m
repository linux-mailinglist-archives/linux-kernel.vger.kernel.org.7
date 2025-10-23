Return-Path: <linux-kernel+bounces-867439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CC50C02ACA
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 19:12:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 42766569057
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 17:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7C8E346766;
	Thu, 23 Oct 2025 16:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BAzeb67q"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C93B4345CB1
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 16:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761238577; cv=none; b=noSy5MJ0eam33glFpzD6cMS02BQ4i5UC5m1aYrsauPTuNbBVhBCnewHsMA8s66hd71pVlub99IjayUUSTeTiyJIU5Hw0CIX4nOgjLskz29dKbzSe9qhowZ70hjPxJQledd494lLB/MmqHuSKT76PPx4IrReTOi4N7o9AyI83ocg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761238577; c=relaxed/simple;
	bh=7sTaFAY0i0UpyN/V+3nClAJ0FqgP+WzfxcAytNEo09Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EiqZVK2VWkW37T+rmQfYDHhI0wrlZpba2Sll2+r3K+kIxmHV7JNJdTGbz+hRMRn/fGPJ4LiYEyB+ykqPegtzYXR81pZPf0oYn2Dzsx7vWP1tJDYTJJBemFlksDMaBdV0L5aAtQRhVPsPHwz7DTrBcS5aGf+2eFAHF+hhvdy4ImE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BAzeb67q; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7a26b04bfc8so1209083b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 09:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761238575; x=1761843375; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IyIF9He3AQaNVecfdTsFNoyNYPTFP7D9PI/cuCCk9Bw=;
        b=BAzeb67qK9p+jvgts23+2lIY3fglCm57lUZ2jwpZeCJ7Ccz5n2n2wBheVkShVnjHUD
         1UU6AIG1JRvQEhMCsP8LVLmvjNzWL/cWCwDo9nH5ppGM7FMnYajgkq0jnlAKUyvMiWK1
         cyr+icMPeY4+ilxLLW+ADdkQAj/gSktc21YcZPVDFJNcWpSFONp+hd/ZbwFoALMHUzQ2
         3AVr2PIrGY6Xbj8zjVDdnjhzz4gs55SbodlqQjgak9blbdPTluheimM0Wc4xcvv0/grK
         xLXUYP8DOCYNeg8bXcy8YPF9cvSqIvA2b1EBhvHFjXTKmBpmxdGUYWqJNvDoC0fooPd7
         LDeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761238575; x=1761843375;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IyIF9He3AQaNVecfdTsFNoyNYPTFP7D9PI/cuCCk9Bw=;
        b=rMFBNECVtX1IqWGo8nTDx5TwtONJQZUF8dCd6XaBwfylsND/a6TXDm0PW+Bw5oP1/q
         BLlWvQ9yhdZmGqnSfsB/zoKLj4TGzVLBmFMUxuN0cNWPqXBBonvzZ2xxwpm8zBbUQxug
         lof6WFBob1VuUEUCl73lg6D4k0qmRPHqBapwGBNl0V+n0KcHOQ9fIkEctrWSpS5XivKK
         GdViy4zIoyn6ljAfa+bAQN2421B75QqYQLoZyQwI9CzIVpUD8voKoO+D2OdEqUPfssU1
         Gen5Rc/sJjjktLcZjirfbzA5QoTs8mHvFz4aTb5O90oGiPcZhnhJO2HUWDAcmjEukFRE
         OaFA==
X-Forwarded-Encrypted: i=1; AJvYcCWK6R8K20WCyUIYkL5f4z2rfnTmx5uoO2GUpaNrrAV72K3CqR+ockkF4IRVzJX+dvW3M+wSR5/ploAh6G0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFfFhrjT1vebeappL+1kMFdyPCwuyxxBwbcZp+LKBRf+/rQtnT
	PFDD6gxj3xuHg6Bqo70kb/4WAa/IIEPqIXQU24RNLidQYjkMjOSv6UIM1vNdw6EYHtLwea7Lwhq
	eH4MOqXmEiRQd0TRvNfInVVTUiCWEbWU=
X-Gm-Gg: ASbGncueJY4A6uqm/zzfRtMbIYFxCweqK0Or3RguFjO4tkb8+1UwMyoDyLE257yUhl5
	ZPhc86JfZV0Tocft4XppVq2AAiv/p9H6Yl4+MKgmlXvcccCgpBvPNeIqGnk4VhioDl/bVL/klXi
	E/Vi0F04uGyf8jcL5xWKmuapbyVOrMYg2urITA3Xn8Caip5vorSPQPYTUZZg+oHmB4KPiT/zILS
	1JwEzJXqUn7jIaISyDw2GVDrwQWdNQBKUEwzqHGUyUHyty9yfL4I++5MzId3lXdt7o6Ef0pOrQ/
	TOK/IDVsf6wwz+SGwjNBbS7t5BvGuQ==
X-Google-Smtp-Source: AGHT+IEvRoXJfYMZjLnM9ZP63L/5zp9Rf14uYE21EAJuMeQwO8GZzBEVXuVhiBcrXsZ+KWISLhDWamGqzNn6ZRdV9YM=
X-Received: by 2002:a05:6a00:3a21:b0:781:4ec:4ec4 with SMTP id
 d2e1a72fcca58-7a220d30df8mr31645438b3a.31.1761238575072; Thu, 23 Oct 2025
 09:56:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251023-kmsan_fix-v1-1-d08c18db8877@gmail.com>
In-Reply-To: <20251023-kmsan_fix-v1-1-d08c18db8877@gmail.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Thu, 23 Oct 2025 12:56:02 -0400
X-Gm-Features: AS18NWCOd__EDody6eeBwzndQnzzqlcDk_m68XoL7saCBzCoOClxu7kW1b4-ve8
Message-ID: <CADvbK_c2zqQ76kzPmTovWqpRdN2ad7duHsCs9fW9oVNCLdd-Xw@mail.gmail.com>
Subject: Re: [PATCH] net: sctp: fix KMSAN uninit-value in sctp_inq_pop
To: Ranganath V N <vnranganath.20@gmail.com>
Cc: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, linux-sctp@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	syzbot+d101e12bccd4095460e7@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 23, 2025 at 5:52=E2=80=AFAM Ranganath V N <vnranganath.20@gmail=
.com> wrote:
>
> Fix an issue detected by syzbot:
>
> KMSAN reported an uninitialized-value access in sctp_inq_pop
Hi, Ranganath,

The issue is actually caused by skb trimming via sk_filter() in sctp_rcv().
In the reproducer, skb->len becomes 1 after sk_filter(), which bypassed the
original check:

        if (skb->len < sizeof(struct sctphdr) + sizeof(struct sctp_chunkhdr=
) +
                       skb_transport_offset(skb))

(TBH, I didn't expect it would allow BPF to trim skb in sk_filter().)

To handle this safely, a new check should be performed after sk_filter() li=
ke:

+       if (sk_filter(sk, skb) || skb->len < sizeof(struct sctp_chunkhdr))
                goto discard_release;

Could you please proceed with this change in sctp_rcv()?

Thanks.

