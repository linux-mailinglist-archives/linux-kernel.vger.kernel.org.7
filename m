Return-Path: <linux-kernel+bounces-882853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D3986C2BAF5
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 13:34:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 134E54FA467
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 12:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16B2130E856;
	Mon,  3 Nov 2025 12:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K1NT6mGN";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="m3IxmIyC"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E403330CDB0
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 12:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762172687; cv=none; b=JqzfKGJ70Pt1DKTRvzqf7pEYA5zqRBI7h8PWU+Fa7cwTT5XAFEHhRzHb/Rn3HYsRTGpkA39bpu78Xf9Xb5o0gL8C112wG3WrE6GdNo7AF4Eej7X3cGPPOqG4aak18k+w/C6SRc4WQ1AlqfoJPmPC7t6BGCkbEMXfDpXQWSTgJ5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762172687; c=relaxed/simple;
	bh=0sL3Sqt4pPtcdmPcFr1YF4MWNWB4MKnWEylQFPolhFs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=C/EyDq9+Z+j+5WF+W/xs8JXJ+lm34BABUjyPeOclCR+J71KFle0OrUWwck4x+B9LNEJwyXAxAje+vUs8tMH4fFbJDeVb/paButt39SHQU9Cp9ZSxdGqoqox5pnkpuk7Vr48XlrEP4k/F/G65xtfAqNISVk8y7WS79+7paeIOzM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K1NT6mGN; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=m3IxmIyC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762172684;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GjVp41+JcRNlhKhJQBn7GbDkB8mn6fWxcVLv0a89y4U=;
	b=K1NT6mGNNof/Q5pobPO0rhIiv5DEWcaPTwXaF4ungMPM9ox4T36JwtuDuV4ZpIIITvoRGF
	efOQZ8SR5aQQHXbohGQLehGLUhVi70PVcs9wJZZRhDjO6Hmm5Wbr78nfdAK4KO5+fcVwgP
	RUSRPSewj0lcNuHLYnsYGrXcwIaRR9E=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-177-LvEpaJxxMUWgacZNMrgtCA-1; Mon, 03 Nov 2025 07:24:42 -0500
X-MC-Unique: LvEpaJxxMUWgacZNMrgtCA-1
X-Mimecast-MFC-AGG-ID: LvEpaJxxMUWgacZNMrgtCA_1762172682
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-b7070cef38eso428208366b.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 04:24:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762172682; x=1762777482; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GjVp41+JcRNlhKhJQBn7GbDkB8mn6fWxcVLv0a89y4U=;
        b=m3IxmIyCpZtxOZ6ZnC9IsL+UpdHCeEAFO+a+UgYr6U67L+yQgbEpqsUMhU2hEFo3N5
         f2PGIned76BiMzzo/XMQYMrQ693HF1wYbrj7Dd8cC94bzEt0ONtOHSiWfI6ZlJWjZdnj
         eveZv1xsS1+kiqLlAAcVuk6ufAJSEJO40OK38pQXw2qHPlTZ3rLDcCaljO17r9wIVl++
         t4qZZuUHfNjEB67HM4pQTBsd5Bsr8bPsGXYxb6gQOeB083j/MBFAj4Qrwib+YWxtKofo
         s5oDMqMYVnYfjx5d2pvpr00oyBg4sXFQupEjsQsXYbaL67K+gjr/Dje8NtVDck3Uh2rx
         jWRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762172682; x=1762777482;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GjVp41+JcRNlhKhJQBn7GbDkB8mn6fWxcVLv0a89y4U=;
        b=OpRe28oXnZpgyinAkG6DQnz/5VlAdm+F07aAJtrmwUEf+q7zcNfi6dt8KwSHS2gc1U
         l+uY8o5Gs80pH8Gfrx+0OA+TDw+ixZUqBjHKLDpG56hTjV8za2Pu6yfvMUQsIJ0sB0/R
         D3ZMkEuKFbyQqj72CGMRyWBPjNGQsxnTNKS5erub8h8S35UVVantwyGF2C43rd3v3c31
         jLzlVX0sDoqIMa88t/sJQbPQtVOGAvrEYsVn7FTbUtNjid2Pspeui/rr/nopTKzmQ1SD
         t+rINZx4+6AK5mVTBwpEt61+3kXNTLMhO/+fQHjBCb1oLX55WiQR6l552ARzjNR/Y4p+
         Qp8Q==
X-Gm-Message-State: AOJu0YwSmvhwj14tEciKVVv/4VOA/0lxiEwAuOd52odn6WB4BotKX+0l
	2vWAr+fE+gtnW5r1Hr8Rpg7eQDdTaoCYwapAaqNWXw+lsNpK7AONiD6DDlnYzw60+i2nN+NhRue
	Y4r6tia1h+NF0SNmANmIN1czi8QT7nh3okKjb+avyXw1GUlrLoQKH2yRQo0tux5BqQA==
