Return-Path: <linux-kernel+bounces-877898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C8D8FC1F4A6
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 10:29:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 241644EA513
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 09:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08C96340DB9;
	Thu, 30 Oct 2025 09:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="WjwJRUkn"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A59193385AC
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 09:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761816529; cv=none; b=bkQ57EWBRwS857aNGBw/zua4GkPO1J3eUmWRRIZw64VUzZU1nB6Cg7zGy+D4EV2Ty1MR7lZ001L2Vk1uroQ08GN4CT3kZobJxHpxcuXlzdaeJ2VDuzyiRDqif04TEfbyxuv7IRaY4iQxsBwdFyyPhxYumhVRIXnRqEsnuvn9bj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761816529; c=relaxed/simple;
	bh=xkvI7JJjRLswA77nMH3pbHH6X0Zj/X1+CJZLyF9Itqw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=URj13Xq7Ff2eju1yPauS2KuVUKuisEeC9rZn7UauOYZ7TxIcEx/lEcAff7ikVMfy14De4ifOfA7uermv1gthdsru3//dcH9tQAXM2goGTDyhhZ8cHH4KwWqkIsdH6/riRzic83ln5E+cOyj9Fwf8xbf9HmuPUFNEf04gaAblwL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=WjwJRUkn; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-426fc536b5dso509781f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 02:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1761816526; x=1762421326; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jSDNxghdg8zkqAoa5p4bXl7N7lGv4samb2Pk9SkOcB4=;
        b=WjwJRUknVk2EXFM6lQD/IpJO+dPKqhUDOvtpruTH9Fn6okI4/+p0p2v19jbpsedJ3Y
         rZT0Fu4471daVWjLym6yYfgYQLSQwCnYswWpWkemRNTzhVjCyPhibzNkmy7wn4HiwkUC
         p5X0h8H1Iq7yR8Vb8ThZ/W1L0af9MMWnr/ilgMnLRFJDgSGDvxXMcflCGMnmkRT0xMpS
         nr1bnwtm5TQg3jhVOaS9PE1/3rIiyLMP9ctByds4LQACtAxOA1TvIvQIbQkfv3b+aAgo
         QHYtWYJNhEW5ZBayfzc1xIl2PTY/CUpXJcULzXlEUn8rGfFVQTsvB4ew4fbbgSHV0GHF
         N+1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761816526; x=1762421326;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jSDNxghdg8zkqAoa5p4bXl7N7lGv4samb2Pk9SkOcB4=;
        b=wz+fkzizvaLU+kQR3FzjEDfQshBdF7XmcaXomuPVDOOWhHmkEKVhoqwLVb4WM9t8Fc
         QQKS6hOqWq8qZDSzZOWiv/iobdFT35uTkAwwpQ1lmQmRPPftr3rqwOHN8szgt2PmdP18
         T067G7R2+X53SWcxp8i1I0gb+COVw5X2cWkTMEQ59Eqn2kfG8X107kRhrShWNFNEUqRK
         IX+nLomrLqr1urRxrXgaWIuNmcNysql1MCzu3mesPS7Ok26Q/5yGZQtuqyoIczX6wkmj
         bsUIXgQyKGU5/VolhvjQ5QzdA465ZVtm1LMg5uJMA2SreqAonOy+HhyiQ7/famAgqwUh
         D7CQ==
X-Forwarded-Encrypted: i=1; AJvYcCUV/gRROthPAVXmiB9GRr0rnCqUbUNqIc6jLr0OlXcXJzKSO18147u0pbjKTk8iEbqGSth13WBckJZAez0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCJ19MdfboCX0JhcNPYiw09M8sfJSVu1KOkK7NI325cwYgmwCf
	/Mnn/NfdUuRl957LULYQ+mN6OV7EgjExYQ0WhFQV7ORzD0iTGZPH8I+4A1pPwEjM68jQ5rAuKgF
	ZXpMjuTs=
X-Gm-Gg: ASbGncuNzuTerB94f0vVQagdhtTDqpalS+wcWxRn7VOzog1/qGkCGV2ElEJb5qvp5gJ
	Qq4lyPj4yM1whEzpoPCzMqbca0+yk4z8KoS5LkbQRm8YXhrgcyvzPKu81sBri1rUWEglhZGds/s
	iF4iIrej6NY9TFNhksWPG+iWPj1EZjCNFiUL5SecNtW2aWo3fy4M6KTbDfMP0arZxgbPQr0Rgy7
	Gp5Nmn0tN5JXL5a8sLtKGF0UHMnFFtzo1/5UuS5Hs/xTK4i0hS7qa2naRRa3gvsOKUJe4AAtIqj
	pU0mkcAV/wbXHOnYhwhQlb7X/aq2BfRIlDh504uvdbMScvFwk67pS6lTJnEmbXnLGvblewPf9V9
	irXKbcBXQS76NQm4zFBpFD4WofK/mlX31h520bsXGZjURQR5VLboid3PpTBpshOXKUvmQvQ==
X-Google-Smtp-Source: AGHT+IGLIFbBL40DZw4XiGHjdXG6bk7FaQ4ETbbN0uGd8OVFlfoXKEJV2/ulV3+2xAoMbAIYp4+DqQ==
X-Received: by 2002:a05:6000:230a:b0:427:719f:de70 with SMTP id ffacd0b85a97d-429aef81bc8mr5220107f8f.14.1761816526020;
        Thu, 30 Oct 2025 02:28:46 -0700 (PDT)
Received: from brgl-uxlite ([2a01:cb1d:dc:7e00:4de0:1456:94e9:3a3b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952d4494sm31524134f8f.21.2025.10.30.02.28.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 02:28:45 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] gpio: mm-lantiq: update kernel docs
Date: Thu, 30 Oct 2025 10:28:38 +0100
Message-ID: <176181651570.78037.2946846263283889588.b4-ty@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251029091138.7995-1-brgl@bgdev.pl>
References: <20251029091138.7995-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Wed, 29 Oct 2025 10:11:38 +0100, Bartosz Golaszewski wrote:
> Update kernel docs which are now outdated following the conversion to
> using the modern GPIO provider API.
> 
> 

Applied, thanks!

[1/1] gpio: mm-lantiq: update kernel docs
      https://git.kernel.org/brgl/linux/c/bac88be0d2a83daf761129828e7ae3c79cc260c2

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

