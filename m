Return-Path: <linux-kernel+bounces-895124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E2D8C4CF04
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 11:14:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08F061888A20
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 10:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A192334C11;
	Tue, 11 Nov 2025 10:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MwJe5B6Z"
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B170304BD0
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 10:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762856041; cv=none; b=aPL5cxf5Jo/7rEp4Gpzwt93n66OiopU8Lv5FxKrMtVAp0wR84lE08HcAe4I5ZVfSXa88AhOiyJF1QZPRMMnl5DdXl248FsmgTvrfzbMYat8d45zwXW2KruKjOApGGM/B+Q9rWbKk8nC67zHaOBCe/cPhj2S3k0GaV9ddB5yPzCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762856041; c=relaxed/simple;
	bh=LeMwXNllT4LhHLeKTaFba9eFWNp9e0Refct3JU/EgW0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G+hXBbbVUbiO5tWlbnvFjJbdMT/arRkUwKyKk/beBlAcY75S7dFEq+31P5onqygBy8THOKijB68cj0IpHUCUk0dgJXcYApKKa2EHeAenEVq2QPJ3utq9KMwlUPXUDQweRBJ1cmbAld9FeYfaI3EfPMq7w/jObwanysannHKo7XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MwJe5B6Z; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-787e35ab178so26117507b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 02:13:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762856038; x=1763460838; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LeMwXNllT4LhHLeKTaFba9eFWNp9e0Refct3JU/EgW0=;
        b=MwJe5B6Z3IGeLMOqgsNvZFEjNRHUlq982uY7NL9wNNhyAt3zn8VRJep2I/v8PObOIT
         8SwgHtTAiF6FSzh0YnA+HKuE2gnse+20y3qY1qmrkZ0Dla/+dKdVMqxpPQo8vBl65pl7
         ZdxpZtX5sorSF6912jDSaSa/URTCIKwXJRTa4L1wMdev03/GmOlJkPLiUkKuIWGIQCgu
         MI0O45RTPgla75V31QzMzwznVdkWxWmm/7d3qW/olHsUA6s3rfRuGwzmRmIsuhPINaHb
         ZO8B3XOZgcm9zSRetSfGEx8UTqkQrk/33fumhD1XtHspiwQi/PQuraNStDSVzry3x3IZ
         Wk3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762856038; x=1763460838;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LeMwXNllT4LhHLeKTaFba9eFWNp9e0Refct3JU/EgW0=;
        b=Fxdrn6XrvtVKdUo0ii72K1XhHzwqzdlWsrQPzKRL+KinNOJcCL7DyXNek3RiijQ8/W
         vKgz3xzfz/I2KRYLwu4C6V5STJE1BS4MR+V6Suxq7/saYbLZctSyRLD2U2s0JdAWgFca
         3HrD1UDbPhivY5TI2jtboJbFiEfT7c1sQos3MY0YdJC1LnQ7GXe8UdZWr3/jp8sUonbR
         vtoDHIPGqMplb0Pe0A7X9GaCV/XQpgTbwVe3OlfBr7ipnJ+zW5Mczer+7sFc1czR+TJG
         kP0UoqWFTLwPfJD3zX2tcB32vgwfz8BVUedLobVwQLpmmcLCcVNAMqrzamRjtAzGB4uV
         d49g==
X-Forwarded-Encrypted: i=1; AJvYcCXRlzSOfDR5P+xm0c2iXb/HJVz5A+qyKrpE6IhhbbhhPLDjbX0e52wOGJ8DuKqM+OCMe8cwk4aCo6AofM4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2XmF12DoqWGl1xjd/j6sYqotFQo1Et7WAP9yXCYtTzASnWY5g
	CvuxyDeGqQUXQFKmtFDzrdjWdPDpngfwKEGNFIR3sbFcQkGm8btAgjjtGUIEY0OSTZOoRGYgE73
	is8iBuzlPIM8/hGMMPf8yV8ZUI7h9z62UQwP+FiDn1g==
X-Gm-Gg: ASbGncuCuGtFNkxUfwSAqOWBg5Cf3LvvGAfn2hefqdEfy47HOpVmHv42v1DgpE+CduM
	zjQJ/M/6j0RNnf0aX1D3UTryrp/u6Rq7dl3Ynd9PPxBSWUSASKQ0DdtlJpPcLDm8JmTSwM9rW3E
	lAKiRpJEb4161jPrEpap3V1ZCU33wTIbCYF4E015qfyqc7eRGy12wVu0T4X5Xf0u0RVC/bRNDBk
	QXiG5/lzwCmkLLh6F5gO4X7C/h7iUcMLx2fp/mRmzAR7zv2VdQI3wmjWp6RFbAn3CdzYSQ=
X-Google-Smtp-Source: AGHT+IF9Qzu6zmE2Iio8Nz23xz7uKZaMMjTrJFnhpC9W7T174pmVZm6XJJz8JqOAQn21MLhQ4SKvuQGEPKenwCujUTM=
X-Received: by 2002:a05:690e:dc4:b0:640:db91:33d4 with SMTP id
 956f58d0204a3-640db915617mr7528496d50.26.1762856038239; Tue, 11 Nov 2025
 02:13:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251105195007.199229-1-linux@fw-web.de> <20251105195007.199229-2-linux@fw-web.de>
 <5DB7D99D-A30D-42A1-8E3E-B0204A1E6E6D@public-files.de> <1af7077b-42a3-4efe-a8cb-6117136c8f2a@collabora.com>
 <20251106-strewn-carport-a33a8b812794@spud>
In-Reply-To: <20251106-strewn-carport-a33a8b812794@spud>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 11 Nov 2025 11:13:43 +0100
X-Gm-Features: AWmQ_blovY8iar-yYYC_DuviA6U5c_hbl8gXmu0oONH393Qf8f6FhAsUxk1NsNQ
Message-ID: <CACRpkdYbcc_0=qwZgLhpTi1NNjkQ88JuOANqTqTfwMrUs_+OfQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] dt-bindings: pinctrl: mt7988: allow gpio-hogs
To: Conor Dooley <conor@kernel.org>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, frank-w@public-files.de, 
	Frank Wunderlich <linux@fw-web.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, Sean Wang <sean.wang@mediatek.com>, 
	Daniel Golle <daniel@makrotopia.org>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
	AngeloGioacchino Del Regno <angelogiocchino.delregno@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 6, 2025 at 6:43=E2=80=AFPM Conor Dooley <conor@kernel.org> wrot=
e:

> > > Got error:
> > > said: 550 5.1.1 User does not exist -
> > > <angelogiocchino.delregno@collabora.com> (in reply to RCPT TO command=
)
> > >
> > > maybe this can be fixed while applying?
> > >
> > > regards Frank
> >
> > Eh, have I typoed my own name?
> >
> > So cool. Lol
> >
> > Just in case it's needed:
> > Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>
>
> I have a vim macro to a) save my hands typing lots of tags b) make sure
> I don't typo. ;)

Typos happen. Also for me.

A good idea is when you change mail address try to negotiate something
simpler, this is one of the reasons a lot of maintainers have simple
mail addresses such as linusw@kernel.org (which will be my next
mail address the day it is needed).

Yours,
Linus Walleij

