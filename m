Return-Path: <linux-kernel+bounces-826549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E97CB8EC47
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 04:21:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7A583B4538
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 02:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A92B246787;
	Mon, 22 Sep 2025 02:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LWgty87b"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01CDBEEBA
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 02:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758507687; cv=none; b=BoCo9NzPnOypBjMjFjJJbne82BAfx7ZR1ipP96JEo28MaFljZyPN4x5R/Xs27JgViPRGEfwPgodvds2OtwYP0MvxsofYqAkw7sd/xbh7lX4QarYxQ5P2Yga2cbDUEeNNvOjGj69qOpOB0rApGvW3TPml0yeBIOZxZdw4YLISlNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758507687; c=relaxed/simple;
	bh=kvVV9PTDETwhqZbjjMuytjmdRg158xf+4BDF/BkA6ZQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SZev9/eqptRb0lCG0BaBTRD2ohnsCdbTbzpxnkIYLYiPHyaOyRoWVGbqKcvOa2JGv8dq01D3zYhVSVsj/ro/M5h2xh2fiOrdTSLnHeROBlxYnAVIzyqprsJadswRNWoYxaGo3d0MveWM5EWQ4kJhdnzcszbym4XwXXnnEbhH4tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LWgty87b; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-45ed646b656so33873505e9.3
        for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 19:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758507684; x=1759112484; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+HBWjDQ3/WxPf53erW1k2PDyZoFPPjb+o4gyhBoAxc0=;
        b=LWgty87bwmd3voRC+1+wnriqaufhMqTifRT4/Ssb6ZJ/X+YcX2Awp+e/VSCTnigbeO
         pg7IoTlUxuwHX9YTuTtnvbS5qIRwvGv3kzGJmyopTYAm/9D55TfBp618xnDaYY1hdeDq
         b7bLEW2lDDH1scsgYKIxBjVPmvoX/vBWI7S0JJ9DdJmdGaO96B9IqxB+i/F21u6mnIFr
         dkIUDlPUx+6/qBErr9cnayDnz2IgnPi24HrVr0KsHr3gjYNwPxTpg2gYBLvvuJ6mTh4l
         8TcSIJfklL6NPJMoKl4+/CSvzCjm9qvPyASzdGtrXQsgcOf+E45LI759IyyFycX+RJOg
         QB+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758507684; x=1759112484;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+HBWjDQ3/WxPf53erW1k2PDyZoFPPjb+o4gyhBoAxc0=;
        b=we3h7uYm4khe7w6RjtnWq/C9fX/P9F8oPKD8+TCBrCdII6uSwwG04MrWTiQ4CBEg5h
         mB81xddenz+x/GdFYNFUoWN8vmMfnrBbH+mk7Dp1TOg+MF9HtKHXEEso6QuHrfxna7nC
         Y8OLbknY6G6w94jgSS57NlibtujuWCvm7WUFfKqqgfk3socEaBC2Apb9HS5+dSbGgA+2
         HfBVI5vsbQE+pGgMZdQl+z+86Irx0H987pzNhJsr+O1revPy8qb04LfSDDgpkjAfbuwk
         YmJufpxLdrzx1qvOdLJQtCONceg1/YrOAMAw2+FvnJo0U79DTJ1Sv22cKLD+RZUElluR
         CScg==
X-Forwarded-Encrypted: i=1; AJvYcCUrH/vyn+4kOpbfoOk/VlUc+pxreEOC2WuuHFz8UwhO1oOl5xUtb1NTksWn0xvOjOcdGiMIdLD4e2UaYHE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyplzAt80gX6S64V2rL+ahi5keWrt+CQpbpqZzLxGBzJQehgZEw
	wCBm9k6UBzIAwVArs8xD4E7XAE5bAR74KsxSciCffbnjurjV+B9Ycxu41x0PI6ov6anWpFWS/H6
	FEq5I/XJNI+1IirMjVT/vlp37273OakeV5A==
X-Gm-Gg: ASbGncsdi1tQX1FLVmApXf5vsgGsR9g8hwQWEIUDEgIjt8eJ9TEZzsTqUeSuawly5Nj
	7qAPGCH9MnfLCAGqITYQZIVwcdY8nj/7tFumIo4f5piw7Ijqmb46iGKI0bTp+kI4JusfhM+cCla
	vKM7TwnVoNBvk4ZXgBqxvM0PLwmDYGQSIvDw9Z91SAo1Ymysln++5BoBTfehYf09iobOTtazNjW
	qt5lDabb7jmh6uoe6pX80mYlBoNp1GfZaKE4ZRK5OJQpEkcq3Q=
X-Google-Smtp-Source: AGHT+IGO2vCR/2NNGfxqRbbgUrg/H0tXDykPj2RK9VygzUW/3gXKqxiHTWTS79gcWN9FvDsTkiTwoqMXgYbVDjAXVRA=
X-Received: by 2002:a05:600c:1d1b:b0:46d:996b:828c with SMTP id
 5b1f17b1804b1-46d996b8a1cmr7210265e9.10.1758507684130; Sun, 21 Sep 2025
 19:21:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <tencent_E0C8EAB7EBECF90582B0CD21490DBCF53A0A@qq.com>
In-Reply-To: <tencent_E0C8EAB7EBECF90582B0CD21490DBCF53A0A@qq.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 21 Sep 2025 19:21:12 -0700
X-Gm-Features: AS18NWANcjnrd4z4jrAFZwjD10Rry6UkRpVmPtR8IDhsCca-5EDvYgzBPBOItIM
Message-ID: <CAADnVQLJBDO5e_U-9SxQ6RxUGLUALVk1_TuJaqdJFmjf2XOTJg@mail.gmail.com>
Subject: Re: [PATCH v2] bpf: fix netfilter link comparison to handle unsigned flags
To: Haofeng Li <920484857@qq.com>
Cc: Quentin Monnet <qmo@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Haofeng Li <13266079573@163.com>, 
	lihaofeng <lihaofeng@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 21, 2025 at 7:17=E2=80=AFPM Haofeng Li <920484857@qq.com> wrote=
:
>
> From: lihaofeng <lihaofeng@kylinos.cn>
>
> The original implementation of netfilter_link_compar() used subtraction
> to compare the netfilter.flags field, which is  an unsigned type.
> This could result in incorrect comparison results when the unsigned
> value wrapped around due to underflow.
>
> Changed the comparison logic for flags to use explicit conditional
> checks (similar to how priority is handled) instead of subtraction,
> ensuring correct negative/zero/positive return values regardless of
> the underlying data type.
>
> This fixes potential sorting issues when using this comparison function
> with algorithms like qsort() or bsearch().
>
> Signed-off-by: lihaofeng <lihaofeng@kylinos.cn>

Nack. We don't fix theoretical issues.

pw-bot: cr

