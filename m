Return-Path: <linux-kernel+bounces-853316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1008CBDB3F3
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 22:28:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B55A19A2B9F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 20:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1CCF306B1B;
	Tue, 14 Oct 2025 20:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SZec+Lnf"
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D836B306B01
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 20:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760473712; cv=none; b=syT4NLHKOjeF0Nruqpxb+lpERm1odRsMeBkCBDc2Uu66rJIbnr1lntshxf44jiremaxI6AmFA+VNmWVeMofWPS4+2xfYKK+d2PE5O501apsaMMOIshwvwJNSnZ0cfdcee0kjGZ9WP4zCHngdBfx4VlA2fdgg3gekwYRfaLHEKxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760473712; c=relaxed/simple;
	bh=pBzO/qxwMFiuodUwjnNSTjmJpn49BdXukWovp6AjsAo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HKs3HYr551ywJoK0kunqm15YMYzSOW169hHCfn9L8M0axE2AA9s8rYx2X3OKDmmGCUWJ6ussQr/EsXQ/bEDJN/uw8fg/6xihuGHG74lT1FYBBQNOxJHdAKHf5rIzhvLTw0qT5p6kWHwG0t0D+Ih+NBFNd6AP3pXANDAd2eTgvgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SZec+Lnf; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-883902b96c3so489658485a.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 13:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760473710; x=1761078510; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pBzO/qxwMFiuodUwjnNSTjmJpn49BdXukWovp6AjsAo=;
        b=SZec+LnfhPz18Vi5m+gG9zrYDgtkpFRQKx6Y4HSghIuULM03IFrGd7tqDNUTMkVi/f
         ThNROxpJI+djccxpcfeaa2KoNNlPNHkPV1EuaodW4CnaPlOsJMLeDASTkPGLlBMhVcee
         9xR7rFShtvoJN0e/kL+yaOe+iTLSy7DCMCFk6fh29n/t2h725kDengT0zXg2aO+HWe5q
         +uhzK2GcgHj7eQWzuLI6tToQuJmQolrxqxcN9lZgEFhhVKHXUJlIMh6NzxBBF1+iTRlx
         yahBsrs+mB65jysDUXWAZc9PiGANCyHBKcPFJIQXMpYFr2+Zc7QlEsHvMNNnVGkZcj9v
         jK0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760473710; x=1761078510;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pBzO/qxwMFiuodUwjnNSTjmJpn49BdXukWovp6AjsAo=;
        b=uf4WhqOvTxVASvDzlAP9gNj+xkeNQnSVMChPJpmCnVWbDPcjXzVrkBDZ1qb4smKVw2
         QlauWqvmpfILBGHtA5ZlaXpcEXH/eXOHW05E5omn9dK32GshAU4IV623f7Jf0anGkHE2
         qpg/Azri4VRjpgd6Kmwb2K2ueJn2ZX1S/d7o2d0M+GZnqCzHioJStuqkREgGPFCDhNFo
         vkfYdkzEUMioLYZMkiohpXEMkk0yMJaCdKidFBilwGz1S2dAsr5f0RU74Hmb3QDp8eS1
         4YftWzjRthxSrxWbR/sRSmY2mR70YbehqestvO/nMKgNwkQSEXTi+c8sBYtpgievs++L
         yE8A==
X-Forwarded-Encrypted: i=1; AJvYcCWCoKjvsQVAIZpVNc7riIZqq8pcPuVzFW5zUQGwmlitvw5x6aFP3oKlMhvBLZ02GSbxWnMC7uuQlPvSaaA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4/sX+k157L4df9/GnAhYvQVN9WLfLywhx2ZegsDA1vifpe6Py
	BpB1nuJrSiWsHh4eyfWCeY/qof/mW3+tgZWHIXrwTBEzWjoIeUdI/RH53nNHh6f7zbdwTYsEIEw
	ucC6Rd15lm6sN3n+49Y4XNaaCtEPAP+k=
