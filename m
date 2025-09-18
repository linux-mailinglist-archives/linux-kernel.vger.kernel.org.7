Return-Path: <linux-kernel+bounces-823678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A67FB8727C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 23:35:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EE88582F85
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 21:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3B9A2ED853;
	Thu, 18 Sep 2025 21:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bNjCJlMM"
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D950F2D24BA
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 21:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758231344; cv=none; b=BpSZu4sn0ZcYZitlVkgSJJeuX9yztUCvoSjUEYr4xjH+L0AcUeO2nW2Bt/yVx0/kFAbZNVMj80BZGNBcYMIBO8S+KHjFtjqvybpXBSv4KHjY0i7gYaaGEIiZMCW7Df5Kl9QTbpYNFwbhWCxwZgKxCTcE1nKoQ1KLYdo0K0ORPk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758231344; c=relaxed/simple;
	bh=jXnCKXVgE6hQ+FZVg5JB5sEK2bj0/Q1cT8SKrEgFiVE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z/aLH+xA8yjAD0cgy6jccA0E2b06ofPr5hENE9MR/tbquM910BUmGJTCBZLYgUDm2zIUd2UdZfjDQT3woLP7tipIcke4ObSFJ3zt0Aq1Uu3pO46s0tYzc2DbWrBEXQuIw1JkiXTmPuSm9s4JFFb89nHplGvVOQh5YKJsh8F859o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bNjCJlMM; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4b794e9a850so12044301cf.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 14:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758231341; x=1758836141; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jXnCKXVgE6hQ+FZVg5JB5sEK2bj0/Q1cT8SKrEgFiVE=;
        b=bNjCJlMMk9U+TmCXETmxrNLUEg3Pw61OWrPd2OcJ6xZKXBcdTz9RinDpguXto2zA5e
         IecU3MyxOKWcb1Q4KZUlx7EQWwm9Lc/kWUmIfQIDHuOqEevbaJcK4g4+YupfbDFye10Y
         KTMGIPk+b4lqGXRNnuMhDoWVEtlO6i8uS1nEp7B2ZLDDK3pBVaaHuybAuPp+M9kzojSz
         6vsx8zwSxzFCV+wOs6u/xhauwUfMpVPg2S96oacX6VsSHIunV63gztKnRB75oRtztO8p
         VAsoXhU80mIfHVPwNlF+Pw0p1BjKhcbhoPMwsWEOY/ztDhaz7YvVpMPWFNf8SXFTQHBa
         xIIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758231341; x=1758836141;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jXnCKXVgE6hQ+FZVg5JB5sEK2bj0/Q1cT8SKrEgFiVE=;
        b=F4LTwcIceTTYwPgf6g78FatYGUT33S+fxscK3EifgsbxO3LoEnKMfLO2OyaA0vxtJd
         PHTgdopwEcYdI38nnjg10jz5eibVU28OI+4uII490V7h9k6YobABbLe4ttAL5tAU2gUf
         7CnH/SN55epkdTspmqZogkVzdmYh99jDh+CGrAJNl28sV1K5hy29nhivZy7AfDEsXV8w
         FJFpVupn6WxN8m+SGz9YIv/z3JiwK8MasrzfYgysglmOIyBwWWZQ5fMZDHXon9p3REOX
         vR5XINQKSx7ZLYyh9jxnwBURrSNmaOALRNiXdMfM+LcXk4Uj3Q80VKPnkU+77oB3EFv9
         vVdQ==
X-Forwarded-Encrypted: i=1; AJvYcCXWr+2bYBYNmnNR+PmlwxGLQRiS+AXyMdpyGgyUoy2DHH/zkWiwGTcdPF/pWbfcA7N9cTcIwvybRDZSltg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwinVE1cMQJ7DAD6KmE/lRJ8Y6gjEb6pGGdl7iCpnj9FIzcLiTU
	MhZwltMYjo5lo7UOMeHSpMzGTDkFVQsQwt0hGggCQWvXqokOflKyuMiNMGx1fVgm9RsHznGV95i
	2a0QWaQNHZ46TOtOwOB8YybKCK+ez9Po=
X-Gm-Gg: ASbGncvh24fKB9VkNg2usabtKQAppJKq6AJdUlBI+VZlsA+LCa4X8rGP/QjkC3at+/I
	IFL6MifK20KTS+olg944Qb4465d5eVwNPW+j06A+0UrTWz+73dkaJLgqHuHR2f2wM+2ezqGCDID
	xCL7gO1BXgs7UCCEVWYmQNe1eEebBGSjptq4ustRYkBlsF91wYfv+EsrcMn1s2vKnA/uRoOhZ8e
	2jtMXvjHklztrabPwj34uNrkKrbNa4s78BhthvwAI1ahuShacqvga4eUyvAOwUBkD4gJZk=
