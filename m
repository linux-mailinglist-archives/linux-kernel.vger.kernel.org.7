Return-Path: <linux-kernel+bounces-876255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB06FC1B7F5
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 16:00:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BB8D586357
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 13:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8798335471F;
	Wed, 29 Oct 2025 13:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YK0rm6No"
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A9853546FC
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 13:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761745329; cv=none; b=VSGVFHXOvXtMaQZdJNeDt8hPIAbfD3/oLxbr/GAaoiBFfAyLpl70BbS3SywZyV7bOd1hmjLCca336mShEU++dKcrYApIVeRP9UpnwiGTQ1Uf0B2zW7NPy5jB9D64qWdaw32VQfKxrT59fQnwVDmi4Rc/DfB+pilYW+Frs9PV5qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761745329; c=relaxed/simple;
	bh=zbMOoAZx7RYNx6TmQte8UME/DXY5NFfuty2hcf87lug=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uuWWtMTZWS7/z3gUZRebClsJ5jvTEG9HEmxRqQEZQgLzkCHolA+aItNlKegNzp0BWS8eWWYib1M6nh5GFK/CFV2mqbinBmn8iskXP0aqg18O2JmTbvDQ+lz5pqKqpPv20BiyeiWUHyN+jdkQYShe2GJpgs96B2glq/YVN8nn4ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YK0rm6No; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4eccff716f4so349311cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 06:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761745324; x=1762350124; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JR9rxo2u79GKDjnzL8I5WnLfCVj8XfqRuf1RDu5qxZQ=;
        b=YK0rm6No9KRbzuf/URWqKnByLSVQRYT2bE9JhVyRFfQsg3/c1kQwOfw16OsR5C5Rzt
         0FUM9oz5FYLvNjs/0z9hbh/wzNlx3pgVhQyDD305Nr83w0uAneWHAG5eBfNy4PlL4TYo
         M88hIKNbQ7htu1BrRLF0hbyLkQM/upYNZXsRnC8UuI/ZgoIlHZb7JZbcod98HW1x6i6i
         GyV3k1bGV1jyPUOcE5V3o6jdNsT3lqRYur3nZj9j5VSIN9E4baG5bAg4XQ10qsjXsZv4
         mK9OFme9K7P/8eB5+qvn5u6UzzZ2X3jO0icWBNLd/DhCcgBxAyDGyb9PinWDf5fLYNZJ
         36vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761745324; x=1762350124;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JR9rxo2u79GKDjnzL8I5WnLfCVj8XfqRuf1RDu5qxZQ=;
        b=rPEDQN8VD45nMiL8CtYcIwzjJNt4h3XpwyC0uWHmHiOXWZ4oMpM5Bs47isxNUdCpUV
         l7cYZAtP8PW8NGlLib5ZezZ/Uq/N0+8R8skCqclJoMZuKq5mDCDOq4a9vaIf4rC6+g8s
         d4XH1ydgmlGDg0qc8JPIu9550G6FJZHO5GR7PavvQD2Ps2eKp9ZZ2ryCL5Un5mzevr7u
         WE7Z2dFSoMCkWC54EDWfFrLwag+PjQ3o1i2oxSIiKKzNCTmoJXJXwq0puXjECAOAMSCn
         V7ZiV7bWvckE/1gDvn+T1eJ6lUFmE8bF7N6lq1P4mn+QxCs4tGYv4sCI5IKr1wEI/YQv
         SnPg==
X-Forwarded-Encrypted: i=1; AJvYcCWBZf+XmzRZwWMZuBplZfaNxDcZyO0W75h5zoAHh8VfLgpDan2leso/h8meaF1WdRIuezJVQt3S/sl+wJ0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyi7MKnanEhLOYFfnPQXK4wdjTxaa3uyAILtZqUOYF+wECWnfpw
	UJgPaopD0wpfmaTjFIhqXQU0/Szdy/Om4Ba5BEKJnmr1ov3WNzfrcVYUKGfyWOsvjSEk6vJ7JfD
	uMeqY3NeRW7BwmwXzckf09RtLgxLwtG58S9hRO405
