Return-Path: <linux-kernel+bounces-882718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDB50C2B3AD
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 12:04:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4E4C3A847E
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 11:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7368D301039;
	Mon,  3 Nov 2025 11:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eCv5i1OR";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="hCkvRS/R"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81603009E4
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 11:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762167819; cv=none; b=B5+5J8eotjuFGO1oLSycxPgc684YtqSxYjEhWalT2PvoNXIRD46N9gQ0BUsbgazpAuswn0LCIAy2EZ0J+HncFutab/UinrH2zNNpFabB7gIWgxF4IfSjl464I65GTh6i+SE2tVc9OXi+ty1zL7mxMwufIupsP+sdlIApP3jIXBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762167819; c=relaxed/simple;
	bh=ZWKf1U4K8p8K7ajfbNKacDFOZXuDZuDDSYcIrkzA/N0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fiP5hSooizu2DpksggsniBFB5q0S3kQsjjt/QIugocbujbV/gmhnRB/xt7IOWnv/awvN5Tz7xbWmwu2FuZwgIlTVdRiBrJ9xPrd7K7zMtLmnxSnMpUKlAYEGjCoB6klmRfplyt2wevFy4Drx9y1ZdLVL2vmXPhmgQ8E3Wc6BGh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eCv5i1OR; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=hCkvRS/R; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762167816;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zhTdrnjfA8ppQxzFb9fDiTAH4jVhlOQqvIRjACG6oMI=;
	b=eCv5i1ORlbybQ6Q4g7cwrCix9jLd2QdyO63zsqQ5zkJGW3UA/U62s1453YgFLtGeTp3cc4
	X+cGnJfx4YipgwPxgMZQYhH0u7mb6rEXt2K3kfTQtnQMvBTp96kucYbSNTq5nUyC7bO9wV
	9CzXHFHlkDC64Pa2w9RVKXhAvNGD68s=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-157-t2MKeOKiPxiATcxH6e5Rrw-1; Mon, 03 Nov 2025 06:03:35 -0500
X-MC-Unique: t2MKeOKiPxiATcxH6e5Rrw-1
X-Mimecast-MFC-AGG-ID: t2MKeOKiPxiATcxH6e5Rrw_1762167814
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-b5a8827e692so310856566b.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 03:03:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762167814; x=1762772614; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zhTdrnjfA8ppQxzFb9fDiTAH4jVhlOQqvIRjACG6oMI=;
        b=hCkvRS/Ribp6ASBG1FHRVpshS7QKtRzANGVovMCtgfsDKFgyKH6ynspCdCfnFL0pYZ
         JA6gUnKnDOPD1NYjeOkNXO/+B3RVifOFy5iqe+fY4ZDkmxXtUYh844dbDKJ67EAjmCR1
         zgw3ON9BvrOm0ofo/uW7WDyuM8KUlW8tm/ZhOXrOBdwJRwEqcjpu0o6dSiN5pxMxZeGZ
         LcuI2K0Q93la+pdqIiC5OUxRIWGaVbBCoxXgGb2Fj4XrHKQ9MTVoVYVSq7baXsz/qJ3w
         h4O2Wgvv0XkuKD9T2oSg9HMdOhxxT1+lIoJFkbFKO9i/dm5Eb2rCypx/W4b6wlK9U8mR
         Tzgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762167814; x=1762772614;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zhTdrnjfA8ppQxzFb9fDiTAH4jVhlOQqvIRjACG6oMI=;
        b=Py9lWS5r9ouR8imVSpnHzU5rpAt55YTIos+gizM7QRurjgY2/TDdH9KEtXjywc7kLP
         jlxTk9ybBKA2tLNq+FdeJIVgP7314s04Iic5dCpkUXsAgN0Vur5MYJZTQQSZQLBU2WeD
         MAzbKlMOEirfSheTHqwb3fliL/zBni465P+Cu+g4RzuBFu8fmg/8FvGDJX7lMLSlX4h+
         oEPuvmEimtx3fFt7iCxzrBzN9AsaFLT53lg0yxIHsFNCsGtud7ZLARrhljOO7ZW6tHYH
         nnJWhb5vef85rZdE7/gIUkIFC1k7r/Ky3bauSjGSqzw3nEiEQM8SkiE565Dmdn2heHZ4
         bkpg==
