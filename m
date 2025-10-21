Return-Path: <linux-kernel+bounces-862479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1010FBF5655
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 11:02:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A329C18C7028
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 09:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1712E32B988;
	Tue, 21 Oct 2025 09:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="N6cR1szu"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E13A632AAA2
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 09:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761037313; cv=none; b=VpHPGwjKdzGdQt3XtZcE+AVuHIinkhvj7b3gGQcW9MakrdJOLpyx9iiB4sidgoz6JjIIngDz+pVO5/LW0INHRhiMIxqlNi2HdVbo27GWOUQ5B6SxzAeiIH/J7BSp8sINc42vaT80BJiQiBpqLbyWu/alEKRoQ+cdwrlzuH7Igt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761037313; c=relaxed/simple;
	bh=6FGMoBORg99KnBrarD8GoS8zAVIGXZsSV3BubyDkhDw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TxOF/ZBVuPmvqZCr8Reshq+n4lZQxGlWLpct8D93YkLUlmHbro+KkXiJ/nZHxG/vfG2l1Gis/onMmO0uWWNSBskCg2VJSMmAS/HWkK1nheoRqtQMihTIEfjGI6L1I436o2wYA2BQTJkQokQPazLO3SknHj7eP0pW/iG/70Im82o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=N6cR1szu; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4710683a644so47129915e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 02:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1761037310; x=1761642110; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=49JxCosN6UMd+mu602+9mIL8zSuLvHdexepIGtQqYnU=;
        b=N6cR1szumcd0F7oAFEndX5X4NRVVCSLcsZtmEF/eOwquswLMxVA7xmyrPpKTanEF70
         GfUqEBdWOSqRRtzIQnzxi3rpyYWhGfvK3CClKDYvr/ylZzwX33bme7xCkM0L5KvYoqKr
         QOd+I2G8cIONIYU8d3R1mpgSAvBx0cvhyzhX5fd2EntaPLG4QhGf1F/hw8mO+h4USD08
         X3OvNnWaSMcS/S+kxglqaax73Rn7X0AVi9bFVasJpMHHcFlKiz0RJT5/32y0eqjyc6cS
         nRJ62Tq/OinpxVTGa/inarf3ku2K8FpRVx5E2/QGPHZ6Cih2mxq4J+Idlzgz6HNv03b+
         Iz9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761037310; x=1761642110;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=49JxCosN6UMd+mu602+9mIL8zSuLvHdexepIGtQqYnU=;
        b=gaqZ7xdBW96tha9jyNOoyR2ihS+cEoKenNqNuuJRTLsCPOgXn6wn2NpKT3iWD0bjg2
         1tmrgLduno5LYJtiua0X0CBFXIgK741nJ2iBnsCDKttwyeGqPBM8XtSX8uUwgFcA2KA0
         e2D9ObQP8AU94yQ18zKzxvlKt8l2+kAktkLR3CsfegyzhhWLJ1SOkGYAJWSqN8VgEgAD
         b1f0N386aJ5xaPM+RT3BStFbWRwH2pF2o5oKdvmPLKkRCGBBGr0tzM/lOCAka3z/DP6s
         AYJ9WmF7elU6AkUgohtK5fPXz9uMpZFqyvhHm8VmfrQezWRCbAcBR3k7m6i0KuaBd/RB
         6LMg==
X-Forwarded-Encrypted: i=1; AJvYcCXsADDb3yn3e7odxdAtnFOoW+MYWsMT45IOJ86tJ2+ssSbnSZMCwuilgRXtX66IRf+UzKOUDv9Y9iM2144=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrZahoKSl5Ai1WFuQDIblu47cDDjt9jh/dWIlHn4gSGwGJvYc1
	umd7worDoRNc9SRA/CjI+oI5h6q8oLR9yOrS42qLdypu8GkK4X7t/wDCsv1bZdIiWLg=
X-Gm-Gg: ASbGnctSSYoUIwGyKGIsHWQhP0nx7ZOwU/VtkPTcijGrGhbfjRP0pNG52NtCaH72ZVy
	HdTHl2QvbTVUr52ANiA247OQ+nz+aw+uxoLgElG2XbzuuQi/5ZaBYlrdzlzuAEjLeJudj8NgcdD
	xatpEuN93zjMJO2jIhAVl1RQ+FCOD3INPB2GgYOS7tfJqjPTClJYmp3oposXUUjSsy2ldy02Qus
	cfNf6IL0bG9KcBNm4Dab0Osty26RCXvgXWPKjPOmKye7D9MkEXgNezAEQjqhjWo4Fl1381lhiQb
	K63KoNP76lu9xHHYJz/iuexx5HfV6NSxg9hBqES0aOKlAzVXQuZOnlp543QELxwyIW91XevZf74
	D7vyvmtv0P2J9CfEj+G3+ydLRfJaHAin/gOpSQvxmpjEHcDVELn8g5WaJV6mJ2oFMWvAzXg3xia
	SN3g==
X-Google-Smtp-Source: AGHT+IF4+Jqg42h4vf4LdcJ3ZdiKv/gkignL2tLnHJsLuKCIADz3i+gKe0h9ZTIsqthfXRn+rzdJQA==
X-Received: by 2002:a05:600c:4483:b0:46e:33ed:bca4 with SMTP id 5b1f17b1804b1-47109b58b72mr87717475e9.15.1761037310064;
        Tue, 21 Oct 2025 02:01:50 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:2979:9ff9:6677:97c6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4715257d972sm191369065e9.1.2025.10.21.02.01.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 02:01:48 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>,
	Frank Li <Frank.Li@nxp.com>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Michael Walle <mwalle@kernel.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] gpio: qixis-fpga: add missing module description
Date: Tue, 21 Oct 2025 11:01:44 +0200
Message-ID: <176103730244.11215.5092820773554833275.b4-ty@linaro.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251020072028.21423-1-brgl@bgdev.pl>
References: <20251020072028.21423-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Mon, 20 Oct 2025 09:20:28 +0200, Bartosz Golaszewski wrote:
> A kernel module must have a license and should have a description. Add
> missing MODULE_LICENSE(), MODULE_DESCRIPTION() and throw in a
> MODULE_AUTHOR() for good measure.
> 
> This fixes the following build issues:
> 
> ERROR: modpost: missing MODULE_LICENSE() in drivers/gpio/gpio-qixis-fpga.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/gpio/gpio-qixis-fpga.o
> 
> [...]

Applied, thanks!

[1/1] gpio: qixis-fpga: add missing module description
      https://git.kernel.org/brgl/linux/c/e0a6ec724e5b87a0b162912b5d30bb6f066677e2

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

