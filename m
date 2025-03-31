Return-Path: <linux-kernel+bounces-581805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DB35A7652A
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Mar 2025 13:48:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CF8C188B255
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Mar 2025 11:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3BB51E2823;
	Mon, 31 Mar 2025 11:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EdKnZb6z"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7151E25F2
	for <linux-kernel@vger.kernel.org>; Mon, 31 Mar 2025 11:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743421679; cv=none; b=P1EVjAl5Kb0FUR6n9jnbO26BGmDJzBlApyZ3XMoI7PKMkz7XwqSIH+/wy0FPsClsgrd0SZ2B+FVTvbRCbvDId5kGJLcfCwcojS1McNuxhd2PqNDO3fRJMnJomDyQUPw/3Zy5YchMxQ4uVjzy1NrLerAa2gWgVCjNWL/cLSUbSPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743421679; c=relaxed/simple;
	bh=pArKK9G7xodDbemAOrxPr3k38aDwYAqpgkxAXEAWrXM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B/1kvINIanb6gXU8eYI4aV6YRH538JNDUD9V9M0iOfbZ8/FPqCmz/m2Rs/kdUHqRHB668b/LGqOKFgNmO2pqWoIHLZ3ENJ6ka27MNgYinIuCq4+sCEPNC74+bhrhL3ZiW/uFtPrmf6YhFiH+gpNmrFSVJNraaVDdcnlmNft/9iE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EdKnZb6z; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743421676;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pArKK9G7xodDbemAOrxPr3k38aDwYAqpgkxAXEAWrXM=;
	b=EdKnZb6zkUKjBIu+rJcTmCga2IeX5wB9MnZM60mRPZJ93+wvEDa2EjeKspOP6qXu+HdMPs
	yVAlmrMZGUSqKJ5p6KW6p/aVqkhL8bp3Ibjb5PMbr0DDhoHr6kwKZDWMIK+o9A0JkB7/Bx
	HhDQAiqkyAmGBvpFf1ue2kxDwnQ5jxY=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-312-EGXLr96YPe-ZrG170BSXXg-1; Mon, 31 Mar 2025 07:47:55 -0400
X-MC-Unique: EGXLr96YPe-ZrG170BSXXg-1
X-Mimecast-MFC-AGG-ID: EGXLr96YPe-ZrG170BSXXg_1743421674
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-5e5c76fd898so3524350a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 31 Mar 2025 04:47:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743421674; x=1744026474;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pArKK9G7xodDbemAOrxPr3k38aDwYAqpgkxAXEAWrXM=;
        b=gp8rWASPLFQx6uwGvOvY6jzJxOIx4SuxMmPE+Hhrbv6CXRWGmIil1iWNdfmed+hPxM
         mQTJmrPkovyZecDYOKrv/tEnzz4G1gcuqfY2rJ2/Zwl3X4Mj5EpbQ4KqZHVO/B+Nf3N3
         5oj+qRLzNAXumE9WtuUItaCDN6kvPylb0WZ5rhOS3/X2BTWPOo8hKT6/fihgW9sHrvFk
         +SAs/zq8yDlL/b6YdTvPJgTIY4tkJ+aR4xOa25qjjyh3b7Wlja/JRiCNKEGUJprAzwIV
         JlVpdyi8MdEa5tNKx1ogyK41IgEixB5bW3YdOUppkNREfqSBU7Wz6Fk2Oe8XzidT7wDf
         a4zg==
X-Forwarded-Encrypted: i=1; AJvYcCX6qLEDmbBusD5wkhbsHQ5AwJgT2czCc71Ob2RwwhpcRg2Y1nY6wKHXHupItNF6/3kJmPHQTxJfhohk38s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMBrG+D+coH5AsI8ftu8+IeJ0l3w+Vx9Zur9Wc1mypC17RbVz1
	BHrzeJqwr7JySYpxXj91RJF93bl/uyO7NmV5548Ucp0baw8C30UetqYEBgXOprIwHNsxHYoI0Rb
	cBtxlYGay/20l6TmZgrH5PUBBqamReHlKgAzFRG3NXhYezOQ4Zd3fjBEXtN61lPiS6Bnqyz8035
	sziC6PG0XbpYKMR/+lWPKAVp0Doim8ZCi+9Xb0
X-Gm-Gg: ASbGncuAlNrd9hKJ5frHEO+vr7o+v0k9tEaa0uBD8VhfnahD3iplrfftpKZzgKnxzxg
	0r4XJIwyvzxGdmOsv20qngHak9BZVel5Sy3+toktcoasfyDIfyRWyvQz7E/lmYIeZrHU97jPkVg
	==
X-Received: by 2002:a17:907:7e88:b0:abf:4b6e:e107 with SMTP id a640c23a62f3a-ac738a374efmr776687866b.25.1743421674146;
        Mon, 31 Mar 2025 04:47:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFRmb2sP6u1Kcqc9voC0cuFc8cG9X4wanJkzT5G0J8qfH5D6leVLiwsM+zFjfRL7h+LKaFEAz4OgYXd5DAAjI4=
X-Received: by 2002:a17:907:7e88:b0:abf:4b6e:e107 with SMTP id
 a640c23a62f3a-ac738a374efmr776685266b.25.1743421673726; Mon, 31 Mar 2025
 04:47:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250327134122.399874-1-jiayuan.chen@linux.dev>
 <67e5be3c65de3_10636329488@willemb.c.googlers.com.notmuch>
 <17a3bc7273fac6a2e647a6864212510b37b96ab2@linux.dev> <20250328043941.085de23b@kernel.org>
In-Reply-To: <20250328043941.085de23b@kernel.org>
From: Lei Yang <leiyang@redhat.com>
Date: Mon, 31 Mar 2025 19:47:16 +0800
X-Gm-Features: AQ5f1JpaEdK08-KL1Gf8Ek3oojs8QnopOUqDVrhQ8D9XsTzqJ71WtMtHpHShaOE
Message-ID: <CAPpAL=y2ysE6jJgVYAOOx9DQXOYkR627LF1nusb2-Jwx6gXR8A@mail.gmail.com>
Subject: Re: [PATCH net v1] net: Fix tuntap uninitialized value
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, netdev@vger.kernel.org, 
	jasowang@redhat.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net, 
	hawk@kernel.org, john.fastabend@gmail.com, linux-kernel@vger.kernel.org, 
	syzbot+0e6ddb1ef80986bdfe64@syzkaller.appspotmail.com, bpf@vger.kernel.org, 
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, kpsingh@kernel.org, 
	jolsa@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

QE tested this patch with virtio-net regression tests, everything works fin=
e.

Tested-by: Lei Yang <leiyang@redhat.com>


On Fri, Mar 28, 2025 at 7:39=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Fri, 28 Mar 2025 09:15:53 +0000 Jiayuan Chen wrote:
> > I'm wondering if we can directly perform a memset in bpf_xdp_adjust_hea=
d
> > when users execute an expand header (offset < 0).
>
> Same situation happens in bpf_xdp_adjust_meta(), but I'm pretty
> sure this was discussed and considered too high cost for XDP.
> Could you find the old discussions and double check the arguments
> made back then? Opinions may have changed but let's make sure we're
> not missing anything. And performance numbers would be good to have
> since the main reason this isn't done today was perf.
>


