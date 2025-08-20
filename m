Return-Path: <linux-kernel+bounces-777082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D3672B2D4D4
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 09:27:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 073735A48EC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 07:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D30962D661C;
	Wed, 20 Aug 2025 07:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W1rhmHN/"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB4FB2D4800
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 07:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755674809; cv=none; b=PnXhzUC4gwC6Ne60+M5Oa6RlhYYorFAKP0bs2sYuLduK3DnWTsnusLrlPxrpUZ248beh8vkJjGzzftmriT25evLpBWyEqou2aYOxo2CmWxKU9GSueuk+t0h+6pcu0oT2f9QpzvFYtvh7HxmOIyjJM5L+CC4a0tonnNf8JhoaQqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755674809; c=relaxed/simple;
	bh=ZuX2HRuY540gLLn3OBzHXp4J6+mRpc3xLSPypfFFPPU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D8Rz8PHeoiBpZyVYyxxoJHQfsIZLov/BTNbCZ2vEtO3O7rw47QeGj0rI2x2uE7Igq51sSochItH6bzACGfbzcDZmo7aVk8zNpRKdPEcqgIis5AEFtXxocfxqooxHquBK4gFPYz8T9gcwbk3d5UZ7V5S1cJ0zF0djRkzhbfyas3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=W1rhmHN/; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-333f8f0965dso51905781fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 00:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755674806; x=1756279606; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZuX2HRuY540gLLn3OBzHXp4J6+mRpc3xLSPypfFFPPU=;
        b=W1rhmHN/EfUEv3Oh4CjZm2N3JxzCZz3VHoZQsUaJ76sEHeNb5EyB/i2Y5Y3v5XVb4w
         ubBbvbF7IS9oDyQ+dV1Mvqws7yz8vgalMEL6ZS5x+ieo4wlYNPJu9aLNOKLGJ/uiU0Ce
         N9HaIQl1B02sd7KXfpgCpU0w6MnWI5AfjTVgqd9kKf+BuSNyHkDsNnI3C5Cv0iN8pvq6
         XaA5dUnmzTFeqZmYcSnONBaVjexY9ksXWXQIWleXrWOBL1fSuAQV/PcB+2pHreBXwhD2
         fwLIIoSqW1aMk1FmQUOgpnxvtLrFb7q1y4PluKVkUCBiVG/LuGvG9yA3op7DsC6uN+Oa
         SxdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755674806; x=1756279606;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZuX2HRuY540gLLn3OBzHXp4J6+mRpc3xLSPypfFFPPU=;
        b=MT1oNR6++a1JZbqqlT4W89Vw4naA0E/940Pc/L/i2n2hX1rMTVZL9YJPrUU/1PxIgB
         xATRYfbrf9ud97oNcHI+4L/2QjjLEf4cV4iyF/sspzKa+OO+Qc9NftvmHCftjYTWhHBF
         CjQb34ieP0fu+3rEaceSLQ3Y8ug20pLM91LEVI3lbakuqTa+H4brgkdNmeu+uaQx9tyv
         iERTT6TW8sfr9pXCJc4Lj96keNFEbjdBrhoqf25CQhVVOzN8QJhsyHexkrcGLPdxq4lS
         WJ7GHZ3KMPKYr3OmbuzOzkdKGFcZFGI6bGxl36aZOWAiM5vQ8ifdzg5WD6E3gyoIM814
         2iQA==
X-Forwarded-Encrypted: i=1; AJvYcCUf+xH33ndjCNM2tBWS1sRYMI7+HjXXjrF0ashOhOGftz1kqA8mVPguIPpXHGBq1g6MS5el+9MjFY4HyAc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuPlHxJWmfCkofe3q12vXj/G3TnVaXTrGs4B7CyvUhOBkFAZhU
	ilBuyGQ5SWEyPbBiOxfFZIz7Fa29pMFaVrtnXW1WtUrndyWDloDDK7a4Wfqh7B0O9LTU8umKT4D
	QHSlnVLA6k3Vxwak1N80lrCVot1rndmWN80YaNioLQA==
X-Gm-Gg: ASbGnctPzLTxU7AOPbMbL7YnmTdmAbq2EPVYcvV8baGgaAnyZ3fub3M+OjPb4kxQqve
	LfDdffpuU4fcJ6Xpx41FqLSXV+m/BwJx5jCJWnznLFUQa6g8ONNkQylWTDCzoME4ruVIAjQb02c
	Pdwd3ITx5z4+irkYOLU6qyonP4yVP+Lz6AUcp5TERoNiYYO6H3E1XOIgRxFfFOm5EvnmWwK+evM
	D3Oni9XOs0V
X-Google-Smtp-Source: AGHT+IFkIVL0QsIdOZQlW0D+lgAA1nsGZknVFkVpqjaB4S1VwEZ4JXZCYItH3d8xt7tCiiSuJNsOnXUlgb3FzUcPr1E=
X-Received: by 2002:a2e:be22:0:b0:332:2405:4d13 with SMTP id
 38308e7fff4ca-3353bea0a8fmr5933501fa.39.1755674805791; Wed, 20 Aug 2025
 00:26:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250818103931.1100084-1-richard@nod.at>
In-Reply-To: <20250818103931.1100084-1-richard@nod.at>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 20 Aug 2025 09:26:34 +0200
X-Gm-Features: Ac12FXzmS-9yGVF-QG0jps5D9FFgyHp9dtJtJ14yfzuuesjlk_IGoKkXWSgMngU
Message-ID: <CACRpkdbwUU5TmeVhcSAZ_ZaFa5nGVtyFBjNXBwNMC5y38heELA@mail.gmail.com>
Subject: Re: [PATCH] ARM: ftrace: Implement HAVE_FUNCTION_GRAPH_FREGS
To: Richard Weinberger <richard@nod.at>
Cc: linux@armlinux.org.uk, rostedt@goodmis.org, mhiramat@kernel.org, 
	mark.rutland@arm.com, ardb@kernel.org, ebiggers@kernel.org, nathan@kernel.org, 
	dave@vasilevsky.ca, ruanjinjie@huawei.com, liuyuntao12@huawei.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, Donglin Peng <pengdonglin@sangfor.com.cn>
Content-Type: text/plain; charset="UTF-8"

Unsolicited thread intervention:

Richard if you use ftrace on ARM a lot, have you looked into
patchable function entry as described by Mark Rutland for
ARM64 in this talk?
https://www.youtube.com/watch?v=p9cqUTF4I0w
(Described at 19:12 into the talk.)

I think it would be neat if we could do this on ARM32 as well
but I do not know how hard it would be.

Yours,
Linus Walleij

