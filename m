Return-Path: <linux-kernel+bounces-859898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DEEABEEEC2
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 02:00:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A04241898910
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 00:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD5AA2E40E;
	Mon, 20 Oct 2025 00:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kdN8T2LH"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C6338F40
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 00:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760918422; cv=none; b=Gb8NZyIiwERq4dy+JGRo3Gb0YViUO7YIqzxnSZPTygYan3w7hKLllyzbZt21ID7c8fxtt4+GXd8lok5VXad1HA9D+QcCoj9G/pKJOZ5iFROUKJiXPX3cPbb0CX0og5KFmCksVQRi8UletdClcl2Wm3o/vI1GJ9vhn+kwfHQpFyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760918422; c=relaxed/simple;
	bh=ezMN77l/qcVaMgmJJ7bxGKgebH9Xy6zHK2EiL+Mja6g=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HPsYP5wk7f19oCuMt7rhfuk0rVFXaBVMh+CVPhcbn7YoKA2Ft2Wx0aJG40cwA+IdbpTL3B0tlUsfaMbnkeI4sqwpg+qM9yY8f3Fuc42YCQSnJFGgViy/St7Vzdf34qrgbGDbN/H9rvZNw1Nx4DkjHCl9i01Q3XuBGCpLpRyRtt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kdN8T2LH; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-27ee41e0798so60528725ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 17:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760918419; x=1761523219; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VaiAWLD4XNNKUuKlNpoWsuUt8QnNRZuGQMftj6fdN74=;
        b=kdN8T2LHmzKckBMEPGtkUkWjbogtRZAwPdlIHx57qD83musWmtd0xsxOSKzPMPL8do
         TnhzIB+vYpaFYF8BQRmmGF3KPqnaR77lQJCt64yhAypRca6ptgkqYdHpIxPhvaaaUA1F
         aCvySa+wsBaL7xrgZv00qyviGhIm+V7WxHWChnS44ZZuwoPn9Z+Rb6xoDs9hEXJMm4oI
         KRsyz1XYy3C03ZxwOjGUqCvxk3X4qsvXbX45ire5Hu/1eTS0NRg0JfYkSHMbiOnubiJH
         AXWwhJbp0eZx/6Ok2HIMTnaPgSlW477iMJ7sz2EEB5zEIADJ33l941LHqabfUdEI8OrZ
         pMjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760918419; x=1761523219;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VaiAWLD4XNNKUuKlNpoWsuUt8QnNRZuGQMftj6fdN74=;
        b=pP2epomTv4EZIvF/32iYKbm5f9aiGpUdgCoojHb7303wTxBSlAKWnMnjM8yLGXyDXF
         eCFuikkqWvmQGwbAcIa4jAjL2HSc6x1Uw1/X1B/cmDA4rlvi1zJlfTaySRyD+xDJubP7
         qF7fLGTH9PHp1lVvJ/TlfqtL+Q9mI2218l7HFTBtgfJ7VAEKEmdDb5YXOcp7SpLMdKFr
         6aWvtYfROc3ACdxGnWXN7TPV8/+MCJmkYw/VuNgxN7kWiwawfhzbA+yQBhNgNWUv4CO8
         7ZnLkGNe0+PP0KmW7CHXx0kKMEFsWgya8SvMSyVEYakNP47ONHD2fzc6K9QGcXcWcHOo
         oxaQ==
X-Forwarded-Encrypted: i=1; AJvYcCVR2KvLeSPqO57gU+dONVpkTBhC/f3DOKmvsQatWDMqxGEmVJJ4zQhDgvrEXcR04P3i6eymuanRAKiq6UU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyI2uPPdvFrvjiVpM78hLh+wZl6pxsnU4N8I7wdnx2odjHXBqPV
	0Gfw1F9KDPR0Kl5UCF8suIS3lSdTHP+Za38WAVHg6NHkyRCZqAbWAr5P
X-Gm-Gg: ASbGnctoRTVvO/73LRcm3AGGIDHsTQ7w8NjW526/QpynrzTSne5ADeo6fH21E41D8I9
	HYmSzcnUJCDMWMPOSR90VVlMns759hi2DUWLBJ6iG3gVcxnoq6R/FzdX+2s2tHEYo4544286nhw
	5x+wN0vkHwXoc5lmtfMiRxUaHMcUlNkXOjEAnlbiP5VlTxpybPqRv/+iMihOtLwNR8zzJvXOC4y
	g6qROXW1vSzlM1GX4ILye+nMlBnpwe/Pti99jN5uqODU3gQ5VW1EGI3Sl/7gvQzymsCaUBWzN5/
	Bs/sAbjhVuZ/I70+iUiwZeEcjhg7+1hNpwh9hnvjp3RXtTabJ8zy9GWn71m4CkCoCqbuxxIQXXj
	bweAr3G9XO7rHYdJUCap3JgkcWgDaByfxHlKB9kFg+bjlETBXqGoTqUy12k3Dg+Rw3oh5stBKZF
	TK91tw1wkFNODczGz97oMzo/uuhg==
