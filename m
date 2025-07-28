Return-Path: <linux-kernel+bounces-748131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 364C5B13CD2
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 16:18:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83E28188BD9D
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 14:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A64226D4D9;
	Mon, 28 Jul 2025 14:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NUGVxiKU"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 164CE26B76E
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 14:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753711968; cv=none; b=ccDObWfX2MgiJiR4F/RZoaI5IVcjw8huLZw1QlNj2XpRZd3Kq0LYQq6Qq3qpG0ZEF5j4eDdrY/iYOHiKq1R4Ah7NY1q00cVuNkt+8usf1+yPf9A8DpxxMBcrBzlOtoDAOvvPDOTj+ueiWJLApzB+g75Kr52dvy1Gj9a7iLJDBPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753711968; c=relaxed/simple;
	bh=eyO1Zh3JLq89LG2uKG9/+47hoHtzpYlBtMnkZyT0qW4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h2NAX4/yxeFI8wHSAyIJXfmLPzbmSiYY+hc04DuRQrQWD6QvwGqG2wjEvT0myCUsOFGXs/+af1XqDXVyBSQ4GqQP+O2lRmbXxSRx39cbc7b5Qb4jr8CsOPaVzhv8i9SDgMOAv0tUKIpIaYi+3wxq+Mg3a7UZOoQrK2D3mtUhMtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NUGVxiKU; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5f438523d6fso16260a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 07:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753711965; x=1754316765; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eyO1Zh3JLq89LG2uKG9/+47hoHtzpYlBtMnkZyT0qW4=;
        b=NUGVxiKUEabmjxLx2dhVJxUFKYpbYh3OW7tyvd8R+I785/jtDxqEHlar1yaM4CAIXO
         HXQ/JiPTgmtBezQbPyik8xCOe+Ej8ZKfFVAH5r6c4umGWerS2S4RIj+/DPSdj3rlSeec
         4hg0u0vNRGFHCZSlUuYpzooE/tP3aYADFPtbcq/wHjrG3zi1JRMCbRp6gCvfRSO9WmS6
         MTnTmwewXjwTmq4NnxUhpk95Eb/Aap3GCQqljY1fOfj+jzY3MJmqriLlcr8Z93Se6BM3
         bsUxjMUe59+4nf/fvzjuRBIpakmoAnM1jIPSD0y35uKx25Jk9VJiSsQSj1d4VoSc5Nfk
         RyUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753711965; x=1754316765;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eyO1Zh3JLq89LG2uKG9/+47hoHtzpYlBtMnkZyT0qW4=;
        b=bS16PAXu+3+2jM8FPu8HwwY0OH8NS90e9EBTuww5iHr+WAFhaZ+HAtL3YesuS9p1oF
         JxL8zwBo0k/tSntU/f+VtdPUO7Bb0vWiq3KAVyyRXzeoM+9ISRDGPNEySDNhKgLfBOUk
         VR1nTa3cqdnM4hSb/19xqqEm2O7ze/lYjmfPVk7fGTa/IJ22m2k2DVzrRYjmNIPohzjo
         H8PvPIbt6e/Pu20UPV/XpBMYzo+X1C6jJK3l5MSyfDigHLFtxmyVdphT/8ib+DHA9na4
         riZAwPymJvmVzU56+8FZn2vueJ2PJt+b+nTeLyjvdTjBlshnxDMHlHUnvDoMZsCs1QrC
         iWmw==
X-Forwarded-Encrypted: i=1; AJvYcCWh2jBebvQs4BxjbtMMDw9ipCA3/AdzfHiQOTSlGsd0gXu6nR+DVP+pw9XYofirnnT1WrISif1KNlQ1vDw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIlPVr9/8hwSN7mJwtqCZ83Xh/pDDawOkvMYllLuo93RIilj0Z
	1NE0m1oixoWG1S1LrlIdL1mKwPBHJMB/96+kOK8xc1A8Affjhpuwo4sdq0vnIw7bFGbP8VTHDTs
	v59HDrZrTuvdGt5wWwK2X7bcysRoVMExpW0BJkJGAduryGd8jEhwd/Yw9
X-Gm-Gg: ASbGncvIS3blNMDh4igeNdApfFzRdhuyz47aF+b90v6Y5xLg0rJ55RPmIEEhy5kNkBF
	73H0zreyt0c0nlypYoysSz39Y5u1KaBt0HShk91DyDfX01V67GRKNeOssfe3N7HKCozzdvzedZB
	OFcgXx6IFHDagxlLGw4oxeai1f2INwMlANqg8CLZphM/BNCr7NtbtJ+1czFN4efdyPU86vO8qN/
	xmJK8s7vBHd7j3gYy2fL6za9mtsjxgKeA==
X-Google-Smtp-Source: AGHT+IGqSyVPEeBd1/C92xR8Yk5cwA35fb1bP695SMItcVpEcxcrhb8x+oSwZU4glMUFyz5GmbVv9lfOnFDdUmso97U=
X-Received: by 2002:aa7:d793:0:b0:615:28c0:fac8 with SMTP id
 4fb4d7f45d1cf-61528c0fd99mr103964a12.4.1753711965037; Mon, 28 Jul 2025
 07:12:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250725-anonvma-uaf-debug-v2-1-bc3c7e5ba5b1@google.com> <aIb3In3G7XygrXNT@harry>
In-Reply-To: <aIb3In3G7XygrXNT@harry>
From: Jann Horn <jannh@google.com>
Date: Mon, 28 Jul 2025 16:12:08 +0200
X-Gm-Features: Ac12FXyCLEXjkKoQicke_OUqRIIitb9JxcenfQlHNDrm0vc-8LFcwy48OZbcVYg
Message-ID: <CAG48ez0sfeF73sBK0V2TiYMc=grhM5fA-673xXNeCqQMYo2dug@mail.gmail.com>
Subject: Re: [PATCH v2] mm/rmap: Add anon_vma lifetime debug check
To: Harry Yoo <harry.yoo@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Rik van Riel <riel@surriel.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 28, 2025 at 6:06=E2=80=AFAM Harry Yoo <harry.yoo@oracle.com> wr=
ote:
> On Fri, Jul 25, 2025 at 02:16:24PM +0200, Jann Horn wrote:
> > If an anon folio is mapped into userspace, its anon_vma must be alive,
> > otherwise rmap walks can hit UAF.
> >
> > There have been syzkaller reports a few months ago[1][2] of UAF in rmap
> > walks that seems to indicate that there can be pages with elevated mapc=
ount
> > whose anon_vma has already been freed, but I think we never figured out
> > what the cause is; and syzkaller only hit these UAFs when memory pressu=
re
> > randomly caused reclaim to rmap-walk the affected pages, so it of cours=
e
> > didn't manage to create a reproducer.
> >
> > Add a VM_WARN_ON_FOLIO() when we add/remove mappings of anonymous folio=
s to
> > hopefully catch such issues more reliably.
[...]
> Oops, I'm late to the party.
>
> A question; does it make sense to disable reuse of anon_vmas during
> anon_vma_clone() to increase chances of detecting this? (of course,
> for debugging-purpose only)

As Lorenzo said, I think making such a change would risk making it
impossible to hit some bugs in debug builds even though they can
happen in normal builds, which would be bad.

> Regardless of that:
> Acked-by: Harry Yoo <harry.yoo@oracle.com>

Thanks!

