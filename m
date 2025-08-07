Return-Path: <linux-kernel+bounces-759360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25088B1DC9B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 19:45:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C67B582EC6
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 17:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10E301D61A3;
	Thu,  7 Aug 2025 17:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bnrl9Xr7"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3BF71A0712
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 17:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754588745; cv=none; b=GKiDTmiHS73k/mzGWI+s+NsDg+xth/P+LqTNKomAGmaG2IBdCFanA57pTxKywe4RTXkatt3VjwJg7wVzFkV5YkJs3L0OqkUJA6fvpBssrjzyJnc4Cx/dpsCMwIdZNdtv6z1jhUduEGxznpba/r8QDUHP0X7+WIMwHyJUEipes9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754588745; c=relaxed/simple;
	bh=mfvcv7HiZ+WmvEiPy97ympVI9kZ6wtR/RomqPMn3sQQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CQ5qU4ne+5vpuENwcMaBysm5kZdDJ+fhbKw4AFrjRkQ9EjD7ayEx8/3kVKhsu6Q2vNUXveOj2Z1iS/pQNahziUCLYfDJkps7lzEZzcJVZPowTaJ2/VwDhZiUZa6DMjRo9U0xM/SvuYSw2qWFXXP64xh/6a3SZftUlUQ0+XJ/pqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bnrl9Xr7; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5f438523d6fso1042a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Aug 2025 10:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754588740; x=1755193540; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mfvcv7HiZ+WmvEiPy97ympVI9kZ6wtR/RomqPMn3sQQ=;
        b=bnrl9Xr7n7n+D5cscB1g8c/95df3BIKeMTRqWfblPTlOFxKL3vtJtEkhY3Mqc8E7co
         Wa6QXthEfwnn2fo8pnFiw3SfBvznDO+Cln5x6pfSYER7rB3VnYndjqCg2G2PrArEmKCb
         pmgx6xNUmVGTXrkFg3Z2NtzDzM12iFYD3PZUVgJyhj48sl6cCROGfekRvpbfssH8yZDK
         sEZpMSMNyAydtt6ydOgUniwDJ7x1sWn5tlxJG6xa0pK+Y2Rq06/n7v0OG/+itWeE9kDS
         0IGRIFG1O3A4D6c52oBtndwpZd2oNaSZOu6bxCJG1TApqmSVkQbAbozGobE3rYbKNkxS
         W+fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754588740; x=1755193540;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mfvcv7HiZ+WmvEiPy97ympVI9kZ6wtR/RomqPMn3sQQ=;
        b=gVK+h4kkTTFiGIC1hn9N8dZjyIo8tq/kLY4NS5c5eu4q3kkcQwXX56HzfTy+lY0nl2
         4PYyO+bVCAARtP3rVn3zHqkO5k/OnPfXZGELjF8hRzePnmbx9fW2S0MMliWvjD83yE/A
         t5T75RSaqfp093p3ABERU8jp8HEArpW73B4JC2vWbtWhrxKsbvzjnuJ6qGkqnMjEg3No
         y4cB1H9VyXoCIk1Pd56+F6w5CBbMExNuHeEh/LkIbQUhfIfMj3XBJTLWpH1htqdVp+Ql
         xfn5SWp/wc/6HA5L9LDfPJtnm1d6vXjpCrQ8mvtLGzsrPDanouoRuSzlIIiLoTG3SVma
         E6ww==
X-Forwarded-Encrypted: i=1; AJvYcCU8w/QQo1nDo5wJOaNlpfswPKwGJxxTXZzpqSBZA/TaSSzUKXgWxuCaxam8gSdYEpvCFq6lN7aKYIfHoIg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoEPaD3m95aj6zReRHFb/kwWOMXOZjHdTFdGuwBErInsvD4Q+q
	Ii0BtPCH6xUyqY/Fb4WLrc7fxaqV9WHZc652S2H1hVQzxYBaJD42aLNzFS6tYywJkeykgodAGDW
	wThBdRxj/0+kjhl30nkwhMBT1tAMQJijSfes1qekQ
X-Gm-Gg: ASbGncuvFBMgkItF2Z+vwbf8Y9VtFoDodQwYFEmJMygi6PeTYVeHHi4QIyFlrIf4BEn
	V9wtUbt5IsMoRUCVC/pURZQN9ZxuOLJXyuJO/HcXofMuwxvXRdGxzxrKlscrxJzAhqihMCuAFl+
	jfNU9f9Tyh86XpVZULGiPS6Rx/mQ0ivf5lNdBjZFum9bqmfTbpM+EW0H2N9Iu92HDNq7hlqyGc5
	mkkkrqsXedIvXXl38N0INVqmBhjIkdTJlg=
