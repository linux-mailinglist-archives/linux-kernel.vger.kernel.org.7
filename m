Return-Path: <linux-kernel+bounces-834538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB661BA4E4F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 20:29:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AD633230F5
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 18:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D7AB2FFDDC;
	Fri, 26 Sep 2025 18:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ud+glv4w"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F86280308
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 18:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758911354; cv=none; b=pq8/l5FxhLWbH/yF6O9TqLh2BJRU7r4Nn39GxrZxQGWSJMHYNFJLkLnTDo49u0ZkX34mzBZnZGeH9iYN86dIvKiAm+e95IbyvOls1p9rxM0u2FJJLv7hDIeIiWe+IpyU9TYU1tKLZKV7VqiEMyevEozH1JmC4CsFeqnnTeyFZvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758911354; c=relaxed/simple;
	bh=Fdtvwdou0j/HPLsynKl5haCoT9J7J98Gr4teoaFv51w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CdHSnD8QrZt9vcmn09uN0Yhvz01B4u/SZf7NQmljJbnFb7xHUQXXT302m3jG/5X5evopMCQZ0BT7DY+7q9CMLW1iwZowCEm3lZkTXxyK0Fje0l7KhsHMPJ69g0XhhIUhkYBUVsyUdvfbaP3WUZ/1yhfgcj025cDnmtQIar+KlFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ud+glv4w; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758911352;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VVK5hqYxqrcHg6x0vzf6zc77p/zTjdplz2xbifw60rg=;
	b=Ud+glv4wUhkuLSHv7FjFH+xxx3y30nzqiwCURVDnlRt9Y2iAXWHHDLiGrc+Ls/WeRJO3DC
	qJHptrBTwEL2NkuBVZpIKHU3UPORNB2ti5TOO3CO3KTn62YSgqclEnl0v0xWOrNKAiqlcf
	3fIZpD7FdW1pv1C/41WJyEnu/4rjtso=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-343-pWaw8Ao8OIWZlvy7848z8Q-1; Fri, 26 Sep 2025 14:29:11 -0400
X-MC-Unique: pWaw8Ao8OIWZlvy7848z8Q-1
X-Mimecast-MFC-AGG-ID: pWaw8Ao8OIWZlvy7848z8Q_1758911348
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-b3826ab5449so82545966b.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 11:29:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758911348; x=1759516148;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VVK5hqYxqrcHg6x0vzf6zc77p/zTjdplz2xbifw60rg=;
        b=EzASFGGqPlVP+TN3RbxLoPSypsA8kDysXO09BrZ1JMYlhy79PT+Vq6Ny0mEY18yGsJ
         ZKScVt/T7dXCCuazh6/O2dmtxY/s+Mem9PzbhVPcWApacD7xf8PnLu44axhbt3vbh43b
         Fn1FBIcPrafSjYoQtlu4CM3fNeVBLpFtKENgLNsymXZVKTmqH2QvOlfQN6pY/iGuiAcK
         C0uxqaI2bODK9+AhZgvhB7ApDc2rY/5yMaxfYcw+AkxSH1sNxdZFXIoGvAy/InRTgqIN
         w1HrOCzm/dxpOA8ecRYIHgPv6KczMjv1X7QE/Rgf1jO2r6FeC7PIprHP+xCrwiin2nBG
         XuPA==
X-Forwarded-Encrypted: i=1; AJvYcCUudjU7cIM9BPwtwXSMdFk1qSuShrYy78iDePqiT7ldwck/jypPjxx5XgVAqLQCW28otwkS0Xd9AYH7Irw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywi+dME3uj5OzN/E7TaGM5xuRPmBajtiVqXQeZyx9jLrxXlpMA7
	GJGI1eKPBpZdghZ2M4R836zexre/9HaNJD/Mf6Bru2WPUD1hJz+GMWR6JE6KuK1FLp6TCN2OKI1
	q+kaw7pmDDlntX3CaKnyfmhAWgwYwrO+tuEF6T/iKUfggb/l+BUsdBWvAUQsjh5liWRwmi90V0N
	d7R1/fJHSirDXoMJy6WCjwMTfpa4t4Jv4S+DYlFtkh
