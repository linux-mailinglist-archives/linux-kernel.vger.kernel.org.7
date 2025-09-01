Return-Path: <linux-kernel+bounces-793866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BC8F7B3D976
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 08:07:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 406BA1899E73
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 06:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D69351F3B8A;
	Mon,  1 Sep 2025 06:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="emnj6MpG"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C457442C
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 06:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756706826; cv=none; b=rJWzllhQCxbeLORMKoi/WcLaLbxxIdK31nvWoSthDVVjkEJ5+6iWHY7WhQfAaljoYk4NTmdL64X68Q01NEkcxs0WtpRHuKxAmziqS6AN1hjlOVP+8jPXIsXUOIpHGxS42TmOgmt6h8Q2yGyBktPsZ1Vtb0zqGLnDSPS8hkNnz3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756706826; c=relaxed/simple;
	bh=HcQrHOb1wVfTrlN9M0H1QaA5L9SHSXnUMIJz92t+7EY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=do/xMaKicAW32Dtdvbor4KcghKG+pg6wqBa1AhfED8GVDZ5or96M60xGiQ2ltEsBdXSVxRy7ZpigTIojJPZEWh+IB4g9xGuEgz4lfwyGQZ5OcD5cLSATtyXbgRl+nCv2neFoSLIMYYlZpEwcXJdDcyq/d0JQJcLwIOT2m7/9joo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=emnj6MpG; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b042cc397dcso68046666b.1
        for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 23:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1756706822; x=1757311622; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gnu1IXOMn4pWHCktYzkVxOKGOFnkM5LbN52VhyjC5rU=;
        b=emnj6MpGDuvOjqQcdT1e2M+RDDaGjW0p8C7pt81AcWuyUo2wmZaVK34cf8aN90DzY8
         XB7Su1nKCLnHN3VyOBlZj+i4nC6rA3bvz/JjkUa5mhA4P+VWfabHYW4avIbh2nnqi0X8
         RzppGHtm4P/YgaOMFpXcOQMXQImf1f4f6avSyg4PLcr6oLbbHb69Mm3rTxxesq3zr7Nk
         X+1CWeEFxquawkIojxA/I4qDNpsYeRwgwUMelqs70/XO2HThNgBE2Fq9ocx8vJNiImpE
         ouPivit4kjlpG6BB7UcmX9gJiTjDsmoG7rWll6OB/P1JwNeGsknLBKT63NnrNOzAEUJr
         JEIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756706822; x=1757311622;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gnu1IXOMn4pWHCktYzkVxOKGOFnkM5LbN52VhyjC5rU=;
        b=r2bZdWcH+TNHUrzbAIVL1evTiqFzTuLqSszvbEUj0yOJfAoMv5rYo4Z0m+6RhO5f8t
         yzbzm+qQhxDBAWsyVKJiryf1qJ/CI0Zw0sXCtOyazYkwXdfuaSEOIWEyJLO4JWqFbfgQ
         RXXssj349K8X6d/5qoQdtCuycZa1PCecUHD7gwmgsSiWr4GpE85tDsHxwPI4kC8Rtofa
         Ios2G4SXPvrmLiahOEcnp2dYOtCDqdRjfGhHb6ERoILYdLqHAUEnfaWpaC3MUCsSj3Al
         kzLvLMzWQDofSpZ4SWnrp2PO0cZnnvNS1nT0pnEaFNa/cypWfLQVQHsHo7crKIxV6Ojc
         Q18g==
X-Forwarded-Encrypted: i=1; AJvYcCXbJx5CDv3YYRVuw1B4DoenFDYbBuwK2x6A4yrCQusrbSmrVdm3AzgDmPD+o7X1XiI5sR+H4uf5tEkhAoA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzguUEQBJV+wPjBMINEDckNNvSxyQE4x3u6dO2OfVMEx3dkz7V
	kUPT7Bg0YpgMEQjM0v2Z19nhfQd1mt08wUxsx8ZFzprJlg1jmoHEoMbsoJZsbPNA3GvQuVns+GN
	sR3DZTDZo2v521F5lHhCK5yxorNCV+CI0VKpwDuddicOGj5ErALodjSw=
X-Gm-Gg: ASbGnctlWR5esxD2Jrrar8A9QkhTsPocjs2kczat3znu28h+Y0Hl+xns1Q7K9JTpFdB
	a6RuNnoI0wj6dOvXEoYu7+jE9fqKo0IupmdmfVa3aAIGlTa+AGn7Y+k3+Ap7i4YhnW/zY8NWXCa
	vjFsLdT3NzGZnBtxZyXQPG60i/ILV2x7+7227OQt/tNdDOyOc2NZaaNYQ2IGEe3wuil+rcmySWI
	LSGw4UT9YQ3wSt53wuzKNszPLxPjoh9q5Ilgl79ngyiug==
X-Google-Smtp-Source: AGHT+IEdaMOQbJHWE/iShULgOk2Ptal9fTqO2WN/JPiF7AgbveiCYUcgAekCFvIWZBDFL8NIRtadXqTLu8pJokZAlDc=
X-Received: by 2002:a17:907:2d21:b0:b04:1d85:7106 with SMTP id
 a640c23a62f3a-b041d857815mr341972266b.21.1756706821818; Sun, 31 Aug 2025
 23:07:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250831093918.2815332-1-max.kellermann@ionos.com>
 <20250831093918.2815332-8-max.kellermann@ionos.com> <aLTrAwhfHne_iuVS@casper.infradead.org>
In-Reply-To: <aLTrAwhfHne_iuVS@casper.infradead.org>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Mon, 1 Sep 2025 08:06:50 +0200
X-Gm-Features: Ac12FXyWDxh49J8Y4EQOCnwU2qaQTP3uHc98CGH1GCTMePapt2fS2CVRLAqTcsI
Message-ID: <CAKPOu+-4N7Zywp+Hdr9CNdO40gm=tAwD4O9M38d4rSdo5tzNRA@mail.gmail.com>
Subject: Re: [PATCH v2 07/12] parisc/sys_parisc.c: add `const` to
 mmap_upper_limit() parameter
To: Matthew Wilcox <willy@infradead.org>
Cc: akpm@linux-foundation.org, david@redhat.com, axelrasmussen@google.com, 
	yuanchu@google.com, hughd@google.com, mhocko@suse.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, lorenzo.stoakes@oracle.com, 
	Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org, surenb@google.com, 
	vishal.moola@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 1, 2025 at 2:38=E2=80=AFAM Matthew Wilcox <willy@infradead.org>=
 wrote:
> Since you're going to respin this series anyway, your tags are a
> disaster.  Tags are not filenames.  They're just to indicate to people
> that they should pay attention because it touches their area of
> interest.  So this one should just be labelled "parisc:", not
> "parisc/sys_parisc.c:"

OK, "parisc:" is understood - but what tag shall I use for all the
other patches? They're all subsystem "mm". Are they supposed to all
have the same subject? My initial post had that - it was one single
patch that touched the "mm" subsystem".

(Also I'd appreciate a wording less strong than calling an aspect of
my work "a disaster". This is mostly just taste;
submitting-patches.rst is unspecific enough. And quite a few commits
contradict with your interpretation like 620943d7ee69
("include/linux/mmzone.h: clean up watermark accessors").)

