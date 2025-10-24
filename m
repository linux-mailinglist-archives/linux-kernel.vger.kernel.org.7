Return-Path: <linux-kernel+bounces-868825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB6B0C063F7
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 14:27:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E96771AA5EA3
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 12:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F919316199;
	Fri, 24 Oct 2025 12:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vyos.io header.i=@vyos.io header.b="v663jluR"
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA3CC3161BF
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 12:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761308815; cv=none; b=NM0qIAvFEg1HfboIH/qwdZnYLVhsuBAKX0Va3/ZAhaOAlWDFSd5mnAhjAEGzmYyKlnxLn85O+6t6H/9kWLEjxZKkXoV42DITQYCD+TUmJjhNkhuasrCfMEA8AfEsN64lg70xF2ICIXBMJbis1vxlNezfbXxJQQ6whTOMoHNzAO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761308815; c=relaxed/simple;
	bh=O5Dle4BNj5msa8BckU+W30hPvec/HAk9Is79YZfojyY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OH18/1zH2UkE6TSvc0yfdAmMuRy5DlwgTJCHlw2NdDBm52bDVyJxfQi+C5Ok+e+BM1IFOsj3dR7UJRG/VEmVwILqclWuyjOKb8GKAmbn8qC70TkBNLlNIDHwjVCKg98cC8+vQ+OHgt2ANtntS95na25Rgc2Ij0eRv1moViht6AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vyos.io; spf=pass smtp.mailfrom=vyos.io; dkim=pass (2048-bit key) header.d=vyos.io header.i=@vyos.io header.b=v663jluR; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vyos.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vyos.io
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-78488cdc20aso25214987b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 05:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vyos.io; s=google; t=1761308811; x=1761913611; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ncYqI9As37pY3UXnqEMw7tkASKkcarOp4L+gW3ftqL0=;
        b=v663jluRSMr1lsTE65ZeYzjMIpTXtuM55eY/zLaMYOoJnMDAoIYE4ojSXpOEr2/84Z
         Zme8CiXxR/233Ft6fiZMwxCfEYZHs3RoA4FNRM9zeG9KndrgNrJo+mE+KHuEJwCiyOzs
         oo31Ob1LQ7LYeJZe0JIA9k0rOAjajgzzPonbP4urUkaCEFxDKNFCbe6xhdlfXtccQt+t
         TkKJk1Vgj/5zI/O+ZQMHFvsqq0EqRpiULRennVdRDfGCtevJd5CKNwWLlYu2T+I1VPfb
         z890YbzZw8GYuyEXkXcI6Ph3kpjpf+V1qyyIiww+wX6uGfJ0cUDWZjGFIkT2Nuzphc7f
         wc2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761308811; x=1761913611;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ncYqI9As37pY3UXnqEMw7tkASKkcarOp4L+gW3ftqL0=;
        b=DYdRwFEYfx2QQeawoXvz913Oz6qbqZDz/X7C0xBkSroOfgNq0B/gk3U5c9qGSQ2hl+
         L1jj/RLpbK0cri+pDiYAbX+2iuOxfJddtmT/CdjS4neKlrecLs5LmVG/GNbI4rJw5DIT
         PoIJciVeUEvbAYNXBDAUU7RzZtV8shcv4MXlMjSUeKy8mzUO01+1L8HOeCJNJzNvASqZ
         AcpXDAeL+Nx0oBGBvJ2ie+tPKZbCyhk0PZqOyCupecd6OEzWgV3eTPilZSOpGYsrPdd7
         pCI7VH/BG8fcew8nOnV7Kw0cbSQ26argDE380/wGmklLXYcZgYSp0NPGYAQdUdA9djw+
         eeBw==
X-Forwarded-Encrypted: i=1; AJvYcCXHDW2jJCzLkI32AgChvtNy3f4n5qpr6akUarv5HcfdxbqLCioMvFwTxa2eEN9tMKDT/BbYFiXkvFahmt8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyf5uv34q9AncDxfzwlngaFN8MZmxSviApDnmb5MoXuTpSwff8x
	HV0DcCPNa7DHapnmo8a2vreeZDH0dlnlttBoF/F0zpQ6MXBjbFeKKJ2MnnopTqNOI302RH9itcZ
	kykG9PKVyGdN4aT05TJiyVBLTQlUbFI4ieoqqKFUkbQ==
X-Gm-Gg: ASbGncuhGv2jfCJIy1Yty38sPHcmeAIBhDy2fWtW4oO4imarhlSSsIhsStDESnAj3/E
	NMKi8F2Gv3jEFtPh41OVArALWvI0FeGjJfbY2+g17K84zmHQGOSZ4o96qXRRXffjPaqTm0fgoeA
	9sdF6/QCG+jz4bTz+u5gBsv8ORdBhoeo+DzAxPGLdgR8zoPoCAF98BqDfprG5CfDxELPtRgbvHf
	jBDAxT6J63q3AEYIwHDyZvPwSvtgWmhReBEF46SR1gdTpAQRV1rYS7sS+DiTaWO9H4dAUxI
