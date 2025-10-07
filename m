Return-Path: <linux-kernel+bounces-844733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4117ABC29DB
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 22:20:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0CAA04E328F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 20:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 649BC23BD1F;
	Tue,  7 Oct 2025 20:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sMwxbj+0"
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B87C1DE4C2
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 20:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759868407; cv=none; b=fXtAzVmGS2DzR5J68DUdgNrsU0p0zDX7DfkB0tIddYB3QFjvmyBCFEkH+APG8yVkmv98O2pkJw1HecxOHBf4krvzbjNtolbhDQ1bddfw6DZL1BG6bYMJf7bOH5HDLeuZZ1Nnws7NOMh3zXfqQYCasNzl2mv6ExJVRmnjHKNJn40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759868407; c=relaxed/simple;
	bh=VOJGm4xHo9yLpjNqGa0Z0pDqyLUjWX3aXbAIUsOlMvA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lUa7NdMQgqBRh6s+igRsmEw7QImfZ0rnTEvHsiwiG7T2e5zFT9jYIYx/iqOOGlFKKFDzmBbDETIQshAspPO741eS6vEOSr4pFOuSlCbf8LtcdTlxGLoFCswV1YIpkFojr6elo/d31DK+NBcTsJGgpG3l/MTllitgKb3SVYFNsXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sMwxbj+0; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-43f50c2765dso3666270b6e.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 13:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759868405; x=1760473205; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VOJGm4xHo9yLpjNqGa0Z0pDqyLUjWX3aXbAIUsOlMvA=;
        b=sMwxbj+0yZEIWst+fxNSOKU16i7Hi2P1EAHSYTXd/hMaBD8hy/mKcLKjyDrjssPHRk
         g1xAssGwgV37uT+qwXZ5ursK5Q3KCnpkLrqZ94JAmlKQKge/Q0SdgWEEkCd8xklTSBwG
         YkwXFFITj9jR68nMy+Pv0ZkjvrzBmsJ0H49t6Hb+ZxVWbTp4SX8n5G6XFI1XADB5QLuO
         9mhktUWBZvmnDRpyJu32/tEamJ6meEdhBNVCErOmO8A2zeB1V/z0PrMCAy32K2H9KLES
         Nb/fljhmshuSnQN9JpzVaVCkewqm/2iAO9qXnuLoQLHn/frCehIb7UiIe5In0Zh57NOY
         9KyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759868405; x=1760473205;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VOJGm4xHo9yLpjNqGa0Z0pDqyLUjWX3aXbAIUsOlMvA=;
        b=lQBOowpDwc1uZf095fpNMg6A/h1wn+u/qT4zJhGisxk9u6MQOWdt1XVtgGdcVZl1A+
         gdsFA6/0Y/u5w0HHrZtmOjWocw4rz7H/297ostfgjmajzv1UzpjqmRPzoEEr3mwcbzcA
         ZsLoHL0JBxoQOV+9sK9swXF8FtKLJw/tRrPH8bUrc3u6CB/pvbKmbEo3uXTqRc3fLVj1
         Vu/FFc68J5+Ni1F9t8X1PGuGThrjXQH1ebxQZx7yI5ZMLvXILyFjHQWES9tKW5vpCIzG
         9Nr5hh0TZyQqTOhw01omnNZVap3vV0FtMFCbxTNS4TAN0u963xTbzYqGo8vqmEviLSyl
         LFfA==
X-Forwarded-Encrypted: i=1; AJvYcCUJpsv09QDrijNtA5zTedrUKcfHafnSq0NJw+Q7dYvE2Gtj+fJjmOJniwmX40SesjEZrPnUpNfpmQO6myU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7i7Y8C8f/GywexC1Ik0AhECnRQULaYKbJG8udtk7LyI6IlzMh
	xAWWJVQ6LwVIa6OTnijfi7TUEwiz+7JxcG2NLElW/EqSXon8y6CLxS+T9PjEuzb07Zk9OV2b8Gr
	ga7FdfaOulXOlpPdKMrjLv7X/VBYZ04T+WLhMkoldtA==
X-Gm-Gg: ASbGncsl3oEjxQyYlhdcYU9Q0rriWfpxZItBY+v967gbB36pQpyKRCMu0vxEztjkdcn
	6ZEiK/h6VoQ9h7QRP9YOgakVRbKG/E/ShS0vITtYeu5vGClOsAZw7XYnlal7uPe7ai20zgUYrJ0
	U9K+U3vo/bemW3tF0hdmJ0p+qYJGzvoDOgsB1x5gfh6LMlwTq5hdvJs/eh5Pqrarz9G5t8pjYfy
	se+igPjrEJZzTehVxdHQCjxsEc3zmDpZbkJa+pOThKNey5r
X-Google-Smtp-Source: AGHT+IEHI8U1dVlqnhrsS6fP0FmSa3idf/Em/3CBdgaLIh3/qrBErYExCYpSsQBQQgzXfSMxAukwo27BHqZsQjbeUds=
X-Received: by 2002:a05:6808:18a7:b0:43f:5b28:f0a6 with SMTP id
 5614622812f47-4417b2c48f6mr450890b6e.1.1759868405185; Tue, 07 Oct 2025
 13:20:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251007-power-domains-dt-bindings-usb-samsung-exynos-dwc3-v1-1-b63bacad2b42@linaro.org>
In-Reply-To: <20251007-power-domains-dt-bindings-usb-samsung-exynos-dwc3-v1-1-b63bacad2b42@linaro.org>
From: Peter Griffin <peter.griffin@linaro.org>
Date: Tue, 7 Oct 2025 21:19:54 +0100
X-Gm-Features: AS18NWB4avL22wQ3_NUeMTQbUpbAXczc7-BwaaCDEfZe2LaYa7fnIVbjvyZG6LA
Message-ID: <CADrjBPqeucFJw5kH7YKK=PEOOYFJkQbmZ_CORu62FoFwqySsTg@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: usb: samsung,exynos-dwc3: add power-domains
To: =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Alim Akhtar <alim.akhtar@samsung.com>, Tudor Ambarus <tudor.ambarus@linaro.org>, 
	Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
	Krzysztof Kozlowski <krzk@kernel.org>, linux-usb@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 7 Oct 2025 at 16:55, Andr=C3=A9 Draszik <andre.draszik@linaro.org> =
wrote:
>
> The DWC3 can be part of a power domain, so we need to allow the
> relevant property 'power-domains'.
>
> Signed-off-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>
> ---

Reviewed-by: Peter Griffin <peter.griffin@linaro.org>

