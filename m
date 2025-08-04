Return-Path: <linux-kernel+bounces-754773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 648DDB19C55
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 09:19:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21E703A68C0
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 07:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78655215073;
	Mon,  4 Aug 2025 07:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JDigyBMl"
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E306161302
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 07:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754291978; cv=none; b=PY19jyE8fFLCUASb897ZrbSpPKvb2OWoyACee3AAdxgST+sZjGdXHvmEUdwNsPc6b6bT3Q+5ATNqrzluXW84taQmLD2Wc0j3n0yIWXXNmrBAXDLrDz/YVUkbeNvK009gpJRtyFKVJZ8+vc0dEQ3w8ysiGgg0v+X1xSzYaS31WFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754291978; c=relaxed/simple;
	bh=oE+jK0I7mLPY3+tSedssnvqNY96rnU3UqPwusHT+xSI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FfFlG2pEZRBE289niXCQGmr0PNCkqtYBb4lBRmRwVQ9iozjEvaO8I0k56Bn0lKKo+FndlxTFOUpPvXeCJPUWJIM6PSesMnfvX0gdcjm8Ya+PsYKad5XkAUOlw9LrBUuTD5L+FDzuVdplq0PxavkZNzRY18998oI1Q3Nud12wWyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JDigyBMl; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-539360cc274so1932944e0c.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 00:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754291974; x=1754896774; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oE+jK0I7mLPY3+tSedssnvqNY96rnU3UqPwusHT+xSI=;
        b=JDigyBMlYT53sKI597D9qNkZVj2baFgjbBomM4JnSGj7/QTrbYtpMum9khKy83PRvL
         pDPz9c7goqutHDWh5AhypE8BVePaIHnWLoR89zC1RgoKx7BpCtYy/evRYYHGzacWmrQd
         dxuSXgljletBtzIP0EDhuXM0Uwnp4/e2lCrncvugdPOLuyLFHWwYYVJDCprdcnAbI+S8
         9KbCFFOyPmZXikds6RVffKEaj8LXeJCMOKXnArj3vkzFNfrZUaMKU0HCZlBimqh0sv4P
         8opbMJ7gq2XVY+Mbq50i8fkVUTLZb6K7NEj0EUGfzOfEzibyPDLU92IqaaufZbdY93Kq
         jAdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754291974; x=1754896774;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oE+jK0I7mLPY3+tSedssnvqNY96rnU3UqPwusHT+xSI=;
        b=atQz6/XNCC/xlEYhye9GxT+jx2CbQro57C9uX0Qw7OYyfOzUlFtpFV/Zk6r+EOlgdn
         OQdhr0S6t+P8puw6f0AudcE/kefXl/UwK+YJ7HkyOMa21JHpIXmn2wYSbd0kgY2ViNLb
         UQq2TCRTym0c2n/1KW0BOWsQpCGwhk7uwHJ38hwWGXx/ToxsXb16UpDSMfH5rVUfTzzm
         2LPkWsQoXxsXUuUyD7t7wOoMUvwNrsV/Zflmt2Rv41GKlACgxVV1xGfTQ6/r+94UGvP1
         mE7pA2QuM8hYkJooOG7t+XKISwEAf7MVZtAk+gqNWcfTce79rfzXP3rNbSXYjQHwos8F
         6AzA==
X-Forwarded-Encrypted: i=1; AJvYcCXMT86NnZw/alAGirmkSlIc3TwUs8KxwufaUo6OeZ7Q3tZ8zJfJmfOhBOp0qiuv/eRrL4V/tcc8M5PWqpE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0DKjleJX1ESjAQyuZ4JHevNGMYzr87mZKT55F33BvJAbH3KQ6
	0fb6J5XbH0ongRHa2Rdo58WlEPzSa2Me2pngDjLBEKhzjWm/+YfvgMY8PiOGa0HskGQ0rU7sbvc
	gu8EKQxNl1WFdzEbutg8mmahTxnXD/Jc=
X-Gm-Gg: ASbGncu6/65rU8a66EhR3ySAbFYYjkrM9ow/5AMffVkQGgkN6G9ZnJsWAhyHt7CJG/W
	jrtT+gTu53s59kXer0AQEQANZviloDjzyuMvpvc5pu08MbKyhjGwsnCCOWcjg4qc4eRTrhclcd6
	TpitdT/TPth9cz9OF2h5fu9Ll/ks1LKzIXCcYWcnMlBwdXBxQSOVnJKxvK9cEd5dlibP3njD5Ij
	VWnkx4=
X-Google-Smtp-Source: AGHT+IHIHjI5MYWeINur/RAU4kGeuEnodFp+xm0rJ/4u5tVFs6YXOYCd4Z566t+gNbTxJkjSM5LG5rNhX20GXJDXPuA=
X-Received: by 2002:a05:6102:3747:b0:4e9:963f:2d09 with SMTP id
 ada2fe7eead31-4fdc213519dmr2975464137.10.1754291973644; Mon, 04 Aug 2025
 00:19:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250607220150.2980-1-21cnbao@gmail.com> <aJAFrYfyzGpbm+0m@ly-workstation>
In-Reply-To: <aJAFrYfyzGpbm+0m@ly-workstation>
From: Barry Song <21cnbao@gmail.com>
Date: Mon, 4 Aug 2025 15:19:22 +0800
X-Gm-Features: Ac12FXxLO6_fioid_qXwJgf4K-CWznI8zE5ixEHbnOLYS7IN7dCTl9scP3kp4MY
Message-ID: <CAGsJ_4zYrcooZWh0hRHqUoaiuu2eZMOuEAdGjmGArL9k925KZQ@mail.gmail.com>
Subject: Re: [PATCH v4] mm: use per_vma lock for MADV_DONTNEED
To: "Lai, Yi" <yi1.lai@linux.intel.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Barry Song <v-songbaohua@oppo.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	David Hildenbrand <david@redhat.com>, Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>, 
	Suren Baghdasaryan <surenb@google.com>, Lokesh Gidra <lokeshgidra@google.com>, 
	Tangquan Zheng <zhengtangquan@oppo.com>, Qi Zheng <zhengqi.arch@bytedance.com>, yi1.lai@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 4, 2025 at 8:58=E2=80=AFAM Lai, Yi <yi1.lai@linux.intel.com> wr=
ote:
>
> Hi Barry Song,
>
> Greetings!
>
> I used Syzkaller and found that there is general protection fault in __pt=
e_offset_map_lock in linux-next next-20250801.
>
> After bisection and the first bad commit is:
> "
> a6fde7add78d mm: use per_vma lock for MADV_DONTNEED
> "
>
> All detailed into can be found at:
> https://github.com/laifryiee/syzkaller_logs/tree/main/250803_193026___pte=
_offset_map_lock
> Syzkaller repro code:
> https://github.com/laifryiee/syzkaller_logs/tree/main/250803_193026___pte=
_offset_map_lock/repro.c

Hi Lai,

Thanks for your email. I gave "repro" an initial try with today's mm-unstab=
le
on arm64, but I wasn't able to reproduce the issue.

Please give me some time to test with your kernel and config, as well as
on x86_64 (though I'm not very familiar with x86).

Thanks
Barry

