Return-Path: <linux-kernel+bounces-808352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D7E8B4FEAD
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 16:05:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BACEA1B25077
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 14:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01DE72DF703;
	Tue,  9 Sep 2025 14:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WSxzIayO"
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF7ED231836
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 14:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757426701; cv=none; b=L6O6uNnNyWeU4m8i6uOnSL9bjnWACa7lVE56UvDJKkTF3rAWSobY0ZJ9yf4h1E/4DVMaNTXkOFVYNdJT3BZifdoJNkpHK/118OLfEEFPEZo5exGvMJjVViwYhhnAGrG+6389YH/+bNrcOvrb+RPaNS46wJ1N4FqTKmNFjQre4WA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757426701; c=relaxed/simple;
	bh=2mB0x9tUEIQ5MxbhPdxec5L9gQv7/jA9btpwr+y5T4c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kilml8GQGO5LXwxAMZoii9xexXWQ92z0GnE4AsEFLTFYiUXLQODMgr46LagRRuyeaAvktfp0/SwQYxj0Un7kXbGzF8zEfeKDQMqktnJ+7eIEpxJqtHWbCgmQCe1PFDf+MzV6izll48YoW2nY0T09GHnkI3GPCIIEAYN5bynwJqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WSxzIayO; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4b5ed9d7e96so39066561cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 07:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757426699; x=1758031499; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oe3MS4NWrw5pSnT/UHkzhsJzbgIdx98+KXeSp06EODM=;
        b=WSxzIayO3nGzNEwh4j0iQ5k9SXm9ibsrfH/kPY/2YxCBz0/Hf+rQJmlZAozyIzgF+H
         CCA3OQ75cvinG12oBsQ6f81kdrZ/gKHp6+l4qjOWfS9z2gcBG/L078bBYsBbcLDT+X4Y
         LfpTkau9QZjvzzuNNJvA5hZ3Rp6UMJGSZwamyJ8B+p63uYK4qn9WZ8ZvAhFP3nnryqIi
         hlxiDyeBUA6R6iH6jBbwE530iBHJJXGmUJQhlfaopXbjZ2rMEt2Uwqnj6YB4tauBAd4D
         N02BIO3F/3GMNFGHSkAQ1C/7pZFSN8qa4WKPw06naLQbefGDQCqBZrLCeM8OZpLEol9f
         jxqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757426699; x=1758031499;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oe3MS4NWrw5pSnT/UHkzhsJzbgIdx98+KXeSp06EODM=;
        b=N8GhRd0qM47/g5CbP8UpklAyx53enaI9GXk9LTeY53fgqvBuYvO7mK1E8ClxQ9uwzX
         ouHgv0rOh7LYOd5nreYylRNi/HoSUClUgfsnFX+cBUcJ1UBWmhACYVh772vXISQHG4EJ
         SAbL7eiS8QFRfbqgtY0f0u/IFojll9OjRXNJ/8AlfhE3m6OYpGiGuv+OMxIIEuq2KUd7
         aaLsA7dA1r415fOo2QRRG8HLuAO+W61dcTZMlimWrGpFJCoumLEEJiR6ghStZDu+41oa
         ElcuP2xRwynXG29udfbQiM80IRRdIEao+La5/qlui4bx49byxtjU11b8FyH3E8jlYOyS
         I8Vg==
X-Forwarded-Encrypted: i=1; AJvYcCUxWNxRVQCLVtAnGbfkVV27hgBZY31nDVapTaZnhDLciddlu3YwkAPjI4nVfh3Gk6vj6aJMXZm3OeRo3W4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPRbGD7UlWJ0O9FkR1HJw5uIhvl5kxwVIaIy+3IKiDPZGcf/bN
	xeXzZ6T8ixMTct1Ns4yKdMcgx5z2oshy/7rsr6r0ZnKb8+ahO/eQ4AAMxUxBX6AGSv4CUc7uyTT
	G+m6yjzAee6ShFzRhoQVwi5NwYpHWnWQ6rTNvOGCW
