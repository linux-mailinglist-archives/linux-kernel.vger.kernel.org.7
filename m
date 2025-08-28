Return-Path: <linux-kernel+bounces-789969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D829B39D84
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 14:41:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22F8798605E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 12:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F25D830F7FF;
	Thu, 28 Aug 2025 12:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="CEieVCQL"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D0C30F818
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 12:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756384844; cv=none; b=ZVeaSlIXqP6Zz6X7k5KqRsjNcsfHQOhZi3mOc9mhFt6UoO28plcPkFWmbGiGwhY4Gd6flK/QJoHTDUh9hNjw8+ULpzyNzSUJBvnow7q3n6azE9dzkUZsFOiKV0qHTeDqHmNr/ncnq6Zg+TDSIbdM1aWUep67mFGLzwp6DM0wydA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756384844; c=relaxed/simple;
	bh=trSlbet/QuueBs9xQCBBEcGeeBLPyPlp1BPEQPaV1q0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NuVhVkqhlx1c915XY3v5N2gHo31h2SnEDzefaR0eWWa8+3KdPzG8N0/oc4ikvnhGHmMVaTAo+p+POCLR6OENpU5W2POfpYl4P67txwJgMNMp+JHqUuaSXhZJFvojiKuFQadOj14bomLIn/O517NnaCYVlcPMsl4TZRMl1Q6T8DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=CEieVCQL; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-afcb7322da8so160049866b.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 05:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1756384841; x=1756989641; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=trSlbet/QuueBs9xQCBBEcGeeBLPyPlp1BPEQPaV1q0=;
        b=CEieVCQLgb/s9cx9H5/4Ikd9djvc20IWSEKSQMb3rFHDNpZWVeiH7DMZfvI4EJqRUT
         1cuc8LnkzItpJ+MZIhCdO3ydGgP9s/RYYjE4LwJwdX3jgPAc43Ya44H/coBxAMxO6uyj
         eXzxpP1BUPJX4Qn5Sq/RBlObutecHoK7ymd9RGBiHBnDss4E8Zh0A2IvdGlxw4LVjTu/
         usJTs1DtdD1O9/r5rCilagUewoUhc2Tx4kxl96eu7HIJZrv61XKABh2uurZgdgFNzhjP
         Vz5LbrxCipVlEbQS8WNIHo5p0WIm86IUyB8i1yNphNWGzgLsPTKepxRGbaa/oGXBxKbv
         zuEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756384841; x=1756989641;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=trSlbet/QuueBs9xQCBBEcGeeBLPyPlp1BPEQPaV1q0=;
        b=Vi0WIV/MmSQwdI/4XNNFgLiAhRwhE/0Rct0ulg7zzAQibACNTMMF9NDF/R3QZ3StFg
         ELzpPt4Pza2sT9+iH5VcIxXIWJsGJoOdUA/PWTiIMT1PZ2spY0k0qcdEC7ManY6tL1dS
         ct95UWybNTAvXqid/0+OcO6OWQVB/WaET3LCTsWjHTth+r2h4LIWEIlV9ukQ6SyZy03V
         cGqDQ6ljYdHHcpjUi3gabV33JvtZccZ9EKDnDi2h+19OXuSDnJkggDI6vpXcEZ65VEiv
         WDmzTMz4mhA6wM3VIGucTyMof9FcICjU3SarbrTnGXvHuBIfFH4ZzgmhYLVi466z+yM4
         Lchg==
X-Forwarded-Encrypted: i=1; AJvYcCXRJ6LYVV8NBd6qu+g3nRZA2kmSx2oRnRU2FmhgPCTYwQkzOO5dOHsPs5bb3vfQVoDFSDA2N5lBYiWG4uw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLrnj8D/40q1EXKv4ECIGEwCLPx0FD4XxIkU32644vmBxx1qO2
	Qs4bC5zu7gkFEG2Y7vB6yyZ8SvQpMgOGsoON+idUuKXwOIjNeK7POT94iG87u3Yjgeic54u9Z9a
	FUHaVciRn+R+62md7DIRmYPxqpg95lDnaazg5t33tiA==
X-Gm-Gg: ASbGncv1vOnKLVbvR+8BUQdndwbAX5m3Qk1uVzIGNWl1k62wk/XYXNH0klayAuTdo9y
	CjyW/nS4sYCl8lp5QxGC/4LkulC5omAx4rJLJ3dLz/BUsyspce9VnO7fDEXiCaQKw9kVbXcCIic
	p5GNg4Mngn/dJz4WdISv4GKWJTVI7HKcQ7369RwPLCMcjNJuEkAxz6TvkD1C3Hvz0l2/a57fPwM
	dKuyqhvqjRWPRCO1a4/MNOwojje+uq6uUc=
X-Google-Smtp-Source: AGHT+IG8bYx4wIXfIdcPfZhiB4fk8x1jfzQ79t0ZECOBclW3p4Or6CJiYYn5dcoy89VV/Q824U7zbSHINWxTvm92/XY=
X-Received: by 2002:a17:907:dac:b0:ae3:f524:b51 with SMTP id
 a640c23a62f3a-afe28ffcee8mr2305659766b.10.1756384840560; Thu, 28 Aug 2025
 05:40:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250827192233.447920-1-max.kellermann@ionos.com>
 <c688a2f6-375e-4a00-8d44-6a833e3d30ef@lucifer.local> <27a21510-e9e8-4eb2-9e26-618c103d49c6@redhat.com>
In-Reply-To: <27a21510-e9e8-4eb2-9e26-618c103d49c6@redhat.com>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Thu, 28 Aug 2025 14:40:29 +0200
X-Gm-Features: Ac12FXyF-XXXzaswyonUogGJ99vkSxahZWLwoczFyKONaWpaCVV1M_vCYlT-A6M
Message-ID: <CAKPOu+8DbXY6wT_8gcqLDpyZEg0=En6wOYtHX_VkUvZ_oOLHSg@mail.gmail.com>
Subject: Re: [PATCH] mm: add `const` to lots of pointer parameters
To: David Hildenbrand <david@redhat.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, akpm@linux-foundation.org, 
	Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org, surenb@google.com, 
	mhocko@suse.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> On 28.08.25 14:24, Lorenzo Stoakes wrote:
> > On Wed, Aug 27, 2025 at 09:22:33PM +0200, Max Kellermann wrote:
> >> For improved const-correctness.
> >
> > 'const-correctness' in C is extremely weak.

"const correctness" is a commonly used term for this concept, and I
find your arguments against const-correctness "extremely weak". I
don't think discussing the benefits of const-correctness is worth the
time; the concept is trivial enough, and if you don't already agree,
there is no way I can convince you. Let's agree to disagree.

On Thu, Aug 28, 2025 at 2:29=E2=80=AFPM David Hildenbrand <david@redhat.com=
> wrote:
> I recall that Willy did some more targeted conversions of that kind in th=
e past regarding folios.

And I found many more commits adding "const" to pointer parameters.
That shows this kind of patch is acceptable in the Linux kernel.

> I would appreciate similarly doing it in logical chunks.

So you suggest splitting the patch into many? I can do that, but will
it be merged then, or will Lorenzo be able block it? Will further
const-correctness changes from others (e.g. Willy) be rejected, too?

