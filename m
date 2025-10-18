Return-Path: <linux-kernel+bounces-859377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF26ABED703
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 19:57:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48FB319A60F0
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 17:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAD3425FA05;
	Sat, 18 Oct 2025 17:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="cDC0AuJG"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E94A1FE46D
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 17:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760810234; cv=none; b=HLSf3LRkat4SEFLvDl5GJ3Ne3BgcyDIoRK7FtZbLww34kGIiROOyN5hdoQgIuzR1Was6gtSLgkT+7rnHiuX7lT9Xq+15O+qNs12WsqTfPePbX62o6eqhVLV7uiERfgO2cO6B5A/phDzuaVub3hoGQ2PbUQAF2xd50EJRB4g0/Xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760810234; c=relaxed/simple;
	bh=+0NDnqm96mv6VJBmnJDP9J8W2eqsuwjSNKSIB/4f6gE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CV5tz4q1bh2gXTPAZTkFBS4vJ1o5daWKWMqhiygEiqe+LFi3fUJvZJLRwTxcuR0fOq7hw+0svakIfH76WoSWvvVrWYW8VpjQOdvhdxw0BgG7bnlmzjRXa98qThftsdpr2ZXcLOQbX7j5wb66M6Uky/zf8c2fRWQcxXak8pS5ozc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=cDC0AuJG; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b3b27b50090so525821066b.0
        for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 10:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1760810228; x=1761415028; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lrPVFS9Dd045lBN8JzZ3YytOba9ttGQFMrMdfscWZIk=;
        b=cDC0AuJGl1a8D21yMBkKbAK8MchGlKLnx9LDwZ9bqqL1sR86VB6CFKFneF2yJZHpLU
         7/bjEata07kKP5i9unEaRz/Gq9u+CDx2XZ762W1Lc347r5/9BTq3jA2gPj5UvRRosaED
         txD94f66kmTwT7EavXqrUfuTAET5qpQipCn00=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760810228; x=1761415028;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lrPVFS9Dd045lBN8JzZ3YytOba9ttGQFMrMdfscWZIk=;
        b=JdLc+EE9qPVpuT7mPblbb+MC6sR7jthmUubiTQwuvji7AqQhd5OwEEgQrEQ/Zg/lq5
         pkKhcHskXA1UfD+XtAgbgQYEGh3Ks70+BI4IN1wX4/csqdOFyaP6hSjcxf1bMfvwD+L0
         cb6zcvjLEv0xQLZdSfIfTmIdEsY6cCYHq+nJX2y+Dz0RaKdyvIHuYYg7mQHujARD5Fi5
         FkBlzVXSPRkiO4oasPcm31tajIsVy4B6JDtBvc8l7IFJj0a7zIrzNGPzVkJKQWmjjlH+
         qyckt4T+u0QPZMqfKfFEiKdhK2WBS7WI3fSgYk8T9b/SHz2r4ldhc0rLGRA6NIZqMmFe
         M8+w==
X-Forwarded-Encrypted: i=1; AJvYcCVZlRcqqh2qMB76BK2oRh+75oMP+DyXh5OT74kgoND4waUo0gHtQhgY9wlhQv/ptWehCvhAQ7Ev/26FHl4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6vBbB1oZf6kNsA3AwQGbe7wOcIcDTybogQGLSlOw9jBwqhuXr
	hI7ddOXiGgVElxPpvDr3oCoMGrUEUGhI7CJtoreJUJIKQ+ZwcoT+10ls9Kag28h/uSsAiPFqLzG
	Gu99h7P0=
