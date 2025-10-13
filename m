Return-Path: <linux-kernel+bounces-850107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E17F1BD1E4C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 09:57:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D0373BACB9
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 07:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4A872EB841;
	Mon, 13 Oct 2025 07:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="fmCrNkRl"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC242EB5DE
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 07:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760342211; cv=none; b=kK/2pDdPBGvyMn0ggkX+VHLBdk81Nr5YYwIKodEf9OKA58P0uuwnTgmJDkDfCeSih1gA2fqDCcAZQGgAT/tWJYTqOhGmccSF7Yc9NKUDeyDzCsRnD5RHdhAB1mhibadZa5sDv4Ii+befueadGI5LDxumzoACjIUVuI5mcdiUsZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760342211; c=relaxed/simple;
	bh=SL7n2KdQvOjjrVhOkMHHRC4gMIQW/W1Btvg/A0RdL2E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OQ4ugp9NcXeB+OgFJs4Od1qW5rMVa6x0WGUaC+Zf2ms4p5b6YHK/N6PH6jRyy8Dq1ls3dqyl/TqFA+rkbRS5nwKkKzJOcWwK78J4oHcrJca07XTQbDAv0uqTOvlVeFiSfRhsanrcs8wTDaUx4Me3Hw/FQFaVV3eWl1O7Z//jwY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=fmCrNkRl; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-46e47cca387so39064185e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 00:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1760342207; x=1760947007; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ti3qbUsRzsBtmEjEWfle0or3xlL+83M+/faVmQZq/YU=;
        b=fmCrNkRlQN39C/GCTC/poNQX7HlrmxjuG7g3b8zqMyZslwKRHMvitjEl+7woymWLZ9
         auavNFkvoezbXwCb8uQ/SMeot/q9PLj8C9Z8K6YQlULtozsBqmGFlR810uad8STrBnNh
         icQBN+sspUTSexQ1PLpm+VRjTwvfcKL5a/sC0exTDxc8GuLyKjU0XFrqaK+/nj909X/o
         4+OVp6tlyE9Ib4VLwwqSsC4wEueZhF4Wd1BonRJBlVDS8EYM7rikng6wnsnWCP0u5HmS
         CT8CKjrtKR6c/EA88LpDx0Q3Qz+k1DhpJtKqQzgUgK4sdBz2PS6LV6ntAS8v2Qd8uvkg
         kGxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760342207; x=1760947007;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ti3qbUsRzsBtmEjEWfle0or3xlL+83M+/faVmQZq/YU=;
        b=HBCDrMdHypk8tzndoiP+qAGoteAjexyjiEBzluvHKVTEjwjxw83WLbk4+ljl9Eb1N0
         eHhS9XojtUGB0opqfTuSIiYGUqFo8tNcq8hEt96zvPqRONUduKKAzTsjvLMrjaLnN0Ad
         b6kc4/4zh15AAYMWgqTW0Tc8RncKoQSts3s92Vn6SK9dSCgr2Vf/0xU5ov1b3/faZU5W
         REpTSrIjJjKJfAK0JWk7MWbDYgJEYRnMUhuIW8uDQhAtl814Ve17YWqW+P4Q8wgjg3IV
         bFHAdVRXLce9rxaE+aYYWjz7dKBb8k4lQ6h6f535PmTQWVupj01/gBZK6dY9oMbJmA7W
         QcNQ==
X-Forwarded-Encrypted: i=1; AJvYcCUDSXRkO+H4msZJXeeIKGcmEwkyc/KRx8WoHE9xQw83XQ6FTN8rV6kWTOqNXwjHC2xv7LL1vBi0QIcWDWU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyK6KgcbE3sbxROb4l//BAew8ioh1IXpqxx3PrsDDjUSfahyktq
	pXErDhUu1L0P2qlC1adJtJhC0nXUqCecxT4TgeIbtFORzL5e9R/eGdGWO9KceUWIQlg=
X-Gm-Gg: ASbGncsKJlU3jD4cZPuXB8I4Kly/+X19WmemeWkogBW9he2TBY5OWAK9JAB9vs1NSfA
	hRK+DYeZfLQMZm43lQs+yeYpgJSb93BYYdq7HyMnjZQ8H68QOs7d1auIzNe+IkQ+qz4pmhOpvoJ
	GHMqR899OBK0uihM52Q/1TqMVPZpbZN+FFP/IUrN9ZVyT8JBML4OxuLLruWhY9bUiVoNri0bCyJ
	qjOIs6/k9rEX2sXp90U+VpQZUAsY1Y+Gv7BS09bzl++9AaXYcfilIeZ68T2ErXd9qpFbvRo80SM
	4gR7j9a3qhI2H8oSfiCABkh1wNuzieekKmIBKVRSP2CxRSXW/aL40iMnUrUEHEhUVG/TRqu3e88
	7EZWx0mqc02N+eSIiivd6bUwzyBJ5uOX8p9bOQRYWLg==
X-Google-Smtp-Source: AGHT+IHOX1/2+jxlOfUxvgfeklliY9quaHws1lnroDn6Tp+1CVWZB+Gp8DCBWdKEIn9UPKfg90tjZQ==
X-Received: by 2002:a05:600c:c4a4:b0:46e:1d01:11dd with SMTP id 5b1f17b1804b1-46fa9a89444mr130387155e9.2.1760342206713;
        Mon, 13 Oct 2025 00:56:46 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:fc45:d50e:e755:a6e4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fb32a84edsm96545345e9.4.2025.10.13.00.56.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 00:56:44 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gpio: virtuser: check the return value of gpiod_set_value()
Date: Mon, 13 Oct 2025 09:56:41 +0200
Message-ID: <176034219937.9647.5828196652299079563.b4-ty@linaro.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250922095841.52330-1-brgl@bgdev.pl>
References: <20250922095841.52330-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Mon, 22 Sep 2025 11:58:41 +0200, Bartosz Golaszewski wrote:
> We converted gpiod_set_value() and its variants to return an integer to
> indicate failures. Check the return value where it's ignored currently
> so that user-space agents controlling the virtual user module can get
> notified about errors.
> 
> 

Applied, thanks!

[1/1] gpio: virtuser: check the return value of gpiod_set_value()
      https://git.kernel.org/brgl/linux/c/383760e3faa4d3df6e399d207e2930a785380c4e

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

