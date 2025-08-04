Return-Path: <linux-kernel+bounces-754708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62E9FB19B38
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 08:00:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 107863B4C13
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 06:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A62C2264A1;
	Mon,  4 Aug 2025 06:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TnWiv36G"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 729321E519
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 06:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754287228; cv=none; b=e3OJESMzGJDnqPURxOsU3ccoei48+fIaZdKuzB093y6lmPwwbeuPjP4oQFUMp/PtRJD7D1nn2mncd3l/k8KhcFGA6cUEdpHeR8Zckz6Zo3yK8K1TK4m2tT7S31vFhOFBd8YK2/FwqTL0hzEYdws605uKHziUIQwe+qKttfRt7sE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754287228; c=relaxed/simple;
	bh=CMjSVsnlYIHATz4fXgWOQlWXjlcbst7J2k2mwNhi1Uk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MjAzYMkjQ8DpZcdBbb6vKOPPAKxHo0BWowVdvchys4/CoxFUmtUVCPJlxNxvH1ofML5uaeTUwBAEeONyBZhkPrSnGu9rp/vFfz5MWjCgPgGr374C9Lc6s2/USwUZ9yHnzgNYaIAaF+E6ZSa4MOYv4dhFzyB8zBVBGdY4lj1+rjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TnWiv36G; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-24022261323so53923065ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 03 Aug 2025 23:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754287227; x=1754892027; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GW9ee20vQhs+179oAZihQfxJ7e5GO7cvFv5OZiXPnJ8=;
        b=TnWiv36GJTMN+9LQBBxwj5Xn6WHAy3zy4tIIwg0kjzdME24J3ZeIZAKReLxDuxNlDe
         E/p+rHScsM2OFr4c63KFFV5Qj17x/VKMMpichsnt8AVNW7jbBwhyp1jHLn+TJdQc509v
         AJ3tn+ZLtfDT/oTuBuyejYdGerDFADZYFOioNpK6pj2JDfaOGw4gE8YQJZ8pWBs9bdjT
         W1nJD6QElDxf++YghWNBM4/MlXvyMXuc1UvkCw1pBHDQMdYDcUhwg8RcCmrJ/9Ai/P83
         v4zN2+2BPKl+b4byb8fEdPt2uaTB9MpDUe5rmeIpuGu5PamWm89T+rgYVLnIMwS3xG8Y
         usdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754287227; x=1754892027;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GW9ee20vQhs+179oAZihQfxJ7e5GO7cvFv5OZiXPnJ8=;
        b=srMccOMLUA+Ypqaj2K/eJ1RC1zuyFHe21yaA+gnSDJJeNI6QJ7NdJPLbWEfs/VG16j
         Adrprr1x0cS2F61tPN1Wxm4LPtW70gM6JF5SQ0V/EwqXAD814VbBFp/7HqQjDllibq3t
         KWxACsFiij0MabYBjWINy15VHHfHqea1dtS1r6YWmRqhvWhY+nCHJxSzXSN9SvH2qB8S
         Av/LpVcTLB7Dwpgu9RmbC1MAOXzal0qESVhvpDQKjHDqfFJvPaWaj/W7ehXbF1o2iufA
         xz/aYBKnBMvXUY9suRGSg1pbJuGRaWk2QIdQMnQ0Eto6qqLVZWy/QK5QIat6FBnu6DEB
         tdaA==
X-Forwarded-Encrypted: i=1; AJvYcCWcpCXRB03YGWgRvZlHHDFN6c2YYFizwBCsjMwRg88Q1jRg1VvqPwBnHZfX7rx3xUfX2/yON94iuWrxo9g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxX3pD2w9ZgHgOxjzE7NDV7A+oztDvTnr7+Txqs1q7bdbUkmDSf
	/xWj4RCrH9VCriiLB93fhviorBebN9He1TvnfhbI3ipaxYzoI1530FQRvPAGBhxsRLaGTbEvwKQ
	4Vt9WOchOTtKr1NMDGQP1PRE+tsBt+w659qUXCBvC
