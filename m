Return-Path: <linux-kernel+bounces-759084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76E8AB1D835
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 14:47:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C60D3BB58E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 12:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CADC92571AD;
	Thu,  7 Aug 2025 12:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F+nGFL1O"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D492566F5
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 12:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754570850; cv=none; b=mNTKXwIhTivwuDXzpH/wtTywFcV7jbH6h9RS3ocI9LZjXsWLs1nv0D+O/NbiHVhd3yUsUizUaH9aauy5jB3kr4vCr4wnXq/uXR1W5VnGW1jTNq+gEkZ5/tld2LKLMNySBpAdAK4PSRBAB5Nj+h7zfjlgPBn50UXzFe+BtOEiQSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754570850; c=relaxed/simple;
	bh=un3RrEaBjFQNWnpFNJaSEVX8CHxrowanZGwCtU3ENaQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=nUkQvdJRQOc1JKI/fhjCXpVl/nQw/RfC/IFRBUfQt/QB3L3cwBuJh3AhBDJYQSjrTZo3bb1x7WN/1SsPU+p5rNCIB4MuuG08sCzt8tTfP20r72VsOqlCDz9CRJbyMN2eCLrLnl9l3TNVwu7DLhjGLVt4NO6uInGZLKUJa22AL2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F+nGFL1O; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754570847;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=aTK69kQaFZtjtvMSMDYC7o+QFQbEWEankqiOa7dNWH4=;
	b=F+nGFL1O2otRqpfrcqPVxpXrKDNGDTW1qF14NO5224K5lJR0xcoka33xxsxRTIbaQEDwhJ
	rEF4CSKWe4kPUOgtFJVpj8wimaGX2Dwxq1mi0kHbL5GTZ6w66S0s8fcECwBB3oSXrS3URO
	rxWyZ7T3OMJEhZdlDPWUk6FKRnP7JXk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-aOMPnF-QPQOYGQcsZFSFbQ-1; Thu, 07 Aug 2025 08:47:26 -0400
X-MC-Unique: aOMPnF-QPQOYGQcsZFSFbQ-1
X-Mimecast-MFC-AGG-ID: aOMPnF-QPQOYGQcsZFSFbQ_1754570845
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-459de0d5fb1so9044575e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Aug 2025 05:47:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754570845; x=1755175645;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aTK69kQaFZtjtvMSMDYC7o+QFQbEWEankqiOa7dNWH4=;
        b=fmEq9fRDwzKrBGDF/v+wC60nCj+Ka1xVNx3Hlof6DJHWawzztOi2jghIFkuB6OmPP7
         3XVXAKPt52Wz+OX10YtL5MyMScTDu6ifrBKBUKty5aQzWgxp6JzofLP+DMC7vAj9wOr8
         jKjiZ+jIYd8xTxMFjuwRij2We5YQ22DUAQCU8k7PDIE8i3KuPJZa3+eA159+UQAgW3Ng
         xyBwWC+zX3951D+olJl8LraRG6o5pf7Nz4YSF5qUvyFgei0R6Y1ZdWUxInUzHKUcEksW
         C3fxrOgsl+W7+Q5lCGE1gWFCxolniK13CI7bzvc/B6d4aP4rCxugAgtaUhsPWmKWnzEd
         RLeA==
X-Forwarded-Encrypted: i=1; AJvYcCVYKYLz0FXIfBroy2HZUKG7UzhzLx75VMvtz1wkuIDK7ReqZjz5c6iLoOIOtmgWOLH9ejW+PJOElJ533x4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbUZ5tNhRyOaJytAEVxMtudpsQmImFKZ1qIwOnTikAm75MNSTR
	hxZGDcOtyh7M1z6SVLtC9Gkcx28Tb+mn2FU72FFoDqNQe1AoK7oAb5EYoRP4/dXq9vn3H+Le3KC
	wu/O66Qy295CeD4H8VAIAujPTM2CurKwyE4lWDycs9hOpEhjrsud97W8IGqqbiwEmXLab6rJYdA
	==
X-Gm-Gg: ASbGncs3Dh0sfjPPp0mgSNSRKwU/xv6lEbTONuMpk/ylfwmUUS9hxqmKey0gljeoAjX
	ECTNn7ftupMcAyWif0rScvYQHzfu+aoiXCX3EVMYFIP2dfpSlPTtXpzLfmN8UoTKBUfTDBdU7WP
	w1uyelsmPgZbXXrHOx7WLpGFLdI4lnyMLeLN8O2Ubn65x6QU3XXjS/nVkc0PQUDVJuchWSINNqL
	Kn9r33925XJx1MS+JYAHccxC0Tg4sOgdtoxH8hONAW4gyDOfCe/Z6KlbsGosn7YC89I6XwtPVfn
	b/5h/k83bxJ0AVfXv/sJeG8JHoRVB91Y
X-Received: by 2002:a05:600c:468b:b0:456:1ac8:cace with SMTP id 5b1f17b1804b1-459ebd12934mr46363015e9.12.1754570845007;
        Thu, 07 Aug 2025 05:47:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG09B4jVXtQ521CCCpSOE6UxD7Ba5Baj1YjRug6kR2oAgnAlGT6bbB3OaejRPpTTtCumhOhhg==
X-Received: by 2002:a05:600c:468b:b0:456:1ac8:cace with SMTP id 5b1f17b1804b1-459ebd12934mr46362755e9.12.1754570844604;
        Thu, 07 Aug 2025 05:47:24 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1515:7300:62e6:253a:2a96:5e3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459e0a24bf1sm120608885e9.1.2025.08.07.05.47.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Aug 2025 05:47:23 -0700 (PDT)
Date: Thu, 7 Aug 2025 08:47:21 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	jasowang@redhat.com, jhkim@linux.ibm.com, leitao@debian.org,
	mst@redhat.com
Subject: [GIT PULL] vhost: bugfix
Message-ID: <20250807084721-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mutt-Fcc: =sent

The following changes since commit 7e161a991ea71e6ec526abc8f40c6852ebe3d946:

  Merge tag 'i2c-for-6.17-rc1-part2' of git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux (2025-08-04 16:37:29 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

for you to fetch changes up to 6a20f9fca30c4047488a616b5225acb82367ef6b:

  vhost: initialize vq->nheads properly (2025-08-05 05:57:40 -0400)

----------------------------------------------------------------
vhost: bugfix

A single fix for a regression in vhost.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Jason Wang (1):
      vhost: initialize vq->nheads properly

 drivers/vhost/vhost.c | 1 +
 1 file changed, 1 insertion(+)


