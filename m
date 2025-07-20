Return-Path: <linux-kernel+bounces-738417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AF72B0B812
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 21:51:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0470818988CB
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 19:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF32A22127A;
	Sun, 20 Jul 2025 19:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZIk0er9R"
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C58CD1DB154;
	Sun, 20 Jul 2025 19:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753041076; cv=none; b=pWftn2vXKO2q/N9Otb5AKX0kvF8f7+ee0TXgkHmMyCfNQrKBvMC069TkJere9fBE5muOZKiVGBlm15MJ8G+hPW4yJHiMl/sfFOLmKVjxhayIKbXVL+dz/CBm2k8aCbEtrLC3RxetbJusPwDooi8hv6uFzUJ28GC3MlY+2x6tA7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753041076; c=relaxed/simple;
	bh=wZMKlEUOX68JrTzkSRvjH2OJEUfyYEUoS2SLk9u7Dow=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fzboQZiroOIHtt6jWHwA4i7TXGOPvTJycmLXDfwnuM4lqqPrLgLEpkTTMuPI9Gcjbgs9UmSc8wZM/we42V133opuOlZGgaVGl6ZMc2WgxshNp6NTW/GOGqeGn4cML1pj6zi1Z9wfIxchkOW9cOpPZXzDI0yiA/47/viYNDZL1lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZIk0er9R; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-41bc2668f75so2058784b6e.0;
        Sun, 20 Jul 2025 12:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753041074; x=1753645874; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8pdUiGWbsgg0CJ4pLUwtMgPfW72vVxz6DKVN1oZBlnk=;
        b=ZIk0er9RN4B4QBH3i3rORVdFMjye7l6qPUOi9viTmWp8+qWYdvtkTBuCfi9q4Y/OWo
         pQ96DaK1Y82o6O6WwBsr6QiAKUUJQXFCvP5p8iPQESmGDKaCBLxvCMoMiq2qri+ve4So
         ZPzWHr+9ul6PsaZ/Y/wR0cskhZ4wzbkz4apBTQgs/fJbNXU+C/3qlOlPVbT+3k7ix0Y2
         U1B8fFQcY1Ra3D0cY1DfAxMVBC0HnhgyZAROCzsTIRH+dX6GKu66fhPk5+9Fup1GjfAa
         nGdVHW/2ct4SL9AL8Ea4jYmXXtRWSi9wnbwM8gy4Cgd2cX8D69Oi8sqSgzHLm+xlMQjq
         P3gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753041074; x=1753645874;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8pdUiGWbsgg0CJ4pLUwtMgPfW72vVxz6DKVN1oZBlnk=;
        b=wqN+Fq2Vb31uUjysp6a1M+baPj6UOjX6pj6TpwDB94WqWWNEokSWD3hcK4UqTMHU2J
         jI9Bwdr6F4ZOTyIu6Q1A1+8djEr3nUYGKFRmEs8nQFTj0v8fxE3OYYMo2YM0T68O/ArA
         jaLwN0lNg+S7aOxJ63DROB0fdiLKxmaAlKGC2lKblNMn4eA9k0WoXkbWf9RCmSqY7vgO
         cHHwKgYvp3MmXHNjVkiwIBlhhfy9hQRN3NPJCcbmZ26Lv5M309CWCoMF21LLLRqMYM0G
         3e7Xwq/CnRMZ81qVIDic3ufZjt5bijRT+rYLbLMHM1nWw/kzwakoWdJtPrAnJnUebO/j
         JkbQ==
X-Forwarded-Encrypted: i=1; AJvYcCWmnULnI1PXUT0gWgko1I7xHOsVQpSBtkCYJ0JEswzlm4tr1P/2QjRemOHm11TSleRrVPZVeQoXpQim@vger.kernel.org, AJvYcCXKzFKBrBU/YPHAWAu6hgDBJpkBSlWVbjh/ZJ4bn2H378mXp1zCATL29NaR2uJjENkZyXkDnzBMRNrgU4V+@vger.kernel.org
X-Gm-Message-State: AOJu0YwSWbgeM5A5HhXgvS1wHy3m8b1jnfz9KcbZut1ghbpRHkZILUog
	hZpmgadw7B6xsI/SiNbBcV4IfQim9zSouMVY6sGhSFEF0SIjP3s15hTcqM0RDL5+4N0AJEp6w2C
	L3N5hy7ZkQBjs4uIrR+IuD+LaGRa94Gw=
X-Gm-Gg: ASbGncscqjjn+5rDMGLRpWVnXMNcssNOlLYwm4gTPfqddBxy68mIUIyZZ+0kwcUyWJV
	v4Bfh14Ui+ZQibKRVgVDkkkjWDnd4AwpGqdnn1IBUGuP8VmFca6b2z0gBDlNT8bxmy7VU1shTAO
	Rw03WnJExGqkHq+1R97t2TMmkitlUbg2cdMVkYOtDx+u6l8suLd8q1CHrtO6JKh8naV3y52OOOB
	Rb4wyqJUHbH0Tfq1oE=
X-Google-Smtp-Source: AGHT+IHt9uAWCHbIYGEdJFOU/DaDUPPXZITgD+rBr+XvH6npb6aGodI/kJwOtF692HkZTJVuU0Kx7GBVi3i4oDGR0Dk=
X-Received: by 2002:a05:6808:2226:b0:41b:f2a0:28f7 with SMTP id
 5614622812f47-41d05756050mr10790464b6e.36.1753041073815; Sun, 20 Jul 2025
 12:51:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250702011956.47479-1-jammy_huang@aspeedtech.com> <20250702011956.47479-3-jammy_huang@aspeedtech.com>
In-Reply-To: <20250702011956.47479-3-jammy_huang@aspeedtech.com>
From: Jassi Brar <jassisinghbrar@gmail.com>
Date: Sun, 20 Jul 2025 14:51:02 -0500
X-Gm-Features: Ac12FXwcwYnjAjxqqsPWb8Z6fZqKu8-qloc1mBHuXxX-CpWSK48rSruJh4ba31s
Message-ID: <CABb+yY1kyZdMqcMRUEdqCYByQE=DurfnejtvuQsMf9wfLiij2g@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] mailbox: aspeed: add mailbox driver for AST27XX
 series SoC
To: Jammy Huang <jammy_huang@aspeedtech.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, joel@jms.id.au, 
	andrew@codeconstruct.com.au, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 1, 2025 at 8:19=E2=80=AFPM Jammy Huang <jammy_huang@aspeedtech.=
com> wrote:

.....
> +               /* Read the message data */
> +               for (data_reg =3D mb->rx_regs + IPCR_DATA + mb->msg_size =
* n,
> +                    word_data =3D chan->con_priv,
> +                    num_words =3D (mb->msg_size / sizeof(u32));
> +                    num_words;
> +                    num_words--, data_reg +=3D sizeof(u32), word_data++)
> +                       *word_data =3D readl(data_reg);
> +
Please clean this for loop.

Thanks
-Jassi