X-Forwarded-Encrypted: i=1; AJvYcCXsxBZc71I9uwhHS1Cv3QAd0j/+H5u+ye+RwmL10exDVEjcCRYGx4n4V0WGRpx5bfvJacjW963ddhtiREI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHDTjMAkQwigmwDBGU2aonfGsQHELeCzJgv70VxJuiMFQY46ZK
	2eV9AOJFK+W8RW2WWPV0QHS6Q8b4wS18XudNIvWgw2w+R2iLQgGys8rf7HxdpYNCeD//WC2aVAe
	mH+lQwu3vkwFQysVH8aq0on8r+YrogNSCM8YTrSjudeKUQ8lke4Mgxrke3LERR+4jjK0RZmJbyF
	38cKKLg15OhXi307Ka5Y9w66kwZ9/MLX0V5O8EWMxa
X-Gm-Gg: ASbGncvZdvi+N550nGmhaagJjq0ULo/eHPBJNuoXPCeQzfrwtUtly+p4ZGKEDZzn2dB
	teGYQ3ehUK5Jvf3ECcxBlaPxoGw1Quaeq7zKT+vcjYJ6hOYpWSZYLW4optqCUr74qtNWph2pIk+
	m7nzGC/NVoF4UO723KUEKNSDGPelv/QWhAaEU3dc7QXFe21+B7PAugm4o=
X-Received: by 2002:a17:907:1c93:b0:b40:8deb:9cbe with SMTP id a640c23a62f3a-b70700bad7dmr1398096466b.2.1762167814117;
        Mon, 03 Nov 2025 03:03:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF70Lv5L7m6M605bcYwYl5gdYYQmJQe9fOmppY9gxiQqdJv0qTmTVSWhGn8kw4mBFNTlWE3YlDmM/dVhBYh+OE=
X-Received: by 2002:a17:907:1c93:b0:b40:8deb:9cbe with SMTP id
 a640c23a62f3a-b70700bad7dmr1398093866b.2.1762167813668; Mon, 03 Nov 2025
 03:03:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cfafc5247fbfcd2561de16bcff67c1afd5676c9e.1761918165.git.rrobaina@redhat.com>
 <202511012016.TaXzGDDi-lkp@intel.com>
In-Reply-To: <202511012016.TaXzGDDi-lkp@intel.com>
From: Ricardo Robaina <rrobaina@redhat.com>
Date: Mon, 3 Nov 2025 08:03:22 -0300
X-Gm-Features: AWmQ_bnNelXrYhZN2hvHONfShTGA5EvaaCJcqVosrEermFLRrvdG6VLVDrGvFk4
Message-ID: <CAABTaaCf+5mY8gze4Ojy2fttEuuEtjj3Zm1dHScXVfWtKAQbSQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] audit: add audit_log_packet_ip4 and
 audit_log_packet_ip6 helper functions
To: kernel test robot <lkp@intel.com>
Cc: audit@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org, 
	oe-kbuild-all@lists.linux.dev, paul@paul-moore.com, eparis@redhat.com, 
	fw@strlen.de, pablo@netfilter.org, kadlec@netfilter.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I didn't get these warning messages in my local build. I'll fix it and
submit a new version.

