Return-Path: <linux-kernel+bounces-745445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0261CB11A1A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 10:39:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AD993A6A9C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 08:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13D2E2BF3DB;
	Fri, 25 Jul 2025 08:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OJk7TxpC"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E80E9283C92
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 08:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753432778; cv=none; b=uMtPTz/cplQth+fNMxWdmlnk00TcVZjIT4rnSZrfPZE0fVwTGdhyYBd3B6sQ+frmSizXm8LazlIxAuuIO6q1gaS+gcYDdqpI/dFpGnMnWB7I58vC/q899eEL2wqgkbTyXuSbk7PLa0ls7U3+Lxp3Bb+Wr3FBrOhG0lW2E1OcvOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753432778; c=relaxed/simple;
	bh=tBY0iimkxVoIBYuB3s33dxWd0cIaOYVPs9j9EliKe5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KSTKZ85cFe71Ks9GU8XdqpBL/eIP6eWA2CiHpHMIkS7bseui3Eeggu+qOff3q+ydgTRehB/5E80FWlJ2v34agU5hyr+/R06+xhmJS1sAzrd6dyA1oyy09TNl4AQH2/6dxrJnGSGIGYOcYU+aCz9Ab5GXH2irlW/K1WAWgtPZRwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OJk7TxpC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753432776;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jtiFyoZfZGgkbcgP/8jfuIG2d1G6bK99JX46EtJwAvg=;
	b=OJk7TxpCCUlbCY48VcHsK5lpIvHaQPV+qWbqMvIqAoLgNxIzmA5VZ2XVfvSr0oKeNZuXTV
	dpSosKD+egjgwNxupWe+sKnWUDIHwB+IQ5lKLPEj9ZjwPNPTmep2n5WMBQ49J5ApIo4vjR
	FsbFNItAua3b7ZA7HGfHnDuYSJOS+/M=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-505-y6haglj3N82huet7VBNVew-1; Fri, 25 Jul 2025 04:39:34 -0400
X-MC-Unique: y6haglj3N82huet7VBNVew-1
X-Mimecast-MFC-AGG-ID: y6haglj3N82huet7VBNVew_1753432774
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-704817522b9so28386566d6.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 01:39:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753432773; x=1754037573;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jtiFyoZfZGgkbcgP/8jfuIG2d1G6bK99JX46EtJwAvg=;
        b=ACjhYrcReuf1h4GQvYVGQso8ACRK1etRU/BtlLnK+M6wLhVX1XFmzz57CoTk+YPBhB
         AIx7VQ6qE8j1MTgs9MetJt4GeCJuOxKsvfF5HkFHLvhqMfV3eWcHeV6pNCn5r7X/g+YW
         5LmWFsZZbauFaz0aTHi3UxLqnZpWwXDL1wYw+QCxsmf6DT8cOrKQnyfva0IcMCTWLrSZ
         a3vdKJoCr4Rse2UzDuEOgVyQj5yMYDyvIkvdM1Pl5GTjscgZKfeMeR7Iu+QgL3G5j+3k
         DSeGKrhy5QNXrQdAiiMbeRULkbdmGtCl5JyVxHxmYZQsfwgTFR+eev0M12MJKRWBwswg
         HfsA==
X-Forwarded-Encrypted: i=1; AJvYcCUZK4JEO+FqrHCVq0DXuGoLeo7EEwC725fSAzyeZAgnBeAOzBLcX88QxejmOfZPYuVkcZFCA59uT6/aUEU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCJlRY1R7LQm6/Rug8D1q2I5vDWtK4Jk8mtOC3gtQO3JN3P02w
	gaUnnAwdApBVQhftycIdGzAz/0IrgH2bXrbh9qi0xWCNuA0HuTMdFMD5eVEA27Vmn2d4pb266EO
	2gRPvs6fOe+geW+Y7AKwRROlVK3AMggMw40Sp8bhCKFh7w7lfjB22bRgnB5MJhBHQVw==
X-Gm-Gg: ASbGncsrsjYuQ8NGJt45k0HkmolK0pgl8LTXahe1UBIF7mDjfmSGeyuld4CDECVIYtT
	hdqVNqj3aJ2/YWccz9dgmt2yrO/KJ7Xmln5DYgiIm9HBvLkl5sDpdY5ebMzP2+3KBhyi9QqWrBX
	WVGwF+0vJdSa3lIcmrXFAT3vJtFly2TmS/zSB7CC3+a5npHrAS2R/PO8lzwMCJLPeGEO9Ld5A2Y
	fcMMSxTwnlDanSKukUi2sKPGhx2yXKubb+H1n0NtxOXa2XzwI0mT/XcdotoK/WcS18GI4jIAj+s
	fTlqWZmcyc0POKHqB9PQ+/PfY9ZcDttQXU6VYefOKTRjiuBRRE83elXkeKwaDV5VhA7ASeNNwyT
	3yjJLcyq8iHWkVCQ=
X-Received: by 2002:a05:6214:242c:b0:6fa:bb26:1459 with SMTP id 6a1803df08f44-707204dceacmr12797306d6.7.1753432773683;
        Fri, 25 Jul 2025 01:39:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEuvrU/iDku3ReNmbC6er8A+AX9lbZ9M1ZVZ63Zo4Y0gnCBIubTMZ5l4qHxguWAFRNt5SjA+A==
X-Received: by 2002:a05:6214:242c:b0:6fa:bb26:1459 with SMTP id 6a1803df08f44-707204dceacmr12797146d6.7.1753432773224;
        Fri, 25 Jul 2025 01:39:33 -0700 (PDT)
Received: from sgarzare-redhat (host-79-45-205-118.retail.telecomitalia.it. [79.45.205.118])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7070fca2189sm24242566d6.62.2025.07.25.01.39.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 01:39:32 -0700 (PDT)
Date: Fri, 25 Jul 2025 10:39:25 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Wang Liang <wangliang74@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, yuehaibing@huawei.com, 
	zhangchangzhong@huawei.com, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] vsock: remove unnecessary null check in
 vsock_getname()
Message-ID: <dqlpaa6nczbjmf5agbjktmlzu2avgnqjmsuisp2ic2hsvgxh7a@ruhby5c6lcbn>
References: <20250725013808.337924-1-wangliang74@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250725013808.337924-1-wangliang74@huawei.com>

On Fri, Jul 25, 2025 at 09:38:08AM +0800, Wang Liang wrote:
>The local variable 'vm_addr' is always not NULL, no need to check it.
>
>Signed-off-by: Wang Liang <wangliang74@huawei.com>
>---
> net/vmw_vsock/af_vsock.c | 5 -----
> 1 file changed, 5 deletions(-)

Thanks for the cleanup! We've had it since the beginning, maybe some 
changes were made during initial development...

LGTM!

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index 1053662725f8..fae512594849 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -1028,11 +1028,6 @@ static int vsock_getname(struct socket *sock,
> 		vm_addr = &vsk->local_addr;
> 	}
>
>-	if (!vm_addr) {
>-		err = -EINVAL;
>-		goto out;
>-	}
>-
> 	/* sys_getsockname() and sys_getpeername() pass us a
> 	 * MAX_SOCK_ADDR-sized buffer and don't set addr_len.  Unfortunately
> 	 * that macro is defined in socket.c instead of .h, so we hardcode its
>-- 
>2.34.1
>
>


