Return-Path: <linux-kernel+bounces-887793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 797BBC391A8
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 05:36:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 202713B9D1F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 04:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04D402D239A;
	Thu,  6 Nov 2025 04:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1oXMhKSV"
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A342C234E
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 04:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762403782; cv=none; b=a6HA3gpiIgibxQsMQZrBdiNKoFRuilY4vFPyJ2dUTj9jtOD4Lsl3lKIar65GyxaZeZTYTmkVx7WWpUS2n4XIsBgK4J50J3K0a1qzZLvngZGmKq+tdtu+hQFOiD8jo88ewfYiokK0uQN1leSU4ssepWVD4V2wxnlLMkkeMLAxU6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762403782; c=relaxed/simple;
	bh=/2n+t6Vpa7SvHTcKa6KgD8GKCvaD25RROF+uWNKWmN4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FJ2hhNhrWSJlOj2fGNrlyakugacpmoU1+axZFwnBBo6z6atTpRZSM6v7xT3gc/TXF2ZaQnL2U/tao04kUV3FxOlj0mfYmUM0Bqm5jrOvAQ89ldNqVfDbZ7SPq8gaI9OUQsOFNIvxOQCevRWV1BcaFbdu59iXJUI9i08eSorihu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1oXMhKSV; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-7864ab69f01so4519787b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 20:36:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762403780; x=1763008580; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1YK4JfnHDyjnwEQ8qIB0Z8YQpFfHTjEnJ5dk27m0AH4=;
        b=1oXMhKSVMR3BAOQHsm1DW8g/fRsTaCxhlqAPgonlMRHQeRnO9fR2dK+Wgw7mIf6D7Q
         XHLV7rY1X5wvzHtEKWxxRHfoGGXQpQGvMH2DmoMBf1/WU2uD3q0ff4Y0T4xuHdbHKkC+
         pO6ZNR5tarSTN0CfTLohZ8Y8c2KCy+O1ps6eRjc3gSEZxz6YWX/qDJxV88GhbQcADDTt
         Qd3D5n9yWHVunO8QbF72qfDB3A0wZcjrA77aU54EpEWaTTeZtVOmHzafs7310j3fTQ35
         Ak6C0HfgBZuyOL7hxLI4bDbMcitRVLGRpaz/53vc4bll8KAEUwo0fqyAd0bd8VMGjeRo
         nmYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762403780; x=1763008580;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1YK4JfnHDyjnwEQ8qIB0Z8YQpFfHTjEnJ5dk27m0AH4=;
        b=OYQBK6NLC6i00TfjE5qvFkOFo5FXuDVe+xvHbbFkewOUw5lBTWfo9vQ7ZiGRWDgA01
         K5fdKxRtorLjf31DLvPA/+4e3RvbGsH22/DMjSM+B67A5zyVrc+0lGFbK9bNLbLYPzjt
         lXY5KwJTE7SmcrS/ds5zEcSxDV/pT8Z6NqJ7V3e3tUjGIPa6Pmsst6094p7ojDLrvgOX
         4TfU93cs2ZwS/9K11S3SLadkTY2Td0ZoQXNXFb1/DDgTc/Pw1yb8uwv2NhuGKeDVPkyw
         /n1jng+EFjMzB9QQ5zgaBbbU1kUbStbH4BCCffywTLZd1X6ECZQ3auX2tjb1WRYU07M3
         amdg==
X-Forwarded-Encrypted: i=1; AJvYcCV07fdOs+oAxSWTitHNDWsA530s8MUlZ+qtB/RiOMFKfsCO6/MpxVgT+LPTLYSChKAuXY8aY8L9100qQWk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4aSYP6+zV4s8snryPpf0QS6pjEA54Bcdg2V0XfpRRJDNytHJl
	cHceATT9Ep+j46kDvykr9oAAUOVVB4+J5KXulInnxN0sILj1sSOq5Qs+Q77zdQdBoAA3nysuZHl
	fq9Ex7LFZWsqdPwxtltJoXNkjLTXF51jiNg4pkswx
X-Gm-Gg: ASbGncuR7XsrBvElXBVPUeHba1EefYaeBmeRYYJMxADgB1y/Y2Sqr7n7voQ/gybP4F1
	4Wn2RSibIP7V/0pENee1EXIlsMi6EnZ4QKdTKEqUtLGExPdaiizZty/xe0rZtystETQHuZjsSGM
	nrT+kOwpmQWHWnGuUz+OnbJXpOIl0XJUEs0rT1NSVPRFsUgmiWrR+i6xRmydu+H7LmzWSZkB6Bw
	wiUxoJL2MO3TFfGuZzgDivg/YtoN4oxPAv5Qo8A9/elcTz+hH8mbsUGMahvYDP7IW38YOVyxaL0
	EPlt/2zLTJH1tGC5gkFd0iUkUj+TGh/MPC2UoEBtkqCLB/uq
X-Google-Smtp-Source: AGHT+IFfP9I7Is4+f1a/rhdeYjMmRB5Lw4aTIrzYViO3gh9Ufezr+ev/MJBSqWrYRNLd2uRQjWPiswqToY9ZDNfkpas=
X-Received: by 2002:a05:690e:1517:b0:63e:1c09:30d5 with SMTP id
 956f58d0204a3-63fd35ac731mr3814025d50.53.1762403779511; Wed, 05 Nov 2025
 20:36:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251105182603.1223474-1-joshwash@google.com> <20251105182603.1223474-4-joshwash@google.com>
 <20251105144519.2729e38b@kernel.org>
In-Reply-To: <20251105144519.2729e38b@kernel.org>
From: Ankit Garg <nktgrg@google.com>
Date: Wed, 5 Nov 2025 20:36:08 -0800
X-Gm-Features: AWmQ_bl4KTTOH_1xMsqeeS7CXSaG0I7SZLg7rsK1iURXEmvcIaQ6Wo9YMb3zO4A
Message-ID: <CAJcM6BFGm0xE+dfbv6_srGFYq2F9YbkRjXiM5sWX22-8JRYyVQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2 3/4] gve: Allow ethtool to configure rx_buf_len
To: Jakub Kicinski <kuba@kernel.org>
Cc: joshwash@google.com, netdev@vger.kernel.org, 
	Harshitha Ramamurthy <hramamurthy@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Willem de Bruijn <willemb@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>, 
	Ziwei Xiao <ziweixiao@google.com>, John Fraker <jfraker@google.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, linux-kernel@vger.kernel.org, 
	Jordan Rhee <jordanrhee@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 5, 2025 at 2:45=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Wed,  5 Nov 2025 10:26:02 -0800 joshwash@google.com wrote:
> > +     if (priv->rx_cfg.packet_buffer_size !=3D SZ_2K) {
> > +             NL_SET_ERR_MSG_FMT_MOD(extack,
> > +                                    "XDP is not supported for Rx buf l=
en %d, only %d supported.\n",
>
> No \n in extack messages, please.

Ack; will fix in v3.

> --
> pw-bot: cr

