Return-Path: <linux-kernel+bounces-810168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2741EB516D1
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 14:25:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D271A54052B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 12:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F5F0319872;
	Wed, 10 Sep 2025 12:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S/Zs8n8Q"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D1A319867
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 12:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757507129; cv=none; b=WKKPrIHqpNIcjRPGcL+8KQg1V/5i2M3aCd8Sf/bFIiwuniS019Zf6lC0eRUGZvUSK2qmHGR9IqWWADQiyw3SNvphwNKhpCNTbnZBn0cE+dIjJhZQX7ineJ3Er0ebDbgcvMUZFr8VBW0TQCP4VovbsEfly8w4NJ8uqatVCmTBZFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757507129; c=relaxed/simple;
	bh=Jb8rn+o/7hVLmNx0470CoSk8kVZjdZO+vXlMdQNmAxk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ckaJ0kfAsMiY4yDJoYvyPSbr5jT9DY/jldo4AdsuAyKskglffL/NWHtaTLJgJAPFb5pKkX6qoTzW8S0LQSZCwSvwzPK+yVv4V23X5GbTZsOU3k1Jk4CzBmW+yoJLUSqPN6/iPyYJy0Jt9NoMaZaJB1aa1LctZbT+0tBcfOGLnNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=S/Zs8n8Q; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-336cee72f40so59378271fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 05:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757507126; x=1758111926; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jb8rn+o/7hVLmNx0470CoSk8kVZjdZO+vXlMdQNmAxk=;
        b=S/Zs8n8QJHZwXHVCLkhf2A5+BKB7n3CaN6RBhvIWr5+ITf0JccQidSw5ZyX9PRJyTS
         Nu+QD0jQQZzwTLOEI1RG0Mk6arRhetAA1mKYgSCFzsBZm17nBnudHIwKclNghya6AKJ+
         MSOSDlUKL+wuZDjktjdpmyBWO+iXmTXvz7fjbSNNWRJ7r6IpWQ2m8h1ULtNmqQRBixMm
         hgRl4BajMRuuVgmr8dAdeJ2hzY34qIhYMLSTcWssm5amLarIx1YK1aSRIg75Aoch+G4R
         S0VaRGCc14qq/L7C1vZIR+QWf3Zy3cuD3tr42rjq6XeXpN9oafaNNUHZmrtS8Ys0eIas
         LRbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757507126; x=1758111926;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jb8rn+o/7hVLmNx0470CoSk8kVZjdZO+vXlMdQNmAxk=;
        b=t2SV+b3oekn//4Ijm65PEiaiCAfRuXNLPLj5gs6BP8y9rw+U88WWx2DvESYO+Kvsb7
         392Sg/yVf5TTbJNk6jd8Pf0+Oa2a+ZjDTe+FsyDbpk5JbEssuCvHxGr8QzuBqLJgxaBq
         cy+a22IRmUQ8SBd4bAuhpBVbMgnX/ZO2buQZbofaSDUcRnXzm5wfQTonkJRuOnzt+HYj
         jTM+iALOkCwC5Pxtid0snbRNBL8UuW54nNoQVk4PMHp3gQ1a87BGNZQ7aYBsnuPX82BP
         cZYEajqRBkUU60e8ijq4EV0P6K1t8LCamW+2eAH/OGSUNEbb/gdpWzO7BjJ1Ybl2dpx7
         RHHg==
X-Forwarded-Encrypted: i=1; AJvYcCViag+8FQCtGy4XzDzkBg/CKwRlZkIedSbSDY0cqh7Y79pIaPMZ61+otED6Y8zSRcHfcmUUlMw+52MEffk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlK0YIIKN3fH3eTBeQzysAMDayTq92OcYivDtJBDXptX8s3bbK
	qlJ0xBOsM8uygWJP2QNFeLINJavLrWrXuPd2F83L0HhpUS6r9J2PK0vv/6Rbeeo0fP6eBqyhH/M
	LoDGc89NfdugPbIEGa1P9nQEaAwejWhLW3FAKbOfyAw==
X-Gm-Gg: ASbGncsKF+SDoguqdmkFjghkP5Vzbok3cu86f3IOCXapWbI2IIHdBI1i1pHJOsljhEt
	elN7ydGh8pePmup1UlwEV+bNqBeotXAlsZbGJzekHwAbt21O4l/LhRMjn8wv+fktPYVFyb8YsYK
	zKjQvWDawEhHjrD/ggCmIsJmK3MLJHxZIz4sw67uqq0Pbxab4ruarBUcLc8P+DqPydD9ONLdJq4
	pgtKzSksqDldjCF65n3d72PERzD
X-Google-Smtp-Source: AGHT+IFpOfA2Vx8asGOoswaq+u2iYr23nDNKUHrWZWNtcdlEvv8oM+dzSE/hD6j0Xw1XIKlEFSbJcTZHF5YA5L01CHA=
X-Received: by 2002:a05:651c:2222:b0:34c:e79:7827 with SMTP id
 38308e7fff4ca-34c0e797cc5mr7496491fa.21.1757507125790; Wed, 10 Sep 2025
 05:25:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250910-arm-remove-high-pte-v1-1-d0899882815f@linaro.org> <7dfbb373-fb44-48d1-9880-747faa47e079@app.fastmail.com>
In-Reply-To: <7dfbb373-fb44-48d1-9880-747faa47e079@app.fastmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 10 Sep 2025 14:25:14 +0200
X-Gm-Features: Ac12FXz8vGvAJ3GsfjfvZvjkh8hgdiVonDvi86w4Nv_gPmhE_jPbQsRJhU373_o
Message-ID: <CACRpkdZ=4n=_yeWY1MSDRuQ=H-P=QiTcQkJF_YDHMfRM2RgDZw@mail.gmail.com>
Subject: Re: [PATCH] RFC: ARM: drop support for HIGHPTE
To: Arnd Bergmann <arnd@arndb.de>
Cc: Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Russell King <rmk+kernel@armlinux.org.uk>, 
	Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 10, 2025 at 2:15=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> wrote=
:
> On Wed, Sep 10, 2025, at 11:47, Linus Walleij wrote:
> > Matthew Wilcox suggests HIGHPTE is a burden for the
> > kernel MM, and only one ARM system (vt8500) is currently
> > using it.
>
> I think the vt8500_v6_v7_defconfig entry is a historic leftover,
> instead it is currently enabled by default on all configurations
> that enable highmem.
>
> > This deletes the use of HIGHPTE in ARM32 clearing the way
> > to remove the feature altogether.
> >
> > It was introduced in commit 65cec8e3db60 "ARM: implement highpte"
> > in 2009, so this RFC is intended as a discussion item to
> > check if it is still a desired feature 16 years later
> > or if we can get rid of it.
>
> We discussed it last year in the context of the PREEMPT_RT patches, see
> https://lore.kernel.org/linux-arm-kernel/20241210160556.2341497-4-arnd@ke=
rnel.org/
> and Russell's reply to that.
>
> I still think that dropping it is the sensible tradeoff here in
> the end, as it should allow further simplifications in the
> pgalloc code. Your version of this patch doesn't (like my
> identical patch from December) actually do any of that though.

Ah, I was blissfully unaware of that patch, sorry.

If we go any further with this let's rebase your patch instead.

Yours,
Linus Walleij

