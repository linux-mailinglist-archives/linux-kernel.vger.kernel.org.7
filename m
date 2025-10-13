Return-Path: <linux-kernel+bounces-850318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A9343BD27EB
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 12:16:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06CEF1892E54
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 10:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7C822FE58C;
	Mon, 13 Oct 2025 10:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K8PdD2FC"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E36E2E6CC0
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 10:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760350557; cv=none; b=odiUaQF0wITQdZ/BjfdrzIvLfhsgTQn2KxvDpKEQYYXLbJr2VMwH60TPXQTpfUGnDvaKRrcWP+tg/JZbwO/+n01nQl+QO6t9lnG8+J0npITy4VkuusUHFfVslmEJbGHiZ8L0qV64ZGaSa/9kZvO70qnxrgNDhbXPd+zGE5cjPbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760350557; c=relaxed/simple;
	bh=QJNIF6k+iOR/IePJA8Fl6Y+gEa56kj3NzVJwCbWlVSY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dgJfhBBBoq14Rv1ny2iBgCITiDuoKyVo0e964y/wq3a9t8iRVF9kg23YmOHKnpD5lp2fIrx7cOgjmm5ECmsT8VJhLeMLw98J9LbuCqeDZokLpWlL4OJeC3Q9UsAvA8Kpt4Dj7xaTElVDJT/uOduu0/x667G1PD9DfHkroIujFPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=K8PdD2FC; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-58affa66f2bso4343783e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 03:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760350553; x=1760955353; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QJNIF6k+iOR/IePJA8Fl6Y+gEa56kj3NzVJwCbWlVSY=;
        b=K8PdD2FCAAXeFcaGt4C3KpG+JBrYF3fm37PweQFc9Si/k+JpqxgarHua227b67nepB
         GPHDAmcx6z9d83b64iY7LnC/If0QP+oTGVnaELk8enkpOt7gY7kEtf4hPlY1R/BpHYSH
         tag8W0HHVOFgLr94orqk+P6ByFAYUbwmxCuT2LnA6AhaiQtWngII3GSydlX+3ODrwAMH
         2S5l7cwnTKBalaVc13EoWZ5ejBhJav7Nua9WpEmVhhzKK45MvBeZuz/ed/y1W8tNvgpm
         jaL5keoNRB+23xKPR0HYh+N+4caES5Efyi7cDI8+lrbKHQzJ1VBHXk/VuJc8blaAlN3I
         SMUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760350553; x=1760955353;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QJNIF6k+iOR/IePJA8Fl6Y+gEa56kj3NzVJwCbWlVSY=;
        b=j3l5q2jq35c/8SIe/MhBHuchUhAS+00ZIsAJVGSTr0N/W6nM1UdwDDrYEM2pEhJlbC
         MltqhNqzYSZ0ulXNgvPLjlPuEQ5urnpegX9ehgY1yXaiZHUwTU8jaAlKQsl8P2HetdFB
         gXrxhFgvv+F6DMeu0UAuMSC2QDx3j49DwdNJo1jMlpLJOFPcIWJVF7DA1Kr0F21fJqoY
         j8l8rH7oswAejPzHGpo3wLbi+5ftoVTB/GVe/PZ0/HylaQLFqRYbzaDu7nG/wq2qwwm4
         xFTj2V1xppk7B3h+Qe7ncVSLJIILidqkp9hrf7xwGB8iZ+yAxXaFBaCwKLcZbQ5MsXkm
         LbjA==
X-Forwarded-Encrypted: i=1; AJvYcCXlrVJp13Yk9b1Hkhvjn2mRDj0MGhNwaznv3A8JNLO60NX/17lASADAPL7ia4uleIV/WI5ocf9oRmcsiAg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz77zRPrWFEg9Js8ZUAR4fV40t3Yd3bwAtVK+pDNpkqBVz6EnVx
	97IiVGXdjoLBQq4tZCyCOcLG3m2GxMxND+RczZJoKqEtCarCF26+XUGwCgYPvGLtto9MO64B/7b
	hCTpb+AQv8ugHY2Skce/ec6va0QQ5k/KHyVHZ8Kf7YA==
X-Gm-Gg: ASbGncvXoiS5QwnoqJMO01Ae03MQYg+RkEDhubsf2Xcmp9TpmDlIwVHRFx3Hiz57TTx
	3jxbUwcgvQjtC/ix6h+46fCopcJi3sADbKRODueYYo93R0Sj3lwEiPxIYuCUQUOFBLN8N6qcnwz
	2rwy83zQPn2RkniGAJZ47G/HDSvButDXVSw6RGqoz5kN0nBwXbaEbgw4nwVSjGbsJSwBmfWIptm
	ELGLqJbIh3z9BIG3QmZugCzH0MQKWLgvG+scuST
X-Google-Smtp-Source: AGHT+IEN02w81G1S5VW/kSneQdG1TOPLVZyWHNaF9kPMKLYqgtaUGWqWUaN5LOGIpSVHxD2qCpvgfmV4mdasQo7MrZA=
X-Received: by 2002:a2e:a911:0:b0:36a:a87c:d139 with SMTP id
 38308e7fff4ca-37609efc71fmr50058061fa.42.1760350553454; Mon, 13 Oct 2025
 03:15:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250919-pinctrl-qcom-glymur-fixes-v1-0-426ea410aa94@linaro.org>
In-Reply-To: <20250919-pinctrl-qcom-glymur-fixes-v1-0-426ea410aa94@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 13 Oct 2025 12:15:42 +0200
X-Gm-Features: AS18NWB-Rj8yGZ3DOyv1-w7k1_8_Txh8yemaMK031WnuKWeVF8Y3K9yfpPZYDd0
Message-ID: <CACRpkdY3Hz1QgK9jDVE6LT5DeNKbvz+-aa3Q9=njkESHmyeksw@mail.gmail.com>
Subject: Re: [PATCH 0/2] pinctrl: qcom: glymur: Fix gpio pin functions and
 clean-up match table
To: Abel Vesa <abel.vesa@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Pankaj Patil <pankaj.patil@oss.qualcomm.com>, 
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 19, 2025 at 2:17=E2=80=AFPM Abel Vesa <abel.vesa@linaro.org> wr=
ote:

> This glymur pinctrl driver is not currently being used by any platforms
> upstream, but once the entire platform support will be merged, there
> will be some issues with the gpios as they will be wrongly requested by
> the pin muxing config in DT, if the gpio pin function is not marked via
> the generic macro as GPIO category function. Fix this issue now by
> marking the gpio function properly.
>
> While at it, drop the useless compatible specific match data from the
> table.
>
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>

Patches applied for next since they are not regressions.

Yours,
Linus Walleij