X-Gm-Gg: ASbGncs5DSSGNVBtxG24Q0n8w5Im6iajNgaWCrmj11RNNVvNs0mAq3ecg6JccRbSszZ
	gfxJphZ920rH7b10qZXtLsoGerfMFo2NVL+bTmJweJAnQFGgSnNxShKzjafEmdbqoT3wRKQ3gWO
	2EJMIq40BeVhSoKE2qms3hjHXNLgaxwnI9BsKGmrlsdQJ+9IORatIx6fFM7FackfpjL5BR+u1Uc
	JTLj4o87y7nLloB5pHnPlC4lLLHMSuPAyuQ50xdYBeRyAbwByHQiJi+oQZDcXUbKZJY7Pa1IGIq
	eKvZ7b2jUIo7DF4/0RiP3wFnuTF5E0Jwg/ssBnbFg7RKLZxzNPCBNc+FxYoy3wDg13h8aDZpSFK
	Q8u+adAilx4SzRW+SgGWDUdYdis6PybVpKpd45MeiFLKsha8oMmZT3yoFdw0fUUvKunYSvcQJ4S
	KeL106dK8KjA/8SW+T12B93chl10JfI5anH5YRWTAMNVoLsoXCuaHuSm7U0HD63gJfoqjhxyw=
X-Google-Smtp-Source: AGHT+IEIKFy/G6JRj4E+JagJkGq3IYhf0bI8sLUmjK63hIBffLaBV3zMlf/20bJSJDdxGn2M1VQWqg==
X-Received: by 2002:a17:907:86ab:b0:b48:730:dbaf with SMTP id a640c23a62f3a-b6473245792mr845375966b.25.1760810228220;
        Sat, 18 Oct 2025 10:57:08 -0700 (PDT)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65ebc48eedsm287758366b.79.2025.10.18.10.57.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Oct 2025 10:57:06 -0700 (PDT)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-63c2d72581fso2634988a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 10:57:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXdqP7WvM5ubeQIU4Br1+K1QYhBJvVC2zQeEDoKH34AIQapU566YbAc5CY+kNl3qtx55nLmU984hWe0CJs=@vger.kernel.org
X-Received: by 2002:a05:6402:524c:b0:639:1ee3:4e83 with SMTP id
 4fb4d7f45d1cf-63c1f64f094mr7116093a12.8.1760810225989; Sat, 18 Oct 2025
 10:57:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251017141536.577466-1-kirill@shutemov.name>
In-Reply-To: <20251017141536.577466-1-kirill@shutemov.name>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 18 Oct 2025 07:56:48 -1000
X-Gmail-Original-Message-ID: <CAHk-=wgijo0ThKoYZeypuZb2YHCL_3vdyzjALnONdQoubRmN3A@mail.gmail.com>
X-Gm-Features: AS18NWBhMhgs4_s15aKV87bAatc3jK6By6Ho8BjAuIc9dhonJUNbnDV1fLJr0qc
Message-ID: <CAHk-=wgijo0ThKoYZeypuZb2YHCL_3vdyzjALnONdQoubRmN3A@mail.gmail.com>
Subject: Re: [PATCH] mm/filemap: Implement fast short reads
To: Kiryl Shutsemau <kirill@shutemov.name>
Cc: Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, 
	Matthew Wilcox <willy@infradead.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Kiryl Shutsemau <kas@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 17 Oct 2025 at 04:15, Kiryl Shutsemau <kirill@shutemov.name> wrote:
>
> To address this issue, introduce i_pages_delete_seqcnt, which increments
> each time a folio is deleted from the page cache and implement a modified
> page cache lookup protocol for short reads:

So this patch looks good to me, but to avoid the stack size warnings,
let's just make FAST_READ_BUF_SIZE be 768 bytes or something like
that, not the full 1k.

It really shouldn't make much of a difference, and we do have that
stack size limit check for a reason.

And obviously

> --- a/fs/inode.c
> +++ b/fs/inode.c
> +       seqcount_spinlock_init(&mapping->i_pages_delete_seqcnt,
> +                              &mapping->i_pages->xa_lock);

will need to use '&mapping->i_pages.xa_lock', since mapping->i_pages
is the embedded xarray, not a pointer to it.

But I do think the patch looks quite good.

               Linus

