Return-Path: <linux-kernel+bounces-870146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0126C0A069
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 23:29:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74BBB3AA8F3
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 21:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27F4C288514;
	Sat, 25 Oct 2025 21:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P4NujWDt"
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D540724E4BD
	for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 21:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761427758; cv=none; b=qOb2hIZtA5swKlWg+oRLUVKIJYqTB326TbtgZ5qTEJmrQ3SZirjn4uHchHIy9C4AOejdltp/DVjzea64Y5S6BlqkKxp4f7NkmLWjSXH6lkHQt7r+R1exHaVTcH85moT9DinIeAX5NEd/RK8EsLD7VU1bv1YadF1HiM/cikXJEYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761427758; c=relaxed/simple;
	bh=MmMICD0aG5zYZqdyrqj3OoNO5kVn/Kex+T/2Hpjw7YY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fcg6Z5zCDrN6UhQxXRuYZSoQN89Id1oEv7l/Jyk/PLYH8bPrUsLL3lAkFCR+GUm9CoTXwxOZMfSzaFtNv93UKY8aqOky5Ye0oOzs06O6PjjRpIkt4twN/3q0A8TV2QOaHwbl5EXydBwczGD9INrP5wPwP2hO0OHnkxVz2dCZEtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P4NujWDt; arc=none smtp.client-ip=209.85.221.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f65.google.com with SMTP id ffacd0b85a97d-42557c5cedcso2263771f8f.0
        for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 14:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761427755; x=1762032555; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Tiad/+1cEvbbx15ctckUrIUdNeCP0XY3zN8XtK7zXJ4=;
        b=P4NujWDtttW+YbfhbKYygjWazHF+f8LSGKE6jI69DUfWCg2aq4/FcED+qlrn5F3CIx
         79XUwJNrwuj4EiNgn1b1GFLcLzLaLIbLIY7MVKrAFDd78nxy46I99BsWnezB8GHXyPw+
         wOIMaZriBNWfyKo9zpkztPgNXHhcQB0LQ+lFJXZUXmHjfc9IugqGHqg/x2msh0YU+Cop
         alt+KQyNXrCmQBqjviMdnrlwgwiE3HbCqwHI0ZfnFlqujezNhjsV5xWZ5UUoM63DiLa4
         Ed8i21XHEA1+iLww9n9Lc52kZN9Xu44WE0cah0UGkAiLCeWVOE97a03Oi266rUzvu683
         cP3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761427755; x=1762032555;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Tiad/+1cEvbbx15ctckUrIUdNeCP0XY3zN8XtK7zXJ4=;
        b=hjzd2G4I4EOn0cu47I2UGinXuD5FUGYYRUYARc+PoQLsEiWNLcb3Sigse0jNRsjIxq
         dex4rNQAly7mb/8ePbenAW5P8IBOqbP/UGa5mFfvHCrWeBehjW2GCJPHFj7zGHDceya7
         UsoulcO1Xd/yQp7h9fD6dYlQVKfo42Yk/lM7WlK81eQeNnyjs76OrrdKTldvWw/X2o55
         UZeNyDZUK9j0DsD4hpynV2O2JbJrfjtegN8ggMBH5ckEhT+QXBVCN6CdV7KAf9NFl3f8
         3EsPxBbl7xrfEISYTcmdD0LM+CjEN5WISNb62AyPucrXew900oI+SnKP/7vTf8tI2viu
         C0MA==
X-Forwarded-Encrypted: i=1; AJvYcCXH/jfan8TnhAm/fFmzxAAp1ZbiQJH69Yrb20hquiuYAjNXtdA1TF9e+ALX7mRPMYHXPTnurNXl8NAJc4U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8Kmu9dLuhIK7u0DoOP4xrf5pNFQRW8pEM0dirno454eviw/Z5
	XCi3d9I7IwtF/5iQL4oQ+pXuufHdPJv9o8X/jQIZ9J99mif8LkJzSAH5
