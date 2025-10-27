Return-Path: <linux-kernel+bounces-872618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D256CC11982
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 22:59:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B870C4E770A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 21:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3889030BBBF;
	Mon, 27 Oct 2025 21:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TVbFPix/"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 064AD2E092D
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 21:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761602337; cv=none; b=mjTnwh3oWHO05GOm2V28+jPtM0nTk29d4LUPavMg5MOHayuXVDV4UUnbMFXpv7mXtqPRcwakVQdzOppie++NvogVfXsZEbdnNv6DEDP6gBtwnLx/PdpYuwa1jpam4OaawMJzIFWzz+qLcTdEJN5jQOOt7qtLJnw0CN4HWhIPLHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761602337; c=relaxed/simple;
	bh=+mU5C7SFfUC6J4CkhOJClsnPEoZvWyJV/mtXvk0G7No=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ukRSu8X0D9RcU09j9U4FcX7CeT5GhZrCLa87u+S4TGxpqY1EzKrh9xRI/SpwzMfNCSH2Wsn8oIUcZZpJ0NOal2iBKCPDVhIKtpl5m6Sf2xy3jOtEfdu8HlnB9RG6+Xi9mAl4TvkZg8PNawcDcwJsakS8Z1EBtwffKN+f6xyW9J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TVbFPix/; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-592fdbeb7b2so5075153e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 14:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761602334; x=1762207134; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+mU5C7SFfUC6J4CkhOJClsnPEoZvWyJV/mtXvk0G7No=;
        b=TVbFPix/MEpkDHpX0aZDlETK1VkYOmtlsAs1c1kR+oesvKyM3uq5XWm55MG1STEo/h
         mO77I/TOqg53ZsHi9lvEAOSumIzBnVQPQp5G6cFmvDUDVn5SaWl1m59AHpRtTHFEshfJ
         HrjKwY57adUt/mJ2r0jyDw4zMR+7zBuxaZ1z7qAdggaEB6CuCb5u2ocCwSAFOl+FZDeD
         UsmLz0jTR5SynSNJ/NPefnsWTnRgHmGUzt762P3+QvCWDNjulKbUO8U4JWQCoFLI6EuG
         UPYbZ5sYYASVDcuJB63EUcom1U2If0J+BTi0cDmQrgzw6LWOLD0Jadl9SXLoGZ12Wzng
         SHoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761602334; x=1762207134;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+mU5C7SFfUC6J4CkhOJClsnPEoZvWyJV/mtXvk0G7No=;
        b=nooMRlfVFKIzbmQ3fNWN7w89ek80DvntnPMwgPHqvIl0W25CN5l9CWraqeGSPtmfVZ
         ZlByJ+kdhURj2ekrPlQTmrkeGrfyf+LY84gMwY7UQyKpA4HFuSctaEs0fQF20mP/Vpmp
         9o8ePQ/5WDN6gnjT2lRc1Klot+jsUqkFtjDOac58To+CXARfUaccMfs3GoXfbF6F9XqW
         kvb+McJ4r6AHtuITaeXVykL661Nhz5xgYbDDfp+Pi0vL8kcqqnlkZakhHGzuUJ7dCzSi
         cKtfX0aOJs/jXR5Jm7j/FYLZQ1FPfuh5/4saBLrl9bONab7pBdVvnRxOofXU2EdJpTPA
         XLdA==
X-Forwarded-Encrypted: i=1; AJvYcCXxa0v24Z3MFctAy4g0JRBFnHqKQB8B/2jZQehL2MuNUrMoqwrSUePnEQImwS1vBrs05Vu1oz7zYnmZGTE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQ7MheMVlQz15+H0hV+eL1m6dn0ciqfr/4yRd+c/KOL5aSmATd
	WgSinjXJIuO78ce22rf6Z5YllziFrkZVGHsxuOwLJOGnpS/WsqhnPh9BdCZXWlQ/FpsMnlqimV1
	l9nM1IbKIPw5bT4yxQbdiVzUxdKuTeqFBv18NRo81rg==
X-Gm-Gg: ASbGncuUmOmBMvvSpnmZxz7v61Dn9oqZR6bi3HQUuVnb46f56BOgB/QKYkSCrTIVm4j
	YYOqIQqm8zeTrD0G+suLRrj4oRnzQApdHqSPkRNcb7rZ8Bws2Qyk2A07r7PSKjXEsx2l/VWAXQf
	CzXX4oVQoENaNN7xzvs7ZCeXzBWUKgSi71y4wWISRyFEsnlj0Yhullk3LHzp+WjylRC4iYhQmAm
	buNwSiZUF9pPDagiwL2WdVVVI7l+l4A6S9mUQXnYe4pUicSjwROKGj8/8u8
X-Google-Smtp-Source: AGHT+IH74o4YwHFrblcCgtKny6KnIQvfpnqGtyi6DTdYt7rXfkYKCJxr/ADLzmPlUwLvMuIMarNyWU51gxQT7nyU5+s=
X-Received: by 2002:a05:6512:3f0e:b0:592:eeb7:93ed with SMTP id
 2adb3069b0e04-5930e9cc2admr556166e87.32.1761602334166; Mon, 27 Oct 2025
 14:58:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022165509.3917655-2-robh@kernel.org>
In-Reply-To: <20251022165509.3917655-2-robh@kernel.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 27 Oct 2025 22:58:43 +0100
X-Gm-Features: AWmQ_blAMBN4XZpjKBnIGmFZUkW4sspYUvqfxOKik98qDG_Txt9XayPb2-OwUdA
Message-ID: <CACRpkdYioyktQ5is6TJnkgX=MHk2-zf-XO-gx6sKcST2GABNiA@mail.gmail.com>
Subject: Re: [PATCH v2] dt-bindings: arm: Convert Marvell CP110 System
 Controller to DT schema
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Gregory Clement <gregory.clement@bootlin.com>, 
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Richard Cochran <richardcochran@gmail.com>, 
	Miquel Raynal <miquel.raynal@bootlin.com>, linux-arm-kernel@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 22, 2025 at 6:56=E2=80=AFPM Rob Herring (Arm) <robh@kernel.org>=
 wrote:

> Convert the Marvell CP110 System Controller binding to DT schema
> format.
>
> There's not any specific compatible for the whole block which is a
> separate problem, so just the child nodes are documented. Only the
> pinctrl and clock child nodes need to be converted as the GPIO node
> already has a schema.
>
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

Patch applied!

Yours,
Linus Walleij

