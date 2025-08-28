Return-Path: <linux-kernel+bounces-790638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 418C4B3AB32
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 22:01:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3825A00982
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 20:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECF7126E6FF;
	Thu, 28 Aug 2025 20:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="cMAPOK/I"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDEDF1DE8BF
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 20:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756411255; cv=none; b=HdcleCZWp9ukEKc4uIxTjFjz2c7qWGaDkCrWQFETgdPz6RRoXX5oamHd1oPXrSbkggX/bxvEBOqwwYpnu5ZFqmWTo/wOlGlxntmvGVFbt78IahJtYnd0I3R84cXuLQ73+rI21DmHWYQJ+cE5Y6BpCy0wp8znR5oOQqDlpFLE1x4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756411255; c=relaxed/simple;
	bh=Vr9F3xqCHEdFR93OX9lFs+rhkiKZsACDOAD+/wgW20g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NEcxn3wWojhQMAiheQKHlkVstQg2IEIyMvmPp5jZY6clutuT0hpUT1AZ+81xW+F4gw0NHvsKTiLJUusnnnqljkuPlqCD14RSuf1XEys0LOF4YEcXJ5Ov/IjeESAsRHPN4kYbRafV0+JMA/lScbb+Yh4L1U3E9jIzNJAi2P6Pnfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com; spf=pass smtp.mailfrom=arista.com; dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b=cMAPOK/I; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b49d98691faso1059403a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 13:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1756411253; x=1757016053; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IiCLpZsdgV8UTOXIWEcrK95LvhsGCYsAuVwLPkl0qrs=;
        b=cMAPOK/Iobps4VDptf4DIbqyG+850F8LA0aG6buS+mVbbzHKwwbEwmDVa3C0pdtffh
         upJQP9x0HNCQgaR6NNKA0aHuAojgT7mdUnRIWeo6Vd65+oh8FRid1xrj3h5biKkLMK/Q
         D/KBdGYxzDekR2AzDnvfJ4JLj8Ja3K+lKw7Wx9BG/zPISdY92TREs+dCjA1TdKMa98YA
         HPhX0yPQJg1YFQ1WeP12qbL9R6GdGzgM6TPwf2g7F2cyQuiMLtVoxwADW7FnP0JEpM2b
         tA2H3g1/eto37CMxyDtPjnkhzzIPWGV2KoqsVR2A2T7aH9MbHMgv/xfl34RW1LjAYj97
         3z5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756411253; x=1757016053;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IiCLpZsdgV8UTOXIWEcrK95LvhsGCYsAuVwLPkl0qrs=;
        b=s26ZkKkBx87w2UnAmGyI9AbtnHYES9DNeOQYbcu2HnehDv/q99cAKzm3NcAa/3ufaD
         dmFogz2r8fkkcCJXvx1/xR8oANHlw4pWcM/qONJMVRdeaCmLD/GyIrEvLVkldrytrv2z
         cuWCc+fTGnO314o4fxfWHcAEjsAnMDlaZzqZJpeQSyDuzvXPWa42eODUzfWX/Di7HR/j
         m33+fvz+UvDFoAQb7iYCMlVIYM77bYahOeJqZnxUyK5VyaK6s8uwyCcUFqIhtI13v60b
         zVxBs9kmXlm3hao20ks7wyQG0LILi4FsQbp8ACjjxacnJtI3bQ2NU0d67A4xGky/6Z6b
         5QPw==
X-Forwarded-Encrypted: i=1; AJvYcCWC0WcH9YGMHm971hypfwglSuUc0tEerFJU7OLN8GjJCVsuN/r9JhUTQx5odt5jSVjQCaNQvKq1KdXNp80=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4SZOqhPE1vUuZWEnku1QMxJ+gFaonBAlNADztZHb1puSD6Ixp
	hjXdYW+TNjXdCoKRR4A0/yfXlZPjGXwP2tDd5yGeDmWH8nn7E1eynRdEe/e84wJvZjtmwgh7Mqc
	5/QoVX697WxQTVgUieOW8NjWdi5BViRcMnYTiDz3w
