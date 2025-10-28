Return-Path: <linux-kernel+bounces-874339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71537C1618A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 18:17:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B65F3BCAFD
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 17:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E3F1344047;
	Tue, 28 Oct 2025 17:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HeRHG5qE"
Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0388534402F
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 17:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761671428; cv=none; b=ePscbiSI+s3KazXSSyAXlE/McdQO4JYuG0Cl15AaxsLvWMpnWjYZrqfIprqac9UpT/D6/ADpcEGhqyI4+o/rCfYBC4aEsteREXYCsycsNWBXm17YtWhi7of7wWucQheQzbOucWKsDW/mfKtKVuZd9Pq8j5PSCZifzC5yLQNgGfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761671428; c=relaxed/simple;
	bh=m3I9dtve6TdfQpeD/5c1k/FwNdSdObvUw7hMoEvNVYM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=In6y0fKyQV+k3dcQVPu8fd6fBMpBY3l26LRWndhcBjkyEM4vTYR4sCOafIcLjb0UDjyIFbHTsm0ekKo05Exq9UR3CrAztu5SOYwa5EJTeZeRBXvqRXmCs/ON0Lnyl4DDLo6XjczfEulQxzzO3VvkJMpgFyQDGiIBc6MKDOXsAZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HeRHG5qE; arc=none smtp.client-ip=209.85.210.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f195.google.com with SMTP id d2e1a72fcca58-78af743c232so5786762b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 10:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761671426; x=1762276226; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NkkeBtodNmN2EMa9qJLybudRjmngQqkOpn4I47bN1Os=;
        b=HeRHG5qEN5uTjjY3ibkWq33IiamipujAhi60b9r1rM5RRPJZix2+MocaWLMsgNdzzn
         rCRaFyrKnHeUaypQDn1k3K/dqscVruRVqMTp+igbGbC+db5aiAfFYeE0f5PSLqzGly0B
         Ovbu07ITP9IM/2fwN+YgCr6l72LfCsLXcf98t50rQ2aT51I9i9QHnWZBcPUJfgmI0dRC
         hcDVe7L3na0X+uTihwIrNh/OF7NNAdsSDaUs/thpRtSEuaO3pAwmuCxPhAYF4SvzmzBq
         +g5mLWYTq+KRd+hIVppWWv9JlGPQ/3UNy/vJ92ZwMl4d1BKAHGUXeTSQGuqNK8db6i73
         GIMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761671426; x=1762276226;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NkkeBtodNmN2EMa9qJLybudRjmngQqkOpn4I47bN1Os=;
        b=Dq3Y5OlBzfzsjfjVyBJjzZqABJdkF/KmuHnSJultFfipvJnqm+uGiIDaXHTLEGQ7r7
         bXlxLWuxLcXPXwpuS1uLlEgQJI95XY5SlzM/zKtyGavj4wqC670Jqka9qMfnetZc5r8I
         BOVOBHHf+FI5TLEAcik6sD35GqLkYTpAcZrzzsWfOH4RIg/ZdkkPFhTuuhPCev9gHaU5
         Ac17cXGm3K5pL4XtjP8GjtLeVyflKFEwBZ96u9CygQ3H0hu4VQsIrVv7OQ/d8BdBMKnn
         CgVmlGMU8kcTh9e24FbAT9Ya1lQN/fEpbJavkrEKwXKc5x6gmZS0VnX5K6Mo2Vic65ny
         OLFA==
X-Forwarded-Encrypted: i=1; AJvYcCWZ0vYngkZWOhJo7s7KxUx7egatHojS4aa1NRxerHUiMqsMRcCYjV9XzAZfSso+WCEpuOdMmuHgGmTT4g4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzps4BLa8LsBx44Xw9finQHJdDAHX9KR1axquQwMinpkY0iGZNj
	aLvqbHImVi1ONpuEmaDMwaSMORScB9+M7EeBKJVI2j6VqC29SSfAMJrT
X-Gm-Gg: ASbGncvFxkmXL5+K4F4cTia2I8F8McvVpUTaY6bdaSwoO+HBPhOCM+OGoNFNT8jQyFZ
	ZPJWhlvFtZWx/M/mwkXKZ6GHepSb/jBvIJWcpg5QeC23MlM52QaAC3qkNvnVE+0pjcGqbAPyB0W
	cyWQJk1Voe0z2oD+XQ7tQM9sZI1MZm4RVzD1ma02j0EYcHaxX3/xn2s5Q9vmygQ553+KnlMOzMd
	mNR+yJamIZKa8cas8XXTFVZUGP5KK4FSuN5bhrXAgN6XNyvHudSNnUNUuIIgqQAacZQcu13SUEq
	dVkmXR2IEKjG4TEiutmFCo+9ODvg+ECPid6c3SLBa5eXaRfCEnIHRTB0Xq5+oMy2OSlS+4pDIw9
	EtXlFpKMh2plfiMJIz47Xm2oWumGOnbvXHnLZgLcLydip9eGtC3ItTtKcCLOb6YHd1VqRdLri/1
	VWw5TjtnxxdDdO5KdD5qk=
X-Google-Smtp-Source: AGHT+IGQ8ffNexl4HmIkFUmg1fdyuZl4JbBMFVH6xuxPDuvHwL2uHadtShWy1RlMi1Xof4Eda3TnCw==
X-Received: by 2002:a17:902:ec83:b0:27e:ec72:f67 with SMTP id d9443c01a7336-294cb391897mr51139475ad.6.1761671426009;
        Tue, 28 Oct 2025 10:10:26 -0700 (PDT)
Received: from fedora ([103.120.31.122])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498cf3bbcsm121911965ad.15.2025.10.28.10.10.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 10:10:25 -0700 (PDT)
Date: Tue, 28 Oct 2025 22:40:14 +0530
From: Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>
To: Simon Horman <horms@kernel.org>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Florian Westphal <fw@strlen.de>, Phil Sutter <phil@nwl.cc>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>, netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftest: net: fix socklen_t type mismatch in
 sctp_collision test
Message-ID: <aQD49ukK0XMUHTUP@fedora>
References: <20251026174649.276515-1-ankitkhushwaha.linux@gmail.com>
 <aQDyGhMehBxVL1Sy@horms.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQDyGhMehBxVL1Sy@horms.kernel.org>

On Tue, Oct 28, 2025 at 04:40:58PM +0000, Simon Horman wrote:
> Hi Ankit,
> 
> Please preserve reverse xmas tree order - longest line to shortest - for
> local variable declarations in Networking code.
> 
> In this case, I think that would be as follows (completely untested).
> 
> 	struct sockaddr_in saddr = {}, daddr = {};
> 	socklen_t len = sizeof(daddr);
> 	struct timeval tv = {25, 0};
> 	char buf[] = "hello";
> 	int sd, ret;
>
Hi Simon,
Thanks for your reply, i will send v2 patch with requested changes.

-- 
Ankit

