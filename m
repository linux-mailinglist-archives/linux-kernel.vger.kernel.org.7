Return-Path: <linux-kernel+bounces-859287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B626BED39B
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 18:11:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 12DA34E8E5C
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 16:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45CCA244671;
	Sat, 18 Oct 2025 16:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CAg0xQrd"
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED20F24166C
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 16:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760803904; cv=none; b=ECGtKibkYZ84u/t7lbvrjAUromlGCmoTXFfsGz0C/wj1GjKwaSn8jrSlvSk+EIYkl2HbIrFEEQHVkHZtaqpUYHkLMIodONLKr9Tj3TkgtXESo68uFZo09mxg2ILJuruCIvKnuw1iEeMQUXaud21aRPZcMi0F3ZLHdepiDTMPlkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760803904; c=relaxed/simple;
	bh=S5ZFwEPS/R5zgkEYM73LG0yyzWmgt3D08dI72xwUteg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=gqZkh7O2SAbi8d7bnuthuw9nuq8vywnl5nLI06ALGJFbxwL9iM2NGTCkq7/N2H73aNO9hZdmFyrVkQaeibsCIvH5n698fKkjNzdpJgaAKWhY2m4Drqxyg0aJ7XyixjhjHYwxRk0GbFVCT1d3dOXx9SQF+u3E6DatTBpKNIuPLpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CAg0xQrd; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-89204f67ae1so16759185a.0
        for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 09:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760803901; x=1761408701; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gB1PeMOLXs1r3u9Bm3EJ5/RnLcafi4Uhbd6zm8SAQT4=;
        b=CAg0xQrdKemEWhrVMP1IGX0B0n5R+0W8Lr5u/SL5Vr9S6ItNAG60zqQ8faN/dx6E6s
         Z0U/dES0GX42B4wNpdUX7y/sKIz3ZGPUg2yNFJH+CKP4oUsqfRCsZYCs5MGDwvHrlWkN
         JZJUg2BCNYyx+XOzs71L0ywxiQ1hAPEnwzvUMK9Ezq0yDTAL9bnGZUpdWkGsFyQVp9ty
         EpkM3xA0XGk8lrsLY64qVabnSBnUIPZ93ZEkbEy0s8cHJGoXOp42XGdKa7NmPA2aow2I
         rYNKXuSAm71MSumrKdRm/NwV+gBCSpB10lscAgxxfF1Jpxjp34QZMOxgvp6+PN+5koKV
         xgRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760803901; x=1761408701;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gB1PeMOLXs1r3u9Bm3EJ5/RnLcafi4Uhbd6zm8SAQT4=;
        b=unQh8Wicq/0b8aLHn692pdeeeyPtS6oWSLz1GpumHO48XlevODfbf8KPvaCh+tX5+6
         fhb6GXsZmRCwhlKXVj5j472rOixS8XWX9ngwzgeDJjqn//lIr2ufdKEETltLgTPNSCmF
         cHpqlvzTj4adBDgOiNq9sR9EmaVyNwfQzK3qdawzklGcxV1d73AcF42bsb32BaYUu4f/
         1AEc5gamVuj1oEpt1+whKhw0pmC3yO8TDnhtGnbDXptSCSmfHqKTVIZRSHC85QvZckJ/
         N28LJa/sohOLb7JZgcWE0LjnyG0nkAfJOOjcuSTYgEuczmyU0kG+0JuhMHObUWTU2h9b
         GsDQ==
X-Forwarded-Encrypted: i=1; AJvYcCXT0649SCP9UERSxbLsKg8Jxzx3KUkAKwCXXnINnC47BcDFrE4Y4bDwB5Mca4+b0apeINgQvVSXXrcRbKQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzdt4tSAHovxFNxFUuBmybNMa9nDAwBx8/totunGQG9AQxqKWdE
	U6AzgM2rGBcpznqjsFKlfWkRmCasQZT6PKj9P0CZ4AvYOJTWasluhg1m+Llvv1hQ+Ys=
X-Gm-Gg: ASbGncsmWW7XRScGdUE3P1Uhb9hmxYOlrN7yo1wt69D6HPJGvrL4ILKTvKZpzpsRwyu
	TrHZD3hIEpX6GOYD2PIDU5MnKLwLzjSD2Zu5+MuDif7WwB/VZT7LgO0GQegIEMhHukkf15f+N2Q
	KnuocfG9dSE43M4yxD/saYNxTauWUdrfbv9WFeU1GM28yIkUfjoPiZ9m0Zja0m5Sn9FhAZuUdmW
	Qo/pgaurAL7/PnTEKsXKDFfLNJj/KDaBjTiQKA0mlYNeMmJzNwsl7GiLt9jcDcq5aiCNkwJoTMI
	fTr2fl2lNRVh6324F0XjwkhXP3mExpI8NCnyf1zHQwrOg21bPHeIJMDbRdRrpDlytlzWSoQA/xa
	kXeHzb4vhiRJGjuA7XuNi3mzjIYwk9ziNB+lK70uCYVsmzDK489R0FL1lmTB6863im/1iM1BHx0
	qM+CXhjzXk0zbVLHYKf6ErtrAPCwSsTTaPfl2Wlg==
X-Google-Smtp-Source: AGHT+IGudErotX87fbHUUlOW8PhZW3gWYwQkQZjuqEBocyqBpJK6gFfGLxWRlsagEj71JpNhWFJU5g==
X-Received: by 2002:a05:620a:6:b0:891:c59a:a9c0 with SMTP id af79cd13be357-891c59aac34mr254639885a.5.1760803901491;
        Sat, 18 Oct 2025 09:11:41 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-891cefba919sm189319285a.32.2025.10.18.09.11.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Oct 2025 09:11:40 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Peter Griffin <peter.griffin@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Cc: Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251010-s2mpg10-clk-v1-1-dafb5d179395@linaro.org>
References: <20251010-s2mpg10-clk-v1-1-dafb5d179395@linaro.org>
Subject: Re: [PATCH] arm64: dts: exynos: gs101-pixel-common: add node for
 s2mpg10 / clock
Message-Id: <176080389770.37784.9004691258148372039.b4-ty@linaro.org>
Date: Sat, 18 Oct 2025 18:11:37 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.14.3


On Fri, 10 Oct 2025 16:56:26 +0100, André Draszik wrote:
> On Pixel 6 (and Pro), a Samsung S2MPG10 is used as main PMIC, which
> contains the following functional blocks:
>     * common / speedy interface
>     * regulators
>     * 3 clock outputs
>     * RTC
>     * power meters
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: exynos: gs101-pixel-common: add node for s2mpg10 / clock
      https://git.kernel.org/krzk/linux/c/f409bd20f0a94ca4eece7eb919b800e013abc043

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


