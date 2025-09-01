Return-Path: <linux-kernel+bounces-794907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11C6DB3EA7C
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 17:31:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E162A3AFA30
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 15:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1026368089;
	Mon,  1 Sep 2025 15:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="cd/cMr3m"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50566320A34
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 15:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756739600; cv=none; b=eH7o4quDntMOQDLF7O4FtwezMgy+oOzjXV6utwe6qY6zA43T8Sg3tJslua4WLVQRilUKe/8Mu0LjwS3To/Tof2Ls0fUfIZyZDB3cdi+GIkCRRHWtNYj8IprpNXM0V1U+IRvfm7TCNZ2NTga5W5lDALB/ga1vG75zZYz7Ub98/v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756739600; c=relaxed/simple;
	bh=A08kBdKHaoJbHo5ouUdZLXPFTzEYHeueCSYh810eJqo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rFsnkoz8xgTAx2hJO//9pMC3MqS6/dvce+H5Vtpj7WtYKeOsETfHreMlCJgDFf1rRkY6yEGHTk3bw3v8AasJna9iN6C965NkO2fgR3Ut1OK24FR6M5d6ZOoQ6z/SFPWGnHPwRY7u7teKrCrpkz62sVxmEQY5znPoLGF9prZt+AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=cd/cMr3m; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-afebb6d4093so742148866b.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 08:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1756739594; x=1757344394; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A08kBdKHaoJbHo5ouUdZLXPFTzEYHeueCSYh810eJqo=;
        b=cd/cMr3mBFUKj/l85MxxINGe2ZL/wWXCouUOLF2P7u7Sbb3G2TSO+T7MMjaT92i8ib
         xVVye2DysYNSVHq8tJ6lKA4Lfe2j0OP/3aSBx7XrTl+MRwh75YHhMdSJp9YYyfIHRO39
         Ac9SPC5f1PEpMwBCrIbTUQfFNA7/0Z1pB89UOn0AWo0ZV/a+e7jGsUznoZHpQ+8lCHN6
         celxCU/rqMtV7FgC/CvN4UVi2u3gRCZv6iXKZLyDlHC0rFJR2xSaHcZV3AVn34Oi4Har
         ypZu2Kxo7s7oPnvu1oreYhxXi7Igh14F5/Iifs9vIPSXDKTC+a/3Mqq+6OB11kxfPlUU
         R08Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756739594; x=1757344394;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A08kBdKHaoJbHo5ouUdZLXPFTzEYHeueCSYh810eJqo=;
        b=Ijokm05NDhR/CaNmMKkDpXX2EtEkYaRzhPNPcAR24ezl8oLmwIawy4SwQ7kse5kpG9
         zd7jgtvlPecPycTpOUtx1HoJVf2A6b6uKqJBHQyWGorn6SQuQfHcSwpXgQry9nFdEud0
         XqirkiCxVZ+k/K4O+Pga9upNhWwN0rN7+zT1126M6NuzFqxl4dQBZBQpQa6WSNptWDVQ
         rP3Dgl/gkPgXhnuxy/+JhZ3MCdy6HB4LXHrQLp+e+QcID6mpX2HPFUlGbPUazgELTzOU
         xa4ZZFRMHUkUx7fXarrJtOTCN4sMxlBYJYf3joF49iVwcaC4GrQrZySZCX6be3nRjOAh
         mQBg==
X-Forwarded-Encrypted: i=1; AJvYcCXgqHXYG5z/eXENr54nOcfTt9RV7WYTb98fTQIunSLyPeNNqNRDjM15CaAXMWayQs16t1IFCDtQwUdWn7I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBKII+USOWp+pR7AiY9mU7nSrecAMSm8Cd6Z2BIPtfSTm5aCzb
	1N/PyzZFSF86D/jDE+EkXzbNFJHFoyuLbqV8XGzeil8xTlosNR7gU8QW762qbRSirRBSCNR9jdn
	n244iXjdmd1lPXN4+Rd2h5MPDobBdIKyF0zgyOJgnCQ==
