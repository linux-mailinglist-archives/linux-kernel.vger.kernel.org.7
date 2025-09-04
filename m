Return-Path: <linux-kernel+bounces-801565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E75AB446BC
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 21:51:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 641995A818C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 19:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E95ED2773EA;
	Thu,  4 Sep 2025 19:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UU1xd9A/"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7427275AE9
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 19:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757015459; cv=none; b=swPjAAFF7KI/fPaEh9wgWmYwpl29TNVSZpPphc9htf8CMLtZXL8cZXzU5m53hzGVbDOMk9/0WNkkpPcaqo9yCMUgA1FGuhCBn97uF7IZG2GaDPVaTmDQ484vwkND86Vmt3qdRzYHI0JUZ+poP8gEiJuct4DbPM4AoMeOnvA9R/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757015459; c=relaxed/simple;
	bh=y/BbCZOfutrrGdIEhnUdoJS38e3K8+RsUZAJr/I/qpw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LbZBtTSeoz0VpKxhopQmbwg2AcNG4SmLQ0AMY7IWGpk6zZ2B7q6XUgZQvDtTIHY2oLczOD4U8tgRssBw/AQa37N41sxppAeN1HngQ0Hx6A1qsfpL4ymWLTZiAZdjGJRxkZpXy5aJ270H2NhDQ/ON5TG1zt/gCAXstjiWGiWIMtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UU1xd9A/; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-55f6b77c91fso292e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 12:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757015456; x=1757620256; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g3eHPEufl9xUtgWD3aqAgCiDundMmJHck6jY2E0vTjQ=;
        b=UU1xd9A/T1WZWgzvK4d+Fip71c4GQu7kKDBPeTGZhIct2fEV1DlaX0atkEu37YoMqs
         kGRY//IHK485odl9w7YzByqSziFbVjqIONeOR42S0vbyacIGLY0JKNN9KjGMC+vjJNAK
         /Jr2h2eSFHozHzXsqyxlu++SMMQKtmOD2LiZAJxe7zW1ZMrtCze8/ULVIQv01Qyu6rPh
         YMerxr9L0u+DTUiSqROFik1tGTGqQyo46ej56y8Y3lIwu6yKQdPGXsNluZ5NpFnR3B64
         Vc4gLJEtbjQTTZDWLk18Otd2Z8JS9uO5ooK3UYptcsWp0f153GCr8JL+nGoPlKIGiKLI
         4V6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757015456; x=1757620256;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g3eHPEufl9xUtgWD3aqAgCiDundMmJHck6jY2E0vTjQ=;
        b=LpiIKxPw6fsZho1ZX6mY8dZz0w5uyXnemdLnZPJkdBASg+0KBAasiLhjGGwRR5gt7d
         QQrVhqKnFEGPH93lTzQZhdSOSe3fUe83sq9+GajqQ6K12XQWRJI1j8X741kONcXoL50W
         WF6oBnoIX2a4so6E1tQoP1AWDmgfgb/jTXUBy7J1loCKYs6pCY1pUDs4deGlFT1Yr8gm
         oMdMgj/baPc9raRye9XFo1KMf3VT95cEPBsgGYszqnaOuaQVt5jwvIbaxhTjq8n7lBRI
         hEt/3MDc21Ocl8uhVQ76Vg6BR18GDE4iiFoAGD/5gTyADkgiU1aQ4sn0of8RpKcVxFRy
         0I7A==
X-Forwarded-Encrypted: i=1; AJvYcCVQl1Q1wa1v7OsoA6PeomDgvRYYDlXh6Hv7ZsKhxGtjAWi9730xaBYppLfxgvfEVFpt+zSNJnUCrUM1qFA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyK93yNme4KOiU1Ck1fgLt8nkh5uafpDnEO2Cbpumg/2qjnRyMb
	3Jod9C5X0gZEh3PTq+r+Q4osZaeumM5J1QsN1hmyUFxL29XK3228G0fTrMrEBdGoKlXkG/AVfj1
	/2mdhXlnG8q65u3bROlMq//ttzdifKRKfM63tIo+W
X-Gm-Gg: ASbGncvor4B0EIOCJx/UxCDb9Rm5J+7pucv6+YvmDeqlwYrWKllZbfs19x1DfX0OcMV
	Gshlh9hXjELf0RpUvs9h9Gthlb5qzrFgYilMOC/DpUkQg8TFiXZVptE19Sqz/eBWiLO06JjdEAW
	oRNDVcPNe+TvixYCnJc9gOZILfxUc9WOG0XqhZGTk824N0YiMWJc78q9cQ3HncAI5bgg3HoJPiy
	RiFFysX/h8E8AHb7XWGvyfRGn/E8mAP+RGfk7N6Ug==
X-Google-Smtp-Source: AGHT+IGAlYfo5wIBw3AY98IGAb3xSMB0Z+//3d+kFVon2XgHollfD4NDHAER8NA7szkq38D/pq1qQ3gl/Y+Zfpl4qFk=
X-Received: by 2002:a05:6512:114b:b0:55f:68fe:76d4 with SMTP id
 2adb3069b0e04-560dea6b1bbmr50021e87.5.1757015455655; Thu, 04 Sep 2025
 12:50:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250904182710.1586473-1-sdf@fomichev.me>
In-Reply-To: <20250904182710.1586473-1-sdf@fomichev.me>
From: Mina Almasry <almasrymina@google.com>
Date: Thu, 4 Sep 2025 12:50:42 -0700
X-Gm-Features: Ac12FXwcU_yEonQJHBSkDIvESK_yJi9xHlVf4i2Knv57VrlclcFjGd0j6CV8QsE
Message-ID: <CAHS8izOSq+mYmP58eNqC5WFTvXxh+s8gRSrTv6YQdq6jn41pMw@mail.gmail.com>
Subject: Re: [PATCH net-next] selftests: ncdevmem: don't retry EFAULT
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch, shuah@kernel.org, 
	joe@dama.to, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 4, 2025 at 11:27=E2=80=AFAM Stanislav Fomichev <sdf@fomichev.me=
> wrote:
>
> devmem test fails on NIPA. Most likely we get skb(s) with readable
> frags (why?)

I would expect if we get readable frags that the frags land in the
host buffer we provide ncdevmem and we actually hit this error:

```
  1                 if (!is_devmem) {
  0                         pr_err("flow steering error");
  1                         goto err_close_client;
  2                 }
```

which as it says, should be root caused in a flow steering error. I
don't know what would cause an EFAULT off the top of my head.

> but the failure manifests as an OOM. The OOM happens
> because ncdevmem spams the following message:
>
>   recvmsg ret=3D-1
>   recvmsg: Bad address
>
> As of today, ncdevmem can't deal with various reasons of EFAULT:
> - falling back to regular recvmsg for non-devmem skbs
> - increasing ctrl_data size (can't happen with ncdevmem's large buffer)
>
> Exit (cleanly) with error when recvmsg returns EFAULT. This should at
> least cause the test to cleanup its state.
>
> Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>

Either way, change looks good to me.

Reviewed-by: Mina Almasry <almasrymina@google.com>

--=20
Thanks,
Mina

