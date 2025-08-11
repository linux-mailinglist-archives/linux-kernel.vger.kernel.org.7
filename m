Return-Path: <linux-kernel+bounces-762692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6842EB209D0
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 15:14:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9382218A6EF9
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 13:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21D0B205AB6;
	Mon, 11 Aug 2025 13:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="f5oQrLjE"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F6AD277CB8
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 13:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754918051; cv=none; b=Aav4CCYi+vynrczO5RMtkU6ZD06v2MHUXCUGdDhqFU5nkLO2uxIVWMIR/YT4QZFM/kxOhqqXBdKKxU0gl5kQudbmWodlKvRBx7FhJU3xU8VRqL6cJcLdALWcbeQGF7/wQ0md3+QsRf0UmfS9Rsv35Gn8OA63Zaf1TjebCdTq5nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754918051; c=relaxed/simple;
	bh=gOnD7019wVvxnfkBWIX0WWOVJOpXgqATuZMihxMEtFw=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s79DI0LCy8qXLpwtCsy55wxmA52uUrqf+CcztDuxUaRBU0XJLYRhahmQSL0JYfU/bhCTlhTt0iCUkx53nqA37kVa1orvcCDQ2Vh/BdI2kaULFL/5i4pjm6MDJG2Hb5YVvnjfqZWjw7iIv7v3VuvOKqskOk2uMZSwliXghx22hZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=f5oQrLjE; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-55b975b459aso3536108e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 06:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1754918048; x=1755522848; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:references:mime-version:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=gOnD7019wVvxnfkBWIX0WWOVJOpXgqATuZMihxMEtFw=;
        b=f5oQrLjE4aWrgSA0Jtv/SpOaCuNkrKhR2nX4k31U0mExkM/G1pvEriSiEyXNnn/EKi
         68++wRPh4kLXduAVsU7csQxfnaQw4Ts/I5x/V0gCeSxL6XmYRTOAlTfa9nwX6SKT/z+I
         6/NZ+23/45Wj8eey5/aomzzRVf/6Z4W8qb6N0ly2HAnsl/0lmwuNReDnfenIrocFlzzW
         IonGfKt1xisHyds9bnITOy/xPbYvSQOvouCNyR/xddlwm1y3EN1bZmW7czx7ASoDdX6+
         3JZlNemv6vpij0FkB0VkYJ7mMDV1lem9mUxYRX+lH2rPjtSOGe3nGvmTaz0bX4BT0p0J
         PKDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754918048; x=1755522848;
        h=cc:to:subject:message-id:date:references:mime-version:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gOnD7019wVvxnfkBWIX0WWOVJOpXgqATuZMihxMEtFw=;
        b=E/zTw3+uKyBVQqKFZDkgaa/yW8CeQm5icoB3pDeYuziIG+Bz5WzFpzDdqRsLnTCM61
         fh9I9nYDnxOlGp63COdvdVQr+GPkSU6u9ybzIYhK08xOSnU26ULmOqC+LW7JEhHOo2Qx
         O9LQICz844Ng9lBGNtEK+oO9itjLUD0RrF+TfhNFsnealUxi30PO+xdapbgka0Wwlf7r
         MWoKbzGVj8I4x2t3IPTUMo+d9B+nxMtmxuzzjy3VBaDJ3VZgvJDR3XOTwnksVECZs0jQ
         8laxCwg/qASQNSnXxUMAeuvqz7lrs9DvPYFJhRPYiS0SNu2ZNVHZvKbgyiC9EJ4HHwFq
         hyJw==
X-Forwarded-Encrypted: i=1; AJvYcCVnpuWeLodh0OEnTaWPqwI3E53ZU50DKBfWQxEzA0WB+bYKfrWNIe144vhhQYDwiBVPJ/rbHIDA3yyCNug=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+8HIdCbO2gYETeIiMvAnpXSP8qJScXD2J57oDwtJsN5BuWHwd
	+3EOv/9z52shnxwMyUBXqZqi7JHSVeoJqRI6yitwONmbBwNuiHnNVCr3BnrlUuLOfq5TBUWPWtf
	mxMrRLa1TYW+ugKa3se04xhI7cxYCRoD8FZlkEzIvIw==
X-Gm-Gg: ASbGncvLkWH051o8QiqRnpDGEusoQNdOfpMME7rxoBWKbSWYmtriHKa3nP2rMWuOVW6
	RHrSlt2aR8ZLFisIBKncJAxbS4zGFDhMYx86FNcg0BaQRQtCphpqZhXbZA03SViL6MuNZgW/YDN
	hmDVQQ6YCIPGZcy0XFpFsWT5amPcVGL1aK5O3JwuTMrrVz7D3maj11gELRlVo+flCBsouSRadX8
	HL4EPRtQZNViRnEYtcuv6+PToeGGl96zv8VYJ0=
X-Google-Smtp-Source: AGHT+IFGt5Nc5qscJVVYLtl2huw/aQCNMj0ucn+BAnsYObx2dNoeuixSI2C0/qNBtOnndla2Tjm079hTvc/NwKkkRbw=
X-Received: by 2002:a05:6512:3ca4:b0:55b:8698:6a1d with SMTP id
 2adb3069b0e04-55cc00ad9f0mr3805004e87.3.1754918048081; Mon, 11 Aug 2025
 06:14:08 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 11 Aug 2025 09:14:06 -0400
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 11 Aug 2025 09:14:06 -0400
From: Bartosz Golaszewski <brgl@bgdev.pl>
In-Reply-To: <20250808151822.536879-8-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250808151822.536879-1-arnd@kernel.org> <20250808151822.536879-8-arnd@kernel.org>
Date: Mon, 11 Aug 2025 09:14:06 -0400
X-Gm-Features: Ac12FXxrP0SlfDebLOcuh07PmX_2s3-W5WKUuJmVyKDnXLV2k8bO61Zh8tXjxhI
Message-ID: <CAMRc=Mfm_w4R-63eNpzrYQfE9OAhSO2wY3iPVJVnbSqTzq7rjw@mail.gmail.com>
Subject: Re: [PATCH 07/21] mfd: wm8994: remove dead legacy-gpio code
To: Arnd Bergmann <arnd@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Thomas Gleixner <tglx@linutronix.de>, 
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>, patches@opensource.cirrus.com, 
	linux-kernel@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>, 
	Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, 
	Lee Jones <lee@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 8 Aug 2025 17:17:51 +0200, Arnd Bergmann <arnd@kernel.org> said:
> From: Arnd Bergmann <arnd@arndb.de>
>
> The old-style gpio handling in wm8994 came from a commit 7c8844481a1c
> ("mfd: wm8994: Emulate level triggered interrupts if required") in
> linux-3.11, but nothing in the kernel ever set the 'irq_gpio' member
> in the wm8994_pdata structure, so this was always dead code.
>
> Remove it now to reduce the dependency on the legacy gpio interfaces.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