X-Gm-Gg: ASbGncuixyjtd8FzEkGyoajA9BO6V5rg/7EvqOt9TtrdYg6vTeFaweMk09ASeqAudRc
	ULA0BhZZW6Z1w6HXW5xFPEXYR1C43lJGreMHvjS2uikXTa6TiNwWOsRWEhzfl8Box/Rky9gyhrj
	dy1MkY0dMaAgmfIFNjTFyzQeyahdd+Zscu7B7ZK5HGt7LhUZftlXWiDrtD6Ds925yewbYJd3BLU
	BLhPquS+mg62PCQp19QqaW+BwkZgZHUT6OA4npkx6vXrg==
X-Google-Smtp-Source: AGHT+IEFPWeGuNqM2+QiOgw6fHvRg/b0a6N13KZkb/trfYqooePyXBS3syenI4NwqPjQnySBBQHmRMnR+cpdOfOLUuA=
X-Received: by 2002:a17:906:9f85:b0:afc:cbf4:ca7d with SMTP id
 a640c23a62f3a-b01d979fe6emr930093166b.54.1756739594447; Mon, 01 Sep 2025
 08:13:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250901123028.3383461-1-max.kellermann@ionos.com>
 <20250901123028.3383461-11-max.kellermann@ionos.com> <5ff7c9bc-1722-4d8a-ad2e-8d567216a4e4@redhat.com>
In-Reply-To: <5ff7c9bc-1722-4d8a-ad2e-8d567216a4e4@redhat.com>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Mon, 1 Sep 2025 17:13:03 +0200
X-Gm-Features: Ac12FXzpx0s0QI5qZl1CeOcQ-w6EceVXiGl7R5sUJVErAX6WQ0b3KxehR5HEiuA
Message-ID: <CAKPOu+-zBstZVw4LjKz7ZQyTh_PKEJXaWYsgF0-E0+shAaTvwA@mail.gmail.com>
Subject: Re: [PATCH v5 10/12] mm: constify various inline test functions for
 improved const-correctness
To: David Hildenbrand <david@redhat.com>
Cc: akpm@linux-foundation.org, axelrasmussen@google.com, yuanchu@google.com, 
	willy@infradead.org, hughd@google.com, mhocko@suse.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, lorenzo.stoakes@oracle.com, 
	Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org, surenb@google.com, 
	vishal.moola@gmail.com, linux@armlinux.org.uk, 
	James.Bottomley@hansenpartnership.com, deller@gmx.de, agordeev@linux.ibm.com, 
	gerald.schaefer@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com, 
	borntraeger@linux.ibm.com, svens@linux.ibm.com, davem@davemloft.net, 
	andreas@gaisler.com, dave.hansen@linux.intel.com, luto@kernel.org, 
	peterz@infradead.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	x86@kernel.org, hpa@zytor.com, chris@zankel.net, jcmvbkbc@gmail.com, 
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, weixugc@google.com, 
	baolin.wang@linux.alibaba.com, rientjes@google.com, shakeel.butt@linux.dev, 
	thuth@redhat.com, broonie@kernel.org, osalvador@suse.de, jfalempe@redhat.com, 
	mpe@ellerman.id.au, nysal@linux.ibm.com, linux-arm-kernel@lists.infradead.org, 
	linux-parisc@vger.kernel.org, linux-s390@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 1, 2025 at 4:00=E2=80=AFPM David Hildenbrand <david@redhat.com>=
 wrote:
> Also some getters hiding (and functions that actually implement logic --
> folio_migrate_refs())

Indeed; I mentioned that one in the message body, and I thought this
was good enough, but I dropped the word "test" from the subject line
to avoid confusion.

> > -static inline int folio_lru_gen(struct folio *folio)
> > +static inline int folio_lru_gen(const struct folio *folio)
>
> *const ?

Right. Added for next revision.

