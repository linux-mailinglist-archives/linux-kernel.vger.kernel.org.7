Return-Path: <linux-kernel+bounces-752441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B877B17598
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 19:30:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13BA7546789
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 17:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 351332741D5;
	Thu, 31 Jul 2025 17:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f5C96pq+"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D61DBE6C
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 17:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753982997; cv=none; b=Sj09ilNXH+xxwz4E9JB3rPe2pTs+MuFAthePIp2TdMvYVKC6Bv3VnUWCzhtamc2lHqfXZI5FiM6v47w1YItIbmy5zLoworapXpaI4keMrwKj8LNjdpu+PPsoojr8ObJTllUVQn9SolM8yXV9Q3TPlN1FobdB+vnrqWNadnyLhL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753982997; c=relaxed/simple;
	bh=z6YdCAATkLXfNaxHpsEJfYTsZdJOBEnA3qR4xvdCH5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KhK8eD73rkbnFfVqERfQxfchcwkRNx/2gGQpIlL3sEzWXme8+fAa0vmZDm3AsNQ0DWnOMsqKRWM2nzhSXLVNDvoMY4r5O7TjXGosjVdaCu66G5jnnnRtwN2uVvl9OtQw67STS6Nl1lWaCgmn7omHspWVQ+oGX0k63tiqJmxRSoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f5C96pq+; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7426c44e014so1279087b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 10:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753982995; x=1754587795; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uFB1KZ2lsUeHNufD6xWB23cW2C4DYwY3reFze5Zou7o=;
        b=f5C96pq+gIheO2VpyX9ZH8YCfpKosbFpKh1yqf5HZ/mKI+pjaxkMqoud/HIKEvj9tV
         vrncMdcPnxyF44cXEkySj/uzKagwxLQPWsEW3mJIW81p3vX1zzHfnj0JLNMhy7H44aJs
         7AjIId9Q4B7Trszjsjb9psax010FsjhU9ZjqTou19It5I10PsdqXDUNyxey8e7SMa/K4
         yZ1aCRmcK+hy5DXY8CYkwz0wPsBawESNJgi6ozqf52hnDjR26nuL/vyPkpOghN5+KcEa
         ivA5hOTYrBn1A+njzU43gznTyUAJS49mObeIhSlyCK0tjSbdF8iZUYNFwKzymTfOMRIL
         xjRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753982995; x=1754587795;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uFB1KZ2lsUeHNufD6xWB23cW2C4DYwY3reFze5Zou7o=;
        b=KWzVKd1jf9PNXNRYKCkHr7R+dncU7whFMh7HCCq2yWFm+CIGyIp69eB0m22Dji62GK
         tharmfUAAXMKGJhgsNDlmJNfkSWpcHUV2I+4ocfDKmpvzMaRSeUWitsyt2kBv5LB/ch8
         wC2BLZl6uqFdXrL3wrusmVLe9GheRBAAfzSjUf6z26DkmuhL/7wpIIJ5zQdct+XqRn6N
         Ag6PYWpgSmQX+EdbTokcROhOzb/bvMk8LqY36H/esgYbXZLuaQfqkNdSGuLi88BrtZmg
         4D3XukHc8G63SWiaL8a9E8gKT2j+FRRo22roDo3L7aldq9lahrCrzYg4hmRQG23Umjdp
         ypVg==
X-Forwarded-Encrypted: i=1; AJvYcCWQHlAIWabSyUnyebLGWd5/8Gk+sSwLUWFwndwsqBu9cwcHu6XdHLNhHoMexNV+rdZ5p+TehSCFuKQgkdE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+/8OJMDCfENvYFzHsJN6xTUcUDlnaqipQ1vGuuW9+gtsBqS6B
	9lOWiziYjCBBN3ZscxtOZoT2+BTmH0TiZf4U1C23oDOAuwJygnjxqNYqMtXs3g==
