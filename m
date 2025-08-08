Return-Path: <linux-kernel+bounces-760201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0C1AB1E7BC
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 13:50:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A27D3B0568
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 11:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B50F275855;
	Fri,  8 Aug 2025 11:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eKJb3NtR"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769462750EC
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 11:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754653800; cv=none; b=if8WaT9Kr86Qs4U4RreUmIfbt0j/KU+uy9LIgR2R+hjmP1NtGZaJSHtUL6Lu/FhigmacJ6VJ95AqEOmVT+aBHTwI01OxKXLoLr4CAigV5J2iaOUIOScD1Qz951wqFBHRM57kThwdQNtSybEa9zSFB69nlxWkMU9TwjYiTVdPNRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754653800; c=relaxed/simple;
	bh=eb4KMTW4r4qu3P/OqFSHIaMxQVsV3NPVz2+32AfZSlo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eHZ9XXK9tY28jTYn1Da/Bmh2gtih3V2DerM3bH4yFhY+9op1faWu2aRcUaAbCto8YK1jDJR65JUV68RJzgd+Xk0A+74G0dI/HgQu3PTZZzHMOubE7WAn7BIiXplq3h8zsjzjPP9V/PpokOS+ZtKBzVA3Z9FNAPLUsz7ZKi5o5UA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eKJb3NtR; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2401b855635so15151455ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Aug 2025 04:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754653799; x=1755258599; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y4U8t1hCYMmSASvz9snQHZPW7Ew1JL75mQvLxEN50nE=;
        b=eKJb3NtRsLrZpolYg+MG0qiiT9EHhctSscIAe2Xubyv3GTfw5liJLtXmbzSHqoMXOB
         sVSdFoF6szohxEb95N4T1KE1vYNBVQzTgantkMFNghErmFc3BlFI49KhOOGNi31somVk
         7z+J1DCOuWF1Nq1FIi9iHTl1nYytCSJYlJkTj2bVtNGFrLv1uplrERzf5zcNuPs+mGwB
         VQHnzLcLrFERS354cT7pZKD/3vBYUiM4eO/C1HDyRh/ST6wRzcrZPAiGMbcDMrpPOYrs
         IP8ZsZH4LGZFjJZ2+2Og/4hDZW2gcJvENY9dbYjvC/GJOXv2LqZ6RH5pHLQaGunydTKr
         o9WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754653799; x=1755258599;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y4U8t1hCYMmSASvz9snQHZPW7Ew1JL75mQvLxEN50nE=;
        b=QBbVDU50SbKJvf4ZU5IGkUUAbp2AGmMCJLuJ7VX3JO47x4RWIHz2tuE3iVFaBcMwH3
         bvsKHJ6G7SoQYDaF5qri335e2//yyWHmfc8Pmm5LG6P0t7pZAaNT5k7NCVkau5UXDrmo
         V0acD1LINc3Hm76fAu52v3Y1wQ6cAFKhnVbdvWUe72g4xN/wV1ih7wcS9KYBa2ssl2QK
         iADNNVZzewI2A70PT6pKr0N/80Smlz6AjlvmRaBHuPvuqWyOGp6f94HILMC/BnwwcT24
         n2wlSdCnViEMWZI3gSoBGIAXkaw5ux8edc/qDJokfdjUpWyKceeLorEaivTqrJ+u9AXJ
         tf/w==
X-Forwarded-Encrypted: i=1; AJvYcCUCVUVj8iJ9ZkSx6jnfjap9eqSrylVtsFk7NjW+Qr3er5pkcqvLjtBohDoVDWcQSTQoVlmzc0aRhj+rKgw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGGYmfOp3Pzj0UgSDxd8DjoIZA/FQ4KfRPaJQVIF9AU63dlT+D
	kIzCuh7R/1OHhsLoKpRpVapokmpADSIRK4uKKYS2Dqf5SJt4T2NPGlmoeZsiQ/nK0GxP+o4kwZt
	vHx4bLfwqbuBz9r5OfTvH+tUjNc52612szUdd