On Sat, Nov 1, 2025 at 10:15=E2=80=AFAM kernel test robot <lkp@intel.com> w=
rote:
>
> Hi Ricardo,
>
> kernel test robot noticed the following build errors:
>
> [auto build test ERROR on pcmoore-audit/next]
> [also build test ERROR on netfilter-nf/main nf-next/master linus/master v=
6.18-rc3 next-20251031]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Ricardo-Robaina/au=
dit-add-audit_log_packet_ip4-and-audit_log_packet_ip6-helper-functions/2025=
1031-220605
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git=
 next
> patch link:    https://lore.kernel.org/r/cfafc5247fbfcd2561de16bcff67c1af=
d5676c9e.1761918165.git.rrobaina%40redhat.com
> patch subject: [PATCH v4 1/2] audit: add audit_log_packet_ip4 and audit_l=
og_packet_ip6 helper functions
> config: m68k-defconfig (https://download.01.org/0day-ci/archive/20251101/=
202511012016.TaXzGDDi-lkp@intel.com/config)
> compiler: m68k-linux-gcc (GCC) 15.1.0
> reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archi=
ve/20251101/202511012016.TaXzGDDi-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202511012016.TaXzGDDi-lkp=
@intel.com/
>
> All errors (new ones prefixed by >>):
>
>    net/netfilter/nft_log.c: In function 'nft_log_eval_audit':
> >> net/netfilter/nft_log.c:48:31: error: implicit declaration of function=
 'audit_log_packet_ip4'; did you mean 'audit_log_capset'? [-Wimplicit-funct=
ion-declaration]
>       48 |                         fam =3D audit_log_packet_ip4(ab, skb) =
? NFPROTO_IPV4 : -1;
>          |                               ^~~~~~~~~~~~~~~~~~~~
>          |                               audit_log_capset
> >> net/netfilter/nft_log.c:51:31: error: implicit declaration of function=
 'audit_log_packet_ip6'; did you mean 'audit_log_capset'? [-Wimplicit-funct=
ion-declaration]
>       51 |                         fam =3D audit_log_packet_ip6(ab, skb) =
? NFPROTO_IPV6 : -1;
>          |                               ^~~~~~~~~~~~~~~~~~~~
>          |                               audit_log_capset
>
>
> vim +48 net/netfilter/nft_log.c
>
>     28
>     29  static void nft_log_eval_audit(const struct nft_pktinfo *pkt)
>     30  {
>     31          struct sk_buff *skb =3D pkt->skb;
>     32          struct audit_buffer *ab;
>     33          int fam =3D -1;
>     34
>     35          if (!audit_enabled)
>     36                  return;
>     37
>     38          ab =3D audit_log_start(NULL, GFP_ATOMIC, AUDIT_NETFILTER_=
PKT);
>     39          if (!ab)
>     40                  return;
>     41
>     42          audit_log_format(ab, "mark=3D%#x", skb->mark);
>     43
>     44          switch (nft_pf(pkt)) {
>     45          case NFPROTO_BRIDGE:
>     46                  switch (eth_hdr(skb)->h_proto) {
>     47                  case htons(ETH_P_IP):
>   > 48                          fam =3D audit_log_packet_ip4(ab, skb) ? N=
FPROTO_IPV4 : -1;
>     49                          break;
>     50                  case htons(ETH_P_IPV6):
>   > 51                          fam =3D audit_log_packet_ip6(ab, skb) ? N=
FPROTO_IPV6 : -1;
>     52                          break;
>     53                  }
>     54                  break;
>     55          case NFPROTO_IPV4:
>     56                  fam =3D audit_log_packet_ip4(ab, skb) ? NFPROTO_I=
PV4 : -1;
>     57                  break;
>     58          case NFPROTO_IPV6:
>     59                  fam =3D audit_log_packet_ip6(ab, skb) ? NFPROTO_I=
PV6 : -1;
>     60                  break;
>     61          }
>     62
>     63          if (fam =3D=3D -1)
>     64                  audit_log_format(ab, " saddr=3D? daddr=3D? proto=
=3D-1");
>     65
>     66          audit_log_end(ab);
>     67  }
>     68
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
>


