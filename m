Return-Path: <linux-kernel+bounces-832799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A739BA064F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 17:40:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 650591884AE4
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 15:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C524C2ECEA8;
	Thu, 25 Sep 2025 15:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="myXWvPby"
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A872EC097
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 15:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758814686; cv=none; b=AYZy8VkQ2zBvOnMsLYIKzs/h694+uqcCDNzH8JDgx7Igv0fK5hNTWM+25p9Ja8vx+hi9dWU7p8cvcgt4QmwUKi1EfTpj3E6XehzWu+8MoM7ARCEellF4MqzyV9jyrKkCfsnFGps0UIinP7QiyeaO7+1cYdyDrW0BJHffZ8PBEss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758814686; c=relaxed/simple;
	bh=ZWKVJQhQO85PFVLst/dJeOTjr8/6ZNeNAjSmlGSuq6I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VVfz/43l9OstObTIFnMzjqa/vseVFs/jJiaTJgADF9MTEu9c9S7n9jwenxZTH3qp+jsKy3lkxTG3ZcJ0XMh9vFptxSE55mj9OVTbmbzwpGlNYJxphumFkSHR6+LklpvUfHiFpfHMrBT3f4yBMO/G1sozHRofyxz0xlFlsRkJvMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=myXWvPby; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4d142e9903fso9332091cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 08:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758814684; x=1759419484; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M8i0IjZD3Pct6jS0K9QzdWLgF5ClOIU5SO5hpVGPEko=;
        b=myXWvPbyPVjpZDv76uP6DojN5y0CIitAIxcfDZQ/zSxsVfzb0jxK+TjRAvPr4kPoT4
         TnFEZXc0lu7m/+so65XXeWJ5xGuIbQMAPDBApeWM1Qvt8lljvz8H4FbRMfF+j5SFj5UM
         KXRk76KN1MfRrPe3TSmixWplfKRFxDu6qDAbNP+se9MqGoin6ljB4cDsQgJRBsiyvQjf
         LXvKtj4zmRBDzySKl/bTndk++IuZC9auijOjWkobUEdATO5ik52SlF5o5BWShjPKm6GP
         mYRp8PJphFbcdVs0shJ20h+fI9l7vM1OmBUTE9FOB2j+0wMDA7DaKGuy6LL9ECWr9vH1
         REEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758814684; x=1759419484;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M8i0IjZD3Pct6jS0K9QzdWLgF5ClOIU5SO5hpVGPEko=;
        b=fh3oJrA979MCwjUVGTPAOryLsnJ41wHFPqHElobI8mfVgaMxRdebNFYILzRAP9hJTE
         rvbXrxghIg1yCK1b5fSkIW/v/mKLy3KXHe5VkqARBsvtY6BcQUyAG29pAxGo2fK2utpK
         mFJThu+M7LGFyDV4llHByUSTroX9e7wmM0clnAtihtYfWX7fOO5Vm4G+lrAR+adu2EXh
         FsWlZjmspsBL6pNndprhFQRiERajVarZOUp1Zi5pEN3jfzkaPckrSpHRdYNoVnMY/FCJ
         O2INhmWfzaSnJSP5N1FnafTH5/FebiP5pNERSCzGnqfHPKaXrGEmUgbu4BshGbMQfqt+
         TDHA==
X-Forwarded-Encrypted: i=1; AJvYcCVLrxg+oFUcIV0YSNw5GCZKghUbfDBk0W9M3yo2BwQCftGOVze3/ILt+zbAkFc6Dp7fQTKAm5ofFiNuZFw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGXZCfEen00FGCzws3bDvYXAxix+gtcsySbw4MDk6ideL4DtjX
	5kctNGDPyhThmtf4kbu4g3WQNe8ybOrcIUcgccpQ0ITirckWicXNCHM1wDDGUjflfUclc6VTozS
	2eGenKoPjhlHlzBr3b2nRZxmrgYgT6bM=
X-Gm-Gg: ASbGnctFlVpcNMX6HQZ2CHZiee/fb2n5kx8CN0ZW/rcRJ9mihE6ZLTGCO4mrHFv4KKC
	QEXsl22UDGqhv5n6tC3bvkSfLwUpUaQItr5+5ibeqK8US4AmA6axfrdSnWkhS0jJU3acMBZiXE4
	26jlu19lROo7zaM/L+qp+d+LbhwAPkq6W1GEw7PyHSQuu2RNO1bnlSJrWiKHrcXXPIT0PsIYHff
	+UDF/vG373D1gOMHJ3HYdscRSndwhFHm1/8GqIajTXIzVCBRNZVv4QdpehApdN79/4kBNRoA2EI
	hhJLPBmoIen5IgdZCXPqODny5dzU7+V9wC1kR4gF7zDfxOb2FXQVLq5GHfl55L6Fpq1Xd/ZlzKd
	VL+sYBKW4mZyyYduV8Xq9FQ==
X-Google-Smtp-Source: AGHT+IGYkjlNqAquvUGYdoars3aCxUqWAyfn769FJVVQKoSImqe9jR4JyUdk8MOEby7NGucpyFW/cShWe7F8c02WdP0=
X-Received: by 2002:a05:6214:769:b0:720:8825:f1b7 with SMTP id
 6a1803df08f44-7fc2874431emr49445596d6.9.1758814683507; Thu, 25 Sep 2025
 08:38:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <392013e6-3012-46a1-a2b9-4ee932eca80f@sirena.org.uk>
In-Reply-To: <392013e6-3012-46a1-a2b9-4ee932eca80f@sirena.org.uk>
From: Steve French <smfrench@gmail.com>
Date: Thu, 25 Sep 2025 10:37:52 -0500
X-Gm-Features: AS18NWDFGBwy8fo1xBeNF2K95krRG1ryr3vbF8PehvHoSMfuwAFIeXdhWkMK76o
Message-ID: <CAH2r5mu8zURNZWKYbrUmG+mDXpCBjwGY0x0hOU1MYdjqfXo-=g@mail.gmail.com>
Subject: Re: Missing signoff in the ksmbd tree
To: Mark Brown <broonie@kernel.org>
Cc: linux-next@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"Stefan (metze) Metzmacher" <metze@samba.org>, Namjae Jeon <linkinjeon@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Metze fixed the missing signoff and I have updated the ksmbd-for-next
branch (also now has fewer patches, and some he has reordered to be
less confusing)

On Thu, Sep 25, 2025 at 5:55=E2=80=AFAM Mark Brown <broonie@kernel.org> wro=
te:
>
> Commit
>
>   d76f0acc84fa7 ("smb: server: make use of ib_alloc_cq_any() instead of i=
b_alloc_cq()")
>
> is missing a Signed-off-by from its author.



--=20
Thanks,

Steve

