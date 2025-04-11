Return-Path: <linux-kernel+bounces-600970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 36391A8671B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Apr 2025 22:30:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39B351B82840
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Apr 2025 20:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A1FD290BC8;
	Fri, 11 Apr 2025 20:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="I8u4OxPU"
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8151E27E1B0
	for <linux-kernel@vger.kernel.org>; Fri, 11 Apr 2025 20:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744403381; cv=none; b=ljYHqVvDbDji5VaO2RDybYRTbn7tNUj0GbHqJMwjqgo/KmgHVYllPPXmzr4bqLVKT2sm2paJHxJ7vM72pM0545NWWcfi6i7D99ALRSD5gMMDUvB+Vur7xyYUm8GHk8LJusnP8/aFXKScEhTw+mGr9K6k/8Vtr+w4d7pfaObpGZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744403381; c=relaxed/simple;
	bh=Zz8alp7eLPIwTzedMMr8/MJPGI2MAf5TOo/6UlH4/vw=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=PyrmdglF+41AlTV4ByK6nGwntxdBpYIIHtpfsyBDRm16ndOoZYgRPItgigwHZJ64kSUvq9K7F7Dyi/SQjOK87T+T1IAMDuku9ijajaOrK1T8F7I01ks6frkwr5SqpU/h9L4CmWlJgKq1q4RiN8aqCuqWjq9v+yCqXgwlJ9qEKVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=I8u4OxPU; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6e8f7019422so21624436d6.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Apr 2025 13:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1744403377; x=1745008177; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JbHr93LO4bs0ZMoXRyryi8G/f9qfrVu4Cl+FMwxiTZ8=;
        b=I8u4OxPUBdDE1vZ0s0xDjkdQxI3Sbz4HS11OjZqj/AZCzFdRIWHVjkqc5awE81BKBS
         j7Kc/cHuvqOlGR3Y9d3jWA+QjngKx5Fa8LlCtYpuRDOufqQ2FChLBKUCCqDyIa+QGonL
         caMLtseK48RqSJCx05L7kqRD5nZOhqTRsBum3lu7XZZ7RP7WTKHu6xmUDdSw70b7JqQS
         2e3YcahcuxAT4aN4m3byuhSYGJxmMM8NUbxYCY2bLxo/9FKXFmCiJcTJ1b21pkqiTlRi
         kKRYPy5BPP5q2OMKEwueDaXPnvzLZd8TpVOUV2d67RpDdUhEK5OZaTSMtrU6+y3F+U6G
         2a9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744403377; x=1745008177;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JbHr93LO4bs0ZMoXRyryi8G/f9qfrVu4Cl+FMwxiTZ8=;
        b=OyDrT/rkJCI00cEa8+uzYkB3kVhVi7C6Sbwi3kea1SM6lP6lEcyiOPmcRG0oOl65Hk
         +56Ie2NgI1oE7dju7jGuKVDRphi28f1XUHvedb4c4QMDgwwi+UiK9yngRglJLEV4XNl5
         Zb0cgNUA7HRuCGqjRijia7tG4lCqIi0wN4a/C/BE+PWxXOnopcjFHG2oBEmwh78xSAoo
         Zsez8zRzl1fcNZjhAIJIHL41Od0JQU4sxHTxxp/FqoZ6fsB0NcTI2KzsyX0sivWLHiOo
         Or2tZbsWcAHiEUi7xnohMbHCBpVMIiy2KaUaGELgEESPgi8MsaPluxrX8/WHLilF10UZ
         Fn+A==
X-Forwarded-Encrypted: i=1; AJvYcCVmXm+jb1ssSfD1GXNW+J1IUCcNUyXgKrLxAA2PoUtnnZxV30ZvJjiE9U77v6FzRliNzIhu3PmXLz7bflQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKtEH9uRPp7lMDLxlZ5fNiEkE/lOZ4Npobwu+p+zFr8r3Pjl64
	UcQt1YoqGTLtNkMRFYxoV+8dyE7ndsvaPi1dTZVRB/no9ko6F4AtV4ygIcmSDQ==
X-Gm-Gg: ASbGncvXlEXAPjSv4YWu2A7yq14lD2lrYiLJHoih7xWOj9N+yTT3U+QAv7WQuT4P/lr
	00FoNfZ3dXyk2u5CO2l5aZE8Nq1sWkWHuFG0I0+Nctw+J7tMIsx8XAoNWrNRt/UToENp/4k0ANj
	yp0f0Draf+pxgLQqsS1vaYodXKBST8b/FdiXVm4NBfqdplfW1eUQ96Jq0GGssOA/hxDA0Yceps+
	XptqNHjX4v/qp+ampoDByj/ULB9Qu7AfAlOpaic6dF+IHYVnBVf8zJBW0RzkChJIAAkyf8NWbmF
	qBQwMA+3Y6LJRvpzdVeB5InOiSp5oC6voqjYsQRvxQqXWYJ1ANH4nD3+vsoF3dWmVj8juQDb4wQ
	SdZ/WBjejHA==
