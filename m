Return-Path: <linux-kernel+bounces-823257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E32E4B85EE7
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 18:15:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E12F962582C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 16:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D46E314D0D;
	Thu, 18 Sep 2025 16:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OodPA/KM"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE13307493
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 16:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758212072; cv=none; b=LgcQLYavAiWNl1jVNKsRSUKrXkL7rigHfKOvJpgEGJ7Ld0oP8hZG/iwVqduepnD4MaGBwqq9vpWEFYI7oxdYF8NI/pURb4dizKxTMkixFw54zT9PMWOPKSXKfVAMtAvyPOxOAAnpTBAWvvJExLak43ST5E4SRmj+3gm0wXKHeWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758212072; c=relaxed/simple;
	bh=bmboGWdmYKGEjDqvYv1DVm9bs5qgX4S3Ny/0S2so/l4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l/eUZG5VUUUA1V/TsPdSO9T9iKWaAjxihdo4P1a5fRdAjxID7IvpkIT29allo6tTf4MGClAyj4PZC0NahXVh3Nk4x/WQeo3V9OvZqate8K64gAljany6J9Q4Pp7YlfXj6TES9adQYXhIckajp9g8MbgO8L8E76b9b8mkViVhWcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OodPA/KM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758212070;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4F3hybZYhx1Ydbv1SoblmjPS3ZmGcfGwW98Zsh1rblI=;
	b=OodPA/KM+3UEtyYO/CgmKbeJC+ap4qU7FHLiruvwpJr0qNtPwwzUwSxSsZohswbbYx2O4S
	+FhpXaPrOt9CJT/JfGQ+nX5dUJObpHawn06VIwVWQIQmNzEVyqtnlS0IH1iSAwOwzd80ba
	Vu2SsqMD4uWKwkC+kK6kUGud7xrcoFk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-25-O1BxDEriP6K2kf8COmwcKA-1; Thu, 18 Sep 2025 12:14:28 -0400
X-MC-Unique: O1BxDEriP6K2kf8COmwcKA-1
X-Mimecast-MFC-AGG-ID: O1BxDEriP6K2kf8COmwcKA_1758212067
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3ecdb10a612so696241f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 09:14:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758212067; x=1758816867;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4F3hybZYhx1Ydbv1SoblmjPS3ZmGcfGwW98Zsh1rblI=;
        b=IQVJPS19fDpcGE2Rqe3NkGJ7a/gjoQMi/Hl+IYvIBDUKzuyLfXzHeb/1opTyhLTNS4
         0ltjuTkywRKj3f1H62J+Z/QydHavRYEtszsIoGzx+yigzTax3ekX8UpUIf/w6Zrhtj4X
         tBKXx8lGTdwSoRq4W/hDNBxZMJXtea3R7Mrf1A1O0FBLhZVUIADCq3Qzfwf72YEnLM30
         yFXsQteRwLKI2Qjwmj7kOpTUtizjdmNjYOUAe/BTE9zYwcGpV62wLwTimE6KHLUCpSc9
         m8N3s4ukMDOR696jys+JHIyALbq3DTimAKMS7c5mk75Dn1pDfAlvRuSt1fsoR1wCA5QN
         0O8w==
X-Forwarded-Encrypted: i=1; AJvYcCVRhzMbaqhyiypSVkvaI0BvTq1T+wI/LG4HCopa/JMf1S3IWzhUjbwLoEpYG6K1JJOKnBaKAHleUbFzyEA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0G0jtinRit7jZaMHt38NQPiAl4pzqMenUVmBko1XaGDrXQirE
	IyFl/U6cq6Wxdhyex0fgcaVbr43dUuZ92SgTBK2EECgJFS+ig1H4ov+WvLF8j9nwTWpKNiSn+PQ
	288H1q21Z+5qxvMxZ0jq8WwHn3PS89l1mBgtS0auP+PKDdoKiol5e+kEDKwSMFWstug==
X-Gm-Gg: ASbGncvEj18QXx/ikWIMxy3i26pXzKL17cGy28kiM/u/xnjDHP9UqIjCrDxTXxxxTBU
	kXRlLB6Lv1F//rJTVPyqyB0WPTBu9yCCXOcpTu4RQLL7UpQJ7XnwkpV2pj5qizhiGtvPd0Wc7Om
	EBiT7qlrvW9ZOOyiHWMZDlgrM5hhkG5ND77C54OA1q16Q+DpEj6krLezSXM4tURPt9sidn5ANDV
	fUlfh8t/VKnUjI1/bXn0/DsZcNJ97JZDafvtnk/zh3u742mlqE1myiJKT069eptAu4b5OI1ij2T
	dN+s6ConYPQaL8k4/ImJ2DUgGAVT9nSb2cY=
X-Received: by 2002:a05:6000:2283:b0:3eb:df84:62e with SMTP id ffacd0b85a97d-3ecdf9b4972mr6994282f8f.3.1758212066826;
        Thu, 18 Sep 2025 09:14:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHWuV5SNvbO5Tb9W3Xvg5a4aZyLEyh56k2xiIjkOqz9AqDLzlVKqyG0LIYCFPiIYi4OwFCHPQ==
X-Received: by 2002:a05:6000:2283:b0:3eb:df84:62e with SMTP id ffacd0b85a97d-3ecdf9b4972mr6994243f8f.3.1758212066373;
        Thu, 18 Sep 2025 09:14:26 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73e7:4d00:2294:2331:c6cf:2fde])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee0fbc7188sm4388197f8f.37.2025.09.18.09.14.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 09:14:25 -0700 (PDT)
Date: Thu, 18 Sep 2025 12:14:23 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	alok.a.tiwari@oracle.com, ashwini@wisig.com, filip.hejsek@gmail.com,
	hi@alyssa.is, maxbr@linux.ibm.com, zhangjiao2@cmss.chinamobile.com
Subject: Re: [GIT PULL v2] virtio,vhost: last minute fixes
Message-ID: <20250918121248-mutt-send-email-mst@kernel.org>
References: <20250918110946-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250918110946-mutt-send-email-mst@kernel.org>

OK and now Filip asked me to drop this too.
I am really batting 100x.
Linus pls ignore all this.
Very sorry.

I judge rest of patches here aren't important enough for a pull,
I will want for more patches to land and get tested.
Thanks!

On Thu, Sep 18, 2025 at 11:09:49AM -0400, Michael S. Tsirkin wrote:
> changes from v1:
> drop Sean's patches as an issue was found there.
> 
> The following changes since commit 76eeb9b8de9880ca38696b2fb56ac45ac0a25c6c:
> 
>   Linux 6.17-rc5 (2025-09-07 14:22:57 -0700)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus
> 
> for you to fetch changes up to 1cedefff4a75baba48b9e4cfba8a6832005f89fe:
> 
>   virtio_config: clarify output parameters (2025-09-18 11:05:32 -0400)
> 
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
> zhang jiao (1):
>       vhost: vringh: Modify the return value check
> 
>  drivers/char/virtio_console.c |  2 +-
>  drivers/vhost/scsi.c          |  2 +-
>  drivers/vhost/vringh.c        |  7 ++++---
>  include/linux/virtio_config.h | 11 ++++++-----
>  include/uapi/linux/vduse.h    |  2 +-
>  5 files changed, 13 insertions(+), 11 deletions(-)


