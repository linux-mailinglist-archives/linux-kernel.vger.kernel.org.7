Return-Path: <linux-kernel+bounces-732274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7BA5B06463
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 18:33:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 131341AA308F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 16:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09647253B56;
	Tue, 15 Jul 2025 16:33:23 +0000 (UTC)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 594F513AA2D
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 16:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752597202; cv=none; b=QIvUbS6DjQhmrp/hywEa5kkJZoB5wPlfArNaVnl7ThdxBPHWLLKBMf+57hMDiDqvdzSS0EJVKXN/B8oe4pkPC5Spa13z4y2Xx8ITvmK9GDxqIe5yj5QyIdpbTXjkaTYNMFj2Uc+dCB53QvDEQsWqOV/NYeSXWydmpvuqb+SQz5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752597202; c=relaxed/simple;
	bh=CjUnx4qglKnCSPpRJ4ljeidpsB6he1PLq5cS3WxpqKg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t8LXnaWrY40+B8a0B3vAVMv9gWJeWmEeU1Jng7H9ZpdtoeXloky+he5zab1736HNbXNeAHow+aK8DdVEbzX0YWHJ4zxzIRm4y8AwohxRKr1otXgm0bebD9qXwbSOXWiIHSPxfSs5OqIVnZ9lbiaMjVe4YWE4Y2ULHg6h9mcRWvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-553d52cb80dso61465e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 09:33:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752597196; x=1753201996;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hQNw2leo+Ol5kg5pwyn/60G8pbTVujZAHkW7U5wnbhI=;
        b=AExgJ1fXdCKGFy0C8LwFkK2hGWphfgZcdOlY7Ej8dJEUmiH2mkT/zD26+GzfX1THme
         TDMg70WsW6f4qpYJqQ6deB0Pvu75UyO8y9s2ApznwSZE3aPS9UmtXHRKuZMvBad2GcCY
         E+9mQqt20nZaGQRhXxTN4urThtalwiTFQJ7AGBMDDtz34a3g+lb2Se/tD0VRDbWWcd10
         1GRnl+PCCgLDw2tHe+wIES5KB6p4KzQwHo5gXNQg8dJg/JPOmKk17g/8+dDbSCFLGUAG
         kGaxAIYP6IGS63GPPG4XthHh7mcUoCewFp2t5CTUUMSJ79+U6PXviLLdO3Dy1BC2UqUH
         9gig==
X-Forwarded-Encrypted: i=1; AJvYcCXUAkKj2PpOTqLlG9JCnq2NhPy/D9awQ6XxkZssrBWSOhIDnL85WvhYaDiR/EOgklOLZLvl5VjyKDG2Ku4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWUoZ3E813tuvyaVZCj7JNlMpXi7B0YwM4e0xVfxdqCV4sVhrN
	BG3PhY7hCN0RbhG0AtrqI4mir+7BroLEq4jW9yGBagVBgxFPZgJ3UfkQ8hRV1xHe
X-Gm-Gg: ASbGncsIord9vtjT0iicz6vOHEGmQV2WADTxdXDCL/Y/way+PKlBktW7+RATX0YvYEt
	9hFh/+DNVHS3v3kJd7hukaCov884ktBNOjKU+tU7csSdWjPeCR0Pg4SqKzoKOK33jNZBMXgmZ6O
	fX8brlelhrw1GbV1sKD9jbBoyv2zgk+yta5eR/K8FVZe54c69G8F4oAj5B+uDrNEiUHZF0/BHEM
	oS34vkYY/7yXUHxMzj0vsffciJ8//iUHBm9ZfieXlAg4QTORNCxYOZqrftRbqdZPSFRfqK6YNY4
	K8a3N7a5stMVqZbRFMmqoUuiZ4joajzPYaL8CDcFYm9lhPT9NYzI2cmDuDClsODf8pm0TQWsvK6
	KBixnXE1YXwmD+Kr1YS21CkgP0JMq3B3v1bI+smCgn3mn4EWJnTRBqVM=