X-Google-Smtp-Source: AGHT+IFcYo/fAegdA2C1gTxKem+CDCv348ZEZtfdFlF8lK+pytqmCXrWbosTkVJ1I3pvpi+J3kCQTA==
X-Received: by 2002:a17:903:98f:b0:277:3488:787e with SMTP id d9443c01a7336-290c9cf8e7fmr138965325ad.12.1760918418408;
        Sun, 19 Oct 2025 17:00:18 -0700 (PDT)
Received: from [192.168.0.69] ([159.196.5.243])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-292471fdee2sm63726695ad.92.2025.10.19.17.00.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Oct 2025 17:00:18 -0700 (PDT)
Message-ID: <f0f97b8980fb141849861e67132dfffdfef4771a.camel@gmail.com>
Subject: Re: [PATCH net-next v6 1/2] net/tls: support setting the maximum
 payload size
From: Wilfred Mallawa <wilfred.opensource@gmail.com>
To: Sabrina Dubroca <sd@queasysnail.net>, Jakub Kicinski <kuba@kernel.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, netdev@vger.kernel.org, "David S . Miller"
	 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
	 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jonathan Corbet
	 <corbet@lwn.net>, John Fastabend <john.fastabend@gmail.com>, Shuah Khan
	 <shuah@kernel.org>, syzbot@syzkaller.appspotmail.com
Date: Mon, 20 Oct 2025 10:00:11 +1000
In-Reply-To: <aPAjm1tKMKxIdUlj@krikkit>
References: <20251015015243.72259-2-wilfred.opensource@gmail.com>
	 <aPAjm1tKMKxIdUlj@krikkit>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-10-16 at 00:43 +0200, Sabrina Dubroca wrote:
> 2025-10-15, 11:52:43 +1000, Wilfred Mallawa wrote:
> > diff --git a/Documentation/networking/tls.rst
> > b/Documentation/networking/tls.rst
> > index 36cc7afc2527..dabab17ab84a 100644
> > --- a/Documentation/networking/tls.rst
> > +++ b/Documentation/networking/tls.rst
> > @@ -280,6 +280,17 @@ If the record decrypted turns out to had been
> > padded or is not a data
> > =C2=A0record it will be decrypted again into a kernel buffer without
> > zero copy.
> > =C2=A0Such events are counted in the ``TlsDecryptRetry`` statistic.
> > =C2=A0
> > +TLS_TX_MAX_PAYLOAD_LEN
> > +~~~~~~~~~~~~~~~~~~~~~~
> > +
> > +Sets the maximum size for the plaintext of a protected record.
> > +
> > +When this option is set, the kernel enforces this limit on all
> > transmitted TLS
> > +records, ensuring no plaintext fragment exceeds the specified
> > size. This can be
> > +used to specify the TLS Record Size Limit [1].
>=20
> Since this is now "max payload" instead of directly the record size,
> we should probably add something to describe how to derive the value
> to pass to TLS_TX_MAX_PAYLOAD_LEN from the record size limit:
>=20
> =C2=A0=C2=A0=C2=A0 For TLS1.2, the record size limit can be used directly=
.
> =C2=A0=C2=A0=C2=A0 For TLS1.3, limit-1 should be passed, as the record si=
ze limit
> =C2=A0=C2=A0=C2=A0 includes 1B for the ContentType.
>=20
>=20
Good idea, I will add this on.
> And possibly mention that TLS1.3 record padding is currently
> unsupported, so whether it should be counted in the value passed via
> this setsockopt or not is undecided. (I'm not sure we need to go that
> far. Jakub, WDYT?)
>=20
>=20
> [...]
> > +static int do_tls_setsockopt_tx_payload_len(struct sock *sk,
> > sockptr_t optval,
> > +					=C2=A0=C2=A0=C2=A0 unsigned int optlen)
> > +{
> > +	struct tls_context *ctx =3D tls_get_ctx(sk);
> > +	struct tls_sw_context_tx *sw_ctx =3D tls_sw_ctx_tx(ctx);
> > +	u16 value;
> > +
> > +	if (sw_ctx && sw_ctx->open_rec)
> > +		return -EBUSY;
> > +
> > +	if (sockptr_is_null(optval) || optlen !=3D sizeof(value))
> > +		return -EINVAL;
> > +
> > +	if (copy_from_sockptr(&value, optval, sizeof(value)))
> > +		return -EFAULT;
> > +
> > +	if (value < TLS_MIN_RECORD_SIZE_LIM || value >
> > TLS_MAX_PAYLOAD_SIZE)
>=20
> For 1.3, should we allow TLS_MIN_RECORD_SIZE_LIM-1? The smallest
> valid
> record size limit (according to rfc8449) is 64
> (TLS_MIN_RECORD_SIZE_LIM), so after userspace subtracts 1 we would
> get
> TLS_MIN_RECORD_SIZE_LIM-1?
>=20
> (but this would bring back one "are we 1.2 or 1.3?" check :/)
Yeah I don't think there's a way around this...? I will update the
description to specify these details and add the limit checks. I do
think the payload size approach makes more sense, since, it could be
used for reasons other than just `record_size_limit`.

Regards,
Wilfred
>=20
> > +		return -EINVAL;
> > +
> > +	ctx->tx_max_payload_len =3D value;
> > +
> > +	return 0;
> > +}

