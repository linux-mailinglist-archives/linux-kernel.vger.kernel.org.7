Return-Path: <linux-kernel+bounces-758041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 91854B1CA1E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 18:56:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82C7C7A890D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 16:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0853629A9D3;
	Wed,  6 Aug 2025 16:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KxGv++5Z"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C89602882CA
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 16:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754499371; cv=none; b=J80bpO8amCotuYIbGOytdpLNXnL1iG1Y2FI8bgzEcOu9wiXSB+tU3TTGQpzrCUp/FPP2uKgxW7eU8AYVVPBN7T5XMTyFL6OiRw8bkRfBz3IfWI9VLwGLp86o/iHLLasyXNZrKwr+n5A//WCLX1wo6Nw8uPgmvx/xfXp3KhXo7Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754499371; c=relaxed/simple;
	bh=YA2xMm6GZPpLepmZMpJHF6c54ioYllFRdsNz97VVNgo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H6FpA0AalNBKrVhRYavSKaRwW7Rl7NxA5TnaxzhA78IZd/AmsA9Pg5d8c9monTUy/LKBJZfzZIDxkdslceI0TMVSbSkTZWr+0wvrt/3jUsI9qzI2IOZvUqYvKvoXmWwOxJM3F94+mHMfK5XEGChMFqCIiLhEuA7igbHniAdvlyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KxGv++5Z; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754499368;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=caRxOupOwvLDE4AxnGKjW2rkeHCX/7D6A5vP6Lpr8sU=;
	b=KxGv++5Z1BYuk4lfSSUVnbkVyTquGPkHj2mtK+C1EA8hEbn0O4dAzjluziEtPy+aHo8E59
	JPFPuhzwySLnBsK/V6RIjX3w4m28L6M5gHQxLecUjWNYFLDT5dHT5XPOtpV2tV8C+lh2yq
	nan62M0FzrINudizA/N37MnJbFmuTn8=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-532-SJY9hb5yPU24xBQ8L_4CcA-1; Wed, 06 Aug 2025 12:56:07 -0400
X-MC-Unique: SJY9hb5yPU24xBQ8L_4CcA-1
X-Mimecast-MFC-AGG-ID: SJY9hb5yPU24xBQ8L_4CcA_1754499367
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-71839bc5591so287017b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 09:56:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754499367; x=1755104167;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=caRxOupOwvLDE4AxnGKjW2rkeHCX/7D6A5vP6Lpr8sU=;
        b=MR6RmzZeL3J+jduhb/3Ddg3i4Bqb8fDlKWxmBmlVRQ4TyWmuiplaw2UUPIPydyzbsq
         6BGkcHcsSE8CoFHMILacaP/YOCxIBP/p0NANVaBbLR2gPPERTtjsu7qJQOgdmrYi+Y1m
         MeNXix9RWF5CAx7KFrTHSb5W42emCd6pw18l/HoAxzXRHiFLT4ZWY5C0ORAyuqc3jXUE
         sDWoT3Pm9bI4NTVCkawX6BVT00M+YJUrKLMVjZUZQpJQli8gXl8WUChW7b5rClb8+Ssb
         mFGxPIBLI0DobnR+T852X3QsFzkoWKswsFIh3WvWKk/HXiFJa71+89eEUw8BJwxNLkbO
         7uuw==
X-Forwarded-Encrypted: i=1; AJvYcCWn/x7UeKBT85EIpjh52/RPFaIE0HcZV0N1sqa7WJHmkLEnY2WRJeLVdAXRes5bHPTZD3Z6HDlA2+dGGsk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3uieMZjyDe/g5ZjXTFHEtXotC/g28o0c1cHN2GWI8TczHceWn
	LOJg6WlFPoRYsEZXDL8XnnXGcKdF1TTz6vdPnKouKgBSyOFjRJ9ccav//SA03L2Nxc2zMFgYS9N
	sLJoixisL+pRePtIcOegQ+PjgQQ+DKa4SUE0n/d4kX2Boahkp5eWY0j2MBvjxaCmSEA==
X-Gm-Gg: ASbGncsTVHtMQTFkvA6ECo74XnPMKe0BgHYlxnzeQKUUgh1kE9SBcpcXw7/AUgm2Tkk
	6lkZy3yf2J07Y+RZBYVWkYhNKQEmA7U3amivHaqQ3LsW5k1mEqDXF0tHwcgq0s/Y6RwvTXAiHb/
	6LWLUwJTj8HUqaOE0ODXnfI5NPfJP/AdH2YoF/VjHIYfvS73BiLcnpAx+qBwwGZBu+dM9L1ZtAa
	eGChRomQGq8nw+lW0z1H2Bb0aSTtUywIWTtrrOHHDnjmu2jPW2ETM5NYKJ9muPjG4UUxZgmpGuA
	tKb/6MLrcszNFMRnezRKUSvGyixtK/PuFCY1NFp8EnquMidNh+v2+lT3kRaIOzO+V+2gLHLFKip
	8mWwruadgDm75z+mHgup6ag==
