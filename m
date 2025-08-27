Return-Path: <linux-kernel+bounces-788581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D4C80B386CE
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 17:39:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E37EB460838
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 15:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CE572D1F7E;
	Wed, 27 Aug 2025 15:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="Ya1Fot9U"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B764236457
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 15:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756309155; cv=none; b=T33wsCrFST4qlqgAHJ1N1N/G9oOCbpqWWRsR99HeCfEhQ3vO3//tGfP1xyyNKml/+ZwZTUDW6/M/LJ1TJE9o4gfgxipR7qhQip/0Smp0Xc9A/lJxYUMXAMT4nqQvkB/jUamHUFBQWJ2K4cewy//wftCL/ZUv5Zyh2/fkIDGqkFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756309155; c=relaxed/simple;
	bh=WzQumGde61C3GLvm5gCLwugqwV0OkxnyiRhTDaCfSBg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DJo2i6IqD11ZwGueiK3GeJv3MZPAA+6s2Dbpkm7Ztfu4FA/dfVvDDufIxZ2+4vj5FgM7E8MhqHi3yFb/i3swqRy/ieR3s9NEevKxc/lmtXRhNGqvowvZDvhzKemq8g/XY0RD55yLPpj+DhuSYWC3ArDGYXP3P/ryhWcYDnATOSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=Ya1Fot9U; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-afcb7ace3baso1246446566b.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 08:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1756309151; x=1756913951; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JAnl4bFn7YJIAJ0z1R6sCpDav1qEAvuA37AHDZnUHrQ=;
        b=Ya1Fot9U0dVmDcoTlVO4IdAP7Km3QEvhSIG3C6UKmJ7owgAFDF2upvGA27ihUXjTA9
         fl0CTJUydB0F0BhXsOzVum1I/8FtfwO9MDorU9CcVcxbin4RiWiY0YGZ7R5M/oSbPYco
         kEynojOFLVqMb/Teogqqd5jn66jeSqs6wnjaKuLwNsr5i4thv04UxWD4zkqZWSj/+VQz
         c3OcnMstn/6SCOY3kDQQS+B98zxE3B5e36/gjztqnEkZltLrGPqDS4caQVqQZkH+WgA4
         Zg6zsaCRsPnehtFv916B+uJQ7YhReeayTCLnRQ6x4NDkYvGtOqdJnBhlrXbSztd3NwHe
         JQgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756309151; x=1756913951;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JAnl4bFn7YJIAJ0z1R6sCpDav1qEAvuA37AHDZnUHrQ=;
        b=hIiBeo2nadHoVQ/ChmECRtkfoeNvjLKtcwWOjwR0jygquRwuWL274qKrXYcu5YQweZ
         8F+s3jmsnEXuLENf3T0/VLKqFou/wYp0xbeiZVxpXydZPmukyo1VXduqLnK7fvXoM87Y
         PwHLI/fzZVStuYF5uqQQYz7EgE/tw9MZa0ARGu8axAqWPc+djKEQJhwMfQpnw3ydwVPI
         VoiVrqbwjG3iDKVKsP5QmX/mlP903jlHGozz4I9/JYFXCUpwDe+zP93q4RLoUptuOjPn
         YhnE2RNYiSEr8QefKDvb5MmOLFAq3GKtkcNVWaZFjeW5p/yXdFeK3nfAwp58vmofKyxm
         jZ1Q==
X-Forwarded-Encrypted: i=1; AJvYcCWnSbZFW8sHk/8uBv333HbY2QoodMfwGteq8tsWDIqya90K2B9lsg3WQKJLI+WUft71qp8q1aLgVBFVIuQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaQdSsddNqUuicVAmf2O6CEb5KbxNJwmAUQRj4S8idmNZCzmRw
	RvT0P+6iPvW9yHBysYTapYpVOnr0FC1nkm8MeZOZCidCtpmN2FQvSjbYqtu9jASWX1he0K3ylZB
	hR0lHs8IKluremtvJ7ahZ65qDRfEhWMflObpCkInprA==
