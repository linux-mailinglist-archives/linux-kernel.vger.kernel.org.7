Return-Path: <linux-kernel+bounces-804137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 039FDB46AA0
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 11:14:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98B8D3AB8B5
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 09:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46B232D5C95;
	Sat,  6 Sep 2025 09:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JLamOT5N"
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D202D73A7;
	Sat,  6 Sep 2025 09:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757150033; cv=none; b=T4ajEg8kuvQp+eAXqMxNFDpk6pnMVZC6RuYXaSBBjOWyIzKxKsxuI8xErkdI3yI7Oa3OjF4DS/I1+D3f4/dT/it7r/nV5utco8nYG3CAAqVK4kGoF8kHvs3gj7F7JQpR5CLpfOnkAZHVZgsLHTPyxG2r1ldC4wxvBbBr/2x0hYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757150033; c=relaxed/simple;
	bh=pEaxKZiGIzaKXy7ev8IeQNkQBCqan6oqOpgWyWdmFg8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BW+OxlD3KpFvUDTZpUBfgxl3xgroLt4D4vCVQCMolRjl+RpWLrp9pXYvacp3LT73FeDBpBbs2JQ19B6dcCGhy7aZwjei8CVaA+ucTZpGHpySZjcKd3Q5JPTIloMr+7WIuQKO421T2wwbTpCmYMlIIDZRglyV5nqoKf4rjIWlYAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JLamOT5N; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-4381cdb6100so313055b6e.0;
        Sat, 06 Sep 2025 02:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757150031; x=1757754831; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pEaxKZiGIzaKXy7ev8IeQNkQBCqan6oqOpgWyWdmFg8=;
        b=JLamOT5NlLXvsEmWiWb4E4RXcBTO13/0ZNyH1UG1/Ig1ISfO4AzviwB1ps96+4xDbG
         LGabqjhS8wKrZHHANw4h9a5sikOq39HMLqZqoB6JqfGpiY2dq6BkGCxfOiskr9H5KMRI
         YGrZBYXf6GuzFUQUEM5vYJBYD9JYDPqKXpj04i7n9Ufdxb3iBiPOhEU6yUaW47ldgJ4c
         D1DWK5x77c4zIZ6WQSsdSxjRZd6/Lzqed5rEwe6cyOuLaxc2Zje/bpt5qWYocbQycaKo
         vVEjaIewiRHgHiQlIbJrj1xB8dCXEeYQ+iEOMELdF2KDPfQUlwCZVQIVwdfLX9ZDq91u
         ATdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757150031; x=1757754831;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pEaxKZiGIzaKXy7ev8IeQNkQBCqan6oqOpgWyWdmFg8=;
        b=WKHYagaMBM/D00czgNSEqgIorE9yhju1FCgsjmpJtLtZnTV8n5idxs2cNkBOSe9XGx
         d9SgzfF7zD84NiUSfzfI2uIl0njesJA4tATzWAkBKthrnxZZ2ul8O3YDC4Gsc0kWZtSA
         3+vxp9R3ZnwSBwy0FBEphLDVVbWTlNfgB/TkH18ynnod2LCgUS0hWj4j2NfZfuBvcRu0
         SASgqXvlfw+2OIX6beQdMqcyV7iVsNqir8EYjFOWWFUVWarKZTYjxRM1je/3OH/aNltj
         nt6JT9cpIpZBrp8iW5/vH3LkUdge9DZ1xIjsT/jm24AT0tu1rIHNBDI/ne5YAudputl+
         fuXQ==
X-Forwarded-Encrypted: i=1; AJvYcCUea15V8+2kTZcItJDNT+RSd+V2D2MVKtRhQdJUsmlPxfwWNUVZ9BuakbeSfCQ5E0cjJM4idxGvCiLj@vger.kernel.org, AJvYcCV2H9pZX5v/i5cg11u4o9Yd9wfSBiM4aTqdXDblNS+HN877LExJ0JxgO1VXpudlChCoVi8JnMHetcS4gfJj@vger.kernel.org
X-Gm-Message-State: AOJu0YwhWIWyCqMA2ISI90YJmEO26ScQTawIoDUV4uH8XfOEhxR2w5mu
	zeLQCHsU1USsLs56ZJrrQ3H4wbOHVcFbK8bZwl7uF1M4wLXu7mnhnxxpR4NBExRRiDOk25509eK
	UVZEAytgXZSr/x66delpUCINpOF30gCs=
X-Gm-Gg: ASbGncsEi8pUQcUcreZIAN8qYT13GCTAPW/JcK1JEHEpU+eQHaIsy2FoJv6596eHbwl
	qHVpchBZ8ZOAjn+qr5lc805JhN1wMe/k6hYKomGDxatN6ww3Rs7KOYLMtKSYh2sXjMaQ1t0EI2a
	ZEvAxYXFL1VPcDZ0yBiKpMeV2zXptkuWTZLr7MZFGx+JafnrVRlf2cASBBTd+ayCbVjvD2QOh48
	ENahBvO8NNBsDGoaw==
X-Google-Smtp-Source: AGHT+IFsF96eoSj4k+lbood33wsR+iAjs63neUVdknxMDm5hwOGW73MKSx+gNkoPB5kasZ0CDicLEFrEssaeogXJ/5k=
X-Received: by 2002:a05:6808:1804:b0:433:fe80:5404 with SMTP id
 5614622812f47-43b299dbd54mr801049b6e.5.1757150031169; Sat, 06 Sep 2025
 02:13:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250902142749.13724-1-kusogame68@gmail.com> <20250903074205.GB2163762@google.com>
 <28c1ff61-8510-4fd4-9cd2-0e3ff4fe3a02@kernel.org>
In-Reply-To: <28c1ff61-8510-4fd4-9cd2-0e3ff4fe3a02@kernel.org>
From: Nick Huang <sef1548@gmail.com>
Date: Sat, 6 Sep 2025 17:13:39 +0800
X-Gm-Features: Ac12FXwdOyl87NwPd24rV5zrWXvoiMbEGwDue7ElzfeenKKWlvHLA41-lwqdGaY
Message-ID: <CABZAGRE=6Dg1npRx-jmcycnGMkbtmY6A7E=upffeQ+KANTqcLA@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: fix typo in documentation Correct a typo in
 the documentation by replacing "abd" with the correct word "and". This
 improves readability and avoids confusion in the description.
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Johnsodn Huang <kusogame68@gmail.com>, Lee Jones <lee@kernel.org>, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Krzysztof Kozlowski <krzk@kernel.org> =E6=96=BC 2025=E5=B9=B49=E6=9C=886=E6=
=97=A5 =E9=80=B1=E5=85=AD =E4=B8=8B=E5=8D=883:38=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On 03/09/2025 09:42, Lee Jones wrote:
> > Looks like you corrupted the subject line with the commit message.
> >
> > Please resubmit.
> >
> >> From: Johnson Huang <kusogame68@gmail.com>
> >
> > Use `git format-patch` and `git send-email` instead.
> >
> >> Co-developed-by: Nick Huang <sef1548@gmail.com>
> >> Signed-off-by: Nick Huang <sef1548@gmail.com>
> >> Signed-off-by: Johnson Huang <kusogame68@gmail.com>
> >
> > It took two of you to correct the word "and"?
>
> Can you respond to the comment instead of ignoring it and sending the sam=
e?
>
> Best regards,
> Krzysztof

Hi Krzysztof,

Sure, at the moment this commit only addresses the typo in the word 'and'.

Best regards,
Nick

