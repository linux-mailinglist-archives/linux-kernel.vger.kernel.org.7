Return-Path: <linux-kernel+bounces-817972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AEE33B58AD4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 03:09:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 211491B26B84
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 01:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC8B71E47B3;
	Tue, 16 Sep 2025 01:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CXkVjG+7"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8174C1991CB
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 01:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757984935; cv=none; b=aKxfnpHThrjgfTL/18pQEpTirl8TVQVTIGq3U6SVoL0edsAtVp0x+fy/TF0fAwVWAluEASZGK00NNCJeuDYm+mqLhahmDA2lL9vKX7Z/hf9zMYCoyeIuKoLTZbqZOo7iGtU+LL8Lq5ubsUS8Ov+vzpCBaSk//UUOF1eIOw7UaEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757984935; c=relaxed/simple;
	bh=RLxHq+ieXY28lD11U/kgpTTtUvpefKc4mYLbzO1KbPE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W/f0vgGyNBNpYli+eNVYt5lfHRuMzbk5/bxwlf6LlJ7pNy+c0mRKPhvOCNX5i70mFXxofododh2yAjigskfWwziEGks84t6M5HyxyrLMc9tpoD86V4g4FiVJd6dwEZTiZMUTEV1q/L2LFFci6HTYxuaSdyAmKcDWYK9kPiiLoqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CXkVjG+7; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-267c90c426dso53695ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 18:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757984933; x=1758589733; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nPfnnggT2ndL938eIChQLKvTB/FFnYYq61IMlRsGnh4=;
        b=CXkVjG+7VFG7KXzSKSETiG/AIszysjhR8BMSC6qiRzSB1sSAQJRwguTe5+aww+l9FB
         GHCXRsHO+4wcrLRBH6mvY9QRQJIPsS66twhaxadhJu5zuD5oeC7vCyosU/Ha2aZsBJSj
         LMtFN6VBtgjCRUw4hY1g9XArn0zE0rzdR+C+ZciyziufcmJu/PZdyo3GsjocUpdN0fGZ
         LCW/bHuNmF9nGX4fPDVErMyDFG6KfGIStnq6U4w3Bnlvt+hVJ+nQFH91kUSktbS+8SUI
         nanp3H1tcrFrjQIEaGY4sjAMHcbRrmYIxAnKYqecMW0r8VGL72jvcno7dq6QTfjwjBJc
         mFAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757984933; x=1758589733;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nPfnnggT2ndL938eIChQLKvTB/FFnYYq61IMlRsGnh4=;
        b=recGh+5E5S0a5hWQhfwS0MZqasLV/eEvEUa/yGGDA35ECaTMrOEZWvWhq3tWW2q8VF
         HXV0r3Sg5IgNb9OeUmA+l0EQbSrBAH6cvpGlq14C93hetj8+kdAaWPZJGmTn3efET/gr
         w3UqXeCYdrbo8w8kbcZZKiIa06WZdebIDhcRWt6O4YNkIiS1fXE7H3qXSnlkUFtFyJ38
         SvsGXTk+k3YdtzVAitSbFtZ9q8GTeTjt2VJIxXxZtzkLdPgF+wEbHelsqerF7u9eZzex
         bH5sdQW4B/mzjDVgV8yYu6LoB1T7dr1BMfqUeuJTLqZYSZF0eO8IzGPwEmbHLH2WCu62
         ZcTA==
X-Forwarded-Encrypted: i=1; AJvYcCWakdoqGjIAx1zqyvO4kncSlK9J0JnkN41w30ohEJnTM2JiMoYnmRAwF+i1XFg81IElTLotbY5caRJQr78=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAK5r4GMP5vb/kqPn8RTc3axb6jnztb1LhbS4eDWPpRuA6NPkd
	s8NhPWMj5LPQw2jlub4FksaBcVHW0lyf50SsTHSV/Sq8uc7Gcs8qJgD0o/84U8sAjArIkImH3pt
	PmPsBCbD+txn0aGLgaZsuxWZaSobWXCtUfQqZY27w
X-Gm-Gg: ASbGnct+tq+wXlJLG6rDXwvkvR+Y+70EofeSB3TacmQr8D4tcOeID7ppeFdiwYceTK6
	2ajgsspJYqft/6gwdypCfyp3E41dzUD5lXyDqPxP7Qi4ucyti1Sv4SKMvp9YIHgs/xPBD+Bu6AJ
	ZyQS7MzJ3zzb8v+KTtMygceIIeORpEjiBdgM+kQIpsN4kv6BiL7N5EwgK5wBrlmvZDHEt+PKlRm
	yxEpIe/WMTjpG4tuNCnGl2G0udRr9P/ozXpL2aKlT/72DE=