X-Google-Smtp-Source: AGHT+IHlFZlkJv9riS1W6N4XmGyxvzwAg8NTrbiKu07DcuA6z+vYFaRU1ICr9v5wN5H+qGzoph0KFQ==
X-Received: by 2002:ac2:4d1b:0:b0:54e:780f:3074 with SMTP id 2adb3069b0e04-55a1c44da22mr1278494e87.8.1752597195495;
        Tue, 15 Jul 2025 09:33:15 -0700 (PDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5593c7bb80csm2370846e87.34.2025.07.15.09.33.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jul 2025 09:33:15 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-32b7f41d3e6so577881fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 09:33:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU0SkwnoWbVrfUtdAqYCyRx/Sw2c3eyQasdNJlmJlJJBHhKpMrruk1VXcISUP2ohhv9nF5vGfl0Y5AZZw0=@vger.kernel.org
X-Received: by 2002:a05:651c:214e:b0:32a:7454:4410 with SMTP id
 38308e7fff4ca-330811e3685mr8516981fa.16.1752597194142; Tue, 15 Jul 2025
 09:33:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250704075225.3212486-1-sakari.ailus@linux.intel.com> <20250704075358.3216894-1-sakari.ailus@linux.intel.com>
In-Reply-To: <20250704075358.3216894-1-sakari.ailus@linux.intel.com>
Reply-To: wens@csie.org
From: Chen-Yu Tsai <wens@csie.org>
Date: Wed, 16 Jul 2025 00:33:01 +0800
X-Gmail-Original-Message-ID: <CAGb2v67XWOQQnFterdYixP9JjXAop0=nOpwwtj7Ede6THaMdUA@mail.gmail.com>
X-Gm-Features: Ac12FXyC8zkOlZ-J70-qmRzAihPtcAEM5lb3HzZX18bW3blmNya4r0lMEGeXzOk
Message-ID: <CAGb2v67XWOQQnFterdYixP9JjXAop0=nOpwwtj7Ede6THaMdUA@mail.gmail.com>
Subject: Re: [PATCH 04/80] bus: sunxi-rsb: Remove redundant
 pm_runtime_mark_last_busy() calls
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Arnd Bergmann <arnd@arndb.de>, Zhang Zekun <zhangzekun11@huawei.com>, 
	Javier Carrasco <javier.carrasco.cruz@gmail.com>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 4, 2025 at 3:54=E2=80=AFPM Sakari Ailus
<sakari.ailus@linux.intel.com> wrote:
>
> pm_runtime_put_autosuspend(), pm_runtime_put_sync_autosuspend(),
> pm_runtime_autosuspend() and pm_request_autosuspend() now include a call
> to pm_runtime_mark_last_busy(). Remove the now-reduntant explicit call to
> pm_runtime_mark_last_busy().
>
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>

Acked-by: Chen-Yu Tsai <wens@csie.org>

Could this go through the PM tree?

> ---
> The cover letter of the set can be found here
> <URL:https://lore.kernel.org/linux-pm/20250704075225.3212486-1-sakari.ail=
us@linux.intel.com>.
>
> In brief, this patch depends on PM runtime patches adding marking the las=
t
> busy timestamp in autosuspend related functions. The patches are here, on
> rc2:
>
>         git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git=
 \
>                 pm-runtime-6.17-rc1
>
>  drivers/bus/sunxi-rsb.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/bus/sunxi-rsb.c b/drivers/bus/sunxi-rsb.c
> index 7a33c3b31d1e..82735c58be11 100644
> --- a/drivers/bus/sunxi-rsb.c
> +++ b/drivers/bus/sunxi-rsb.c
> @@ -373,7 +373,6 @@ static int sunxi_rsb_read(struct sunxi_rsb *rsb, u8 r=
taddr, u8 addr,
>  unlock:
>         mutex_unlock(&rsb->lock);
>
> -       pm_runtime_mark_last_busy(rsb->dev);
>         pm_runtime_put_autosuspend(rsb->dev);
>
>         return ret;
> @@ -417,7 +416,6 @@ static int sunxi_rsb_write(struct sunxi_rsb *rsb, u8 =
rtaddr, u8 addr,
>
>         mutex_unlock(&rsb->lock);
>
> -       pm_runtime_mark_last_busy(rsb->dev);
>         pm_runtime_put_autosuspend(rsb->dev);
>
>         return ret;
> --
> 2.39.5
>
>