X-Gm-Gg: ASbGncsa2Wp6Y6fevcO5gKwJbdMfAjdkp1VU1HHFun/y+uEWRik4zrrVJnZM3BOxUJO
	0nhtuufwm7Ea8qinh9pFz+MvBgo93J03C5B2N2NDDus+oPR4FPdRWfCUr+MyXZr8iZkAUcyTBYH
	jm1S0iqjXKVmf95CG3hDR0HiEIOXLsq+lFe5bPx/0gY5up/KmrbZxWDufHsFv6pE8Cts08tgeES
	bjLdTCcMyzONX9rqSYWqE0eP8BzjxF2/VHKbuJbpu/0/c0CJSL+xx5YoTunvIwMFtpGcGNJTAvZ
	OXg7brLx7u+AlAKR3ZfGulKJyVtX0i3MIQm6m9mVN3XwXHgc5/bn7eEdiuebbJE+pn38tbx/uBx
	1TdvWb/JwRvX99cJT5JGT4tlWGLOgzp8=
X-Google-Smtp-Source: AGHT+IFUlWIwvzgTtCNc3AFKsHu9fjk/Qz1kk+2FMUpFckYpU27uESuIj6tbG7ODJikhMeuIT5oUHw==
X-Received: by 2002:a05:6a00:1989:b0:76b:92ac:27cc with SMTP id d2e1a72fcca58-76b92ac2fd6mr8386461b3a.0.1753982995345;
        Thu, 31 Jul 2025 10:29:55 -0700 (PDT)
Received: from ast-mac ([2620:10d:c090:500::6:d4f1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bccfe37e5sm2118703b3a.116.2025.07.31.10.29.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 10:29:54 -0700 (PDT)
Date: Thu, 31 Jul 2025 10:29:49 -0700
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>, Nam Cao <namcao@linutronix.de>, 
	Ricardo Neri <ricardo.neri-calderon@linux.intel.com>, Yury Norov <yury.norov@gmail.com>
Subject: Re: [GIT PULL] tracing: Updates for v6.17
Message-ID: <6z7h63sg3ljhy2k2ymnysm7hhcmtb76follkdy2y2iu54npxqj@wppxbg2qok2p>
References: <20250731101717.6c340b66@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250731101717.6c340b66@gandalf.local.home>

On Thu, Jul 31, 2025 at 10:17:17AM -0400, Steven Rostedt wrote:
> 
>   When tracefs is accessed from /sys/kernel/debug/tracing, the following
>   printk is triggerd:
> 
>    pr_warn("NOTICE: Automounting of tracing to debugfs is deprecated and will be removed in 2030\n");
> 
>   This gives users another 5 years to fix their scripts.

Not objecting to PR, but I don't get the point of the warn.

In libbpf we have this logic:
#define DEBUGFS "/sys/kernel/debug/tracing"
#define TRACEFS "/sys/kernel/tracing"

static bool use_debugfs(void)
{
        static int has_debugfs = -1;

        if (has_debugfs < 0)
                has_debugfs = faccessat(AT_FDCWD, DEBUGFS, F_OK, AT_EACCESS) == 0;

        return has_debugfs == 1;
}

static const char *tracefs_path(void)
{
        return use_debugfs() ? DEBUGFS : TRACEFS;
}

So it will trigger the warn just because libbpf tries to find tracefs
in debugfs first ?
We can switch the order, no big deal.
What about other tools ?

bpftrace has similar logic:
#define DEBUGFS_TRACEFS "/sys/kernel/debug/tracing"
#define TRACEFS "/sys/kernel/tracing"

std::string path()
{
  static bool use_debugfs = access(DEBUGFS_TRACEFS, F_OK) == 0;
  return use_debugfs ? DEBUGFS_TRACEFS : TRACEFS;
}

In 5 years all these tools can switch the order, no problem,
but I don't get the point. Most, it not all tools, have similar tracefs
detection logic. Just remove automount right now without warn,
since the warn is only noise and churn to tools to swap the order
of detection ?

