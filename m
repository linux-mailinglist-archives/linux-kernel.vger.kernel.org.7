Return-Path: <linux-kernel+bounces-887233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B8F9C37A39
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 21:09:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9E163AC4F8
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 20:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14CC03431F6;
	Wed,  5 Nov 2025 20:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="a9HwoIFR"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B543203A9
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 20:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762373286; cv=none; b=Ubz7AGmuiIyOLPpnaMj+NOllTG+ofNqpDWIussulAF5/LsRMr+9+jORdQ6a9X569VZc6t2UzXxlItDqDpekIwlNvhSy2Gs+ukwON5lebP6a/TZOONiNVHut6FgeVHG/dkbuRHqbokkNRD6632K7x7W9C8RRhFN1WNBZ06hdeCVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762373286; c=relaxed/simple;
	bh=/9NPS/36qIpecnxYZK5IQFnwk48VDFXst5m2dce341w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b0lt1g67Cqy5Mckal6ZFJbXlklTGfZr2ecjhCxax3E7tfBamDZmXVOHzQPRcTNyBQXc56MTm3N+qnFI7pYg2jC1019ZhTLJu3lBcDBINtqHiSc24u2qCiI2Y+QS9tWvABkzpgQQDsrIqM/kmkmufK3vzwHPKLQzC8bNuqrf8MCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=a9HwoIFR; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-640c1fda178so292163a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 12:08:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1762373283; x=1762978083; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ST1oNBMS4hRThDaChGSDv3RZNfWOxmzM7Tq7eDcBdgs=;
        b=a9HwoIFRR692XcOOMwTseBLqYKsP2QeC9SgUwQiIAUcJesW+u30oMCtf8sWzfnrl/l
         6FwUrq732N9dt8cpMGUp4ixRiPXJX273GVfuZ28HeIPeeiVNyIKfLsNd7NJWdn09pEch
         BbX8BWQoENgsMZULdpipNDFbL6JWpamBIL4zU1X37cESt+5NJ9mdeOhj9CF+r/UziEhB
         hwHk3lsZP9eQUWz/R8cg8yfHF/leAky9fNFRP77xG791rEV5OB9EQOkaa6Oo7LX6CY/v
         tifPYJPllH1lUJKKBfP6JPkK3WME4A0XAuQM1h8rbDCjZMPae3Tvcb6J2lznaEAc26It
         uSxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762373283; x=1762978083;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ST1oNBMS4hRThDaChGSDv3RZNfWOxmzM7Tq7eDcBdgs=;
        b=nFblzOrH8IRJy7c1uVMvw924b+Fs7iqhZGSgPrQQe5ZA/4SOopXhYQlxAxXUONstdU
         ioAqMSaal9a4+0hj1y3JEFxKL3GZlsH28ZHN359xR92wgpCaTM/tSTqNzXRb5Z4dQpvW
         /ipklWF7pdFeTpy9vF8O9uQb+4HT/kUkb90/Gu2knPtJAEmUI9wtDur40p9eB46mHj1Y
         x6KGX3ZfzxD2pkQvlebImDDmmzuupBE/FNF18gr9D928pseScPk4XCOTMNaHg9OvSozD
         jN6Qweif2xPJRYL9hY2Xw3yyO3wxoLB8bh66BTede6V1DKTx5KeOjAN//3tFxy1bCfKM
         eLMA==
X-Forwarded-Encrypted: i=1; AJvYcCWHRrseU8vFKBHo+jY1qGliPVhHb8bHN7opcopWB35S1i1lVNEr1Hn5xldPNzBqyOT+x/sOUFYWry4XozI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/EpbKTd+2mV3T/8r+FJuiuJLs9umM7uE3ZALpn3WKizJrJbed
	+BOQMd/opF+//wsnOHr6ZLPZ2CfbnCzExTIZ4/zzyKuMnnum8fNQMC4vz0I0B3NYzHYEAtw2A0l
	Vdlh0No7E3wrZ8XrWwcAzjZ7ZgOlzUAHJuBMEvBxKWA==
X-Gm-Gg: ASbGncuZdrz1QwfahtM/BnG5rH4kvnITjn/drES6rqCa+WtT08zsBJOTiPJ+e9gYxX1
	QG3tSHYzsxBBXXgSAVTwhlJmi3urVY/rUAbkrsib4KI+eB9kcek1isy8dx8yMWhcyq7BR0+RslP
	gV7oWML7BCWnzaY+vNmjX5oI3h0fR0QlTZgvOgNhXdNkMNQKG6d1YXDND3uWVZVNv5AFcDEJyCO
	5Rbi29/wLIikGFQrcV3uFhtE70Q3JrxbKWjL1PL96Wxjb4n/nUXxUcp2A==
X-Google-Smtp-Source: AGHT+IFO1PbWILyZhkmdzoG1Cq20TQMLfVmCXio+kB7daV6YdfwSyF0hqOCX+kysiN5VcXgBtF/rgyt0JUY9JXLmzhE=
X-Received: by 2002:a05:6402:234f:b0:639:d9f4:165e with SMTP id
 4fb4d7f45d1cf-64105b7064dmr3535609a12.29.1762373282826; Wed, 05 Nov 2025
 12:08:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251105102022.18798-1-pratyush@kernel.org>
In-Reply-To: <20251105102022.18798-1-pratyush@kernel.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Wed, 5 Nov 2025 15:07:25 -0500
X-Gm-Features: AWmQ_bn21g6lzNnlKmCfnUIMRgz-n6pxjgW9XHZT8JIFo9Q6t3fWBtoZk10pspU
Message-ID: <CA+CK2bBGvaZ4-mjL2MeCP9650z7XOoB3dWr+1BMKfoMbAUK02Q@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: add myself as a reviewer for KHO
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>, 
	Alexander Graf <graf@amazon.com>, Mike Rapoport <rppt@kernel.org>, kexec@lists.infradead.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>

On Wed, Nov 5, 2025 at 5:20=E2=80=AFAM Pratyush Yadav <pratyush@kernel.org>=
 wrote:
>
> I have been reviewing most patches for KHO already, and it is easier to
> spot them if I am directly in Cc.
>
> Signed-off-by: Pratyush Yadav <pratyush@kernel.org>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8ee7cb5fe838f..3c85bb0e381fc 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13789,6 +13789,7 @@ KEXEC HANDOVER (KHO)
>  M:     Alexander Graf <graf@amazon.com>
>  M:     Mike Rapoport <rppt@kernel.org>
>  M:     Pasha Tatashin <pasha.tatashin@soleen.com>
> +R:     Pratyush Yadav <pratyush@kernel.org>
>  L:     kexec@lists.infradead.org
>  L:     linux-mm@kvack.org
>  S:     Maintained
>
> base-commit: d25eefc46daf21bd1ebbc699f0ffd7fe11d92296
> --
> 2.47.3
>

