Return-Path: <linux-kernel+bounces-789366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EAEEEB3947D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 09:02:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 938DC982A6D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 07:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B350C2C236C;
	Thu, 28 Aug 2025 07:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p3WexPG/"
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A832DAD4B
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 07:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756364518; cv=none; b=YjNGhgERuDMV2kfEYbwdvfJ+3H5x8PmJMT8kRs0z9cyCvQUd9/qjYqMFA3cNl7fjWpMiluuZ25wOjAPEOZ0LFXdlcGQJhLA/MR3AirUrAvz81bCXIetcaTK2cKMx1R0krVtBjxXVcs+xutDFIib2IjzmVdtny36J45BtnU0bnyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756364518; c=relaxed/simple;
	bh=x8bkbcL8+tGdys6jSOuE1Hg0Fct7/lC8B1m1J0kB+9Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EkZe4KmgwjtHSbM/A6JrT0ZixMLB/NPO0Tg/hnWTzRSL9Nztg0YS4lSMwQcReYoDRl26pyJwXVn7YcV1tQdAS8ijewV6Ggv5gPIceAbvXzS8fTG7aSDl+u2tTwmGfnic68fbxZEC1LR7V6brvHkRDGTOBQS424ElM8YsXwyk5vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=p3WexPG/; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4b1098f9ed9so5386671cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 00:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756364515; x=1756969315; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UM7DhkEHuk4qSj2m07G7Dl4USkQpCM4utkZ1N2+QBlk=;
        b=p3WexPG/Q8gaSfPUix1wAcrd3kH4zTMhhvIIq/TEZ2Tf9xE2PC6a+4XXxMSQMG+pCe
         WTJrKz/C2z7EYaSh8XpCf9SVYfYeVRjPQuRVsJ6b8wlf8myfv0CDGll1F5K+JtM6wmtn
         iT6jkyxL+ku6ZPHMo2IO6DiNcZ2njPxEZoH7DTqBohvZZhsHEtJKJuadJRwJOQuzXu+u
         T3WvaSxsE/LHVZ3sBWJodRqZAlCwTM6iE05Mq8nkELQ6WcCEoDv1I2HXPqSGmp8pzXyh
         2/sC++uhKx1aVRO7iCmHVsCZJ6RqayJxmVk+CGbrlO12ijdP68qJ2OzpOPgbTmBF57Za
         JL7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756364515; x=1756969315;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UM7DhkEHuk4qSj2m07G7Dl4USkQpCM4utkZ1N2+QBlk=;
        b=k3qIWBxzU4+vDoFzMQ+V7LUVsMaLAOfBssMj3WwKL0mOj6dIZdo3dgxHETiBSoz0fG
         2qgvf9FzWX/CinKceqSy/A0ZNv2EdpZVu5Z5ctux2JvLlcVxEXgv8CxmRPuYN/aOANSD
         DA9dWtJOM5vQouSep85rcFN+4rC4Wci0UbV6p6OhyFEPnHbQpqqX15T6AwjGF4HamQ77
         YWCfKeHUILqSl9oc58Y5LOuVUnzeHT4ed4ulIaFKEOgBNH0Lr4P8UCN86b2PkaHsROZX
         cjyfiqQlONKDgLl94QVSUjAvzlU/PjKZLbwbbtj1o4qOHByUnvUIQmHDNIuK4ytqgR26
         RQwA==
X-Forwarded-Encrypted: i=1; AJvYcCV0KGITm9Zo1DJUc4w/wiqdKaah1pJw6vYRUba8RQbxblJLe2OanfE6o+uzoEsqpucrokyVM6/NcHz21JI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7hRyi+GQ15FiGvOrIvhwGjoP6FIhZvTcNGBaP9XXaBt55xqIe
	+P/j2rtU+yTu5im+CSrjip1k944dfE84RdA9umbrOHKzdm9ozyps0WhSAZtMcBLvVuPBDOgJk4j
	3yiEYeuW4bbQtUg+VOUIRRu8+ATlszUPDCov8OVuo
X-Gm-Gg: ASbGnctDuliYRkl6oy+KEithfYm61tiae8taECsXGnYwhqHtmoAYu3bQDywZP6bhXKV
	/E5HvCDJOlGoz5IFqz2/RFsXRUvSNDeO1HH4xTbGGGw9qF3PkBSNFSmv+9GUA97HzUSU7D52v+2
	OaJRXnBHWVp6x+HP7/AxsA7G5fcQYO+2EiIC4rV3ClsCbb2++uxTy4prTsqKG4AyW6v7pGCKnZU
	ypL+xO+L38=
X-Google-Smtp-Source: AGHT+IHBVxWxWSHO+aK5wpbDFa+mZB5wQcUM810HgKp52eoaZy7vbiDehRSg8/y4lSbH1rCe1G5yO/bjvIOteA5XlAE=
X-Received: by 2002:a05:622a:995:b0:4b1:4fd:2752 with SMTP id
 d75a77b69052e-4b2aab44efdmr304122441cf.58.1756364515219; Thu, 28 Aug 2025
 00:01:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250828012018.15922-1-dqfext@gmail.com>
In-Reply-To: <20250828012018.15922-1-dqfext@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 28 Aug 2025 00:01:44 -0700
X-Gm-Features: Ac12FXyrxU3v8TM23-pL8tHyMIrcYye69o8X_1GZcfqchraqv_my8wEdCPDPvGI
Message-ID: <CANn89i+WjMR7kcGkaQvF5YaCiZxa6txMyQvvVQf8rcU7_u9_JA@mail.gmail.com>
Subject: Re: [PATCH net-next v3 1/2] pppoe: remove rwlock usage
To: Qingfang Deng <dqfext@gmail.com>
Cc: Michal Ostrowski <mostrows@earthlink.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 27, 2025 at 6:20=E2=80=AFPM Qingfang Deng <dqfext@gmail.com> wr=
ote:
>
> Like ppp_generic.c, convert the PPPoE socket hash table to use RCU for
> lookups and a spinlock for updates. This removes rwlock usage and allows
> lockless readers on the fast path.
>
> - Mark hash table and list pointers as __rcu.
> - Use spin_lock() to protect writers.
> - Readers use rcu_dereference() under rcu_read_lock(). All known callers
>   of get_item() already hold the RCU read lock, so no additional locking
>   is needed.
> - get_item() now uses refcount_inc_not_zero() instead of sock_hold() to
>   safely take a reference. This prevents crashes if a socket is already
>   in the process of being freed (sk_refcnt =3D=3D 0).
> - Set SOCK_RCU_FREE to defer socket freeing until after an RCU grace
>   period.
> - Move skb_queue_purge() into sk_destruct callback to ensure purge
>   happens after an RCU grace period.
>
> Signed-off-by: Qingfang Deng <dqfext@gmail.com>
> ---

Reviewed-by: Eric Dumazet <edumazet@google.com>

