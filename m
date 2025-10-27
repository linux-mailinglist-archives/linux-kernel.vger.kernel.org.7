Return-Path: <linux-kernel+bounces-871207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5904EC0CA3B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 10:25:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21F84401D35
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 09:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 481BC2EDD7C;
	Mon, 27 Oct 2025 09:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="2fzTP3Bf"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BFB92DE71D
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 09:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761556777; cv=none; b=ZYm8Rzw/QNcWfPRzJRwcH8tWYHouJgZAFRyBPFftm06okTk4yinfGg8PSIbfMbjpn+dkDF521tqP9zjRmqYBrEj1Do/bVi9Y59SBcURNjAchbJ3zMLO+Vo7eax6xbEcAMndn2ilqiQY7ZKx64pqzvsjCFxrgRj2mwMXrZf7lgpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761556777; c=relaxed/simple;
	bh=bolzSwxyoeuw3xzSsGGpFrysawU+4VMK9wZj0OQ4h3Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AEMwpm16j4vdsebWzyzcJPOZluo2/eoIH/D0oDO4LT2fFMAX0aRaiXVlyqzx1K7ZB39eopd19dTJUtpYZdKSwx54+VtSm4YSC+H8xKgydlOPlmBX5aHtjNCLBjFKj90OvE47cdIVmJjhZHdaYgZaysaSvyPp4Zf7eYOhDa47IWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=2fzTP3Bf; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-47114a40161so49464525e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 02:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1761556773; x=1762161573; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HLwTNRC+QXM2wltZXmt1/Ig8frLjkwglkfeHmY2zBeU=;
        b=2fzTP3BfHTUZg4J7uwcGpZMk6fmiwuBCkG53GLOgKLFcZ3ncT3daOKrVbc/5Yuiym9
         GfBmmLoGHwvf0PogrPA34zHx7A7XVNqDC7b5ZEBv0q/f4hT2OA9Fn1IjqfO5llhnr5UB
         +2fspOVdj62SvLdq0ZPrhrRl6pqZAV2uD9Kv8D+Psn97p9XLm0cxxiHlOMIyZZMVOPgW
         yE800CHYcUaeDZ31oYepOqd26LIITOzDlp1L6LwuG1WHkeTClOzNRU19G9YvPi4UlDhb
         FsN9z1XxXAxhc6VF4pbrS1dWHF1gNgdRrMaeHSHJlO0iUE8Jnr9trivlrFAvAx3XHXVD
         +orw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761556773; x=1762161573;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HLwTNRC+QXM2wltZXmt1/Ig8frLjkwglkfeHmY2zBeU=;
        b=MP9mtM5GwW2WxkBfUFb5v7jqo50lu21bZkyLjy2wRtQ6/q615Hej+SHQACDSsyyUCn
         daJW7wehIsg8b++APsHfn+53MnGpAYZtZ/nSizp/0XPs7+v4yWDW72UJt2vEH3Jfrn2C
         /93g/Y6EGinncm/yCqqBwQh3thcJOVAdvAzywLNhbs4ZU4lAq+0K6JojcIQJbMCnrVRr
         r9M/eP5InPqf7seESYgKeEcM4+jy9rHwqnNgg/0+VLdgRJbf2PvJApC1Uya37dVB0+YD
         SBu3uNC62iKVmxG1yrfKMImMA8ifGkp3eggy31fIHTDMn28Wvw1ZSn/nD7+C+Bb9xAS4
         7UfQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4GaTyplyi6i8+1PQNEgoDcvC444cPtsIEBr2u8ooZetOCQUUhPBo3h/5z+uJSMyoy2UVLJtPjOR9Tluk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdXK4vGMWC9DdNRachqAhVtHpxldjg/DjbBhBNwheMKiJbFztl
	AyZd95cwg+nJNByMt92I+0gsoBSFEvCepP5nuR0NuAGO//mSXiCex6IcgKneBhjoFTw=
X-Gm-Gg: ASbGncvczoKsv5zl7GYg7FRX8A2pby1AnlpH9i9YlbTBXnPgHilM1vd8CYG+TsEYp9R
	H6WDwH0LvqcDiPHDhQGOihZSNPeXuEMBiRaNVGiNUIhqTio4bBTmHgY/IJcFX9CiIRLo3mCUhaX
	J/sraEdY/h0WXdkYVM7mc3sN9wpECoH5L02hVLg/sH9xRTJsynF5vk4aPExluuMa/mkUi1EwFQg
	LvnD69gp9v7P9n2i8YQSADmvpSyvwEtZHuBdLWL8lzGMq9+Kmd5uUODe5bx3Xm1tG8S2jb7v1Fh
	Dyqb8bA9rlahpFYg2CdLt3jlS4f3E8HziDGwg+cge/NQbCu6uN4+Fw2xy69Pn4lGOB6aKW3BPVM
	SjaxjNf+ripCjTmh+SDjcUuzNB2KLupPyastseuITU6Q1LSSGqs2CNuLjK9g+ck1oCAk8vgNCm9
	HeinhbbY/bfvs=
X-Google-Smtp-Source: AGHT+IFydLgSefUUU+8rU+5qeCjpWGOKuNGnYaoOgJsG9vuHDfisTUDla/4LWqckkid34Fks2szOHA==
X-Received: by 2002:a05:600c:190e:b0:475:dc5c:3a89 with SMTP id 5b1f17b1804b1-475dc5c3b70mr71837635e9.34.1761556773351;
        Mon, 27 Oct 2025 02:19:33 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:c1c6:7dde:fe94:6881])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475dd494d5csm126341835e9.9.2025.10.27.02.19.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 02:19:32 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Ioana Ciornei <ioana.ciornei@nxp.com>,
	Dan Carpenter <dan.carpenter@linaro.org>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Michael Walle <mwalle@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH next] gpio: qixis-fpga: Fix a NULL vs IS_ERR() bug in probe()
Date: Mon, 27 Oct 2025 10:19:31 +0100
Message-ID: <176155676924.14205.13738702984732824686.b4-ty@linaro.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <aPsaaf0h343Ba7c1@stanley.mountain>
References: <aPsaaf0h343Ba7c1@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Fri, 24 Oct 2025 09:19:21 +0300, Dan Carpenter wrote:
> The devm_platform_ioremap_resource() function doesn't return NULL, it
> returns error pointers.  Fix the checking to match.
> 
> 

Applied, thanks!

[1/1] gpio: qixis-fpga: Fix a NULL vs IS_ERR() bug in probe()
      https://git.kernel.org/brgl/linux/c/9452252dff94ff2cbcd33d3418c2b95ff74bdba5

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

