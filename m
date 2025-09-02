Return-Path: <linux-kernel+bounces-795996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83783B3FA77
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 11:32:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEAB94E1F53
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 09:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 366652EB5B3;
	Tue,  2 Sep 2025 09:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wSkGuW7m"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E731D2EB5A3
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 09:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756805523; cv=none; b=NoC0MxZFFa23joxl81ysAUnzLdyBAjUr8ptKvcIywipqfttCZmiX6oh9I+wpyWhKrraAFOr9coR3wii5PHyQLEUr4X/dNiLEbr9dWpHWDGBvbg0pffdK5td6RNnRGto1i0flqMcYi5zCCRG/t2PDiLUHh9hxhf2oZfEvZkHl1YA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756805523; c=relaxed/simple;
	bh=aLV5q272r3B8QkMTmOza7YKUzvB4FtaoeC/BZBqbhAo=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=djvCcJw6VI5AhlY2dlRruiU/NQJ4aPIAVDJ2HDN7BVqdH1TzbvQHwT2BsT8tUEGg95pg+qk6LpGeP6M7m4BrC3YB4HpukRqsAwYpGQPsUMWRXJVHbgbbFSW/260rD5lFdkirNBTZaei7hURQRerrLO27eJkRI2CitZFnd4fmL4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wSkGuW7m; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-45b9bc2df29so241765e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 02:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756805520; x=1757410320; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Eh6pXHDb7czykJvkZSECzHtYEJIhB8sIOeQx2+V0+0Q=;
        b=wSkGuW7mkvn9WJC0H8ezXeIdlUW96o1eJVApqILsyLCx8Zj+z1lVkBvPza0EQrESze
         FyR5AnOBNa6xzP2plvpEWzYo1NhyxqQn7hXqrgnchbH149Hvs1WOI5dI+G62OwL/LIgS
         e8OZo/OSNgni0eNTQyCnikzCQT0sVHgxTWQaoMcOPU1pLhAC/VKZ4t43WFDOX4W3LW9x
         1puriBLsjH2M+I4nDeueAkbxupzevtVhrYUzmg9+upRFYHWCsPkQ9hqcAXadp3LPaOjK
         OCxKb//1QtixR+fd0hoA94/DMfQX7OZcSmpKegf2FfS5D8IZMVNpse78ZnuSAuVpcLWw
         okkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756805520; x=1757410320;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Eh6pXHDb7czykJvkZSECzHtYEJIhB8sIOeQx2+V0+0Q=;
        b=C+s9Exi842DpiDIw8QGk3STNKzaP9o76hz6tj32HmylAMT7q38xVbeCqVaZwUw3yK0
         nAZ0aGvGUD87O3YY5NtHrZivj4Bg8pfZ/0cmdxu0mhPGXbIMN897Tzbx/Xm/X0+GkY+g
         vREV9ondVHo5DkxHtkFWPOr+aGQiXrUZBlbI4dyCd6jpjTozqllY8Ir7B8BikjFSJaq/
         EfM3pbGupkNiJ3CQVBGpOstGozUT3UyJskFyJ1Sixqojk8Fr/ZDdz+rZF21hoLRaMiui
         zCRvlN9oMeHnFxky2+IHzIqVsvhsxqmc+alMjBP4tkQQ9f+zlRWdFc8byllawc8YjqWI
         6hJQ==
X-Forwarded-Encrypted: i=1; AJvYcCXfUqePZPN9ba5f3qE9Fim6n5JX5BzhosrUe4gAn2EUy/nwZDKFWMedfpdD8UWB163cNRW6n97AEFW1BHI=@vger.kernel.org
X-Gm-Message-State: AOJu0YycECHp61s8nsAXYuIWqK1RsddZzjqSqeeDGQIe9g67qJnkv4iw
	q4kdGe9BZEm4KwYhAq4zcHdBaY4sdh86xTebiISBb7hXlIRDdyMEJn6U6oZi8KaGb/Y=
X-Gm-Gg: ASbGncvcpziqz/U7/ExYvAgFK4ILXKR85zS+PDATHdyOrtVhx8c3iWIrwHdsVPXLPVz
	yzp59C3fc+epHc32VOKUsoYpH/q+sBR3ZU9fxJjAU8sms6PI69WOx/OPw0w3/EFYm3od7cIRH8Q
	Ygpc3b0tCkTPPh6TWTzHWBb84fYiIBidXTblF/YkT2yk2JkHPHySoYyM0fGRCkmNfqKmVjvuaJc
	2zq96P9IvAjBZxca6USr/uP1Ff5l3r3REEmgSednNekzkJzZ6HZIxKoJQeulyBFdXGRE8QFe9Zr
	5KE2nIUwwaNyC3Y2T11mHJ+UCADUhW8GZmwqP+uLZ5p+fw/zowaRtp2b5XYqiH0L4HNADUkA2qq
	Qy0ZN0qvsLPPMFIdCU4s24qOvUkLS3aW31xlIIU94NGH1az260w==
X-Google-Smtp-Source: AGHT+IE5jYdHUbUS3l29jFR/Jwe1LDiKUmJNFIigz6TfN/+SC34Z3RyjNu1csb1trH6mfuj+fpgVhg==
X-Received: by 2002:a05:600c:444f:b0:459:d7c4:9e14 with SMTP id 5b1f17b1804b1-45b800cecd5mr66503255e9.0.1756805520238;
        Tue, 02 Sep 2025 02:32:00 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b72c55c1bsm281314925e9.10.2025.09.02.02.31.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 02:31:59 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20250830113253.131974-2-krzysztof.kozlowski@linaro.org>
References: <20250830113253.131974-2-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] dt-bindings: arm: samsung: Drop S3C2416
Message-Id: <175680551873.122080.16462297851841792228.b4-ty@linaro.org>
Date: Tue, 02 Sep 2025 11:31:58 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Sat, 30 Aug 2025 13:32:54 +0200, Krzysztof Kozlowski wrote:
> Samsung S3C24xx family of SoCs was removed from the Linux kernel in the
> commit 61b7f8920b17 ("ARM: s3c: remove all s3c24xx support"), in January
> 2023.  There are no in-kernel users of remaining S3C24xx compatibles.
> 
> 

Applied, thanks!

[1/1] dt-bindings: arm: samsung: Drop S3C2416
      https://git.kernel.org/krzk/linux/c/1557c2eb023d9cdf97b4686fd206048c070d4e70

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


