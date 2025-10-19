Return-Path: <linux-kernel+bounces-859820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19C0BBEEAEE
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 19:43:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AA521893122
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 17:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1429121CC47;
	Sun, 19 Oct 2025 17:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0BPkeeK2"
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3771F0E32
	for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 17:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760895822; cv=none; b=Czsqy6oLQaghzi19xzbyQ9IHSDMwSg4Za659BugX24OwWpXc3XRGcFawQqaPZeJIeJcOM+fYPbzfFtkjzWZPYuLm4WmIUgON+S01eNVRV2CeGmg+JFZgwE5xnQWbhY1OXX8LlazTWaBUE+OqOzTT6DM5y9+Q/JMWfowjrvoD2bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760895822; c=relaxed/simple;
	bh=NBxTjOq1rphtkq9ZGwMMLSzy8hPiIAv5nUCpEuG+srQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uH/4N+FyCVhV/DCcWzs+hECk7P8fKHdeTpRFSPGZlPDVz1Ow3983wWMXSb8f+Huzt+VGDLx6xt3epgyo7olVr25ddVU8/sJFANwtqkdLmBQcv+tqeGQPuQ0kE/HgGkq11yO3deGGpDRMhUqZWtH1KiYIBfWFDUTLwcetR+JhLQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0BPkeeK2; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-87c1f3f4373so72154566d6.2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 10:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760895820; x=1761500620; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uC2oktoAuA/UwIup+5BKUv+Ff5r+vqavOtTCSaxD56c=;
        b=0BPkeeK25oyp62dUj9ZKIbD/BlSl3HqyNZDikQPepW28DBYQSajV4qPAXztFpg2zrs
         0xobVOOSzHdM8aUMsgInFSPboyg/mZEQe+WL1B47lLFrQfRwLtt2t8s58B0XtKNEAfIv
         WsY5Ay/XPE8N5PNAwfpPHSiwa1g7pXnqlIX8lMVFfQgF9e1VYJIdH+zDCGA7c3IC0Zmj
         YNKWtDpY1NMtwfEjTARf6lcJJdT/qEUItlBTXmOMxavFZuCNSecVwOwS2veiEijRLutI
         3yTMx9JxSovcJTqsuXQ7Fc0BEIzRCfHn4Ucak1xVnGhAhPLLob0oimUz+u9/HA+4Tsox
         10cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760895820; x=1761500620;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uC2oktoAuA/UwIup+5BKUv+Ff5r+vqavOtTCSaxD56c=;
        b=gpog8omD6ftoFvPdKOnVS0AOdNBuHBLUsKglL8WwX1KfBV2IEv0zhSGwyZZU8ulfFP
         qR4VLOI3sIPiIcLeyxcafHLwJuqL7+At3u6ey9zYd/nTs83GRhaOzuALmXEvu1O855vg
         oYYL+8U18SofxpR8QiLaCJqRekUE8+e64DWeyaVGkOZfeFij56sq5gTZE0UI75gJ4w14
         0YGscb8P/s6mBeQxP7UdjzKrAgQVgMOfjkG4LvLxfPKA2KVSXAPwIY61XJ2JuNMhlyuM
         +vwFFrgo4foG5AAle8iEPcugrVRGvlYeSFAUuTj6907Chww0sOY1aYFZLf0Re0mLEsUy
         So8w==
X-Forwarded-Encrypted: i=1; AJvYcCWnqx1MYeDk584xQEdedC9UQm9Mpv6J9+P3/9a659+zdwvsDASgzyBj6jZp10Qmi0lVYkJQGe5xN5niZrQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOWWgU/nqQ/AVgjdkZzLhhv0ZSMt7C7rIwnWoxvR+rWiMkGVNU
	BL7e9V8i+/HW26Xkw6SAb8pXboKjYAKzaiZQaIW/BJ/avKRBtoHJl2b2A+F6UjubogwcJhRDNPT
	8v/acFRBkowh7EY1ePwZYa7TEhaVVi1eibMJJ2t8f
X-Gm-Gg: ASbGncv5qwKYBwoqBtrx47rXUhLCQSrL4+GNYi5Y2eaNyNfLtJ/QCRI/FxCQVxgdrQ5
	OWDsudVkSQMACaD3eJwSvVozrh+BUtiXTeG24R2reciZuZbqQ7BEZ5fcCOEMKmPEaM5gXTsH5P3
	2d2BbMBSIHVEcGn9CbWvyOWOQ3e6ZYWKjhbpm5PPcXMo52rWuq/QKrg382E+v0KxQubqQG+3whK
	icJFxBGXdBFYRs224vE6uYIQWhPLJjDrhZlW+uYYG+m8IeDzDJFwcQm5DQL
