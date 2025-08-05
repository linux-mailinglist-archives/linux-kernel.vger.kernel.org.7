Return-Path: <linux-kernel+bounces-756850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 357C7B1BA56
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 20:39:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0271718A3CC9
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 18:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBC84298CDE;
	Tue,  5 Aug 2025 18:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xDSItHJH"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC09295529
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 18:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754419181; cv=none; b=LeVzmk4+BsvwNaWxknw0OJCQxV7k84RV5v1cYZAlhR6L+9OwF/ZEsgAp/zFlyBShKy7v1a5NnR8aLy6qMVL3qrqbdlvOp/99nXyb5p1fHaN0EQTGNzUz+j8oV4c4hlsNZt2RyNQEM0JZmIAvzAW63oWpFUrM0hPS2Aew/iYuCwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754419181; c=relaxed/simple;
	bh=a62SZS2QmpfIUSwl1RF5uI2a2L6OPvvgldP/i+3ynSo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bnkB6qPh4+l36VAg1lPf3rCF+kdHaK0PNasCv9EgcQKCGsW3QyxE1dLKyoQTgNiW8+RVsaa/sBQQ3zvkJkP/cffE0APF62uQCfgl9Bo1/BhxdWpjbGMLhWVLxCYGMo/ybyIJ0dnOulxC19hQA6d/KMMLPzkXeQ32Hv4NT0B+J+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xDSItHJH; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-61543b05b7cso2281a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 11:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754419176; x=1755023976; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8xUxg+pq2PUvE8Vk3KBIOKz0oljMTyiqWMDUeHpQ214=;
        b=xDSItHJHscbloZCMkLETcKJuq47LylFSYr8YN0xrsMGAm5DK9PNeLEFOBg1Cy5ZyPe
         hgh+u+xzUnIH6I9pfP2dp/fyfyrwapsniYa0a2N3BRbYb/EyKoHqNs3lQQYaQtby0aQN
         6Pi1XzK3kqlAIJh6u0KqGxpS9zswBKxsHEgVQwCHGOLtnD51uLOhORfMVOZwVlgamzSk
         oeynl7UrFxRfGUlJaRPNK1Y6rHSqHXuuqfQWcDDjd4auKJQ1nsafhklgAQciAGl87/gI
         pfppAQKjpY36dSNkdIoEqpsAqDyWYMoSBqjBc0wyjR5YEuPxjFgpiVkg6x6h4PfhJlBn
         Ctfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754419176; x=1755023976;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8xUxg+pq2PUvE8Vk3KBIOKz0oljMTyiqWMDUeHpQ214=;
        b=rfp3ZzWphAfxeIALk9oE+vPixNx35XY/Hg5FP/ATcCF4m6vHNuaBVNRdk0Aqi7qFZq
         30gQfi4a4ogWLheuzudVfEbySMeGoNsIKkIvr2OmVCv3FjaancCu6fVrSsrjlECradpt
         Htnx17c3wwqXJ4k0zdIFCctQiJx8MTfF6mUOPqNaU7sCKaU7jbpef+qNKHr9TuT/JSAj
         ZD5RvJiQsZUieRbOb5uzRP29ysf323iQDPdZc+BSWN0CB4f+SxsdjOyEqFMYMyFwYNeZ
         93Z9tRAE75R5UxmPwoaWB/R6QPDlKd8RqXniALBj8zcdV5kJpNXkhDQEK94pQ/zeo5bA
         y6og==
X-Forwarded-Encrypted: i=1; AJvYcCVvZxxb6BvAwhTF1bPPGR4Z+ChWL3D2hF/T5Yo6syriErKM+yPjNgNkDQn8IpDJ4V7BofV3ar0XFtWGiuY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrY3NFHlPL2PZWPOfAF6/OZvddv8Ziwbc80Wbx3pQRxKMPVb7M
	Y0o6o53C1h7vmcWkiJLOZ7rE6iID1F8uBJVZrfxmLtDc7JRV3PngKRIsHkBhiJ35rucdUqo+vAj
	eXTncYK+d34d4FbctyM/Vr4DEvJgICLAZYr4lqbsn
