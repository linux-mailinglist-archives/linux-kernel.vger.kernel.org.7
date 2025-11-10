Return-Path: <linux-kernel+bounces-894289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A6F4C49AFB
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 00:02:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41B523A8C34
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 23:02:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B94D2F5A10;
	Mon, 10 Nov 2025 23:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Hn5LVw6v"
Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FFE21B0413
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 23:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762815755; cv=none; b=ZTP6ggpjUMs0W3Q7u+YvB146cJZUt4sFzls+xQ26GkaZK4nqFQ25seTGmlKX7WUGWwKuYTK8mLwkcj/0icMqXbsRFdU0gGV831NXDRXVFdDWv5RsP2bNf7PvBz0QPoq4f/nsgXmkAfHJ5PKhZnB5FIgqDwrSYGVFCeiztV7Xypg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762815755; c=relaxed/simple;
	bh=K5qle7VxOWU8iKUzLYgzn6NH9G6XRkWvpzlofstrVjo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=obKybfho2KQMFyxaTmeh7qjLN72yPCUT13wACj/uUCNm85/ESsul5qnZyR03sVtYR8Rj0cHuyVfnGJEV7V1CLXjUPSvBvMCtGx/6ndxV0dHHwrNPHYPY3Ouo0dfbuFslp2w2t1F7uDJKRdu5UUZ+tYJjOiXGVcgim+ZrkAGU4pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Hn5LVw6v; arc=none smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-640f88b8613so149957d50.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 15:02:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762815752; x=1763420552; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K5qle7VxOWU8iKUzLYgzn6NH9G6XRkWvpzlofstrVjo=;
        b=Hn5LVw6vU2b/gtQu8sSJwEAuJHz8XxPxp/nG0PFaMwie324+nH4/qPvzvhV/wNELKx
         KNNhKCuy3rdh9NEf7Y8fXjjICVh27va4T3MAaCGYR8kz8Gmoil23/u2W7JPX4lrhhO89
         flCI6hc862fvJuRmenUsFGSE1nFXCdwRIomQjz4J1hN/xF415CKoPOIQygAijXFwmMmF
         5KX7jpsTxjhlEuFzTmrrYPLkWiB9KyqpYA+QhJ3aXlkVmRPiFB1AlCP/1ivCSRIyomrz
         naEZLbv0IbaSlgW0SF8FBrojkw6+wGmiSuqQsp+mZAzwaYvP4Rl+hkGZ+akrS0BpEu5a
         vl+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762815752; x=1763420552;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=K5qle7VxOWU8iKUzLYgzn6NH9G6XRkWvpzlofstrVjo=;
        b=Reiq9MLQa/zPZl6/6n0MQpiuA80Qb5FpRFQxJ67zq5dDVtp/KW3Lg7KVweHsk4st1C
         Fc1wVpX5IOZDf+gai/84/Ppjbo3cjh9ggTw7XYGZqBvLdnvquHcyPtiNtSknzzhd1nrn
         F0n5WUPp0UG4CD5zuqJl/K1v2+YBQptrl9k66zzvQUs8HK1tOfYTQirpO2uTtUw7gejd
         hnLGNIIQtpEJ94gL8QsK/i2mwUmOAg4I2sBbf3/HeZ+LUkjMcCLHF55XvKn9AxJJmCAH
         08uzQTCs8bYd0lrUo50ieB70G426BYoKr8oZNNaLnhaSrn3BbJcO+Ez2gwl7ZMfQQVTf
         sl2A==
X-Forwarded-Encrypted: i=1; AJvYcCW3PBT5x+9XsX4/XERbEb5N7+Kw8ph+F7ak6f6W2UCqxAwh1cMFe5vMa5cQByC22JybyABxMMdkZZamhcQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUaop0bxwlhW2JWgc96s7UjomOx3OzJJ4LH4CMkNLz3axDw5Dq
	th2iZlCdg7sTnIlecch7xa0PUTttA6cr9wVwXDNx/ReuwtZV43h7/ZDFPq9c+Zk6Y1AnilqnpWK
	T5YU3Rme7pcx/AyMwWyrWL7FvKmWHIwb0jwwu4B5WUQ==
X-Gm-Gg: ASbGncuPFpaKJw0MCEYbqmeCCeuasdezlr9I7aljP7jMsp2MEsLjJcD8A31s+ERbbGt
	qoWgmSCxztmsQsXev2t2C7/1bXSsWF1y6YYvPnL/eHKbHxNUNCfil9166iDCiU7bOFLQgg6y2a5
	np51BUrLBVSfgr0leuY31T4mJJ5wehbHV1sE5gK1bUgwUBrKPIgyiZvBBeiJhx7/UIeWaqDMxYn
	IZaEc6CYlMWt2KX5V/RVEt6nOBYxiTvhzsDKaTqTOSsde+SyBJVRfjMyG2K
X-Google-Smtp-Source: AGHT+IH6NHwNRdzXaS+QmN+qfk8m2r/FZh8cnCLNpPmojXJfkBdWQ2u20ATg0QrVP2xgMhdnhTJVLjKCqz+f06cVvC8=
X-Received: by 2002:a05:690e:1508:b0:63f:b985:66b1 with SMTP id
 956f58d0204a3-640d443bb2fmr7893340d50.0.1762815752364; Mon, 10 Nov 2025
 15:02:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027132817.212534-1-linux@fw-web.de> <20251027132817.212534-2-linux@fw-web.de>
In-Reply-To: <20251027132817.212534-2-linux@fw-web.de>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 11 Nov 2025 00:01:40 +0100
X-Gm-Features: AWmQ_bl6gy_kvbbOxsO0c9yQS8V5cJB9oHDprLAgoRQJdA1aIm3YFAnru5uFW8g
Message-ID: <CACRpkdYwh69JsvUGoG=SrYTBtgUCFxTUV4Pxo9aAHuDyMqbBdg@mail.gmail.com>
Subject: Re: [PATCH v1 1/6] dt-bindings: pinctrl: mt7988: allow gpio-hogs
To: Frank Wunderlich <linux@fw-web.de>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Frank Wunderlich <frank-w@public-files.de>, Sean Wang <sean.wang@mediatek.com>, 
	Daniel Golle <daniel@makrotopia.org>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 27, 2025 at 2:28=E2=80=AFPM Frank Wunderlich <linux@fw-web.de> =
wrote:

> From: Frank Wunderlich <frank-w@public-files.de>
>
> Allow gpio-hogs in pinctrl node for switching pcie on Bananapi R4 Pro.
>
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>

This patch applied to the pin control tree!

Yours,
Linus Walleij

