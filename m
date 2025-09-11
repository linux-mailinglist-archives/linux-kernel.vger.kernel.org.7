Return-Path: <linux-kernel+bounces-812731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1447B53BF2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 20:57:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E90071C23DB2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 18:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BC8C23E23C;
	Thu, 11 Sep 2025 18:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gV3TjGJ8"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B222DC76B
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 18:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757617020; cv=none; b=QkcTPHtuyV+6VX3S1jd/Y+jP5IuvVpOoaSnXEZTqiZMPJitj5swS9/FQhgkewxTAQxGMfyxCPUxzaucVuVODjFowcJ3J798ih/JGvLtQAiKyu89rctk/wmCUlDoU11SxnrAQBVUQ7QtB33UZol1OI/wq8RWJN4ghoDbFzF1xZUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757617020; c=relaxed/simple;
	bh=+LCm/guDeyM1pbOuWuHtb4/FeaKd5L/pPsDtV39K60U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dJJwT4tFYj9YSNa1CUPRyNubffi4HjSL7r5PiYXWsdgSiywb1+WoGo0bZV8OWgPOaSxucU51DerLsTQxWJwW2Ckx06ZT0n3lcuZvCmZPFfC9VHpgFh7PjRCnFrja1thxhmmrRZeNLrUqrUXCS/OFoxebidcBxUgQPWjKHkeDeFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gV3TjGJ8; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-24b150fb800so2008905ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 11:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757617018; x=1758221818; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+LCm/guDeyM1pbOuWuHtb4/FeaKd5L/pPsDtV39K60U=;
        b=gV3TjGJ8LnGmlHHPLpbBjReQu4ixKleZIm+ZD8DQT/YaZp907tWks6PDPJUebnRUnl
         P7wPAFvCMCGGG19H+7G5JfoBk+FNQhall+k6zD8FCOmGX4XIVcmoBc341XWlUAquZatm
         gRWw2/U+Vtdg6zPS2as7Ge1EkcwyMR2zd7HHoDYlNfAyz2bX3gVCv3Tq/5ng1glov7R0
         gaFdCr1T0pAErIV5vfcEAN5kAML54NnTTpFAs/iZ1pT5BlzEVS/x35DEyv25OJCA/3vd
         f8vhRBq6gMNy7aZpsCaE6kT0LS6ghj6GNR3Uz9uI7sDwpQCba1DkJcfNXPNcqizxVBAT
         5HbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757617018; x=1758221818;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+LCm/guDeyM1pbOuWuHtb4/FeaKd5L/pPsDtV39K60U=;
        b=DvlyGZf55u9RvFAGQ/H4cbU09nnM7D9AJj3Q2zun9+RSTJTQGv20CdOr0TW0ydiLPx
         O/IM2QFFtdQw4WelvNQIIxZxA+adNkLD2jWeGQBUawEpVPB6JdH3cg4Gt9k0cxydopzl
         YKBMqIPBfj4NN+OmxYf0ktAqk0wXf/KV5eNnpNNyNIT8TxAqx+4Vmp8m0GZfTumZjVqg
         S3hrajSwQi0mrlt/dena/ZEySNtm5uom1XhRGh43VSCK8NIapVvtPw82rAck0lwAtP+0
         sanWNS6hKuvA7EYYEJ7mLOdlIKoKPeyFjMuwJ+gNIeMLN7wuBgEX3bcNrwQlKXBocCSM
         x2wA==
X-Forwarded-Encrypted: i=1; AJvYcCXFFhLEjXftFMW12fbT4ItUm4AkNA3pN61ZLuwSj78K0oFgOd/1XqwWSk3krmJOKbNoVxUiGtluqbrSM0U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeuGArvMiGwg6xet4hFpC0KmyEArB03NmGV8XqP6VJQ6S8OPVx
	YHzuqZgF0760/oE6zLoCDWRZw+fRo44eHaFO8ui+m0q+tJ8pohTDILLiU1g+iV/XFDx+wj8siul
	PVo7Z4JG289aGsB22M7zzAw7e3klauzA=
X-Gm-Gg: ASbGnctrOCZy6qnThkTdFqkRVc+IHZ/lfb6+/xh4e324HRs1Jq5jGBV3w8lTXF1lV21
	28XD9k0+AzdI2nrL7rhZtdjVzec0WjUKDu0xvueovnymKuxf6PXwHuVyx05+41/+U3urkDQF1y2
	LZfPo8/2Z27g3+gjLFy6adPHcDzSFqLTrABfyqCgYV5jF7o64I0Xoj3/1h+M6V9v7VpgNZ5vjfn
	ZvG6/SrWF96ZkT0A6atmVUsbDTpuxCnBsKQZDmJPWlCrgytQKm2mGoDiPl0PcnorO3NyNrKaTQh
	ORiod4Jn5hvLvDmofKxgA6x11RwCl8GfVG8X
X-Google-Smtp-Source: AGHT+IHNFxuMr0HNx3D6r2wcpirNJhsmcZ57cU/PHQO1QLIR7pH1pxNHnnOqtqoIkCYjHEr/A+GFV0gytg3T57f+NhU=
X-Received: by 2002:a17:902:cf4d:b0:24d:5f38:ab67 with SMTP id
 d9443c01a7336-25d28f02f06mr1425645ad.11.1757617017970; Thu, 11 Sep 2025
 11:56:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250910151216.646600-1-hca@linux.ibm.com> <20250910151216.646600-2-hca@linux.ibm.com>
 <20250911013243.GA292340@ax162>
In-Reply-To: <20250911013243.GA292340@ax162>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 11 Sep 2025 20:56:45 +0200
X-Gm-Features: AS18NWAUx9lYss-jo7KrNo_jJvvrg-Q82uuHNeRXFQerGQpzkza6gztmm6xMjOU
Message-ID: <CANiq72mr96hE+7HUVedpqyg2jePYqeXGGgwpdPWb4Z_Dj7htYg@mail.gmail.com>
Subject: Re: [PATCH 1/3] Compiler Attributes: Add __assume macro
To: Nathan Chancellor <nathan@kernel.org>
Cc: Heiko Carstens <hca@linux.ibm.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Juergen Christ <jchrist@linux.ibm.com>, linux-kernel@vger.kernel.org, 
	linux-s390@vger.kernel.org, Sven Schnelle <svens@linux.ibm.com>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 11, 2025 at 3:32=E2=80=AFAM Nathan Chancellor <nathan@kernel.or=
g> wrote:
>
> It may be worth noting that careful analysis should be performed when
> adding this attribute since clang's documentation [1] (more on that
> below...) notes that it could hurt optimizations just as much as it
> could help it.

Yeah, it can be tricky, and I assume it may depend on the compiler
version too, i.e. the result could change over time. At least for
"build asserts relying on optimizations" it is clear if it stops
working, but here I assume we may have new compiler versions getting
released that stop doing what the developer intended. But perhaps is
not a problem in practice for the cases we care? Does someone know?

> Looking at this link sent me down a bit of a rabbit hole :) Prior to
> Clang 19.1.0 [2], assume was an OpenMP attribute, which has completely
> different semantics and errors out when used in the way the series does:

Oh... :(

Cheers,
Miguel

