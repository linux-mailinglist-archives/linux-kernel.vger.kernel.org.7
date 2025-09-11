Return-Path: <linux-kernel+bounces-811262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BABDB526A4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 04:44:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75E9F1C80BB9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 02:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A672223323;
	Thu, 11 Sep 2025 02:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XVIJFv55"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B88021D5BC
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 02:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757558671; cv=none; b=WaPH7Irim/1J3yw7pW3F6WFcA4nwVwt4A7kK96tDWvnQIKRjVjNqDoK2ECYNBw7p9UhR5jRs3TukiD+C/Ayr65+q+7Fe/ftpJhk1D96r02arvMgMwiPHEkPWDzz00qIvE3OYZJDOhrYS1oMx3oQ0I/vjDR1xORygudgzJfoqzeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757558671; c=relaxed/simple;
	bh=RH/lKNWxB+jYL9Tts/+toOUQozWus/JszyD4wS05wgY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rjdPyhvugUXOeoSvAA6uOYo7DlpzAFg533h46woVppU5tmWMTKMTj1lhqmBq1balgjI5Z3MUeG4CJ+ix6BNs97uc3g42JGYad0YkZ213DnCwelkIuzvQJYW1i4qCfpXKIOy37qfg93f91fxZtgBM5b2I6sdjogHcODiFm17lHfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XVIJFv55; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-76e6cbb991aso199192b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 19:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757558669; x=1758163469; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rbwrj9MCxkMdgb4OFtqE5AwLZMYq2qhd8B6juxSX8l8=;
        b=XVIJFv551C429ayZ1emor3JSE2hrYLwLSfUS98VacfoqUuCvmUQeJfXFeSrNfMPnGL
         DbUgOSPqNnF8qEIU9a9yELa+w9DXbSQltb45p+7xc9rrtM18Q1N8Jfq6orjkmPPJ/jZf
         2DerwLgVi/ZGH3bebzZpxEXcaqXU/0zBUKPlbu9nAr5RIk71mdoECxRnfJVHG7y2OyLR
         SEtXfU9L11w4iZkxVJnjCldsAG918j23rNEGC5Q6ID7FUMgXJVORh3mo6w7AmEX5Jg1B
         xCrxsPgA8XuNZv7UneE6Jbxye8E2khCfTrtVGXdYwM8cPG5CsUZu/BcX68Swb9jEqHGO
         YR7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757558669; x=1758163469;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rbwrj9MCxkMdgb4OFtqE5AwLZMYq2qhd8B6juxSX8l8=;
        b=MDxceqjW4fN3irsQyZHMU7bRYmhFuvW1wTyey1TA0vUOlxgR+HlbaSbBixJfmTIpkf
         YUavw9wUmiRRCa/JKdLZtYytKPPz6q8BdDES+m635BjEC2lfjkX2FkOmTvAgJ4t/2az7
         1FZ3Vc0QavqzKnhFF7Vajxdu0H/mUOevqd2PBYKSs38uuqNEg2KyExIp5UZ2Z+3G/GzD
         WKpxdyvw160reEAXWsvxAhP0ongr+Mr2YxeHt5qcy1yajBO1uI5wRloTxI7nyU55+T5+
         DEAbrsyyZU0lkTw6QkE8HOuZPjXRTkNNa3vBl4Jp+v5pnj+/qupz8z2evZ5asaUVy4dz
         DUwQ==
X-Forwarded-Encrypted: i=1; AJvYcCUdy3noM9hwdyBdjEQ/1R4Gof9ip34OduQ0TSMqv5QZEOnXj/nBuKJxwszQlm7npmsxf7O2/uf1G+bjlUk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUVAfYaZClMuKKreV1q3vRd5mvalipG6Plx3nSSKe1BQcPA17P
	10RN/HBX1O7PJ+M7XgMvriteJmjZ7d5QzAWQtt4R4xCkAnZzvxlVXztU45/cLkJn3WoK/kUFiuC
	FOhDj/QvvQzA0st7U1Hp83KkVvybH1EogpDRZ/cCE
X-Gm-Gg: ASbGncvQ3bQfqvPX0W+jiBRUpVk/krFdDt+tR8D77hiV5+rLyhFUOiYrhTsYw8ACJz1
	lwFPWCrJEXezlLVT54awfooce8E22iiA0GLh1GLd9l/sCZtyYJzEuW7CGtPcjydM0gDEyWXYlKn
	bTzko5vcxqA1+nLiT6XPsGY2oEpTnxRViE+gBGB2NEeHBY7NHHS0hMQaNi1DQjiKg+OjemoUzt6
	hIn179n0PDh7PTDTN09TQ98OSCDHxMkxbocn2k88lCPMLKfHmxyqwwK8Q==
X-Google-Smtp-Source: AGHT+IHrKxy9g6rBS4o6e1tYQEA5wZNBsvI3ufN2vHAn6MqDAkniz9SsxcxDERH5dE5CRS5+X3a0rZ33jBsa8xcSqkk=
X-Received: by 2002:a17:903:38cf:b0:245:f7f3:6760 with SMTP id
 d9443c01a7336-25175f72ac4mr219280335ad.55.1757558668973; Wed, 10 Sep 2025
 19:44:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250911013052.2233-1-anderson@allelesecurity.com>
