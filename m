Return-Path: <linux-kernel+bounces-827429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C4A5B91BFC
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 16:36:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E34B8164E13
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 14:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B81E26FD8E;
	Mon, 22 Sep 2025 14:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="ALN+77ih"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2759D2641E7
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 14:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758551777; cv=none; b=drfZhNN/9YFqCJNJgMOr21swCQXZ+5vM0TWGiUwj0xI2Rt3BeBwIokzkWrQFk23+VOatzvr/j1DVW+DMQNY95CC+ANEANk4jjNx6X04XH8Lx6/5wsHcP5qbhP7Za3sJoA8ZibO99gF3H9wH2lyW7+ck4sZhwHNyWuHx5XKMNXDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758551777; c=relaxed/simple;
	bh=qSHWd5MnUoH9778XdJsVkBgBxKqbWS2bZUev7nKzCkc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qPf/UIevadUoAIaAjvLJaUI9pY6AQrM1Sg8KVBGHKF7kSVyinIZQxuw2LPc1pOn6koWT1oovw+j2r8QMSfmtErHIOeSlN+XA09gQHEh2YpARUnPEQPvc3SWmqpVM+431FxaTeBgGzqfp+CLI6ZLeqL5xexfXfcgh7Zszoit1dGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=ALN+77ih; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-46cf7bbfda8so8859235e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 07:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1758551773; x=1759156573; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ko8Z5QtiznqRV9ySmUhmRmcgK8+/zFTv7rS09KzO1lo=;
        b=ALN+77ihs9OwhLl4IrSdrfzHHN4ex2rqEwcFbXljkMPxfgceyT8glcNenQpgxZx+xW
         0Cnuvvo7F+3GSUlPmoo03HJBZ7YmYbjVrTxuogWbyLn9PsJDe1UK0TOs3lP3xrCI7lnp
         R0ewlp4bysAeBffBG62xoErUR5iD6soywoE0yhzD2RLlVMIraPoevexsuAq5Uv503t3y
         0QvdIZrrKJ8L/yCXoRCyLmq3XOW0GommMxiP66GM84CfOYXYJStvYQdfoLzNzWjDyKJc
         3PfC2lMAhFUwlPDuZH4GVWNFpl0q33OMUUVOpms8IYJAVMCe7kOgVtdgo8WST/+VS1xA
         wPQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758551773; x=1759156573;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ko8Z5QtiznqRV9ySmUhmRmcgK8+/zFTv7rS09KzO1lo=;
        b=cxtY6DWHX+svJN2rUKkfZJRqswzhPNNmy+FbqtTV9OaRkun/433eLnL9+l/VaMIzyB
         Hd4VAjIWpNckny0Te2jz7sTr/xKYXcjLMSH0hiGjhgg/6WuG7vXsGJEYx3nyENMfFWA+
         nwp5B8mUb+4dO1SSPhOseP07lbnsix+5LUYavQQotWgwvvEtCPYmrk96+qKOVjyWWec3
         e8gVpTx9LmYJSXCFwmM+en+39539ZLvGRMt+yC8hBhib8lGArVfquN10H/OZvFpmQiKC
         6DM03Cnv4nsYjsThnwwT5D2u7JHiFy7br5s7NcaNLoqpo1yYyt0nEf3wf9Ubl9+uUjUn
         NBbg==
X-Forwarded-Encrypted: i=1; AJvYcCVLCg69RHrVEg5ThAA6DspUnrdAyFinjY8IlryqLLvhDP0klvyIgi7vzK7uXB70Zy30Z6LN4Uur4sH9yZc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7ozjNL9yGo8wYin/rYfXsCGmL7FOvonFgESbKwbJXR2onj4yn
	sAHIqe/yVkOwMfe3HDXjlbhJm+fQoypbx7Cav8V0t/83sVjuk7vANAqXMHl7JXVH62E=
X-Gm-Gg: ASbGncsrjLvoGprYVLRpOW/7TNHNreOu9LQzS9Ra247faykT6AalfyDMEIqnYj4vbKZ
	5BwFBg2L3+UHoH2ydppagXQN920+4nHkveerQoyxXTvvEjQv1az5muQUAHtLkvjuwMX6023ARLK
	M85K/pH5UtpIbttuTHLac+Rb7bftmBQhepASyv78pJzRLzWrEMMvspcl24ZG9ptnazJ/a3BSJn3
	UFFLKUBmVtXbYTPvwcciPLMMo1+qbQvAAybnwhUqCxkdVEFohUXD2ADc589ewstgmAYOgohXIBQ
	Sr6Z0AloraWnUxDRS0CupUIcTxlxaYnHkiWkgInDf4HOMCiFjnKk0vLskpRLKK9lno8yxyMmvJc
	FMFWn/ZPu0o56WMHVh8NHT7I=
X-Google-Smtp-Source: AGHT+IEpA++X6qxNbl4vC7xFqMCAmARSQmCvB5/ZALBbkwN/d6RyhBesngGxcYlwSqWlnZ3ntmHuuQ==
X-Received: by 2002:a05:6000:2c0b:b0:3ea:a496:9bbd with SMTP id ffacd0b85a97d-3ee7c5529f6mr11801246f8f.3.1758551773250;
        Mon, 22 Sep 2025 07:36:13 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:824c:ead0:65a5:c51])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3f88de2ced0sm8633777f8f.33.2025.09.22.07.36.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 07:36:12 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Shawn Guo <shawnguo@kernel.org>,
	Michael Walle <mwalle@kernel.org>,
	Lee Jones <lee@kernel.org>,
	devicetree@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ioana Ciornei <ioana.ciornei@nxp.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Frank Li <Frank.Li@nxp.com>
Subject: Re: (subset) [PATCH v5 00/12] drivers: gpio: and the QIXIS FPGA GPIO controller
Date: Mon, 22 Sep 2025 16:36:11 +0200
Message-ID: <175855172655.83493.11261124209453796236.b4-ty@linaro.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250922142427.3310221-1-ioana.ciornei@nxp.com>
References: <20250922142427.3310221-1-ioana.ciornei@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Mon, 22 Sep 2025 17:24:15 +0300, Ioana Ciornei wrote:
> This patch set adds support for the GPIO controllers on the QIXIS FPGAs
> found on some Layerscape boards such as LX2160ARDB and LS1046AQDS. At
> the same time it describes the SFP+ cages found on these boards, which
> are the users of those GPIO lines.
> 
> Before actually adding the GPIO driver, patches #2 and #3 add and
> describe a new compatible string - fsl,lx2160ardb-fpga - which would be
> used for the QIXIS FPGA found on the LX2160ARDB board. As opposed to the
> other compatible strings found in fsl,fpga-qixis-i2c.yaml, the
> fsl,lx2160ardb-fpga imposes a unit address for its child devices. This
> will be used in the next patches when the gpio controller node will
> define its unit address as the address of its underlying register offset
> inside the FPGA. This requirement is described in the yaml file and it
> only affects the newly added compatible.
> 
> [...]

It's too late into the cycle for the entire series to make the v6.18 merge
window but I queued this for fixes and will send it for v6.17.

[06/12] gpio: regmap: fix memory leak of gpio_regmap structure
        https://git.kernel.org/brgl/linux/c/3bd44edd6c55828fd4e11cb0efce5b7160bfa2de

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