X-Gm-Gg: ASbGncsg12mjkAp3tIhJaarySsofJQVJmd9pNpkagJxgeURDyDUrVNKsgGfuYMjBNnE
	VGivVIwrWjlRKfDrghn1V17X4MAna3t3RKQxOnP+QgBa84bKnhYtJiCw+iYmDH3pnHytaVT5fOb
	aesXjQ5I8YHKnsdq1MAvFgfOuWEd2ZRaBWKw4ZYwgpHb04bVy8xE2Bi2zjRY6ldADjzjkRQ9gEE
	yJVJxVAe8ORDN0eaHik7FM9P4kPDNSTy5TW5F6IlfPrrjbmuRi20uxGuBgugINRji/VNWgNyypn
	h95iDgvn6lcPz4X0b3YUi0oM9swe3To=
X-Google-Smtp-Source: AGHT+IHKuBy4ggyOLAexkSTeg9GziXa5fhPjZLTY3qpGn4B960J4ESwZLGqV9YNSE2NT1zhvnzleI02bA+lsJkuWC4s=
X-Received: by 2002:a17:90b:510c:b0:327:9373:efa0 with SMTP id
 98e67ed59e1d1-3279373f3bbmr8060389a91.20.1756411253161; Thu, 28 Aug 2025
 13:00:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250828-b4-tcp-ao-md5-rst-finwait2-v2-0-653099bea5c1@arista.com>
 <20250828-b4-tcp-ao-md5-rst-finwait2-v2-1-653099bea5c1@arista.com> <CANn89iKVQ=c8zxm0MqR7ycR1RFbKqObEPEJrpWCfxH4MdVf3Og@mail.gmail.com>
In-Reply-To: <CANn89iKVQ=c8zxm0MqR7ycR1RFbKqObEPEJrpWCfxH4MdVf3Og@mail.gmail.com>
From: Dmitry Safonov <dima@arista.com>
Date: Thu, 28 Aug 2025 21:00:40 +0100
X-Gm-Features: Ac12FXxSJ8PV1qCATI4uR3CcwYQR9VTD3hYNVBiW7TY295QuzPGQNawDD8es3iE
Message-ID: <CAGrbwDT7TfgQsPJh=5TE-4tuxUsn3ft52zninaRnZct+OaoAvQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2 1/2] tcp: Destroy TCP-AO, TCP-MD5 keys in .sk_destruct()
To: Eric Dumazet <edumazet@google.com>
Cc: Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	"David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Bob Gilligan <gilligan@arista.com>, Salam Noureddine <noureddine@arista.com>, 
	Dmitry Safonov <0x7f454c46@gmail.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Eric,

On Thu, Aug 28, 2025 at 8:43=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Thu, Aug 28, 2025 at 1:15=E2=80=AFAM Dmitry Safonov via B4 Relay
> <devnull+dima.arista.com@kernel.org> wrote:
...
> > +void tcp_md5_destruct_sock(struct sock *sk)
> > +{
> > +       struct tcp_sock *tp =3D tcp_sk(sk);
> > +
> > +       if (tp->md5sig_info) {
> > +               struct tcp_md5sig_info *md5sig;
> > +
> > +               md5sig =3D rcu_dereference_protected(tp->md5sig_info, 1=
);
> > +               tcp_clear_md5_list(sk);
> > +               call_rcu(&md5sig->rcu, tcp_md5sig_info_free_rcu);
> > +               rcu_assign_pointer(tp->md5sig_info, NULL);
>
> I would move this line before call_rcu(&md5sig->rcu, tcp_md5sig_info_free=
_rcu),
> otherwise the free could happen before the clear, and an UAF could occur.

Good catch! I'll reorder these in v3 just in case the next patch 2/2
would have to be reverted for any reason.

> It is not absolutely clear if this function runs under rcu_read_lock(),
> and even if it is currently safe, this could change in the future.
>
> Other than that :
>
> Reviewed-by: Eric Dumazet <edumazet@google.com>

Thanks,
            Dmitry

