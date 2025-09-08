Return-Path: <linux-kernel+bounces-805852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2AAAB48E57
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 14:57:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5BDC87A1BE9
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 12:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB566305948;
	Mon,  8 Sep 2025 12:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xdGfxyrL"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF5B3F9FB
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 12:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757336214; cv=none; b=Ca26eHzz+Ifcw98WdMLxRlLXwO8t97k9e2SEPiICewG9PbpT4VjgkCJ1F11ww/CRgvQkTsqnTvhW3HQ6tQKAl2OaV4xBc+3spsP8GP09Ww7MCJroUXg5yVz5ByuDWzn/T5veT/QBErue8a5m519SMzdBVN6QI8Fg05PppNTwKRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757336214; c=relaxed/simple;
	bh=i9NEs8V73/3LlyodLKStIRGRG21l4ViD+gJckmHEMhU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J7YQGQfb8hPwTNPhp8MRC6Kncp5qcKjNs1nzwxgcflW27FYwngnOy4e8fPt8MciaC8OKFda/DZnmbG+1XySOu5G3I4egJkhjKL3avo8a8pw4w+d3CC9HjeWB4sAu/yxpzn/lrJS5dZ7vwcKLOOQlngeyDxQpD/SLJut7d5ZZGCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xdGfxyrL; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-336b88c5362so39508881fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 05:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757336211; x=1757941011; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i9NEs8V73/3LlyodLKStIRGRG21l4ViD+gJckmHEMhU=;
        b=xdGfxyrLeHAMO3z7zd0IRWxxO7G2ximE/EoZc3i3KhsEDt5xjzy4pII/exmEbaMo/a
         Fcu8BXKB5vOv8xzlpFoIK4yA5efDEKRDV2YJbzOQM8HgQdtupq2vhIzgP10qRkIKc++o
         lTL9tvpgM8jMZGYuQiTYLrx17XyuaXZ51bNK61vLul7JtHq/I5FdUVuXg/pgpDvRG4KN
         ILPPfFaeurch6yEJN6qFGOtcwg8uD9pKUeh3keEW62knWkj4S/qKbCVpwlKEFO10ywdX
         Ipp7THhob7GZzDXa0woyQc+EwqrnhvoJMZmdJX4ceAog8b0W81BHSEs4cOb10Q79QljR
         I5sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757336211; x=1757941011;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i9NEs8V73/3LlyodLKStIRGRG21l4ViD+gJckmHEMhU=;
        b=v4PmJKSNQk+flwKGEK7N9ZL73q+ZuRWl2QNOnjATG7/m338RFHePX1IFFj19IYZzS+
         vAikHIdyGGh04nCvrsArS/qiLrsJEX6mlzM5mX9wAlh34BQGCHAPs0FfSU9eRPZYnUVa
         AoypYMAtsQiZ9mz+SZpzjPqyBgH+enGt/+sawOXdHm8kqZlPtYLJ24GjGXkRhvaNlq/k
         FEyEogq1kUfYeny5ZCUIlGuApAbY0DLbH+uNqeV/WlG15MRIRuZsNtImiposrxYA8p3p
         OyePfG7LtMiPeRYAeQhIGusAw4gLw3gxDp/w9jbpQWhPErzjr+YVl32kn+Is3vNhAaYD
         blKw==
X-Forwarded-Encrypted: i=1; AJvYcCX4AY1keST60MGJOTYxI4vghftbhuwdH07ZjnJNrz1SNdtIXZqvaF+IWMhDuUBjNOUFiGaJQ+E69RkqDc4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6Jeg1uY9NNKJzRH7nDUd23feb7DgTDjPSrPr65N28/DFMjqG/
	mJNtT3oHO1P+LTVoNeN/vhbaTvlYhaIMpL0gNnr7YMtG+vFzdNpz9YI9vPNxVZqzhDG7SNySjJa
	iZE08ZVFd1rAxPdTX008VJKXNQYjFvcqhU2vc30r+Bw==
X-Gm-Gg: ASbGncsiipRD3hKO3LFzHZZCvwSU26awHN/FNTtl4xpknfGBkM/gEbuUvJ1V4MavigB
	znUty7azDKiwSX+2TS0Lwc5rIOoIzCw4fM28it/wJFquVfBFUCQsQ2r6ELApWJyh8QeT7iOPi2H
	jC0o4OA1SGjiPXmMiTVBsV14qAzvtrer1+Xjhk7H97LSG7oT8rU993yL4Zi5ae69uSKQL3AcPaB
	un9457GUjyCYMRuFgpJpqot+WsM
X-Google-Smtp-Source: AGHT+IEJ7fijUeRwcBqhdVkGDGPkBaqhhVLbChjEuCa3TFGud0bMeF8EqC3neCfnzC7X5VYOVF0X6+vHRwRYjqQlljM=
X-Received: by 2002:a05:651c:1546:b0:336:c925:550a with SMTP id
 38308e7fff4ca-33b4fe4ac95mr22086341fa.7.1757336210631; Mon, 08 Sep 2025
 05:56:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250905-v6_tlmm-v6-0-1720e5080415@oss.qualcomm.com>
In-Reply-To: <20250905-v6_tlmm-v6-0-1720e5080415@oss.qualcomm.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 8 Sep 2025 14:56:39 +0200
X-Gm-Features: Ac12FXxW5YwGL17gaiHO7OUXNyNZGzF4JRK0vQggGezgngIJlttln-n3I4WN2X4
Message-ID: <CACRpkdZsBGejSXT0D69pvwJn8smS8BGDVp_BNaa7KhrHhUrYyg@mail.gmail.com>
Subject: Re: [PATCH v6 0/2] pinctrl: qcom: Introduce Pinctrl for Glymur
To: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	rajendra.nayak@oss.qualcomm.com, 
	Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org, 
	linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 5, 2025 at 5:11=E2=80=AFPM Pankaj Patil
<pankaj.patil@oss.qualcomm.com> wrote:

> Introduce Top Level Mode Multiplexer dt-binding and driver for
> Qualcomm's next gen compute SoC - Glymur.
> Device tree changes aren't part of this series and will be posted
> separately after the official announcement of the Glymur SoC

Patches applied!

Yours,
Linus Walleij