In-Reply-To: <20250911013052.2233-1-anderson@allelesecurity.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 10 Sep 2025 19:44:17 -0700
X-Gm-Features: Ac12FXxfHhvQkAVyEXp7XmpClh4AmHOVNOOZbMkwFinVGbnJRgZPSR36H3GxaYg
Message-ID: <CAAVpQUBoCPervZLc+-bWF5+hXX8yj0SwUcU3MiUQ514xi-F6uA@mail.gmail.com>
Subject: Re: [PATCH] net/tcp: Fix a NULL pointer dereference when using TCP-AO
 with TCP_REPAIR.
To: Anderson Nascimento <anderson@allelesecurity.com>
Cc: edumazet@google.com, ncardwell@google.com, davem@davemloft.net, 
	dsahern@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 10, 2025 at 6:32=E2=80=AFPM Anderson Nascimento
<anderson@allelesecurity.com> wrote:
>
> A NULL pointer dereference can occur in tcp_ao_finish_connect() during a =
connect() system call on a socket with a TCP-AO key added and TCP_REPAIR en=
abled.

Thanks for the patch, the change looks good.

Could you wrap the description at 75 columns ?

See this doc for other guidelines:
https://www.kernel.org/doc/html/latest/process/submitting-patches.html#the-=
canonical-patch-format


>
> The function is called with skb being NULL and attempts to dereference it=
 on tcp_hdr(skb)->seq without a prior skb validation.
>
> Fix this by checking if skb is NULL before dereferencing it. If skb is no=
t NULL, the ao->risn is set to tcp_hdr(skb)->seq to keep compatibility with=
 the call made from tcp_rcv_synsent_state_process(). If skb is NULL, ao->ri=
sn is set to 0.
>
> The commentary is taken from bpf_skops_established(), which is also calle=
d in the same flow. Unlike the function being patched, bpf_skops_establishe=
d() validates the skb before dereferencing it.
>
> int main(void){
>         struct sockaddr_in sockaddr;
>         struct tcp_ao_add tcp_ao;
>         int sk;
>         int one =3D 1;
>
>         memset(&sockaddr,'\0',sizeof(sockaddr));
>         memset(&tcp_ao,'\0',sizeof(tcp_ao));
>
>         sk =3D socket(AF_INET, SOCK_STREAM, IPPROTO_TCP);
>
>         sockaddr.sin_family =3D AF_INET;
>
>         memcpy(tcp_ao.alg_name,"cmac(aes128)",12);
>         memcpy(tcp_ao.key,"ABCDEFGHABCDEFGH",16);
>         tcp_ao.keylen =3D 16;
>
>         memcpy(&tcp_ao.addr,&sockaddr,sizeof(sockaddr));
>
>         setsockopt(sk, IPPROTO_TCP, TCP_AO_ADD_KEY, &tcp_ao, sizeof(tcp_a=
o));
>         setsockopt(sk, IPPROTO_TCP, TCP_REPAIR, &one, sizeof(one));
>
>         sockaddr.sin_family =3D AF_INET;
>         sockaddr.sin_port =3D htobe16(123);
>
>         inet_aton("127.0.0.1", &sockaddr.sin_addr);
>
>         connect(sk,(struct sockaddr *)&sockaddr,sizeof(sockaddr));
>
> return 0;
> }
>
> $ gcc tcp-ao-nullptr.c -o tcp-ao-nullptr -Wall
> $ unshare -Urn
> # ip addr add 127.0.0.1 dev lo
> # ./tcp-ao-nullptr
>
> [   72.414850] BUG: kernel NULL pointer dereference, address: 00000000000=
000b6
> [   72.414863] #PF: supervisor read access in kernel mode
> [   72.414869] #PF: error_code(0x0000) - not-present page
> [   72.414873] PGD 116af4067 P4D 116af4067 PUD 117043067 PMD 0
> [   72.414880] Oops: Oops: 0000 [#1] SMP NOPTI
> [   72.414887] CPU: 2 UID: 1000 PID: 1558 Comm: tcp-ao-nullptr Not tainte=
d 6.16.3-200.fc42.x86_64 #1 PREEMPT(lazy)
> [   72.414896] Hardware name: VMware, Inc. VMware Virtual Platform/440BX =
Desktop Reference Platform, BIOS 6.00 11/12/2020
> [   72.414905] RIP: 0010:tcp_ao_finish_connect+0x19/0x60

Full decoded stack trace without timestamps would be nicer.

How to decode stack trace:
cat trace.txt | ./scripts/decode_stacktrace.sh vmlinux

>
> Fixes: 7c2ffaf ("net/tcp: Calculate TCP-AO traffic keys")
> Signed-off-by: Anderson Nascimento <anderson@allelesecurity.com>
> ---
>  net/ipv4/tcp_ao.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/net/ipv4/tcp_ao.c b/net/ipv4/tcp_ao.c
> index bbb8d5f0eae7..abe913de8652 100644
> --- a/net/ipv4/tcp_ao.c
> +++ b/net/ipv4/tcp_ao.c
> @@ -1178,7 +1178,11 @@ void tcp_ao_finish_connect(struct sock *sk, struct=
 sk_buff *skb)
>         if (!ao)
>                 return;
>
> -       WRITE_ONCE(ao->risn, tcp_hdr(skb)->seq);
> +       /* sk with TCP_REPAIR_ON does not have skb in tcp_finish_connect =
*/
> +       if (skb)
> +               WRITE_ONCE(ao->risn, tcp_hdr(skb)->seq);
> +       else
> +               WRITE_ONCE(ao->risn, 0);
>         ao->rcv_sne =3D 0;
>
>         hlist_for_each_entry_rcu(key, &ao->head, node, lockdep_sock_is_he=
ld(sk))
> --
> 2.51.0
>