X-Google-Smtp-Source: AGHT+IGiv+s5AouLfE/H+OI4d7OwQCqJOIBz2+RILHJ3o6xdlmWfK2Q4ZDqx59+U6xEoz6B2TESsbidYoVeBmWAkIXw=
X-Received: by 2002:a05:622a:614:b0:4b7:a951:21cc with SMTP id
 d75a77b69052e-4c07444df71mr8113061cf.84.1758231341042; Thu, 18 Sep 2025
 14:35:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916160100.31545-1-ryncsn@gmail.com> <20250916160100.31545-2-ryncsn@gmail.com>
 <CAGsJ_4w2GqGj8HZMfwndsWu7qkORqsnaw9WwhmQS=pW4gR7nEA@mail.gmail.com>
 <CAF8kJuNbUyDWcJ13ZLi-xsiYcbY30w7=cFs7wdxszkc7TC4K2Q@mail.gmail.com>
 <CAGsJ_4wKWem-STYAnh_0EgSFKzzs1M1c7wz6K82wLt6T6JEw9A@mail.gmail.com>
 <CACePvbU8cUs-wwPsXkZ24EWga5bXxxUGSCT18rKAWFYn5w9rpw@mail.gmail.com>
 <CAGsJ_4yhDU_WVfEybDhGE-WF5+w-fak1-F8jqbAQ-Qw1+qWkaw@mail.gmail.com>
 <CACePvbUabb+L6Z9Nb-41fLR-FMhj--cDWSbnXtCj3rpqXModiQ@mail.gmail.com>
 <CAGsJ_4y8yTX48ESHKgLNCvM1M1_gY9uGnD4qiz8n+gD47Zd1Hg@mail.gmail.com>
 <CANeU7QkZBWFO6SeVHtmm73oLu7r0zavePQEYmQfH8opKPH1QWw@mail.gmail.com>
 <CANeU7QmcC=-CTmJ7i8R77SQ_WArBvjP3VrmpLOy-b7QhCfMRYA@mail.gmail.com>
 <CAGsJ_4zmkibM_Ex7kGMsr2sni85H-cnxQvh0XwkWiALNQy+zAQ@mail.gmail.com> <CACePvbXae0zymE_BHydXtA_pjZ2NqabVyqxu1xKxLjLKmeYH9g@mail.gmail.com>
In-Reply-To: <CACePvbXae0zymE_BHydXtA_pjZ2NqabVyqxu1xKxLjLKmeYH9g@mail.gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Fri, 19 Sep 2025 05:35:29 +0800
X-Gm-Features: AS18NWCCgGfrK6FrQV50p4UjYkTXPoOuJcmQjaVmpdGYkQAzdS7lktT97iKTrKg
Message-ID: <CAGsJ_4zB4ygGCN4JTx+AW+XAUm8WtFVLVesStuDHc8S-HT0ihQ@mail.gmail.com>
Subject: Re: [PATCH v4 01/15] docs/mm: add document for swap table
To: Chris Li <chrisl@kernel.org>
Cc: Kairui Song <ryncsn@gmail.com>, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>, 
	Hugh Dickins <hughd@google.com>, Baoquan He <bhe@redhat.com>, Nhat Pham <nphamcs@gmail.com>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	David Hildenbrand <david@redhat.com>, Yosry Ahmed <yosryahmed@google.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Zi Yan <ziy@nvidia.com>, 
	linux-kernel@vger.kernel.org, Kairui Song <kasong@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> > I=E2=80=99m not entirely sure what you mean by =E2=80=9Cpage table page=
.=E2=80=9D
>
> The page that gets pointed by the page table, or the page that holds the =
PTE.
>
> > My understanding is that you=E2=80=99re saying:
> > The swap table contains an array of pointers, each the same size as a P=
TE,
> > so its total size typically matches a PTE page table=E2=80=94one page o=
n modern
> > 64-bit systems.
>
> That sounds good. Thanks for the suggestion.
> I take your suggestion with some small modifications, mostly to
> clarify the total size is the total size of one cluster of swap
> tables. The total size of all swap tables in a swap file is much
> bigger.
>
> How about this:
>
> A swap table is an array of pointers. Each pointer is the same size as a =
PTE.
> The size of a swap table for one swap cluster typically matches a PTE
> page table,
> which is one page on modern 64-bit systems.

Acked.

>
> Chris

Thanks
Barry

