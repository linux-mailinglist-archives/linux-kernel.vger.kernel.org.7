Return-Path: <linux-kernel+bounces-820291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE820B7DD9A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:35:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89EAE3BFACC
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 08:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18F3E30F80C;
	Wed, 17 Sep 2025 08:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="lcCqaTPE"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E452F746C
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 08:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758099379; cv=none; b=Fji7lfOsmYOONngDU6QCzQZ2iVxdbBKjXSEIa/Qw6nWlPDouIzq0ZcDql6xHTWY9NTc6eQKXrNs0wY39AxPffv+ACYwwfmCF9N8QaY34j2kol2yPMWkx7eg/AddZ/R3HKdo+4mKxH1Kkk+9WZPF845GhXQTwuMdHussbSl80Ing=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758099379; c=relaxed/simple;
	bh=B6c9MTLwc2XGdBCrevDQ9qDxCYaiSZdKMcxvLVT9/iI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BXeGCb0Ka/gzPp/0CNbG1VcfjUXbR68zOJbqkyLJ3XvcJGbHiUsfiGWVLrUmXUsExKGX5EXzY2b/JbWjpamwRKJtU8XuH49iskvsmG9aMg5T4s5o1ldDp3aQx8dkvDp/v/yzipM+8oI6EImJlAGiyiWNrJDa2m96N6J/De8oxZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=lcCqaTPE; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-45f31adf368so17522895e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 01:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1758099373; x=1758704173; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zJpgRICzbLGowr2FIuOE8Yg45vw7HbIpaAZsTNxfjgI=;
        b=lcCqaTPErfI+PKK5uWMawaJH14T8sh/TIZY6+iWPweo/rc504WRVI+Ny4kNJXCoZLK
         8J/n2XMdEVizzIMvbG/6KvzYOfxaTljtMZDq6lyDCJezjdXD44vy5THIw+dau/1EO6Gh
         Zi/Ncnn4srezIm2IiaZ42J20Fm5tYVVbmEuToI/u+46i8ba0vhmkRxR4Be/15nI+O9Sx
         jAA5bdZ/wN6eVz2LRnHY0q4oAsXt6NHFneEMF7SMsHz+DtA+r0aN/a6okDq4sigMDdRs
         /FvKs0B+rGQaYCqL7XwTkitrYuhYZXkvSZnPVixanYJ/a59cCYGtHqFFYBUUYHWAfNb/
         p+Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758099373; x=1758704173;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zJpgRICzbLGowr2FIuOE8Yg45vw7HbIpaAZsTNxfjgI=;
        b=U5wet2CRfxXX8DK4poDJvOR7rf4os9G5Gtr7c9bdi5uGksMWY8RzKYOVkwqt+ov6GV
         nI9bNPGoTZkIKBTsn5JEoyqCB8tm1RH+FSM2HQrAZm7GyLrXFHdybo82s982PENrU4YT
         YNzPx6JC6Uu/O/7LIyV3kuhPpwuqc0udvK9X35EzZSsQguuXZDHf5OdVUHnrOgHXwfuV
         k9DAvTdiFKCUNpp/mU1xFAW3EZVwDUqEg9dpHBZsgaQ6rRMlImpmBECIXGWLHFVH1Vrq
         zfF46BQO7UHfQcBF88cvmJ7Qtc4h1r0K7x05/Q8P0euL5QK+5b6qO3qTL8IbYu1mDHC+
         LmKg==
X-Forwarded-Encrypted: i=1; AJvYcCWst6wkFzNHMsE7AiYm9jZlRsWCHUWwofFOCAj/grBPP372cqkXBYhZRr6zVnneF+QyrZGXAJ1xA0HdZVg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4GEg98AQUrJ3R6w+/XO1D/+GI0696WG3IOmgFjP0zVluF6p2r
	c+TmcUVddZ2qLebRamwCgu2p0q+3tHBkuTt80GmaNxbs3wZnNes9c1betFzl+Y67kj0=
X-Gm-Gg: ASbGncvM8E22m1t/p6bVJSz+EnjxGFpMjNJBG1m8au6bj0/Eakm2d81wmAdC+pXa+pz
	pvf1ut4I7hjbIALFS7lphfyThabHcGYndXbpsdpzeDhnP5EuyEe9vt21JtUyW6V5bgyufwz8YzU
	dfmJYLt/yUJTfIWh0exYG0alGYv70PP/oQYIckKXZga3rwaqDawpsJn/RyE2YxxlTtW3G/lQ72l
	gkZ8nXqWgE6DQy0rLwU7ujGGoYp+s8mtjZECwITZ9ji+3v+uP9gO9kpPLbj+AsvBwIKNSipo313
	wlA3WykGcudW7mnbcmd3QGQSZy0nVnOXc+E5C4wI+MuHISpbFknlJdeHHpeQulQhtR6+M8Dsgn6
	/2N6IuX856YiS0zPRohQMvFUfIMlvBKs20bWiCKPPGTTclRJXexjYg/1ySMHH
X-Google-Smtp-Source: AGHT+IFfHj1d6cqh5fxkybLL27UGQX+/B51RY41pe17x67AKJn2yXlPBr/91btPURGQ/8K0wjUfYSQ==
X-Received: by 2002:a05:600c:548c:b0:45d:84ca:8a7 with SMTP id 5b1f17b1804b1-46202a0e8femr12039265e9.14.1758099373158;
        Wed, 17 Sep 2025 01:56:13 -0700 (PDT)
Received: from brgl-pocket.. (94.red-217-127-72.staticip.rima-tde.net. [217.127.72.94])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ea6805001dsm12895995f8f.6.2025.09.17.01.56.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 01:56:12 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] gpio: nomadik: fix the debugfs helper stub
Date: Wed, 17 Sep 2025 10:56:11 +0200
Message-ID: <175809936780.35722.8768362923828333161.b4-ty@linaro.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250915091007.28438-1-brgl@bgdev.pl>
References: <20250915091007.28438-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Mon, 15 Sep 2025 11:10:07 +0200, Bartosz Golaszewski wrote:
> Commit ddeb66d2cb10 ("gpio: nomadik: don't print out global GPIO numbers
> in debugfs callbacks") failed to also update the stub of the debugfs
> helper for !CONFIG_DEBUG_FS. Fix the resulting build failure.
> 
> 

Applied, thanks!

[1/1] gpio: nomadik: fix the debugfs helper stub
      https://git.kernel.org/brgl/linux/c/0b1619c38600fc06c73b1f59c64af0b7df08fc2c

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

