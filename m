Return-Path: <linux-kernel+bounces-821877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2782DB82894
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 03:42:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D13CE328012
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 01:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 067FB238149;
	Thu, 18 Sep 2025 01:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H4BA4DyD"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF8DD218AC1
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 01:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758159751; cv=none; b=atfGn4+Yb69U8MCMgowYcjDnNmXTSQ7jIrkb0LW6hb/BiJXSEJI93ed9dRWJUg/JN4D1EW0V6UBg0cqcntEdq5VdiVTDisvjteSVMmBEqAl3b7J9JMloi6KF88wrHMv97gTljirHOUBEHyQnoTWEblzbR6wg2BVKdvhXVEQgGRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758159751; c=relaxed/simple;
	bh=c+zrwLe7+HLxrcq4q+hBHCEgF0dl/Nyc5R6TtdQ3zzM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pm3txCunU35DZftDi72vA6Dc46cDouvc9xLd1hpPJfVqO12cWzdWYVtlInUgxZ1g6Joj9uGGQJbO9bNzm3XcNnUoEsIFpEMizmPDMb0EQMWksBFSCFugumaWvVEOxP0jbEhoQ8lPx0AT8rjvC3HlDsvrd5f+suIO36NpnqRtZpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H4BA4DyD; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-77d2632f904so96928b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 18:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758159749; x=1758764549; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ulvs7K3ydlDyEpWR5MQzG7rfwOArTPkkxrt2MdB42Is=;
        b=H4BA4DyDAL4QofPATXA1vU2N2K/Fmcnvjk+5s8l9MIAojPzWBwSOB+nqZ5ns2Nbj3J
         j/RLiNfiQ8R/DVi7HAmlR9UjAtTdanmfKa3kMIdGgY7MwAchZqnE6Iu0OrR8Lscp126F
         tj0/B54dfkWo/sXeg3nNCfiwpF+6llxZ/euW8ofwEg86BYlQUNpIjssNS9dKHBfXQN/c
         L55TFvGqIxTY4EDx8r8Hmz0cTOgxrEhIrTv1IiCzzb/1wnrP18SPt0T4zxxVqdVma2KB
         YfgUxH07fMG2KRuemVzEwPnMmrgbBOxnhwp3k8tiulCQ9yYgorEen5IRnACpDPtvGWxr
         rztw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758159749; x=1758764549;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ulvs7K3ydlDyEpWR5MQzG7rfwOArTPkkxrt2MdB42Is=;
        b=Z238Kn2yPPhs4wMezfjQlC2FWUyDNMplhWfcuVB7a0UzIP2ckt6WVopw08tj82/nUi
         pN+XMS0yUkc+yA3Ok80jvBo/fS/C+HWn7b9jfiXrEVEt4ngUbsiRryie2WUXIAmf+ffG
         MgfIRvF//1sJ5CUuPqDsZER81Wt1xCkhd4Lfx95FhlCdWftGgufYa+YL8rV6s81biXuY
         v6fi68PbgLxanXG6BVZGFHmEqx1wnjetKVcPmNMiMvvsCPPhe7J2+TzkTUYZxqiuaE6y
         YP4GXxlpdeYxwFh1ussClOtoQnKvVHE2gd3sGwDEmNiLFWsfHE5UabFmFh9+ou6jMpuC
         m81g==
X-Forwarded-Encrypted: i=1; AJvYcCV+Q8Vt9y3rOaKPmQ3BMJW9ixPwceGpeZruMNjXz9ljVO/Xwc8LXvl+h2awt0OXWgp7Wj2DQ6Ud/yD/KoM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWO7ufxAoBVHhlmdJXAgMd+MyC2sOsBNpfXYg9GO/vS2Ua21P8
	x7LiaFHqN4QDEjG2rnfHM4LjkGKd5afI+o++68e/BFi4N7dkMvqlml6u
X-Gm-Gg: ASbGncsaLUlYupwV4v24rHDArSfD0ndkT+TzwOYYee12HWb8f09Yfj/256CEOeU6EcS
	1DEW/i/lQaQAkubtBITZAm1Gf3OoiNJdo9I2rZhbPkx+9uv4t2UC5GACtuFM6QuAii6I62XvBDo
	DCJO1EHsofwKCCz7iTgRuM4hruyNFhrfq6mOFSJwlMoqW+fXRg3LblSSt/biSoqDzbS4KFDIQJV
	V/5IEx+KSYJ+d2LEvXpifPuWs3YSMuIyEmR3QP9dhtrUld2dEiMn52MCLwpeLdXRV8DFH4ZcXr5
	tgxjGEX4t8nRemA34dvz1lzLKYFtV1AlSH34eNOpFMD3DuCFGP4jqARGnfuS86u+nbDGh/bm4Hn
	Sh8HWDH81/u4DDfd8IN14pNdUG4BqQldketUOtVcTL2awWNBgxZQng2gn4+jNQu6gP5w=
