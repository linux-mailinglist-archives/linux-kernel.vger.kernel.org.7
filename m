Return-Path: <linux-kernel+bounces-777620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D32FBB2DBDC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 13:57:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F8155C3EE8
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 11:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E6492E542F;
	Wed, 20 Aug 2025 11:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="MPDCSZYG"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC1F2DA775
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 11:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755691022; cv=none; b=IVDtThr0OGzJcqTGt64PScI+WZgh4yPRscak9gl3LMbj7vTw1JV5JG72NdxUUh9Wn9Z9+wBaY5SA3pML8Qe1mkaiCztDbq2TdrqtpwI0XJZDpcHTdz9yd50blJC7/YwOJxiNiOAPVTdYv3QPiyl9HJ6pKveOJZA0GAp/x3cV+YE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755691022; c=relaxed/simple;
	bh=cYaIwa7OKDucApKeRVWCFfec6pzGvS4Cc/Uc55pPyp0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kze11ca+u3GRZOrAK+4zD2eHBWs7Ug2YtRHbHg0VERAwfqROOuPy+jaUzpVavMsBHfci8Cg78vgR9r7KCX6Q7zJKpI0F2fX2Yf/Pg8EMCfBO1uXOguDFwoa0UZRYtNFbpANXdQnBPBtNSfWNkUS4TOSl0U6hQ4u1Wl/VfB7c0AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=MPDCSZYG; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-afcb731ca8eso999803966b.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 04:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1755691019; x=1756295819; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=moCsdLjCmUX6PvbdLzVPGIybOfeYotWGYwXLJgkQHp4=;
        b=MPDCSZYGKuKjPbnTkoV2UzJdGYHBV/gjr5NN+Hh2NJeWhxnSVRMER+ZnJILmq4cv5s
         YzZxzb5l4RNEZ+BBKjMIEzSlmkLcjMk3NHIbentsmMGy6Sh2NycfCwqD+CLIOgrJRVs6
         NZWYZg6AwgJWuEcZ3BPTbwrYN7cMdofXR1Qeono7tiu9qzHjpgez87aFb785knM3byLv
         XmWgFOes8k3Beoaag1erxCwtR6o1u3aTGtnNpSNSXAUtkhctZyfjENbdkg5mmC5uYENs
         uEQkFnuVI6rxSkgzPlFndpF3kQeaRdcDWodaahdBWd3CR/GZk2tFV6JDR7tlWcPP/VqS
         06Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755691019; x=1756295819;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=moCsdLjCmUX6PvbdLzVPGIybOfeYotWGYwXLJgkQHp4=;
        b=wAhCER4wq5MqA9dtwNZM03fyRzSOOKiKWhkLXbBmw2z6vqt+1A4Fwo8+JiFq15pqKr
         z+E+V4ZzKRu2zA7z/fyFPiTfcnkZAdkx0rf2wMvYSdIgSWdBoTuvKhXo72EiGBC6F7JY
         ONRVQYt82aBgIlk6YOg6/u7qzuo0qGcsZM4DJ46FLTMEtjS1NUEqPFLl0JPfg2T0iNCb
         v5fIy//WXOH26AsDM587CfyzFpsoJqBaiPE4gApRTzNZyMrgnDmIHMwdIsoPKvi1sw6a
         uabq7cHkTICCHHVCD39c0oUKoKjXJFbOV2Bx8ttbMoi9wzJes6VZGXB3tav+Fan0XYfK
         HMAA==
X-Forwarded-Encrypted: i=1; AJvYcCVKgKs1AlUlqPGhYxpp69/ruH2aacl5jfWexdrY2pBEQ8IsONzOqm74kXf6wqAVJifC6oA1P/VkJqSHzP4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzh3R5UVYvL0oARvlG7F87Q670cXkWIltBpxjtI73E51IzvD1mn
	9WnwjMQrMnFcAYRvZaXj3vgHu0bx6yDjpOyHexT4Nq7kWfCPj29N42RmUEn/bZqCUnE=
