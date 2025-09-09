Return-Path: <linux-kernel+bounces-808810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 86F41B50504
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 20:11:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C99A41C63C2C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 18:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA7BC35E4E2;
	Tue,  9 Sep 2025 18:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wHM/WnJu"
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989EE31D37B
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 18:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757441361; cv=none; b=Mpv/OR2js+Yaj9EBRsYSETcwwUlaT8cW8HTRSFS4rCGz/l5sv6a9D/Uo4txS0npttS8ucf2WP9JHL6rT9W0hB2HRKUqcq9puvn3C7fl03vtG0HrNZYydFl0U2WzYA7KG/sH3NiySw93LjtgV4gUl2jeqXrGMnzRB2Q3LSVBSZIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757441361; c=relaxed/simple;
	bh=8lATgt4xq628aM1dc0TtLiWTkPU0OGz9Nq4M1dAe0Ps=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oAxbWQiRAd7SWSfQpZenMEGlyOWRxY7FqGuM0yw/Z5nK1SMFz6Zbz4rqlBM0UlieI+o3qkYwcwzfpgUF/UfL6q3T5vcNvBbQSLgTEzM4dpKld1g5RjTpOqdCa6PDQ0lqC4v8XSj6AjCw634LkUukmODlvqgo8EI9tpinUpU75No=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wHM/WnJu; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4b340966720so40194781cf.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 11:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757441358; x=1758046158; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8lATgt4xq628aM1dc0TtLiWTkPU0OGz9Nq4M1dAe0Ps=;
        b=wHM/WnJuhkgD0Wxpw2zP/TpTTyWZ00nskyUiKjqgEANdF4O7J1oezaxUEHpj+lm5Vq
         j8E5iRhnH5da9tEoPYkKfqWILyO9zALtF0jMAWEJ7O4l7qXnaqNTZmPQtKHbSGrJoygK
         W36SVfZwafBQftbkJjOHmTVJXJhSzypdUmXhXE5XK1cKN05ZeP6IBJrFbCx6YrPzcivS
         h8AaT7npGyj4OrkGiMQdBU5rvQiVSuWL0YrnIK9Q+cAM0rcXjTpv+OSWzjCuNPEwi+hO
         Y6LymwYbEoDw0ZumdaqTtHYrFjyik9BV/8abK3QpYtra0u/1hKjQAy3kLbxq3rho0KnO
         ywQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757441358; x=1758046158;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8lATgt4xq628aM1dc0TtLiWTkPU0OGz9Nq4M1dAe0Ps=;
        b=RW1pP2E+sPVmDfH3j2avgnyi/8f08cckMvqnrufns9MJrFN1XI+GLJck7KVfbD9LXz
         oBk3wVa3hikIaH39ZeiW37uPE70dQjNWW6HTXHm/d9etQy9zZ+/iyvJvXDWDVdCprNwU
         NH0udZZtnNUnSJzaRtTkOlJnUU0V1kozO85iSIfLUBQsas5+7FJA/eTKkL5ea4jbLCsY
         3SvRFHXeNxJqIlNoJ+HeucAuzI98hLyItKGz0q74eFyqnIK8arkgmjCCghgqE1FD7xA1
         VGVxu1DEa25Qc6ZQIjLqA5EF8uvTuuPE+aSjI0xWwEc+wjbjWh5ND/Wj+Hxh9qgB2IyP
         3ivQ==
X-Forwarded-Encrypted: i=1; AJvYcCXNqE6Q5tPfMb858OixiFd1kqfbhtszaPToIHdndGdKXSyQkiLAjFVWLPOBTNwPe2zSwiaAG4DKBuRtfoI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdHl8SEKAFgKfzVTkq2C0O3IHFBAtIN3kdVL5GSoAUSeqbGoFJ
	rC6NRZjU06irnSHsoLGFd4umX7gly9DSDbxMIVGbs8hKWeacIGXojYwdWqf9vXqrDWvhEomKnmI
	A2aae2hTtMTp8Wh497g32O+UuXtdt6p9NOg/D8LHR
X-Gm-Gg: ASbGncu4YJhtq7xuP7mULToBzyzpK+tWSkcjqQh+Lf4Ae4pdGrXwP3gNdqI2IhE5pcf
	/ptf1U0rJX6tCGgRP6YpgKWeO6q9qsDll77t5VqlJbQmiYQqiaiaL+3CvW9wrSzmbUxCFmES3go
	rE/jBGNW5TQFlb4NMJON7SQ55Cb1bjDSnSM2syfjJ6xCyoRZY8hfTJ04nbvpjvS3shvd5fkYKgh
	VyiQJwXu0qSUKPDIayrH3LgGRWYvz0JM4X68tIvEAF+U+0IXHceymJlJ3A=
X-Google-Smtp-Source: AGHT+IEMJVPF0HWMiZZlxTuDQEWujN5ULFYWrs76ILnh137CJMPr/ZtX4aEHVgPrCEVxVSnaiVmMbLpWfGDRRvW1sws=
X-Received: by 2002:ac8:7fc2:0:b0:4b4:9550:47e9 with SMTP id
 d75a77b69052e-4b5f845562cmr138967051cf.67.1757441355166; Tue, 09 Sep 2025
 11:09:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250908175045.3422388-1-sdf@fomichev.me>
In-Reply-To: <20250908175045.3422388-1-sdf@fomichev.me>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 9 Sep 2025 11:09:04 -0700
X-Gm-Features: Ac12FXyKIQhR8dUKP0Ssd5jrrL9lQdx2gpWmqHF7a77lpEUCQ7AbJCKSHD5diPs
Message-ID: <CANn89iK61cuFiPRBiF6owS26Em734ioC35tXGV1RMS_WyCZuTg@mail.gmail.com>
Subject: Re: [PATCH net-next] net: devmem: expose tcp_recvmsg_locked errors
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, ncardwell@google.com, kuniyu@google.com, 
	dsahern@kernel.org, horms@kernel.org, linux-kernel@vger.kernel.org, 
	Mina Almasry <almasrymina@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 8, 2025 at 10:50=E2=80=AFAM Stanislav Fomichev <sdf@fomichev.me=
> wrote:
>
> tcp_recvmsg_dmabuf can export the following errors:
> - EFAULT when linear copy fails
> - ETOOSMALL when cmsg put fails
> - ENODEV if one of the frags is readable
> - ENOMEM on xarray failures
>
> But they are all ignored and replaced by EFAULT in the caller
> (tcp_recvmsg_locked). Expose real error to the userspace to
> add more transparency on what specifically fails.
>
> In non-devmem case (skb_copy_datagram_msg) doing `if (!copied)
> copied=3D-EFAULT` is ok because skb_copy_datagram_msg can return only EFA=
ULT.
>
> Cc: Mina Almasry <almasrymina@google.com>
> Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>

Reviewed-by: Eric Dumazet <edumazet@google.com>

