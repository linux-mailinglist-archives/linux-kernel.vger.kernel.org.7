Return-Path: <linux-kernel+bounces-762190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A332AB20320
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 11:21:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00D2C7AFF77
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 09:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12A892DD608;
	Mon, 11 Aug 2025 09:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lvqvOb7F"
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A66961FC109
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 09:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754904017; cv=none; b=CAhFWdVv/yZQeuk6w8b3Grh68enhetpAk0L5UHNpAp2qgFfl2+uaK4bmgURzzxvqOySbfDR5wXP5bhJ9uSKfS8O4U7KAg1eddLOwcJhepZ2i8NmSQxKr9VVyuaBkRM/Wi29lmhlqEU6Gw4mfWSw0Vnh1iLrlntDQmeK1kWpha7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754904017; c=relaxed/simple;
	bh=2Tbtp2fh0dXz5Y7IPl9rPzne47+EFrFsiVlzkhWpqRM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hgZzJZJUmmzdXuSfZqKzhzQrAmHz07bxVtFM8UmAgqYe87N59F3DQKSVOb7zvjHVesTDK7anqLsb7oO26ALDOJ0FyXy1qmHaTV8ArfsmSz+xbWsKzssWoMQJTBuBqESLoNGzN/n7fIldxP06pIvsuhfZKVX9taAcbfeyAt7XtiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lvqvOb7F; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-3b785aee904so1997762f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 02:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754904013; x=1755508813; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=47wjmAatiGqCwNQDs/QFrvMK81xqJJT6Z47iNSo7+Gg=;
        b=lvqvOb7FqXi3mMc5tleHdOqwTrpVhR9hOQxgmN32UcMj7JUfb1l5RkqO6kM1Z+0JAD
         YHJeRx69G9CK2jJRMulHcOnIlQgeSPo4FwrFZUa9rLd8efepfG026aLfsfkhtORWi8Lq
         NLRlIRCNxOTwYOFm6defzzZJvv/ZmsAsGfO3BX6uAP46BHvbXO3MT20v3RXGNyHk2H53
         XnysCZAUaNPSnxXJK55DWtFcHlqszS78xJy7igbhUeCnD4EykpvTfeLBOZKuOT7rFxTy
         Xg9EbSZH6WcsyrNo+xuYRm+aCBCNnULOUa+k4TFQJbYa13apPTBhEZEXQS+CK0qpnsfc
         VxyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754904013; x=1755508813;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=47wjmAatiGqCwNQDs/QFrvMK81xqJJT6Z47iNSo7+Gg=;
        b=Z5VnYNsdK+99UnkLWCVVd8I5Njk7V31KHSX/DttpLAJ9NHkqpfUNKAiyeDBFHU/SPS
         O6r3jlCYpxk7CaHWl1wJALiUi9oBVJOCLp2ggjfaZzKSEfVX/+EuSXrB25EXR6Zo1ucV
         LPDvyO6+en5K4OxaZNZPaIn1chY+7DO2mW4j1MBLEQsm6/gtDGsJXE1aPQAsghyTj4nL
         GXqkVeO1RyO1dvSTYWWyx9i1DoPkJUrKeqiqKKqUS6eFGQZ2863+hnSiHci4sIIn+0ww
         xZEwZxD468OR93q6IcOOkJKFwefn5FqMun91Yp3H/2wrf/8kGA/N7vPeIdiPydMqi/sc
         23xA==
X-Forwarded-Encrypted: i=1; AJvYcCX7VuGi0pDcFgCvpJpc09q905DWic9xqjmhQ9jhmvrndHAOIg0ovli4717EdbWuHXvf80zB32zZ/ikGN5s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8CklP/slTYZgbPWhnZXowgwzfjWvFdRnn0QuJqIrSb1nLBWcw
	O7Q7ZHTSzrgqrEGIGy1pqsD3dV5o6By1ox8S5tiOIoEYsZoN/7ioXMxOluKOhzF4UVq8403sdxu
	6HQV8i2UF9EPIPBVc0w==
X-Google-Smtp-Source: AGHT+IEQetNPhNFVsPBuf7bN0lxlnglFpPkP+Je7L6ay2OslaIr1JymNb0gmu1KXesLGElERGtj2RShsir8WA6M=
X-Received: from wrmt10.prod.google.com ([2002:adf:e44a:0:b0:3b7:7cba:bd56])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:2308:b0:3a4:f70e:abda with SMTP id ffacd0b85a97d-3b90092cb52mr9990147f8f.10.1754904013062;
 Mon, 11 Aug 2025 02:20:13 -0700 (PDT)
Date: Mon, 11 Aug 2025 09:20:12 +0000
In-Reply-To: <20250809073018.1720889-1-carnil@debian.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250809073018.1720889-1-carnil@debian.org>
Message-ID: <aJm1zM5TZpeCW2CR@google.com>
Subject: Re: [PATCH] binder: Add missing module description
From: Alice Ryhl <aliceryhl@google.com>
To: Salvatore Bonaccorso <carnil@debian.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Arve =?utf-8?B?SGrDuG5uZXbDpWc=?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Christian Brauner <christian@brauner.io>, 
	Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>, Ben Hutchings <benh@debian.org>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Sat, Aug 09, 2025 at 09:30:18AM +0200, Salvatore Bonaccorso wrote:
> During build modpost issues a warning:
> 
>     # MODPOST Module.symvers
>        ./scripts/mod/modpost -M -m -b        -o Module.symvers -n -T modules.order vmlinux.o
>     WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/android/binder_linux.o
> 
> Fix this by adding the missing module description.
> 
> Reported-by: Ben Hutchings <benh@debian.org>
> Link: https://salsa.debian.org/kernel-team/linux/-/merge_requests/1587
> Suggested-by: Ben Hutchings <benh@debian.org>
> Signed-off-by: Salvatore Bonaccorso <carnil@debian.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

