Return-Path: <linux-kernel+bounces-804576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 54FF5B47A00
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 11:14:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BAC407A9B06
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 09:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95185221F34;
	Sun,  7 Sep 2025 09:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pMkEQiI8"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F1752206B8
	for <linux-kernel@vger.kernel.org>; Sun,  7 Sep 2025 09:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757236449; cv=none; b=XRWzE0R5PjIXGMd7YhetYelaXjwm9mkp73uo0YwmLN5JdkPCt/sUIB4Qhrgm+r5l9tJgLrPdhTCn6i29vVi84+hvd0NpglLIICGzISWcwta2kjIEGJMLRhvomMK8pqEbALKSyehnkChBxvpG2PHzVb1ja2bQqyR5eFVv9iTjFw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757236449; c=relaxed/simple;
	bh=bjjOrCQY7nCRwJYjDCDSciNQEkgygJ3UGgcY5H/xmAg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=NRMyNmdeRE19ULDQitTq2sG7BKm/Iw7iUyp29Txpf7SmMhzfcVFcynvnByxhwgxONLQrqUPRw9OjsvwckyuNHWwDVP+5+K808LZTK6d4ZvAqSIYXym49/OAfQq+hhimN2ztTUD4EMrUgv/CnKRR04zhOh0o+acMPXT6RcsSzHfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pMkEQiI8; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-45de5246dc4so198635e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 07 Sep 2025 02:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757236446; x=1757841246; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gsp0bK/nuIonUnBqY9AKagtiSrgSRD7fcSEn1YN+5DI=;
        b=pMkEQiI8+8OgDZi/+a9rJdkYDyX+icHpXyTQw4Bj1noiBGdnH51qHkOVu78nVCZ4cL
         rapQ6FaDJLlofPEF7yeCgzHCjTxE4Kjxuu6J6p5h1tga09tXm6ctE70HNyAjJE1XcudT
         5JDTewC7YuWD+uMsPkFqW71cIkCa7AIefNHpaQpcXI9/8Wh6gq69Z+zVtxvaGHq/qDxM
         ZpUslxECbRr0qcCl8Q1a3a8w8lxyLSexTVNAHrX/U7mhM5S9iXANp/76Xq1eHB7C+jNJ
         AtdyqFY8ruaX/D3xe1B9ft2KqH4WF82mUXBSpJHFYjXKfYJXcNOLOe77OpwNum0hGQcR
         Q6zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757236446; x=1757841246;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gsp0bK/nuIonUnBqY9AKagtiSrgSRD7fcSEn1YN+5DI=;
        b=sdi7OHsAXcsgCgKf0Cd3mhSqAlBn5xf8TtAK7UMP8LGjNzOIEAwv/b2wBkqZSVQfa0
         DVef6LIkmCKBm+bBbsh2xP0Hi2ZMcXxBJqTeDqWx1BM2nSUg4LpeCAeg9wGCYcHJ4Uw2
         fUwGIfOnRLYbygm7zSlZWOSnJR1+VyH71tNwI+vKgRbbQSlbfWGYnS4UtBui3iYBqS+d
         iV6WK2sy/ZSQ128y4H19UUG35ot60/Us6qrpFxa3qjF0kCSX3C8z+aQB9QmpLWbF5ZpB
         FDQ7Qd0N0cLVLk2OExPspiwqw3rnKbcLdbhHFjmzLPNVsb2Uzh76yX/ykxqcDtd3swtB
         spfg==
X-Forwarded-Encrypted: i=1; AJvYcCWXFHDnh99WB80l9XbvWE7zNnHub+1iJ7kJPtJGwF3Jhpk3L493tUuAe710HFQ/knRdNDGv4ldoPMmLRik=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyx6sNIQ7tR5OIxhicwnabp4lOJPbHPXhI9LDxpVx79sPYOjQVx
	kd2szjF/rjgV9ztlFSEkuw27eV/ctiixu6lPhHaRbr7NO3UaDndMpjrfEQ9FXetHaNs=
X-Gm-Gg: ASbGncvYaJ7ykO6p3wc7t/pJG4pD5EWp4I6xx96RF5trjmNQ5gn/dUrn3L0texx+HYO
	TAZYXKarn9hsEXT7dxO5JTNGyiAKUlqbrYcpsB8NhY4cqFrwP+dmEyXMvuvDSVXGxiAkslHN05d
	8Im4ZNagqSU9LZbGlPhcPj9Z34zLtL5HY8p5atP9gd7xgpuI4w5PnxL6+F0Cp37y6QotzQ/cQre
	Kh7vLE0MmKLEk8VZ/KL1Wr+zJzFvePaiNzYzMOFqp0hyXISVoGTiighg3RTRYn9qfMsl1X3FtJk
	QdNhNkTbF8bqcAscfrlShwJ60wDQk3yg9jqtxoRGtBfI3sZnp4dtQsI6RNlIoxjoZSHVtlocJJK
	12QTsYqXBY17jRgAHFXXGp9Jf6Wk14MAEd8EVBfW6jDhWX1CgaQ==
X-Google-Smtp-Source: AGHT+IFQImOn+iq/yUmUyBTZk4IQaF9iLgVYYsVIQC7hi6Y7Hlt3FPdtOjJo41ClE7NuPr3IM92ZKw==
X-Received: by 2002:a5d:5d12:0:b0:3d4:6abb:7de1 with SMTP id ffacd0b85a97d-3e63736f694mr1567362f8f.3.1757236446397;
        Sun, 07 Sep 2025 02:14:06 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e21e4c0e6fsm10918962f8f.17.2025.09.07.02.14.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Sep 2025 02:14:05 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 Sylwester Nawrocki <s.nawrocki@samsung.com>, 
 Chanwoo Choi <cw00.choi@samsung.com>, Alim Akhtar <alim.akhtar@samsung.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Andi Shyti <andi.shyti@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Denzeel Oliva <wachiturroxd150@gmail.com>
Cc: linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
In-Reply-To: <20250904-perics-usi-v3-3-3ea109705cb6@gmail.com>
References: <20250904-perics-usi-v3-0-3ea109705cb6@gmail.com>
 <20250904-perics-usi-v3-3-3ea109705cb6@gmail.com>
Subject: Re: (subset) [PATCH v3 3/4] clk: samsung: exynos990: Add PERIC0
 and PERIC1 clock support
Message-Id: <175723644487.30719.10030399153447295312.b4-ty@linaro.org>
Date: Sun, 07 Sep 2025 11:14:04 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Thu, 04 Sep 2025 14:07:13 +0000, Denzeel Oliva wrote:
> Add clock controller support for Peripheral Connectivity 0 and 1 blocks.
> These provide clocks for USI, I2C and UART peripherals.
> 
> Some clocks need to be marked as critical to prevent system hang when
> disabled.
> 
> 
> [...]

Applied, thanks!

[3/4] clk: samsung: exynos990: Add PERIC0 and PERIC1 clock support
      https://git.kernel.org/krzk/linux/c/b3b314ef13e46dce1cdd97a856bd0250dac8feb9

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


