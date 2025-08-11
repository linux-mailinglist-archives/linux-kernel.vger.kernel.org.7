Return-Path: <linux-kernel+bounces-762675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D59D0B20990
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 15:04:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90F7D3B03F1
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 13:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12B003B29E;
	Mon, 11 Aug 2025 13:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="J+FsrAva"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D472D29B7
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 13:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754917455; cv=none; b=tMtpOKcDZCBH3zNv2TBExvLJT4ofiNiJEca4a5xUkctAyxJlDbNHhLTwMqrmnuBkcf40I1kQ01jBvPbTnYcA6POY04lOIlHFUW7MdaAW/PGxiBa4O1eZhRrYE8SRkb9UMXV1b8zCLCKOlC+OVRCoI33SLi46EndK9AN9hFY7U1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754917455; c=relaxed/simple;
	bh=UIAv6R7dgXimPGt0N+vkLUJHGcilgggiS9Tp1RgoP0c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ku94EgZtFL2ViFFldaCvPshWNw2OlQf8/HU7Z6o1+bPwUAWd72tQ7rv27vX2ae05uF+dT8dqzfmzDQYibRexI4RO1AjY46+6neitsO2uW/mxYdbPmt0ncUabGhmlucpmOTY4tKBEDWQUsZ/uFKdTIqILt31lFbSJrIfmWA/6x+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=J+FsrAva; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3b783ea502eso3023212f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 06:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1754917452; x=1755522252; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pOGdI0qcS1DuMMYIZAl6Dd0I+M+1ceI41qmsPEwfMrI=;
        b=J+FsrAvaMON+i891NAtSIKCnEuhd3VAeJ6iWItNQx/ngBJ25UOhTQ0+J0sz0WAhVMn
         fcOIx9uaxx2UzWNeOiFMzf9sNiImvMo/TX4l5MZrYQIgSJPdDFPVupUsQEFMJ+elTLfi
         93CuoL4QANWqupX7dsHMJRdV+w5nZDU/wEioAKzIkDh2rXm0ZLciHq7W+d9EUEqcUP/S
         7zQSUnFNloqwRWbWbUv+IWdx5qmLjLWF8UAg0MWZZgDy9/n0vYuqYBx0+MpluRJ4rJI6
         DeXYYJbYYlJF3AubAZpee2v5clylXdkyexoVNciFqZX/ASFtvhdlIFGHXagVoY5hdDQ/
         gZbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754917452; x=1755522252;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pOGdI0qcS1DuMMYIZAl6Dd0I+M+1ceI41qmsPEwfMrI=;
        b=gD+PuLm6gesC6WrtyGkxEPa+eEj3PhLg6tLg3mUYQe3cjFjFWbG3P+IaC5B0GYgMGN
         J7KtLJiQuunVpu0DENZ1cdwpsb0q96RrNtfiZlVolZ03mN9N+LpUzdaQFokjL4zVojfX
         6SZBcXCDBGbbaB++moe/f/qXMLWmrkC0zFJe4VkOjuZEJzAT/OyP1urtQbSCz9LNN0ji
         arlhEY1jE04ICbopKO8cOvawpdb/2/6F3r35aSFy1at8RhS9zmU5fJsF/L1K0pmDzEqI
         fOAjudUQpw+/91n7tFOCETfkSeeptiu0Xse0/XtucJAJ+BDXlWWhV2X4DJUAWumgBR0b
         NP3w==
X-Forwarded-Encrypted: i=1; AJvYcCV1IGHRPYVxmXKOk3or5uGhRCP/ifPs31ZAspI638pfDVue+ISzVMAAuPIes9CiWlid0/KxRm0N530aAbY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9oB1Nfa5G25sye7heFTXvII1aiTv+GHSVOa6G3INOo/EBqA3x
	7+yEKWYt+z7MH7uSowWAxil4qUJRk5lvnaxq6SDWn9rV7QZvAPaJcU6FHG9G7IHQNQ8=
X-Gm-Gg: ASbGnctYczyD9gOEktMT749D1kQOegc+kvuRvVE5bVRI8VtO2o3lGt8qZZGru64bKxg
	rnn+QWgdO+qOb5p8HNbvPjNrDKtkPvLTPIiCzUejWeCSubzOD7RVanGlcdy4kGv5h8QZQ28KVcq
	D0T3HVrgAH6J6rmWiRM+PIrJLXcmQkqeEIeZ0Tg8BJ090XmyPfXDpTv/74j31OWH29JWsYiQ/e2
	SomQvJVPWwlYViiWJQv0uvCMSuuM4zESnCmLUm0uZkT5Wq2SIHMtM+3hfkEli1qLlGkcUr/I7Rg
	p1RvxFza/NUnNiSOAb4Fm8X6Bv9F17nJV3rGNc2RgXdMT/Lb+bUpa16xlQbo54ZvIQWe+VB69bE
	BJeRGbmocwi4jEb9shSXGc6x9
X-Google-Smtp-Source: AGHT+IHtUbLqpcg23VCQmTvH5m2lShmq9cFbBS5x0r30qI8afvacXVE3h1Mdirh1FpDghLktqygdCQ==
X-Received: by 2002:a05:6000:3111:b0:3b7:882c:778 with SMTP id ffacd0b85a97d-3b8f97e1b4fmr13538412f8f.17.1754917451367;
        Mon, 11 Aug 2025 06:04:11 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:6841:8926:4410:c880])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b90a64318fsm5400195f8f.21.2025.08.11.06.04.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 06:04:11 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Bartosz Golaszewski <brgl@bgdev.pl>,
	Linus Walleij <linus.walleij@linaro.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gpio: TODO: remove the task for converting to the new line setters
Date: Mon, 11 Aug 2025 15:04:09 +0200
Message-ID: <175491744673.53661.12726233261625402174.b4-ty@linaro.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <417af7e5a110c527eb759289bd5d2fd6885f4e01.1754917104.git.geert+renesas@glider.be>
References: <417af7e5a110c527eb759289bd5d2fd6885f4e01.1754917104.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Mon, 11 Aug 2025 15:00:01 +0200, Geert Uytterhoeven wrote:
> The task is complete, but this was not reflected in the TODO file.
> 
> 

Applied, thanks!

[1/1] gpio: TODO: remove the task for converting to the new line setters
      https://git.kernel.org/brgl/linux/c/6ec4b94e8e959b4201ca0bfc43fa50dc946d10cb

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

