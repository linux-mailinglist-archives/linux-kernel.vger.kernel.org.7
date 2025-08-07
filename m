Return-Path: <linux-kernel+bounces-758780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B58CB1D3C6
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 09:57:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEB96163394
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 07:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F18AD242D8C;
	Thu,  7 Aug 2025 07:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="jgCUl2bT"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 729A82E36EC
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 07:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754553442; cv=none; b=EJYZodVzu/QG+1g1MsAJGX3Gm+fdo2bd1fUaXUwUWRlmxQaKIE2UjS2mg0pk4a46usAl6YHhoXX3Y4kyBrUa1623alwZsdoW6no3R42l3yHn5KfSTQi4LbKadDAHkd/LhP5KaQDMuhgIdBVfrF7/5LqEH36/7SYxg/qCQndOUzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754553442; c=relaxed/simple;
	bh=vgkfpdwJ4jw4QPMZ8xrlzKyL8qOR5t7DvsVO97Z8Mvg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cGqq5Bo+GZEgLBY1O1SfUmoysGZIDfr4yJ96t3HsM2zDHV0L+XPV0Uh1EeFhzhf8vxXzhrAPhqe1bbZddQ4aN3ZwrD/0w+CyAwoQyeT6ZQ4P4sXjkOEXme+ANxC2oxMZdjEashYZ8rHDearyM053PiYrMepppR7atT1jiiqSl6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=jgCUl2bT; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-458bdde7dedso5042075e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Aug 2025 00:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1754553438; x=1755158238; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SfU3+JLlOgj4XUuWyXL62GCcWpurAz54I0DEQzkcox8=;
        b=jgCUl2bTHVqAh44Tw/v0vqLOj6ZvfLpVWe++u4kHN/wF8M9CHlYx9PTSNZnwTgHkuY
         fT8mmYaf8LjlNIibY1c+e8ZOtS5s6nLagfypzrwclt4HRXH2F8+veBIWAeXlY0ZXDjmq
         oxkztSASvC0gI7FWh+WPT197Xnuh9kTf2/enBfDPbwYjh54N/SVs5oRrFEoeclQ7vkuo
         LR0Ag1c3jG1jmWXpvEkoLJfdAsWlmzD57zDwspoVYcW0wW2VYL8b3vU1Ku/MuaFQWvb9
         yCd19Mdmt7z+SBGqeSNJfxFKWc91bP2LaSYVSzld6Nh0gVzqu3VN3IFHGHVMWrir7RSk
         8FFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754553438; x=1755158238;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SfU3+JLlOgj4XUuWyXL62GCcWpurAz54I0DEQzkcox8=;
        b=UsqqeoEc8jLAisLNMRReASRzE9ntEYZPCOTFmtHb3T99I/T0b+jjkfNVzsXOA9vYkg
         vyluF2UazP5x8muviGCx88PZfYA210cED/QG9kjV86K1/UOJujSSiIKHn6lTE30DAF+L
         hBSPkrOrhUO84FOjC5xfsO1zk+kjYbascGa1/sP4MRXskT4Ij4FxFzp6mrEhxvKVmuo2
         76P0WtV7nz5RQsd8xwRD9g5svp6xhTAahBxbe3LJn/zbYrMmh2gVYEJXaS4UByIXaluE
         EHKhb+QQ0Ilc9hlNhZkxeBpei/+VCN4x01EQDgVpJXnAOpafzCdZZ5wP0EH9O6orFEJ0
         Ld8A==
X-Forwarded-Encrypted: i=1; AJvYcCUBJrSu+Mk9BdEU2TewrQA5t4VDLywXP9lU2zKPDfbad0dYhpEUfZFsdT+GF6BNUbKGXqaSzqIksOnaW9c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZhZ8vX8mod7IjwSGTGEG9FbYJH92bo2e5F2265Mnz8ZxZuBOm
	jHF/fHsNYbUX5VZsL7kMVTQDMMfG1H42j8SvhGjOt1/iC5qggrjUyun/0d2XncrBl3g=
X-Gm-Gg: ASbGncvfCr3Jgb8zJ1jr5NHRxfuKgSD6kRbBB3ctRMTiTje89aj4xvYbNla/CgYyD3L
	ccilSJVGu1lQiRHk2zHqWXMIoWkTGyxSzVeyAkXZVKPCM+kw6uwcmNhVaKpUjmJg2sJYR+sto6r
	JeaKBgtw4RBAUT9zF8zcQrYYfrxwJ5soiWI3b0o6DB4Z35AurqLVITc371QeL7o0S/cMvmU/Lh7
	2X0jaEXiB4JMD7394rc9gfHAvfz9NfhUyJ+VcaeaMG7iAvwOYmWPgfdoAuHqTbzxvBUmD0oUOtF
	cfMdEWl145rRUc2VGssx2XYZ6Ojd1FtbdDOT/wXpQn3oGx5N9vNENkmMht6n/mnexIHA0OhepOP
	Y/EyQmSfhcTbO4GFn5NDj7eVy4f6Dr7/Pqec3EvHkU3cOgHJUSjg6ufxjEAduHK0UtqvaMMBC61
	UQwgZ3C9I=
X-Google-Smtp-Source: AGHT+IG1Zkw/5s891kaO2uBzPkSnBXo2w2+ZGLhV+2clBzLljqoEFUKEehl54k7C+1ej3DQSWerCIg==
X-Received: by 2002:adf:eb83:0:b0:3b8:f8e7:7fea with SMTP id ffacd0b85a97d-3b8f8e7802dmr1563703f8f.7.1754553437672;
        Thu, 07 Aug 2025 00:57:17 -0700 (PDT)
Received: from brgl-pocket.. (2a02-8440-f501-4c26-fc12-1c8e-3b9e-e794.rev.sfr.net. [2a02:8440:f501:4c26:fc12:1c8e:3b9e:e794])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c3ac093sm27069447f8f.9.2025.08.07.00.57.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Aug 2025 00:57:17 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gpio: remove legacy GPIO line value setter callbacks
Date: Thu,  7 Aug 2025 09:57:15 +0200
Message-ID: <175455343159.5538.10394058883390003007.b4-ty@linaro.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250725074651.14002-1-brgl@bgdev.pl>
References: <20250725074651.14002-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Fri, 25 Jul 2025 09:46:50 +0200, Bartosz Golaszewski wrote:
> With no more users of the legacy GPIO line value setters - .set() and
> .set_multiple() - we can now remove them from the kernel.
> 
> 

Applied, thanks!

[1/1] gpio: remove legacy GPIO line value setter callbacks
      https://git.kernel.org/brgl/linux/c/397a46c9aa3343e8efe6847bdaa124945bab1de4

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

