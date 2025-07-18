Return-Path: <linux-kernel+bounces-736459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34FC3B09D1F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 09:58:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 904C41700A8
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 07:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CC06292B53;
	Fri, 18 Jul 2025 07:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="gi4GnIon"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B55292B49
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 07:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752825387; cv=none; b=TPXkJgS9uXhAQPZMP9smTiw9NuKvz0UTaFhuhWt4bhkAd0grqEv8JUHJyxH0qVg4yHcmlH/1AVIvqfXtYdvQjp+MATnXSDMItzeXZPfgItBUC7aJ2n6C+L5saJ/Xpm2cubI4EvSI/yYu7q5/+TtNPvGDn7BPIi5QzylWSWuzJzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752825387; c=relaxed/simple;
	bh=lpm2+edJa87Cx9epc57JEOOqNv1u0nwKEPrxDjWFGM4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iHvDrqVNIuR1q+kyF/hika8tjJ31GxmyPHeQ/Va6nL5y5FOiqxvhnRT7rUgv/5FZwI7MQWlI5ula/d0YDIxdnPr6epgrJxUoLj6kQjj+Gpim5GAvfMUDSdr02llQZlqgEC+KvQ4zuGfiLxqQu8A/SleoeTjriEMPRkhRGIi/RCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=gi4GnIon; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3a528243636so1113640f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 00:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1752825384; x=1753430184; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0c8fdFMr+UpHuCUTudUkRscMjxr1TXKDDE9fIOozpk0=;
        b=gi4GnIon/kSSt7Fr3XqPhEGqEv2lPFCioUK/D8CosdcEYAnXbmRNqeI9uEK+Mu4qoV
         5+/5KrIi/A4dCFxVf5XC+QnnJTh2suLl9t76JKQLzNcVFjFrOLCyFwK90nmTeOwpjaS8
         JJ1U7qfGc+/+wsNwlL0WLZ4MlyMwId0UeKG2qTZlDNeEZ3EfPXzTMziTzLX8aUzfHm1f
         dSyZImwyEoW5lfp8AMcgrhXU6KKrEnOhanLSg2Lvw3sSqF8oCBcFuHhzjxxMJUeoYoMZ
         Ck6KnMkmEbkSku70Z5B96SNZilXrY3ZdkMfJz++j6cq43+goS0Ryb9snB2ADCqWxA4M7
         o/+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752825384; x=1753430184;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0c8fdFMr+UpHuCUTudUkRscMjxr1TXKDDE9fIOozpk0=;
        b=sdt5FClpXXh9FZmG/4BvK9joxi1RvwXAZ5nWDm/df5o79GDWVraWOWlEuAilFmJsYB
         Nypp9FKNt4FfI80Uwdad5XoNlL1Yhm1b3gxCZgceMPzASxnyJIjsG6y/YjKFHPkI+Tpz
         TCsmxLvrx6JQ8xi+c4rQkeK0gJ7+5Tw8MgUo+bzltt32fl7UfwG7Ul97nDCvhSy/+Q8o
         P/c6SNPyP5uzCd2rDK1MIsz9CXs67utCxB0l9O/HUX7uNmCf5aWYs5BaJXHjB+LnDpIm
         kw8m++Tv3w/Rdu5qosq0Y86ThsREbeo0St/GqrhDiaLCkDseNKpOA2h0s21kpP5gDM6E
         NdCA==
X-Forwarded-Encrypted: i=1; AJvYcCUG4F4r1KtE3w2lnS/V+qcGDa21nCyxxu4Fqb2OmU4V6HYBCbOQJBPwn2qbdCDtz39HtxBwT0fBNk1E8Eg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3qxI7HPtJcqHlu5Qvt4iKoRghFD4zyv4DIiNjNFJkuGEiHtDH
	UC2E5v7a395TRB0+l/nggeoM55izolj9vROVfnMmcxV3rFpXz09tHkak0BsYSMH8IBw=
X-Gm-Gg: ASbGncvtsDX5xGncwo0R6NzheeHVk2mBLwanhMuR7XQUlHEO8xPBxKMNW+DQTTykJSx
	0o+y1/Fb6S0myYpE7wfV5Y/zOfS+6DuL6hJXNlO/Rt859gLu4adj6P3DBIa2TZMGN4cfMnVc6FL
	+lUgXFhkH1gxS7APuTfCaQiMlGcTTGpaDGdzRpu2FwxM9MqReWWnD6aI+sY9pdpmP8dqWiJ5FwX
	FshpNcmM4k5jcWB2RnYbsdbH2kt1XXuKBfKc6sgmY7TBm42tWXJnvFgsfQaMFHI/AY8Y3LRC7ed
	b5KgjVOoqo+V7cL0lMcy5z3fw9M5QMqVlcqoCaGeoUrp/wjgPySAlDvlLjMMXWJrenWtwWhZxpf
	aO/YuJy9R0bKRR6ouMqoH
X-Google-Smtp-Source: AGHT+IEEuT+p5IKgXfqrVBFf6P2douSPhQsT/o2MEkjNdOPlGK3LK33AdLMJCbwxmACcgn2BBprRQA==
X-Received: by 2002:a05:6000:2705:b0:3a5:1cc5:4a17 with SMTP id ffacd0b85a97d-3b61b22299bmr981616f8f.42.1752825384413;
        Fri, 18 Jul 2025 00:56:24 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:be63:a233:df8:a223])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca48a23sm1080851f8f.54.2025.07.18.00.56.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jul 2025 00:56:23 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	John Crispin <john@phrozen.org>,
	"Rob Herring (Arm)" <robh@kernel.org>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: gpio: Convert lantiq,gpio-mm-lantiq to DT schema
Date: Fri, 18 Jul 2025 09:55:54 +0200
Message-ID: <175282531513.45055.16088789806778358341.b4-ty@linaro.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250714202837.3011521-1-robh@kernel.org>
References: <20250714202837.3011521-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Mon, 14 Jul 2025 15:28:35 -0500, Rob Herring (Arm) wrote:
> Convert the Lantiq SoC External Bus memory mapped GPIO binding to DT
> schema format. It's a straight forward conversion.
> 
> 

Applied, thanks!

[1/1] dt-bindings: gpio: Convert lantiq,gpio-mm-lantiq to DT schema
      https://git.kernel.org/brgl/linux/c/71b660010bde67a0e0ffdee67d30e62672e6d393

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

