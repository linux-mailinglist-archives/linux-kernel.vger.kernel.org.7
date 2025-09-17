Return-Path: <linux-kernel+bounces-821786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 189D7B823D3
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 01:08:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD4E71C215F4
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 23:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93B0930F95A;
	Wed, 17 Sep 2025 23:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a3GfjjVD"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 349882F3C36
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 23:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758150526; cv=none; b=iUmtOtfYLfP2x0qBsxG+H0546CTx5iI50SCXUn0uhjJmZjMb1ZX5cxJnm4jrUTX3cFvHTlh9/tiEmqupU2b/+C9mQjI/dizuAe8fUdmBFMDy7gryS8ldjOIjKcySOjoTc03uFkJao90ZoWL+R3/UnGe11BUDjflXLM5igV8TtEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758150526; c=relaxed/simple;
	bh=fiHidarY3es8NBA+LEW3pv6bjjvuMZYa+mJzlo0B1L4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lAWTN5hOQD/tV5w4ZJyB9H0Nkq5oX8wlT0vhKdWy1UrivBmd7cd90fM/45aqWsDDkwmd827zjvBcdWnplObnjlUI1COICxdb1g+CMLYtGmNgqJyR44Zx6MMLYaGacnf/0R5XPwmCJplX66vQRJwfnh4go6/efzmkcx+gXDM0A5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a3GfjjVD; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b0473327e70so55966866b.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 16:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758150522; x=1758755322; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hRGj/ILyJWi2Bsgex4Gvbo4N7e1wLDw4WJvnSHlYoZY=;
        b=a3GfjjVDOZloiF3VHg1fDTK/uGAjwoqZxrDmljLKWUYqeFDkG4puWSop+iNpdtY33S
         NdJ/cP+klOKHxsi6s4nCGtkbcYEDAr91Zn8tCT7GSnFwGfC6ggfa2Q5GgWRsLQpgHBpM
         EpHymmtQJ0Lf27fTlyD1EBlsqIOChVPhkRy9Lf+4/l3T5KNkiTqz6hMJeKiwi5b3DZrB
         AYGyHTdN5Je9sN4jCvevyClImXvu8bsCKeLyPITDphDybU3LBlBAkM1rHHfFUagqm+EG
         iIJWJWDWxzZn54aHP90ddn90W5Mz38hCIIC1IFhAfEdK5vwq35TO1TBkGVofSdTYJNs0
         2l7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758150522; x=1758755322;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hRGj/ILyJWi2Bsgex4Gvbo4N7e1wLDw4WJvnSHlYoZY=;
        b=b/CQZ0pIMMoy28D7kiDIcUgGwVdbPCqzH84aR4Gxo7YAl8tJzq14/dcHPWwOGWrheP
         DmF9b4gISmxsnJmr5xcWXzcMATBw8pSLVtWQ9G/+ozfuRwU7pW2AIEi7HYQNqFsX3B3o
         q8T2nNq5PdvGj6zcogulIULRolbyeVxmd5CKnx7cndCAId2Uap9uv0ArgWVjpS8pEaV2
         83cuiL19mT3AaTw6okvWE2S/iw6sGSSbVvj1s0nIHqDDW6rZfKiO4orKzrZFpntlH3h1
         JU0GNzE1j5pB/Dee95RvbpZV2XA0eJHn9Dk+lX05GGT6IZxrbrx2imyoi8ddjMiaKQ1X
         YXiw==
X-Forwarded-Encrypted: i=1; AJvYcCWeqSBh/rdfr1Ber4/xwUP8ZTdO9+uPlBFXoPtAmO+ExYdgtQObYcAi/PvbJwXecz/il+l5V2RkziCl3HQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyjaw5ksYZ51Gipl719d/M55SESmWCDc4fnT9hmXqQUuZB1ianL
	0cNgyk8jmFB5qrNvEZ6ul/l9tzyn9Xg0eUBprVHCMs/Pj3U67FCNEA1S1j8DgFPD3iA2jiJvA0a
	AnE/19/5i/FYRgJRkTHxAcon1zX8dCGw=
X-Gm-Gg: ASbGncuSLgIdKYwx23GsGKXf1sMGHwXggnhM5oBhHkx6pLLPOY0keDDKfwbBNq1j7jX
	IztJE6durSAYJCaHY9dGLuHU7qL9n5P+tOgoA8i/TTFB67kuJXcPY13XU++ulGvRxjBUEGwXxkw
	8iJQ5ft8rlOXt34+kpEcAE9Hz+Gi4sqv6cBxeuVzsNbHSDskUCp9Xe/KstxDol6nprKUcE1uKsC
	xQOV1X2xiGJQmV+OgiMJjrEinWGYG5N7kNPrWBVRb/6SUaRb0I5rVzG4g==
X-Google-Smtp-Source: AGHT+IFTShsh8t7nrREG3sNteTvvDWCztpJ0irdoYHone0kblikor9dVjpl7/+XtSzyEetSqaaCdKn/NmlZEPTV0vhE=
X-Received: by 2002:a17:907:6093:b0:afd:d994:7d1a with SMTP id
 a640c23a62f3a-b1bbc545b99mr380535666b.63.1758150522536; Wed, 17 Sep 2025
 16:08:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250917124404.2207918-1-max.kellermann@ionos.com> <aMs7WYubsgGrcSXB@dread.disaster.area>
In-Reply-To: <aMs7WYubsgGrcSXB@dread.disaster.area>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Thu, 18 Sep 2025 01:08:29 +0200
X-Gm-Features: AS18NWAPWaGTXxRYRzp3XafBT13uBoehIcp4zLeoIa2AaJjHnaVuMpyaFs-UzhE
Message-ID: <CAGudoHHb38eeqPdwjBpkweEwsa6_DTvdrXr2jYmcJ7h2EpMyQg@mail.gmail.com>
Subject: Re: [PATCH] ceph: fix deadlock bugs by making iput() calls asynchronous
To: Dave Chinner <david@fromorbit.com>
Cc: Max Kellermann <max.kellermann@ionos.com>, slava.dubeyko@ibm.com, xiubli@redhat.com, 
	idryomov@gmail.com, amarkuze@redhat.com, ceph-devel@vger.kernel.org, 
	netfs@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 18, 2025 at 12:51=E2=80=AFAM Dave Chinner <david@fromorbit.com>=
 wrote:
> - wait for Josef to finish his inode refcount rework patchset that
>   gets rid of this whole "writeback doesn't hold an inode reference"
>   problem that is the root cause of this the deadlock.
>
> All that adding a whacky async iput work around does right now is
> make it harder for Josef to land the patchset that makes this
> problem go away entirely....
>

Per Max this is a problem present on older kernels as well, something
of this sort is needed to cover it regardless of what happens in
mainline.

As for mainline, I don't believe Josef's patchset addresses the problem.

The newly added refcount now taken by writeback et al only gates the
inode getting freed, it does not gate almost any of iput/evict
processing. As in with the patchset writeback does not hold a real
reference.

So ceph can still iput from writeback and find itself waiting in
inode_wait_for_writeback, unless the filesystem can be converted to
use the weaker refcounts and iobj_put instead (but that's not
something I would be betting on).

