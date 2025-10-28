Return-Path: <linux-kernel+bounces-872890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D8058C1289E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 02:27:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0BC604FD4D6
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 01:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CDD3224B12;
	Tue, 28 Oct 2025 01:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HyzJw3wd"
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35CA64C6C
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 01:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761614756; cv=none; b=PHjXHjLHDgVjeyYCGhCKiMleY3rk6AlVSnJOEQcjZCqxTxrNiX8okywUAArtbkGWAA+PVToSh3HYNvlYzlzpZvh7/8yGxALyyCUG1Nu8i3o1wSlEx4zMVF8+CWJGohT3wrwyln2KaqJxkPmDqgDAHCB++PDIqHUotEni1u4MGOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761614756; c=relaxed/simple;
	bh=ywd+nRpAGTiaVQINUv/TgRZUFQCJClxYOhlWAyBWtdw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PtaUcLRYVuUNmQbaSIO0eNbih5mAXiq1kQ3XukVqP/UolysOQ+7EmXcYslgCVwla2/53PgDQPXK+ivpins+Tbj3edw2FXP+LHFY702Eoqk15BAfzUqWtTX8IeiIAZR9bXbea8GKDdSi6LSYujMzvOdk7S13K7eM8aylUBQgXDxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HyzJw3wd; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4ea12242d2eso119491cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 18:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761614754; x=1762219554; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6+IhRzMSNfrWbx9v4qoylhMH03PgpLB+fsJBfp3BHIo=;
        b=HyzJw3wdWeYBunTcMnkz87mw/GU4wDc7GQzDVRA7sFOlCDYzDPcERjPgBsPqrfPhS8
         MrVOJ7AqD2X2V1XfOJ2M7hM4oRdRI9xgAehIsQajES7y3QWs51UlKGw7BTjNuCp7/5HD
         olW+1dHh0WjQrAjZcnTs2i7Nfvi1gZ4JI2nIxJ6u3AwpDjruPXz/X4bwQlA9At2BTcGL
         wblkjMCS0bPAQpDabL7yV2UJOYBe+I6P7mNvS/cmOQITrjjji75GA0GxbdeB9O/Of5tP
         B1EtAm9jfLzQLonYVFXzuPPqLp9adcevjyUr7ULbUXSYfTi0pJLxZRjBg0bwIoEH8zqw
         znPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761614754; x=1762219554;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6+IhRzMSNfrWbx9v4qoylhMH03PgpLB+fsJBfp3BHIo=;
        b=Qg1qYzGkDH0CUHcmmy3ZZd8k0muhKETmyeYgRItfg1M5Dl1jm9JS8lZd0oTiZGwtBR
         CCuNFz9dqdj5kNLDv0txTysTmBWI4dL8YmHu7Mv+1ZmgLvWVVRzk1l3DshstKrnNVy6I
         TpgucEFrmxJuE5ecLmETrw2kRnH2Qv23RBb8JeTHWCAiqSiGtWuHb24b9F2VNBxR08Q6
         zoKmsJYoTwr00hiQ5cZmatlhhsWxXose/6UJtQHUaaO2W9FjayidpgGqkH9J9yjaWPJU
         WdBXAWnUd9sy/mdBXlmP+d20wedXZBU0VCtSkglEhF/SYNaXp5OPijlepesCtUBoPMv1
         i+ww==
X-Forwarded-Encrypted: i=1; AJvYcCUZxaDjXHqJbch4f+sf4/tbCFY+MEEm0kg2N5YgQDR1u+hg3aiIrFD/gvHcWrDs2xnoas4gqxhDRQ3nuAQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdIlV96mo9ZvgMSYWp+vtxwha356BB9pULVv1cslJjbcg/x9G/
	+fsstBQHulwxJsRRIOwc9SSYnDSZIn9DtE/MXTGZyYqF88n/q808on0S6sypXQ4mfpc+FyYKq0B
	xdOfCzDvpXBzHvg59J2D1ncC00Fe2cQDElujrsB0n
X-Gm-Gg: ASbGncsBfFZVbBLIPCXEAAqFonEWQNhJtYZlxlNTbuz/WdkQIhWtGVylniUa9gyt9fv
	gTQR5HfBHaVlSIBeQv78LNlMllPixovzyDa0Cg0QWVxXLlaHlMFkabQ1we3uAGQCn52ZykVnESP
	XP9Q3LmcR1dTgsvrc0min4rZ9UpGL4Sisbvc3DHgLTJWhy+CgPbCqnm8Zus+P6eY4SMmgeMiZlp
	CVD+mDO9CKWf8i/v2S3qqRDIetCJ1JspcKp8CLPRIuQq6hUrwriA1R57/Yl