X-Gm-Gg: ASbGncuJYi3SwSLDApsYNG0/PzFTE4dgcWJedadbZJxTH16/fGx++8Rufcv1qF7LdwM
	Qm9wc0RrGWJ0BcYaRELL8gkT1DShJFe3HirgzpmWcd5+DF6v8AaQ7A1g44TaGKpnD9pDIBOyXzE
	xEE9A0Og5h4LfveSF6WL5Mu4D+qiQR1ePDJhbhK/r/o00aLUkBy8DtiPcC28Lo5fJKCCwLziqeH
	VaXzJgDy9JOH8u4
X-Google-Smtp-Source: AGHT+IH0s9s6aEdmFhMvXZ4jC3JQQ+y7jerlRSgp7hlj83FuNqzsn0TqKg9ZFWYeqJAVpEDhAQfMyUTG7SsgXKTpfiI=
X-Received: by 2002:a17:903:b0e:b0:235:1b91:90a3 with SMTP id
 d9443c01a7336-242c1fdb197mr41704705ad.7.1754653798769; Fri, 08 Aug 2025
 04:49:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250808095503.906244-1-linchengming884@gmail.com>
 <20250808095503.906244-3-linchengming884@gmail.com> <87zfca9kur.fsf@bootlin.com>
In-Reply-To: <87zfca9kur.fsf@bootlin.com>
From: Cheng Ming Lin <linchengming884@gmail.com>
Date: Fri, 8 Aug 2025 19:49:49 +0800
X-Gm-Features: Ac12FXy4tzXGUM6oD18C6VZVKs6r2WLP8uQSAD1KjLa_SaRxd-7zezNNfL7wkKs
Message-ID: <CAAyq3SZC2R_9_CVJURAvhZe8_-iE6t8ErGBV16vKPbgVsOhbbg@mail.gmail.com>
Subject: Re: [PATCH 2/2] mtd: spi-nand: macronix: Add randomizer support
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: vigneshr@ti.com, linux-mtd@lists.infradead.org, 
	linux-kernel@vger.kernel.org, richard@nod.at, alvinzhou@mxic.com.tw, 
	leoyu@mxic.com.tw, Cheng Ming Lin <chengminglin@mxic.com.tw>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Miquel,

Miquel Raynal <miquel.raynal@bootlin.com> =E6=96=BC 2025=E5=B9=B48=E6=9C=88=
8=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=886:19=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
> On 08/08/2025 at 17:55:03 +08, Cheng Ming Lin <linchengming884@gmail.com>=
 wrote:
>
> > From: Cheng Ming Lin <chengminglin@mxic.com.tw>
> >
> > Enable randomizer function by specific flowchart to set the default val=
ue
> > of RANDEN to 1.
> >
> > Randomizer introduces two new DT properties for child nodes to configur=
e
> > the randomizer functionality and coverage options.
> >  - mxic,enable-randomizer-otp: Specify whether to activate the randomiz=
er
> >                                feature.
> >  - mxic,randopt: Define the randomizer area per page.
>
> Can we create a global NAND DT property for that? Enabling a randomizer
> is quite a generic step.

Sure, I agree. I=E2=80=99ll update it to use a global NAND DT property.

>
> > The penalty of randomizer are subpage accesses prohibited and more time
> > period is needed in program operation and entering deep power-down mode=
.
> > i.e., tPROG 320us to 360us (randomizer enabled).
>
> Do you want to share what is the added value in terms of lifetime to
> enable the randomizer, given the drawbacks which are significant?

Thanks for the question. I=E2=80=99ll describe the benefits once I=E2=80=99=
ve finished
organizing and reviewing our data.

>
> Thanks,
> Miqu=C3=A8l

Thanks,
Cheng Ming Lin

