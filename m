Return-Path: <linux-kernel+bounces-837809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AAF96BAD3BC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 16:45:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AF1E1C4960
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 14:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F19E61D63FB;
	Tue, 30 Sep 2025 14:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G5lYBlj4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 583A81487F4
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 14:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759243545; cv=none; b=noUdl3g9tS+oOGWu7ywbj6lYCCgUH6WhzQW0zIsqMnWjR9IkZdhT8NwfcNK788aYc8r8VJ0wNDf2/p+uUHPhKxthTbDtrl5tnzBnjPDLedOkC/54/o1J9ifpc0TqvcZ4+JTUEJxgDervD5qMAeLauDgKON/fhHLb9OXTNXIb42E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759243545; c=relaxed/simple;
	bh=8gLdJL8Qtf+NqHZmB2i0AIoRu72Vt1AiMXEqjKqzjxg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wvl64ZnkWf8Bx/CsAqtgVl+PzBlUKr55UXOdyCHu4h9dncpaJhsg8QjD4Mj4rQP+0CeP7EsW5T8PWiu7ks/0yVJXHtIj0yY1i6CCLnL/QW76rTvjh/ZX4cbWZ34P0WQChqJm0/S0g6tHvFo/LW4GD0wADZJG9Cg6b//pMvAq97A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G5lYBlj4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D04AC16AAE
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 14:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759243545;
	bh=8gLdJL8Qtf+NqHZmB2i0AIoRu72Vt1AiMXEqjKqzjxg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=G5lYBlj4YMFnlVxk30Ejo+DoqzFVxg9q+NMUcMTCl+Pm9XcalENXRdNjKpl+2ccxK
	 z8aKsfImY2vMAUzZTcUptFpnbb5L5RpND5g58E1isiLk/mxc/aNA1owXLDvqZ1fhY4
	 AjipbfbObT3kt9K1G9ZkDMYuHDm0Q31mbQxYvWTt9oSjDUh8/IH5ltnOO4xMhDwdlu
	 u+2uPor9nfOGOzsbKJG9Ips6R8YG1Oxg8ljxKhxSVPofQ8Gptn3iKRJv3MMQIWRMht
	 IfFaSeKVrRSyc2bT/d4Ogh+4B69+3LFXXLzUpF4pU2UWYpQTom8RkQvpldgwTif+vk
	 LDZXZnBjP1x7A==
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b3f5e0e2bf7so398888966b.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 07:45:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUOJwuaLmNojjPLf7XfWszmvhQbj2M7LA+ES7/tAnmOY+KFsdkuuun0xDMpPZsz72ljAZcFBSdW6F+OZ3c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+gvzIvbbiW1mUpSe4cqbs1ulmOsxoUNLKvQL/c9f97J6yEYlV
	JdWGqA7/rak2QYExCRxGpsStvSU2B/sgAS38Ct6zWBDvPXBlRJkN3GPryJBYN5v+MJW1CuxBhIJ
	xstCxvHpxJS6+OU+plQzb9booab5m8A==
X-Google-Smtp-Source: AGHT+IGFKuwWTxqgZFN1sKn8z44c3DsN+/zWVoH5x3IdU6B9+r5DMFiLRR9CeEZiSco4imjsr8Fjmm054z8AwbnQu8I=
X-Received: by 2002:a17:907:94cb:b0:b3f:b7ca:26b5 with SMTP id
 a640c23a62f3a-b3fb7ca30ecmr712122566b.23.1759243543581; Tue, 30 Sep 2025
 07:45:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250930134547.1096686-1-weibu@redadmin.org>
In-Reply-To: <20250930134547.1096686-1-weibu@redadmin.org>
From: Rob Herring <robh@kernel.org>
Date: Tue, 30 Sep 2025 09:45:30 -0500
X-Gmail-Original-Message-ID: <CAL_JsqL3z7P8YJuqa1tNMYSBRbxWTKfzaDE87FD2+Oe5Thoiog@mail.gmail.com>
X-Gm-Features: AS18NWCD2uaYyjFBVGOY5TASNbgoqor92iEQrjs455o4MLprWpEFrzc6cn-wWew
Message-ID: <CAL_JsqL3z7P8YJuqa1tNMYSBRbxWTKfzaDE87FD2+Oe5Thoiog@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: mmc: Correct typo "upto" to "up to"
To: Akiyoshi Kurita <weibu@redadmin.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 30, 2025 at 8:46=E2=80=AFAM Akiyoshi Kurita <weibu@redadmin.org=
> wrote:
>
> The word "upto" is a typo for "up to". Correct this typo in the
> mmc-controller-common binding documentation.

You just sent this yesterday. Why are you sending another version today?

What changed?

