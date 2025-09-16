Return-Path: <linux-kernel+bounces-818050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B6B5B58C1A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 04:58:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B2AD520168
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 02:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECB9725D216;
	Tue, 16 Sep 2025 02:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kxEVaw8b"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0674B23ABA1
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 02:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757991520; cv=none; b=uSEzGjUphTALvG9WIzUP5VBL32zTFXggSkftQ1LpttVAyA01f2SYOiB38KLRJlJwqdnKR9OJlTIqHiKExfCkrGVgbl+fwC0CCSXRFuS98m+KWvHUu+XbgTDQGq5rQZ9YF4zoNrRP0Q/bwZlxDeYspP5Z9GGY8/nzqo5xeALbEXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757991520; c=relaxed/simple;
	bh=7XO66tFZ7sDtnbhU8FMTHuC7bAcZAOuj24LDeP0n+JU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nJYH1nSh/8UK2V3tlO+dSaHRPVRO28Aq3U2N6kqt06MwPSQrVzDQNShBkTNxzg9DIciWIwxMt3Zc++4gXHP0mTXMKZxo5aUclD+jp42kyxVEgj1BCqgcl+0jBOK4FbEPyx5PHn4E0Y5bN0QJyxISnIW//uFm0YkSllxWZRqncd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kxEVaw8b; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-24cde6c65d1so42687945ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 19:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757991518; x=1758596318; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aQgTdWvdAbQBkxXTr6NMR0psWz9YegO9W+coZ5goAHs=;
        b=kxEVaw8bf9vuBlp2ZbMHx8xvRrOnKLl+SRELST874YRW/9R3lKOjE/oU/DTMwJGFyy
         5JWfUEs3HyfDMASVLzU89WA3Rvf1zazHsutNSDv6IvGT8tHh8Y6Ce7sV+U6aR3i+nILF
         OoHJs3AaXDfhtTWQMWQFVho3Gn1UTBFbe4A5FYns3rHUiZWnj2DIqBSybEOW0aKF3Byq
         kJ06WrhU+MM6j+8SdWeELVVLnmSaSQchi4RyNLXRfU9W6v3biM6PJN5B7sivChPDJGLs
         ugt56e6+7MwX4UVxcJQjL2Lq0Doz0W4sXWs7eTI1VbUCpeMJdpdzavEZB9kRnAhPDo4q
         r8rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757991518; x=1758596318;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aQgTdWvdAbQBkxXTr6NMR0psWz9YegO9W+coZ5goAHs=;
        b=RrgS5x9yQIGtXSOHFkmVLv3Tp7amS2pwk7f235R61CElPtH8CCv2XAgHy/yOHoYhIS
         IGWtQAMrb6LfT2Qv8Z6womD9jf14EzGCXfvM4bAtnlrvmtLakePZl7Q6AhLvejxhdMgZ
         xUONg0QKscOjTB7YSwfJDCQ6Dl/xAmL779n9Z8LoOEM8jcO193p3qbqYZ07bDjIGe4dD
         W2FP9q2aHxOcrGOLjy1GR1bFZwzi0MHxOi6TsySPsHUYIxTWSyvSRUBwufC3Tf/Ye1qk
         1zQQguB7qWilx0u7aFKzEaSp7/PfbfAUkjaJFr7QKZlVrGmPJXG0IXLga+xlwaqliphR
         EyTQ==
X-Forwarded-Encrypted: i=1; AJvYcCVCJ/Mjb2tlFdC/Fsxu3hhZbrDeGCv2WOs2gEkUqjzYEMy5sk4oWhM3QiZQ3WcCxneXX7wHv5dqOEHQKE8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2MalLx2p7Gaf3y4QEuw6/kncKPE4fr37ep2jfvcSYz3Ou9hnY
	2wHNTKxu6jRIlgQK4RislzvMhFMU1dgzEsh4fvVdo0umTzgw6VhT49CT
X-Gm-Gg: ASbGnctCS/5FK4P5dv0/DwM4KrmXMUDRyuMClOz2mIsegH/gjhHw7EvX8drSKrHxqv+
	uPN3iahBEGJzHY6ghd4zJZySowcUiTGkU0IHS8eDv8EixTjvafK72AWO9xGccuKgUMmytnq2ItX
	Irml9QJY249TjcnL8mIK3DEqS0VPecNG9EsG3N4qvtHYlirJbxVB6vM3nLPp7Uzvx6FWjFCY7wr
	Yrw6pfQbobhCptCHbCrI9DyP7yx2nf/kalMylbFeojp5pCp9m5uEQDLxzdsjRgizDfnK1u506h0
	Dew7PamRG+INme4q2rsLta9agwzVH6Y95I5zDCSHIWpSPR4FzBLBclQLC4aGM1UDAgwGnYnURFO
	QX+cVzJOBqrVG4vxXvmsqk5u/zAWbZKLc3zpgsA==
X-Google-Smtp-Source: AGHT+IEpu9RPplREq+3dMnA9cO4wkDr5H7kfF9jU5qM/IUS4/1bFfNRe4izqZKvwQuiVIt05YcDmPQ==
X-Received: by 2002:a17:903:388b:b0:250:6d0e:1e40 with SMTP id d9443c01a7336-25d242f2f14mr151186285ad.7.1757991518269;
        Mon, 15 Sep 2025 19:58:38 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-267b0bbabe6sm22016895ad.107.2025.09.15.19.58.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 19:58:37 -0700 (PDT)
Date: Tue, 16 Sep 2025 02:58:31 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
	Petr Machata <petrm@nvidia.com>, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] bonding: fix xfrm offload feature setup on
 active-backup mode
Message-ID: <aMjSVwIv7f9VDvHL@fedora>
References: <20250915083742.423741-1-liuhangbin@gmail.com>
 <20250915184123.505d2bb8@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250915184123.505d2bb8@kernel.org>

On Mon, Sep 15, 2025 at 06:41:23PM -0700, Jakub Kicinski wrote:
> On Mon, 15 Sep 2025 08:37:41 +0000 Hangbin Liu wrote:
> > The active-backup bonding mode supports XFRM ESP offload. However, when
> > a bond is added using command like `ip link add bond0 type bond mode 1
> > miimon 100`, the `ethtool -k` command shows that the XFRM ESP offload is
> > disabled. This occurs because, in bond_newlink(), we change bond link
> > first and register bond device later. So the XFRM feature update in
> > bond_option_mode_set() is not called as the bond device is not yet
> > registered, leading to the offload feature not being set successfully.
> > 
> > To resolve this issue, we can modify the code order in bond_newlink() to
> > ensure that the bond device is registered first before changing the bond
> > link parameters. This change will allow the XFRM ESP offload feature to be
> > correctly enabled.
> 
> This reportedly doesn't apply.. I suppose we want it to go via net?

Ah, yes. I forgot to add the target repo. I need to write a git format-patch
wrapper to remind me adding it...

Regards
Hangbin