X-Gm-Gg: ASbGncuOuJ+6uPdX92Iv1Yy1OnPIjVRFXyPUm7aSev9Cvu1a9XY+nqCmXHauZXC7fBJ
	zvyHY7aNdotYfMHN18IRwc7HhX07wD3eKoPI9etQis6vr83TcirbG7VpSzUF45XiGyuknxEhdl/
	MVGEcjVyGfQQar+PThHhUZCAG2eWCwupP3KEO5MdbAgjsPDjfIO2ZYCEIoNCy4iycT5h7Uckw6L
	x5gGHJYupsm4I1zlW1DSsVyJ4l2o8ZKkIUmgHjMB2LsSjrmEGunA9Hgk6wCpu5P/bHlUbz2kwfg
	el/1PENUP2broLplcz3KEA6Qzu+FyiFAc4ArOfHK9JhPHyDvxdZVLNDwU4melkBSHWqj/y1fdyS
	+KMzQo2V47Wr0OHu9mIV7d02fs/ym6eMDy68h
X-Google-Smtp-Source: AGHT+IH8jGgP7Yi06FTb3TEFxWNfS8BaL6kBNZrhzOIwS6IMpjYfsgVAKJNdI/w7l343iLu7BzJvvw==
X-Received: by 2002:a17:906:7313:b0:af9:e1f0:cd15 with SMTP id a640c23a62f3a-afdf00a90e5mr214610866b.18.1755691019015;
        Wed, 20 Aug 2025 04:56:59 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afded2badcdsm167984366b.21.2025.08.20.04.56.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 04:56:58 -0700 (PDT)
Date: Wed, 20 Aug 2025 13:56:56 +0200
From: Petr Mladek <pmladek@suse.com>
To: Ricardo =?iso-8859-1?Q?B=2E_Marli=E8re?= <rbm@suse.com>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, Jiri Kosina <jikos@kernel.org>,
	Miroslav Benes <mbenes@suse.cz>,
	Joe Lawrence <joe.lawrence@redhat.com>,
	Shuah Khan <shuah@kernel.org>, live-patching@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: Re: [PATCH] selftests/livepatch: Ignore NO_SUPPORT line in dmesg
Message-ID: <aKW4CApORh7o73nz@pathway.suse.cz>
References: <20250819-selftests-lp_taint_flag-v1-1-a94a62a47683@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250819-selftests-lp_taint_flag-v1-1-a94a62a47683@suse.com>

On Tue 2025-08-19 14:37:01, Ricardo B. Marlière wrote:
> Some systems might disable unloading a livepatch and when running tests on
> them they fail like the following:
> 
> $ ./run_kselftest.sh -c livepatch
>   TAP version 13
>   1..8
>   # selftests: livepatch: test-livepatch.sh
>   # TEST: basic function patching ... not ok
>   #
>   # --- expected
>   # +++ result
>   # @@ -5,6 +5,7 @@ livepatch: 'test_klp_livepatch': starting
>   #  livepatch: 'test_klp_livepatch': completing patching transition
>   #  livepatch: 'test_klp_livepatch': patching complete
>   #  % echo 0 > /sys/kernel/livepatch/test_klp_livepatch/enabled
>   # +livepatch: attempt to disable live patch test_klp_livepatch, setting
>   NO_SUPPORT taint flag
>   #  livepatch: 'test_klp_livepatch': initializing unpatching transition
>   #  livepatch: 'test_klp_livepatch': starting unpatching transition
>   #  livepatch: 'test_klp_livepatch': completing unpatching transition
>   #
>   # ERROR: livepatch kselftest(s) failed

This seems to be a SUSE-specific feature. The upstream kernel does not
even know the NO_SUPPORT taint flag.

This patch is not for upstream. But we should add it into SUSE
kernel sources.

Best Regards,
Petr

