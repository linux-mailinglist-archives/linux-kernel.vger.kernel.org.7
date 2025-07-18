Return-Path: <linux-kernel+bounces-737420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01881B0AC46
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 00:49:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83A94AC0B1A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 22:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C21D221721;
	Fri, 18 Jul 2025 22:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bjL4Rp6g"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778302AD2F
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 22:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752878936; cv=none; b=UHsL7pnlN3kzn7lJMgrjMsGSuBHu7d4PD7/50qM40k57HJlE5CLKWxkhnml1VtnThFdiGE9f+OIaZfJ6Q1cHpu1rstqPMRwL44T8rm2q0aBSbPMn62QsFj1Fu7tvoc5O0Sll4dkRUMbYGV3ORbJ24GOPoOO4P8yYA3+Q3VdHZ9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752878936; c=relaxed/simple;
	bh=u+GoV1d3OjrOfjZvHBGS5A7zm5qLVyzCUMqD4/+LCbk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o/INjh6yl3YzrCBXmAOuuezokPBLt9d1156F8m/zNCWzzOZNHkFHoteEAQ/T1oc0Tl7BYxyQvbuq6YYm6i1PQCso/0+G2UygbnhJC53yLe1GpHDoToet1vUrnFAjdD2d7eX7Gl26OZzdgJCSLxXWp25qjqcXtwxTRs2k3Zmfe7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=bjL4Rp6g; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7399a2dc13fso3333220b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 15:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1752878933; x=1753483733; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hELc5E/W58AEsTFPxRlrtTifL6X7XT08Dw5sqYCmPJM=;
        b=bjL4Rp6gGF7xEuVxG7qlSDhV4Phey6dFgqlBaKL1c+GJ1QJWL/u70GkMjS8czgRjbd
         9Frt3HilNqmJ7slvohjJp+rG3gI8C8cTSxzNjvSyAjGywQl1ixSTMwXPJivZgLMEXzcr
         CNwHcxX45pEtNK05zbpFiDSbb34cPKkJGH1jg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752878933; x=1753483733;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hELc5E/W58AEsTFPxRlrtTifL6X7XT08Dw5sqYCmPJM=;
        b=kOk9GuesFADgXJh39+7cThezGzIoptX0/Lxkw5NPrG7hVu695Be5sKPauBeRjA3cuZ
         0TQorK+6jNSzgN8YF5dr/R0gzIhnHExsqcsb1lIXD/EYE1M8WqUdDvil124YghczErki
         waOGqycaFLwBVJegXPz5Hvg9kqIPB2fP3sVqnw+yMnuIuv8p7WhDyZcJb8FCibNJ3hXE
         ITiwtANMAwrKjNBS2npeEjhEMbUu9gyb9/DnY8gJTHv6YncC7YvbEJdEh158D2SkfPb7
         Lcc8coAqo/MiLPt5jiNnVF51XBBB9zueQtvWAhL+CGMtXTgWD/+4wQ4cwU3dxH8z/Sw+
         wnnA==
X-Forwarded-Encrypted: i=1; AJvYcCXg+7NtDnjG3q+8Sqws946WnmiUhpPExqkYkjDtO3yHGW3l1hsIpS8fBXFWc2ekSM2hJXi7IzJbTXjkvEE=@vger.kernel.org
X-Gm-Message-State: AOJu0YybCnXWxL2s+04EP566bk/qpmI4fCazlsrT5AZN/tfHfmlweaqL
	wWa2TndjL1Q43Mdv/kG/uXBLAjBsTaXvlv51L5oHeT1p71o+jczHZQBLU1KWduFS/7sDhzpudpj
	UfPg=
X-Gm-Gg: ASbGncvAvjGJKEPH2mp5FGoyYPY/pOoOGtvVKkMe5EsWE8LCravTvK56ZCKK/Xeeo0R
	D8WwCEqPEgaNyvnMSa2J0r3H5+s+IWRQLB3l05w7ZEl80OicugRkmv/0U/VmSeMVXA68F3CljUF
	0Vw/z8vlV6nGJ9QSIgFRWswyCiIr3HI1vY32E8Ab83JlZgbBVD1ghzS3edCm40xKS0YXMND2U+3
	2ur5QU9yze3UvipLai1R76F6xIksJdIpMif5HMnKgN49nwBOkPTZYRBEleIPSfcu8oTD3K6eXq8
	dKMSOj4Ku8RDE6hx5Q6it9xuTjCIXBD26/YNo5ddVifqC+u22mZWOBKy/qRDb+9zARDUMsYs1hL
	4K3jP2QOgO7G110LBMezfCtgKHrq4U3AC1IWYZYoCvh5cWyqNu/ho/b1lJzk7Jg==
X-Google-Smtp-Source: AGHT+IH+BI1nHNV9AeUoHIOgLS5o8t1XDTXGHfnGATTBkj1XTLglYKSrwhCo+fE1eR59Rt7YZvMoGA==
X-Received: by 2002:a05:6a21:648a:b0:1f5:9175:2596 with SMTP id adf61e73a8af0-23811056550mr22142266637.13.1752878933399;
        Fri, 18 Jul 2025 15:48:53 -0700 (PDT)
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com. [209.85.216.54])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3f2fe653a7sm1757602a12.2.2025.07.18.15.48.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Jul 2025 15:48:52 -0700 (PDT)
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3134c67a173so2535122a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 15:48:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW0pD9qo+UyU0C04Pc6+5GsOfmoqui8rD3QrWZ3907iP0FTHj64gkmjFo+a8wRj3bH6xKYmQbN83V6aHH0=@vger.kernel.org
X-Received: by 2002:a17:90b:3852:b0:311:f99e:7f4b with SMTP id
 98e67ed59e1d1-31c9f47ce80mr17566314a91.28.1752878931628; Fri, 18 Jul 2025
 15:48:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250718193220.316685-2-thorsten.blum@linux.dev>
In-Reply-To: <20250718193220.316685-2-thorsten.blum@linux.dev>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 18 Jul 2025 15:48:39 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UjmcOO0hdy2n9aL4Ms2beMVbBHW6Pk60Q-KvMCudYChA@mail.gmail.com>
X-Gm-Features: Ac12FXwxU5mzcJB8ppCxVaB7BneXFy3b3EU4qPIxu2y22lPFk0Y9cevEpEvupEk
Message-ID: <CAD=FV=UjmcOO0hdy2n9aL4Ms2beMVbBHW6Pk60Q-KvMCudYChA@mail.gmail.com>
Subject: Re: [PATCH] kernel: debug: Replace deprecated strcpy() with strscpy()
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Jason Wessel <jason.wessel@windriver.com>, Daniel Thompson <danielt@kernel.org>, 
	linux-hardening@vger.kernel.org, kgdb-bugreport@lists.sourceforge.net, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Jul 18, 2025 at 12:32=E2=80=AFPM Thorsten Blum <thorsten.blum@linux=
.dev> wrote:
>
> strcpy() is deprecated; use strscpy() instead.
>
> Link: https://github.com/KSPP/linux/issues/88
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  kernel/debug/gdbstub.c | 29 +++++++++++++++--------------
>  1 file changed, 15 insertions(+), 14 deletions(-)

nit: Since this only covers things in the file `gdbstub.c` and not
everything in kernel/debug, perhaps that should be in the subject
line? Maybe "kernel: debug: gdbstub: Replace deprecated strcpy() with
strscpy()"?

Other than that, this looks fine to me.

Reviewed-by: Douglas Anderson <dianders@chromium.org>

