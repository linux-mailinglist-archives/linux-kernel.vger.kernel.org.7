Return-Path: <linux-kernel+bounces-812737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75689B53C01
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 20:59:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D11A5C0198
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 18:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20AD3242D9E;
	Thu, 11 Sep 2025 18:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aUVASghm"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D4C2DC76B
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 18:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757617183; cv=none; b=CKz7va7z3SliSU6D3MWrPdtJTmrF/2rS7CZNLVLKKpir/RhdkS2g16mBRHX2X3J9tOmTZTY93NK8vGfYUAc2umICpdiHVfQeqtV1FJpkTz6J3NlmMETOIzi6bIzP6QNTZhxaD/FZszZ0uNlPrSOvA6TDpMCa7wFf48q1h/FmC+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757617183; c=relaxed/simple;
	bh=SlHbXoSOWKIKfOiAlhxlkv67/qSC4UpXFWS+5u+yVPw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bGbQHwUJsB+96AdvymFQSBJ/2ym2vfqvgGbBqaR6VpTi/xO5lEBZkwbL9L8UkrEcFtCu8iljvF5F0dMSMxDSlZ+mOywg3ciKoHHz7fE61uiBsD6m7Cd1IlZpvny40qhAlBNyR24fL7iAgtPTmVzR6h4avvGT5ddST+8V0d17Ow8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aUVASghm; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-248e01cd834so1297975ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 11:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757617181; x=1758221981; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SlHbXoSOWKIKfOiAlhxlkv67/qSC4UpXFWS+5u+yVPw=;
        b=aUVASghmtNe7mfqylEdSHQhbn3aeaxn178ztITBznZAdXEN71EzpJ/GPKetlnJ3JLm
         r4tcSDHFSiEaThAvFy53tL0X+6iDxZFO+WaWvN0KmgxW/gAfbjjLCplgcnNIzeOdkdfr
         NOzMWK925Pnqy2inGT16DnBCKQ8KB1XCRzX71K3LCwcxZhnz/KO4Xo0KwXQNmVhGq+EH
         W5XXS341kzwPjVO3mDGBXg5VrAaWdBxEbdWpilqZtjdJK817vutotdc3IZ9CMVSiVtmM
         uYnJ8+PZhVQ+fL1wJK3l0JFfCrzOiIaNk5sNeQuhlepoKrF/OJ8k4tpDdI/NgyQAWkW4
         OARg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757617181; x=1758221981;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SlHbXoSOWKIKfOiAlhxlkv67/qSC4UpXFWS+5u+yVPw=;
        b=jftZwadTmXjg9LHzrbYCYIVJQzzAdq23nv40fogUMyTAu1eLlIu0hK3VCVWovsGScr
         EBBIfPqkBY+TosibkjS8e5z7RGGXDlcurwENXkiyDX3PeMekJBRMPN7g6fMF6UCssR4g
         ++s1TrN2igmT3UvHdFh/bkao8wD6w6HXLrGGxj3qFf7CntEUR1cFb8thkxA/U5OZzEDO
         tjHbu8tKvhtfB/uB7IB2RTlDc+ag7XOTUMqJCVeCzyXZvS8uxxZmIVjVb+NimEQn3/dN
         N+vnO/BmUjB7edPQCe6M/kZA7zo0oAiYPkmTXO4Wk/katxdkfEjsGFVM6XuOaj1y9WMz
         qZIg==
X-Forwarded-Encrypted: i=1; AJvYcCXvtpPrGX/LhT3sewCOZd5Zo1PE0V8jYKt8h7XMUL021xBg89kzpDz/ukvkEVkqPCWx90Yvf+0cOgz2dbs=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywu6fhpsGDaw91bG1nVTSy/vopL3pZrqz/kmXAG1y97afCivQdl
	xfShzxCYMq4BE3STKuRzZdShK+SW8ww1wY9LFjf5S6s1NL4FUMZZnagNAIYanxa0/O+0raQ0Hba
	AxjG+ezHgXWbO0jz9SBfbbg4ry4oX0rJMzTmB36200g==
X-Gm-Gg: ASbGncu6fD0Qt7xYV/C2Aw5r8f1Epsni3baWriP0BZjcSYHIivEf4gb51LkZf2Inq9p
	ckIKOXvcdF4DRbecN6IdZuRfHSyxahPUs9au5mppP/xA56MPtZi7if9aieQ4a4Smq1ylZqocoRS
	nF65PbaDq8jG89Tus69n9nDe3Cg1gkxz4DXIv6NGFO7pdP5xO8YVK66H2rxyVl5Eq6lWK4ypNBR
	8/jo3HOL23NlJ8cN+Z5w/29x8MoL3LREFWWMijwyZU+JiqBD9Qknl8NbMWbehuqQ0MwcNlx6l/J
	bWg+c9HDGegb8rqu6B0EoLuPFw==
X-Google-Smtp-Source: AGHT+IEhGdAk/TNo3Vs7pJWsw55XwaHN0nNz2mZsFk0wZRa5eWpKkDagr26WeKkx1RHB1o3lH8jQ5UjqAcD9F1rf3Mk=
X-Received: by 2002:a17:903:1a8b:b0:25a:4437:dbb7 with SMTP id
 d9443c01a7336-25d25e85badmr2097215ad.4.1757617181630; Thu, 11 Sep 2025
 11:59:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250910151216.646600-1-hca@linux.ibm.com> <20250910151216.646600-2-hca@linux.ibm.com>
In-Reply-To: <20250910151216.646600-2-hca@linux.ibm.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 11 Sep 2025 20:59:29 +0200
X-Gm-Features: AS18NWBsSbFpEMa9h98MxMUmpHPD8j33LPQt4-hBhwPvnoo-tvGMMll9crK-jFA
Message-ID: <CANiq72=Zhcrk-cvXX+75mQzqUUwQznkZmLTCoEn0XNs62meUtQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] Compiler Attributes: Add __assume macro
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Nathan Chancellor <nathan@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Juergen Christ <jchrist@linux.ibm.com>, linux-kernel@vger.kernel.org, 
	linux-s390@vger.kernel.org, Sven Schnelle <svens@linux.ibm.com>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 10, 2025 at 5:12=E2=80=AFPM Heiko Carstens <hca@linux.ibm.com> =
wrote:
>
> + * Beware: Code which makes use of __assume must be written as if the co=
mpiler
> + * ignores the hint. Otherwise this may lead to subtle bugs if code is c=
ompiled
> + * with compilers which do not support the attribute.

I am not sure I understand this "Beware:" comment: is it referring to
evaluation side-effects? If so, the GCC docs say it is not evaluated.
The real danger is triggering UB with it, but that is different, i.e.
one needs to be really, really sure the expression is true.

Cheers,
Miguel

