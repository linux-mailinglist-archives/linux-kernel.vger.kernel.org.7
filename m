Return-Path: <linux-kernel+bounces-827944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E49F5B93818
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 00:45:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAA2819048CB
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 22:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD6F2261388;
	Mon, 22 Sep 2025 22:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Swqoiavj"
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A09621548C
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 22:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758581135; cv=none; b=t/hE/poBfsqmyLDzdRAzwTZaSeDYWJnW1p7swyxOAjDYwDRpolgIZRSff+opIx4XFcYfa+ZlwVzR6Jdu1eo9RLQakF+boVmEHIJbTTcjpcv+Yr98kxLp3WpWsTBqbE4tQfN6ujjftgGTSKU+uojoggZQRmrgnp5js7VdOdDL2kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758581135; c=relaxed/simple;
	bh=81+xe4iAGauiki031P2C3Xr5MVG+bpBbO/KitipPrW8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QGM1EKSnVuYuuKU/9tbW74D+HNBtJuH7SmMeQ6AxM0xV8XXJoV70DySLkDByaHdTgVjlwW3GUGxVoNrqCt4t8FgAdW+rJXYaThhZQOmuKnzoD2IeYBa/CgFxMkqxlRX7zzqVe2umQk54pDnqDL2VJ0NlT/I3wUG+o7xCcSfpTXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=google.com; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Swqoiavj; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4bb7209ec97so111791cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 15:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1758581132; x=1759185932; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=I59lx++Tx+ZboAPSBm8Z9Aq9d7rn9DeuhAfPTw4RUyo=;
        b=Swqoiavj7CGyxXXWYVq1WI+q38UDYsbnx1fwzOPQTNoaf4Lm+eIF3ql5Ov68QAR+4J
         hsAJQhwTiespSjeQvhIKOX1i1gEvjnO4lQNLoTHr7wxqROFUTOpUhoW6qID63+dc6lqC
         gmvLebTGv/uYkSshFqXUvHeZAX9Tu5jbyjBZU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758581132; x=1759185932;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I59lx++Tx+ZboAPSBm8Z9Aq9d7rn9DeuhAfPTw4RUyo=;
        b=p25NYXz7M6QoK7WSfedl7Zws/zBb97dxsXxOCqgZSoj1uRUtNZti2biU2MUElIolIa
         q8+P6AkdDf+AiqTfUShzdF9QdR3Pd5+Xm5Igf9PdCnKByh6Mm2kdtIpa6C41jkx6Dr0t
         /bA1hJrZvcKhdU7rcc9yOlB8caXzlhd6EjcoSo6gysiBaN1rv8ot8oEGY0+68+XKwD8W
         IGPFm9AXOvxUYH7q/MZACbirgNKTfZqdbOgUMyb9gE/rbClLvy9/880r20/y82KDuyoY
         hoGlCZt1UI1SsV6yhy9KsgEbEc0ACQlLUIivN6WQTrOu3JY13IgNZ0F6xLrpKV4IlLiG
         N7Pw==
X-Forwarded-Encrypted: i=1; AJvYcCWg/ngtB6Zj5bTuC2dwjIl7mutWJ9L6pG1gSca0SGh17ZMwCcM77cjbtZarFQ/tILLtW93nDdYkooNj4To=@vger.kernel.org
X-Gm-Message-State: AOJu0YxilHaU7hJO3ceHfH3TFEUVe0FvVP+nNzkRPXU1Zq9oEN/oeAdg
	tzaqHNLpfWydoRGbkIlPkN7m9sKYSyB7E2Y8lJkzxipYYs1goVTO8Fzjm41ECpjSE1qV5b9GNFW
	vITWJRZZmb8sGveFFfD2I73NlrgZjNGVB/KeHpxyK
X-Gm-Gg: ASbGncvYcJ5rJ0tlz0WGVPPDTGRJUObI1boryiLmspokyIeOgVxdDg5YKEtzFI9oEcM
	bccgSHh29RgbpfBbaS8Y0r3IpXGzBApUt/uBKi/u/0Q1J1d2U184pHftk17U5P0f7wU44YFmqHr
	8/eZ2Z26NfaqZceFXBJk8m6ksVGxIk49XVbu0jbW7Z6oz0pD4GSLtdzigaDuxUwC46w7eq60cwQ
	hBP
X-Google-Smtp-Source: AGHT+IEEHjj+wsiT1bNCpHBT5Mi+r8GATT0+bhUw8kMDnXciBxiK/CjOVLMPqzXvLsmITsSiS2BY9rY1zKy2QnMzLjo=
X-Received: by 2002:ac8:5903:0:b0:4cf:dc5c:8c76 with SMTP id
 d75a77b69052e-4d36ab2866fmr1207671cf.11.1758581132096; Mon, 22 Sep 2025
 15:45:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250922-b4-ddr-bindings-v7-0-b3dd20e54db6@gmail.com> <20250922-b4-ddr-bindings-v7-1-b3dd20e54db6@gmail.com>
In-Reply-To: <20250922-b4-ddr-bindings-v7-1-b3dd20e54db6@gmail.com>
From: Julius Werner <jwerner@chromium.org>
Date: Mon, 22 Sep 2025 15:45:19 -0700
X-Gm-Features: AS18NWDpJeoFHhQc83aqhmhoSwFRisU770ZW4iy7Do1FLF-ntGplzcw3QSX4Lyg
Message-ID: <CAODwPW_oDTh9FdnLq7w2FPQv68ReAUUpssqEktUH5zhewbfcxg@mail.gmail.com>
Subject: Re: [PATCH v7 1/7] dt-bindings: memory: factorise LPDDR props into
 SDRAM props
To: =?UTF-8?Q?Cl=C3=A9ment_Le_Goffic?= <legoffic.clement@gmail.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Julius Werner <jwerner@chromium.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, 
	=?UTF-8?Q?Cl=C3=A9ment_Le_Goffic?= <clement.legoffic@foss.st.com>
Content-Type: text/plain; charset="UTF-8"

> +      lpddrX,YY,ZZZZ or ddrX-YYYY,AAAA...,ZZ where X, Y, and Z are in lower

It looks like you accidentally changed `lpddrX-YY,ZZZZ` to `lpddrX,YY,ZZZZ`?

