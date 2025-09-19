Return-Path: <linux-kernel+bounces-824802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B3C7B8A2F5
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 17:08:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4E9F16741B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 15:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A47083148BE;
	Fri, 19 Sep 2025 15:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gn6vO+nL"
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85CC93093CD
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 15:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758294400; cv=none; b=seBtnp/p1sIj5vdn8QwVKL3EdnGEtC1LZXB92XVrdPNreKjCYgGjwIyWtMTVGvAQnWyEDUz+2Uw/Sh8fc8LR8ZVrX8YlLFs+6U8J4jkX8RnJnBA4j0dmSnsgqA0upRdY4LOx7Z6XnfA+by/OCn6kNkV8caon9GVUurjpFO43Gq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758294400; c=relaxed/simple;
	bh=wq2abhQipyX+QwuDbNp6dgczc/zpKuyCE998M/az7IY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZRz404RK2Xtw3+JS+cuh36AUlagXbUsp1z1X74YteHXjRRVNyR+WdebFgpSsznXPU6M3aUX30r8I52ZUWryzsnumeRg88tvaS4ilx4AJFOFGYit4uyWK1njrQHdv01QUbhPRfP+4ObudO78+s5pZwrp7TkR/3BI5ePCmwaOozug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gn6vO+nL; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4b5eee40cc0so22114351cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 08:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758294397; x=1758899197; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wq2abhQipyX+QwuDbNp6dgczc/zpKuyCE998M/az7IY=;
        b=gn6vO+nLjJcK09NnVY6/EwXtc16UAGnom97Yds9I/gU/ZLFI6sZ2tV9Xq3MnfoHptY
         91dXILumQnl5QQWy7hr8ePI5uSVWT8m1uWxjYJ7QWRFX+mewd+dftuP8Hkn9FnxwUKIK
         AkQxflKQ008azAr6BUEHd46tJdaZX5akIAadsZC3o31fynecKgKc+KtNpvAy3AWEeHu1
         Cz2bUrWobkBPYc6XFYTnpBeypSYurZrOQ8OrFG+lh3wQXTWa2bDaBUOruLXKryxFefxn
         KW4GOWXlL33wQAyAZiTpkmSaxuozS8ak6hn50PdQkpojRaPGfW10p+n0vzFOnSvPT4zZ
         f3Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758294397; x=1758899197;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wq2abhQipyX+QwuDbNp6dgczc/zpKuyCE998M/az7IY=;
        b=G/Hu3KkrUlSCCZLRPKPt7uRZNj4boRnQFGZNKfQxlsP07rXVBjL0hjNIglvkEZjkPx
         YjZtBjQVi36+K1gACfChCGLvfqeKq2FdiH7/kX6sG51aT9ggoO8vSsut9kbeP6J6lt2S
         32+rM9PxG3jJfT8DxPW1n9bQScHZkqpnbYq434swGeeiep8UWTOvUrsfq7PE0wI2KRlc
         PtWkXBgTSyl1aVfjlPlzoWubeylzIiz8erpV5nb4bhfRqm+rJznQiCpbhdukIAOklY/i
         w1mLjXBiVa8Z1SfVAs23jBEW5phOL+W6DuMq2t2X4E6Ow/mjGp2/Ut3ASIREZo5jY5uN
         ll+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUEct5jq5XGNIT2ZMp3npz4y3YCvVBuMlagV4XwBI+xnkI17tmFTU4xaWoKlEMs2p4nPvZ830iwdz9n4ak=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEQNl7tcZsNliAL6SrePdzITKHmj2qa+5gYYSV47OIyOJe/OPu
	zU5eHJAMFQngzd/1Yz3XLDFjPJAhaZQ/HHLHmLoZyw8tH8L0Qc8MikkU5yDFor9f+I3dazDPV8i
	HppvYXwol3T6CD2b/SwvcpRK1/CvdZFBqlUq/1yHa
X-Gm-Gg: ASbGncvXxy0K3F3E9CcyT4v2Dd1Av4H9re8A3nP3kq1Y4FFqFYTKSFzc7naE+GpGw/X
	DCRK5lo4kc2DWj+2RbbcE0J3HhUL1X6DKK0NKSauaiFZtz7yL+xLgVW9eiWW+wijuO/RQC1/Dmb
	8GhrZNVvHYLUJIIVhFj9qLxBjXgJjSqVu8itUOsQfTE94Ca6kmmTTtoZx4FwotYz7N5Jip/7LJz
	Pg03G/ndPO0T2TsFXcoKMqayWgYz9pdLf3HJw==
X-Google-Smtp-Source: AGHT+IHAZGtVHgR/T5vgwj/kVG3d+Xvhn85HcOAqMoUr6UVAzkpi/OktlLCwoHTesoJWJTkkDQIa4OfoQDwjclHUNCg=
X-Received: by 2002:a05:6214:212c:b0:798:acd7:2bb with SMTP id
 6a1803df08f44-7991d54f750mr32395906d6.51.1758294396642; Fri, 19 Sep 2025
 08:06:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250919145750.3448393-1-ethan.w.s.graham@gmail.com> <20250919145750.3448393-5-ethan.w.s.graham@gmail.com>
In-Reply-To: <20250919145750.3448393-5-ethan.w.s.graham@gmail.com>
From: Alexander Potapenko <glider@google.com>
Date: Fri, 19 Sep 2025 17:05:59 +0200
X-Gm-Features: AS18NWA5Hk_dVmA1agOSIAGh1dzuifFPUnlHCTY8eojJWXc2mgupvfI9rEJhlqQ
Message-ID: <CAG_fn=VXNBH-1QDAy+xR_ubUr0rZxmPBpFWov1y+7a65-mtGmA@mail.gmail.com>
Subject: Re: [PATCH v2 04/10] tools: add kfuzztest-bridge utility
To: Ethan Graham <ethan.w.s.graham@gmail.com>
Cc: ethangraham@google.com, andreyknvl@gmail.com, andy@kernel.org, 
	brauner@kernel.org, brendan.higgins@linux.dev, davem@davemloft.net, 
	davidgow@google.com, dhowells@redhat.com, dvyukov@google.com, 
	elver@google.com, herbert@gondor.apana.org.au, ignat@cloudflare.com, 
	jack@suse.cz, jannh@google.com, johannes@sipsolutions.net, 
	kasan-dev@googlegroups.com, kees@kernel.org, kunit-dev@googlegroups.com, 
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, lukas@wunner.de, rmoar@google.com, shuah@kernel.org, 
	sj@kernel.org, tarasmadan@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 19, 2025 at 4:58=E2=80=AFPM Ethan Graham <ethan.w.s.graham@gmai=
l.com> wrote:
>
> From: Ethan Graham <ethangraham@google.com>
>
> Introduce the kfuzztest-bridge tool, a userspace utility for sending
> structured inputs to KFuzzTest harnesses via debugfs.
>
> The bridge takes a textual description of the expected input format, a
> file containing random bytes, and the name of the target fuzz test. It
> parses the description, encodes the random data into the binary format
> expected by the kernel, and writes the result to the corresponding
> debugfs entry.
>
> This allows for both simple manual testing and integration with
> userspace fuzzing engines. For example, it can be used for smoke testing
> by providing data from /dev/urandom, or act as a bridge for blob-based
> fuzzers (e.g., AFL) to target KFuzzTest harnesses.
>
> Signed-off-by: Ethan Graham <ethangraham@google.com>
Reviewed-by: Alexander Potapenko <glider@google.com>

