Return-Path: <linux-kernel+bounces-816700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6299B57751
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 12:58:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01F1216210D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 10:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAEEB2FD1B3;
	Mon, 15 Sep 2025 10:58:00 +0000 (UTC)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D99A62D7805
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 10:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757933880; cv=none; b=VWCWBA8i8WW7teCTn4ixIfUSwIuepa1GY8h6NUg/xKe/n63QiohGTMtiRv9EYuYychjMowsWDcJiGoN2IwckS6M2RCAYOLoyT6ftJPgC/mLdmcUGe2twbjV0gIgITUc41G3rEicfBiFfARpjgNsFVLGiWkpionFopc4dtGh9Xq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757933880; c=relaxed/simple;
	bh=H8a9AOknFnKTAIvE/ikaP5nTBBNK9uvX6MCcpkX9++g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nu643ebP/op6h2BUCNBd0q4p9kFsXEOSi7c65VKJ1tzE6bg3did4QepcjD5TIoj1mpCESH6C8LzZj07WIMlKBugnwr2wwIknt6Ti/qG7UkW5il2NGUBUCOSgnod90zM8hG8cojPwb63BIG9I9NDVD5eylwevihn2mjeQM0ueFW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3d118d8fa91so1301204f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 03:57:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757933877; x=1758538677;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qxA92b/5xfR0qSfNO+nVmulxGyOD0T7zyHwVnXVrHGY=;
        b=F/2ulNX8dRHgPkddQK3ABtm8wf9GdAQaTHCPvnY0l1bVonijQk7nd3cAt1YCTI++8s
         0RCNa3eDz73xV9rhYRyq/U2D7kK2YK+1gTwROovLdU4YINdMROI24rjaLN9cQ3ura+b0
         Z6tzDzN8Nknyv6rQjx1tL5XhmyZb6PY7n1lyNQxWu/yPmkHJJ6aV1My4mXp4qiRilt8r
         1SYU3MoHgC+SJQB/2qHUT53/kx7GvYVO0uQhTYvR/mhNy7tz1RWRhe/SDk5T/mbVHFTe
         Kif1IczBA15ul55z4Jhnr1hYByl1RcRVmmEqcfQaQKh1eXEA2I90r6mB/kro3DvBvAKI
         8pmA==
X-Forwarded-Encrypted: i=1; AJvYcCXKcU93oCCgjo/wsVWZ8NcW2o3xilANEMoSfYknNmLtIvXE8VZhBXmBHcFxaiXXDaAMeNMR7kYvzO4YIOc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVwWu+LI5/JihGG9Shrc4JoNcYKk0kEmp7wL7mFOJWFWP08GY1
	hBuO8Tx2XtMhLiJLJpel91qskisZ6K9UbNYAX3ZQ4HlZeSFiTGL9WzDJ
X-Gm-Gg: ASbGncuO5478iVsaEAJbm5h6TUBrXhzH/ZcNVp5vY0GPL+RA+Fe5zBwIGczURdh6Xid
	Zef1abTR0LteeDebrkRr5S0o/XQ+lJQVeNRgA54jRKDffhpZRfZJ1EsTlu7PbbmW8fJUXlcmeMf
	FFCz8OKoPBZCZ3s4Gne18fB5mBTr/98VODrnkSquUr/5CjDlUW9CB9JKBEJTC2OXiGa4bVfXstR
	6y7igznlbJoDAXK5XTSc4zzhhARhq4plrxHJ3FHQH/Kc8WoopSkq2QY8ebuYWpXOnxkJ0wPC92F
	qGRt/Dq8XGXn2R9DwkDqBgo62k5zLVkDNW0PG05PlV3fsAMbEG/eC8sQ8PMqGyA+vx8UjS5Iw92
	sgVw78F75e0qR
X-Google-Smtp-Source: AGHT+IEqBROGBlCJuMZ5Xroh5nM+yePitTdtSR2h9RagADSGmVIoyFS5fOwROqRLNyP0ZkUbkvwstg==
X-Received: by 2002:a5d:5f42:0:b0:3e8:6b2b:25e0 with SMTP id ffacd0b85a97d-3e86b2b278bmr6162260f8f.25.1757933877209;
        Mon, 15 Sep 2025 03:57:57 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:8::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-62ec33ad2d6sm8998142a12.18.2025.09.15.03.57.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 03:57:56 -0700 (PDT)
Date: Mon, 15 Sep 2025 03:57:54 -0700
From: Breno Leitao <leitao@debian.org>
To: Lei Yang <leiyang@redhat.com>
Cc: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, kuba@kernel.org, 
	Simon Horman <horms@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev, kernel-team@meta.com
Subject: Re: [PATCH net-next v2 0/7] net: ethtool: add dedicated GRXRINGS
 driver callbacks
Message-ID: <jserzzjxf75gwxeul35kvvexscs7yruhlddwhmw6h433shfdhf@jsesmjef3x76>
References: <20250912-gxrings-v2-0-3c7a60bbeebf@debian.org>
 <CAPpAL=zn7ZQ_bVBML5no3ifkBNgd2d-uhx5n0RUTn-DXWyPxKQ@mail.gmail.com>
 <glf2hbcffix64oogovguhq2dh7icym7hq4qkxw46h74myq6mcf@d7szmoq3gx7q>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <glf2hbcffix64oogovguhq2dh7icym7hq4qkxw46h74myq6mcf@d7szmoq3gx7q>

On Mon, Sep 15, 2025 at 03:55:53AM -0700, Breno Leitao wrote:
> On Mon, Sep 15, 2025 at 06:50:15PM +0800, Lei Yang wrote:
> > This series of patches introduced a kernel panic bug. The tests are
> > based on the linux-next commit [1]. I tried it a few times and found
> > that if I didn't apply the current patch, the issue wouldn't be
> > triggered. After applying the current patch, the probability of
> > triggering the issue was 3/3.
> > 
> > Reproduced steps:
> > 1. git clone https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
> > 2. applied this series of patches
> > 3. compile and install
> > 4. reboot server(A kernel panic occurs at this step)
> 
> Thanks for the report. Let me try to reproduce it on my side.
> 
> Is this a physical machine, or, are you using a VM with the virtio change?

Also, I've just sent v3 earlier today, let me know if you have chance to
test it as well, given it fixes the issue raised by Jakub in [1]

Link: https://lore.kernel.org/all/20250914125949.17ea0ade@kernel.org/ [1]

