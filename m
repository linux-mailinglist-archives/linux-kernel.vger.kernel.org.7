Return-Path: <linux-kernel+bounces-832493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1D1AB9F7A7
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 15:15:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52ED75601D1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 13:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94695222578;
	Thu, 25 Sep 2025 13:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J3jlgsRY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F30262222AF
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 13:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758806099; cv=none; b=VOUs4QnRAqmHTJWqN9zrKRhbyjliBJkF90ZW4sPxCqY6JJhtoI64BkEw+a3+SOXi2sbY4qEDi7Vw0Aw0Vh3XasKC8VcvEAf2C4DRnFDXP9ZYsoFLMl7k4b8149URN2y/7Z3o0raQaHUXpcWzsCIiWkEKoNF3PoVYXKZlD5UF+5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758806099; c=relaxed/simple;
	bh=062M6/8j4NBzg2XWFjfBe/0J/9992fP3Zjk0wG8eK8s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A/HJcopw1VmHdZnQmV00wBXLvh/sZXV2baTCHqDJ5CFOwLzoJniqTeysqI5YQc+SSVMjFkSPOQgUzyLl73hZVrU6rNowVh05JUxGDK8ve+imVFoJ7/IHMU7KslVhWKhtNtH62BhsSrlpf2uazVK6geHzTnnAiG7VShuq3cm0vXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J3jlgsRY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0CD4C4AF09
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 13:14:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758806098;
	bh=062M6/8j4NBzg2XWFjfBe/0J/9992fP3Zjk0wG8eK8s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=J3jlgsRY0/E6Z4oiW+LnGS/HJQC3hSvvTz3GdG2WpmcNMywVtx5FgvBYswTN0y63A
	 CY7WZCYcrAvR9n5JYYhPld9yuB0K9R3zwKH5JMCrQLvqq+Tpqc8+aJft2R8pZ/YDjO
	 xKYKkvQlXMv2dLj6FRuMFAlZqaguPnpSCv/FmuQ7egNRDcziNADCPrnI0FfuG4fe6t
	 SHS7/m5vr0YzA1bm5ZraTT9wnwijSpxEKS7+nwVNJ+wqNmkIf9zjXEKZm9xpVaJota
	 ESagvtM5tb0GlYoHqxN4kwYAVVve2IhoFrMwNApJ1J2+O0RxOZpJx+Gqbiz0BfskDv
	 kxT3RDlfI7/wA==
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-77c1814ca1dso775681b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 06:14:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUbhz9rNTPDn1Q51a2bow2sYBPk/Qf5BMCyBDAeGOX3tMQ+gTp7Q4FuFXpHU3dmU5ATxMGUNhasOU7FGMI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyuy0Aaf9yYAdbpK2tqaBn+diO39zdzgUbo1u4Mx7LRE3NwXnjg
	GAWKW3y+UxWofDc05hJk5nIGgkJLFgtX03jBNQnjETbTgigYdZ1UgzsdIWmMgNpIPxKNQYdls4k
	MZ/S2MgPZmoDuicnvIOaituzHT+tbA60=
X-Google-Smtp-Source: AGHT+IEZTnk4r2+Yb8GhN2efY3oHv0w7Pj85s3V/DNwMNZqwPOEwouLCSWf6XxrASX7zuc/9JwLdyD/Xi3x6JTBBRwk=
X-Received: by 2002:a17:902:ebca:b0:269:ba77:4eea with SMTP id
 d9443c01a7336-27ed4a92b47mr39799145ad.46.1758806097880; Thu, 25 Sep 2025
 06:14:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250924-knp-mmclk-v1-0-d7ea96b4784a@oss.qualcomm.com> <20250924-knp-mmclk-v1-2-d7ea96b4784a@oss.qualcomm.com>
In-Reply-To: <20250924-knp-mmclk-v1-2-d7ea96b4784a@oss.qualcomm.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Thu, 25 Sep 2025 22:14:44 +0900
X-Gmail-Original-Message-ID: <CAJKOXPc2LwFCW8w5kDEZPAOPz1Y_ix0=jjUHQDHXW03wdcufsg@mail.gmail.com>
X-Gm-Features: AS18NWCtGqOMFzAGGyQqpY8JXXlJLDCy6kxa6YEKNYiE0F2TiXpsp24xv7MAzJw
Message-ID: <CAJKOXPc2LwFCW8w5kDEZPAOPz1Y_ix0=jjUHQDHXW03wdcufsg@mail.gmail.com>
Subject: Re: [PATCH 2/9] dt-bindings: clock: sm8450-camcc: Remove sc8280xp
 camcc to from sm8450 camcc
To: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, 
	Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>, Jagadeesh Kona <quic_jkona@quicinc.com>, 
	"Bryan O'Donoghue" <bryan.odonoghue@linaro.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Taniya Das <taniya.das@oss.qualcomm.com>, Konrad Dybcio <konradybcio@kernel.org>, 
	linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, aiqun.yu@oss.qualcomm.com, 
	tingwei.zhang@oss.qualcomm.com, trilok.soni@oss.qualcomm.com, 
	yijie.yang@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 25 Sept 2025 at 08:57, Jingyi Wang <jingyi.wang@oss.qualcomm.com> wrote:
>
> From: Taniya Das <taniya.das@oss.qualcomm.com>
>
> SC8280XP camcc only requires the MMCX power domain, unlike SM8450 camcc
> which now supports both MMCX and MXC power domains. Hence move SC8280XP
> camcc from SM8450.
>
> Fixes: 842fa7482915 ("dt-bindings: clock: qcom,sm8450-camcc: Move sc8280xp camcc to sa8775p camcc")

Trim your cc list. You do not have to send it to 50 people.

The patch is obviously NAK, if you bothered to test it, you would see warnings