X-Google-Smtp-Source: AGHT+IFsVI8ca5DhUITgYh4VP54SltgZVBPy9yV+UacuNN8tlTVmEdOFLjduDw/AeORei3lobDwst5nXoKGw8M1vKcQ=
X-Received: by 2002:a05:622a:1482:b0:4e8:99f5:e331 with SMTP id
 d75a77b69052e-4e89d3891a8mr126498661cf.60.1760895819282; Sun, 19 Oct 2025
 10:43:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251019170016.138561-1-peng.yu@alibaba-inc.com>
In-Reply-To: <20251019170016.138561-1-peng.yu@alibaba-inc.com>
From: Eric Dumazet <edumazet@google.com>
Date: Sun, 19 Oct 2025 10:43:28 -0700
X-Gm-Features: AS18NWAmmbau-vvPnXqP2Xed52k2q_aefTZRH7y6JzClnIDf5qiToP7YQGMZXQ4
Message-ID: <CANn89iLsDDQuuQF2i73_-HaHMUwd80Q_ePcoQRy_8GxY2N4eMQ@mail.gmail.com>
Subject: Re: [PATCH] net: set is_cwnd_limited when the small queue check fails
To: Peng Yu <yupeng0921@gmail.com>
Cc: ncardwell@google.com, kuniyu@google.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Peng Yu <peng.yu@alibaba-inc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 19, 2025 at 10:00=E2=80=AFAM Peng Yu <yupeng0921@gmail.com> wro=
te:
>
> The limit of the small queue check is calculated from the pacing rate,
> the pacing rate is calculated from the cwnd. If the cwnd is small,
> the small queue check may fail.
> When the samll queue check fails, the tcp layer will send less
> packages, then the tcp_is_cwnd_limited would alreays return false,
> then the cwnd would have no chance to get updated.
> The cwnd has no chance to get updated, it keeps small, then the pacing
> rate keeps small, and the limit of the small queue check keeps small,
> then the small queue check would always fail.
> It is a kind of dead lock, when a tcp flow comes into this situation,
> it's throughput would be very small, obviously less then the correct
> throughput it should have.
> We set is_cwnd_limited to true when the small queue check fails, then
> the cwnd would have a chance to get updated, then we can break this
> deadlock.
>
> Below ss output shows this issue:
>
> skmem:(r0,rb131072,
> t7712, <------------------------------ wmem_alloc =3D 7712
> tb243712,f2128,w219056,o0,bl0,d0)
> ts sack cubic wscale:7,10 rto:224 rtt:23.364/0.019 ato:40 mss:1448
> pmtu:8500 rcvmss:536 advmss:8448
> cwnd:28 <------------------------------ cwnd=3D28
> bytes_sent:2166208 bytes_acked:2148832 bytes_received:37
> segs_out:1497 segs_in:751 data_segs_out:1496 data_segs_in:1
> send 13882554bps lastsnd:7 lastrcv:2992 lastack:7
> pacing_rate 27764216bps <--------------------- pacing_rate=3D27764216bps
> delivery_rate 5786688bps delivered:1485 busy:2991ms unacked:12
> rcv_space:57088 rcv_ssthresh:57088 notsent:188240
> minrtt:23.319 snd_wnd:57088
>
> limit=3D(27764216 / 8) / 1024 =3D 3389 < 7712
> So the samll queue check fails. When it happens, the throughput is
> obviously less than the normal situation.
>
> By setting the tcp_is_cwnd_limited to true when the small queue check
> failed, we can avoid this issue, the cwnd could increase to a reasonalbe
> size, in my test environment, it is about 4000. Then the small queue
> check won't fail.


>
> Signed-off-by: Peng Yu <peng.yu@alibaba-inc.com>
> ---
>  net/ipv4/tcp_output.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> index b94efb3050d2..8c70acf3a060 100644
> --- a/net/ipv4/tcp_output.c
> +++ b/net/ipv4/tcp_output.c
> @@ -2985,8 +2985,10 @@ static bool tcp_write_xmit(struct sock *sk, unsign=
ed int mss_now, int nonagle,
>                     unlikely(tso_fragment(sk, skb, limit, mss_now, gfp)))
>                         break;
>
> -               if (tcp_small_queue_check(sk, skb, 0))
> +               if (tcp_small_queue_check(sk, skb, 0)) {
> +                       is_cwnd_limited =3D true;
>                         break;
> +               }
>
>                 /* Argh, we hit an empty skb(), presumably a thread
>                  * is sleeping in sendmsg()/sk_stream_wait_memory().
> --
> 2.47.3

Sorry this makes no sense to me.  CWND_LIMITED should not be hijacked.

Something else is preventing your flows to get to nominal speed,
because we have not seen anything like that.

It is probably a driver issue or a receive side issue : Instead of
trying to work around the issue, please root cause it.

