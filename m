Return-Path: <linux-kernel+bounces-841204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AB91BB67EA
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 12:55:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D6DAA4E753E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 10:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78E062EB5B2;
	Fri,  3 Oct 2025 10:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="Dt+2do/4"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E69723ABB0
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 10:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759488908; cv=none; b=XlPKKVFSTPtEejpsxFijuAYE3h6eJiAcWcq+aBGujzU6bzef7KOoT+KWk1SWAPYbz1WN72JRXG5udkMHvBEYsB1qDvQOfuIdOUAvP0KNYkPmh3Mv4PGNCk9XVDWgJsKa3BkYTpCI3N8rS3xZnZkD6KAR/cjo2wIMob2aWV3vFXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759488908; c=relaxed/simple;
	bh=cAECDx1sSxxHnbecn6VuOU03juzMj+AYiQE0DPv5YUE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dUcpx1qsO4/TkiQEluaKWf5e7ZjnkESWJ6rtIMd3xRTG9xxiSbVXvJgmmCrnh6A0Wxi9Dz/aY8hXxbettJ3LHJ5wZVBZeU9/AicUuXA5qO+LQ6zDsRYZfM/iOU1uOpLXjrtwvWthpxR6N7otbo39UgckLTU/BjZyFL01WlfNemg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=Dt+2do/4; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5797c8612b4so2691171e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 03:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1759488905; x=1760093705; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cAECDx1sSxxHnbecn6VuOU03juzMj+AYiQE0DPv5YUE=;
        b=Dt+2do/46SGcsGlqutC2Q/beezSoVs9eXPKN5p4FKJxnCrCkMHXrFEv1Pa0koWb1E0
         E3ylkTaRcOxyh6BZxHlh+rP9wzmHFm1G7KxB2fVhYuaG6x589AbsxP6vxrSvRrS5vR3x
         oh+kBAzL3k6rz1y8rRZi7VMcbKuVRc1z+QRe+tJJLeZqIC9jEIj7LCWdNXNjAjOzm/XE
         B48aP0YzfnBskXW5Xy5JNslpK4lkwWyMtGGcWHydOubqHA2wHw/iGjFPnS7pZMs01azt
         Y3V8rr5hGGRgUITB7xI4DWDkwDg/eR1PARpPsg1VkjP+gdv+dyCsyGIPFtgoclSivWzQ
         pDbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759488905; x=1760093705;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cAECDx1sSxxHnbecn6VuOU03juzMj+AYiQE0DPv5YUE=;
        b=dWysi71yEybSwbq2e6VDyYeP+znSrsKQxYlgyU5mvIQGcwqezwuZbXwtgE67TQXHe+
         FrkOJSs0lLLYl0XNRDRy9TndkWxexk8/p6IS4sHbE6th2XbyYQJs09iTsfbZzgGf9Ise
         sYlL98LWb+0mMz86hInDyLT++MCnpT+FAYY38oOGo/tPHEJg+bLooNE8ZBnfmy9bmHLv
         hQgYp3R6PojcIu2uO//Byd5OmN8uyRA2gvmqxrcJ5y3NCA6BCO1TwyyAGlAt4mcQYwdv
         RQtX7DtmvZp9hc0NUlchCQRvlu6WKPuDq8DVGEZJX2so0jS8XuaL4wXVHefNg7WwhajG
         osHg==
X-Forwarded-Encrypted: i=1; AJvYcCU+GNeqLR5C8GFylyAuNGg+J/z2ML5rlmO082fhTvddf4CrYh4X3FuuXIrZrBUMwHlvsyhqeMO8y0E2oqA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzrSlyLcVyYjEy3hDF8UU6frCgGtqwc1NZtSHK0bnMo1/lLCtj
	PkRT2YJxrLZX9eSBluqqLYfcaTAiM9XuZO1qCDnbi7m1hDcM442tcDw+7gcmCulAHmlC2LXVqSP
	b4aFA3/lK7yeIhpdfsgIsVvoTUs2pEpR3fD5PNxVFnA==
X-Gm-Gg: ASbGncsw+DijpvevpS8/YTUjUPm3nRpgmT5PXWlRWDHKJV931EylfjsyWt6Gkrd5Mb3
	G4QEKwD9doyTKCb4Hsko3PgwgB+zK1Wkggogty7qTQm0vEdFpI/V2kssfjik060bj/gn2i7R3gT
	V7sw7rJeYrsFI35N1NRvaskhZfVTdAj4OkOUOBs1yG9+w3CC4cbegPAKOjeloFJdB+NJdg4kOF0
	lNyJaXu7WAXL1VxGGDpo4pdD6Jj1kFeQF7y8El5h9kwtqgVCAQJzXWHHLwhFw==
X-Google-Smtp-Source: AGHT+IGo1Glv8ZcBFFkRNiPBtLkYhJhSKCGq1mD+OwgNLadjXj8hOaQai5wx3gNPSSCbTSSPaFVxfKegSNtXTCiWc44=
X-Received: by 2002:a05:6512:b96:b0:57d:8870:e96a with SMTP id
 2adb3069b0e04-58cbc2a5121mr956262e87.43.1759488904866; Fri, 03 Oct 2025
 03:55:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250924-knp-tlmm-v1-0-acabb59ae48c@oss.qualcomm.com> <20250924-knp-tlmm-v1-2-acabb59ae48c@oss.qualcomm.com>
In-Reply-To: <20250924-knp-tlmm-v1-2-acabb59ae48c@oss.qualcomm.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 3 Oct 2025 12:54:52 +0200
X-Gm-Features: AS18NWD5PiAgE6Z0yAwhzxIEi8uvGvV7o02AtdVmxa4WxKd4BMM2EBFXwJajs9U
Message-ID: <CAMRc=MdaT-ZSep-VYBUvS29XPje2FF4EvCfuUrXUUE1+8bGTaQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] pinctrl: qcom: add the tlmm driver for Kaanapali platforms
To: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	aiqun.yu@oss.qualcomm.com, tingwei.zhang@oss.qualcomm.com, 
	trilok.soni@oss.qualcomm.com, yijie.yang@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 25, 2025 at 1:18=E2=80=AFAM Jingyi Wang
<jingyi.wang@oss.qualcomm.com> wrote:
>
> Add support for Kaanapali TLMM configuration and control via the pinctrl
> framework.
>
> Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
> ---

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

