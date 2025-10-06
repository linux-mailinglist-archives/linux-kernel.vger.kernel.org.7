Return-Path: <linux-kernel+bounces-843296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id ED99FBBEDC7
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 19:55:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 97FDF34A94B
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 17:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F5552D239B;
	Mon,  6 Oct 2025 17:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N/QrT76T"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4882199237
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 17:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759773334; cv=none; b=bqL7eB0wqRN9dWZh0oKaXo6ugE2UcYWN2s8DvhLwOMu2TxkP+pGh7SNzCkPNoc34FHvwin/BTqhEEVSyFrcEUDHp+0JpyAHWr0xYHhzXBN4sJgl/bTtLD1JREFkUKndd9t9ScM4ei5xSVDUkp+s7l5qOuYJrd/C1dfDv3Vcu7tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759773334; c=relaxed/simple;
	bh=GHjC0ZDFv6Yr8oyAI/yfkHsqZVcSi60mbO6eviVgQuc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hzN1JDGAxwFNhA0mqkvExlp5F3KmZsGkfPUmxUurjh2ksi8pT9VOdHcbsEeSOhMGThCzM2W9vH6MZaZowGkQtxZnfZVSTUkYWTEvz4BYmgvTRzs+eOGyhR8LvhHf9yEUcO3MUhabV0ER3j/dtyoE5EdCISDrBYxjMv2PljJMZ7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N/QrT76T; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b463f986f80so761683966b.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 10:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759773331; x=1760378131; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GHjC0ZDFv6Yr8oyAI/yfkHsqZVcSi60mbO6eviVgQuc=;
        b=N/QrT76TIAdC2Xf8e/7sGmoF71bdpSxLxTI+lbSUcml+PR6Dp0jwxBT4C6AE0r4o8o
         T1qM+WVOZF7QrXXCL+syQMicKzxu9UyklrkNB8MA/Zu4ALwPkQcYjWzsNxPj/APNJe7T
         tGukpanFcOG3zUToZpW7/q6uwTMCrsrqQ0xyxpiBFMmzvTlbjRHniXDmaFTEJDbOwUl8
         4fbHcYWvHnUXbBymjdpBJrqhEvTRZ3mBgsktKxuS+f5c7zBVUToKqAZ+AKsWLKA2hwsB
         IefDx2SQCHTF+XfHABhi7+tKGlW/noDg0tg1TP67ELmziV3DLwyfM82apXcsxR42ayBi
         QEWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759773331; x=1760378131;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GHjC0ZDFv6Yr8oyAI/yfkHsqZVcSi60mbO6eviVgQuc=;
        b=L7hS1lZs/dGjAQPGYyfbXID/SbBiopAyItdQWeXr/H88pB2iXASiCsz4H5cViJwRm6
         i/o9PAnoo0GemMLXsgIHNGqmbLHQYHBfD47x2p3w6D+oT5ZzZnGKHMWU14hNfJcW6uko
         G04vJ1UU69cqsHK/sgEl4BP3+vcl2blMMD2/fOjURLx8vwd09dRFhE2n3DkDSvzALg/x
         C/kw+7q1HlW13ZOyOYK/9rk8Z7q+tMEPplijao7r8VwYkXBUDU4hQ1dg2MokZr0x2GSM
         wDRxCo22EVWdUjpkSWc35ohhX1pXn8lKQVVzXysRg58Jpmi0wIUadcDgqBDdkN/X07Wj
         z1vw==
X-Forwarded-Encrypted: i=1; AJvYcCXoaLQpQSc0PWsrG3xwNnZY91X7H/9HsH0R186oW/TazBpY0lpd5GeXB+5k+qOo6UBAPF7B7pXv+trYaBo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxu5loGKOuithdo/2cKBWng/C3NQdWmQH5kYmWISB6IBFouFDhA
	FnQD5GEF54L4iD0r2oYadFqXuXYxyWTWjsdJzQlxm4gl2Rkq/3lOc5nnRNR8VBZLASs8pSiQDPA
	XRdA/dDBwKwfV/zyLiSDyQEiU6Ob5lVA=
X-Gm-Gg: ASbGnctc+YtK3vCq0jvDtBMIhnTVFM2Ka3dC8VqPvvFG2CTLRq4aw1Bm9+SU90RwaZZ
	lXSPTITpOSzmOo2FN9arW+fplTosvRDQ07bjwy4lrJt/HH2h3Y3b7kTRlXeA/e7btR2VeGGbZUs
	qeXWjEffeSbm+1uhtqFvWyAqiqRc3AOWNiqau22YltG/fUHimmKsSbtRsA04upRH2pz6P4JHJq7
	9uGDRrm9pSb+yAafiuho/LTAzl7bBt04vxLGCrrerEQFMnjZkOXgaW7dRZnoACL
X-Google-Smtp-Source: AGHT+IF6Lji4cfL4NWxn3OG8grf7sXZzXO96Xa1ApY9O9MXdGCSzyo+0gGxA9MRKx5Bp/KFgOH15DtuzKOh+kShvfYQ=
X-Received: by 2002:a17:907:3f9d:b0:b2b:3481:93c8 with SMTP id
 a640c23a62f3a-b49c08981c4mr1708644866b.19.1759773331112; Mon, 06 Oct 2025
 10:55:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251004080123.98285-1-vivekyadav1207731111@gmail.com> <aOOyTtruyDVrzuCe@hovoldconsulting.com>
In-Reply-To: <aOOyTtruyDVrzuCe@hovoldconsulting.com>
From: vivek yadav <vivekyadav1207731111@gmail.com>
Date: Mon, 6 Oct 2025 23:25:19 +0530
X-Gm-Features: AS18NWAG5RtFmRVVuhL6BMEzmjYiCX_hw7o3O3M15qlv2CpXbiPWh2lU4nJxUoY
Message-ID: <CABPSWR7s3o+36gvXb5QQyHYn3LJiDP3vLoVXijU2r9Qi6fA4uw@mail.gmail.com>
Subject: Re: [PATCH] usb: serial: fix: trainling statements `break` should be
 on next line
To: Johan Hovold <johan@kernel.org>
Cc: gregkh@linuxfoundation.org, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org, 
	linux-kernel-mentees@lists.linux.dev, david.hunter.linux@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Johan,
Thanks for giving time for the review of my patch.
I understand your point and will avoid such kind of practice.


~~Vivek

On Mon, Oct 6, 2025 at 5:43=E2=80=AFPM Johan Hovold <johan@kernel.org> wrot=
e:
>
> On Sat, Oct 04, 2025 at 01:31:23PM +0530, vivekyadav1207731111@gmail.com =
wrote:
> > From: Vivek Yadav <vivekyadav1207731111@gmail.com>
> >
> > Run `checkpatch.pl` script on path `drivers/usb/serial/*`
>
> Same here, don't do that.
>
> Johan