X-Gm-Gg: ASbGnctsTQpdAyZ4jB2DLVv/MMQnBCbItQgfURXXd4qgrg+OY1K1qvWHXzbwOjvJ2lj
	JU5SVfO3yL3U+TtCBPyLqKq0htI0gC9OhzuEULF6BnNov9MkM/4AICGL30q9wDrzRdl5o/WBtEb
	5Nn9nwVZFHI4QePYrqE4HEi4U4hwFr5svvE4Zttij5Af/LNDnSGdg9UrE+DfV0sjBQJ8B25G0yJ
	fge4U9F8w/T6G5PVmzLP9GxqcjFw09M7bqCD34muogcoeHtw4KbyPV9cwbCmYSLv8mIOsj0bF/f
	FwdI37JMfojna46Yj+/7sJh3NujUQqYO2sMw9jZefrHJ1gqScQ==
X-Google-Smtp-Source: AGHT+IGOZDQAj/TycBpf1oLko6kxdZqBO2Sk3hT4y5SfEx6uw5mwTcmg8Z7NahmZfp18PPYf1PTqZO5h2SskSugGe9E=
X-Received: by 2002:a05:622a:5a97:b0:4b7:8de4:52d6 with SMTP id
 d75a77b69052e-4ed157cfd4cmr6757411cf.2.1761745324169; Wed, 29 Oct 2025
 06:42:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251028-net-tcp-recv-autotune-v3-0-74b43ba4c84c@kernel.org> <20251028-net-tcp-recv-autotune-v3-2-74b43ba4c84c@kernel.org>
In-Reply-To: <20251028-net-tcp-recv-autotune-v3-2-74b43ba4c84c@kernel.org>
From: Neal Cardwell <ncardwell@google.com>
Date: Wed, 29 Oct 2025 09:41:47 -0400
X-Gm-Features: AWmQ_bkzo-mReBBs6WU6490vxEeqlXsoSqmYJljmFEdRABTFs0x5o3xtvuTei8g
Message-ID: <CADVnQy=NBw3RL+yS4=4AusooKkiMx9Wr+20dj-14fK+jPNw8pw@mail.gmail.com>
Subject: Re: [PATCH net v3 2/4] trace: tcp: add three metrics to trace_tcp_rcvbuf_grow()
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, 
	Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mptcp@lists.linux.dev, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 28, 2025 at 7:58=E2=80=AFAM Matthieu Baerts (NGI0)
<matttbe@kernel.org> wrote:
>
> From: Eric Dumazet <edumazet@google.com>
>
> While chasing yet another receive autotuning bug,
> I found useful to add rcv_ssthresh, window_clamp and rcv_wnd.
>
> tcp_stream 40597 [068]  2172.978198: tcp:tcp_rcvbuf_grow: time=3D50307 rt=
t_us=3D50179 copied=3D77824 inq=3D0 space=3D40960 ooo=3D0 scaling_ratio=3D2=
19 rcvbuf=3D131072 rcv_ssthresh=3D107474 window_clamp=3D112128 rcv_wnd=3D11=
0592
> tcp_stream 40597 [068]  2173.028528: tcp:tcp_rcvbuf_grow: time=3D50336 rt=
t_us=3D50206 copied=3D110592 inq=3D0 space=3D77824 ooo=3D0 scaling_ratio=3D=
219 rcvbuf=3D509444 rcv_ssthresh=3D328658 window_clamp=3D435813 rcv_wnd=3D3=
31776
> tcp_stream 40597 [068]  2173.078830: tcp:tcp_rcvbuf_grow: time=3D50305 rt=
t_us=3D50070 copied=3D270336 inq=3D0 space=3D110592 ooo=3D0 scaling_ratio=
=3D219 rcvbuf=3D509444 rcv_ssthresh=3D431159 window_clamp=3D435813 rcv_wnd=
=3D434176
> tcp_stream 40597 [068]  2173.129137: tcp:tcp_rcvbuf_grow: time=3D50313 rt=
t_us=3D50118 copied=3D434176 inq=3D0 space=3D270336 ooo=3D0 scaling_ratio=
=3D219 rcvbuf=3D2457847 rcv_ssthresh=3D1299511 window_clamp=3D2102611 rcv_w=
nd=3D1302528
> tcp_stream 40597 [068]  2173.179451: tcp:tcp_rcvbuf_grow: time=3D50318 rt=
t_us=3D50041 copied=3D1019904 inq=3D0 space=3D434176 ooo=3D0 scaling_ratio=
=3D219 rcvbuf=3D2457847 rcv_ssthresh=3D2087445 window_clamp=3D2102611 rcv_w=
nd=3D2088960
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---

Reviewed-by: Neal Cardwell <ncardwell@google.com>

Thanks, Eric and Matthieu!

neal

