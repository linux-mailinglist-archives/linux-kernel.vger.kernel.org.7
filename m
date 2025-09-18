Return-Path: <linux-kernel+bounces-823071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7874AB856F2
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 17:05:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6AF82A4612
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 15:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCCC01CDFD5;
	Thu, 18 Sep 2025 15:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JOLUq1p4"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720A626AF3
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 15:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758207808; cv=none; b=tp9qQWm255DEXWlmblJsuNvdfgGnLcJJwmimjqs+rlOGg0AnzaWgJND47gfbWl1gLWPpXzV+6FGXjn7EH1bqwE+tY8MJOvHUdW+/F6w1NYu0zBaetDdP4fL98S1l52MuydhJXV6YJNJo81WA8nxigRfyrfK5Wluv05XDLpYNeN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758207808; c=relaxed/simple;
	bh=EkExrjB1v+E3308pb6pdcKo1s1yc3WIbaOoY/+f5qXI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i45n5dj3q3aKFqh0XhOJ3LdeGIM5XWBWlzGSZ9t+dDTjiLT/7fK3ElvgL1kmpk7wTup4/yhlkC9zkgSinUhWb/8LXnPyMJgUbCrdX0XN3uZidO00ViZS7svxE/3S7cLr+C+jqqiPMZkbSsRUKOr74U2dvY91km5ebsXje5YVYyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JOLUq1p4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758207805;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jHuroaDALPzA9ek/TZGAIvvuwoq2PBaqEYZO83mgbI0=;
	b=JOLUq1p4cHteaOzoUSEwPNJgt7wYW0Hzsow15lDRy1YX1AUuyHUKhhSihc97VpKNnr9vuV
	2eL6Wio4dtO4Cu8lhVQUfqYnA531USOui3UdN9RXEDYnUMLRkApd/Dk2ocoa3aho0UTH1f
	vPblG5MiS0fyxAFGwT3PF6AoC2G5skw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-626-OAoywvbGMm6d7Z-V209WRw-1; Thu, 18 Sep 2025 11:03:23 -0400
X-MC-Unique: OAoywvbGMm6d7Z-V209WRw-1
X-Mimecast-MFC-AGG-ID: OAoywvbGMm6d7Z-V209WRw_1758207803
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-45f2f1a650dso7624395e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 08:03:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758207802; x=1758812602;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jHuroaDALPzA9ek/TZGAIvvuwoq2PBaqEYZO83mgbI0=;
        b=A865EjmWmTJnw1pcYV9lU9BlJ3Y+qYn1ZzuxjsVq5W3wZzTGGXNKvsgJoIw2Vg+BeD
         BIp4n+vRw/rVRPeGRRGisxSA6UhCeQIeLIok7fCpFu1qAoSt1hwHwc4L+z8M67Ryd3gk
         lSanZt2Ug8QXPbQnwWNkxHjEeCqOuXO6JUy9W94OMYi82JiH07y61rMtHlFLWPZ4c+Ct
         VIwxPKt6QeDVzftsSlo7RpWczOGJAmWnQj0GcGQHB6TAMTo2xjI8Ldq+nKPUuFO7RM01
         tFkzcWgVjRacPPQmQUKVZcJ9cRQKlMBZuPZcRf3Lboz9rUdMQaw2VkCe1jyO8UvpVbdi
         vpGA==
X-Forwarded-Encrypted: i=1; AJvYcCWdthHax+EgIChmNVNcroF1FFe9wYWD18TR0ueIvZuJNuYqWNPfTwz+jbeQyZWPMjdXnFz+tFH/VKBD9F0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxz7PEWIPo2263pXxXJWlsIjrxo8kBOkwIKVaLOk0xfpvgHt0wU
	VETg9AFriOJfttQc7VAEFpPGQuqZA23IBSK8aQ8o41gSu2WAEG2pcmqqzvOPtsSf02sA5uDdrcc
	avw3W7K/W6kTPZYpLzyBcexhGPiPby8XCzulUL9e4dT3heIlM6+iQ4s2hoBqXPROAbPgsXlmSyg
	==
