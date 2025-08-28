Return-Path: <linux-kernel+bounces-789387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41499B394C5
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 09:11:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61A805E6071
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 07:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF78B2EB84A;
	Thu, 28 Aug 2025 07:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f1Z4dyhz"
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BDC92E5B1E
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 07:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756364979; cv=none; b=cpbzZwYj1/AIV4M/kBlqUbG/Run57wz8kXubeSEY4GIsQ/9sOqKlybutJFw04zxRDSb5qVkIiQi2MrbEAw5NPRXjtL+6QkYE/jX43/iIuH84KeTRK04M3b1NFhK8U1Gthbtb+Av0P/G5uIKDGy9fDyv/b3Xy5Axr/csGh8r24Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756364979; c=relaxed/simple;
	bh=lURPkYJzF21xY2QquL/oWnteDlCb4vfGHfOnzqSwApQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EOoMM6VY0o3ZVX4bxOvwZP/2vnor1CniDRCTJXocvjVENAh16PLIYsjVHZzB/qW0Mg9Jn8sguY24w6WBnBNPA5K2yitHJ998AF8JdtfKZiswyoDe3cpj1U4duZO6tyf5yez1yfILQUC79norXmy0urijJyfjFTuUKZk1/tO8WQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=f1Z4dyhz; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7f861f89313so71116985a.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 00:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756364976; x=1756969776; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jvs5njM1wOnHzJ4hzbLuwCvVNmJOa7dYI9qPuTJeAVg=;
        b=f1Z4dyhzXv5ADmSboyQ7Wn+9L+xknDiw6NrUHNrkgDKKxereJq9Muvz0qnM+gJQq76
         0DaXprhdL/kruFypknzsyO9mbeL2jFhrhQfdqAzzZJgQvc5nah9e2LZRXpYeevQZJCb2
         QiU0jclssmi4nlrMb9umZUJrv/k3WNPvNfvvLCfRC4P3GdZ6AiTV3YYSjzqcaDnccUvN
         CGV8BP1git/TrFlAgUF1a1HUbCNGL8OcYXvlJ7LZ4T1jXraKQcTnshZLz2tZJ8/4RU5R
         k9uljz/G/qCAkWcZnXhdJvgV9GEl8M+YY9HAD4gcGHfKsSA+WIwc3iNg8KJlhPS4AAUe
         MwDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756364976; x=1756969776;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jvs5njM1wOnHzJ4hzbLuwCvVNmJOa7dYI9qPuTJeAVg=;
        b=Fo82XpUD0zsU25bXJ+wtB1hgtSmxxx9zkMUEO6AdKE/9wArR7eh9j/M22kPRU91+7m
         WW7Ma0rC0dqxycd0CnG9kF5fL3byYpfxgn+ZiF3VT8FoAYnoJVv3qxWFc6Jhs7f3Pd4d
         LV1oV/8U+PgmdElC7Q2SFC7IuQUVoEsJmgErT3IOHDZiF3xPEzZf4W1das/vzne2zVZk
         ON+bQQZrwiflCLxVpc8u1Mlbr0WOyd7CrLTy8j8+3EnKTiEG0wtgJmzPV/hLFeJs0fK6
         1HyMGFQLbjQsGk1/IsunvyGppm7bst3bh1WeHFhuKMyd6alYqEJr17I/fhBMqQ2hongS
         DJjw==
X-Forwarded-Encrypted: i=1; AJvYcCUcqNw86CbpvFQ0dZERod6+XatcmJIHjxGbYHfNJDqch+fHO7HqUrhq+HrGH2TUaNLXTYuJMG+a+hiZC5M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrVCxzupq7iFcdmzOIHppctSPcuWVwInLNurxGDaP1eQjLp6+Q
	bM1niGfHnWF41Pr7rAbagiPxk1HDBrroJMZj5f4hSmjwPi0tCcO7d1gFWxSFrOHMawhDI8Is50u
	Mge5/RJpfgkqGYEL7fcaHxxXwRPanELNrAgbFxSky
X-Gm-Gg: ASbGncsaJ6Jq3mFXKJqY9aOVk4QuNvEoPG3O3OO83MoVKlJyieUhxFrTJGHVBY5pHqD
	0PgOS4b51tsETk1rIJ4fakK80CsvCPB6j5BaO0NC8Kz3ClS/MclzievKgGlhZnnbmxMMWxLcCh2
	TtvbCxPFNbM7v8SxTdSIb911gIsELJVRGlc+ZXqHwRr9dklQtifEl6Z0jfPHRxwP0zPZnmpgMYr
	acMQWzfWzKuGSYgDp1HKA==
X-Google-Smtp-Source: AGHT+IHxSqNH/ftHbBJ+fPHtJwYAGqsLTp8xOivDx1VKWMe0sNYk7sTPD/n4Agil+b9tyPi+N2/KpIicDTDhJp0h0hI=
X-Received: by 2002:a05:620a:1a27:b0:7d2:1953:a410 with SMTP id
 af79cd13be357-7ea10fa1344mr2611829885a.17.1756364976094; Thu, 28 Aug 2025
 00:09:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250828012018.15922-1-dqfext@gmail.com> <20250828012018.15922-2-dqfext@gmail.com>
In-Reply-To: <20250828012018.15922-2-dqfext@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 28 Aug 2025 00:09:24 -0700
X-Gm-Features: Ac12FXzCOHbY-0cZG_DPV4Isb0S8nmhFOKMxM0fnoaIGHxRJ38be9HGtCcgGyWA
Message-ID: <CANn89iJ7DDA4gM2vDAwhOyc5KGXPmOBGATMQfXD8FHUAFbVDvQ@mail.gmail.com>
Subject: Re: [PATCH net-next v3 2/2] pppoe: drop sock reference counting on
 fast path
To: Qingfang Deng <dqfext@gmail.com>
Cc: Michal Ostrowski <mostrows@earthlink.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 27, 2025 at 6:20=E2=80=AFPM Qingfang Deng <dqfext@gmail.com> wr=
ote:
>
> Now that PPPoE sockets are freed via RCU (SOCK_RCU_FREE), it is no longer
> necessary to take a reference count when looking up sockets on the receiv=
e
> path. Readers are protected by RCU, so the socket memory remains valid
> until after a grace period.
>
> Convert fast-path lookups to avoid refcounting:
>  - Replace get_item() and sk_receive_skb() in pppoe_rcv() with
>    __get_item() and __sk_receive_skb().
>  - Rework get_item_by_addr() into __get_item_by_addr() (no refcount and
>    move RCU lock into pppoe_ioctl)
>  - Remove unnecessary sock_put() calls.
>
> This avoids cacheline bouncing from atomic reference counting and improve=
s
> performance on the receive fast path.
>
> Signed-off-by: Qingfang Deng <dqfext@gmail.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