X-Received: by 2002:a05:690c:3588:b0:71b:6ad2:d10d with SMTP id 00721157ae682-71bc9710de2mr45651897b3.11.1754499366758;
        Wed, 06 Aug 2025 09:56:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGQh+vw6wvMh/Vx0bRJhyUZIPHP4wgxRJuDS2ljLQE7fUIxuqSyVdyg6fKn8o5oDzXI3s/eew==
X-Received: by 2002:a05:690c:3588:b0:71b:6ad2:d10d with SMTP id 00721157ae682-71bc9710de2mr45651537b3.11.1754499366296;
        Wed, 06 Aug 2025 09:56:06 -0700 (PDT)
Received: from x1.local (bras-base-aurron9134w-grc-11-174-89-135-171.dsl.bell.ca. [174.89.135.171])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71ba7634498sm18397677b3.58.2025.08.06.09.56.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 09:56:05 -0700 (PDT)
Date: Wed, 6 Aug 2025 12:56:03 -0400
From: Peter Xu <peterx@redhat.com>
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, david@redhat.com, aarcange@redhat.com,
	lokeshgidra@google.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	syzbot+b446dbe27035ef6bd6c2@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH v3 1/1] userfaultfd: fix a crash in UFFDIO_MOVE with some
 non-present PMDs
Message-ID: <aJOJI-YZ0TTxEzV9@x1.local>
References: <20250806154015.769024-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250806154015.769024-1-surenb@google.com>

On Wed, Aug 06, 2025 at 08:40:15AM -0700, Suren Baghdasaryan wrote:
> When UFFDIO_MOVE is used with UFFDIO_MOVE_MODE_ALLOW_SRC_HOLES and it

The migration entry can appear with/without ALLOW_SRC_HOLES, right?  Maybe
drop this line?

If we need another repost, the subject can further be tailored to mention
migration entry too rather than non-present.  IMHO that's clearer on
explaining the issue this patch is fixing (e.g. a valid transhuge THP can
also have present bit cleared).

> encounters a non-present PMD (migration entry), it proceeds with folio
> access even though the folio is not present. Add the missing check and

IMHO "... even though folio is not present" is pretty vague.  Maybe
"... even though it's a swap entry"?  Fundamentally it's because of the
different layouts of normal THP v.s. a swap entry, hence pmd_folio() should
not be used on top of swap entries.

> let split_huge_pmd() handle migration entries.
> 
> Fixes: adef440691ba ("userfaultfd: UFFDIO_MOVE uABI")
> Reported-by: syzbot+b446dbe27035ef6bd6c2@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/68794b5c.a70a0220.693ce.0050.GAE@google.com/
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> Cc: stable@vger.kernel.org
> ---
> Changes since v2 [1]
> - Updated the title and changelog, per David Hildenbrand
> - Removed extra checks for non-present not-migration PMD entries,
> per Peter Xu
> 
> [1] https://lore.kernel.org/all/20250731154442.319568-1-surenb@google.com/
> 
>  mm/userfaultfd.c | 17 ++++++++++-------
>  1 file changed, 10 insertions(+), 7 deletions(-)
> 
> diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> index 5431c9dd7fd7..116481606be8 100644
> --- a/mm/userfaultfd.c
> +++ b/mm/userfaultfd.c
> @@ -1826,13 +1826,16 @@ ssize_t move_pages(struct userfaultfd_ctx *ctx, unsigned long dst_start,
>  			/* Check if we can move the pmd without splitting it. */
>  			if (move_splits_huge_pmd(dst_addr, src_addr, src_start + len) ||
>  			    !pmd_none(dst_pmdval)) {
> -				struct folio *folio = pmd_folio(*src_pmd);
> -
> -				if (!folio || (!is_huge_zero_folio(folio) &&
> -					       !PageAnonExclusive(&folio->page))) {
> -					spin_unlock(ptl);
> -					err = -EBUSY;
> -					break;
> +				/* Can be a migration entry */
> +				if (pmd_present(*src_pmd)) {
> +					struct folio *folio = pmd_folio(*src_pmd);
> +
> +					if (!folio || (!is_huge_zero_folio(folio) &&
> +						       !PageAnonExclusive(&folio->page))) {
> +						spin_unlock(ptl);
> +						err = -EBUSY;
> +						break;
> +					}
>  				}

The change itself looks all correct, thanks.  If you agree with above
commit message / subject updates, feel free to take this after some
amendment of the commit message:

Reviewed-by: Peter Xu <peterx@redhat.com>

>  
>  				spin_unlock(ptl);
> 
> base-commit: 8e7e0c6d09502e44aa7a8fce0821e042a6ec03d1
> -- 
> 2.50.1.565.gc32cd1483b-goog
> 

-- 
Peter Xu


