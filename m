Return-Path: <linux-kernel+bounces-775681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 335FBB2C387
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 14:29:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEDE8188E528
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 12:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03C4230504E;
	Tue, 19 Aug 2025 12:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fM8ixJ6R"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5CD3305043
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 12:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755606177; cv=none; b=H28M+J+xw+iVl+Z95HwijkdScUWNAvmOhNSGxm7sj+j3QRUsR7Jsexc3+1+PfUn0Tl8rMawa3qUv0mIZNx2VRokcJP41SslNHZysLEO1ha0Urhh0ZqocuUd+8Rr4njuByjU0mnaxhhEhw2WxAGd0CdRMTA2m/KBnFRAjaHi+afY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755606177; c=relaxed/simple;
	bh=gw/jOwKQuYtz365HYvInA17YdqiK5qLhDO82IeRsFBE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F4ArWZJZeyMUpVfqOPNwfLUlR4ey8xFezKr//b9+RBxnS5FyevWfKVPi8t6JZaSbwnkvxrVXbHcuICxjNsq+42Ze+36nqv0EUtHP++LOYR8JzY6/gRVaczEWzVQzRzGc3XQIxjzFTGTmJ2JARVnyzOkEwUqhq7/YaKmfQLu5xQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fM8ixJ6R; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-333f8f2d6c2so43144711fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 05:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755606174; x=1756210974; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gw/jOwKQuYtz365HYvInA17YdqiK5qLhDO82IeRsFBE=;
        b=fM8ixJ6RQo60D4JPEtBo6KumlRlXnEzNb0KqaHra06JgB1I1tUBAKnIs3Yov9i6BV4
         Unh3rADN79v6mZXZq1OvojG8vsM2kYAVTIDsLwbZrwFatF1VtNJvlSToG1uSxrYElgJX
         Jr0soMUn73gRjzRYbxgIPIkBrDTiqkJixCYFXNOSGFGVEtUq3F/CC4tvBaVV+kwJWsQk
         VdJ+rqhn6tGoYASYmHucGq64+R7STHwLpwxcU4pzoRbCsWINp9gXB63IzQDuENLwFfA2
         A8fF1p5IhA3+JOrBgwQGIqQUIluoKOtAmY2EcCsuX9psAbCyC0wICYp6wlkN9AWyn27Q
         7+vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755606174; x=1756210974;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gw/jOwKQuYtz365HYvInA17YdqiK5qLhDO82IeRsFBE=;
        b=GaGeAtgygsbGj+xTY6JmaSkwd9twg9QuCdNF3/vGMPEhJiRm2ZFvx3S3QPqa71MN9z
         oeegwsciAY2OyZYbPR87giuUGoKnh/lpPtxCeTnR6DhI6bq/fBMtpX1xpGteB4oILCkF
         iTByxU8FDDuaMngThMdhMP88WEYb/No2EYko3KS9t5lmRPGYDeJoIpOBJeeLQm/vfC4H
         cDtIdKOQTaqJuzBW2jbNNULzOdkkhQm2NJL9YeQCNgcwneWPgZMAtNzc5neJCRhIIFvW
         I74dsuyhPjiTTYLdy+kByrrT95mEpkAdbDRq1o+mVNDWOfOeQPdauH37p6VYv3SIkygd
         D7kQ==
X-Forwarded-Encrypted: i=1; AJvYcCUqJodA6nM+TMV2RSc403Q2MgM6pg5HPd6XxpgNWezikZaqCzCHgHzMCIDl9xIA8mVgKsS9R0Kk90AZMvc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmT7jLcvLhw4K0uXFctVn47k7uIgChXMQfV1DmJRnSwsn9pNMB
	SatEhMBlYvdUq5V+0kLPlSPvKTbcbeGiKa0JsaIaYyLIyay0la8O3cddzl/CCgck8Sn0w8KI4sh
	Me9rbRwuBsdibmTDaMuX4XuP4M+jVp/nhKE2pL968bA==
X-Gm-Gg: ASbGnctPtRdPqYIRfl7hwNBOcVaOwCjp9wP3tz//y4RU5TJqdtsETY90jn5IKo7SWmc
	DkVbNbooR4TosnlZxYd36gFv9ytuI/RsgjNnZK9zu6es0H5y1qmpFdejnll6K6szB5aLmiu6Z9e
	bRYmTCA0PDt1XyHItwM0zsjhhbn45H1HN1SEzUl9fYleX766dGaqhbC7sTlqg0jGvhlZ9H6Su/f
	srje4vbEuaG
X-Google-Smtp-Source: AGHT+IGNH/KGoaBSyDp4h02tKapeKQZmf3kymXUsGq0Isjr/TRxPuFwtsDzGDorqqxv6Gg/sQbzuFVjxKVKE2P9+7Vw=
X-Received: by 2002:a2e:a98f:0:b0:32b:59d1:7ef3 with SMTP id
 38308e7fff4ca-33530737cadmr7048501fa.35.1755606173912; Tue, 19 Aug 2025
 05:22:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250815082118.586422-1-rongqianfeng@vivo.com> <20250815082118.586422-4-rongqianfeng@vivo.com>
In-Reply-To: <20250815082118.586422-4-rongqianfeng@vivo.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 19 Aug 2025 14:22:42 +0200
X-Gm-Features: Ac12FXwCXMFv3UHJtH3jQfAak79Kdy3rWEOtMWOBnQNnjLpEps8EvhN2w2SpjZ4
Message-ID: <CACRpkdbzQmhtpbYxnTtKBrxJk8d3-8U7rzkrncW-05-vKZTUaQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] spi: spl022: use min_t() to improve code
To: Qianfeng Rong <rongqianfeng@vivo.com>
Cc: Mark Brown <broonie@kernel.org>, 
	"moderated list:ARM PRIMECELL SSP PL022 SPI DRIVER" <linux-arm-kernel@lists.infradead.org>, 
	"open list:SPI SUBSYSTEM" <linux-spi@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 15, 2025 at 10:21=E2=80=AFAM Qianfeng Rong <rongqianfeng@vivo.c=
om> wrote:

> Use min_t() to reduce the code in setup_dma_scatter() and improve its
> readability.
>
> Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>

Clever!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

