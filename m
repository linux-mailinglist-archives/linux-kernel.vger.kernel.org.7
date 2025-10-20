Return-Path: <linux-kernel+bounces-860244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D29CBEFA8B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 09:24:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4BA91895A0B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 07:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C0A42D97A4;
	Mon, 20 Oct 2025 07:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="0Ypqhkgf"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2589F2C08D5
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 07:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760945046; cv=none; b=lYTQc9RCcDnYqEb9GD0X1J5/n1OEF5Zez4ZLWBOPqeC0fvgMC7apt7amc3gLOdkUUPKmLouoT0+kJoX0jZIngCWBG1qKyLr2/aRp2TKLIkKMyicVE1OjK+ICOWpxb9DOA4onm9h2PQrOt0pFY0Go/YNYD9KPXe/wzT2L/zNUkJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760945046; c=relaxed/simple;
	bh=LfI2d9xHsW2tVkkiUTrpMSXy8Fqflp7nkvdNzVka+zA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=thlbxn8LRc3fiHtchkRAmG13i2CCLgcXbzDSIWQurkFJ81lERF+FysXMvcTpknwqP43RCFl3tHABJUZ2n4zhXI1zUjJw9SlV3pnNvQSr6P6Do9BvmabTH95M39BPaHD1pna0gfi/0tzBKG2pq25juQpHoYSUCPMxkbDnOzPTChY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=0Ypqhkgf; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-47121d6da31so1208345e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 00:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1760945043; x=1761549843; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zNBkAkxjAwi7kSHSCpdGrBq3Sz+mlKhpy0dVM/BjiBI=;
        b=0YpqhkgfOLyVrClirJS+Zb4gztiIn/xAaHr/5BKRCqXeWZVOlwMrEzWnDdXf8dUMZZ
         vCk9awRuqDONddZrw/M0Aen/HXr26L+KErJq3WuIplgMBx8Qa5Di5SM/I87lYd6CiYnC
         xsvnsLQzqepPUoT+JRnKm6ffSs4ESH8Wpxrk3o5gay4csQwNMxvMA5FKxhbUIMdj2MW1
         xY0GpRV5Szhrbc5hy0uTMRl+xDZzMuphZRxr7Cla6U+KUnaitByngbGKOceZkdTb7hq2
         RGuFhKfPivXhd2/RpUGfxRQCoK7STdex/p/eDHJM+roD4Cf+03U1dX2Vv028GvT2WYD+
         YQrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760945043; x=1761549843;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zNBkAkxjAwi7kSHSCpdGrBq3Sz+mlKhpy0dVM/BjiBI=;
        b=AEC/iyTMUW+qRVMPg8F3GXg44N/iAEyBNQtsY+eBmQjWO1TvsyEnq2LKXODXyciyIL
         i9g1BSEpBG8UFK8TJvciPEfEYsmGgbi5BKa8uce+gi1nRYBPGDgkfGtpEF/9eigM5yA9
         q1wgFFl78v8tMQ56wzIg7oc1DmVRGfW0n98VD1OX2tQnHtMQAoY8MwqYLtULwxWGGqGc
         ypNVjwiyPy+QJbICTbwYpQTdakYmw/fVpmbwx95NjWQVWBlFUVNTjBCQERVksnu3pJr4
         zmcv8o/Ihj8W18U8/askb572KdJS5Zop+5hWGBzsCGqpWBxWbvLMy/jqk7bydSWCCEPV
         zKGA==
X-Forwarded-Encrypted: i=1; AJvYcCVQyy5vXP0v5PLmsz/yjIXdAl/PHmI6Ko0HhZdhLdU5zI11+fxI2nCoDKVuZfFYezyyjJZI0Aatc2ky7t0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwNrlbC/X//AhXWQxbfiYcRIP8WNYFUU4nXUh7t+PiH+6avn+I
	hhKExy5C25nPcna00ShWyQgvQo7zLHozOnv+RYjiDhhNgF4J3K9GaSNBAXvsWLefq3E=
X-Gm-Gg: ASbGnct1IMHUFYpcM3GQMz0Ij6hE+i/58IAQUm9frLz/U9Qwi81gwt1aqXJnVXbiEHS
	vM75iTSuLdx3u/gHVJK0TUa+WPliXKyjL7gxUjfOhI+yY/AZmm/DbbJesKpLkxtz3Vq4PSLf3Py
	1yodzGnsT5oiDWBJzwB9JIybc7hhSvhvGr2nkDYGCzCQOaYhEMxGG0T7nq9M9weMB8YeteQIShq
	NqeRtqp2BR6yzN0zlLDbOh0jrM4f59T2E1iouQ31fkQkquybLu2vG9vWD/pwTgIHi3FbOHDxd/I
	KoWJ8CGZ/mQt7MON93MmM16yHpYtjuwt5Nzx/AvWfokakVQc0Qf1+RE5/05doxaPUS/Hfa9N43J
	ArZjuL3+smxlz4nkRN9Rsbf3hndtNjkjuzGQXp0/BZlaGX4pG+5uUhnGGH9hP2EyqtE3Y4rFlUc
	9kxOKgEZjb6qA=
X-Google-Smtp-Source: AGHT+IHXm5UtRkQRdhNnkMLXDT1OdBNCuioYx0cdaBRDBVm2QIZL2jEWwG0baXlFDuMg7LuRe2kDdQ==
X-Received: by 2002:a05:600c:524f:b0:46e:326e:4501 with SMTP id 5b1f17b1804b1-471178a785bmr84128255e9.10.1760945043239;
        Mon, 20 Oct 2025 00:24:03 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:5b13:a549:df98:9c00])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427f009a7dasm15028660f8f.25.2025.10.20.00.24.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 00:24:02 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: linus.walleij@linaro.org,
	Michael Roth <mail@mroth.net>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	brgl@bgdev.pl,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gpio: pca953x: clarify log messages about auto increment feature
Date: Mon, 20 Oct 2025 09:24:01 +0200
Message-ID: <176094503872.21784.10106172878163279314.b4-ty@linaro.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251018101404.3630905-1-mail@mroth.net>
References: <20251018101404.3630905-1-mail@mroth.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Sat, 18 Oct 2025 12:14:04 +0200, Michael Roth wrote:
> The probe messages currently print "using AI" and "using no AI",
> which can be confusing to users unfamiliar with the datasheet term.
> 
> Clarify these by spelling out "auto increment", which is the meaning
> of the AI bit described in the register map.
> 
> No functional change, only clearer log wording and matching comment
> update.
> 
> [...]

Applied, thanks!

[1/1] gpio: pca953x: clarify log messages about auto increment feature
      https://git.kernel.org/brgl/linux/c/6f5976c0cc0977b1fd168d6ecbf3fb36cf041524

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

