Return-Path: <linux-kernel+bounces-778944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CEDDDB2ED02
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 06:37:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 637375C0126
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 04:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE3A82EE289;
	Thu, 21 Aug 2025 04:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uffX87SD"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E9742ECEB9
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 04:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755750595; cv=none; b=Zz/xy44G23e/1V+Wg6v4NjpENtsPV2mcco1TR3E5oupPeLCIdCzTJBRsUbyW+CgpbKWrN4IQpQnvlHXJlfzSWrBCtFj5l3pr68c37YT5j2USgOCgJ3uoiGQBKZRtKMAoKGD2djmF6tkNWGZMOPZtl9kz5TSga7nanbRtuMHH8nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755750595; c=relaxed/simple;
	bh=6igN2PgVpdM6gB9VkiPhmNgxoN8+EzSL+9Xe3tQtx0c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hm8oO7XG8HsSEbf7cW++xNphx/vsqiEhU3LP2PmWu0bpN0kmjA93LcdHegPp+o7n+Iw36YwKckiyxA4R0kfbJ7WxfPjHiLVixCDmk/oi3RzGqf3JXXBPT/7ZnvUbqvtC5x3sgZ4oyKdjf7AkZ3BeGyZOk18GjgCZUIhMiN6YtXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uffX87SD; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-61a207a248cso7269a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 21:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755750591; x=1756355391; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YiQAxhM/QJlwWL8l9+SNOEA+OdOO+5ivlQu2a3QQ5Fc=;
        b=uffX87SDZC0yuMZbPY/dLjGJgdeWRXJXx4pL01SgbNi+QoE+mNpHQzHLfqHi3X0bzO
         5DXf9S8CQl00rhHRCVIlMypGuVdrtDNxwCZSU3lVAXynQKZd2IUOP0/ocNxfhcWwbMLL
         do39z+yJmO7qZ1niLxXPDgv0vfA9L8Inq8uZ6OrI8np1BkHWkPTKM5Ap8NslJmZHaQE3
         o2xMPbbvxnHPKwhEJSB6GaGo5j988KruMgeozuD6PGMgEDVLVny0a8EypLxz57QYurJl
         SOYEobMoJiPXp0Z4J/jwPEnufsTF9ojCQ34/OuMeA9LMh8A1DQ5cCsMGpVW2rS6HbNoE
         IcQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755750591; x=1756355391;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YiQAxhM/QJlwWL8l9+SNOEA+OdOO+5ivlQu2a3QQ5Fc=;
        b=qidrrCzLEEBMmYg0Tfa4DkUCi4AxmtZg2HNEhwfBQ0PAG45066UJzJ3+f/4yGX79f5
         wBz/S2szxXoQCn33SzcLvk2tmGQnTw+XzikSBf2o0cnHDFFkEv1DUuWSEy7xy/eHhtWi
         XctXuBOvtWCyyosx9aeLs4O8vTTJEgfbrRCGbvGKWFDlW714jPqb7JiiI0qg2lZHOHjW
         xX4VMfOJ25PCYV2CmWpK6Gl3o3x28mujWBSEZR5u73X5yYdP5fGqgjhd4KLV69alE7uK
         JkTGghYR9f1rg1vakTMAXn1C0al+HODyR2NmxwmRwXfdbC6Q2AdiS3ny0KgpeSNgsI6j
         mPrQ==
X-Forwarded-Encrypted: i=1; AJvYcCWAFGyUclg5Sob2C0RksnjdLqKWc69Z6CjBkTCwPRZkInKQtVTDMoG+7YsiibduqV9chXgEQO0HXF3b6FI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxP6qmPVHxdvdCFcBCLSgdpdV49CI8DGtQjwMhNOxLf9Rk/YtTp
	vFz6uo+V3eldahwwzuLE1OmL1Gss1KxHWIZMzU+HfA0I0MRsyVG787NVfnQN52vvCbFnKS7oe3g
	BYSohC/M0lbvjkSVw+XfwhrXshlTitz4vHTO5F70H
