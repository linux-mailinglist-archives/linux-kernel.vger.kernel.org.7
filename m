Return-Path: <linux-kernel+bounces-805227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D3EDB485AA
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 09:40:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D9023C31B2
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 07:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2872E2EB84A;
	Mon,  8 Sep 2025 07:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="bn0+CyOL"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19912EAD13
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 07:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757317142; cv=none; b=Wv2Yg/d8U1rcKd+GSKh4AxIH5XLKT3+qtyTQlxC3odBdZ98CKY3vE30oiTSxejNDgAfEZyMoBkwVDNMcQZwISqRdjtsXt8r58d/kfTxHkMVtdul2D16vISlH4Zl0OTmciHEwBMYO58WocMmqOXTm61JOnwQ0YzDiaKOULw1HPyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757317142; c=relaxed/simple;
	bh=MPT8NiohwpIH2FRM+/GL0Zo9ZEY8NsCZTxRtvHtMSMA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dViwA59PgMD4ldpwNcZZMLtVtyd8BlGll+J4PAI01U8IRki2kXikgCnAFcQvE+9IDYXKr5jru1Ez6msZh5xu1X7Izo9uLzKh4ky/yGDLRIahJMRtrAgun9bZ51Ztp+mQf8a5oan4XWdhHKRSL+IZ16KuhdZX+QS7Y890JwQiFRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=bn0+CyOL; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-45de4e1a0fdso3077565e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 00:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1757317139; x=1757921939; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T6Qgw00JLihNswGsKUrWXq3EQB6PCDyKUk5esdN3dkc=;
        b=bn0+CyOL4Zht1NuKe0AMRI5SUB8Bvx7QhKI61DOQSyNZ/3KGk4LrAq81gipNoy3EAt
         T4qffOU7W8jhZg4VQ7vKLmsUgFKgN54Q08KRuxh41lMy7UGr5U7ea8nVZQKN2+PSXAez
         Ik+7c+UQwiZJ0FxNnRmJS+f/yCvtlKSaijp3u3aYPVjL+cFJfHfP8LM+Wc1eUkjE+Ixx
         A7cOtsR1/FS470qvoWLvge1W4W+e0q2aE+J7wqKCQvAonu0CUgr4bMwfbtAS3Voy2xOB
         e/sMW6ggObVlGOlosPPMTo1zGXhOaeYdMwkLsP8eP1HdHEYQ8FcCiquTw9M8Scia+UQm
         9IKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757317139; x=1757921939;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T6Qgw00JLihNswGsKUrWXq3EQB6PCDyKUk5esdN3dkc=;
        b=wFf815OlZHgnej59laggclhOZ1FxN1FEd7HvQXkDLdA1jdtdKcgZ1WmCMSLnnDvjQM
         KPeY3WghfOVkZ0kqYo+gA6xxW4aNAf0b1/vpsrP/UdkisRG0eWmRYgcUpF3ZklKlB1Ng
         gfDcC+OVJgmx8eIRn2/a0/keiiaZJTOEAwKdanT2SzEZDIHMxNa47qaJ7wB5UcKqdlFT
         +tqEuOHb4pDEkYXxZqDSyq7oqab5hJS1uHVT7IjBE1usZ6GU/Bq/S0EdNzllCOxnEZzj
         Llrj38AXpnSaaL+/DOpR0rDCSBlHdqNsqm082nIWA7yInBnOv+7lbwWI2qOCURgzMaWL
         wVsA==
X-Forwarded-Encrypted: i=1; AJvYcCU9VRH+gSjZFbx9Yo1w+qc90M+rQOoKfny1wYYMFlYNzxZ8RhD9t3QiQxgPcav9+IW3pjmMTMB5r/pCU64=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWfS6GidxodXji5wM6RRJrwx5tRM6+CA6CvmKVlkatASsHFEds
	psz9zR1I3/dkaKcfNUOtJ9sCL0G+0khQQGAFbVAyhvGziw16SaAYb848xc8Bp8iIAMA=
X-Gm-Gg: ASbGncuMNhWs4E0OSLL1BS0dbF855VY3FPhMKLeC2ekfyTaQvRpOtKofYfSbYZyLADC
	TNSmTtw+F43C2/wQK/ulgsVEz8c8jg/x5HkeXGbiDbuVgRRFTp7/pxVT/OtuW7QGRCtPJ+qb1eD
	sohEwqV3EUlU7I1HmXLiu91QTgkXsvVZxS9MVM6oevU3LqOiR013mi0uFkNivw8f5QE3BFxyMx8
	lL9RusXFtLTeQz+5WtBv7nQO3Oqml1Emi/wqV3w/1nu21JVY50STkvg4vZXsM6vkVWER9n4QIqV
	itx7I/FdoVbCay3VqHqFCrhmFNIhiH+hbyEG4qgTkDCjtLBDytywlZkp10zhliTZdCVOY1GW672
	KBh6Ms9V1+zmfAmDSVRFDENRb8IQfDIVBA/Qt/FgY8dfrwA==
X-Google-Smtp-Source: AGHT+IE11TRP6jW/sA1IoRyIuD/EMwHLllVmU+DHqF0PMbyJk/g8CcFlOS/FaP1Ivex22BkhPP0yAA==
X-Received: by 2002:a05:600c:4e51:b0:459:d645:bff7 with SMTP id 5b1f17b1804b1-45dde66c671mr59265535e9.12.1757317139282;
        Mon, 08 Sep 2025 00:38:59 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:5cdc:d980:b6fb:1eb3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b7e92a42asm429977665e9.20.2025.09.08.00.38.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 00:38:57 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	linux-gpio@vger.kernel.org
Subject: Re: [PATCH] gpio: pisosr: Use devm_mutex_init()
Date: Mon,  8 Sep 2025 09:38:52 +0200
Message-ID: <175731712491.48218.6418145557482787417.b4-ty@linaro.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <01910ebdaba7d8d0cdc4ac60eb70da8e29cb85f1.1757251512.git.christophe.jaillet@wanadoo.fr>
References: <01910ebdaba7d8d0cdc4ac60eb70da8e29cb85f1.1757251512.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Sun, 07 Sep 2025 15:25:38 +0200, Christophe JAILLET wrote:
> Use devm_mutex_init() instead of hand-writing it.
> 
> This saves some LoC, improves readability and saves some space in the
> generated .o file.
> 
> Before:
> ======
>    text	   data	    bss	    dec	    hex	filename
>    8431	   1808	    192	  10431	   28bf	drivers/gpio/gpio-pisosr.o
> 
> [...]

Applied, thanks!

[1/1] gpio: pisosr: Use devm_mutex_init()
      https://git.kernel.org/brgl/linux/c/474014cdec1758e1802082b94043189e198c58a4

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