X-Google-Smtp-Source: AGHT+IFJAwHXee6Yr2rlSgFzR1W6KmuFM2AmQV7u+C+LW88ZIxPQ1NthTP/QNnO6EiXNfW/zo3fYwDpWfY06zM6keSU=
X-Received: by 2002:a17:902:ea0f:b0:24b:131c:48b4 with SMTP id
 d9443c01a7336-267ca0ea180mr1360815ad.5.1757984932255; Mon, 15 Sep 2025
 18:08:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250902111951.58315-1-kalyazin@amazon.com> <20250902111951.58315-2-kalyazin@amazon.com>
 <CADrL8HV8+dh4xPv6Da5CR+CwGJwg5uHyNmiVmHhWFJSwy8ChRw@mail.gmail.com>
 <87d562a1-89fe-42a8-aa53-c052acf4c564@amazon.com> <CADrL8HUObfEd80sr783dB3dPWGSX7H5=0HCp9OjiL6D_Sp+2Ww@mail.gmail.com>
 <CAGtprH_LF+F9q=wLGCp9bXNWhoVXH36q2o2YM-VbF1OT64Qcpg@mail.gmail.com> <b325fb38-d34d-45e1-a5cb-eaf2b8c59549@amazon.com>
In-Reply-To: <b325fb38-d34d-45e1-a5cb-eaf2b8c59549@amazon.com>
From: Vishal Annapurve <vannapurve@google.com>
Date: Mon, 15 Sep 2025 18:08:39 -0700
X-Gm-Features: Ac12FXzyKYuqCZZsxxrtjECaM8gnlnpPAkbnGEzt2I2OQ5pY2bh2gNnFAoMROiY
Message-ID: <CAGtprH8PJa-hV6DsfUKevZQs=73CUf8ow9i2-sdxbj555De9Aw@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] KVM: guest_memfd: add generic population via write
To: kalyazin@amazon.com
Cc: James Houghton <jthoughton@google.com>, "Kalyazin, Nikita" <kalyazin@amazon.co.uk>, 
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "shuah@kernel.org" <shuah@kernel.org>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "michael.day@amd.com" <michael.day@amd.com>, 
	"david@redhat.com" <david@redhat.com>, "Roy, Patrick" <roypat@amazon.co.uk>, 
	"Thomson, Jack" <jackabt@amazon.co.uk>, "Manwaring, Derek" <derekmn@amazon.com>, 
	"Cali, Marco" <xmarcalx@amazon.co.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 15, 2025 at 4:01=E2=80=AFAM Nikita Kalyazin <kalyazin@amazon.co=
m> wrote:
>
> On 13/09/2025 01:32, Vishal Annapurve wrote:
> > On Fri, Sep 12, 2025 at 3:35=E2=80=AFPM James Houghton <jthoughton@goog=
le.com> wrote:
> >>
> >>>>> +
> >>>>> +       if (folio_test_uptodate(folio)) {
> >>>>> +               folio_unlock(folio);
> >>>>> +               folio_put(folio);
> >>>>> +               return -ENOSPC;
> >>>>
> >>>> Does it actually matter for the folio not to be uptodate? It seems
> >>>> unnecessarily restrictive not to be able to overwrite data if we're
> >>>> saying that this is only usable for unencrypted memory anyway.
> >>>
> >>> In the context of direct map removal [1] it does actually because whe=
n
> >>> we mark a folio as prepared, we remove it from the direct map making =
it
> >>> inaccessible to the way write() performs the copy.  It does not matte=
r
> >>> if direct map removal isn't enabled though.  Do you think it should b=
e
> >>> conditional?
> >>
> >> Oh, good point. It's simpler (both to implement and to describe) to
> >> disallow a second write() call in all cases (no matter if the direct
> >> map for the page has been removed or if the contents have been
> >> encrypted), so I'm all for leaving it unconditional like you have now.
> >> Thanks!
> >
> > Are we deviating from the way read/write semantics work for the other
> > filesystems? I don't think other filesystems carry this restriction of
> > one-time-write only. Do we strictly need the differing semantics?
>
> Yes, I believe we are deviating from other "regular" filesystems, but I
> don't think what we propose is too uncommon as in "special" filesystems
> such as sysfs subsequent calls to attributes like "remove" will likely
> fail as well (not due to up-to-date flag though).
>
> > Maybe it would be simpler to not overload uptodate flag and just not
> > allow read/write if folio is not mapped in the direct map for non-conf
> > VMs (assuming there could be other ways to deduce that information).
>
> The only such interface I'm aware of is kernel_page_present() so the
> check may look like:
>
>         for (i =3D 0; i < folio_nr_pages(folio); i++) {
>                 struct page *page =3D folio_page(folio, i);
>                 if (!kernel_page_present(page)) {
>                         folio_unlock(folio);
>                         folio_put(folio);
>                         return -ENOSPC;
>                 }
>         }
>
> However, kernel_page_present() is not currently exported to modules.

I think it should be exposed if there is no cleaner way to deduce if a
folio is mapped in the direct map. That being said, we should probably
cleanly separate the series to add write population support and the
series for removal from direct map [1] and figure out the order in
which they need to be merged upstream.  I would still vote for not
overloading folio_test_uptodate() in either series.

Ackerley and Fuad are planning to post a series just for supporting
in-place conversion for 4K pages which is going to introduce a maple
tree for storing private/shared-ness of ranges. We could possibly
augment the support to track directmap removal there. RFC version [2]
is a good reference for now.

[1] https://lore.kernel.org/kvm/20250912091708.17502-1-roypat@amazon.co.uk/
[2] https://lore.kernel.org/kvm/d3832fd95a03aad562705872cbda5b3d248ca321.17=
47264138.git.ackerleytng@google.com/#t

