Return-Path: <linux-kernel+bounces-867650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 98814C0332D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 21:37:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2E534501883
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 19:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFF1234D4C1;
	Thu, 23 Oct 2025 19:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hmXuKXx5"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD412264A0
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 19:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761248260; cv=none; b=fGxhXQvtGZfx7aiwuADdTOGmRyh+GrYzZ9CuvjIuDZ0EU/hn2d/aCMXwiRSMPU3RMJYKlQ/sKvT5pJzuaNuZMSQ+bo/xJbf8gq+KHNZXCSpdVIDsYfYeNBSl5tUZcnXbodJzSHj+g7RVJQDyUJIR6D+HG4eKdOEg1bL5atAsgx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761248260; c=relaxed/simple;
	bh=lSgu3nilc+FoS0eOXBUtZUH7bFANmrn+EnLRvkUufcI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A2aVdXyuFGiRzhLZUu04YSyPj7KyQld4tKF2DdqtVnv5NukSy84qm0lHtT3KPS0lRiPslXJvqlq5US0Sqy1r/7ou1GD60vf8GOZOU34yroUhyYDtHHwjPDsQgfyq5tcM+7aM0Dr49xjkElIRbTH94mdhYJmMsxs25ngUkbT1UxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hmXuKXx5; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b4fb8d3a2dbso824425a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 12:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761248258; x=1761853058; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WZ1LxDTD94mTUxZEgC//vZy3WRPH3SzHMiLz9if+iA8=;
        b=hmXuKXx5al7xrzBvjqvu5Vq5PUL7Y1ca02dPCo5sQwQVn8JnUnkHo1q7mr8qJYo6JX
         by2pqnd+8IKUdczE6QH2x/DgzVbHLfMcunK/Fr2u0nw990gg5X/qBUYnoDciAkoISRP1
         PflhUGwGGwFUcSyuudSUAuMYVNH+24YlW1JjsaTMfu+izVm/C7IyxwAbdYsvai9nzS4n
         YtPjO946wQwnQ31CIrg9DwN72XmNRHuGVMi8ZfH5btetFNgtbPJoMt0rJY93keqJi6Ec
         ZzWI2HN00BlHrsmZv2KVGN3Xj5L0UG2PJYho5EinI6noFhhlHR0npX3UGeG/Zj25Y0xt
         wn/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761248258; x=1761853058;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WZ1LxDTD94mTUxZEgC//vZy3WRPH3SzHMiLz9if+iA8=;
        b=t8RPyWEi9H7NAvybEdcFg+jsNc1hOhYGGqroAeCQEzJpavrHPEao3+dYRnhyPkILSR
         wN4Z1Nxz7jT1Ia0UyB2Qe6ob/7+TwRQhqQYpr+WKSF0SWNRegigMRs2/5pAF85R8j6T7
         D+hsQgQIbRajJc/IMqm1aFSjLE2rUF+pvwuVG4PJDQtqybSA8xuiJCewVnzcDu9sKB4X
         PjNxPyNOVg7aaK30/OshIo/S1+nD42nzrgeHjwaOhYuVFzKz00IpoPEChFqmAWQvnGZ3
         xeAmAtFgYHOH2r3A5yMm0cz96IeXKwvwbyxyxX9zKvtZ3VQPsRkvcEMjUpreZ0qMP0j0
         PFPQ==
X-Forwarded-Encrypted: i=1; AJvYcCXfmRkXhSxJy/3Em0hcFidb3ns1jgZvrdlQFUKLAE35QL5FLuun2rXcH4cl5KRq9BcjE1UiQ6Cgb9yWOD8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzpb5scYBcQX+c6D/YCIdFawf/K917cgjhobI58xGcbcUSZv5LL
	uMN7cmgKD6VmQpuNNu5Z3I6ZFOntXwwnEsF19XOxZTAtq3jaKb+ijJbVrrNmrUWEElhtVXP4lFv
	nthtgKQ7oCX9tq/nQdnD0fctfNRkX/2NCe6NN8IpD
X-Gm-Gg: ASbGncv5V7zuGL6NqK839BftOV49ea8QHThg6j+d8GlNrJllcIzTY1K2yZr8KBIhxpu
	b3ihuNwC7Jg/4h9T9vKHnJdWW6Nbz8AElQD38yhmI7x+Bd3BDbU73QE4iSzBVramWPK2uudtC1O
	RueMXLjclA91lFfdemdvt8HDsOZToHWB3oinOoj53txFT9OR3mq6Gxgf4PctwTPYMHbeOaq6YCx
	CqVcQX7lzXGGQZ4mUHY8jz10IFAJw6MdHgXOlfBsomWKAq78dY8MQ7VJI3pmvz3WXS7YHl/cD0z
	SBFhs2nt7H6H0UJoWZblop97CQ==
