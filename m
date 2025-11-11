Return-Path: <linux-kernel+bounces-895363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EA12C4D93D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 13:06:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E21B518844AE
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 12:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADC66341650;
	Tue, 11 Nov 2025 12:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="T6MBAlE9"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB16273D8D
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 12:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762862621; cv=none; b=NU1Oxg8Vs66I6yAaIOKWzMFpFPAfNFVMo+4yqL2c/K/jUVA4tCzvR/tRWwtxzER2o5ztWO5YFMXsz/lAQgGsus4J5wkE2ZPieYIMQ4+fhxhCXwbw42SW8kObOTMS6+D9wO5ZnGIPkhNnnY/yBQedvcR0/Xkrc7VphjhzN8pStrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762862621; c=relaxed/simple;
	bh=i5kTeJu5utIxHsxfwz0A0kB+pA68IurFxsSvc3yAIvg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RbflsiGRtNMNWDLM/K0pBt8LFWq6bzFgtplmMgfPlJodtjyu7ITdwcby2/ZXlbesk8yj9Orz6IPph/IE7QyEkcvijPaA+Byz1l6/OtqHnbmXdJX3PJPou0h6kNyjt5EgWsNAgdOoiZV9usGPvvvGqlr+YznioVRvTwGG1gbFnew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=T6MBAlE9; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5945510fd7aso3125605e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 04:03:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762862617; x=1763467417; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KljB7KA8H9UEbKdOlknFY9ShE3Ul6YXvW8YhMZmV7dU=;
        b=T6MBAlE91+fR68qvC+UI39dl3Pl0ZCzXXH3CkPNvz3jI0Uu/5CmFmf2wRRFMRe/27D
         0lSuOEiKfwudDoLLObQgD8s1CbXSE2Mc79MMoWLmBkyoYKliikrZz2PkvQgKPoTnncoq
         /Grhzag1mImY5RKEi5CiLshDejVjYQmgjtq9DPQXIlyu6fy3ynnS62cqbMvejM2EeC0x
         d4KL/7gTv94xq8Srub29vYtyK7ghb40ldcWkG1+24pa8eZc0NdY8MKLIasGnYOXEwgwA
         LGNTkUNUr7RXy1UMFO2OKTirCwcc4ig79VAHGjZvwxQZc6pctFKTiOSxEUnoynq/v+4A
         NPGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762862617; x=1763467417;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KljB7KA8H9UEbKdOlknFY9ShE3Ul6YXvW8YhMZmV7dU=;
        b=NsMXrPnhVcxmVp7rL+UaP5YJGDQaKc0oMYIsMIyLVG4i3sv8rG5+XBuOfD7gN67c8N
         x7OqBUzMK76pf9W61O870H5t7fCi0HIWdxJnAU+/SHBOmkXH7b0hWF2F8jsamPTbygyT
         MRW6wufeZCy+R4D9XCp17ilOxRJzojjJUWyw/cPiLDQx2TkDmAXZHlEAfzVgyeAzuXNs
         m4MDSE++xigv80tbbU4QSsqVc6EB5NMuhICVbot+qnjYFrghg61wJBicfjZqwEbNQ5fE
         Mk/wQK2eB4V2Chr2s65+ZF1tutRc++r6bLBux1vgKdQnRB+Sn23t9lI9lXrLJ/wq0QdZ
         ln2w==
X-Gm-Message-State: AOJu0YxQW84DaW7pSf9HoW6yiawP2wDWtmNGnlzCD4IauN4xFLZIJjS/
	uAsHFaGVrLVgBXqOlLa45tkOG5lgZt/7G72qtOetrlFvrSXTV6uFaFwAz07AYpD2S+ETKAzarVg
	oACTc6jkRmNPLY1qbkDtbGFJT98NVSJNkPuHPaHvvFg==
X-Gm-Gg: ASbGncu/3kG757mwb0Mc3DcwI7dgwNrXNXwvLi5QGuYQC4xOmIKGnWXxSdtSQp8eSQz
	utTY3PxQSqTiSZT4p5qqS+MON3kbDit/g5fiCeSuVVHMMaz6d6eWBVyfd1Ua9NaaH4qMo+5qSB3
	vyrylTnYILWV6kouOiIAoRuVxmthi+hcRuhlYhWSwtr064g49r3xd0r+IkOvhKrDVcALLgh6B4w
	XzI5QAJzNo0/j01mPM0ZZvJ9/7wV1TaayPlVNV4riFHpJOBqdnpi2ebb4QyJ082BHAyqXXolMsX
	g54eUBix4gTFJWCGQ+p35rKI8Uaq
X-Google-Smtp-Source: AGHT+IE79G5EhyzCGFO5KShwUVwQMKTk9DLfvtXgvYUrm3xN6l8t83Xw7QhBO96Fv1jh8YdyD7Y7DE1SL12Jvgo2IgU=
X-Received: by 2002:a05:6512:e98:b0:594:2d64:bce7 with SMTP id
 2adb3069b0e04-5945f14610cmr3166689e87.11.1762862617351; Tue, 11 Nov 2025
 04:03:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251107152950.293899-1-marco.crivellari@suse.com> <176286176938.477075.17121782345964029950.b4-ty@csgroup.eu>
In-Reply-To: <176286176938.477075.17121782345964029950.b4-ty@csgroup.eu>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Tue, 11 Nov 2025 13:03:26 +0100
X-Gm-Features: AWmQ_bnOYD56Kc4jcqB1Td1b1Q7AnUCQFEmxY7td5AXiEMwVkgsUHWrdJFOKphU
Message-ID: <CAAofZF6OnMGid8T=gSezk4YWJkZsET4VmFcbCVTzQU3HWHsUgg@mail.gmail.com>
Subject: Re: [PATCH] soc: fsl: qbman: add WQ_PERCPU to alloc_workqueue users
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Michal Hocko <mhocko@suse.com>, Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 11, 2025 at 12:51=E2=80=AFPM Christophe Leroy
<christophe.leroy@csgroup.eu> wrote:
>
>[...]
>
> Applied, thanks!
>
> [1/1] soc: fsl: qbman: add WQ_PERCPU to alloc_workqueue users
>       commit: bdedc7414642e9c3793933d43b72c67f3b7db326
>

Many thanks!

--=20

Marco Crivellari

L3 Support Engineer, Technology & Product

