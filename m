Return-Path: <linux-kernel+bounces-728080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CC5AB0237E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 20:21:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D79C1CC286B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 18:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97F9F2F1FF9;
	Fri, 11 Jul 2025 18:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NU+AYmdS"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B5C72F2352
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 18:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752258072; cv=none; b=MRowHjm5w/0blIFEm7yl7XBGv3VuJciAAOBjd/GEeeH9pi+PB/FZcm9NmADzunICINkfPbNzuf4V4IPb5clIE9AgNo79EF2A5+J3cC6OP69nI2WkY7MYj6nfOXTxlXbXagn1VOdOiB+yXkGEdCs4b9xgzahzRhztTmA6mYThK04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752258072; c=relaxed/simple;
	bh=9pueYuEIoRhh8Q7SXjsOxjLRBOEiyf+7/9ZBmo6ZPtc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=szDcoaTM8G7DV204nCJfB9MgqKpPG9l9CXBdFpOPW/fd6BDDVzmxFt4yXbBfJ4w2Z1uLdvfrZjmtUNVx7NzMrUGVNE2BPR2cX5Pj6CNjjgiPbpRkO0q9TIgMT0KSJcJ1wXlXu9hvQXkcUopqHg4bGa/2ZoI9bqmj3K5ZMftqCgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NU+AYmdS; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-32b553e33e6so18528611fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 11:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752258068; x=1752862868; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PFonXyBEBu8bBQGRWXHhhJM0VZMeyX0O0WVctxeWjqk=;
        b=NU+AYmdS2Ww6aEAAyX1OFL3gx8fQMdj2FV6y1Bf3NGinK9IoKNI4s/wwdWq1Trt6wM
         Zx0EwUktzxHcXtEplUngRUWRKxGY1nDWp2u2W79DZqKn8t6zv/lUi43WssItoXrnOGrF
         UcB5OxZBwf4sS2l3d+YxdFlf1B/hSCLWarNX6jNDVvKG/i2WPdB9k5NYgp2Z8phscFqV
         GWnf6n8iHEa2VtI5/H9AKNPUue7gblqgGzl2CMLGJVnzABkKTpXH2PqbmX/PKrCoAsjF
         MZBfgpLRR36M/3pczQhVQMozYmPWyRGvX9xDv1hZHHsSq9FNi7rZRK8y9LAmIk27HNqO
         f0XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752258068; x=1752862868;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PFonXyBEBu8bBQGRWXHhhJM0VZMeyX0O0WVctxeWjqk=;
        b=p3ND4XPIdjSqDAdVALgCANeBP8xf3GSJDVMNyv9DzKWdc0sB6YrrRvtBFQFKF2UtGX
         qq78wWsaOlfvPjuwSFzGAUHZuFk4nF4Mg2RGFrfyDSdAOsWYzTxEi48U964X+gtJ5W2E
         z9d+6rCgVdNPg0y3aLLf8n69F7qQ9XgbjftGfYwK8ZRzd80ccfx0yAffgvCYsOjPO2SL
         ywyQS5nJJihu8e/cac1n4BB8asBcqpJplzortuMS6SeWzxRLSHcHhC1qram5CfdEh3OH
         lLQllV6ZL0r+o11kS8PlxIGbiYrWgjQv8C8RkAKavmPDOO5lw1YF5W49tLMiS09Y+XmL
         uaBw==
X-Forwarded-Encrypted: i=1; AJvYcCUpocoQjI5tuQou6qbuEr5olrtQyNwL+pXh1yhSROrFhdVjvoXsKX5kpqTCoNcgyby1OBo2lpXfm7Pm1Ag=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxc9IbvjLklEc/QoiO21KU+M1a0ZyB8FBkR1kDw0BVDiNU9DuG7
	1umzHZq2m8QUxlatHmsfGs5xprP7G/3menLFEFZwdbo270/zcLqHnXaK0S92CUKvCMFp2qBfbxs
	Zm4dalez6YLUjtqr+iMms7OvPKB6pkEAJ7F4ptUTUwg==
X-Gm-Gg: ASbGncu1Y4S/v+iN1NlduNUnvKxj5zobwANF96pDi+VPHFbwIfXG7gO/FI0fZHKyIBv
	ZrCMXG/Q5bis38ogk5zwWxzanDlOfjbDoMR1wmG653nQGFMvCtO9tJgAwLnWm1d4pMjNFnYLFGq
	g2UGTA47RQd94RllXp9kNetDRqt5Izt6U5IdGVQ5brekBNXZLBrMj+iy7D0Z9/0XliB7S91AXe7
	fhXo+u2XiTEspASkg==
X-Google-Smtp-Source: AGHT+IEvkwHGOLQfSLv38NyMLX/duDgiOrEo48zv9nOud2f/wZg6mazHn+ZXSSe8h4+6KW3mbg6mMV6T7HPqsPw49Lo=
X-Received: by 2002:a2e:a007:0:b0:32a:7d61:ded0 with SMTP id
 38308e7fff4ca-3305341307dmr10521881fa.19.1752258068303; Fri, 11 Jul 2025
 11:21:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250709-sm7635-pmiv0104-v2-0-ebf18895edd6@fairphone.com>
In-Reply-To: <20250709-sm7635-pmiv0104-v2-0-ebf18895edd6@fairphone.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 11 Jul 2025 20:20:57 +0200
X-Gm-Features: Ac12FXwUK_6BkBTiMmf0bIqwdADNOgyJE6d12NaL0C0nqmiCzFyAn5E5nDpYZaI
Message-ID: <CACRpkda-ssTEJqcj=vxnz91rj=qYz_rer5p5Db_b=pSdjUj9Ow@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] Add support for PMIV0104 PMIC
To: Luca Weiss <luca.weiss@fairphone.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Stephen Boyd <sboyd@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, ~postmarketos/upstreaming@lists.sr.ht, 
	phone-devel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-gpio@vger.kernel.org, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 9, 2025 at 1:22=E2=80=AFPM Luca Weiss <luca.weiss@fairphone.com=
> wrote:

> Luca Weiss (4):
>       dt-bindings: mfd: qcom,spmi-pmic: Document PMIV0104
>       dt-bindings: pinctrl: qcom,pmic-gpio: Add PMIV0104 support
>       pinctrl: qcom: spmi: Add PMIV0104
>       arm64: dts: qcom: Add PMIV0104 PMIC

Patches 2 & 3 applied to the pinctrl tree.

Yours,
Linus Walleij

