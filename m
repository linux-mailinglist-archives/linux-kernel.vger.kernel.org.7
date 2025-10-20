Return-Path: <linux-kernel+bounces-861797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 511DBBF3AF0
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 23:16:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BA9818A82BD
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 21:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67EEC333747;
	Mon, 20 Oct 2025 21:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EWcWWI0+"
Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A614333441
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 21:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760994996; cv=none; b=KfQFRhFBTzN/LHb7067CQDMrCXaR3iLK6L40Zp6klclSGxlYR6EDh+QsT+oJlKhCHb76aLUhp1gqL1ipClNFL7iAs70EBzVh3J0GjQX8bIaW7cBaY9IF44x12Rn3v33B4695L5Zlip2b6u43rRGLTPmMF5tmDgIwa4wzCKHQtXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760994996; c=relaxed/simple;
	bh=Z39XKUjyZrgm6nEjjbRX8r0IFRUqHZXsDHxC2pIscqc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BLxiN92N/DHiNceodyY6HhTActkyP+aErv+5LSE1tlkgxdA3qZfFFaFmoRRutFswcZ/N94Fetzx3tO4Kra5a2yRnYrP9nE9HEZ+qlMiu2gbUxUMexHPGOiaOUci1wyyFklHMapwVN4EpKlM4y+ZS7NZi0Mbmm/VXEIm6W/S7JhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EWcWWI0+; arc=none smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-63e393c4a8aso1615811d50.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 14:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760994994; x=1761599794; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z39XKUjyZrgm6nEjjbRX8r0IFRUqHZXsDHxC2pIscqc=;
        b=EWcWWI0+/gbrT8Hpb0+MH/d9PDGEwEVbVzq2jJVo7gj5HI2ol1ncyEqfaPdJJguLEE
         G7Gg8sg3QORCxvaULe8AFObISRqPvF2hxXNECs5f6ZoIFIdEY0pk+BeUO9wwsjJpRXhU
         2T4t/VKsLD3Px1XYJEvs5395p7x37NkU+BkUM1377YaHHL6fTp7CMBlWPAdLWYZWLkvc
         8QQqT/Kf/25aNhrupyaKKGdCn4rNGJMVu/APpAqsJgEofjEVtd4cxr3/cJTLCdS4gFZ0
         XCWL/TrrMGALuV0Xxa+mOAUerenLj62dCxzuDMyJal7so3hzmRQnF/o0lRbGZ5jjYl0R
         TqPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760994994; x=1761599794;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z39XKUjyZrgm6nEjjbRX8r0IFRUqHZXsDHxC2pIscqc=;
        b=PbkaGerJytAEWk+fca66yklIrNJ4avRx4NjYIv95nZgwS2bDlH8bHtyVCS5sXLW92F
         6ZvWWr3tzYpkZRYCkK8e3jE1IZbK4LGs00KXyqX1G2wVfW33s0E/OxqQWpZkdZnj3VAN
         nJAek6VHeO+XcHdNGhFxwCOJWoxKoPcbyf5sfVRYdM4PhAIOSXIbgJ41gxGEXpIMTaEV
         E2LF5NuyJgHwhDHeZ1Fy7gS8REaqfEwVPSekiHfNbq8Sz66rOwCP5hp3APPJIhlHl5Ib
         AKGOMb1S/a3uIrtHvskH0E4J2ngesCDMqsRIqKmVAGMGrukAgLnDOor3FcYwNpG0EuI9
         NZjA==
X-Forwarded-Encrypted: i=1; AJvYcCU8yCcrt9/D5HZMIoDIF1qflEHu9MKM/B5pCS9bkT077Fq+B8yZzhCVQyC1TAzU/Q1j6iuU8YuCNxOyccw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBEYryJHYGy+r6FexVVxfZ+ls2qNKmI6MIqX2ImdLxe4g9c5XL
	RE7v/r/BD10uKkp5M3Rf3xHYQXgB4Y/msg9JWm6PTrj1NA1XkG7BxhkquHMmSZzBOjcYbqWsNHb
	I6CI0nb5Vg9bKAf8wQLHbI0qtN+iRPZ4x1/0wBQZhpA==
X-Gm-Gg: ASbGncvE+WSyq6kRZde8wpDARZ97Ih2nnv65yqUBy5LsAoGhkLN4LuzYxC05CjAeYop
	i4QjkFxovVIHXrBx3m/Jp3EMIcoxbKKfjAwr9hbZJzqn5U8w7qxTe2cTe+cysohBiFwWs0fSjjr
	+HmlJCCeJohLysdM7D0Y5NA2Dz8N3l1U/Q3fXRt5IZ24rcO8dprFKXbxgxWjcpw2DZVMBwAEVoO
	lAOzTp0LtWt4F/j7XPYKxWfOo/zTfdP9NDVt1yDJKg4NdzCdaF9l4sjxsDJ3Y57Vkg54Ag=
X-Google-Smtp-Source: AGHT+IFgddNnhWh6OKVZ0qTi4mmYoAX0fPulCNpg9r05luMnstiOJYyZQ51cCpijocVdPz93zIwR2zKGF43lIrhanLw=
X-Received: by 2002:a05:690e:408d:b0:63e:30d0:61a0 with SMTP id
 956f58d0204a3-63e30d0632bmr5728377d50.26.1760994994012; Mon, 20 Oct 2025
 14:16:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <c7415e2870b3bd9109f95bab3784d48e708e30e6.1760360638.git.christophe.leroy@csgroup.eu>
 <176062606134.122017.14455806740339775356.b4-ty@linaro.org>
In-Reply-To: <176062606134.122017.14455806740339775356.b4-ty@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 20 Oct 2025 23:16:19 +0200
X-Gm-Features: AS18NWCUioZsQP6x4ZemVNFC2EGIJBPA6Sk-XCQsTICPirre3kuANA4BRArrNEg
Message-ID: <CACRpkdZZOWSeG6D49x54QWaVG9=hSVSeAen_qvHhwiDBXSB8=Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] gpio: mm-lantiq: Drop legacy-of-mm-gpiochip.h header
 from GPIO driver
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, linux-kernel@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-mips@vger.kernel.org, 
	John Crispin <john@phrozen.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 16, 2025 at 4:48=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:

> Awesome work! Thanks for doing it, we really need to keep getting rid of =
all
> these legacy intefaces. Queued for v6.19.

+1 on Bartosz comment, you are doing great work with this
Christophe, keep doing it!

Yours,
Linus Walleij