X-Google-Smtp-Source: AGHT+IHfKehAZmgdUEZG9w4+itRQMd77fJC+uH4WKlJ1wnorm7NJHcBAYt29h/4pWt8OBKvjJDjZb4F2zQi1+wfu5BI=
X-Received: by 2002:a05:690c:8d04:b0:744:21d9:f5c3 with SMTP id
 00721157ae682-7836d21567emr245208317b3.28.1761308811515; Fri, 24 Oct 2025
 05:26:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251021133918.500380-1-a.melnychenko@vyos.io>
 <20251021133918.500380-2-a.melnychenko@vyos.io> <aPeZ_4bano8JJigk@strlen.de>
 <aPghQ2-QVkeNgib1@calendula> <aPi8h_Ervgips4X4@strlen.de> <CANhDHd_iPWgSuxi-6EVWE2HVbFUKqfuGoo-p_vcZgNst=RSqCA@mail.gmail.com>
 <CANhDHd_xhYxWOzGxmumnUk1f6gSWZYCahg0so+AzOE3i12bL9A@mail.gmail.com> <aPoi0Sozs3C9Ohlc@strlen.de>
In-Reply-To: <aPoi0Sozs3C9Ohlc@strlen.de>
From: Andrii Melnychenko <a.melnychenko@vyos.io>
Date: Fri, 24 Oct 2025 14:26:40 +0200
X-Gm-Features: AS18NWClQQjkS1wvkZ7GF5TCuhMrgSrnQiF09pio6ihuMFXDTdoUb57YjPBebLA
Message-ID: <CANhDHd_W=FQkm0u3ZBSE4-RQpGQcXUqKwJRDj7e9anPbv8Djrw@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] nft_ct: Added nfct_seqadj_ext_add() for NAT'ed conntrack.
To: Florian Westphal <fw@strlen.de>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>, kadlec@netfilter.org, phil@nwl.cc, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, netfilter-devel@vger.kernel.org, coreteam@netfilter.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi everyone,

On Thu, Oct 23, 2025 at 2:42=E2=80=AFPM Florian Westphal <fw@strlen.de> wro=
te:
>
> Andrii Melnychenko <a.melnychenko@vyos.io> wrote:
> > I've taken a look at the `nat_ftp` test from nftables. It actually
> > passes fine, I've tried to modify the test, add IPv4 and force
> > PASV/PORT mode - everything works.
> > Currently, I'm studying the difference between NFT rulesets.
> > Primarily, I'm testing on 2 kernels: 6.6.108 and 6.14.0-33.
>
> I think its this:
>     chain POST-srcnat {
>         type nat hook postrouting priority srcnat; policy accept;
>         ip6 daddr ${ip_sr} ip6 nexthdr tcp tcp dport 21 counter snat ip6 =
to [${ip_rs}]:16500
>     }
>

It is! I've compared the ruleset and found that the SNAT rule differs sligh=
tly.
In my case, it's something like this:

```
ip6 daddr ${ip_cr} ip6 nexthdr tcp tcp sport 21 counter snat ip6 to ${ip_rc=
}
```

So, for example:
 +-------------------+     +----------------------------------+
 | FTP: 192.168.13.2 | <-> | NAT: 192.168.13.3, 192.168.100.1 |
 +-------------------+     +----------------------------------+
                                     |
                         +-----------------------+
                         | Client: 192.168.100.2 |
                         +-----------------------+

The FTP server is "behind" the router. So the client needs to connect
to the router.
With a ruleset like this:

```
table ip nat {
        ct helper ftp_helper {
                type "ftp" protocol tcp
                l3proto ip
        }

        chain prerouting {
                type nat hook prerouting priority dstnat; policy accept;
                tcp dport 21 dnat ip prefix to ip daddr map {
192.168.100.1 : 192.168.13.2/32 }
        }

        chain postrouting {
                type nat hook postrouting priority srcnat; policy accept;
                tcp sport 21 snat ip prefix to ip saddr map {
192.168.13.2 : 192.168.100.1/32 }
        }

        chain filter_prerouting {
                type filter hook prerouting priority 350; policy accept;
                tcp dport 21 ct helper set "ftp_helper"
        }
}
```

Client has to connect to the router (192.168.100.2 -> 192.168.100.2),
while the FTP server would receive the connection from the client
(192.168.100.2 -> 192.168.33.2).
So the connection hits SNAT when it's already established and confirmed.

> This sets up snat which calls nf_nat_setup_info which adds the
> seqadj extension.

So, we still need to add seqadj allocation for DNAT.
I will propose a new patch v4 with `regs->verdict.code =3D NF_DROP;`.
And later, I can provide a new ruleset for tests in `nft_ftp` for `nftables=
`.

Any suggestions?

--=20

Andrii Melnychenko

Phone +1 844 980 2188

Email a.melnychenko@vyos.io

Website vyos.io

linkedin.com/company/vyos

vyosofficial

x.com/vyos_dev

reddit.com/r/vyos/

youtube.com/@VyOSPlatform

Subscribe to Our Blog Keep up with VyOS