X-Google-Smtp-Source: AGHT+IFdcQcWFVUS1QCaJowNQlqmrKMadj3R+g3ibkhiKQd6PPuK1CiIPRFjs1gwggeFAwB+1AJwIA==
X-Received: by 2002:a05:6a00:228c:b0:771:e1bf:bddc with SMTP id d2e1a72fcca58-77bf75c1492mr4848577b3a.13.1758159749067;
        Wed, 17 Sep 2025 18:42:29 -0700 (PDT)
Received: from [192.168.0.69] ([159.196.5.243])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77cfc72b21csm687875b3a.44.2025.09.17.18.42.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 18:42:28 -0700 (PDT)
Message-ID: <c7104a0d58c674bb1fec1a6093be6085ad0be0e0.camel@gmail.com>
Subject: Re: [PATCH v3] net/tls: support maximum record size limit
From: Wilfred Mallawa <wilfred.opensource@gmail.com>
To: Sabrina Dubroca <sd@queasysnail.net>, kuba@kernel.org
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, 	corbet@lwn.net, john.fastabend@gmail.com,
 netdev@vger.kernel.org, 	linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, 	alistair.francis@wdc.com, dlemoal@kernel.org
Date: Thu, 18 Sep 2025 11:42:23 +1000
In-Reply-To: <aLllqGpa2gLVNRbw@krikkit>
References: <20250903014756.247106-2-wilfred.opensource@gmail.com>
	 <aLllqGpa2gLVNRbw@krikkit>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-09-04 at 12:10 +0200, Sabrina Dubroca wrote:
> 2025-09-03, 11:47:57 +1000, Wilfred Mallawa wrote:
> > +static int do_tls_setsockopt_tx_record_size(struct sock *sk,
> > sockptr_t optval,
> > +					=C2=A0=C2=A0=C2=A0 unsigned int optlen)
> > +{
> > +	struct tls_context *ctx =3D tls_get_ctx(sk);
> > +	u16 value;
> > +
> > +	if (sockptr_is_null(optval) || optlen !=3D sizeof(value))
> > +		return -EINVAL;
> > +
> > +	if (copy_from_sockptr(&value, optval, sizeof(value)))
> > +		return -EFAULT;
> > +
> > +	if (ctx->prot_info.version =3D=3D TLS_1_2_VERSION &&
> > +	=C2=A0=C2=A0=C2=A0 value > TLS_MAX_PAYLOAD_SIZE)
> > +		return -EINVAL;
> > +
> > +	if (ctx->prot_info.version =3D=3D TLS_1_3_VERSION &&
> > +	=C2=A0=C2=A0=C2=A0 value > TLS_MAX_PAYLOAD_SIZE + 1)
> > +		return -EINVAL;
>=20
> The RFC is not very explicit about this, but I think this +1 for
> TLS1.3 is to allow an actual payload of TLS_MAX_PAYLOAD_SIZE and save
> 1B of room for the content_type that gets appended.
>=20
> =C2=A0=C2=A0 This value is the length of the plaintext of a protected rec=
ord.=C2=A0
> The
> =C2=A0=C2=A0 value includes the content type and padding added in TLS 1.3=
 (that
> =C2=A0=C2=A0 is, the complete length of TLSInnerPlaintext).
>=20
> AFAIU we don't actually want to stuff TLS_MAX_PAYLOAD_SIZE+1 bytes of
> payload into a record.
>=20
> If we set tx_record_size_limit to TLS_MAX_PAYLOAD_SIZE+1, we'll end
> up
> sending a record with a plaintext of TLS_MAX_PAYLOAD_SIZE+2 bytes
> (TLS_MAX_PAYLOAD_SIZE+1 of payload, then 1B of content_type), and a
> "normal" implementation will reject the record since it's too big
> (ktls does that in net/tls/tls_sw.c:tls_rx_msg_size).
>=20
> So we should subtract 1 from the userspace-provided value for 1.3,
> and
> then add it back in getsockopt/tls_get_info.
Yeah good point. I will fix this up
>=20
> Or maybe userspace should provide the desired payload limit, instead
> of the raw record_size_limit it got from the extension (ie, do -1
> when
> needed before calling the setsockopt). Then we should rename this
> "tx_payload_size_limit" (and adjust the docs) to make it clear it's
> not the raw record_size_limit.
>=20
> The "tx_payload_size_limit" approach is maybe a little bit simpler
> (not having to add/subtract 1 in a few places - I think userspace
> would only have to do it in one place).
>=20
>=20
> Wilfred, Jakub, what do you think?
I'm in favour of keeping the RFC definition, as this would mean
userspace only has to worry about passing up the value received from
the record size limit extension.

For V4, I'll add a note in the docs regarding the TLS 1.3 ContentType,
and fixup tx_record_size_limit to account for ContentType.

Regards,
Wilfred
>=20
>=20
> > +	ctx->tx_record_size_limit =3D value;
> > +
> > +	return 0;
> > +}

