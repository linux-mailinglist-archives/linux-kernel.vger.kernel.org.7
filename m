Return-Path: <linux-kernel+bounces-866997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C79E6C014A8
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 15:15:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2B1818C889C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 13:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17014309DA4;
	Thu, 23 Oct 2025 13:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="v/8+Ah+E"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F2B02253A1
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 13:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761225324; cv=none; b=Q2ZnEUPRz3jVKpCtuW+9pMK5OjUetCVGchr0hhuWM4zAqKeSy+S7MtVvGTfOnT7aAO2SBpkXvJ7xXZBEEePVzWc5VV25PQxsARqpmII1NjpgT8IZRdP3EvKy3z9+DgfO8IJ6a0kNf2RGIagQe8Wu9nzkKOFSsoSBpMIdkWSe/UY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761225324; c=relaxed/simple;
	bh=z76NHbYS0l11eBUt7HKnQi+UP7NNGUE+0BdLSRPd0MQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JbHh73qnws3jXN1stukCibvCqs2qtQzbnB4lhplUbNLJ0zSIQYa6/vMlRetWeDWCABK80E2Z1tUAv+z5tgGtoaCuO4wQP7hvz7oU7+jDYz+jIFurHb9a2j8GxcX6coTQH3rI7hXx5+/aJFvNX6u1d6zCxpG3OFrqoy5Je0xnrMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=v/8+Ah+E; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-375eff817a3so9508171fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 06:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761225320; x=1761830120; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z76NHbYS0l11eBUt7HKnQi+UP7NNGUE+0BdLSRPd0MQ=;
        b=v/8+Ah+E94O993/x9K1KeDjV8MYEBky1QF2AsgHqGiukg1O6EShOphrzgIigfER504
         VFaiVGBJMDYSDNBnixNVCUDIRpGbzvy3uz+CmBMLj9HvMYg+R4wK0l5YRACz18wxq66i
         eHjWLMA9wqWhI64MNtWu89JOY+LZVy1ptiMHcc+1hIn6nQ2rfMso8t4bMmNxHQWWM6rB
         Dk+dBBypmHIr7G+c6sZrCEBYcPV6mIQ8Q7eEj47dsR2vD1H9QAwteAGmsosMqnH53WOg
         mH5zBgEKcKvBhhqwigHdpLk6bGrYEsokEEcqEjGEL3sHnTdJeGxyu9ocjstIgx5KIXJF
         CEJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761225320; x=1761830120;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z76NHbYS0l11eBUt7HKnQi+UP7NNGUE+0BdLSRPd0MQ=;
        b=lWNrgRjLj9pJhoaxohRsa5PmwHpynHWN/qnEQwGg9jFsHlYrHaf0ImX1ys9mNfQiZy
         MQzFIvOu23l3oj7UbL54DsCrP6WhdNxawhUxQ01okTOcmXiMSE3+ex2em+RGHOhx3ljy
         QsdjPvmb6gCubHeu5PF1pDveis4BmjHCxQ8br3dZLuBr8kP/TEey/E1e8bI/x86O/pqc
         7xfWMw53gx9bzh8zPb4iwQVNeYnw4JRMsUfyN+bz/UmvvtGNbusGautqXVnt+PbRLxWb
         FtfGW030L6hquSmLYQkr1BHIsKT/D96szWT67YVEG5OgfxmLx0NPX5Cgt6pTmrQAv0WY
         0dsw==
X-Forwarded-Encrypted: i=1; AJvYcCXHXwj7kt+pSpm0KBhnPyEXP1KAYI4c2IXz51z/sTqSlfyEXs47sjBeNtfHnzOsDKMXH7JnXe8SufvMqqE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0L6KV3RFmqTUKlKPQVTmnCIi1W4c9FZntoA1p46I9+hNA7teF
	SIUy8cmqnpTnB+VVOiH17HNV8NvXi0p/Sc9iT06WYpkE93XBEj8DKZBZxgBKi9It5fBeZlMmnE+
	05+EcTyLqZmyoUrqSBBVf20oZymhG+biKirUAA93uag==
X-Gm-Gg: ASbGncsP/ov+BlUeUCexFElJxTvHegRb6PNA68yeu5CzKimiP+jO7l3l4nuTulT9M5i
	zkEjpOR6/DxEWS3thbEtJz1L9c3vvKTThkoD4CcE52eQMBkltfFnqtin5sU3pgOfCLD6R4jmnkj
	WpM9/pq7K+DhU9DDHPruFBBtDrtutQBNPAhGVcu2mmFbeeIcKI0/TfkfPVrc+rKBry2SLfnCvS+
	ekN0PsGNlrNAlBoNHIG4Kew8ynwI46ftJRuTpjxhxh3cIoggwT/oGz5cFWSw3a3Ql0Tsxw8X+xD
	wGGgkg==
X-Google-Smtp-Source: AGHT+IG/ZAd7RUnoCK6/TWMMjPJ1VQjmx8Caf3SATBmY9x3/PxhBlmEnwJGz57NSvFmOq7fh2pz0uSBe0AV0o43DOpw=
X-Received: by 2002:a2e:a906:0:b0:378:d424:d3d0 with SMTP id
 38308e7fff4ca-378d424e478mr9052641fa.8.1761225320551; Thu, 23 Oct 2025
 06:15:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022133425.61988-3-krzysztof.kozlowski@linaro.org> <20251022133425.61988-4-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20251022133425.61988-4-krzysztof.kozlowski@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 23 Oct 2025 15:15:09 +0200
X-Gm-Features: AS18NWB6N45TxgNnccz0wGQlLC0_F0Qi57GxnfcGIPV2g0I0ThiCPIszr8ydkDg
Message-ID: <CACRpkdZ8rcWy9SvNuh+wq0Yz+byYMPkK6ZMkqjd8YW3SKKBzug@mail.gmail.com>
Subject: Re: [PATCH 2/2] dt-bindings: pinctrl: toshiba,visconti: Drop
 redundant functions type
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, 
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>, 
	Punit Agrawal <punit1.agrawal@toshiba.co.jp>, linux-gpio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 22, 2025 at 3:34=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:

> Referenced pinmux-node.yaml schema already defines type for "functions"
> so $ref is redundant.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Patch applied for next.

Yours,
Linus Walleij

