Return-Path: <linux-kernel+bounces-802140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D704B44E05
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 08:36:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A65ED1BC79F2
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 06:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 892332C0266;
	Fri,  5 Sep 2025 06:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IzulrF9u"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43E2F212545
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 06:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757054209; cv=none; b=lgF9cS+9niEhqtrPZA5cuDA7HFqUDnEFHiEcB8sBBGk8QbO3058V/Z3Ab2Z8LTtmd0WjazMwyrcDMd+efoKHH/ky/LvbWUTJ3Sx4KK0SeHdG0CJCivijEm80wJSMiW2rl3N7s6o+vVbwAIAahP92LcHu5YvjGa58qsLZprvusnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757054209; c=relaxed/simple;
	bh=wFJS1RHxYpPdjfElWjyoww5Tm6gmIS00MsIdtooweP0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=liUN8T1wBFm7IDSyR4aqvRVg1vf8CvKx0WiEyy/qRmc2mmHHeVU1NdTh26g00kQ/S7PwputGDxvAwsH2AQgiBNQRN6b7bPtqvtPsXigh5FfpVxhDuulpEK69svfWDZDLSOTPethXS+NqZ5jf4mgwAa2Phnjri3SJhp7d4n1oI+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=IzulrF9u; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-333f901b2d2so17953851fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 23:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1757054206; x=1757659006; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wFJS1RHxYpPdjfElWjyoww5Tm6gmIS00MsIdtooweP0=;
        b=IzulrF9u/DSrT3zqQPUsDOY21AVLbnTTjCEcARRgy+OT8PlJcHAQS2yebbq6X5XqAI
         duf0IS7+JJA0PmNyMahxFhjyjto1zT3e/bruHK35GFkh4cfA2R3kdPC5QsbW3Vrvd55b
         7kjrMqfl55s/CSa4u6ru9TyGum0qbFn4WRis0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757054206; x=1757659006;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wFJS1RHxYpPdjfElWjyoww5Tm6gmIS00MsIdtooweP0=;
        b=WiZsIimVgiGk7fDXCWIh8MJ+sNT63vi7+eMsV5HJQi44EiwiQnIwWXa6Miw8DCo0zW
         CAMzYWE7OhOOBUStbHQJ55ow0pcT+OXg6J4jU0STiEJj+oH6h18f0RWWbo3BHZlzUi0R
         qM9OJQuUb/XGtjxNp0h4xfG2DMqTD1zerGnaCwGCtvLhPCsrUBgHuglQLrpLRpwv58XF
         o+JNyD69WatqEgwuxojMM17ykB/HYQJTllWLdf7qIDvDqh5F2/0DYZjUgPDWvm9xxJWP
         7j/T/6y1HsvZZcdxZpwVdO+O7+Gd6PVjifW8i11b3a6lAIjroFNAIxsKhBH4Wn2UBG7F
         8Z+g==
X-Forwarded-Encrypted: i=1; AJvYcCVfi7SEimeFNF4VYzq506or70VAxVo9x/nXPdp2LH7DqhA3RBSCCe5fasOglPUr21AMs5dm20YdU4fe7Vc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzY0qKuUSDkVAlPJVdbEFyO7vh+a/Xz7tZVLsiXSepxj4jxNRKH
	W7jKeS2ZZWYyVgXRhQv6VNOYql9eteeyxfIzx6J82W32UEvmcLA7cQyfh3WzrUr7tXPH1+KVSyF
	uqgAR9g9htl/jjZaAevcq9cD4E0U9UEukFFbB/iUh
X-Gm-Gg: ASbGnctuNkLXuYJFCr+TqlgGvmqkXs+BdYb1sf5MUKAIvTzZMfkwhAiyw79JmSDsmYu
	CvmTUI3YBXlY+aLd7FBCi+XBigDESfIIAAf1Uc3pku0k5TFLZwmQPsiWtxCPCvWBGNkWAT+GLMP
	oQF5oDlDoX5dcmAA7IKLJbIj+l0m+6kfLfHDo0hJ7dTm20fRAYyOhwyMzbSAplR5h1y4WIM2WAv
	kjDNFSDPsbwH2lv36muLpmhgSnlGgi5V7LhVg==
X-Google-Smtp-Source: AGHT+IEgVbxQy/DxXsDzvdrcOfC49jBWiMtOAGepTowcEVXECREwr9aIaRDx8B4CTbXxL/deN9wUH95NSxy3a5X8TKE=
X-Received: by 2002:a05:651c:20cd:10b0:337:d2e2:d467 with SMTP id
 38308e7fff4ca-337d2e2dcfbmr42859621fa.43.1757054206408; Thu, 04 Sep 2025
 23:36:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250829091913.131528-1-laura.nao@collabora.com> <20250829091913.131528-16-laura.nao@collabora.com>
In-Reply-To: <20250829091913.131528-16-laura.nao@collabora.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Fri, 5 Sep 2025 14:36:35 +0800
X-Gm-Features: Ac12FXwXWypau4EdANuUrgXmxAn5bymNrHkP7HBNlw9rFp2Nbb7jmA3VYZ8UsYk
Message-ID: <CAGXv+5GjZusKNCe+EshMktmyDcfjm6i5oD+h8LvObymvD9QXqg@mail.gmail.com>
Subject: Re: [PATCH v5 15/27] clk: mediatek: Add MT8196 ufssys clock support
To: Laura Nao <laura.nao@collabora.com>
Cc: mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, matthias.bgg@gmail.com, 
	angelogioacchino.delregno@collabora.com, p.zabel@pengutronix.de, 
	richardcochran@gmail.com, guangjie.song@mediatek.com, 
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, 
	kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 29, 2025 at 5:21=E2=80=AFPM Laura Nao <laura.nao@collabora.com>=
 wrote:
>
> Add support for the MT8196 ufssys clock controller, which provides clock
> gate control for UFS.
>
> Co-developed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@co=
llabora.com>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>
> Signed-off-by: Laura Nao <laura.nao@collabora.com>

Assuming the previous reviews for the bits are correct, the removal
of CLK_OPS_PARENT_ENABLE IMO is the right thing to do.

However if the hardware ends up does having a requirement that _some_
clock be enabled before touching the registers, then I think the
MTK clock library needs to be refactored, so that a register access
clock can be tied to the regmap. That might also require some work
on the syscon API.

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>

