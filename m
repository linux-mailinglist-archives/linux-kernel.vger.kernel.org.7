Return-Path: <linux-kernel+bounces-802000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BF20CB44CA9
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 06:14:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3AC627A385B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 04:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A617A269D18;
	Fri,  5 Sep 2025 04:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Pa0nujBX"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA911E2834
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 04:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757045641; cv=none; b=l8szFJy6cOpz3w/K0CYT2c59kPBVatEDAlE65SgJWiwI/XcgzFq0IwbSa46/8Cw9HpZ7mq80yLmBkO0enKx+KBL46NbLDi1X226+DJG8xVEddnySn7oge2QcKMcUIeQfU2Slq/K9V4Gu1X9y/nk8Vd8vbaZbjs5cS0br+xhmoqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757045641; c=relaxed/simple;
	bh=0fYRl15KIX0WePQH2MFQdJgEu6wtt4B+4sM9XqpEHp0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UGWcE24lIc0m39+GUmVtjHt3tVa2Ezdo03jggcPK/v27AMHv5aG4z7iY05FUfe9QT7FZDErxfvbbfcGfn+9R5KgIcK0MOkB5JKIuPr1Vmq9cEyaoWSm4LLN4Yf1ypK7gT9G/6/mq8K1GFj6OPXDMCmhjkH6gBbJe4vWIf7nmRno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Pa0nujBX; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-336e16f4729so12794361fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 21:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1757045636; x=1757650436; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0fYRl15KIX0WePQH2MFQdJgEu6wtt4B+4sM9XqpEHp0=;
        b=Pa0nujBXCifPQc3nIHCWUFY3HJpuGZw9+3DSEDyNLt7E6+n5KjdX3pLQI4hxrfHixA
         lln7Gh9oqN7xgSaWqTJLqCrnDbX+b4f3yCy2mKf4+mVZpEWnmJDLz+JPP7kITlHBT7yq
         VJlYjFM2/38gZsSnil4Vi96SpNsC2vB8Legb8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757045636; x=1757650436;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0fYRl15KIX0WePQH2MFQdJgEu6wtt4B+4sM9XqpEHp0=;
        b=gj2aVAwAhwxBET0MmP9+fBxIfGFyDbZh76MFfuITH9R6LBdEV74Xz/4Sg+U2KFMTQ3
         5v0wIHHqfbRFs4k72xqoliuMkPjJunExE8HRfMwZQL3k0HjFVUcdThMXRhHXBjyMyyHJ
         D2Hau8F8A8f7bJKf0Ygxa72VHCPWzsljEeY9QCevJY29KdHAF2g6B9HeN75LOMwg21dz
         TZzfzHH9BFMSZi8pvqri6AyBjb7SeNWnmXlTlax49pP+yPuw2Nyz8/9hsWI21Onb/Umh
         Jk+akKD6uFrHDvmMmF+mvDrAK1e1X1jW4NbdQHfmOmaC58cMlqpBIJRq4kl8rk58OCPL
         GOjQ==
X-Forwarded-Encrypted: i=1; AJvYcCXBvBDUaT4sf+25hso4gGX/I0wC4p33Qk2EVEgZrWkKUGA+2sfADbFc79dDQ/AD3MwE/Fbcg2yHit+3WHw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyw5ZiNXnlLFM9by5fd8GzNWfEqxwvSJo+UL81ww4DCXvKw2vbF
	qnHEM4x5pp5INsxVkVEKk7WJPtBdC040Sa9nC8hYR8z0M4Gl8lEcm4J5w9MvkXX/iRgFp3AyN8F
	9+N2Yjgzsxr7G9oH4TnsoA2MKUaxwaQUpDwqRDMcl
X-Gm-Gg: ASbGncssZ59fkMvG37jx3r7LPbqIz0vWHjhUsKb8OwHaW4VsD6+m+FTmxdMGaaiNJ4u
	erWEIUME5d5R6hs+CjntbfCPHW2dX/dqHhu2MWrVZ4V+yGeajbqVEp+POJnRUDpFOOfmO3vZ5x5
	ebibzljdwepGjupxJsXV1wxv47CL4F3ySBl9gkUBFeuQtC6LgyF8wDbkFyksV6k/J0R1wxW5u9O
	VM3qFaz7LlHD8lARtOxv5S0kZnTzcFctDFxOWEh+08UDW6S
X-Google-Smtp-Source: AGHT+IEa0TMIVMFiRNiOTeyQqmllYD/2S0wrm6EQ9v6TWvwu76YIEfNVYAC1dteqcnsTmIHsn61yA6m1gNmuAQeVk3M=
X-Received: by 2002:a05:651c:2129:b0:336:51d4:16b3 with SMTP id
 38308e7fff4ca-336caa4a818mr59122681fa.10.1757045636072; Thu, 04 Sep 2025
 21:13:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250829091913.131528-1-laura.nao@collabora.com> <20250829091913.131528-7-laura.nao@collabora.com>
In-Reply-To: <20250829091913.131528-7-laura.nao@collabora.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Fri, 5 Sep 2025 12:13:44 +0800
X-Gm-Features: Ac12FXztQWtNoog-vK5ygrU2ksjNm_shuXo3XvVwDmyxsQtnU3LNJR6VMH81zew
Message-ID: <CAGXv+5HjikmVaK_++METYBvTciQt1OTm77TU_e4Zh52MpCZ8bw@mail.gmail.com>
Subject: Re: [PATCH v5 06/27] clk: mediatek: clk-gate: Refactor
 mtk_clk_register_gate to use mtk_gate struct
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
> MT8196 uses a HW voter for gate enable/disable control, with
> set/clr/sta registers located in a separate regmap. Refactor
> mtk_clk_register_gate() to take a struct mtk_gate, and add a pointer to
> it in struct mtk_clk_gate. This allows reuse of the static gate data
> (including HW voter register offsets) without adding extra function
> arguments, and removes redundant duplication in the runtime data struct.
>
> Signed-off-by: Laura Nao <laura.nao@collabora.com>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>

