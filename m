Return-Path: <linux-kernel+bounces-720572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70AA5AFBD98
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 23:37:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC21D4A4F42
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 21:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21CE82882BC;
	Mon,  7 Jul 2025 21:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M5WnnDPF"
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 327EA207DF7
	for <linux-kernel@vger.kernel.org>; Mon,  7 Jul 2025 21:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751924216; cv=none; b=jtMlYJbWgxlae4XYuGm6WDD3bYsCQBSrlXFotkhni8SNdBafPbLEzeBVIN7I142WXQHrWy1Kl4flwz5v7kI7MtO8yOqTH06mDIom1VmL7T+fGU4GAnv3wX4OgHKHLt++PSX8+rmLmJ9lf9mPlhtgFL4vxpteWif9uWbb0ApJpbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751924216; c=relaxed/simple;
	bh=WXMt5c9z5T7EEkHmHTONttuzAvrlHed+hbckXkH5d/Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PZxkx7TI0/9W9JfKup6XV6+BXDm/xecPPYWaRgCI5JU6Zd3Osk74IpmfY+ITIgnMpcFjEvTS88V/6pAfxtchqR2yJImiGVQF5/eoR9MJsMJDsTtrGBRknENTBL1RVWBmDApgnbrWGkHO+QU53ank3yoqS1kjH48H5g41IaDsjL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M5WnnDPF; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6facf4d8e9eso40465566d6.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jul 2025 14:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751924214; x=1752529014; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WXMt5c9z5T7EEkHmHTONttuzAvrlHed+hbckXkH5d/Y=;
        b=M5WnnDPFBiqWNTs85quWecPsqMlE8hNBBuOY429ikajC3sQ0rzFfWufU7GezbnSvbl
         n2XwfYlYdTnu2xCv3Sm594jTiNKQ8JW/nTRwDMQ4+ObhJ5Hv/HLAXY+PIXO0iNS7cww3
         hgUsHUyTErXYOhiAnqfOAgxZ62h2IIRV39Usfc4Iv8a74WEk/AilbE7cykG4Q1DGg7Oq
         6hwfTx+G9BtSxDgMBWa4qvZY8WCLZLbwVt3Cvy8d9c03OLfLdudSaxEmh+HEqFxPrmET
         /hFypDG9G8WCFm1NrfzhATdoKQ4lvb3xZc97DLz5Ewz3CqjWS6JBCs6YtY0KsJB9QaEk
         /0nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751924214; x=1752529014;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WXMt5c9z5T7EEkHmHTONttuzAvrlHed+hbckXkH5d/Y=;
        b=K2zIkqrtUXVjBcw6APSEfSQptBdJ9I+gFPgJCn6DIBkG0MbVlagacBMeUD6qrp8Rw8
         3wPmaImaOGQA6qoU3akwkj16K/UFKZUJaV2lLgWSW68/LiqiU3VDF3t49LYowoDgD5yF
         +RM+PmElTAhaTlGktOYjfXDOQbQGJgw7Mp+EpooiyYSzKTs4r69DR6bQLjRRfGJLQb4c
         1xiATr2zZk7zhWgbXsE5OiX4XFiriwy0qQHib9Kc649DY4UjitSSPxTg94QAXGrDSw7/
         UIvIEYqo0p6DI1ns8Pq4TwvkJ6Qkdsz8T+okRm8s5mzPE0YYhh71ViGEiMWMNl/BhFju
         w6mg==
X-Gm-Message-State: AOJu0Yx4sVagzFmkYUf50fTI1L5O+SyPmYlEtafYq0Z6t3PqPWHdqnaW
	sf8ahOtYkJIDnUVxHLkiqZNqdJ8fLB/5rrUS1B5nbZbc6XrqzRqJs1B1H+F+seeXF2hHG2odYgw
	7lhM69Yqn/+dtp5Glu3s0YAUNo5M0vKmCMPODrE4=
X-Gm-Gg: ASbGncvYbgrOjh8Q5VMC2rZj2dcWRC2TuWkHnqDD2TR92YgK2cjfI6cZI4fDZx/Bgi3
	JbWhGJ0kCrlry4xT373dPlwPfrcK0aD/NG1Q0jJhC6mpUyLQBoTGhEAB74jaM+k+81lBVDla/NJ
	E3MyX4BLvu2stZ3uw6zD/yFJDvGA07ivrpBatGdhVHKR8=
X-Google-Smtp-Source: AGHT+IHUThxSB63AW5CQmAd9yQ9r3gS4EdoyxJOXpTu0VFbQmch2K0iEKcuRdMx4ew131TCobebed2kR88en6gvOTbI=
X-Received: by 2002:a05:6214:5546:b0:6fd:4cd1:c79a with SMTP id
 6a1803df08f44-702c8bc0efdmr224979786d6.21.1751924214118; Mon, 07 Jul 2025
 14:36:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250707201315.9497-1-kanchana.p.sridhar@intel.com>
 <20250707201315.9497-3-kanchana.p.sridhar@intel.com> <CAKEwX=OLk308EDSc4ApXnuQYbR4_-Vi9Ca9rJ3dgRwV+Airz_Q@mail.gmail.com>
In-Reply-To: <CAKEwX=OLk308EDSc4ApXnuQYbR4_-Vi9Ca9rJ3dgRwV+Airz_Q@mail.gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Mon, 7 Jul 2025 14:36:43 -0700
X-Gm-Features: Ac12FXx69sGZOSqNc9wEqk5H0AaE-wxK_VR_iKjhLveAP20PwkUU9RV0T58iefA
Message-ID: <CAKEwX=M8OtFgG8RfeM721sr1ev2i9-b0Oe6M4zyBD915v9TOTA@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] mm: zswap: Consistently use IS_ERR_OR_NULL() to
 check acomp_ctx resources.
To: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, hannes@cmpxchg.org, 
	yosry.ahmed@linux.dev, chengming.zhou@linux.dev, usamaarif642@gmail.com, 
	ryan.roberts@arm.com, 21cnbao@gmail.com, ying.huang@linux.alibaba.com, 
	akpm@linux-foundation.org, senozhatsky@chromium.org, 
	wajdi.k.feghali@intel.com, vinodh.gopal@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 7, 2025 at 2:36=E2=80=AFPM Nhat Pham <nphamcs@gmail.com> wrote:
>
> On Mon, Jul 7, 2025 at 1:13=E2=80=AFPM Kanchana P Sridhar
> <kanchana.p.sridhar@intel.com> wrote:
> >
> > This patch uses IS_ERR_OR_NULL() in zswap_cpu_comp_prepare() to check
> > for valid acomp/req, thereby making it consistent with acomp_ctx_deallo=
c().
>
> Is acomp_ctx_dealloc() introduced by the other patch series? I can't
> seem to find it.

Ah nvm I found it in the other patch!

>
> Also, why IS_ERR_OR_NULL() in the first place. Can
> crypto_alloc_acomp_node() returns NULL?
>

