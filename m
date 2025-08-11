Return-Path: <linux-kernel+bounces-762645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E96CB2094C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 14:51:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5082D161989
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 12:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 648182D3A83;
	Mon, 11 Aug 2025 12:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hFPBGwUj"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B1D223E23C;
	Mon, 11 Aug 2025 12:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754916655; cv=none; b=sJVt8tDOrik3K05QoXPEt898g9QTvzUwq/LYF2nkdsbscZmqw16GaKzMzHoWqvZ1hBeueAeoRvPaa6sf8+WHFyN7obOYoiJOVHziNtip0f6y7IBvXzlOG3t99o9JeZsmTGDsN5aQNuqRp+o/oF3iP08tawMIO4ITTLyGc5K9eG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754916655; c=relaxed/simple;
	bh=d2sHLHvSVyFklgV1qgK42wPXdASR5TaIWwfAj0DU+lE=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Szypmm5YNqYKb+xL/Dh4bLhC5XLbnxvLLAByXi7YltfIFGrcDoUHd6K6LwyeL6FXiYMTlhNMoAeyVvmksTjMhR0iydV3x/WkTu655GB/t/DS1BO/nzSD9EdhoBouH2Mr/JUQesY2BopPCvtRACmM72QNwFND0GT05eGHUz9Cy4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hFPBGwUj; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-32106b0930eso4483599a91.0;
        Mon, 11 Aug 2025 05:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754916653; x=1755521453; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ihtOm1TaCpPd/gazvBdb1QnrfCHqjlh2aMsqATTPojM=;
        b=hFPBGwUjQyf7fhL673oTrM+9MKl8SXjCHLrrA87U+OzbEaxh1QHTGObiMsiWyyygLL
         4iX8159p9ZjzAUK0COdbpP7xMNetW6iWBjffpcGSJfvatouexGtfjAgqpDT0GK85zA1a
         2sSNu9BtEYfwmNyDfrou+jgwByeV86zXuAq0i8HH/6hwR/t/WKcKbX8ozRfFPWQ26Sxk
         ons4BbD3bO548oO7AwMwyMg1y/qr84rjbowl4dZCdbFDaIhtpbvoVIiG/jY/EHhUHtpn
         PVEkIMP287zbHs/4Htnr+ROI+eBjIYy6Ai5vuVnSVZ9yqqh655jgLW/lSKwOWjoMozoM
         0JIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754916653; x=1755521453;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ihtOm1TaCpPd/gazvBdb1QnrfCHqjlh2aMsqATTPojM=;
        b=uk712y7y6d22VA9mLSOpqeO5R3cFTJI7BCiO9u582E7wxBwZrPfwQImpOMgX04ixbd
         SvMAyAT/EW3T/EcEes09/WKDWLo0Z5MPqonOpxEwPcRev/v2YMObBUuKlr6TwW4AyexY
         vk0cgLQmH6dVPIQQFjQjvTKDx17KkIzgb/CsnbIBPXv7BMu7+dWcEfs50fzqCOrmCJFV
         Oinz3yNWmguW1dVCwT9hqpTZMQ6L3QjMOi0yAWRnfTEu/pOvbDrOsT6KVchviz/OYUV1
         k6JaDCvjYvveSH6IKdsT18py8P+9pf2CNneVgjuC5FHvNlVy2kC9NKGrGHuC8vwWpFdH
         ce4w==
X-Forwarded-Encrypted: i=1; AJvYcCVOManVX23nzsb4ddnRibYN+Q+gWMhXtn24yYPJt405sMaxhls/R9WM2GQR9kHpeUxxCLIP6NkDIOjxnFlS@vger.kernel.org, AJvYcCXBv7jQ7gSVDaN8nokcew5AEpekVx0c9geOyQDLWgsQmcHJ90G5G/10WdfxnA69oAHtGYOZOOAhBskM/+Yzbg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4sTnRlXVwwapxOBLw+MWDDTvt+X6rEm/caul9r4rRCVSpO/TM
	iM0zxemEQpQJXaKHb+VY+ATFMloCqjrW7qwxONjTFv4Bm7w1ljFVeFie
