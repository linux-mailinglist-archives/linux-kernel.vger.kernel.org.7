Return-Path: <linux-kernel+bounces-851605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A84EFBD6E0B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 02:30:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21755405C1F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 00:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF8C218A956;
	Tue, 14 Oct 2025 00:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zi9btCp8"
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD2D16F265
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 00:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760401814; cv=none; b=dRa5OPGh/rjO/RN+Wm4/aLNmIYOXNOCsJRPoPgvUvhSxNRt9doh7LrQRu0xFUEQD9KnjjnKnNNe8V4+NRvZoH9zUPFpPwXLaPqorzDMVYM7kX4Gp67xXRH4Aw/O71JZmjzqw8KKOkvknK2tvq29o0CG2sPHxLdcvwj6ZBZQCdzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760401814; c=relaxed/simple;
	bh=FL0O6oR7tFBbgxorRPIiHZOqnAEHXSA3uOI/qucr4Lg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c7iH62udQKIhoTZRL9th6Vt/RyCUj8WcpA1C3X43FJDucaqnE9IXzeoyaqC3hxR8nxEt0KRIdZjm5a/ydJlyz3wQlGyMKn7xPKEwAiywdxiGFvP//0Or3hOuv2KzcqmmAdWtq9ZA/JUWVbtYT7JhDz9bKxcAIT3kR9bD0+ke6wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zi9btCp8; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-77f9fb2d9c5so42484027b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 17:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760401811; x=1761006611; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FL0O6oR7tFBbgxorRPIiHZOqnAEHXSA3uOI/qucr4Lg=;
        b=Zi9btCp8IjaQkChy+oGeBWV1fL+SW/qY0LRD8IuXe5olAxYPqFUCQ1K58Dej+FBWhD
         t7/xybg341MUPFPHw0zbQZD2aKztQ/bshIOHaY7I92OUPHc+x8qxei0kxIMtR8Flt+gF
         dYMpHElyXSoayiECGWU+QaJ0/Is+SY8PdIiPKmDnzLNZlowQj1HMBzz7w8MdzaWinukx
         SpuZ3kmP4f5WDO55x0Mpn3hprXXSQp+6K6bar8+Sa6LCEMqf5t5N+24AKtmyM1B1KSSW
         peDw4SzuoLpLJpnr3sYolVyjJnrSO2Cub79HYR0gApkg4+kakkHmMyb3B3RBN2fBxbX2
         YcMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760401811; x=1761006611;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FL0O6oR7tFBbgxorRPIiHZOqnAEHXSA3uOI/qucr4Lg=;
        b=mxEpjW+k3PhXMYlvyW9FSm8H2YVuZ/vmQdYDqVEN47At1EalKtmRFC3iylXPW/J4FH
         L8k7w1Vnh6vLmVUi4gCWnIAuqUACZLQuWiVM2nN1xAiS7WiTYv1w78SnaLhtCgxb28V9
         TkMPivxKLhYZgT5aECEXlcBWQgXfjlTfwi6Fp8cPtKlYbiHm/KW2Fpock7I3Ez5Qwb+G
         Rc8RJaQu58wq9RGAHFtbgPqh0WdaRWGF/7cKUr8lvpqgbRjnABCYOzfsG7+Ozcryzs4c
         wnXCDEKN21AW1/c6utMjJCCedFLiKa/IyPSSpxGBMiQet6I6yVm82eE0osN92sOCV6GX
         njGg==
X-Forwarded-Encrypted: i=1; AJvYcCVjLfdp0tF8brAeoUgMlyI9I0QmvNvekQgJfivXWjGNaQclEHBUks82uDhnj4CX3tvgNHZCn/Y9ZKyZ0mo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yygo0UGzPGh9vw5Ad6VmUClKQBg6Kk5eqadnzXQxYYl5pKElsZW
	XR3IddYWn32bu6IRlUrO8XIIXge5GTViJ17Ae9KLdhqJzK/TvXQExspYONbg/GJiVuRVf92U8RV
	mF7LMEZ4ZzbIg/72MGvy9zPGm3fAYJGw=
X-Gm-Gg: ASbGnctZoOuaweFqQ5nzG5XZogMMtTQ/5PbHWpd1Mol9Gu4GyzopzNiuFwi7vbaO5Eh
	g+5IXfjUACUyITXoZCsHxfKG/F+0w5A17lL3KhXhxJig1KG+88CIKvSryrPUmofXpsvJ1McJJOK
	Jbz7dYYuqeWFhLTUOdOWHzXjHPfcWlRKoMWyTIXACFPgKAzTWlYXwfxWkWi+7inMiCcxKNie2og
	GlTDM1mUh7EOuE/Nj9+ymtlahbF8vkErMhtq3DgGS6RatT0bvb8xzsOrQ==
X-Google-Smtp-Source: AGHT+IEUvVnpl14a7Q5M/OtoBNBYZn6+9fewhUttiUvAPvVoTebCWbrrZ3wpmAZYfXuUtNCIrHfIKGkBJJx456zaMyI=
X-Received: by 2002:a05:690e:15c7:b0:636:5e6:cac1 with SMTP id
 956f58d0204a3-63ccb7fb22cmr19733855d50.4.1760401811361; Mon, 13 Oct 2025
 17:30:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251013121709.104546-1-andreas@kemnade.info>
In-Reply-To: <20251013121709.104546-1-andreas@kemnade.info>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 13 Oct 2025 21:29:56 -0300
X-Gm-Features: AS18NWAiJadHGMJZMT_VxfTRlUlHgWEUDMnUSc2rSEDmAVW-OfdMZEsrg58YfMs
Message-ID: <CAOMZO5BQQhNrYyjDRSr+bAYUa57YdFcroY-hi=La9aOSEAwURg@mail.gmail.com>
Subject: Re: [PATCH] arm: imx_v6_v7_defconfig: enable ext4 directly
To: Andreas Kemnade <andreas@kemnade.info>
Cc: linux@armlinux.org.uk, shawnguo@kernel.org, s.hauer@pengutronix.de, 
	kernel@pengutronix.de, ebiggers@google.com, ardb@kernel.org, 
	dario.binacchi@amarulasolutions.com, martin.petersen@oracle.com, 
	alexander.stein@ew.tq-group.com, stefan.eichenberger@toradex.com, 
	lukas.bulwahn@redhat.com, tytso@mit.edu, linux-arm-kernel@lists.infradead.org, 
	imx@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andreas,

On Mon, Oct 13, 2025 at 9:17=E2=80=AFAM Andreas Kemnade <andreas@kemnade.in=
fo> wrote:
>
> In former times, ext4 was enabled implicitely by enabling ext3 but with
> the ext3 fs gone, it does not get enabled, which lets devices fail to
> mount root on non-initrd based boots with an ext4 root.
>
> Fixes: d6ace46c82fd ("ext4: remove obsolete EXT3 config options")
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>

Thanks for the fix. Just faced this issue.

Reviewed-by: Fabio Estevam <festevam@gmail.com>