X-Gm-Gg: ASbGncv/Jv9mewuBD4QFD7ERnFTwDRqGOQ9QrXLIQSyet9APT5CE8oNoxcgmdDfz5rI
	UZWYEZ9AMT62sCuR/iIdu2TwdA0mhZ5neP0WCt79KXJT0cC885udquuukIh6/prxcej/kPiEzBC
	SOasG8ZXaLnzLbx5I4rlNMhRjv4UoJ+mnVOxPdk0t1IatkCSsSv4U1wCTqzKWDOIabVqwAlN+9Z
	vIPQ7WuSyX93Y2RgFO9pWvQyxvq2zz6h0a0XFirfWQyVPJLvYeFrqWsFGZKaK80U224lncOxS25
	YSQV0KYD/W1C+0Bi+5N89gB7tOWGEQ4Rbko=
X-Received: by 2002:a05:600c:3111:b0:45d:d287:d339 with SMTP id 5b1f17b1804b1-4620683f1e4mr63892265e9.25.1758207802083;
        Thu, 18 Sep 2025 08:03:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHzXMO/8xWkfvQqlitTmfPRvJ7wLVF0bHaOOs2wJAFpxqVjxaTdhQB7sp9EBt86tb48mNkwbQ==
X-Received: by 2002:a05:600c:3111:b0:45d:d287:d339 with SMTP id 5b1f17b1804b1-4620683f1e4mr63891665e9.25.1758207801215;
        Thu, 18 Sep 2025 08:03:21 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73e7:4d00:2294:2331:c6cf:2fde])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-464f6695a9dsm45758515e9.24.2025.09.18.08.03.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 08:03:20 -0700 (PDT)
Date: Thu, 18 Sep 2025 11:03:17 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	alok.a.tiwari@oracle.com, ashwini@wisig.com, filip.hejsek@gmail.com,
	hi@alyssa.is, leiyang@redhat.com, maxbr@linux.ibm.com,
	seanjc@google.com, stable@vger.kernel.org,
	zhangjiao2@cmss.chinamobile.com
Subject: Re: [GIT PULL] virtio,vhost: last minute fixes
Message-ID: <20250918110237-mutt-send-email-mst@kernel.org>
References: <20250918104144-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250918104144-mutt-send-email-mst@kernel.org>

On Thu, Sep 18, 2025 at 10:41:44AM -0400, Michael S. Tsirkin wrote:
> The following changes since commit 76eeb9b8de9880ca38696b2fb56ac45ac0a25c6c:
> 
>   Linux 6.17-rc5 (2025-09-07 14:22:57 -0700)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus
> 
> for you to fetch changes up to 549db78d951726646ae9468e86c92cbd1fe73595:
> 
>   virtio_config: clarify output parameters (2025-09-16 05:37:03 -0400)


Sorry, pls ignore, Sean Christopherson requested I drop his patches.
Will send v2 without.

> ----------------------------------------------------------------
> virtio,vhost: last minute fixes
> 
> More small fixes. Most notably this reverts a virtio console
> change since we made it without considering compatibility
> sufficiently.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> 
> ----------------------------------------------------------------
> Alok Tiwari (1):
>       vhost-scsi: fix argument order in tport allocation error message
> 
> Alyssa Ross (1):
>       virtio_config: clarify output parameters
> 
> Ashwini Sahu (1):
>       uapi: vduse: fix typo in comment
> 
> Michael S. Tsirkin (1):
>       Revert "virtio_console: fix order of fields cols and rows"
> 
> Sean Christopherson (3):
>       vhost_task: Don't wake KVM x86's recovery thread if vhost task was killed
>       vhost_task: Allow caller to omit handle_sigkill() callback
>       KVM: x86/mmu: Don't register a sigkill callback for NX hugepage recovery tasks
> 
> zhang jiao (1):
>       vhost: vringh: Modify the return value check
> 
>  arch/x86/kvm/mmu/mmu.c           |  7 +-----
>  drivers/char/virtio_console.c    |  2 +-
>  drivers/vhost/scsi.c             |  2 +-
>  drivers/vhost/vhost.c            |  2 +-
>  drivers/vhost/vringh.c           |  7 +++---
>  include/linux/sched/vhost_task.h |  1 +
>  include/linux/virtio_config.h    | 11 ++++----
>  include/uapi/linux/vduse.h       |  2 +-
>  kernel/vhost_task.c              | 54 ++++++++++++++++++++++++++++++++++++----
>  9 files changed, 65 insertions(+), 23 deletions(-)


