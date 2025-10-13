Return-Path: <linux-kernel+bounces-851286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 508F1BD607F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 22:08:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1D84D4E5937
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 20:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4756E2DCF55;
	Mon, 13 Oct 2025 20:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P+M4Alen"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E902264D9
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 20:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760386094; cv=none; b=NRlHbiblUjaAXV/Rk4Og09xVKzYR+Pn/0LnEkM+DYLWg4A58c5JgQpCQ9yW0CDScBdm9r7SWpReI3n/m5jxF/Ct1HajWTNus0f+K9OOQMLlZ5KP86XMeMyXD0I+EeWTwftf8exvDqpjwu2SQGdIUjNOoGd9P8NCjpq7U8m/Dybc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760386094; c=relaxed/simple;
	bh=f6YCfiZPgf7T9da3PF433sgpNomzWHgHCTzG6Kev77s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GtNTn8qvir5Hnj0jKzH1YGuP3gqPT63LGy2Numq81mMuObH2zsflKkqG332Zt2x78/jc1FgXjyLPDdtSvRoiXDnKs3bTlzZsIbQfRh2500L9c2m0FiRGixcYUQfYTEsmHVY68hrCjn+W8KC2DgfBcWc1xqu4f4QsH8X/qpifvg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P+M4Alen; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b403bb7843eso990208066b.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 13:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760386091; x=1760990891; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f6YCfiZPgf7T9da3PF433sgpNomzWHgHCTzG6Kev77s=;
        b=P+M4AlenvDBYl66gEuJKbC66DjRlVBhZ7xRZBMxWg8+1DtuSVff0vUi7qTgMjilaI2
         un0IoFj/gijG/XS0AWPP8dFcqOkIlEbMfRm23o0WqTRyrPC1TB0bHQky19lITzx/OpIw
         ej0CKLpWp9A6qke6rLzCa9liJUhwvI4st2Qr00wFzsL6SH9Q9H6CdCwHrTNUxG+rx4fP
         0cygwbu3YLaiHfSEYdVFEpyjGW9nXmSxPvenD8UH6ULjcS1U0v9ycVLdnKOnld3FgWN/
         s4LzIFn+BVyhZRsOiqjzlSEeh7Hp1YvErr8UDQkRB7Gwc/BK6h9Sj6U2SIfN5CeaQUUC
         Sl6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760386091; x=1760990891;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f6YCfiZPgf7T9da3PF433sgpNomzWHgHCTzG6Kev77s=;
        b=I00E2PT01fWaAqCTwKIU+U8eYjPvzh6h3RWVLQbdducBBzi7UXsEw5E7VEK33tV3ke
         QuNVsX/2fWHD2YGUMHyVUvM8EsGf/2cOF9A0i4wD/ixxyk+fghEVDiAKGCXy1906Bvio
         PbBqG0gs9TIehl4YsJLntNYWjEfxqy8PatZLq4CMK13jetu8b43MXxKZrVIuQkFhmeEl
         luDNKWvEyy6Rr8qYiObjufyIXQYUI2oTJj/WwvRlgQyRYk8b42KhewqK+8N6qEi2F3Ut
         kxcZ+V6MUiHBrpLZrs40PCn6qixDt90Bb4O7JYDFoVd36T3s9NsxpQCZ7CJFszZG/Fr8
         4Fdg==
X-Forwarded-Encrypted: i=1; AJvYcCVPZskFRjeQA8Ure+u15YO3U8I95lDNGtDOjlCoIRUCzW0O5nD2fbdtv37yrDnHJcZD4S5YD0NA3Pz6WoA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJiuK6Jyq2mkf+S7OlRyxzmMCNbnei8R9RJxhN5rtjh4Cu5KWG
	uXT0U0NYUX0HpsdPRAjLrhChHXlpt/lP//D6IrZA1hKcTsHf6J+wFXepkT7eo0oo/MWC2qvnyzS
	4AI9LotuobC8ADfmOm9c7Yoicy57jlH0=
X-Gm-Gg: ASbGncvZBJjWH1oOMWKcfcMBGlq0SRKKD8WhpYcIs1H4hPr1OG54iVADVgQmd4JGsSQ
	lSz5BueAaZX4DZv6VeQivt7HDaQPPmiCO4Rg70kpST7dYwHAIHS2+vKG/Lx36PRtQoZtZE4sOBm
	0HxWDE76PxFkW3RCuoLqqK+F+Rrq1Jhamw2UufCh1LFu8cGj64PbMGpF/3LIUHXVJG5UOpLjqmJ
	zl+8jv8wcJdj7COFSVq9kkrwyP6eSZNoNJN0qwQYA==
X-Google-Smtp-Source: AGHT+IGaOBiDAnkUof21+aHq5NOWhRzhwOoz/nzsettYzFgLEx+7+Ty6orvQvellFLzzr1bdUXMUgkNJat1TukbLgbU=
X-Received: by 2002:a17:907:26c8:b0:b3d:30d8:b8a0 with SMTP id
 a640c23a62f3a-b50ac5d1de5mr2440916766b.52.1760386091019; Mon, 13 Oct 2025
 13:08:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251012100002.2959213-1-a.shimko.dev@gmail.com>
 <20251012100002.2959213-3-a.shimko.dev@gmail.com> <bf59e192acc06c88f122578e40ee64e1cafe8152.camel@pengutronix.de>
 <CAOPX745BVB4oVUxz0ZYRRs3_KWT6Y6cGrMdc26v49U66+u0ReA@mail.gmail.com> <06e7f7f23fb264e9db39441698b33c048d8192e3.camel@pengutronix.de>
In-Reply-To: <06e7f7f23fb264e9db39441698b33c048d8192e3.camel@pengutronix.de>
From: Artem Shimko <a.shimko.dev@gmail.com>
Date: Mon, 13 Oct 2025 23:08:00 +0300
X-Gm-Features: AS18NWCzd5nZy964L2prlJcgE13LQIh9M4J6dP4_QQwOGLFh6mQxszugWLdKR_8
Message-ID: <CAOPX746fn30c9zVk1Wrsgy86zccEHRGuhraUoS=qsFz11QSeWA@mail.gmail.com>
Subject: Re: [PATCH 2/2] dmaengine: dw-axi-dmac: add reset control support
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, Vinod Koul <vkoul@kernel.org>, 
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Philipp,

On Mon, Oct 13, 2025 at 6:41=E2=80=AFPM Philipp Zabel <p.zabel@pengutronix.=
de> wrote:
>
> On Mo, 2025-10-13 at 17:56 +0300, Artem Shimko wrote:
>
> [...]
> > dw_remove() has axi_dma_suspend() function, which is where the reset as=
sertion
> > occurs via reset_control_assert().
>
> It looks to me like dw_remove() is now missing a deassert before
> accessing registers, in case the device is removed while runtime
> suspended.
>
> regards
> Philipp

oh, I see, it looks like we have to insert reset_control_deassert(chip->res=
ets);
just after clk_prepare_enable(chip->cfgr_clk);...

You're absolutely right!

Just realized I may have been too quick with v2. Will wait for more
feedback and send v3.

Best regards,
Artem Shimko