X-Gm-Gg: ASbGnctw/I+XU++pcq2UebIpvUJ19RjTSHS+MeMEoNcNTRQTep9o17+3ks06zrgsouZ
	ro8bv3c2dUcyMMa49mphRjY9YATVfXK70I9AN39U/B9dvQHaNWDiFvl2c8HDEhJ3rpjrYXUwzOU
	fREg0J+XzMzLIc1+7qwckIJoLiy4B99KJ6Tc6FWa/tYOjSYDCcvJ86zwMQ85HXzX/9OcnIzGRZf
	CLqzpIWknpqRGLDpbeS4VplxYy2Wb0BIR4JXViLHGCoSosebY2bD2gdNqYBp/Ft+pRrAxhf1RMl
	2NiyjAHMAeUyh4AQWv1P5UbObNoG72Iyd5zTjEk1/Gn0yGy3dV019aMQ/iUWdWVS9UUFiW9WlqU
	iqnY1Ve70U4HsEjlNZRHiY0g=
X-Received: by 2002:a17:907:6d20:b0:b70:b83a:73e5 with SMTP id a640c23a62f3a-b70b83a8c35mr359782166b.44.1762172681699;
        Mon, 03 Nov 2025 04:24:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFL2sLtytpLuUcKWCOkoRDcXckWNNb+evONxAWiMkrqYHa0li9xt3zPEufFR+6cGkgmgzhx/A==
X-Received: by 2002:a17:907:6d20:b0:b70:b83a:73e5 with SMTP id a640c23a62f3a-b70b83a8c35mr359778466b.44.1762172681211;
        Mon, 03 Nov 2025 04:24:41 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6407b392d5dsm9676772a12.15.2025.11.03.04.24.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 04:24:40 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id EE02432844E; Mon, 03 Nov 2025 13:24:39 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Byungchul Park <byungchul@sk.com>, linux-mm@kvack.org,
 netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kernel_team@skhynix.com,
 harry.yoo@oracle.com, ast@kernel.org, daniel@iogearbox.net,
 davem@davemloft.net, kuba@kernel.org, hawk@kernel.org,
 john.fastabend@gmail.com, sdf@fomichev.me, saeedm@nvidia.com,
 leon@kernel.org, tariqt@nvidia.com, mbloch@nvidia.com,
 andrew+netdev@lunn.ch, edumazet@google.com, pabeni@redhat.com,
 akpm@linux-foundation.org, david@redhat.com, lorenzo.stoakes@oracle.com,
 Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org,
 surenb@google.com, mhocko@suse.com, horms@kernel.org, jackmanb@google.com,
 hannes@cmpxchg.org, ziy@nvidia.com, ilias.apalodimas@linaro.org,
 willy@infradead.org, brauner@kernel.org, kas@kernel.org,
 yuzhao@google.com, usamaarif642@gmail.com, baolin.wang@linux.alibaba.com,
 almasrymina@google.com, asml.silence@gmail.com, bpf@vger.kernel.org,
 linux-rdma@vger.kernel.org, sfr@canb.auug.org.au, dw@davidwei.uk,
 ap420073@gmail.com, dtatulea@nvidia.com
Subject: Re: [RFC mm v5 1/2] page_pool: check nmdesc->pp to see its usage as
 page pool for net_iov not page-backed
In-Reply-To: <20251103075108.26437-2-byungchul@sk.com>
References: <20251103075108.26437-1-byungchul@sk.com>
 <20251103075108.26437-2-byungchul@sk.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Mon, 03 Nov 2025 13:24:39 +0100
Message-ID: <87ms53pam0.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Byungchul Park <byungchul@sk.com> writes:

> Currently, the condition 'page->pp_magic =3D=3D PP_SIGNATURE' is used to
> determine if a page belongs to a page pool.  However, with the planned
> removal of ->pp_magic, we will instead leverage the page_type in struct
> page, such as PGTY_netpp, for this purpose.
>
> That works for page-backed network memory.  However, for net_iov not
> page-backed, the identification cannot be based on the page_type.
> Instead, nmdesc->pp can be used to see if it belongs to a page pool, by
> making sure nmdesc->pp is NULL otherwise.
>
> For net_iov not page-backed, initialize it using nmdesc->pp =3D NULL in
> net_devmem_bind_dmabuf() and using kvmalloc_array(__GFP_ZERO) in
> io_zcrx_create_area() so that netmem_is_pp() can check if nmdesc->pp is
> !NULL to confirm its usage as page pool.
>
> Signed-off-by: Byungchul Park <byungchul@sk.com>
> Reviewed-by: Mina Almasry <almasrymina@google.com>

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>


