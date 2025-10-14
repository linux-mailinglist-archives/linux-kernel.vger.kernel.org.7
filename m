Return-Path: <linux-kernel+bounces-852419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68029BD8EF7
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 13:09:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88853425B3D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 11:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00D8C308F15;
	Tue, 14 Oct 2025 11:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="H/02+A+J"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A67CA3081B9
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 11:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760440127; cv=none; b=jRGV73wkfA6NBRXemx3O7VwWux/jmuwpB9lbvsuvYsHe18WyrCxocYZVUHZF9IKwq3ABQXYFY3/YI8eZNMRQ6KuDGzeRRBuZvtKuzI9Qzv1OZ3mGZAENk1f4gRYSF6R4xSzl7EfIuz9Pc2dSoc50rFtcYFNJ+6y3Rkw7mfSsox0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760440127; c=relaxed/simple;
	bh=P+5GauTt6GT2A5ICewQhAYJjsy2WOR/Fp4RhjgMbv+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hpRu9k+TNIfMtNyO3RnMy6AoommwySscGC9LoJOF1fjCPuIIXGPQjtvBeSH4aoe6WnD9JtogtubrV7dMyolmY8Huw6rHU9TStv41C8Jk6tYrRBUSm5qXJ60KaMBXA7YwMBD0yNlRw6mqxMC6nvRPQkgjvJqBp2hqdccz+Z3g/4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=H/02+A+J; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3305c08d9f6so4231778a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 04:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1760440125; x=1761044925; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kIl7+t2byU2rLxGt9Fvez6I/u2Ic/lM71HIRdn+BxNU=;
        b=H/02+A+Jy1afx8MazniDdIkPUcfD3mozlAvQd3k00bvcAnKT9uWCcdBtRjpainlonI
         nyAN92GepjCoe20RpotEEe6h3gac/V13RTXHleFFcU3pMqUJsAbm9vygupmOdlWwS2FE
         JcdBE7DQ0/jjuceG3b6B7zWIaUIecCrDSG6gI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760440125; x=1761044925;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kIl7+t2byU2rLxGt9Fvez6I/u2Ic/lM71HIRdn+BxNU=;
        b=PeMkgiS1oIIXliz9w1uhWCgtgsaXXiQDsQb32bp8/YxDB1Hn/y7atzMlY0tWlhVeP2
         5LbWOVM8DKPhSVPz//WqQrTxyE+1pQOqWTr0Jj7Y+S2fUYUxzrKzruEZjXpBaZw/0eTL
         V9YXVPqST25AlHeAQB29GwmvEHmwTlAMUlUUoKOaSkX/lyWDL/UjNz0Ngg2x7GuI4EUv
         MOa7ce3nCTlGfJ+R8MOHoXX8nxWJIqGV4ginUl74D1QQtA66xZLvPtlKQbMk4t4jVFgT
         7oV5UCrhJP9pUt0ICezZVDWiI3P1LDToUks7jdjiJcMBp3tkvqZxYsO//Yk1OfKSc5t7
         paJA==
X-Forwarded-Encrypted: i=1; AJvYcCWc6G9FzaBpASQqt/eDUd09PYhJjGFoBs6LFMuXZiHMNdeb6sW+TM/rUpAe7joierBrPHosKzX84Yx+e5U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9vk/yCd1WTq4Y3zerS/J/5rQvDvE6DPeZSejQVcow1LpSmiOy
	Ls7LSmZwlTWONA5rXzQSLEhcTazZ3QiL38mG8Y/vvmHvszh5db/zj8PGCHN1kWeR+g==
X-Gm-Gg: ASbGncv4WxZcc01TMaSOrcDYF1UlS7PwlhzKk+G6gSGhCAXi19zJImhhiW7Gvjdg/Nr
	tvadBMxhw9QIUrWl8p7zdOMLOiESsIVNKJ1nWjhJd7mdhn2c4JC8fZgWDi/a3lBy+XS1Sh2skA+
	yvr9Be4pgptfSpsvSUmvUqtAeo0fRuRv8Vxp94NLJzJH1E9M4YJNxmB3mYv+nz81RirDYg6MRgk
	Nt2sL3nef1wdLdkLwTv8g8yglNSWgWPjWSaO1qfCJo6QLzE7ogeSnfrMuvS1x5rf1JmOmD+S8Ke
	qxrxvuRYwH4WZhLmbVVi9fALeqgYazyjgAYuGMvbJRua0CduIKPRLJscoOtGUD1oomys7s9NZUP
	ovaQfNcbmdyI3X1boV1FtZ1jax61Aac5sSCUr6h6bs2KTY+KdhbHd7A==
X-Google-Smtp-Source: AGHT+IHZp5MLtuj8aEbRYmVAG30fR1mkEeXUfh1F7/djMcG98/l7AMsS3SPYvh8TdHqkm61PdymDQA==
X-Received: by 2002:a17:90b:4acf:b0:32e:6111:40ab with SMTP id 98e67ed59e1d1-339eda4744dmr37545449a91.3.1760440124929;
        Tue, 14 Oct 2025 04:08:44 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:f7c9:39b0:1a9:7d97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b61a1d386sm15642214a91.5.2025.10.14.04.08.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 04:08:44 -0700 (PDT)
Date: Tue, 14 Oct 2025 20:08:39 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Artem Bityutskiy <artem.bityutskiy@linux.intel.com>, 
	Christian Loehle <christian.loehle@arm.com>, Sasha Levin <sashal@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Tomasz Figa <tfiga@chromium.org>, stable@vger.kernel.org
Subject: Re: stable: commit "cpuidle: menu: Avoid discarding useful
 information" causes regressions
Message-ID: <gl4gcdqg4d7kqvnbmo3vuymdzcxjoi3qubgaiuu4pzlashxzjr@z7fqi3lek3e7>
References: <36iykr223vmcfsoysexug6s274nq2oimcu55ybn6ww4il3g3cv@cohflgdbpnq7>
 <2025101451-unlinked-strongly-2fb3@gregkh>
 <zfmoe4i3tpz3w4wrduhyxtyxtsdvgydtff3a235owqpzuzjug7@ulxspaydpvgi>
 <2025101421-citrus-barley-9061@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025101421-citrus-barley-9061@gregkh>

On (25/10/14 10:02), Greg Kroah-Hartman wrote:
> The point is still the same, commit fa3fa55de0d6 ("cpuidle: governors:
> menu: Avoid using invalid recent intervals data"), is not backported to
> 6.1.y, it is however in the following released kernels:
> 	5.10.241 5.15.190 6.6.103 6.12.43 6.15.11 6.16.2 6.17
> so something got lost in our trees and it needs to be backported.

I can send a backport for 6.1, unless someone else wants to do it
(or is already on it).

