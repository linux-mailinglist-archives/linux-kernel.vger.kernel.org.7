Return-Path: <linux-kernel+bounces-872620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C1BAC11994
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 23:00:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 860151892ABC
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 22:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD56132143E;
	Mon, 27 Oct 2025 22:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yUdk19iD"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A1602E5B26
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 21:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761602401; cv=none; b=j2PhNSbfFmwp4yjg1iiZGuPd1dcOQ650gVRa07bix+A8gRuh/pJlawSIZUeOwqfUYIt7SFvtwetZx64K1l0nTcbPq0I3CYDWLVfm3iu88DWjiQLwfBX6RDKBPYZPs66jocrVso+WWKiVRmBUdh+qSLIaxrZGMfVwUlDbq4Ar6wA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761602401; c=relaxed/simple;
	bh=+s9wJrUVnAiARoihgzYhQW4ZH/+T9QovHaBTy4YJrjc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mNPmR8LEvRvo/eUABthodKr7ZLdBOVoJI2OLd1Qh3he5NHdQLVVMf2usYsTdfSlG/4+pRSWY4Ld8nSStmCnt5yKneMNO84PbsGKCk7gRHVv/cBkKKHUYl+VX0FMR2bRF6zt5v8v7les4Sbn8EOieYvPjzpHSS2BoQe0rqKY2MmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yUdk19iD; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-591c74fd958so5815095e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 14:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761602396; x=1762207196; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+s9wJrUVnAiARoihgzYhQW4ZH/+T9QovHaBTy4YJrjc=;
        b=yUdk19iDG9Y2oATyh5vf/Mmf4yZ82QWmJm65k014Sv5n4gZ8Jtr0PsS5yh2WnlL727
         26VKoJSi5DrBOoGeDw9v8PxxQWMFkJJMHss6M5DN36/u+QfNLKMX6UIKEtfzdCnQJyB1
         omitV7vv3YE9C2JmssdREvA/qWTSyJ0wxcA4Pvdr3N88ARUDIXuCwK/rqCLDId3/Vjsa
         929jRE9R23gfqJkrxyfp/fg+UDzET+oxRndmGiqh5qBVjukKWllLYLKN9vfCqZpz/iKu
         b/X4GAuASQ5wAm4EMolhPc8MpOCyI4voUbQBKrrXb5ZkDCPZb4ZABjj26VPoI5w31BmZ
         qrEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761602396; x=1762207196;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+s9wJrUVnAiARoihgzYhQW4ZH/+T9QovHaBTy4YJrjc=;
        b=U8hk6xzMzOidFPFaPqqWphV5CfMzLPGAsSsijm6MpUVequXGN9LaqB8RlFrKiK/aAw
         Wi/vA0PkgkMqO2J4lNAE93OZe8Eyf3+7Xb9OfDjhSp/OBNP4cJDjcGcE3hoJ7X1dnYaL
         hxp4rg9AK4j82ZhkhWND17qUMfwP41AJJSD8RdGe6Qa87fgcT/w4IjhIOwhcsaozKcpg
         p/3QJGeF2O51ePHP8jlVvd1htcsnjeCiWgHCW1ydk98KH0bmHvbuneDwFkGSv5RXbTeJ
         vd76bTqxmYp2APoYEoLPaaq83Mc8jsHMd6yAp5R5Y3UeyvyZS9dm84B8+5d1bWG6qRp7
         RbRQ==
X-Forwarded-Encrypted: i=1; AJvYcCW2HjWCOZGe8pwtBtthfXCoCfyLa96MhEtwddO6l0z1eWnunIMrJXgur3XZ/qWLrRiVWa4zrWl5jQfpyu8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAMULDVq+3UrpmdRt2mhxvc4FDfd9CsoHfL9f5inqhpEacB/4w
	tNngxhXiyVaKdtY4D38xs7mypomz6H03ioI6quhScOJJOTrVsk6SAQiePBG8no7uUPuAGV46u7z
	T/gcbCDQMAuQqa540j084r9rBCkBt5HHVmVMavKGudQ==
X-Gm-Gg: ASbGncseud4kZvrVoof4Ci+Jt91dmJyeBo6vbMpHMQweAeQcLWZNnr/4m/9cQPYU2mE
	3jYTEL3zy7Iv17ZLM5XHGJX+1rQ2PnirvROpAIATuxVyTp2jaqYdiclWdwe3yZTr7E2lBu0e3CA
	ayh6mGwGaMqFRZaPYEKeb8Nh01t3FWmcbDC6Szvla5y6mNpf+dQaPr0Dod5DY+XQxmcPbYT1l5G
	7dOBZzG0UHG3pVQy1gyhI3rCJZH/TqP9lup1VohIrDgs2G9FtogWSwiFT5YOurrF9TF/9Y=
X-Google-Smtp-Source: AGHT+IGENMuTPrZutUQ46wuswD5BGa1TjRpeG2e88psXFvOk1H1653TvwH72RHt6gkUrwbtJPBtV0+X773X1GDUqzwQ=
X-Received: by 2002:a05:6512:2349:b0:591:ca21:e985 with SMTP id
 2adb3069b0e04-5930e9dc52bmr571986e87.43.1761602396255; Mon, 27 Oct 2025
 14:59:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251014153040.3783896-1-robh@kernel.org>
In-Reply-To: <20251014153040.3783896-1-robh@kernel.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 27 Oct 2025 22:59:45 +0100
X-Gm-Features: AWmQ_bnaFR_aOmEFaodrc7AgItv72GvXAJNlQaZ0Wjyw4FDq1FooRjnsolDKmfs
Message-ID: <CACRpkdbiJKy2KrCO2wETQzLAkFate4miWNJ2Ed=a=jzS07wqsQ@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: arm: Convert Marvell AP80x System Controller
 to DT schema
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Gregory Clement <gregory.clement@bootlin.com>, 
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Miquel Raynal <miquel.raynal@bootlin.com>, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 14, 2025 at 5:30=E2=80=AFPM Rob Herring (Arm) <robh@kernel.org>=
 wrote:

> Convert the Marvell AP80x System Controller binding to DT schema format.
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

