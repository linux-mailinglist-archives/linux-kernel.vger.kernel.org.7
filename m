Return-Path: <linux-kernel+bounces-852282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D05C4BD8985
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 11:56:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4F2324E0592
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 09:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50A1B2EB5CD;
	Tue, 14 Oct 2025 09:56:21 +0000 (UTC)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEDF72E2EF0
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 09:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760435780; cv=none; b=Nh+kYXQQwYl5/drGCntdk0PMo4uVpchADA0HD48ve7kBEVgAPhpy4vFnoQReSG6wvKC7Q3YWqJVpqE7x1sug7Rpjrog0UouVweR8IEQOkw+McLX1ytNTiyN1qVWr6gh8Cy4rSy/0JwjtqXLOrmmruTEJ7d9yXa/wp55TXClWkVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760435780; c=relaxed/simple;
	bh=Mpchhi+Fh/IRqTNpL7ycpB6a+myWh9FixXmfhSjVEqc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f9g9u4gfL2yD5BdSPSbhRt3Hk9loBkNvv5TpbhacE9ZCz2BRzhLo/U2+9MwLAJxvbZ/YBE5hkldHt6baesRlReP8J9h9rDDPdbsTvA3sGjnpO1/nyvsSFx1frALl4F5bGkcsxzIlv3rl1wO7M3HKTA9cHfFWtRqmBLvXRlqDWmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-639102bba31so1665548a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 02:56:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760435777; x=1761040577;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PNWrH3ibK1A0oJOgc28AFjo9DlplMc+4m4rED6UPK/o=;
        b=Y01TA/FqwpdIRoIw6SPJG4uHBzcsaCHzq9azRSRKS3mldTXRu6y+xVwt1uoa60CiHV
         I7mLFkVpV3gyPWT5F0zTblSDiEdjjPckVN5t8QNfRNDcOaJ1jWpm+PaUeB36JkB+eIwV
         AoURDDRF+cRknwh1TGjt2pDWeBiUJrlw/Xo9qDiiW8FiOBILxdqYeAvUjsU7IX/Ye3TZ
         Urr+QWfoWtsMnH+OriF1T3l8hbXmuno2nirGmzcaejpx/tiOhp9k2f2CmPtw/RqRq/6t
         sH4yR9NqGi253F6kV87eM2krLKZdFwAqVmb4POVgPNoME08zpis1uJF+OkIL52HeIdUK
         +31w==
X-Forwarded-Encrypted: i=1; AJvYcCWriU8NZyzW2v+A0OtWrUEGzwh8QCpz4QyBR5FCt7m2jRF+hQzmL2Pja4DIjKpQ7Dwmg6c4gjSE4T1Y8U4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGwX5D1o4aZxNssQUSmj6SjA6LyR6yNVU16nuf/IhAWOSkB3EL
	a2Vt0mFpgpzoZ1P1Cp+nHXpwosdVGX1ZiCpS2AbHEHn5PX+UrOWa35Cu
X-Gm-Gg: ASbGncvO2vBgXME2Je/pPQChGVfZCzXGFRw/ew5N56UvS0gZel5ExsD0sZ7OpbRHbw3
	hLzeDyWDBfr93U0Kee/6nyizo7pfuIErOTMZKZ6aQfCHvD8Rt7b420PlDFtu53z8B4k0Np/HP6k
	ZeEm3OzmiiDoeZFpc8p6YOEXIsQgD2ezpvzehEoPQlHFlJQKjKkdYVlWXP7h+eWhFK+BnAETiez
	MdGTv9pzoRofR4kU/brS3VPdcRs9QsG/tj4RZpWzrMClB0wzK17DdVrP85pMsxKu/uDYNS0d6Jm
	bfVu9fG3Xka+ndGgNT+1aRQQBzct18MBpJkCUAMn7+s0fb1Ema+EpF/HYpAKMQAl/dD7z7Yv+Sb
	B1+Q/zrhblVXyQD7pekrOpHjyxanVGgJDOZvYnpFXzIzZng==
X-Google-Smtp-Source: AGHT+IERV23ZXJ/VGs6V6Z60hxYDlIdN22yBbnSFl7QLWOm9hnG+wBC6zXyB7jvuqY1odJXkn1JBtw==
X-Received: by 2002:a05:6402:5244:b0:634:544b:a755 with SMTP id 4fb4d7f45d1cf-639d5c3294cmr24317805a12.19.1760435777006;
        Tue, 14 Oct 2025 02:56:17 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:9::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63a5c133feasm11074887a12.35.2025.10.14.02.56.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 02:56:16 -0700 (PDT)
Date: Tue, 14 Oct 2025 02:56:14 -0700
From: Breno Leitao <leitao@debian.org>
To: Kriish Sharma <kriish.sharma2006@gmail.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, linux-kernel@vger.kernel.org, david.hunter.linux@gmail.com, 
	skhan@linuxfoundation.org
Subject: Re: [PATCH] sched: remove unused cpumask variable in mm_cid_get()
Message-ID: <v3zyf7pp64yd4kakqniq4thjf2egb3kavkwzgoqt6ye5cuqkys@jmkcwst6lrn2>
References: <20251009194818.1587650-1-kriish.sharma2006@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251009194818.1587650-1-kriish.sharma2006@gmail.com>

On Thu, Oct 09, 2025 at 07:48:18PM +0000, Kriish Sharma wrote:
> The variable 'cpumask' in mm_cid_get() was assigned but never used,
> causing the following build error with -Werror:
> 
> kernel/sched/sched.h: In function ‘mm_cid_get’:
> kernel/sched/sched.h:3743:25: error: variable ‘cpumask’ set but not used [-Werror=unused-but-set-variable]
>  3743 |         struct cpumask *cpumask;
>       |                         ^~~~~~~

Thanks for the fix. I am hitting the same issue in my builds.

> Removing the unused variable allows the kernel to compile without errors.
> 
> Signed-off-by: Kriish Sharma <kriish.sharma2006@gmail.com>

Reviewed-by: Breno Leitao <leitao@debian.org>

