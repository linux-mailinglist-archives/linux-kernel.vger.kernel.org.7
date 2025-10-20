Return-Path: <linux-kernel+bounces-861760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 70F52BF39D0
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 23:02:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 224854FEBD9
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 21:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBED533468D;
	Mon, 20 Oct 2025 20:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JAr70K18"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F2633437B
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 20:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760993828; cv=none; b=Bkcv6YATcxBcyy9ZaqiOAJKzol/7xiQYjXS1upd+Tl/vFZZcqoLyuAhuczSruaHAW2L4mreZVgGSPI1KR1Gi05OQy2FOp5IfjdPOeEdOWYQ0jcNMA+51I5j5Qg74UQ1eNB5nCmRWi5YXoOni8K73MLncA4LA1mgqf2lJjjzanqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760993828; c=relaxed/simple;
	bh=TZEYp0wwdbVO5FwvBARexBlR01VmAiUyIuBTdS4/y2k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rDE+7YTyA3nr7o94XtZtPaia6ppwV7AYMp2SnpN8705/s+xBuOeXf6iwWnvIoqmBMiR/xDB/FeyZtLhMIyoRCj31nd7lWdkb5zkBl/iVqDJpN1/mKeB/MGmV11YXgWntX6ai5O62qCKYbA9DMawjHHG1LFPnZOyNPIe4neDHEu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JAr70K18; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-36639c30bb7so42791741fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 13:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760993824; x=1761598624; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TZEYp0wwdbVO5FwvBARexBlR01VmAiUyIuBTdS4/y2k=;
        b=JAr70K18zwjf7rO1hWXsRM0w9OgHLcMrtjYGyQ/rJuw5uBRdcupcBz8l/ZsbCduJZV
         Yld/i8QwEtkkJXlgxWx6cQFZtP/q6DO8xzb6X8lDNqAHrgeklmdwiuHM8Us1sLz3KGPB
         h0/2+sYKbu1u/Ra6ig77wJtJ485rPzLXaEtnxW9AHgJGL2BPNN9AAJ+0qMCh5C2rboPH
         OWUrIChBLhyY8BwJZaYna4tqzmX6SGsaFSOPXGdFfWOfpiJJQE2NByd5bshgrH94PH8Y
         yXTYsKHvn6rGIJ0NlVr37EXCK6Blcsp/U4TWMtEIDEZgNUEBOVZg4/9MZ6q4kHSkAmtP
         qUmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760993824; x=1761598624;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TZEYp0wwdbVO5FwvBARexBlR01VmAiUyIuBTdS4/y2k=;
        b=qq+0E7Wlj9OvvJ0MHnQkjvhbnqAUWnG7rB7rAY+RPbSZwAYqmwpnDUIi48a9mchxoE
         yEy6kH2UoDhUQkXhKr1+VBIsHCnbi/rMFq5MUByAl1PK0HUFUUE4OaKKdnACfqHsQzpX
         ULwa44ozKyu87l6TCiOlj7BfF1quI9Ki+mL163QIHcixlPiqFYgEEjjIhd9ZpjQR2dNL
         RPsBXidImTva0GV627B2IcwdK4Lh2+4kKiQVslwoBORUk7XBBOVIIqadmN5X/qomIcNU
         6WJe1Pkh6FeDeQrAo5kkr+8X4MIZvOvCjqe1qZzwKN4GK56kKCc1xH7KiJ5pikkMfzIv
         hqSw==
X-Forwarded-Encrypted: i=1; AJvYcCXF4vSSH1UajrIDwY94paweelDTsGW8B+22q8wav3hbM7xt/at61eHTlbRBxbniRIg+jsKsDCm+tprPNvc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPrCTj/0f18fEwTIf5zqg3nafNbKPujq2vfimStOjZCrQJBYiM
	ooh9FpIB4hu45K4goJG2DRGTPvNqFcqnWcJQh85cxe7X5PK6K1Y+66OHf3R75WogbB5Hi+eRcGT
	f3R3h84RFXe3zBmh4pcaXOMQrpHOEYKQ0NQPp5cPCPQ==
X-Gm-Gg: ASbGnctLZ5kyYYQLSELlKLprLYunqG6fDVl6bzJBGtARMI7O5XHAzPLnTjdQbxW/7FO
	B/8xdsUpug8Pl+H8ZiSks9SwHYAYIa0onaIUrunaGKKeue/P5HX7svzw3r/YquTqf9OQNFZGzU0
	G3mwBXdPQVbfo4zXss4RZysVjasLY1JF6FK7dhC5yJxQ9Ty020xsdyFk6yxHDWbabFtTgHHCEJQ
	+vM5MFx7iTdWJrHLSwz3csyAA0uwQHRzOdwqCX8NoLAaNZxshHX0U1ixBtS0p54Qf5ELfs=
X-Google-Smtp-Source: AGHT+IHW/3fH8VK8UvrQO2N1p8h2n0H3HlH4UW/gOsTzZ7h7xtAZlPnMvG79X4+aymc2cjxzZ7sc3DkXHSmcaHjBQ1s=
X-Received: by 2002:a2e:be25:0:b0:375:d1e4:21d4 with SMTP id
 38308e7fff4ca-37797a9f7cemr47365901fa.44.1760993824327; Mon, 20 Oct 2025
 13:57:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251013191218.4136673-1-robh@kernel.org>
In-Reply-To: <20251013191218.4136673-1-robh@kernel.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 20 Oct 2025 22:56:52 +0200
X-Gm-Features: AS18NWCeioy3mWv3ZhVPApAQA3XGSmMWhoG9OZEUlcYBSQV8TD2OC05OSxkf5sA
Message-ID: <CACRpkda6y0anNZ0dCHf_OQp-2q1g9LfXWqWD7mS44L1rYsZKDg@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: pinctrl: Convert actions,s900-pinctrl to DT schema
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>, 
	Manivannan Sadhasivam <mani@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, linux-actions@lists.infradead.org, 
	linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 13, 2025 at 9:12=E2=80=AFPM Rob Herring (Arm) <robh@kernel.org>=
 wrote:

> Convert the actions,s900-pinctrl binding to DT schema format. It's a
> straight-forward conversion.
>
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

No comments for a week so patch applied.

Yours,
Linus Walleij