X-Gm-Gg: ASbGncsG2Fnb54Rbx1eWIgkGIJSqgHVV2dvjDYMJHob2DJxcOC5NYrPCW/BF6jSnwSE
	1wEy39CKix5sSdGgRFVA9pmxpsTGpIhJn0KvPLWAZ8BuHoDZaMx1gD2WprHa8i7ZANbkH5iomxY
	dAbUKsEBAmnbWOwRtCpUrI2I2JK/Z20uQOHPZtsPCwmhDTcrjPD442CCEP5QiM6FDLVgLqWVfU9
	D/Hu0mq5MIuCUmacY2h3B61BTU3WrFNShrgrHPWFNBMeQ==
X-Google-Smtp-Source: AGHT+IFy4uCtvmoKREB9xPubyGfQITaTP/Y3zHYx2x5Mjq6NIu7iwEqR3CIj5VJ9+pdXbxXR/6XQYM75C8EoDMNJUO4=
X-Received: by 2002:a05:6402:c02:b0:615:60d2:c013 with SMTP id
 4fb4d7f45d1cf-61795f56174mr2645a12.3.1754419175703; Tue, 05 Aug 2025 11:39:35
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250805175140.241656-1-ziy@nvidia.com>
In-Reply-To: <20250805175140.241656-1-ziy@nvidia.com>
From: Jann Horn <jannh@google.com>
Date: Tue, 5 Aug 2025 20:38:59 +0200
X-Gm-Features: Ac12FXyOYi_qLL7ZLj8tprF4j2V_jxE8BegFfXRvFrXyIiZBLUKoXwoL4IXp0EA
Message-ID: <CAG48ez1wKqyCKZX7J2eJekTuzRshVE2btPEWQEm2hW9Ri46Uuw@mail.gmail.com>
Subject: Re: [PATCH] selftests/mm: fix FORCE_READ to read input value correctly.
To: Zi Yan <ziy@nvidia.com>
Cc: wang lian <lianux.mm@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, David Hildenbrand <david@redhat.com>, 
	Wei Yang <richard.weiyang@gmail.com>, Christian Brauner <brauner@kernel.org>, 
	Kairui Song <ryncsn@gmail.com>, Liam Howlett <liam.howlett@oracle.com>, 
	Mark Brown <broonie@kernel.org>, SeongJae Park <sj@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 5, 2025 at 7:51=E2=80=AFPM Zi Yan <ziy@nvidia.com> wrote:
> FORCE_READ() converts input value x to its pointer type then reads from
> address x. This is wrong. If x is a non-pointer, it would be caught it
> easily. But all FORCE_READ() callers are trying to read from a pointer an=
d
> FORCE_READ() basically reads a pointer to a pointer instead of the origin=
al
> typed pointer. Almost no access violation was found, except the one from
> split_huge_page_test.
[...]
> diff --git a/tools/testing/selftests/mm/vm_util.h b/tools/testing/selftes=
ts/mm/vm_util.h
> index c20298ae98ea..b55d1809debc 100644
> --- a/tools/testing/selftests/mm/vm_util.h
> +++ b/tools/testing/selftests/mm/vm_util.h
> @@ -23,7 +23,7 @@
>   * anything with it in order to trigger a read page fault. We therefore =
must use
>   * volatile to stop the compiler from optimising this away.
>   */
> -#define FORCE_READ(x) (*(volatile typeof(x) *)x)
> +#define FORCE_READ(x) (*(const volatile typeof(x) *)&(x))

So is the problem with the old code basically that it should have been
something like

#define FORCE_READ(x) (*(volatile typeof(*(x)) *)(x))

to actually cast the normal pointer to a volatile pointer?