X-Gm-Gg: ASbGncuFfluKNi/TCsxAGBbSDnav1hrmh4BOLsslWuhW3IIa4Tb7uUQ+LIl7yyZu0tU
	aQ8lHLXxVc4q4SMe153r2lMpQgY0ujisN1Z0SSmbDXztczCeA56oNb2ds2aADZ6CsZkPiTTX+n/
	7wAVcgfzab+WYwERooyNhP7bzGlvdUnVZaWPuCzBuE0KJji7d9EeLDUq5xCSJ6Oj/xD+VAQSfEG
	RuFkTik8R8gI8RjD9q9VBIPK1A7hnoL+dTa76kWxVzd919wg1R8tFPC8A==
X-Google-Smtp-Source: AGHT+IEHWtgmhT2p78ndsLqREi02CoamLTiJ6OeM8OKrYE6vz8/hYR3ehoD9cuCKSfGARp+UWdPDUVymrBOFs0luCz4=
X-Received: by 2002:a05:620a:7010:b0:85b:cd94:71ff with SMTP id
 af79cd13be357-88356517355mr3325050085a.48.1760473709638; Tue, 14 Oct 2025
 13:28:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251013101636.69220-1-21cnbao@gmail.com> <aO11jqD6jgNs5h8K@casper.infradead.org>
 <CAGsJ_4x9=Be2Prbjia8-p97zAsoqjsPHkZOfXwz74Z_T=RjKAA@mail.gmail.com>
 <CANn89iJpNqZJwA0qKMNB41gKDrWBCaS+CashB9=v1omhJncGBw@mail.gmail.com>
 <CAGsJ_4xGSrfori6RvC9qYEgRhVe3bJKYfgUM6fZ0bX3cjfe74Q@mail.gmail.com>
 <CANn89iKSW-kk-h-B0f1oijwYiCWYOAO0jDrf+Z+fbOfAMJMUbA@mail.gmail.com>
 <CAGsJ_4wJHpD10ECtWJtEWHkEyP67sNxHeivkWoA5k5++BCfccA@mail.gmail.com> <pow5zt7dmo2wiydophoap6ntaycyjt2yrszo3ue7mg2hgnzcmv@oi3epbtyoufn>
In-Reply-To: <pow5zt7dmo2wiydophoap6ntaycyjt2yrszo3ue7mg2hgnzcmv@oi3epbtyoufn>
From: Barry Song <21cnbao@gmail.com>
Date: Wed, 15 Oct 2025 04:28:17 +0800
X-Gm-Features: AS18NWCDtdWGykNnr10kVKpaN-UFlp7dIYD7B4uot-LSzZLpylUZVkd3ymutVWU
Message-ID: <CAGsJ_4w-=MNAKyNk6hvAYMbi_tdiehM4dFtz3x0-V-0kCh83PQ@mail.gmail.com>
Subject: Re: [RFC PATCH] mm: net: disable kswapd for high-order network buffer allocation
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Eric Dumazet <edumazet@google.com>, Matthew Wilcox <willy@infradead.org>, netdev@vger.kernel.org, 
	linux-mm@kvack.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Barry Song <v-songbaohua@oppo.com>, Jonathan Corbet <corbet@lwn.net>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, Vlastimil Babka <vbabka@suse.cz>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Brendan Jackman <jackmanb@google.com>, Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, 
	Yunsheng Lin <linyunsheng@huawei.com>, Huacai Zhou <zhouhuacai@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 14, 2025 at 10:38=E2=80=AFPM Shakeel Butt <shakeel.butt@linux.d=
ev> wrote:

> >
> > It might be worth exploring these settings further, but I can=E2=80=99t=
 quite see
> > their connection to high-order allocations,
>
> I don't think there is a connection between them. Is there a reason you
> are expecting a connection/relation between them?

Eric replied to my email about frequent high-order allocation requests,
suggesting that I might be missing some proper configurations for these
settings[1]. So I=E2=80=99m trying to understand whether these configuratio=
ns affect
the frequency of high-order allocations.

[1] https://lore.kernel.org/linux-mm/pow5zt7dmo2wiydophoap6ntaycyjt2yrszo3u=
e7mg2hgnzcmv@oi3epbtyoufn/T/#m9b94a1c60452551496738e4e15235329f860d1f9

Thanks
Barry

