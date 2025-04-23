Return-Path: <linux-kernel+bounces-616876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C54CA9974F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Apr 2025 19:59:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38DAC3BFF5C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Apr 2025 17:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2609028D836;
	Wed, 23 Apr 2025 17:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HACIZgpw"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE2E10957
	for <linux-kernel@vger.kernel.org>; Wed, 23 Apr 2025 17:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745431173; cv=none; b=c91qb0OuK6wKFCrtkAzQQ5tjbB1MnbFJ3rpk2izqSYsFD/9tXwyYFrh1NfJhJeocU9/y6/uzf7mFiq+CWe6TfXOwj4M29qF8dzWVHwVxIPEZ1DWp8PBm/3C1XPwhr1SNlksMeeahekCNY6fwtFKXouwarI8SHCLpwlgiku6FGww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745431173; c=relaxed/simple;
	bh=T2TBlvkxpqSt4Yg66wrWZfHI9nHaKVofCMCsYRliPm4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OaLtBzBJWA6iPZE670pJQEHvxbQ1On0BkqF0XbN0CQ/ZqRcwywveZ5XRago3AJ5ON+/WJLcGcoXlHDG4Gx1b3LLc0R9Ei1bOU747uZlCbQVLxtKqsy/qaRbCXWGxCYtwuiO27fyMYv+ck0gm9M3i/Hg9mCQKIgE4UwNaO5xFVO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HACIZgpw; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2264c9d0295so27525ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Apr 2025 10:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745431171; x=1746035971; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+8ET6hBVRzBDqshUdhbgCvSUTaazcby/sOi3F1Bc3pI=;
        b=HACIZgpw4Xflv3W6XmdPwNuTYxQ8zATeYzoR01w5U1QhvU797QxfB3VWNBYsoEXN0D
         r1sBI0OEbn075eeaSweSTK9Kt/MJ+oPdDAesZPl/+gwjrSyjiKHi/louVdIOC2rBhz0F
         gfHVMBUSPw9v6u9oUVGZYXOL2Hsolk65Haz4RZ3eyh8VtpyVn4oN+idH/iRyUan57kOv
         VJ6+rf3ozumb3R4FPyShUVTDwoFxVdmAp+3zSh7bj83RiPJA3ghFhOAXou/grUCVcWQN
         ED6+2Mxhsurs/2rbbxTEY/C3kPb4RP2/y6TjS8R445L88/BoxlCYyj8cauarXMlwAt0F
         s43Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745431171; x=1746035971;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+8ET6hBVRzBDqshUdhbgCvSUTaazcby/sOi3F1Bc3pI=;
        b=omECl59PIlSc4cXsYr8zewMzSFN20WHLtZbbKXnSjrmVnKSoVGH/aOkh0aXNY4jcwd
         2ewnSsp+P7p2jBX3mIdgAHPLiDmuUQYItSD15kkn31ygueUAXg7PeLagntns1eQc3SW0
         nDPEWAtr1js1I2GKUJf+C1+EyRLTi7NNbx6KZU5IM8YLc4uTB7t6/V1gDeF3r+y8OTvA
         9PBTNMqeVW4nZDKbM8W2vr4SELtvEZX75z4gF9nKV0NRJ/BC4bgqeCGsSx5pSrsUvfDs
         XKIV3/c4LG7Y2SfFtucWz5VdfAeyAiPexttyXDst7eP1zC2yY2JUS0zWz2Ynp8Bk52sf
         fs4A==
X-Forwarded-Encrypted: i=1; AJvYcCUwRknAzoBU7w7NAgEwgTu2520kAGji0sPZ0QdrJ+YAzCNaml4yQ68fc2p+KKcerjyHUM6CmSTSTfrFMf8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaPwkdngIwCvbQXS2v5cpLPrc+8wmiRxEdPf3ar2euxVJ8B8LD
	zIMpAWv/bZAnX2KCi+Aix4x6KwPoSXv8Kg5QapIRE/C6wwMW6IBZKNCxTLjmCXAsdRhu309u3Uq
	z3/rH61+m7sgeYcjB7ED8B5kMu7ySR5zkdc57
X-Gm-Gg: ASbGncuhY2mdVgO+yM1XijybT0IUSCxp90VScTr7MxCYejQs6/Gy0pXuijdTCkUJZkk
	WFpEysR+fJrNlQW78Og5vuwcAww1xQ0CMEYMLivARf3iX/zHsB17VoeeNnvP8TGrJv3J2QZALs3
	2ICCwOxO0ost+1iAg2KGKFL/ynqnyi9tNEpfedkPbKtxlYmagXLIGY
