Return-Path: <linux-kernel+bounces-719465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3F21AFAE42
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 10:09:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B74F42330B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 08:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8334728B3F8;
	Mon,  7 Jul 2025 08:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="r2YA0I7N"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B24628B7D3
	for <linux-kernel@vger.kernel.org>; Mon,  7 Jul 2025 08:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751875743; cv=none; b=RRIDvougxGVottPtxY6+DEfhdTfPu2+9Q8HE4m39NHH7vtN1claqFoW+6JUdeJtXjktgwWIzEW65x2MNXYgh+6LRPndRW3SiNpOMvQeLbTRD1vOFYwMt1UxlLbWXOleEWDH1A1IpXecWR3Fkz4MfyBMuuG9LGgHo3lq5BgkmMJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751875743; c=relaxed/simple;
	bh=WSm47YcCchWeKGlgq2UddpuspkqMTR+iSyXd6RnhhpY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FhCGt4f2pIcVpy1c+i/lbXmu4jLG7NtN3mtJfl7gf52AU64onOvB1ekSihF3SQWLIQiN/1koiA5urtcnPe218Sk0rViExO1DwyalplzEv1AzFn2BWq941PmbZ9VlvbvtER7BWMNaniY0PYWSm4cDcuxdF6hW/GFQCQV+ynhglt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=r2YA0I7N; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-451d3f72391so28270575e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jul 2025 01:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1751875740; x=1752480540; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eFAboXfiLA0FVMTr+TL/V0gKAaepQ8a/OFLOFGrBygs=;
        b=r2YA0I7NdTczfX2llfm3IZXFP35fBThIZH5xpU8/driwxhJSdoDa4CZpGd2qL5S7ol
         z8uTLCUCP+PAB8iZPDbZCakbge8flnJRJX68ZPIF0VaxcLcmiurgil1Q83PSFvN3ixjM
         xr/wR0ytIDS6+yHtVKnxZPEFQ0TKnyMEv6ipyvE47WTwuD4WShp9w0hY0RoeNsFn5+fe
         7Sz0E2wEqEES8cHDVxyIbEGvFMNbVZyMHev64oCzM7eSvWtFOX4+5uGTELaJ30Kl30ec
         n96zBQSjMxzrNN2B2O59Rqm5+IUu1MRu+cCkaq7w8SG1saNjw+SrUe+4rJBB1M0BqZtM
         oa4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751875740; x=1752480540;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eFAboXfiLA0FVMTr+TL/V0gKAaepQ8a/OFLOFGrBygs=;
        b=xOcR4Ac95YU0EGnIXbx+SqIiv/4RWK8u4IGDHcxT72lldjZ8hJ+H7PQv/HnP0ZXEqL
         EB9IOKDqQMIgx7ZBeBebRxAyfLJq+spslQ6abzelYrFE0SJrENe3phxgZ96/ZciVTIcF
         S1487zRmmZSpycxLhQPgbfgCQSiKtyiUDXbraEEO6fdXp56K99SEQCiFsQ6iuf7bakkv
         PncextzIZvIhgrTFlkzAjnJFgQSmHAFDj5R8GuhvmCG8ETIU0HQqebc1ZaszrUHoA4hA
         jUIobulSD0vxGeFHaOBu41NmdkWiwWp/0R3utDp60P+yS7+G2CAoVGETl0cNSgemHvUb
         wYMQ==
X-Forwarded-Encrypted: i=1; AJvYcCXex9wx651+o54C400amjaDmjMnasBa0AHtfaM03p0DP4MU7a/3gYtefQAonp6S9WVjVE3X1h6MnKnjfZA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxZHJ0ZimQo+G0opzGw4qzU7lhQ3pL9cuKWJoZjTeeXkX+xFtF
	kJ6nocHuw0Sdorn7PZjOJgYEqDc6hUwwd9UzQ+SHBKvXlXgqHJXohoVjGynne+4rXZ0=
X-Gm-Gg: ASbGncvUVyE8die+Lqgre5gFSXeMqrbVa3lXBfWaGLXHeO5Be15YYlIzdzt3eLWQAtH
	e4zVxgZ4cbU6Q4QH0iZVyyaoNOB4AgSlgpR4V+6hKbYbEHWYNbdPBDsNJ5ak1hKLe9JYlYptpTf
	z1grz66P0HxRQilBlmahiqPbuLmdu7Paqun1kOs9PH2QWb4zsUGKOl0yci4UoEgoI5l+vDezreh
	kQ1CTDZ02yZ6VZkuTlgQDKZfknO5krO1D6GF/YOg1rlczLdM8vpSEV58va2qrLSZhGVthtDZy7j
	YV3qOTK4hQnTcIAvaZkjue2J8LIYcpysB2zg+g3BxIthL/NdFREZyBoGT1AknGs=
X-Google-Smtp-Source: AGHT+IEKfIkjGLcMB9V/pRGCJ2/g6v2IgOD5q1MoSjKN3jTgw9ek/0VEXkiz2KUdVlkaJ0frvKGjEQ==
X-Received: by 2002:a05:600c:4ed1:b0:43c:ea36:9840 with SMTP id 5b1f17b1804b1-454b30d915bmr86571355e9.22.1751875740556;
        Mon, 07 Jul 2025 01:09:00 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:3cf3:a61f:85ed:69db])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454b161fb78sm104386275e9.1.2025.07.07.01.08.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 01:09:00 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Maria Garcia <mariagarcia7293@gmail.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Maria Garcia <mgarcia@qblox.com>
Subject: Re: [PATCH v4 0/2] *** Add support for TI TCA6418 GPIO chip ***
Date: Mon,  7 Jul 2025 10:08:58 +0200
Message-ID: <175187573641.15653.14317168480317813793.b4-ty@linaro.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250703205740.45385-1-mariagarcia7293@gmail.com>
References: <20250703205740.45385-1-mariagarcia7293@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Thu, 03 Jul 2025 22:57:38 +0200, Maria Garcia wrote:
> This series introduces support for the Texas Instruments TCA6418
> GPIO expander chip, added to the gpio-pca953x driver. It also includes the
> necessary device tree binding definition.
> 
> 

Applied, thanks!

[1/2] dt-bindings: gpio: pca95xx: add TI TCA6418
      https://git.kernel.org/brgl/linux/c/c488da2228bdcbacbbe1f898225d28f58b84fcb4
[2/2] gpio: pca953x: Add support for TI TCA6418
      https://git.kernel.org/brgl/linux/c/cc85b9f83304e9d68af4b5f3b6efed026e615642

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