X-Google-Smtp-Source: AGHT+IGZpu7KbnVsM8kZ0fYv9D1RFyxoo19HTWIE9dDLgf5qw+saPGsXAmE1ImayYWVIS9arkPI85hHzY2/USWHgdZE=
X-Received: by 2002:a05:622a:190c:b0:4e4:d480:ef3a with SMTP id
 d75a77b69052e-4ed09f734c9mr2176101cf.13.1761614753768; Mon, 27 Oct 2025
 18:25:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251023074410.78650-1-byungchul@sk.com> <20251023074410.78650-2-byungchul@sk.com>
In-Reply-To: <20251023074410.78650-2-byungchul@sk.com>
From: Mina Almasry <almasrymina@google.com>
Date: Mon, 27 Oct 2025 18:25:38 -0700
X-Gm-Features: AWmQ_bltJKoIWK6cFNZ6Knu_i6BSq0jOkYeTZTTOB6G8J-1_KJrKj4k-v2-ULKU
Message-ID: <CAHS8izPM-s2sL_KyGyUyv37PfZxNLf029DrXpQe8fo637Rn+rw@mail.gmail.com>
Subject: Re: [RFC mm v4 1/2] page_pool: check if nmdesc->pp is !NULL to
 confirm its usage as pp for net_iov
To: Byungchul Park <byungchul@sk.com>
Cc: linux-mm@kvack.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel_team@skhynix.com, harry.yoo@oracle.com, ast@kernel.org, 
	daniel@iogearbox.net, davem@davemloft.net, kuba@kernel.org, hawk@kernel.org, 
	john.fastabend@gmail.com, sdf@fomichev.me, saeedm@nvidia.com, leon@kernel.org, 
	tariqt@nvidia.com, mbloch@nvidia.com, andrew+netdev@lunn.ch, 
	edumazet@google.com, pabeni@redhat.com, akpm@linux-foundation.org, 
	david@redhat.com, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, 
	vbabka@suse.cz, rppt@kernel.org, surenb@google.com, mhocko@suse.com, 
	horms@kernel.org, jackmanb@google.com, hannes@cmpxchg.org, ziy@nvidia.com, 
	ilias.apalodimas@linaro.org, willy@infradead.org, brauner@kernel.org, 
	kas@kernel.org, yuzhao@google.com, usamaarif642@gmail.com, 
	baolin.wang@linux.alibaba.com, toke@redhat.com, asml.silence@gmail.com, 
	bpf@vger.kernel.org, linux-rdma@vger.kernel.org, sfr@canb.auug.org.au, 
	dw@davidwei.uk, ap420073@gmail.com, dtatulea@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 23, 2025 at 12:44=E2=80=AFAM Byungchul Park <byungchul@sk.com> =
wrote:
>
> ->pp_magic field in struct page is current used to identify if a page
> belongs to a page pool.  However, ->pp_magic will be removed and page
> type bit in struct page e.g. PGTY_netpp should be used for that purpose.
>
> As a preparation, the check for net_iov, that is not page-backed, should
> avoid using ->pp_magic since net_iov doens't have to do with page type.
> Instead, nmdesc->pp can be used if a net_iov or its nmdesc belongs to a
> page pool, by making sure nmdesc->pp is NULL otherwise.
>
> For page-backed netmem, just leave unchanged as is, while for net_iov,
> make sure nmdesc->pp is initialized to NULL and use nmdesc->pp for the
> check.
>
> Signed-off-by: Byungchul Park <byungchul@sk.com>
> ---
>  net/core/devmem.c      |  1 +
>  net/core/netmem_priv.h |  8 ++++++++
>  net/core/page_pool.c   | 16 ++++++++++++++--
>  3 files changed, 23 insertions(+), 2 deletions(-)
>
> diff --git a/net/core/devmem.c b/net/core/devmem.c
> index d9de31a6cc7f..f81b700f1fd1 100644
> --- a/net/core/devmem.c
> +++ b/net/core/devmem.c
> @@ -291,6 +291,7 @@ net_devmem_bind_dmabuf(struct net_device *dev,
>                         niov =3D &owner->area.niovs[i];
>                         niov->type =3D NET_IOV_DMABUF;
>                         niov->owner =3D &owner->area;
> +                       niov->desc.pp =3D NULL;

Don't you also need to =3D NULL the niov allocations in io_uring zcrx,
or is that already done? Maybe mention in commit message.

Other than that, looks correct,

Reviewed-by: Mina Almasry <almasrymina@google.com>

