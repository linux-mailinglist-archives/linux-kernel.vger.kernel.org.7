Return-Path: <linux-kernel+bounces-800872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF2CDB43D2F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 15:28:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC7635A5736
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 13:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78BB2303CA1;
	Thu,  4 Sep 2025 13:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Tu/JYreT"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C8A30276F
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 13:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756992513; cv=none; b=ATswI6vYsMBj5FxdVLyYvCaE9npzHO8tyOy4xUlueLyckjFceRc849o4/a3Fdy+cN9hZHhA0VII6aMZH8ke0YwL9ycfHJtY7dN2sGMc3cGfnUNZa2n2a+N83nTUQ7FFw6IKsHPppUlVjSBEyd+/S3pZ8WPAxOmylcPHb1ote6Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756992513; c=relaxed/simple;
	bh=OAEQLvtjaMRkPtNdtAXuxJW6dE4Z71tMVOvtkQiratk=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=LKe97piZv9anD2VjrbHto3DRdUMtKwKwZvHfHQL9dzGgoCYMQ0uKPK+J9TKP/viQZJ2CH9a9zbo+ggffwESlihLWraGDSfR20KsdI3ec4ZUPtXsnpXfrCG7bZfOLgh2UXB+op+e2xBSz4NlryQFSNA2ODZB2poZyhCe5EHp6tco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Tu/JYreT; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-45b87bc67a4so7704235e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 06:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756992510; x=1757597310; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vVjNlWUjUJbko6NCXNm3bP5sMvagvoIs0Rsycf+Tcfk=;
        b=Tu/JYreTREsRekuMgnSvGAcbFbY1rd4v8D0w1eJl9tHZar/olBCKzvFUXsnZKpx0Re
         LslsrxgrpES5POdpWpBGOcZ1pCZiKgPexCfdYAZMqEmgbCLW+GKRgD96csPw4h95UrMp
         4zwbSrXu/zatr90IM4iPwFCA9b7h2MfLxARd70ZK5U+neyKqGNaKac8AGNqc0mUyAaWN
         dtwTMnDwV6JlBXIeRh6T5F2qVQeRn+sHhsej1LJO00plQG/gP6Jr7khmDdLdkOmNo4NM
         +OSpyq0JS/WCWr+BJUMfDN6EVuqkN3DzVsigqaCyO+ciVhBLXXnztEsI9A/xolr+gnP+
         BCAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756992510; x=1757597310;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vVjNlWUjUJbko6NCXNm3bP5sMvagvoIs0Rsycf+Tcfk=;
        b=FN3vskcBaPY8Ny2HIJPBlIpttnJxCE6cyuOVn/66ToqZ0f1gihtOmsYa+LWctZUY8B
         KenavErjJJ08twdkIc4RWOxA8vURbkUHs2wUbG/qNNLKe1vmUjbcH62x0kLEIsjlB9yu
         7OMpu7Re+Idj2x5pXn4tYtJAdxK2Hon/TWB2msGOjQgArSjjnNsn5xIG18o0eU64kEjy
         g9j0Afk7KTJKqSU8F+VBPSt9OWT8R/q5P7mC5NEQ0qWHt9Rin2gr6ewsY49ot2vVcJ/M
         4/Vbh3gPiyFLoXaSuCJcvUuHSn/6rzJtXZTPwQoottU6leyFu7qhFXig5+h2RoS/pDIZ
         4IMw==
X-Forwarded-Encrypted: i=1; AJvYcCX5DGK8MqVbxx+G/M69Z+ZvNijBRXV/63k1DkBKQB+2ZJJlMmfPPbYJSF+/LNEILQsw8BGYL9utf7oNavk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9ZfHNVevBErzlaUZS/FbOx1O1ZRtkbqEWNj+VnoDYJ3zIjytZ
	hRtJavv5HNyZlUQohVNyRU8TUQtG0Kswvv9vC495G6dS0Y/syN4ga6FLVlTvBqHG2nk=
X-Gm-Gg: ASbGncuOrbHrEOQXls40SNnUi5WqabPzthiJR9z/d6utgjobca7gmPB1M8mQConpeoa
	jnqJOVId1/bMYpin4lUCnEqtcWezHj/N8rQxvEbD6MkdDOYgp+I6mnLR601pYlJXKHeTrPJ+Xga
	h+9VPmyxcU4wGX7XvLN/FJdnxjyw4dGKAw/DOLqIvgz9SZDGXS+PrKjNgqQbXEhETCXuQb2kU8W
	ft1kCga1qaLazjaX0R8WJD9vTHxjHJfNOHs9jhe5QdKd7Sj8h4438snVXQJPQMGER6K8gJWqPa6
	lpvChjicF8atYOG5TavvbCFxmbvdDIUxtFOWf2gRaYxCTdyIgACyVXWGK+jZlq7UMW80WruCBCw
	E868pP+gMX4izRYSEcFoVRmVo43jelJdE1/r2XUZk/8fknxh36YhTVQ==