X-Gm-Gg: ASbGnctKPPR4dpvkHJAVGJQRiBJ71LWwvknTkD/MLngS/S9837kcbi6nUIiQGuXYSqW
	GXW5huIU6O32993AoqBROXKD/nReYs10zIKpT1bhXt27BdANf06BlDHSE3WZuzHwgL5qFZumeNf
	fVe41iowaDqm6fi4Peolh48LEVpbz6OWijJv+dye0nYPmL5Du4TK47Fd1CSuVPa3c0Qtnhhc2/L
	46eeCiln+DQYiKRuFg2qye0nwpFel6mbKo8/uyhrZj53/O5+tL0/U/Ljg==
X-Google-Smtp-Source: AGHT+IF0GoUa1z6lXNPBUJmlXAgsphR5TTslfw+Yzi/lcxUYlsx48nQaH6W3TUc2RxxrXd4Bdlz7ftjct1PNH9I+USw=
X-Received: by 2002:aa7:d319:0:b0:61a:a800:f1fb with SMTP id
 4fb4d7f45d1cf-61bf8eedfcbmr24552a12.5.1755750591033; Wed, 20 Aug 2025
 21:29:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+EESO6dR5=4zaecmYqQqOX4702wwGSTX=4+Ani_Q9+o+WUnQA@mail.gmail.com>
In-Reply-To: <CA+EESO6dR5=4zaecmYqQqOX4702wwGSTX=4+Ani_Q9+o+WUnQA@mail.gmail.com>
From: Lokesh Gidra <lokeshgidra@google.com>
Date: Wed, 20 Aug 2025 21:29:39 -0700
X-Gm-Features: Ac12FXxHmOMkQ3BdmXM0ypZZLhdcYPi7nFCF_HU_hcXD5yQRJE2Fxc9-_DNG5YA
Message-ID: <CA+EESO6iqowMAOnBPJjERqZym_qvd6kx8BDMQG8+3xQSrNFytw@mail.gmail.com>
Subject: Re: [RFC] Unconditionally lock folios when calling rmap_walk()
To: "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>
Cc: Peter Xu <peterx@redhat.com>, Barry Song <21cnbao@gmail.com>, 
	David Hildenbrand <david@redhat.com>, Suren Baghdasaryan <surenb@google.com>, 
	Kalesh Singh <kaleshsingh@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	android-mm <android-mm@google.com>, linux-kernel <linux-kernel@vger.kernel.org>, 
	Jann Horn <jannh@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Adding linux-mm mailing list. Mistakenly used the wrong email address.

On Wed, Aug 20, 2025 at 9:23=E2=80=AFPM Lokesh Gidra <lokeshgidra@google.co=
m> wrote:
>
> Hi all,
>
> Currently, some callers of rmap_walk() conditionally avoid try-locking
> non-ksm anon folios. This necessitates serialization through anon_vma
> write-lock when folio->mapping and/or folio->index (fields involved in
> rmap_walk()) are to be updated. This hurts scalability due to coarse
> granularity of the lock. For instance, when multiple threads invoke
> userfaultfd=E2=80=99s MOVE ioctl simultaneously to move distinct pages fr=
om
> the same src VMA, they all contend for the corresponding anon_vma=E2=80=
=99s
> lock. Field traces for arm64 android devices reveal over 30ms of
> uninterruptible sleep in the main UI thread, leading to janky user
> interactions.
>
> Among all rmap_walk() callers that don=E2=80=99t lock anon folios,
> folio_referenced() is the most critical (others are
> page_idle_clear_pte_refs(), damon_folio_young(), and
> damon_folio_mkold()). The relevant code in folio_referenced() is:
>
> if (!is_locked && (!folio_test_anon(folio) || folio_test_ksm(folio))) {
>         we_locked =3D folio_trylock(folio);
>         if (!we_locked)
>                 return 1;
> }
>
> It=E2=80=99s unclear why locking anon_vma (when updating folio->mapping) =
is
> beneficial over locking the folio here. It=E2=80=99s in the reclaim path,=
 so
> should not be a critical path that necessitates some special
> treatment, unless I=E2=80=99m missing something.
>
> Therefore, I propose simplifying the locking mechanism by
> unconditionally try-locking the folio in such cases. This helps avoid
> locking anon_vma when updating folio->mapping, which, for instance,
> will help eliminate the uninterruptible sleep observed in the field
> traces mentioned earlier. Furthermore, it enables us to simplify the
> code in folio_lock_anon_vma_read() by removing the re-check to ensure
> that the field hasn=E2=80=99t changed under us.
>
> Thanks,
> Lokesh