X-Gm-Gg: ASbGncu7dS7UJQqKuz4aIWM7Jj2Rk3R0ZOXy9LE39Y62na8HT5+oWowCIJHScUloQle
	bJKFpPawqULh9ZE+AKlW7ImJJtiVwy0jdyeO3dorPAXLlihpfeME2D5b3v+tGVvp9aXBJaAl69P
	zEde9g7so6gODP8QOM4VS6aO6qcXwzU/hmgIO4FRCbHRXSNABEbhCYxIGXSpIx8basQBPfMNRsx
	yTkTsjJXjs6o0Kxan+rQBr/078ebD9fEDWebOzB8RL1if/i
X-Google-Smtp-Source: AGHT+IEEJs5ATIhb/+q+aJw0Fa+x8WJDtjNWkOr2z/Gq3RIHYs/0Zof9ATeSU5qk43EzE1eKqSxCu5/hSladqbzUtB8=
X-Received: by 2002:a05:622a:1:b0:4b3:4e8e:9e32 with SMTP id
 d75a77b69052e-4b5f8382644mr139813601cf.3.1757426696511; Tue, 09 Sep 2025
 07:04:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909132243.1327024-1-edumazet@google.com> <20250909132936.GA1460@redhat.com>
In-Reply-To: <20250909132936.GA1460@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 9 Sep 2025 07:04:45 -0700
X-Gm-Features: Ac12FXyw6AFwM8QYIvqrqv7UIhW5n9GY5UElWWm_-QForGN8qFcrvQqZyLC1MGI
Message-ID: <CANn89iLyxMYTw6fPzUeVcwLh=4=iPjHZOAjg5BVKeA7Tq06wPg@mail.gmail.com>
Subject: Re: [PATCH] nbd: restrict sockets to TCP and UDP
To: "Richard W.M. Jones" <rjones@redhat.com>
Cc: Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>, 
	linux-kernel <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org, 
	Eric Dumazet <eric.dumazet@gmail.com>, 
	syzbot+e1cd6bd8493060bd701d@syzkaller.appspotmail.com, 
	Mike Christie <mchristi@redhat.com>, Yu Kuai <yukuai1@huaweicloud.com>, 
	linux-block@vger.kernel.org, nbd@other.debian.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 9, 2025 at 6:32=E2=80=AFAM Richard W.M. Jones <rjones@redhat.co=
m> wrote:
>
> On Tue, Sep 09, 2025 at 01:22:43PM +0000, Eric Dumazet wrote:
> > Recently, syzbot started to abuse NBD with all kinds of sockets.
> >
> > Commit cf1b2326b734 ("nbd: verify socket is supported during setup")
> > made sure the socket supported a shutdown() method.
> >
> > Explicitely accept TCP and UNIX stream sockets.
>
> I'm not clear what the actual problem is, but I will say that libnbd &
> nbdkit (which are another NBD client & server, interoperable with the
> kernel) we support and use NBD over vsock[1].  And we could support
> NBD over pretty much any stream socket (Infiniband?) [2].
>
> [1] https://libguestfs.org/nbd_aio_connect_vsock.3.html
>     https://libguestfs.org/nbdkit-service.1.html#AF_VSOCK
> [2] https://libguestfs.org/nbd_connect_socket.3.html
>
> TCP and Unix domain sockets are by far the most widely used, but I
> don't think it's fair to exclude other socket types.

If we have known and supported socket types, please send a patch to add the=
m.

I asked the question last week and got nothing about vsock or other types.

https://lore.kernel.org/netdev/CANn89iLNFHBMTF2Pb6hHERYpuih9eQZb6A12+ndzBcQ=
s_kZoBA@mail.gmail.com/

For sure, we do not want datagram sockets, RAW, netlink, and many others.

