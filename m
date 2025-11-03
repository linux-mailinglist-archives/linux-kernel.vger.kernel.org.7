Return-Path: <linux-kernel+bounces-883549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A7AE0C2DBC7
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 19:51:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C5D714F1924
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 18:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDCF4320CCC;
	Mon,  3 Nov 2025 18:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aTY/xaqa"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC1D320A39
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 18:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762195777; cv=none; b=U8wLuqzHW5Hn7kEB8MOv7ztLqbBTIlE5jmzly1gG6wP8mMxKfbkxzVyZnWwOGXZfF7i526V5DRko8U46CDfiUQCYsuviyLgDQqdnaa8rlVFFwkrOTIGhRRjSnkEnNK3UgJ8y004qx/YmrJ7oWEyWd5IQEgIW/afgV2XmVs+KyxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762195777; c=relaxed/simple;
	bh=cUXHg1xiNrQAJnQmh3zAMwsMypmYmGeR8zDCYyhj5sQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dXXuxWSxUFC8Pcr3rw8cW1hgoVLSob0abpovc/+DStqyddFumOwIzXcq7gshC6GzcazD8d2B8jCGpzAP+eKqrQSI6zKwH0/dXB3WBBqbNtjpMX0whkiZ7pEzrnK56mnHwG7i3VwkwfIBDHCX8cfGiCd9dwsrFrFb2KaYcCMfpCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aTY/xaqa; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3f0ae439b56so2471568f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 10:49:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762195773; x=1762800573; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cUXHg1xiNrQAJnQmh3zAMwsMypmYmGeR8zDCYyhj5sQ=;
        b=aTY/xaqazcbzk8ytmmYFIWPxNJZ3mCWnimlq/tSoALFFaScdclz9ng1ny/7+NdsdXl
         fC/lSBM+Ll8tD1ODwOfPH6FcqM+uxhmPtNLE14bGr/wLn/zexzt+zabMF/4R+emCBKNq
         YBnqMXUjllF1l7Oq1T3UMZGKwfDjx7gq8tlW0lB4XN5yGYcSYM64xN5p1/7DNdY0rALD
         xV1gu9NpoldrXkAvO1VDRmQGVtxoPGedRf4INUhtEnTyOykmZg4EtuIeADYoyCU003/n
         LxuyRieOIDx9FxGX7N4cNGEl/FaiLD/ruzI3Oae1Qd10mScp3NY2l1RDv/ap+AGlcqvp
         vGpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762195773; x=1762800573;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cUXHg1xiNrQAJnQmh3zAMwsMypmYmGeR8zDCYyhj5sQ=;
        b=GFR9+hZ6NEMrgSm75RtKwQA4LZBzS853xLFKUY3tNB2qUjTwUIJdTMw0oFyS/0FSvP
         KRb0YCVIuvzZDFTsMcmtWXZK531tPu9GYDQT3NUV6iYgwbHDTj7kcO/pJ/Ll76nfcdZJ
         m8nmskGxmWEoKoQtDwiZXtrdqVFqRwX7a7RajaUffWVg9CPpZs9cTZ7miU1+fB1I157P
         01fG0Qmp9WL33haPLejWaB4HeiLIfilE8Wn2B6zg2SAI5o8yqRXG9cW0x27o3QZBGNHl
         txtdy0zEDVJG2qm51hIx6rS0lcAH3oT5AM+Hv1iaQp0Zac7GAXZwE4Zp1A/Np8vSu9gV
         Vhag==
X-Forwarded-Encrypted: i=1; AJvYcCV6CLNu5HFYrRPn3ugwpEvT7UtDsCe65IeEyrrxLAd7eOPW9VipqOCHtpCLjBNvHzIJA6jU0NbnvmDdoWo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjNVkGQBAhBAO/Vr5IvVs17C8zYBDC3q35e+LGJzrdQAUX7ssW
	0je+6PSMf5hOTsCHJbooMWMun48WiV3uyNzb/hgi9p4I4nGJ8EWy4Wd+sNY1B45vcen0mGcWO6j
	Y/7/jkbWfLwuBBsJjT+CdIMam8UfMUOw=
X-Gm-Gg: ASbGnct4Xn4ppUSd7LzvZe+iHTVmgxKr/sL0t9FTcA4tNZs+wsTTVTqioknfgHto03i
	KOW/XUPEFV+K6yWoVOsYrT2o/B2TSK5bOL0staccjEDOq8NtR1GkpDr75jRchhrmE2S+8zj545C
	5hDD7lJzvN6C1ArV+BVVHaSl5r2gPiX8rHLDfWkfjDgmjgWBNTIS7si6PFQqAdqgOpJmMpiwA50
	9NKunifSzbQ0KEsJuFTcw5zTWavPHpvku88BAyT4QmkV/RSl9xNlrwU0o04qk3Ys7BPZZUXa1ZN
X-Google-Smtp-Source: AGHT+IFt4gOGrDj2t6tA8XILvHGEiv4nujQD4kFEHH+eHW0pODe/pp5N8EnfpMaVw2g1H2iXy/kIoISejExSMdbzjy4=
X-Received: by 2002:a05:6000:2903:b0:425:7329:e1d2 with SMTP id
 ffacd0b85a97d-429bd67c41emr11138869f8f.16.1762195773367; Mon, 03 Nov 2025
 10:49:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251103-fix-nolock-loop-v1-1-6e2b3e82b9da@suse.cz>
In-Reply-To: <20251103-fix-nolock-loop-v1-1-6e2b3e82b9da@suse.cz>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 3 Nov 2025 10:49:20 -0800
X-Gm-Features: AWmQ_blWzRfr9N_Nvg7Vzkxyh1lg6x7F8lqvMADmV-lK2vXgOf6Km-urto1BDyI
Message-ID: <CAADnVQ+pMfza=PF6eo05gSrtGkE1LbT6Fsg6DnmqZcta-3KUiQ@mail.gmail.com>
Subject: Re: [PATCH] slab: prevent infinite loop in kmalloc_nolock() with debugging
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Harry Yoo <harry.yoo@oracle.com>, Alexei Starovoitov <ast@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Christoph Lameter <cl@gentwo.org>, 
	David Rientjes <rientjes@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 3, 2025 at 4:24=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wro=
te:
>
> In review of a followup work, Harry noticed a potential infinite loop.
> Upon closed inspection, it already exists for kmalloc_nolock() on a
> cache with debugging enabled, since commit af92793e52c3 ("slab:
> Introduce kmalloc_nolock() and kfree_nolock().")
>
> When alloc_single_from_new_slab() fails to trylock node list_lock, we
> keep retrying to get partial slab or allocate a new slab. If we indeed
> interrupted somebody holding the list_lock, the trylock fill fail
> deterministically and we end up allocating and defer-freeing slabs
> indefinitely with no progress.
>
> To fix it, fail the allocation if spinning is not allowed. This is
> acceptable in the restricted context of kmalloc_nolock(), especially
> with debugging enabled.
>
> Reported-by: Harry Yoo <harry.yoo@oracle.com>
> Closes: https://lore.kernel.org/all/aQLqZjjq1SPD3Fml@hyeyoo/
> Fixes: af92793e52c3 ("slab: Introduce kmalloc_nolock() and kfree_nolock()=
.")
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
> as we discussed in the linked thread, 6.18 hotfix to be included in
> slab/for-next-fixes

Acked-by: Alexei Starovoitov <ast@kernel.org>

