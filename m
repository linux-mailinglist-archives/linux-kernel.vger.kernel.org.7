Return-Path: <linux-kernel+bounces-736483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8641BB09D6D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 10:11:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC3745A1103
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 08:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E42BD290DB1;
	Fri, 18 Jul 2025 08:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="bFSMIElY"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D0F220F34
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 08:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752826304; cv=none; b=Vq+fVUGumWFgXKe+NhnfIIbWH7kttiYOtBWovWhA9rcbILa12Qvzbb5dptXR25dr3H4WO+giSdIoLU78JPBzrBbekujbmu4e7wYQEWpD/wjo8YcjrlOf0lULvD66FyQRuJXYzlJ5VjBXKFCqfWm9p+WQUOU4RP1lhPikgfRuU6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752826304; c=relaxed/simple;
	bh=1jAhRd3FU2QWDV+irfVHSFtxSupHRhWFUek+YocDJXU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bgW7305HSqMtlsoFKvnYSZJ1FN2e1Nl/sXbHO/g01ezsVBxhJTz900lcqz0/wEylogz/BngxWX88KBXGoTNcOAEWWmWWKYriopaoUgH0vkleCTkXWx7y/D4OmSA0gowfoo2REHBXEfCYGSSBSIFRzFoj855sOFDhDb6gSlJrK4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=bFSMIElY; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5561d41fc96so2125054e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 01:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1752826301; x=1753431101; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1jAhRd3FU2QWDV+irfVHSFtxSupHRhWFUek+YocDJXU=;
        b=bFSMIElYHdaBXKzDxtG9RfJyeYj7A3fHBpq7D/oI99mPyvum//FPQe266/lU4XF82N
         /iVWmHXXGxV35qAzN6XhMy3Np7Enl8DdrGjAIc4A3mzcolC+psF6PX00bl3hXg8EpZ0x
         YIenmSz2bMuN44XWlPKl/AewcHwtOA1mJKX4Q8lO0oAcVXe4eV7JzunUC3Yu0Z35arVS
         OCSXqqSpiS+XA3aVWTV4lp08ywcxEBjtO4xteKgQgz5TwR9YO8xH2Z77RvHo8L2VYOMh
         33tbrfGoVt+crLdBAvdmaUF2bmbZKAHhek/hpuBTmJoFPgmQpNbfuUzTBsB6BKLN2sIB
         3DGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752826301; x=1753431101;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1jAhRd3FU2QWDV+irfVHSFtxSupHRhWFUek+YocDJXU=;
        b=hKIB+LjsqBkRdw0DaEbogVLU89lezxlUZT7N3zt6b+Efv+07MZIPvZYilWNbQkIz73
         9OYzLE5paXhs0NU2XkDZZRNJv9igWd0rxZmKZn9gECjlO0g6xR+/xUmESX6LWQXKzPXP
         wuAuGN0NWn5gg4Zdmswbjcvt0HzoFu44nm/54O5ER92qmTmZpyb7mM+gx0F8yxxQFlax
         0NcNINsodAZDe7kD2h0jvxiqqrN2ACPZ5gWdhTVpF5lh9wNcqWvichyg95osBEc5TjZD
         CG1H5v2RA5e7gaOmFwF1TO2OVNGSz1CwvHtFerHNPoQlDMdh2xzpGdlHD0Z3oTIxJPy7
         O9Vw==
X-Forwarded-Encrypted: i=1; AJvYcCXe6DUwixUPA1TiJCQF+6C0CDbYexe5jQ30LSjIanBuTEWBRWGb/KNhg9Oj3vgeyBtkLbxkEsoc16l322w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcmPp7AAxv0mZGkUgZR5yY1YQBiv/2kCIN1sMGGWU0g5whQRd/
	ePLJX6zi0n76WaT/P9h6Vl7pOZ4tOBw6IQCLld0uCYxUVZq+Bi/2eVp2WMw+GtBDuuT6qZH+iFM
	NSa8+wPxrRgmlvtfo9pWkhyvxciEkKPupK1GVjBkaGwewiUar36XN
X-Gm-Gg: ASbGnctmkVReRzph7Pe2EudPBOcpYh61/lC5zPTSVio6jZ+elB81cskxBJXfPKfkpzZ
	xe+JJoJPZk54VI+qdHiFmxodKMasd5rOThwBSuKYSaojaiUxQ7fizLnaaXLZQxLVVmMrPISyksl
	87h0sPS4KLmRxFloxaKS6l6y8OjVwvGwnp/qp0vqCs+zCkbGsjFMP/gWHthisJCTpHOOD8e2YuA
	0/S9c8/V8ahehx6k0FZ0Gfdelct1MiB07GDn9dsuD40Hcm1
X-Google-Smtp-Source: AGHT+IFb1uJD4V9aouoJvlP1yjVac8eQbZ0nNrzuuL9tqojwVBFkpEZenb7Pr8T2XBBshIaYd4a1UVo6aAXBNqT0N6o=
X-Received: by 2002:ac2:5686:0:b0:54a:cc04:ea24 with SMTP id
 2adb3069b0e04-55a23facb73mr3023679e87.46.1752826300986; Fri, 18 Jul 2025
 01:11:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250717141000.41740-1-harald.mommer@oss.qualcomm.com> <20250717141000.41740-2-harald.mommer@oss.qualcomm.com>
In-Reply-To: <20250717141000.41740-2-harald.mommer@oss.qualcomm.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 18 Jul 2025 10:11:30 +0200
X-Gm-Features: Ac12FXxoZ75HfgStvYvOn-iPfwrSf7_9mNtIsTgIecfFZm93LScfE32n1cfLPdw
Message-ID: <CAMRc=Mcxb4SqH+XJeLkd8J==TNaja3iUep2dEm147HOETUfXEQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] gpio: virtio: Fix config space reading.
To: Harald Mommer <harald.mommer@oss.qualcomm.com>
Cc: Enrico Weigelt <info@metux.net>, Viresh Kumar <vireshk@kernel.org>, 
	Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 17, 2025 at 4:10=E2=80=AFPM Harald Mommer
<harald.mommer@oss.qualcomm.com> wrote:
>
> Quote from the virtio specification chapter 4.2.2.2:
>
> "For the device-specific configuration space, the driver MUST use 8 bit
> wide accesses for 8 bit wide fields, 16 bit wide and aligned accesses
> for 16 bit wide fields and 32 bit wide and aligned accesses for 32 and
> 64 bit wide fields."
>
> Signed-off-by: Harald Mommer <harald.mommer@oss.qualcomm.com>
> ---

I guess this needs a Fixes tag? And possibly Cc: stable?

Viresh, does this look ok to you?

Bart

