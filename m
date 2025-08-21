Return-Path: <linux-kernel+bounces-779690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B09DB2F756
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 13:59:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FC001C219FC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 11:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 837052F4A13;
	Thu, 21 Aug 2025 11:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xCtXgylk"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D7C32DFA40
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 11:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755777519; cv=none; b=oWjFETV4fgGW+/wLQE4XCcFUtOHVQ9uSTxeWxLM1xboe/+RTafDdVZEQGaNTwJhWvS4IdJ9AiLQsf4c4FhZumEUg4hUJ+lxW+DCAEaRaPjSXvIgCkGkYx6YEeAeudmWtlNPt95vnV9QBZxB6ASbG9eYCXtSts0Q8m4FoUSAIglo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755777519; c=relaxed/simple;
	bh=C1yHBNPn96c3V7CQ1BaXqtWREVYjXTs5jbHzOGvJ8fk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iXqkDKTl2+iNuJC3rE381IpF3sqYxXn5/NsCjvUyJv9EFtlAC7I+phD5S6Ox0F0UT/MxWdBZXOG4KmkC8gOSunQ7JX49aRYWQjdI5b/u/+bwCoO7pUqrjeFqVjKAExrmuPumjiNHCPQDszzMHWoGlOQ5xx0eA4cy6KOCsSGByfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xCtXgylk; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-55ce5097638so970337e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 04:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755777516; x=1756382316; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C1yHBNPn96c3V7CQ1BaXqtWREVYjXTs5jbHzOGvJ8fk=;
        b=xCtXgylkBbfdKJboHDlBwK90op4jRs5JqWNuldY7emQXEfjph29J3zeHYzVY66HNBK
         wlzu7hYuc0Am7d+n/syK1tVjCxWoH+3e72rTBrhkC3Dx5aDIL+MKdCPMo+MkkbDYJW3T
         GQvD+kbfmctw/uefm2A35c8su4EkpA1Wfn2Rz7Mq+1bjEoE4nDoKcitA4mbIIfNVAXg+
         7Ix2Xb0Ls2ATJk50pm1I6IPQxRKbScEbdKffVfd4aO9RjpGSobDGGfARBTaCM+iKEhqr
         hERPw1NK173TD0FcmCdQROMxaa3zWtNMdMiZuPY6C1RavSibckpO8dwpO4lOMUbaTxJF
         xucg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755777516; x=1756382316;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C1yHBNPn96c3V7CQ1BaXqtWREVYjXTs5jbHzOGvJ8fk=;
        b=r2MvTOuzqxS/Yl8Pln6dcJtojpsJJk5Bzb60Gn1qaT0w1LX8CdS8zvtK5XZw8Sktta
         joUBFpGtiOzuAXe8A6g0l3Tbg6NRyxHAAz0Vx/YsOHVQV8pBRf3yb4wEWAwHj367H6Ws
         5Iniw4aKrgyTwhydPtWzjzxHeMG3mjbYBZEIa/EcClkXwDtJZK0PqTxsa4feeUqTgcIW
         Xll0CpvFrCFc6r3gsoa1EsawQdOI6q9Hr6fS0/kSILezMfWUTb30dHiVRRzyRO2hdD8Z
         EgSDro2XohQnxa9/WF2d6GI+lp3HXJoS4+7DPxPDhRitpK1y47NhbuDYQ9yGe3CEWj2S
         E8vw==
X-Forwarded-Encrypted: i=1; AJvYcCUyF7Fk9sCx+L1CAsY7cCok1pcvMK8wTO7pdQTi/yQTvkHxXUmxmAXSq/zmBtFX05nS9BT7MDSoEWVAJ3w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+8j/3AWkVG+KzVAmy8jujLfLtHV/Slr6eHLzG9C5HLuVrJURo
	NsdoY/S9w4GWEuFMKrB029tF9qmE8tCM10Zd+Ujqo//48JMSWqv70jkUJAI+XVZn8O57xJBdXww
	/y52I/56hSUyE0vpJDC5amJqmXbJd+iSwMAyi/mmPzQ==
X-Gm-Gg: ASbGncsG/pmsOH7fyVmub5tbo7cMwVa8hfGTO8LnnTsfpplY1x67/GLc4BLj2kb6RLc
	l94SA8Dc9QTG6fPy7GF/tkVC1LmBKHE0OuDP1nnQKfPWX7pVIdELpr/1LUMpTY2GWFPh1/NOtCI
	pE29TtgdFtsTwGoSt13x71iwYBDsFr6oCjTxA/UnpJrND/MGHd9SkG9iY6xnsfc10QpNE5xTsb/
	4y16HzxYkqA57+36g==
X-Google-Smtp-Source: AGHT+IH58fB2HF0XIYb9mpaGtP+eqBvxII7AxaSZMaIMfHYj0Aglieg7CeivWcXE0AOhVbRVIpo+wetUS4Xw3r7Sv6Q=
X-Received: by 2002:a05:651c:f01:b0:32b:9c54:4ca1 with SMTP id
 38308e7fff4ca-33549fddaf7mr6881041fa.39.1755777515598; Thu, 21 Aug 2025
 04:58:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250812084639.13442-1-andrea.porta@suse.com>
In-Reply-To: <20250812084639.13442-1-andrea.porta@suse.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 21 Aug 2025 13:58:24 +0200
X-Gm-Features: Ac12FXxsqYADEtH5a5dR5PUdlqrKLGpwt68yMJcS6gbSE3gVttgWEaGZaRZKzIU
Message-ID: <CACRpkdYPyp7p9Pe6KU9yq+1V7OTykCJrNFzv8KxuzxSDYJ93sA@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: pinctrl: rp1: Describe groups for RP1 pin controller
To: Andrea della Porta <andrea.porta@suse.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Florian Fainelli <florian.fainelli@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, linux-gpio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	iivanov@suse.de, svarbanov@suse.de, mbrugger@suse.com, 
	Jonathan Bell <jonathan@raspberrypi.com>, Phil Elwell <phil@raspberrypi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 12, 2025 at 10:44=E2=80=AFAM Andrea della Porta
<andrea.porta@suse.com> wrote:

> The DT binding for RP1 pin controller currently lacks the group
> definitions.
>
> Add groups enumeration to the schema.
>
> Signed-off-by: Andrea della Porta <andrea.porta@suse.com>

Patch applied!

Yours,
Linus Walleij