X-Google-Smtp-Source: AGHT+IEdJA3haUsbTz+16YzBdMM68eI0eHjD98BC0sTPMoAeLto2g3VcHvdassvHL9jiwGwrO33J0kGL9Kn2MLkP/pc=
X-Received: by 2002:a17:902:e88e:b0:290:9332:eed1 with SMTP id
 d9443c01a7336-290ca12153emr299361315ad.34.1761248257584; Thu, 23 Oct 2025
 12:37:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANn89i+0bmXUz=T+cGPexiMpS-epfhbz+Ds84A+Lewrj880TBg@mail.gmail.com>
 <20251023144805.1979484-1-wokezhong@tencent.com> <20251023144805.1979484-3-wokezhong@tencent.com>
In-Reply-To: <20251023144805.1979484-3-wokezhong@tencent.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 23 Oct 2025 12:37:26 -0700
X-Gm-Features: AS18NWCNBUrdZzai3h5f3kN93-JxNAspDqdkgoGxQ_vgOOCGtaLuec2K14EBHaY
Message-ID: <CAAVpQUC7qk_1Dj+fuC-wfesHkUMQhNoVdUY9GXo=vYzmJJ1WdA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] net/tcp: add packetdrill test for FIN-WAIT-1
 zero-window fix
To: HaiYang Zhong <wokezhong@gmail.com>
Cc: edumazet@google.com, ncardwell@google.com, davem@davemloft.net, 
	dsahern@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, wokezhong@tencent.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 23, 2025 at 7:48=E2=80=AFAM HaiYang Zhong <wokezhong@gmail.com>=
 wrote:
>
> Add packetdrill test to reproduce and verify the permanent FIN-WAIT-1
> state issue when continuous zero window packets are received.
>
> The test simulates:
> - TCP connection establishment
> - Peer advertising zero window
> - Local FIN blocked in send buffer due to zero window
> - Continuous zero window ACKs from peer
> - Verification of connection timeout (after fix)
>
> Signed-off-by: HaiYang Zhong <wokezhong@tencent.com>
> ---
>  .../net/tcp_fin_wait1_zero_window.pkt         | 58 +++++++++++++++++++
>  1 file changed, 58 insertions(+)
>  create mode 100644 tools/testing/selftests/net/tcp_fin_wait1_zero_window=
.pkt
>
> diff --git a/tools/testing/selftests/net/tcp_fin_wait1_zero_window.pkt b/=
tools/testing/selftests/net/tcp_fin_wait1_zero_window.pkt
> new file mode 100644
> index 000000000000..86ceb95de744
> --- /dev/null
> +++ b/tools/testing/selftests/net/tcp_fin_wait1_zero_window.pkt
> @@ -0,0 +1,58 @@
> +// Test for permanent FIN-WAIT-1 state with continuous zero-window adver=
tisements
> +// Author: HaiYang Zhong <wokezhong@tencent.com>
> +
> +
> +0.000 socket(..., SOCK_STREAM, IPPROTO_TCP) =3D 3
> +0.000 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) =3D 0
> +0.000 bind(3, ..., ...) =3D 0
> +0.000 listen(3, 1) =3D 0
> +
> +0.100 < S 0:0(0) win 65535 <mss 1460>
> +0.100 > S. 0:0(0) ack 1 <mss 1460>
> +0.100 < . 1:1(0) ack 1 win 65535
> +0.100 accept(3, ..., ...) =3D 4
> +
> +// Send data to fill receive window
> +0.200 write(4, ..., 5) =3D 5
> +0.200 > P. 1:6(5) ack 1
> +
> +// Advertise zero-window
> +0.200 < . 1:1(0) ack 6 win 0
> +
> +// Application closes connection, sends FIN (but blocked by zero window)
> +0.200 close(4) =3D 0
> +
> +//Send zero-window probe packet
> ++0.200 > . 5:5(0) ack 1
> ++0.400 > . 5:5(0) ack 1
> ++0.800 > . 5:5(0) ack 1
> ++1.600 > . 5:5(0) ack 1
> ++3.200 > . 5:5(0) ack 1
> ++6.400 > . 5:5(0) ack 1
> ++12.800 > . 5:5(0) ack 1
> +
> +// Continuously sending zero-window ACKs
> +30.000 < . 1:1(0) ack 6 win 0
> +
> +// Key verification points
> +// Without fix: waiting for packet timeout due to timer reset
> +// With fix: this probe is sent as scheduled
> ++22.000~+23.000 > . 5:5(0) ack 1
> +
> +// More zero-window ACKs from peer
> +60.000 < . 1:1(0) ack 6 win 0
> +90.000 < . 1:1(0) ack 6 win 0
> ++16.000~+19.000 > . 5:5(0) ack 1
> +120.000 < . 1:1(0) ack 6 win 0
> +150.000 < . 1:1(0) ack 6 win 0
> +180.000 < . 1:1(0) ack 6 win 0
> +210.000 < . 1:1(0) ack 6 win 0
> ++0.000~+5.000  > . 5:5(0) ack 1
> +240.000 < . 1:1(0) ack 6 win 0
> +270.000 < . 1:1(0) ack 6 win 0
> +300.000 < . 1:1(0) ack 6 win 0
> +330.000 < . 1:1(0) ack 6 win 0
> +360.000 < . 1:1(0) ack 6 win 0
> +
> +// Connection reset after zero-window probe timeout
> ++0.000 > R 6:6(0)

I guess this test will time out if you run via selftest ?

