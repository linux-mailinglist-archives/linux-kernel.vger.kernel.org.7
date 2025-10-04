Return-Path: <linux-kernel+bounces-842001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17CCEBB8C07
	for <lists+linux-kernel@lfdr.de>; Sat, 04 Oct 2025 11:37:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B50333C3D1C
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Oct 2025 09:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C422726B2AD;
	Sat,  4 Oct 2025 09:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EAUQw4+5"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24731DF271
	for <linux-kernel@vger.kernel.org>; Sat,  4 Oct 2025 09:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759570620; cv=none; b=iGzddeBAuGjJbqjz05j9Cd46f9HqNaE+9TcLZ/1c0doVPFFK25KshNGQgGecbXffvaJXbo2EyMcHFdcWOd/CIv5INV29fDs+8MfdxJulbjLeDTDjPB4i5aiMiizelVvXsOKAemEuS/i28XH7rMy/S6Wb/qMj70yAG5kIZF95Pxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759570620; c=relaxed/simple;
	bh=feYeUBQ+zRG9kMk06d6rOS7HenSqT9mRm9UdGzyR9sk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fRVaM+ZVpj4iT6rpCNademDM0C6cR1YIL6nXVr0S+1CTjg693oNDO89Aw6KdHiBiqurlRtzpO23jKLwJhcgOm0occx6kP4kGAHibVZHgvBEgF5JZGrc8XUHBG87f17s53+YgNRVtkKXnEnllWAS8ZGsR8+6IOdAqutRbP1+499M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EAUQw4+5; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2697051902fso4640535ad.1
        for <linux-kernel@vger.kernel.org>; Sat, 04 Oct 2025 02:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759570618; x=1760175418; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=feYeUBQ+zRG9kMk06d6rOS7HenSqT9mRm9UdGzyR9sk=;
        b=EAUQw4+5LYWQngugBjBLw0Xli5fkrp1Hb6Q/hBHURfvySLY+19E9q+Kk7yh8Po10mh
         s80MGXT77UGkhKMVtpkU5ulu3FwKeFWdM97tp3NMyshBEtDFGkvoI2NkzUU94QTLhHZa
         5QQeWnAxesG1TrcCSj0/ajG88FtkVdId7deoRrebAtdUVC1v9+g1x7cqCPtEAtn7K+Ue
         cCms5cw093CGFnMOHrLq9oBNmgh3KTK1q8HUReZwJ55ei7AsP7f7jS2phzIJAFYosjMO
         MKGDcetP2isEvuNBtVOV2IXKDLsa6Re/7tyhBOTsPTsmhWykaIKEMw7hlfDwD9G+12DE
         Mcww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759570618; x=1760175418;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=feYeUBQ+zRG9kMk06d6rOS7HenSqT9mRm9UdGzyR9sk=;
        b=XRoy5shSfJktBdWdVhWjE4GhLh6+MaiBBbve51v3v4fUVlCeRpHhgBtGuKkPUt6gRZ
         MSAyvKtd1ICtgrkNv7ITT1NAgDl4g091k8LLkVMYgpMlHaeyu/b8KbdAdVqG6xLBYuZ3
         KtxrVF+PqVz1AmeuCZKmMAsN/2jHdN04JjJo9rBKHQVcjjr4bUZL2HwBSQf1htmAkITn
         NJpdzCHmRsbzdeshCl2Cnzn/FoYUBzwlK37lk15F45sNTHxaFnq4lc4C0k4vfiLcOFii
         3iQoIjXlmc2553tE+4N/Wh21CZIW74fZHiPPbjNG6IjpkzKYVtI7ExPqvj8Nju6R4FVC
         cp/w==
X-Forwarded-Encrypted: i=1; AJvYcCVnU+CXZWWviCQhniRz///Nu79RcWYIe6ML3DSWmPyRr/pGqikBFn2keKXELeWlrUaFo8YOXgzOAtdgTNw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4hQQROxL06EKCm1IuXZGXD2ImW/7FFiDC7gO2TOO7Ilx86G/i
	LC7K6QDsLHXUB6WP2Rnk8AymIFWf8Qe44Stgywmcx2RZfaYq7AOUrlgB1Wns1yXwyF0yRjskWvQ
	D9HXRvWZH6tXiwf5sH7a1br4CMkKH3XI=
X-Gm-Gg: ASbGnctyV5O5Ez0n5Tg7n+hoty0+Yf3Oh+MqqAGXgntr4YW4mc8YbX8hYq8ClOyvM2d
	5nWg7lI1YV2usIf3HyvEBU9f8N0FvSyJDp/uoa3etRTJhUksOG7qDm+xiUcbG5VF+eDn4KdcwUC
	FE8fyk+q3KBIBAuVdMgOgNEWKydDQvyEGzjcafDtTmG2qBY0sQ1hzwekbCLXGkoUr7dfMFZ9OTJ
	v0yyvW2WRhoq2wIewO8TCWtwtAbdeMFVjw76qH75G9VRxtDHdR1Q2ZCFiTKJQL5DBGUxJhNjpB+
	jHpugI2so6mn8wwTJZ91wb1QR3zGzEH5HOBFNQOBT3XH+Q9t+w==
X-Google-Smtp-Source: AGHT+IF77wTkNQM9OohiiK7sgjNFds3niKOBIfBEyFk8BZ16yvDihaUL7UtpNXy0XNC2sOVra2ov0jtp328+HUcOPDg=
X-Received: by 2002:a17:902:d2ca:b0:288:8c30:f08c with SMTP id
 d9443c01a7336-28e9a5d22c7mr40643515ad.2.1759570618049; Sat, 04 Oct 2025
 02:36:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPM=9tzYUBfz+YmifRDgdBsuTL=FpBxQVfxu23it48kGRzJNPQ@mail.gmail.com>
 <CAHk-=wgO7S_FZUSBbngG5vtejWOpzDfTTBkVvP3_yjJmFddbzA@mail.gmail.com>
 <CANiq72kq5YHovH=_a9c0JQgfrAx9gRsQvVo1VfHd-FaupOp7rQ@mail.gmail.com> <bd004ac5-9e51-4e90-a3a4-025d74941a38@nvidia.com>
In-Reply-To: <bd004ac5-9e51-4e90-a3a4-025d74941a38@nvidia.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sat, 4 Oct 2025 11:36:45 +0200
X-Gm-Features: AS18NWBfyunA2-nfASh7Yj1hCcCcrL6FKNe1jx_SFPOW7HhxILbzUUVeFdW6VCI
Message-ID: <CANiq72mRdQRM_uDPxB35zUDXrS99o6i=RaPjTghVTZSG53i2_Q@mail.gmail.com>
Subject: Re: [git pull] drm for 6.18-rc1
To: John Hubbard <jhubbard@nvidia.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Dave Airlie <airlied@gmail.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Sima Vetter <sima@ffwll.ch>, 
	dri-devel <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 4, 2025 at 3:54=E2=80=AFAM John Hubbard <jhubbard@nvidia.com> w=
rote:
>
> Very happy! Far more so than I expected. Being able to *not* fuss around
> with minor formatting details (while editing, rebasing, and reviewing)
> has been absolutely transformative.

Thanks :)

> For example, on today's linux.git, I just now ran it, and you can guess
> what happened: it changed its little mind about yet another use
> statement! See below.

Hmm... I am not sure what you mean by "another" -- this is the one
that Linus left in the tree, i.e. the one that originated this thread.

In other words, changes should not appear randomly -- the stability of
`rustfmt`'s output has been perfect so far for us in these years and I
hope they continue to maintain their stability guarantee. It is what
enables this, after all.

Cheers,
Miguel