X-Gm-Gg: ASbGncu9PIeKPzwd+UZrEX7GIa/3RR+a1o8RQ4NQqlpWftJ8nQGAAKjtPm4TLubRFJg
	FUsjE1XFPLmZJaFlrknC/YWX0msbfBD5FFVSIuNQVwQGR69tyvJQBL9/ETxFyIs5Mu+EK6GYUKr
	5Ot5NnOPRMmQ6Uf9YDWaECFUWGY5HbQHlX32yjq3buqxT43duGk58xXQ==
X-Received: by 2002:a17:907:6093:b0:b04:6a58:560b with SMTP id a640c23a62f3a-b34ba93ce11mr909046866b.39.1758911348366;
        Fri, 26 Sep 2025 11:29:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH8NPueb5nCMT5DuPssEE6Gyfl/L/QQSo2uJ/kLrAnQWxWWz6E92b3DZ9NPm4ViF0aNX+BwD71pWnwRFHvSZHo=
X-Received: by 2002:a17:907:6093:b0:b04:6a58:560b with SMTP id
 a640c23a62f3a-b34ba93ce11mr909043066b.39.1758911347929; Fri, 26 Sep 2025
 11:29:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250925134156.1948142-1-rrobaina@redhat.com> <c7a8d5f64e19f529a7595f26e150826f@paul-moore.com>
In-Reply-To: <c7a8d5f64e19f529a7595f26e150826f@paul-moore.com>
From: Ricardo Robaina <rrobaina@redhat.com>
Date: Fri, 26 Sep 2025 15:28:55 -0300
X-Gm-Features: AS18NWDStEem2dFQRSusMMoOLIwVwIMaAYTG9PMRNMPg6ucZ8NhwQ2lffaOUJ4g
Message-ID: <CAABTaaC9tSJ2Say6RHiQ3Ffm-xo4g-Ld3r83GwUBYZ5STs-hCA@mail.gmail.com>
Subject: Re: [PATCH v2] audit: include source and destination ports to NETFILTER_PKT
To: Paul Moore <paul@paul-moore.com>
Cc: audit@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org, eparis@redhat.com, 
	pablo@netfilter.org, kadlec@netfilter.org, fw@strlen.de, ej@inai.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for reviewing this patch, Paul! Sounds great, I'll work on the
v3 shortly.

On Thu, Sep 25, 2025 at 5:41=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Sep 25, 2025 Ricardo Robaina <rrobaina@redhat.com> wrote:
> >
> > NETFILTER_PKT records show both source and destination
> > addresses, in addition to the associated networking protocol.
> > However, it lacks the ports information, which is often
> > valuable for troubleshooting.
> >
> > This patch adds both source and destination port numbers,
> > 'sport' and 'dport' respectively, to TCP, UDP, UDP-Lite and
> > SCTP-related NETFILTER_PKT records.
> >
> >  type=3DNETFILTER_PKT ... saddr=3D127.0.0.1 daddr=3D127.0.0.1 proto=3Di=
cmp
> >  type=3DNETFILTER_PKT ... saddr=3D::1 daddr=3D::1 proto=3Dipv6-icmp
> >  type=3DNETFILTER_PKT ... daddr=3D127.0.0.1 proto=3Dudp sport=3D38173 d=
port=3D42424
> >  type=3DNETFILTER_PKT ... daddr=3D::1 proto=3Dudp sport=3D56852 dport=
=3D42424
> >  type=3DNETFILTER_PKT ... daddr=3D127.0.0.1 proto=3Dtcp sport=3D57022 d=
port=3D42424
> >  type=3DNETFILTER_PKT ... daddr=3D::1 proto=3Dtcp sport=3D50810 dport=
=3D42424
> >  type=3DNETFILTER_PKT ... daddr=3D127.0.0.1 proto=3Dsctp sport=3D54944 =
dport=3D42424
> >  type=3DNETFILTER_PKT ... daddr=3D::1 proto=3Dsctp sport=3D57963 dport=
=3D42424
> >
> > Link: https://github.com/linux-audit/audit-kernel/issues/162
> > Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>
> > ---
> >  net/netfilter/xt_AUDIT.c | 42 +++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 41 insertions(+), 1 deletion(-)
> >
> > diff --git a/net/netfilter/xt_AUDIT.c b/net/netfilter/xt_AUDIT.c
> > index b6a015aee0ce..9fc8a5429fa9 100644
> > --- a/net/netfilter/xt_AUDIT.c
> > +++ b/net/netfilter/xt_AUDIT.c
> > @@ -19,6 +19,7 @@
> >  #include <linux/netfilter_bridge/ebtables.h>
> >  #include <net/ipv6.h>
> >  #include <net/ip.h>
> > +#include <linux/sctp.h>
> >
> >  MODULE_LICENSE("GPL");
> >  MODULE_AUTHOR("Thomas Graf <tgraf@redhat.com>");
> > @@ -32,6 +33,7 @@ static bool audit_ip4(struct audit_buffer *ab, struct=
 sk_buff *skb)