X-Gm-Gg: ASbGncuGt7ne6MO/p6nok3Kk79xWOO3eHA2AFqcjDoHrPCM0Tsnm/VoiTQBuNUa5Kem
	reb/d4l2Doot0tTGAq143xgLsTmXfksED2N5QKoZhmJBYru8sNhVbVSN47Iw6wHzitlsreOfNQ6
	MtT0Cogl4LgRJs0sLZW37fbU43KIRYywtpLqcSRLiDxCR9iwWR5pvlQAHOVQGKKWg+tKCO6ZgQe
	+rjxJZVpFWgiRy/M9LZfsfp9qajH9inL+0=
X-Google-Smtp-Source: AGHT+IGdZTnAyrn6Z1nHv93WNlDG10RZ+ZvGr0jvBPfBBuK4HkngyzikdQlggg44pAD9u9Bjt9B0ZaW9XCeU4ylDZhk=
X-Received: by 2002:a17:907:1c13:b0:afe:d62a:f04b with SMTP id
 a640c23a62f3a-afed62af6dbmr19395266b.3.1756309151468; Wed, 27 Aug 2025
 08:39:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2aa3f478-9c87-4102-b83e-bf235372d834@redhat.com>
 <20250827150330.280399-1-max.kellermann@ionos.com> <30f52bf5-ff37-4e22-ac57-7be0b03b1f51@lucifer.local>
In-Reply-To: <30f52bf5-ff37-4e22-ac57-7be0b03b1f51@lucifer.local>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Wed, 27 Aug 2025 17:38:59 +0200
X-Gm-Features: Ac12FXysXWZnAhbNSepM2Yi-H6asDq5I0w85BopTVtWfMwBbXkVe9E6qrywHqes
Message-ID: <CAKPOu+97BQs6Y_nJ4ONsciSb1=OC_jZ7s9W4ftN-Z378Q9cZ0w@mail.gmail.com>
Subject: Re: [PATCH v2] huge_mm.h: disallow is_huge_zero_folio(NULL)
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: akpm@linux-foundation.org, david@redhat.com, ziy@nvidia.com, 
	baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com, npache@redhat.com, 
	ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org, 
	shikemeng@huaweicloud.com, kasong@tencent.com, nphamcs@gmail.com, 
	bhe@redhat.com, chrisl@kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 27, 2025 at 5:21=E2=80=AFPM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
> > But if somebody really passes NULL, the function should not return
> > true - this isn't the huge zero folio after all!  However, if the
> > `huge_zero_folio` hasn't been allocated yet, it's NULL, and
> > is_huge_zero_folio(NULL) just happens to return true, which is a lie.
>
> Hmm seems like this is a bug under a bug. folio_put_refs() shouldn't be
> passed a folio batch of NULL's.

Agree! That was exactly my point - I was hunting down a bug that
sometimes caused folio_put_refs() to crash, but most of the time not
(when no zero huge page was allocated yet). And this randomness is
what I'd like to get rid of.

> Shouldn't we just put the VM_WARN_ON_ONCE() there?

Agree, but that was the 2/2 patch I dropped after David's objection.

> But I really don't think passing NULL to is_huge_zero_folio() is a valid
> enough situation to justify this?
>
> You've encountered a case where a bug caused folio_put_refs() to be calle=
d
> with an invalid parameter, then you're arbitrarily changing
> is_huge_zero_folio() so it would deref the folio and splat.

Actually, my v1 patch did not do that. Instead, it checked whether the
huge zero page was already allocated, in order to make
is_huge_zero_folio(NULL) to reliably return false, because NULL is not
the huge zero page. Then David disagreed and asked me to add
VM_WARN_ON_ONCE() instead.

> I really think the VM_WARN_ON_ONCE() should be in folios_put_refs() based
> on what you've said.

You only disagree with David, but not with me. I'm happy with either
way of dealing with this kind of bug/abuse.

> > +#include <linux/mmdebug.h> // for VM_WARN_ON_ONCE()
>
> Please don't do //.

In Linux-main, there are currently 432 comments documenting #include
lines. This is a pretty common coding style.

> This include is suspect though, huge_mm.h is included from mm.h and thus
> this very easily might break some arch that is weird about this stuff,
> because a ton of stuff includes mm.h including things that might absolute=
ly
> baulk at mmdebug.

What would you suggest doing instead, to make the VM_WARN_ON_ONCE()
macro available?

> I've had this kind of thing happen several times before.

I know, #includes in Linux are a big mess. A while ago, I tried to
help clean it up, but my effort was rejected by the kernel
maintainers. Which is a pity.