X-Google-Smtp-Source: AGHT+IHvMK0SV6VtztVj+YoeYQ5/i4hvqsncQiTOPb2g+BToFdj7TZ78J3grFAhStRy75jc6hEr26BgE749DHVAlZwc=
X-Received: by 2002:a17:902:ce08:b0:21f:3f5c:d24c with SMTP id
 d9443c01a7336-22db2089754mr282595ad.0.1745431171080; Wed, 23 Apr 2025
 10:59:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250423031117.907681-1-almasrymina@google.com>
 <20250423031117.907681-4-almasrymina@google.com> <m2y0vrtd5i.fsf@gmail.com>
In-Reply-To: <m2y0vrtd5i.fsf@gmail.com>
From: Mina Almasry <almasrymina@google.com>
Date: Wed, 23 Apr 2025 10:59:17 -0700
X-Gm-Features: ATxdqUHq-n2Ogx9j37-VJ8KU3c5QgjU5O-8PAbfORQ_YtioEYEuiwEUpYsuISUQ
Message-ID: <CAHS8izNUOO-X0WHFTMd3_yEjCDu4sPYADE1oDEtWTYFNNMB5wQ@mail.gmail.com>
Subject: Re: [PATCH net-next v10 3/9] net: devmem: TCP tx netlink api
To: Donald Hunter <donald.hunter@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, io-uring@vger.kernel.org, 
	virtualization@lists.linux.dev, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Jeroen de Borst <jeroendb@google.com>, 
	Harshitha Ramamurthy <hramamurthy@google.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Willem de Bruijn <willemb@google.com>, Jens Axboe <axboe@kernel.dk>, 
	Pavel Begunkov <asml.silence@gmail.com>, David Ahern <dsahern@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, sdf@fomichev.me, dw@davidwei.uk, 
	Jamal Hadi Salim <jhs@mojatatu.com>, Victor Nogueira <victor@mojatatu.com>, 
	Pedro Tammela <pctammela@mojatatu.com>, Samiullah Khawaja <skhawaja@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 23, 2025 at 5:11=E2=80=AFAM Donald Hunter <donald.hunter@gmail.=
com> wrote:
>
> Mina Almasry <almasrymina@google.com> writes:
>
> > From: Stanislav Fomichev <sdf@fomichev.me>
> >
> > Add bind-tx netlink call to attach dmabuf for TX; queue is not
> > required, only ifindex and dmabuf fd for attachment.
> >
> > Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
> > Signed-off-by: Mina Almasry <almasrymina@google.com>
> >
> > ---
> >
> > v3:
> > - Fix ynl-regen.sh error (Simon).
> >
> > ---
> >  Documentation/netlink/specs/netdev.yaml | 12 ++++++++++++
> >  include/uapi/linux/netdev.h             |  1 +
> >  net/core/netdev-genl-gen.c              | 13 +++++++++++++
> >  net/core/netdev-genl-gen.h              |  1 +
> >  net/core/netdev-genl.c                  |  6 ++++++
> >  tools/include/uapi/linux/netdev.h       |  1 +
> >  6 files changed, 34 insertions(+)
> >
> > diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/ne=
tlink/specs/netdev.yaml
> > index f5e0750ab71db..c0ef6d0d77865 100644
> > --- a/Documentation/netlink/specs/netdev.yaml
> > +++ b/Documentation/netlink/specs/netdev.yaml
> > @@ -743,6 +743,18 @@ operations:
> >              - defer-hard-irqs
> >              - gro-flush-timeout
> >              - irq-suspend-timeout
> > +    -
> > +      name: bind-tx
> > +      doc: Bind dmabuf to netdev for TX
>
> nit: maybe add "for RX" to the bind-rx doc.
>

Thanks, will pull this with the next iteration.

> > +      attribute-set: dmabuf
>
> The bind-rx op has "flags: [ admin-perm ]", should bind-tx also?
>

The omission of admin-perm for tx is intentional.

Binding a dmabuf to an rx queue should and is a privileged operation,
because basically the application doing the binding is taking
ownership of this rx queue. For TX, no such queue ownership is being
taken. The TX binding just gives the netdevice access to the dmabuf
dma-addresses so the netdevice can send from there. It's very similar
to a normal dma-map with normal memory. There is no need for privilege
checks.

--=20
Thanks,
Mina