X-Gm-Gg: ASbGncv2hUjhq7Zoe7xKMZcHxaZlydVuQm+JhQpq/QBHeSUfTcXrHNt9nlrVi2p3sbg
	+ywojYL6jW2kqf7ZCmp912PsXlMkdnkQ2gveX4I7isXRIw47PHVlRkL8cE7kkF8Mm6GbUyvxpto
	hRApLqu5WLNRtSktx6JHNUiO+DrTQepsumfQPZ37gOCA3WVK0XiE18dD9tUr2e5guSBPIwxEZYP
	CcRUEt9BN3BhMZGB9oprNS7zjXvZE7PLF/L00jM9pluhsg3jW502vVh3x3+3tZLqGz51t/DptIa
	HIs1rnu5CuLrbTj+U6pgxmaKPeJOGxXBDsTt60DZJPp0uVe7XMzET58491sVwRWqKRykXTyhzoL
	l4VEZ4YLa+JyV0rbMqccFxBZLHMeNXExDuozvULaLlt1/ZAbb5Ca7Vz6ZN6CxaZnjFCIvwmvAxO
	rLy9E+qhQ=
X-Google-Smtp-Source: AGHT+IFR9xPlXCmUBASW/ik5a6VeudIrPkWWyQ4aeDva1FfLdoVVStcvOXzPLBYNJFCvHVp+roFOgQ==
X-Received: by 2002:a05:6000:1a8c:b0:428:55c3:ced6 with SMTP id ffacd0b85a97d-42855c3d3f3mr10555869f8f.18.1761427754791;
        Sat, 25 Oct 2025 14:29:14 -0700 (PDT)
Received: from [192.168.10.22] ([39.46.217.86])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952e3201sm5395009f8f.47.2025.10.25.14.29.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Oct 2025 14:29:14 -0700 (PDT)
Message-ID: <0881d989-c1f7-484f-a5e6-aee47ee5c5d6@gmail.com>
Date: Sun, 26 Oct 2025 02:29:11 +0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] pinctrl: starfive: use dynamic GPIO base allocation
To: Emil Renner Berthing <emil.renner.berthing@canonical.com>
Cc: hal.feng@starfivetech.com, linus.walleij@linaro.org,
 linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
 Bartosz Golaszewski <brgl@bgdev.pl>
References: <CANBLGcygpsp=R5gM7NeuVO-JG1yfQJ_0dhnFfL1ud=291cJZAQ@mail.gmail.com>
 <20251024143353.71753-1-alitariq45892@gmail.com>
 <CAJM55Z-SrU1Mk4xUZTgey-zArYAvtpftTwGBb_VEb0zL3L1EPw@mail.gmail.com>
Content-Language: en-US
From: Ali Tariq <alitariq45892@gmail.com>
In-Reply-To: <CAJM55Z-SrU1Mk4xUZTgey-zArYAvtpftTwGBb_VEb0zL3L1EPw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Emil,

Thanks for the review and feedback.

Quoting Emil Renner Berthing:
 > 1) The justification for why this is no longer needed should be in 
the commit
 > message, and not just in a random thread that will soon be forgotten.

My apologies for the confusion. I did add the removal of unused 
variables as a bullet point in the v2 changelog (which is in the email 
body), but I failed to include the necessary justification for this 
removal in the main commit message itself.

You are correct, the justification for removing `gc_base` and associated 
macros (because we now use `sfp->gc.base = -1` for dynamic allocation) 
belongs in the permanent commit message.

I will update the v2 commit message to clearly state the removal of 
macros and unused definitions (before "Signed-off-by") in the v3 submission.

Quoting Emil Renner Berthing:
 > 2) Please don't send new revisions as replies. Start a new mail thread.

Understood. I will send the next revision as a new thread.

Quoting Emil Renner Berthing:
 > The code changes look good though, so once that is fixed you can add
 >
 > Reviewed-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>

Understood. I will include your Reviewed-by tag in the v3 patch.

Thanks again for the review!

-Ali

