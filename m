Return-Path: <linux-kernel+bounces-754484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6199BB194D7
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Aug 2025 21:05:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4499E3B4EEF
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Aug 2025 19:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 209041DDA09;
	Sun,  3 Aug 2025 19:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="Q1P2gAsy"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1D61F2BA4
	for <linux-kernel@vger.kernel.org>; Sun,  3 Aug 2025 19:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754247940; cv=none; b=rF8Nj0Rs78SoLgVTcJBC1ZxUWMTbQeCMgh5jncUlwwvuJ9RVLwLbGfbeQo0/pPaNJmNiXv02Fk1s3AkuLKdJwo630PcnErF0rLvLy6eGlf5cnA8YXLc5f+UO86nZ1y6RxWsQmofkiW/n5nJBwKGoX38Y1/OVpsK8/X4OuP3JP9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754247940; c=relaxed/simple;
	bh=PMyIylZMNl7hOmJVaTu9fUoxGlBy9SQAK3UVNLWLrls=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pTDu3LSfOtVYar5GqYcee2kQNj0lKFlu5LNbVabnxjcsE2NHWDJK/gV2+kfKwmS569UPgli1NGUy+hGHp0rr1tukiYwEaHQnHpJ9Rm+C/GekdjM+b9Lyk8kCUGCy6D7hwUP92mQSujGbRYE4P1PD/TLfuMBGHCnfFsEaWq4NOWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=Q1P2gAsy; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-458b49c98a7so11979235e9.1
        for <linux-kernel@vger.kernel.org>; Sun, 03 Aug 2025 12:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1754247933; x=1754852733; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ue6yILCiUSW0isjVw7pYnke0QhJ7+S+qitF1Pphk5Z4=;
        b=Q1P2gAsy7L8Z5AZ36R7leLaTYaOfvPuLe0IxqKBoCRfPpeDv47zTqHcFLFwEPG/B2Y
         J5FElgUY42ClHZ4bCZcCUfqg1je0JvT65ZuVUSFMO8Du+qdRTFlfubTGO+wLbVh3EYuh
         7TjoavOWf0NBe6DOsyGh6ATmD2AOgSMi/F94EZEvjbxV/WbjaAqy+nC65AZ/Q0YSOUgj
         6x0A8Qs6ErpDFH48ec6MwLprh1P1AVICMzIo71ccsp8qRJWySNEc4Wf+XSB9rrI6cAhQ
         S7/a6gx77YjW6sAXUsmFfWli83NsQbHIcHtxvo7MouOU9UikVE80q2eprAlN93tuLsTx
         mhPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754247933; x=1754852733;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ue6yILCiUSW0isjVw7pYnke0QhJ7+S+qitF1Pphk5Z4=;
        b=UtIJfw+99rEFGqSLHcL8RzTMj6/qBRgyKNwq/OQUK4p+Sj4JRJ8sLX6awU83rVSk3K
         9MDpvyfnCBOizVl/ntcTqt5DJPWcQiMPqEA6B9MFw+uSOVaf/rJl8CHeX88Eo/xH7t4F
         8L8fYomZ22jW7IO3eqVx/UyBpQHXdW+oZuJuHLD+x9zMdiobBEPv6RFlzr1aaAJ4V5Pw
         Ql42fH36KFCSvGGAMmLKQQJvhedj1LrCrs/S+5Xlv27sTiGNpbQOeLdl3firoreK+TzF
         0zdxJs/WTnuN4YSjp+jjr1ZqIu59QBeHVxiipjMWmpBMmFG2T/9ASes4qiEK0CexB73m
         YGDA==
X-Forwarded-Encrypted: i=1; AJvYcCV6gAh2eySFmDZOR21ZNV7cFsZ4r5quxWSVVucDaf3BQXLDd4PaTWl8bUB63qrbTTQkwuYcnGbckGiAc34=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/w+nhPht8uCYqgFqJzvJwwMh3l8GJxytGS1r9wD3pE6MAudTo
	QsNKOszmsclioSumoF1jp0FLxuJhXhfeurpxyL3xZDE7iIiFkmKVmQNzQlW5hKcXgwI=
X-Gm-Gg: ASbGnctenljc2MB/GCUOZcVo5tFQiVtwlcYpJCnP5VJpD1IMeZWlNv8cdVCz+tMCfaQ
	v3K7ml5FPVhTj2kiqqlEq97VTpEJC9Lv6zgYiXDMGE+7KGLKgX53kQEKDsEzRnlZUtGLJjOuafe
	7UZ2XSH//UO+tf/QDdGzkwTZMukaV3McDdOiGENa2HJKOD1jO+xSSZPdcP6+HvAX2jeCPQOVSyS
	/TumI63TnSHyRWJDGKMnp5G84mqgTrph77DOjHMVPJaT6UHFD5U+yOhef+PKJOulqHhGFtUA9oa
	Bv6RQPnnWH2JJ4DuBkKgptSrRnG/M1SfOsh7Ll1OXVfMTkQaNHp6Fvim7penmeiIIZ+pJTyCwT5
	wQ6c9NeElow2PDZ8hs1R1FwfE0XNb0MIv47l5bfWQgKwg4G45VAkL9fR4bkPeyVYlw0tUD/f8uH
	az6q8Csw==
X-Google-Smtp-Source: AGHT+IFIHB5mM0/8HsYQwqU57U0GSbxPiC90f1GhhyqIwsvDX5hPAvaS1dkEc5zopKvLYYmIQx2Jkg==
X-Received: by 2002:a05:600c:a43:b0:456:173c:8a53 with SMTP id 5b1f17b1804b1-458b69c8300mr56997445e9.2.1754247932932;
        Sun, 03 Aug 2025 12:05:32 -0700 (PDT)
Received: from brgl-pocket.. (2a02-8440-f501-a968-a175-e139-72e5-a366.rev.sfr.net. [2a02:8440:f501:a968:a175:e139:72e5:a366])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c4534b3sm12948486f8f.47.2025.08.03.12.05.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Aug 2025 12:05:32 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Robert Jarzmik <robert.jarzmik@free.fr>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Duje=20Mihanovi=C4=87?= <duje@dujemihanovic.xyz>
Subject: Re: [PATCH] Revert "gpio: pxa: Make irq_chip immutable"
Date: Sun,  3 Aug 2025 21:05:25 +0200
Message-ID: <175424788064.7115.2655491563046401147.b4-ty@linaro.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250801071858.7554-1-brgl@bgdev.pl>
References: <20250801071858.7554-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Fri, 01 Aug 2025 09:18:58 +0200, Bartosz Golaszewski wrote:
> This reverts commit 20117cf426b6 ("gpio: pxa: Make irq_chip immutableas")
> as it caused a regression on samsung coreprimevelte and we've not been
> able to fix it so far.
> 
> 

Applied, thanks!

[1/1] Revert "gpio: pxa: Make irq_chip immutable"
      https://git.kernel.org/brgl/linux/c/b644c640923b625340c603cdb8d8f456406eb4de

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

