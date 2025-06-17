Return-Path: <linux-kernel+bounces-690449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B16C1ADD0D5
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jun 2025 17:03:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A52C21669D5
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jun 2025 15:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F2BF2E7F0F;
	Tue, 17 Jun 2025 15:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="EkwSVAMl"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7646B2E7626
	for <linux-kernel@vger.kernel.org>; Tue, 17 Jun 2025 15:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750172597; cv=none; b=WSkm13Igit5gPMUfCVxw8IIKI5r2aJuphE+K5/rSKs/2qSxtGsyIdl9QoTPv7vSTa3wNSVMnyXoKPHLqc8pHUd0rcuIiRdFuCG7XqwpkwJSOXpeaTpx6zL54oLmnhqfHpeBPJ2IdfivW1zaeOVARwRuyB0NUBktm3Fq0GfdsBmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750172597; c=relaxed/simple;
	bh=cBM0bl1EYdw9m/LmJstocm95QTHjddRw6azuJUPFwDU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qE9GfHFoictIX63v/x4m3fURuLzDgvGr6zaxPZtZs2ggTDJIthGc6QUCKKep5jROuJqXh0MtKuFd6YjPCDlz+d9TvzCuH9RxWf/y8iHeJPO4UVxAhW9GE/E7NJCxdDnWmdMt+q6B/B7mUUB/hUClhgN/COqxZx771Y9/Vza/Cdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=EkwSVAMl; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-551fc6d4a76so5690121e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jun 2025 08:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1750172593; x=1750777393; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8kro4RJTLnz5wiZbHdQt1ebP7niZRblh94LfQW2yVq0=;
        b=EkwSVAMlRBSjPuoOcaegUSjDri7TcwkfKlGbxzHLxsNqdFQYhf65Gysr5/tcshqAck
         w632tqJ34b+XmkddFD8zusqZvw48kyyA+1+DIJnOvY0+iq7G7j74P882Br7/n1hgC89M
         dhxL7Qoo0F+qdb/mbXIB8GGgIU2VfxnfyFXykn2I0UtfvTWJtk8tCfcCXxp6Wkc0dxRs
         ZZlduppDxt09Azdbtgf9bYaU2LKHtZOLDOaQ5DZYfyUCRqNZ4K1YeTZKfhU4IzoOLzUk
         9rjwiVG9/efaGh35N8pSs7uLhER4tVbKN2hzKQKUg1x5ADTHHmU1FzkvyzRXPn2owuk1
         8WyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750172593; x=1750777393;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8kro4RJTLnz5wiZbHdQt1ebP7niZRblh94LfQW2yVq0=;
        b=dCv7XxOoEH0+aip4uAq/RNH8lHIE6+31+7A48w2pVIuPSBWw4onaLFhHkBE5T33/Rl
         xFBfheMru6Xjc8X3mQV0/7AHQEAFnOQBXC5vyfFo+rPprqrKd0wcf7LKbBEYEtABkecL
         LwaMYl6woz8otsQxLXHSB3HOigUUEeVN4gKir/pfzYT3PZVtjKgFFr1cjDRXR80iY/pq
         3EgXkVpcbTB5nNtHc5V0Cx+M3hH+gvbRkQy0cJuGbvuaYMbujNdwlgV5ZBS67Qbyz9pY
         Oss8PR2Ud5lVmDVcvGTvXu8XzeFFy28d/tZSbgQLlD0/y+9YPQHfle4k8wBrAJkueJM4
         2tvg==
X-Forwarded-Encrypted: i=1; AJvYcCW515I8yuLgsD2FZVkMbI812JsWgWbNS/5ZPHBzM/VkilpiwUx7nSLiSNXDH2EYiCwZN1K+jorRsgHp6qc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZFK2yyMWG6PFecnArBT+xiJ7LRdAwTA6TE2Gn7dwHfmTdZiC4
	du3vnrJwbE40xPoClO/NCaCf0YAr0uCHMKagT11vfC444yr5qsczjfSDudy7XHqWn2E=
X-Gm-Gg: ASbGncsdcWR0zErlnx6H+ACpakbH/vBgIDdXf5DzWZH9Md4/82m25WU9Zof4qxW/9+h
	ZEvyD3+FDwJWsWBteMnZ7AhjYMMUzMBvJ4hunSee1O7GQSRdB8Dq6HvVwGEO10xZ0K9xu7WmjpW
	SLbVMyNGOPwl3GBa4ArQdort8eFGW+tCdtHsyOHNKESlKL+0YPmmVyzp14C06JCQia3kN27kVDj
	XP1KLHrIIbqPsTbDabEgti+BORYZPM+qet7eDJly85guT6oizwFqKn+XbWyNRluRnzL3EmFa6X8
	H4oEOk41SMwBK/NG8f8c6ErzcvD8KOLVgbdc6r4iNk57a0q3cYM0vQqIH3ONha2J
X-Google-Smtp-Source: AGHT+IHT9POn8wjfJ3yL9wa7ePb4/upFX9M1uvkh2r1EA9oSU/oPblXzyWWBgyX0wBY3kJqvG2nMIA==
X-Received: by 2002:a05:6512:104e:b0:553:510d:f464 with SMTP id 2adb3069b0e04-553b6ee29d9mr3569632e87.25.1750172593026;
        Tue, 17 Jun 2025 08:03:13 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365deb4e27sm81250535ad.176.2025.06.17.08.03.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 08:03:12 -0700 (PDT)
Date: Tue, 17 Jun 2025 17:02:59 +0200
From: Petr Mladek <pmladek@suse.com>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	John Ogness <jogness@linutronix.de>,
	David Gow <davidgow@google.com>, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3] printk: ringbuffer: Add KUnit test
Message-ID: <aFGDhxefzuWCwOOV@pathway.suse.cz>
References: <20250612-printk-ringbuffer-test-v3-1-550c088ee368@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250612-printk-ringbuffer-test-v3-1-550c088ee368@linutronix.de>

On Thu 2025-06-12 08:29:07, Thomas Wei�schuh wrote:
> The KUnit test validates the correct operation of the ringbuffer.
> A separate dedicated ringbuffer is used so that the global printk
> ringbuffer is not touched.
> 
> Co-developed-by: John Ogness <john.ogness@linutronix.de>
> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> Signed-off-by: Thomas Wei�schuh <thomas.weissschuh@linutronix.de>

Looks good to me:

Reviewed-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr

PS: I have got an idea to count the number of failed prb_reserve()
    calls. And it really failed from time to time.

    I played with it and came up with two more patches. I am going
    to send them tomorrow. I think that we should solve it separately
    to avoid too many respins. The current patch is very good as
    it is now.

