Return-Path: <linux-kernel+bounces-799541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 03A5AB42D59
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 01:26:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE0645647CB
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 23:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B49B2ED85D;
	Wed,  3 Sep 2025 23:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="U9zVtug/"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 071ED2D24A4
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 23:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756941965; cv=none; b=VH4ktMzJBwKceM37uwiQS0xCf1pfGFgYnhiTPLtQKA2Zwic2tEZea1fk+TKxQUN5SQBHjTTkuDbWXkrpbuazzxYt7padlk5/1dIhzIWSW9btgHIO8nuiLtGg+PKghCJF2f1nh/Q15eQ6P6DgtIAO28NsdNojes6MlfAzMrBfksc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756941965; c=relaxed/simple;
	bh=CZCxyVRjGmIgbC2+w/rDZBnmRaashl0wu/5ho5DdFng=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d4fdRBM8UEVLUsnrEKqXiOfqN8AhdJgU95Kn7TUffBDIKk0a1sV7DNpUgDI01iJ9euyTzdCkhGqWlRsW3EuToEK5fHtIy2Lff1opXGF+Lr8ALqLsnZzbCAc3x5Xl+Ks52LbYIEOSoMmq8to3A+bq8ognkXZLc3+fna/rvSLALkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com; spf=pass smtp.mailfrom=arista.com; dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b=U9zVtug/; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b4df220483fso246967a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 16:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1756941962; x=1757546762; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IwdklP4KWlGIE1TPiux2aozGiq8ju61lCzTwNSsrvjg=;
        b=U9zVtug/jre9t4P+HI57eB/Y5TQ3FV2YwNCqf4uR6NTFDvTWr/FRp1AU8bSVozEx9i
         VdiShPpiZOapHbMQ4W9DG+SLiXqrxqgWqRxhfwWbEgTz10Ibykga4ukr49SLpa4j5iA7
         DOAWJtHYNWETXVYgankR6I/gXHONafSleh2zD2LV4wSs8QqI4+Fj8sXR0/eyvacL0Hdh
         t25yUd0QBEmIKIzVd1eDuCBypwCBQ/lnBVVIMqX/OO4bc9JUtaOeO02szBhN8RnrV/Nd
         8VlGETw2znPMOwv9gBjvgMCUGhG0FcOiQI+b9XE+VBd7pM/Eqrkao2t0nooCgt1fAC1X
         KLEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756941962; x=1757546762;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IwdklP4KWlGIE1TPiux2aozGiq8ju61lCzTwNSsrvjg=;
        b=B2im7lNIAFUMwlgfNZ/qhuHcedGO2IgBIGy25Lb/bLEnUW2IQT4chFLuy8Ys57+FPs
         yzPpiIBQY5/dwg+ali2o+6r+StHjLQgdHzMANtOECnffKctPcsA4qJJS2Fv5SjYXrwiN
         MJT9xt4y5vTz0WBg/Kw6fw8e+jhy3Tcb/IR3ftf959vRMr03WnYx+H2t0ZI4ZAx6twKC
         yDvmw0rSFTAwQp9hQw2kDP4UWo2ks02Er9Gl7RwZSZLL+cxLglCRIWmcEvWTmx8Zu/uR
         jA/+/UJeMxl1Nft33IR3GbtHlB7ycUyhk1kwmk5uK10WlEZK3w1IgbJpXiwKp5Utmol+
         8dfQ==
X-Forwarded-Encrypted: i=1; AJvYcCXEzBhHypkpaVZqtDNpEHRPWYT+iipFtyGlZRWAIIE/X1z/4+/Ak1TUUMJkgT1Z0nsoPG9kao+HJDY/dXY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvxQ/4KcvnSpN3YvS8rgOi9L5trX6Xz6sJxUoUM6cwTTz1NNyw
	Ggdy0lXVlXi52+THWoN99WDQrsBw8wrAIIHxVO7eDPN0/Z1774777zlwiTV+yIHv+tAVfx7+Nqy
	2/FWZyc0bJcgu6SRiDC4XcoRdLahqYHXk23In+8/M
X-Gm-Gg: ASbGncuTwvU6FTtr5mMDkMiWKf+G6Y7kAkwJkbKkEcPUnk2roFKzlT3DpmvZs0ELxF1
	jDk8xqU4K4pMbiZVJd70dxPlooIMy/b02UkC4vbROK1vlM93yCAAlWV2K0J/aze+v1Rp3/2KqqI
	K28PeZ4LNsfdv/dPp1FUTnR3Ns6ebUPlnscj2C2SeiaNBHWW7BotTKWW/EIqFQNlOJqXkGPOCVl
	iy7Xhr8NN64xkPvinuE+tLpttiFB3yIJwnqgaeRPGNztSyLPXpgQLNZ5jjbnS57eZlHzxpMgcBf
	/122aTVQqraIl+iKHO3y8mN+bCfwOM4L
X-Google-Smtp-Source: AGHT+IEJt+Bc66o4PxoYoI6kkp3fEpqoU2LXdQUNHT9yM38QSK2XD/eq/9C2pWmpWi3fCMgYVO3TS9qXhaYKQ6c9OMo=
X-Received: by 2002:a17:902:ce02:b0:246:a42b:a31d with SMTP id
 d9443c01a7336-24944ad758dmr206762635ad.44.1756941962239; Wed, 03 Sep 2025
 16:26:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250903-b4-tcp-ao-md5-rst-finwait2-v4-0-ef3a9eec3ef3@arista.com>
 <20250903-b4-tcp-ao-md5-rst-finwait2-v4-1-ef3a9eec3ef3@arista.com> <CAAVpQUD1mPPFHx+7eVEVJq1xz1S4PJVDcN6FDsVxPy=ehNiV7w@mail.gmail.com>
In-Reply-To: <CAAVpQUD1mPPFHx+7eVEVJq1xz1S4PJVDcN6FDsVxPy=ehNiV7w@mail.gmail.com>
From: Dmitry Safonov <dima@arista.com>
Date: Thu, 4 Sep 2025 00:25:50 +0100
X-Gm-Features: Ac12FXz2-8v5QXc2t5UnQHmCGXmAEH983k_rFviNYPRTr7vbSyRsyg7wpi9XgJE
Message-ID: <CAGrbwDRXcVM08a2=Vph1Bf4uq7+aFe7kBhzs+oA6zRTd8ZXeRA@mail.gmail.com>
Subject: Re: [PATCH net-next v4 1/2] tcp: Destroy TCP-AO, TCP-MD5 keys in .sk_destruct()
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Eric Dumazet <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>, 
	"David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Bob Gilligan <gilligan@arista.com>, Salam Noureddine <noureddine@arista.com>, 
	Dmitry Safonov <0x7f454c46@gmail.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 3, 2025 at 10:18=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.co=
m> wrote:
>
> On Wed, Sep 3, 2025 at 1:30=E2=80=AFPM Dmitry Safonov via B4 Relay
> <devnull+dima.arista.com@kernel.org> wrote:
[..]
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
> > +               rcu_assign_pointer(tp->md5sig_info, NULL);
> > +               call_rcu(&md5sig->rcu, tcp_md5sig_info_free_rcu);
> > +       }
> > +}
> > +EXPORT_SYMBOL_GPL(tcp_md5_destruct_sock);
>
> EXPORT_IPV6_MOD_GPL() is preferable.

Thanks, will use that in v5. I did remember that ipv6 may be compiled
as a module, but forgotten that there is a special helper.

>
> Other than that
>
> Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
>
> Thanks!

Thanks,
            Dmitry