X-Gm-Gg: ASbGncuAzka6dtzM8VFme3D8duORewtkd0C+fRbcXKuqHJhv29aK521PYdWXiNMqTOb
	pOaq7qVIVSzDeZa6iyOnGRvei0MHIEJGJcxTlSis9c9luTbeRZYJ+AN1FOl7xulg/sLqrlTYo56
	SPUwxtrG7Ze/iqNTN/JdFMaOcaOWEAKyweLjZmdnLjoAoFCAlne6oQRokXH2DrdozvTRhfBh8r+
	17PO9DMc0wLKbhlfBbbc403QZlLravqHTTgY2+SyZGpvXK9bisJ45ARWL2GwQKMHztu+mpXSKo5
	b191LalapIfwQHXfyAmUWGiX8oL/TKYTlUu6ld9q/EUY6IVLcqVLAG4ccfQdR6jrOy8Xwq86bBs
	QPhm+ZdRo/jY=
X-Google-Smtp-Source: AGHT+IGaHyPmUwKo8OmiJUqdlMZ27Rh9nG7dnmsX481OiC0VxYWNIz3snAzLp4+BVsBHjh3wAB435g==
X-Received: by 2002:a17:90b:1a81:b0:31f:69fd:a72b with SMTP id 98e67ed59e1d1-32183e6d980mr18251243a91.29.1754916653458;
        Mon, 11 Aug 2025 05:50:53 -0700 (PDT)
Received: from smtpclient.apple ([2402:d0c0:11:86::1])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31f63dc1bb7sm31576999a91.10.2025.08.11.05.50.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Aug 2025 05:50:53 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.500.181.1.5\))
Subject: Re: [PATCH 1/2] bcachefs: Using vmalloc_array() for array space
 allocation
From: Alan Huang <mmpgouride@gmail.com>
In-Reply-To: <20250811120953.529864-2-liaoyuanhong@vivo.com>
Date: Mon, 11 Aug 2025 20:50:37 +0800
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
 "open list:BCACHEFS" <linux-bcachefs@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <1EB1AD1A-C14A-4A1F-A97B-55F956D241E7@gmail.com>
References: <20250811120953.529864-1-liaoyuanhong@vivo.com>
 <20250811120953.529864-2-liaoyuanhong@vivo.com>
To: Liao Yuanhong <liaoyuanhong@vivo.com>
X-Mailer: Apple Mail (2.3826.500.181.1.5)

On Aug 11, 2025, at 20:09, Liao Yuanhong <liaoyuanhong@vivo.com> wrote:
>=20
> Replace kmalloc(size * sizeof) with kmalloc_array() for safer memory
> allocation and overflow prevention.
>=20
> Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>
> ---
> fs/bcachefs/btree_key_cache.c    | 2 +-
> fs/bcachefs/btree_trans_commit.c | 2 +-
> 2 files changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/fs/bcachefs/btree_key_cache.c =
b/fs/bcachefs/btree_key_cache.c
> index 4890cbc88e7c..8dd70024e513 100644
> --- a/fs/bcachefs/btree_key_cache.c
> +++ b/fs/bcachefs/btree_key_cache.c
> @@ -136,7 +136,7 @@ static struct bkey_cached =
*__bkey_cached_alloc(unsigned key_u64s, gfp_t gfp)
> struct bkey_cached *ck =3D kmem_cache_zalloc(bch2_key_cache, gfp);
> if (unlikely(!ck))
> return NULL;
> - ck->k =3D kmalloc(key_u64s * sizeof(u64), gfp);
> + ck->k =3D kmalloc_array(key_u64s, sizeof(u64), gfp);
> if (unlikely(!ck->k)) {
> kmem_cache_free(bch2_key_cache, ck);
> return NULL;
> diff --git a/fs/bcachefs/btree_trans_commit.c =
b/fs/bcachefs/btree_trans_commit.c
> index 4d58bdb233e9..4102a3cb2410 100644
> --- a/fs/bcachefs/btree_trans_commit.c
> +++ b/fs/bcachefs/btree_trans_commit.c
> @@ -396,7 +396,7 @@ btree_key_can_insert_cached_slowpath(struct =
btree_trans *trans, unsigned flags,
> bch2_trans_unlock_updates_write(trans);
> bch2_trans_unlock(trans);
>=20
> - new_k =3D kmalloc(new_u64s * sizeof(u64), GFP_KERNEL);
> + new_k =3D kmalloc_array(new_u64s, sizeof(u64), GFP_KERNEL);

No, it=E2=80=99s not an array.

> if (!new_k) {
> struct bch_fs *c =3D trans->c;
> bch_err(c, "error allocating memory for key cache key, btree %s u64s =
%u",
> --=20
> 2.34.1
>=20
>=20