X-Gm-Gg: ASbGncto5zkZSGuGYhPbLNpiB/NJQ8jtbQGlzmnaHs8Yrte9lgm9+/TwZ+iVKiPA2oa
	h8zZw5nJxHdEEDKNQ0Poica+UPrbmffhYdLoGldto83SCEHa3DzdrCnWaeebPxuqoaBsXTrumMD
	RV0W25j+X1BQdLMND1ci0B2iLACsc+1YS/toDDSOMzWacDfU9mCkYiI/8oUlVi9UT6FAinZccZh
	J96Jebr6Wls8MXqtZwRKIvk0kZZN9ZV/ZvMwcw=
X-Google-Smtp-Source: AGHT+IGjk2UIBetcSl3cOr+lPMFKsmxl+eJNheNEbJC3BP4ucecQ/KCFqsi7V58RFGF5MsVFqR2tEo7P/NgkM0Cjsno=
X-Received: by 2002:a17:902:8601:b0:23f:ed0f:8dd4 with SMTP id
 d9443c01a7336-24200d7d3a1mr165647385ad.23.1754287226255; Sun, 03 Aug 2025
 23:00:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANpmjNPWzJZrAFT3-013GJhksK0jkB6n0HmF+h0hdoQUwGuxfA@mail.gmail.com>
 <20250803180558.2967962-1-soham.bagchi@utah.edu>
In-Reply-To: <20250803180558.2967962-1-soham.bagchi@utah.edu>
From: Marco Elver <elver@google.com>
Date: Mon, 4 Aug 2025 08:00:00 +0200
X-Gm-Features: Ac12FXzqJppzOFmhwA4bjarsTDBlyoRY0yvvampHjfyILSAANQCwWK9R6F2pkOY
Message-ID: <CANpmjNNvsJ_u7ky+d1tiXtwc-T3z6VB4SiMqpo6aKWBBFO3ERA@mail.gmail.com>
Subject: Re: [PATCH v2] kcov: load acquire coverage count in user-space code
To: Soham Bagchi <soham.bagchi@utah.edu>
Cc: akpm@linux-foundation.org, andreyknvl@gmail.com, arnd@arndb.de, 
	corbet@lwn.net, dvyukov@google.com, glider@google.com, 
	kasan-dev@googlegroups.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, sohambagchi@outlook.com, tglx@linutronix.de, 
	workflows@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 3 Aug 2025 at 20:06, Soham Bagchi <soham.bagchi@utah.edu> wrote:
>
> Updating the KCOV documentation to use a load-acquire
> operation for the first element of the shared memory
> buffer between kernel-space and user-space.
>
> The load-acquire pairs with the write memory barrier
> used in kcov_move_area()
>
> Signed-off-by: Soham Bagchi <soham.bagchi@utah.edu>

Reviewed-by: Marco Elver <elver@google.com>

> ---
>
> Changes in v2:

Btw, it is customary to send out the whole patch series on a version
bump, even if only one of the patches changed.
https://www.kernel.org/doc/html/latest/process/submitting-patches.html#explicit-in-reply-to-headers

> - note for load-acquire shifted to block comment
>   in code rather than in the preceding paragraphs
> ---
>  Documentation/dev-tools/kcov.rst | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/dev-tools/kcov.rst b/Documentation/dev-tools/kcov.rst
> index 6611434e2dd..40a4b500073 100644
> --- a/Documentation/dev-tools/kcov.rst
> +++ b/Documentation/dev-tools/kcov.rst
> @@ -361,7 +361,12 @@ local tasks spawned by the process and the global task that handles USB bus #1:
>          */
>         sleep(2);
>
> -       n = __atomic_load_n(&cover[0], __ATOMIC_RELAXED);
> +        /*
> +         * The load to the coverage count should be an acquire to pair with
> +         * pair with the corresponding write memory barrier (smp_wmb()) on
> +         * the kernel-side in kcov_move_area().
> +         */
> +       n = __atomic_load_n(&cover[0], __ATOMIC_ACQUIRE);
>         for (i = 0; i < n; i++)
>                 printf("0x%lx\n", cover[i + 1]);
>         if (ioctl(fd, KCOV_DISABLE, 0))
> --
> 2.34.1
>