> >  {
> >       struct iphdr _iph;
> >       const struct iphdr *ih;
> > +     __be16 dport, sport;
> >
> >       ih =3D skb_header_pointer(skb, skb_network_offset(skb), sizeof(_i=
ph), &_iph);
> >       if (!ih)
> > @@ -40,6 +42,25 @@ static bool audit_ip4(struct audit_buffer *ab, struc=
t sk_buff *skb)
> >       audit_log_format(ab, " saddr=3D%pI4 daddr=3D%pI4 proto=3D%hhu",
> >                        &ih->saddr, &ih->daddr, ih->protocol);
> >
> > +     switch (ih->protocol) {
> > +     case IPPROTO_TCP:
> > +             sport =3D tcp_hdr(skb)->source;
> > +             dport =3D tcp_hdr(skb)->dest;
> > +             break;
> > +     case IPPROTO_UDP:
> > +     case IPPROTO_UDPLITE:
> > +             sport =3D udp_hdr(skb)->source;
> > +             dport =3D udp_hdr(skb)->dest;
> > +             break;
> > +     case IPPROTO_SCTP:
> > +             sport =3D sctp_hdr(skb)->source;
> > +             dport =3D sctp_hdr(skb)->dest;
> > +     }
> > +
> > +     if (ih->protocol =3D=3D IPPROTO_TCP || ih->protocol =3D=3D IPPROT=
O_UDP ||
> > +         ih->protocol =3D=3D IPPROTO_UDPLITE || ih->protocol =3D=3D IP=
PROTO_SCTP)
> > +             audit_log_format(ab, " sport=3D%hu dport=3D%hu", ntohs(sp=
ort), ntohs(dport));
> >       return true;
> >  }
>
> Instead of having the switch statement and then doing an additional if
> statement, why not fold it all into the switch statement?  Yes, you
> would have multiple audit_log_format() calls, but they are trivial to
> cut-n-paste, and it saves the extra per-packet checking at runtime.
>
>   switch (ih->protocol) {
>   case IPPROTO_TCP:
>     audit_log_format(ab, " sport=3D...",
>                      tcp_hdr(skb)->source,
>                      tcp_hdr(skb)->dest);
>     break;
>     ...
>   }
>
> ... considering how expensive multiple audit_log_format() calls can be,
> it might even be worth considering consolidating the two calls into one:
>
>   switch (ih->protocol) {
>   case IPPROTO_TCP:
>     audit_log_format(ab, " saddr=3D...",
>                      ih->saddr,
>                      ...
>                      tcp_hdr(skb)->source,
>                      tcp_hdr(skb)->dest);
>     break;
>     ...
>   default:
>     audit_log_format(ab, " saddr=3D...",
>                      ih->saddr,
>                      ...);
>   }
>
> --
> paul-moore.com
>


