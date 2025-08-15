Return-Path: <linux-kernel+bounces-770069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C6CABB2766E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 05:04:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 951F44E40EB
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 03:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5452F29B8C2;
	Fri, 15 Aug 2025 03:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eFSyTybM"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025B429B20D
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 03:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755227034; cv=none; b=nvtHyKu0MvX7jMRWUmzOlGStgRw4F1LxGxyEi9U5YEEx6rAMXl2dsG0+MdvNWFBojKOpuTM3MxHROAXBBtvNmBsVM3joZPUXVqgOlAMq3nuzVCsn1FYc+rIrMaBzM7RXYS/0ZFtU3DrnHHv3QFIiaSzRtP8YDrcbayzJ0tP1R50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755227034; c=relaxed/simple;
	bh=HinHQKZUtxe4t41iR9D9bn+PEZ105vFBbOQmMnTwk9Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NCDxZhFPEQtf7/h9uF7BUkvxab2hHXBb6j+GrR0n7UTt7A1YvzHzHulOpVi1feHpEb1CqNTDQVIFlTNJGQMs6dhPxRW3rN9eegOQ8iL2U5z+cTUmZP6MKnOu8Q6IG8LJuMml50HnE10w612hB9d5sNXHfPYSsmUxKRsq4SoRu1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=eFSyTybM; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-55ce52807f8so1486152e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 20:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1755227031; x=1755831831; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HinHQKZUtxe4t41iR9D9bn+PEZ105vFBbOQmMnTwk9Y=;
        b=eFSyTybMep2zGs8cgTE9pFyv+RTx1qg/TRgwPwPzjOQ7yhv/VSIHID5g3GxVInSYYs
         MEYzYAInQbb171Zo4sOPVbxWclPPKuptT/OeJ9TBJAvsCWXlngg9fkFLbU6PW1q805dl
         OiqErf0N1aN3mvk2cDicMkezFJiuU/xQAQxCQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755227031; x=1755831831;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HinHQKZUtxe4t41iR9D9bn+PEZ105vFBbOQmMnTwk9Y=;
        b=IX38YuAlDFOz1SadogozufyjvHkAECw1FN40lSsG5KyYmmv4ZqZBosA+awoaBiaHXz
         A5iB5VtQHGzNS98FCvoIQNE/LBsFvQg8qEDEf0gONJQ0eHOn3DONxKWG80egNPInlwOB
         MR1ui49icvJV7QxMjQrETZwfpsfbzhYLZ4+DSrLtkYcO198rYGm7tL0qtbrPmoNHvf7W
         5LrHHxgrD8kyT8Cgi9EZ+l50vabn8GlMo+6TNOzzVehOIn9UfwshOxrP8Zy8yA9wWvY7
         o0rWxLf5r33QYvwjPhzGzKXW+MDpK21EC/axk1IQVGg+xyGD0XXYqhpSP7Rtmtye06Wg
         r4HQ==
X-Forwarded-Encrypted: i=1; AJvYcCXNn92lo9dMvX14ZzM591NKnupC5ZfbK8fpnERIZb7oUtHSPR02c10tEomU0HZF6by0AM8izRX5l5XUAZ8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywt4JSsdmr9DYLIhSkNjpgxsGmqj7SQRro646XwTZkoa8dW3RH5
	UjEmuI0z3M/E9DtK+qKT2zJJErIqGmu7SXqMuWUfwpO2ar2j2ycJproI2n6xBoJVu5Nz31D42is
	HFQwgGl0oRkktQPs+XnoNy+gcdf4nS+IIx3EcGzJ5
X-Gm-Gg: ASbGncsa+McmRmBYBcwVr/jfM/Y6QGwhQoWo6ZQ1NCBLkDJO3DAj/PkhQNHts2ycKuU
	LlX9MevjO0b1fUi4KeApBO1tQH0OvwPBeQNVJ5lElrDzDWwZCd9i0TJtyoT1x+oKKCLu8Ou3yJ9
	q1nnFT6783EaN9uTZpZZZ0jRiCvzjuErIqlIhEG6VCTuRrzOK6JLQIQwUoURQGexoGFjZD+oZnw
	FSYCWsGJFtRNVLStmJVEj4Y0xU/cJFBshIxQg==
X-Google-Smtp-Source: AGHT+IE5oudoWOuExXFcWc613ObdeU+xcba/kkjYM4lQww+ElYzSmi2/gSXFiaP7UzcFCgh/kx+W9zwxu3OJ8SIUDuU=
X-Received: by 2002:a05:6512:1104:b0:553:a9af:9e43 with SMTP id
 2adb3069b0e04-55ceeb906demr143594e87.53.1755227031067; Thu, 14 Aug 2025
 20:03:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250805135447.149231-1-laura.nao@collabora.com> <20250805135447.149231-2-laura.nao@collabora.com>
In-Reply-To: <20250805135447.149231-2-laura.nao@collabora.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Fri, 15 Aug 2025 12:03:40 +0900
X-Gm-Features: Ac12FXzlE2kni0q5NyqXgX7d170kjvAVh0V3KwwS63urIxRRXRRBW2zdHpmR4vA
Message-ID: <CAGXv+5GDU45O46A+mpdu1HQ_sfT2Su4fgFCtr4xPjoRPzwOWmg@mail.gmail.com>
Subject: Re: [PATCH v4 01/27] clk: mediatek: clk-pll: Add set/clr regs for
 shared PLL enable control
To: Laura Nao <laura.nao@collabora.com>
Cc: mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, matthias.bgg@gmail.com, 
	angelogioacchino.delregno@collabora.com, p.zabel@pengutronix.de, 
	richardcochran@gmail.com, guangjie.song@mediatek.com, 
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, 
	kernel@collabora.com, =?UTF-8?B?TsOtY29sYXMgRiAuIFIgLiBBIC4gUHJhZG8=?= <nfraprado@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 5, 2025 at 10:55=E2=80=AFPM Laura Nao <laura.nao@collabora.com>=
 wrote:
>
> On MT8196, there are set/clr registers to control a shared PLL enable
> register. These are intended to prevent different masters from
> manipulating the PLLs independently. Add the corresponding en_set_reg
> and en_clr_reg fields to the mtk_pll_data structure.
>
> Reviewed-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>
> Signed-off-by: Laura Nao <laura.nao@collabora.com>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>