X-Google-Smtp-Source: AGHT+IEBKJDajZYrrZ3gDKTry1qqALA694IS63BLywJqibFp8HFfvqn3OIAivhRbWMwLbAA37COABg==
X-Received: by 2002:ad4:5dc6:0:b0:6e8:f3b0:fa33 with SMTP id 6a1803df08f44-6f230cb96d5mr64559166d6.8.1744403377434;
        Fri, 11 Apr 2025 13:29:37 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6f0de98096bsm41240806d6.59.2025.04.11.13.29.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Apr 2025 13:29:36 -0700 (PDT)
Date: Fri, 11 Apr 2025 16:29:36 -0400
Message-ID: <7ed70f417b10ae1510dbbea501da892c@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20250411_1406/pstg-lib:20250411_1552/pstg-pwork:20250411_1406
From: Paul Moore <paul@paul-moore.com>
To: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, =?UTF-8?q?Thi=C3=A9baud=20Weksteen?= <tweek@google.com>, =?UTF-8?q?Bram=20Bonn=C3=A9?= <brambonne@google.com>, Casey Schaufler <casey@schaufler-ca.com>, GUO Zihua <guozihua@huawei.com>, Canfeng Guo <guocanfeng@uniontech.com>, selinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 4/6] selinux: improve network lookup failure warnings
References: <20250318083422.21489-3-cgoettsche@seltendoof.de>
In-Reply-To: <20250318083422.21489-3-cgoettsche@seltendoof.de>

On Mar 18, 2025 =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de> wrote:
> 
> Rate limit the warnings and include additional available information.
> 
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> ---
>  security/selinux/netif.c   | 8 ++++----
>  security/selinux/netnode.c | 4 ++--
>  security/selinux/netport.c | 4 ++--
>  3 files changed, 8 insertions(+), 8 deletions(-)

How many of these messages were you seeing that rate limiting was a
concern?  Also, what were you doing that was causing this?

> diff --git a/security/selinux/netif.c b/security/selinux/netif.c
> index 43a0d3594b72..38fdba1e64bf 100644
> --- a/security/selinux/netif.c
> +++ b/security/selinux/netif.c
> @@ -141,8 +141,8 @@ static int sel_netif_sid_slow(struct net *ns, int ifindex, u32 *sid)
>  
>  	dev = dev_get_by_index(ns, ifindex);
>  	if (unlikely(dev == NULL)) {
> -		pr_warn("SELinux: failure in %s(), invalid network interface (%d)\n",
> -			__func__, ifindex);
> +		pr_warn_ratelimited("SELinux: failure in %s(), invalid network interface (%d)\n",
> +				    __func__, ifindex);
>  		return -ENOENT;
>  	}
>  
> @@ -169,8 +169,8 @@ static int sel_netif_sid_slow(struct net *ns, int ifindex, u32 *sid)
>  	spin_unlock_bh(&sel_netif_lock);
>  	dev_put(dev);
>  	if (unlikely(ret))
> -		pr_warn("SELinux: failure in %s(), unable to determine network interface label (%d)\n",
> -			__func__, ifindex);
> +		pr_warn_ratelimited("SELinux: failure in %s(), unable to determine network interface label (%d):  %d\n",
> +				    __func__, ifindex, ret);
>  	return ret;
>  }
>  
> diff --git a/security/selinux/netnode.c b/security/selinux/netnode.c
> index 8bb456d80dd5..76cf531af110 100644
> --- a/security/selinux/netnode.c
> +++ b/security/selinux/netnode.c
> @@ -228,8 +228,8 @@ static int sel_netnode_sid_slow(const void *addr, u16 family, u32 *sid)
>  
>  	spin_unlock_bh(&sel_netnode_lock);
>  	if (unlikely(ret))
> -		pr_warn("SELinux: failure in %s(), unable to determine network node label\n",
> -			__func__);
> +		pr_warn_ratelimited("SELinux: failure in %s(), unable to determine network node label (%d):  %d\n",
> +				    __func__, family, ret);
>  	return ret;
>  }
>  
> diff --git a/security/selinux/netport.c b/security/selinux/netport.c
> index 7d2207384d40..dadf14984fb4 100644
> --- a/security/selinux/netport.c
> +++ b/security/selinux/netport.c
> @@ -162,8 +162,8 @@ static int sel_netport_sid_slow(u8 protocol, u16 pnum, u32 *sid)
>  out:
>  	spin_unlock_bh(&sel_netport_lock);
>  	if (unlikely(ret))
> -		pr_warn("SELinux: failure in %s(), unable to determine network port label\n",
> -			__func__);
> +		pr_warn_ratelimited("SELinux: failure in %s(), unable to determine network port label (%d:%d):  %d\n",
> +				    __func__, protocol, pnum, ret);
>  	return ret;
>  }
>  
> -- 
> 2.49.0

--
paul-moore.com

