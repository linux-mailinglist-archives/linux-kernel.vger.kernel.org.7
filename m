Return-Path: <linux-kernel+bounces-804562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA1DCB47999
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 10:29:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69A053BA99E
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 08:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE12421B9D2;
	Sun,  7 Sep 2025 08:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BlSpBZB7"
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D743FC7;
	Sun,  7 Sep 2025 08:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757233757; cv=none; b=ftF1/rvUsB92eVFUf4g+tdPHdLQNmxbXOcvT9iP2e2/wk1S5fuJbNKAhUNOZgbFjA3CUqCLA0I58q/BAtGds5lpcrJSckKa28j59dG4rVerIHPXcj9NjV5HFci4ExxgTquC+k++gV83RZDksey/r3DPtAbuGcd+VgnmeubKmvOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757233757; c=relaxed/simple;
	bh=zHL5OUhPXjp6SZHcCKZnrqqQKzlZOLlAcjYf8xWBt5o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hvWwcvLv0xzqGfwjTrL71++J7dZLwRvK5DE3QcsoI71y4t3SIrH6adqMdIvlS9apIQmbW/4djWWJh/Wlo4cMUCrw5Z+5Y8DVtitpR8LvC3LkEifCLivwQxXq9NRuN1YVQIBjxsm05kBHsSpQh74Z3n6F0468voarbejbZzgDFy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BlSpBZB7; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7459d088020so1779979a34.3;
        Sun, 07 Sep 2025 01:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757233755; x=1757838555; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zHL5OUhPXjp6SZHcCKZnrqqQKzlZOLlAcjYf8xWBt5o=;
        b=BlSpBZB7aSMinDqBUHZibzhRj3Ar2GdnjpFwz3RKZOq6wSTpE0vsqiqde84iqxJt3Z
         3DxgNBdaRAa6hOPptIbLaK0CXHmkrfGHjBCDfq/z8lf3t3eZ0CSTaazsPd1rmuBAnFR7
         WoNBVtRJvBuX/EBVpqV3sfsk7Bgtrb7CJi4smoynGYnUcvxi7f8RZRU5eUNmSUAlqEYT
         Mu/I5fim+OVk9Npf7eefebc4EssEhzYxNRvxYJZIsrtCUDSTJpANzFdoOT78N2MVTlXV
         0Qu+YimjTPXn/wtuGFLILl6xsGVRXf8O4eRnH8BE0F3KdjXPFml8cUnkLrUGyLMQTXsf
         CIbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757233755; x=1757838555;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zHL5OUhPXjp6SZHcCKZnrqqQKzlZOLlAcjYf8xWBt5o=;
        b=ZVRyKS3QV8dL1TeCHSg7gpgAI3XXqECkF317zrpkLLiQT2W62M+XSpWRgQd6EAza4X
         37TgxHi6vAhmx3lcbCL2tR+d6vHg5MoM2oH5R96S+2Wxh/NonxnHEamTB+gXCsSCiwfg
         l4Wi8Xq+gCXxsWKueLlwryMrFQ7yaADtRAL1yKyLlr+MaVRMO4ayZc3jvvunfLGjbFZD
         DTkLvmiPPSztnYNIXddqkyozzUa/2gzwgUjD5PVCQlWA8NuzP3Yl/AdHmHb6qELmOshr
         rEF5y3Q7ctQpjQ3UQ+EDkxydQNGnLatDkFj1z+0WSVorIyezjgxOjmS5ihZU2fLePEdo
         +tGw==
X-Forwarded-Encrypted: i=1; AJvYcCVB0TqVnRL1xp8OXUENvo378Xx8p07YewN9MkQ0NhmgA9+5gFrV9FV5mJidZIlWakI6GO56HQ12EnIwxI+9@vger.kernel.org, AJvYcCVQvbDhr+/yYPirVEEEQDGTcNuwF400uiRLQVeBDMoDhl4as0R4yq69wfl9yUzuzcJNtgSycdIE/HlO@vger.kernel.org
X-Gm-Message-State: AOJu0YwPIg7/xXCvCgOaPWGOLxjhDfZJKf9ExoaGYDctjr/9UMrjFlXC
	amaRVZb5yKygVmtKwTQk72yolAQC/tKyuG/k2icA9rxLboBqAEfW79Rnhed3XrNbEWVIy8bGx1b
	EdUVg7XjRp5kaYZrbFcyfXtB1ntUnMMk=
X-Gm-Gg: ASbGncuEZbYQd5iSMiV9M0Eh8MhIbRld1hgSHp+wuN+2RaMm1MtUE3jELKMdGtEZqDH
	z8Z0gb6aN1aMKW0szpSvX85AwlsKqnSHgRgCLL65DYyedgUuxURovzU66RGVSRABRPf4q517NKH
	sTsmxhoViWe0WWCUohmTVnw4IDTzJT4BHT4qhokW/vQdbH+LzF4pWlhACDknZ4hI2ELylSkX6uO
	fpbjyA=
X-Google-Smtp-Source: AGHT+IGyh8ld+6tQy/RCVtIqpvu3UGrTFhfuBz4MseUwlBWxJL0WjulAhzGeEX21wQaQ+OyTZiS6u29Qftewscegmms=
X-Received: by 2002:a05:6808:4f27:b0:439:b9b4:2d86 with SMTP id
 5614622812f47-43b29b114abmr1874556b6e.11.1757233754995; Sun, 07 Sep 2025
 01:29:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250902142749.13724-1-kusogame68@gmail.com> <20250903074205.GB2163762@google.com>
 <28c1ff61-8510-4fd4-9cd2-0e3ff4fe3a02@kernel.org> <CABZAGRE=6Dg1npRx-jmcycnGMkbtmY6A7E=upffeQ+KANTqcLA@mail.gmail.com>
 <96e6578e-b21f-498e-82f6-eeee3ee81e20@kernel.org> <CABZAGRGof5e=mwpfmEgE7W+Pn5gS05ei7io8e7C4tPfkvz1=Gw@mail.gmail.com>
 <ce631cd2-c00b-43b1-ac61-b38e1848b729@kernel.org>
In-Reply-To: <ce631cd2-c00b-43b1-ac61-b38e1848b729@kernel.org>
From: Nick Huang <sef1548@gmail.com>
Date: Sun, 7 Sep 2025 16:29:04 +0800
X-Gm-Features: Ac12FXzjWYhVSL6pLRke-nKO_o5nQ4XreN0pF_gxg52k8J1nJ-NqvWQoOORoo4o
Message-ID: <CABZAGRGqWXgKWT5ReyK_tZXTfNWBn_hC4Ctx47gY5b2=K5YeUw@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: fix typo in documentation Correct a typo in
 the documentation by replacing "abd" with the correct word "and". This
 improves readability and avoids confusion in the description.
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Johnsodn Huang <kusogame68@gmail.com>, Lee Jones <lee@kernel.org>, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, weiyan huang <dory85109@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Krzysztof Kozlowski <krzk@kernel.org> =E6=96=BC 2025=E5=B9=B49=E6=9C=887=E6=
=97=A5 =E9=80=B1=E6=97=A5 =E4=B8=8B=E5=8D=884:17=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On 06/09/2025 15:09, Nick Huang wrote:
> > Yes, I have read it. The subject and the content were mixed together,
> > so I will reorganize and resend the patch.
>
> Please do not top-post.
>
> The question was not about subject and content. I just don't believe the
> DCO chain here.
>
> Best regards,
> Krzysztof

Can you tell me what=E2=80=99s wrong with the DCO chain?

Best regards,
Nick