X-Google-Smtp-Source: AGHT+IEEWnzxKzJRyT3eEFYsuorsgTXLKnfmT3YCKLi6VQxYP8ugD4yl1yHboe6tUZ8/uCLiCcnrlQ==
X-Received: by 2002:a05:600c:46c3:b0:458:c059:7db1 with SMTP id 5b1f17b1804b1-45b8557f254mr183701165e9.30.1756992510230;
        Thu, 04 Sep 2025 06:28:30 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b7e8879cesm286165305e9.12.2025.09.04.06.28.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 06:28:29 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Kevin Hilman <khilman@baylibre.com>, 
 Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, linux-arm-kernel@lists.infradead.org, 
 linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Anand Moon <linux.amoon@gmail.com>
In-Reply-To: <20250825065240.22577-1-linux.amoon@gmail.com>
References: <20250825065240.22577-1-linux.amoon@gmail.com>
Subject: Re: [PATCH v2 00/11] Add cache information to Amlogic SoC
Message-Id: <175699250964.3374853.16885676491827667777.b4-ty@linaro.org>
Date: Thu, 04 Sep 2025 15:28:29 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

Hi,

On Mon, 25 Aug 2025 12:21:40 +0530, Anand Moon wrote:
> Most publicly available Amlogic datasheets mention that the CPU employs
> a architecture, quad-core ARM Cortex-A53 and ARM Cortex A55 and
> Cortex-A73 and Cortex-A53 cluster, sharing a unified L2 cache to enhance
> overall system performance.
> 
> However, these documents typically omit details regarding the sizes of the
> L1 data cache, L1 instruction cache, and L2 cache.
> 
> [...]

Thanks, Applied to https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git (v6.18/arm64-dt)

[01/11] arm64: dts: amlogic: Add cache information to the Amlogic GXBB and GXL SoC
        https://git.kernel.org/amlogic/c/d7fc05da8ba28d22fb9bd79d9308f928fcb81c19
[02/11] arm64: dts: amlogic: Add cache information to the Amlogic SM1 SoC
        https://git.kernel.org/amlogic/c/fd7b48b1f91e1830e22e73744e7525af24d8ae25
[03/11] arm64: dts: amlogic: Add cache information to the Amlogic G12A SoCS
        https://git.kernel.org/amlogic/c/a4428e52babdb682f47f99b0b816e227e51a3835
[04/11] arm64: dts: amlogic: Add cache information to the Amlogic AXG SoCS
        https://git.kernel.org/amlogic/c/3b6ad2a433672f4ed9e1c90e4ae6b94683d1f1a2
[05/11] arm64: dts: amlogic: Add cache information to the Amlogic GXM SoCS
        https://git.kernel.org/amlogic/c/fe2c12bc0a8f9e5db87bfbf231658eadef4cdd47
[06/11] arm64: dts: amlogic: Add cache information to the Amlogic A1 SoC
        https://git.kernel.org/amlogic/c/2d97773212f8516b2fe3177077b1ecf7b67a4e09
[07/11] arm64: dts: amlogic: Add cache information to the Amlogic A4 SoC
        https://git.kernel.org/amlogic/c/57273dc063d5a80e8cebc20878369099992be01a
[08/11] arm64: dts: amlogic: Add cache information to the Amlogic C3 SoC
        https://git.kernel.org/amlogic/c/6d4ab38a0a21c82076105e4cc37087ef92253c7b
[09/11] arm64: dts: amlogic: Add cache information to the Amlogic S7 SoC
        https://git.kernel.org/amlogic/c/494c362fa1633bba127045ace8f0eea0b277af28
[10/11] arm64: dts: amlogic: Add cache information to the Amlogic S922X SoC
        https://git.kernel.org/amlogic/c/e7f85e6c155aed3e10e698dd05bd04b2d52edb59
[11/11] arm64: dts: amlogic: Add cache information to the Amlogic T7 SoC
        https://git.kernel.org/amlogic/c/e97fdb9b8a0f8bd349de48815694f8a7200e3d62

These changes has been applied on the intermediate git tree [1].

The v6.18/arm64-dt branch will then be sent via a formal Pull Request to the Linux SoC maintainers
for inclusion in their intermediate git branches in order to be sent to Linus during
the next merge window, or sooner if it's a set of fixes.

In the cases of fixes, those will be merged in the current release candidate
kernel and as soon they appear on the Linux master branch they will be
backported to the previous Stable and Long-Stable kernels [2].

The intermediate git branches are merged daily in the linux-next tree [3],
people are encouraged testing these pre-release kernels and report issues on the
relevant mailing-lists.

If problems are discovered on those changes, please submit a signed-off-by revert
patch followed by a corrective changeset.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git
[2] https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
[3] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git

-- 
Neil