X-Google-Smtp-Source: AGHT+IGcEDpK8Ms228S31UJyQbAhkBpRIwdLjP1Clq9AvE21KoiH4tSwTjlg40PwpAD3vSeDQTwiPuojzRmAtQXU/js=
X-Received: by 2002:a05:6402:42ca:b0:612:ce4f:3c5 with SMTP id
 4fb4d7f45d1cf-617e0c31262mr1251a12.0.1754588739638; Thu, 07 Aug 2025 10:45:39
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250807152720.62032-1-ryncsn@gmail.com> <20250807152720.62032-4-ryncsn@gmail.com>
 <CAG48ez114_bmuca2UL-g0ZY76-VqhL-4rQtJM_k0N2NJXE4vdg@mail.gmail.com> <CAMgjq7BhfGC7jVHQ62wAJBfTKCDG2+VdgpjiZ7hjxXeC5fHg-w@mail.gmail.com>
In-Reply-To: <CAMgjq7BhfGC7jVHQ62wAJBfTKCDG2+VdgpjiZ7hjxXeC5fHg-w@mail.gmail.com>
From: Jann Horn <jannh@google.com>
Date: Thu, 7 Aug 2025 19:45:03 +0200
X-Gm-Features: Ac12FXwnxeugojc67eEPK0kCxtOuhwPnrmiHNsk9EMBjaGBmvR-4KLfAtDyKybA
Message-ID: <CAG48ez0O-Ro9-x1LZ8QdijMk57j1D2jWf3MR7F6AiDP7Wq1p_w@mail.gmail.com>
Subject: Re: [RFC PATCH 3/3] mm/mincore: avoid touching the PTL
To: Kairui Song <ryncsn@gmail.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Pedro Falcato <pfalcato@suse.de>, Matthew Wilcox <willy@infradead.org>, 
	Hugh Dickins <hughd@google.com>, David Hildenbrand <david@redhat.com>, Chris Li <chrisl@kernel.org>, 
	Barry Song <baohua@kernel.org>, Baoquan He <bhe@redhat.com>, Nhat Pham <nphamcs@gmail.com>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 7, 2025 at 7:28=E2=80=AFPM Kairui Song <ryncsn@gmail.com> wrote=
:
> On Fri, Aug 8, 2025 at 12:06=E2=80=AFAM Jann Horn <jannh@google.com> wrot=
e:
> >
> > On Thu, Aug 7, 2025 at 5:27=E2=80=AFPM Kairui Song <ryncsn@gmail.com> w=
rote:
> > > mincore only interested in the existence of a page, which is a
> > > changing state by nature, locking and making it stable is not needed.
> > > And now neither mincore_page or mincore_swap requires PTL, this PTL
> > > locking can be dropped.
> >
> > This means you can race such that you end up looking at an unrelated
> > page of another process, right?
>
> I was thinking If the PTE is gone, it will make mincore go check the
> page cache, but even if we hold the PTL here, the next mincore call
> (if called soon enough) could check the page cache using the same
> address. And it never checks any actual page if the PTE is not none.
>
> Perhaps you mean that it's now doing the page / swap cache lookup
> without holding PTL so if the PTE changed, then the lookup could be
> using an invalidated index, and may find an unrelated page.

Yes, that's what I meant.

> A changing PTE also means the mincore return value is changing, and if
> called earlier or later by a little bit, the result of that address
> could be opposite, and mincore only checks if the page existed,
> it's hard to say the returned value is a false positive / negative?
>
> Or could this introduce a new security issue?

I don't have specific security concerns here; but this is a change
that trades accuracy and simplicity for performance.

> > And your patch intentionally allows that to happen in order to make min=
core() faster?
>
> When doing a clean up (patch 1) I noticed and didn't understand why we
> need a PTL here. It will no longer block others and go faster as we
> remove one lock, I can drop this one if we are not comfortable with
> it.

If you had a specific performance concern here, I think we could
consider changing this, but in my view it would sort of be breaking
the locking rules (by using a swap index that is not guaranteed to be
kept alive) and would need an explanatory comment explaining the
tradeoff.

Since you only wrote the patch because you thought the lock was
unnecessary, I'd prefer it if you drop this patch.

