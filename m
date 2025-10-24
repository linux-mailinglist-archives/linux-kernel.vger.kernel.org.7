Return-Path: <linux-kernel+bounces-869589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FA02C083FC
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 00:35:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B90AD35279B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 22:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45A3D303CB7;
	Fri, 24 Oct 2025 22:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QM7oMOxx"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A2492FF152
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 22:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761345292; cv=none; b=LrxIVetxIKJfmCal7vauYXRP3aNJ2ev3QV4DmSqCaZW5/d12nTBKBG3e/0fikOySGNJbxhvagtycvieDLSj8Guo3tX4eoaGl1hg3pJGAAKnUeGAp0IY1d30NuwIFbln+dMxJTOpqIOfirtG1KLKft1b8tqz1yQu+pLRcYDCL/Y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761345292; c=relaxed/simple;
	bh=/1lCqzDVfSqKcHOVvqPIUIhFwtXQWPe83gIVdwmBx9A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uDWGkZCloUswJcQjBW/3ICBziZpLfMBGHppATnsBJ5QSyXWpj+x+y1P7HNGgN2x9shhAnElt1dJGqOwRQPxqZcgZbZlbAjh6WS8bQwbuqdBMiaEdegtFisW54GZxSoDM52kZWoNusx2oXSOLOrppncuSngzDX0fDNyGPQ0X9eOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QM7oMOxx; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3ee64bc6b85so2581216f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 15:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761345289; x=1761950089; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dgWMmy8jJ+GexnEc4sqtdfOGQCxpNGU9Ux5BrjtS6oA=;
        b=QM7oMOxx7+3JP6Nos+OzBy89rmsvVBDDAlUa0JFbnArfTFZL2DDCv1KUIX4vX0Pimi
         vzBdvKazoTSpfZammXUIh8SXdc4IbR2Zl8iUUVBBhphmIxQS/7IBQSeH6TFvbW8rmbfP
         5BoKYpS/FSMSNPUnY03GlDqxKIVwogaN1VgozobpWrZ+f84NkrSmyngCH6R5nA0Iybjt
         I8iYGj0mBAUftxTJvNg64s4gQ1X0FENWzt7SkwFvC+OTAqE6YHMz6zxYA6pcPd2cWM6d
         h5fLopTIvEOGsV89M6Bx6D1HnGd6LncOMSZFXmz7ivyBXW5we6XydkH5MHHq4q4nqpFV
         omSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761345289; x=1761950089;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dgWMmy8jJ+GexnEc4sqtdfOGQCxpNGU9Ux5BrjtS6oA=;
        b=wpA9jx6iBW+ktF6aH5Vnzl+zpz73o4Ona/7vYYjJFOLbfnlw4nW6CTieJ0CkEHM+AO
         b6pwzqzRY+P5qpq785XhBW+F1L3Gw1Z5VACMeBcAQk9FanESf1dS3geocEWv1Er7p4ul
         VlD5/NWr9Izt19n2bZLKxuU5QpQawp04pGA+awaQV0Rk+SngJ9YqiSz7CcpRlphAQy1X
         91W8qov3w0vQPEYh+FZCcwlf//fBuSkeVCRnbZ0jZOaYbqGVICNPbC3b95GHWg+YLrbH
         bSEbJ9W8eojoPfJAwAPBzI55wjs9LtAXI/LmtSGge5S5Uqcv0w4flUjSXQLzJZsOSUse
         xm6Q==
X-Forwarded-Encrypted: i=1; AJvYcCVqOVs0QS9GdWJZLRm3jV3sJhCs3bibpE3hl1m9s8XXSwWhFsZssCbDIVDKedFFFUGe/5IYFdct3bHXkX0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxv12YhvR4aN8NoMDp0Mkcde7iOAb/i8CYNB7ymqp5UweWCnp51
	XapMBw5HPfDH17OwNcBh8OuWlMWzOIG+gtkKC8SdPAZ3fDEeI3iT61JUizRuJHDRDM9ZiSzSK/z
	HNmqfb5f2130AD0mzSGcPYqMry+iiVgk=
X-Gm-Gg: ASbGncvNs0cXPZ9P//AGzxMAep2jAgQp63xs3BLHLynU+yIdpvCVCgjufvuAVgDg+j9
	NhsDsdbPj7sfSMwIckkudNMp6+IvHqTbfeVUon0oaNLjROwb0rFLHU1qIhX8zcVkxlg5PgovM+Y
	WWSQNr4v1OgpILe98PLm0ELLi4WVV/0mG8aO11vBvApBVhriFSfCsiVviSoS7GZ77YDCa5/olz/
	N79DdA5WMTxjGlQXVu67IYnzjtTidTyBxPtdp8rsOLY3CUI5tNhuYFRcOz/SXka9/HwylDaaO43
	MeWOyyGAy3o6L960AnZkqtmV4t71
X-Google-Smtp-Source: AGHT+IGVBqTo1Qga775DM3PeXJFOBVyycwfIPdw/nCiZHEmybAiqSl5amP9rqdkQHIC0hvV9j/gd2HZiroKhtTMd1Iw=
X-Received: by 2002:a05:6000:40c7:b0:427:847:9d59 with SMTP id
 ffacd0b85a97d-42708479e00mr22413715f8f.45.1761345289151; Fri, 24 Oct 2025
 15:34:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251023-sheaves-for-all-v1-0-6ffa2c9941c0@suse.cz> <20251023-sheaves-for-all-v1-3-6ffa2c9941c0@suse.cz>
In-Reply-To: <20251023-sheaves-for-all-v1-3-6ffa2c9941c0@suse.cz>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 24 Oct 2025 15:34:37 -0700
X-Gm-Features: AWmQ_bm73zAZG0hwU9rfMl02lZ4uq3I2SSq2VpZGEnfSrxZZCZEFxDP-C90Ympo
Message-ID: <CAADnVQKYkMVmjMrRhsg29fgYKQU8=bDJW3ghTHLbmFHJPmdNxA@mail.gmail.com>
Subject: Re: [PATCH RFC 03/19] slub: remove CONFIG_SLUB_TINY specific code paths
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>, Christoph Lameter <cl@gentwo.org>, 
	David Rientjes <rientjes@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Harry Yoo <harry.yoo@oracle.com>, Uladzislau Rezki <urezki@gmail.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Suren Baghdasaryan <surenb@google.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Alexei Starovoitov <ast@kernel.org>, linux-mm <linux-mm@kvack.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-rt-devel@lists.linux.dev, 
	bpf <bpf@vger.kernel.org>, kasan-dev <kasan-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 23, 2025 at 6:53=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> CONFIG_SLUB_TINY minimizes the SLUB's memory overhead in multiple ways,
> mainly by avoiding percpu caching of slabs and objects. It also reduces
> code size by replacing some code paths with simplified ones through
> ifdefs, but the benefits of that are smaller and would complicate the
> upcoming changes.
>
> Thus remove these code paths and associated ifdefs and simplify the code
> base.
>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  mm/slab.h |   2 --
>  mm/slub.c | 107 +++-----------------------------------------------------=
------
>  2 files changed, 4 insertions(+), 105 deletions(-)

Looks like it is removing most of it.
Just remove the whole thing. Do people care about keeping SLUB_TINY?

