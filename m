Return-Path: <linux-kernel+bounces-850339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id ECA09BD28D3
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 12:24:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CD1E84EF51B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 10:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B99272FF16B;
	Mon, 13 Oct 2025 10:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PnycrD9Q"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792E42BD03
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 10:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760351091; cv=none; b=rHkFYcBp/Z7eYt9v8YaL63PiDieMJEly+2GKL2j8hZ4EuSj82S9NpOiPp/s3h9QelppjJAEop3NQmcGPufcX0zNBrTNlpMq7sjv1qLzTrK/8360YFFOCMt18DhnLBQ+4pk/+TRvHRIAsuF0AGNJl4sNs4HDxt1QdXRcJBeJz6RM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760351091; c=relaxed/simple;
	bh=+unRYycP97fv008huF8n6bo0ikkvJYI2Zc7wQSeA3nU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iWN+FSHhUxG7vP+eBh8VNnmNbOgpoa4NqiS6iGNXpgyqyioFO1LDRt9/jkp7jjkR5Wj7YOtwQ8NsSjQRgQV8LFoszpn5AIirWgW3NKdh+vvdQqYGnOwGBT+MEgAxsjYSfk2NjDYXiV92S/QZHMaDQIWVLiZ0WvxbEtvG8JH8nIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PnycrD9Q; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-37612b15a53so42366251fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 03:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760351088; x=1760955888; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+unRYycP97fv008huF8n6bo0ikkvJYI2Zc7wQSeA3nU=;
        b=PnycrD9Qad1YKFd8X1Fdi+B+dQb2/88AAJMxqSdOEyAn89o5Vkb6zBKx4rZK8+SYA7
         l2s5oHfjefOqLMnW41TWJdDaS8KtoTVXqwZUFsi0Ih+x6jXCizfsM3njjDTzrf8Hn4xm
         +zFcy+h2NDXA/DNnvMNVpkZqB3gp0511kfa3K/+iDC6UTCF35SoIscW5voCfrJXOsaW5
         UHhH3ttD2YsQPKHIkOJIRRvJ5V+QnZbK3GEE0VJhm9HtdGTqJ0uX5CMQ3rKMT/QCDT/f
         DhtdIIRbTgImcyvRWPvPL+StstNq3dbIOaFbxqe5/Bh7LsjGEklpQSG5n+ZuTJNTDMND
         vZKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760351088; x=1760955888;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+unRYycP97fv008huF8n6bo0ikkvJYI2Zc7wQSeA3nU=;
        b=oNKKJOrOdivegmYcI/iamKKhOpklHue3lNS34Q8/8H8eBvjG1XXII1JLwndIc19cgv
         BuQVhxicXogI9QHCZURnPoM0RlgooghgLfPMgl3bmowZ5j6+eYnfrunqzxMK16V+kO9+
         FvzmvBwqI0mxnx7fCgKxD2zzyJkfa5k5TxQycJbOiHCYgc2MMnEQyK1KZE/EoD8pac+v
         s3qRcIgl6iMCuW0c3KgiRnARyOc6RAYYEKSrl94VqD6hR4L5rXHv0Zg8sMrOtqrsdwzv
         UCiB301hgn5G8PtyD8Txxg1LPfofotTejEg4F0AcNsFmm/ustlowCVT5MAPzJEiRN/cX
         xelA==
X-Forwarded-Encrypted: i=1; AJvYcCVBq2O3uBL+0pBhfUlY+9Or/VqSi3X2h/4bJz7uE+1X0xtjrOsqKmx61eajSHANUkFLH+0E6J2HDxXw4dU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3dIhdop5UDHAH2/sL2gEAxrbQG7Yx/Wqx/+4HYCMjQ1WWGlNx
	Nu7cMBLJrPDecjWggUXDQRQxe+MKTR6VZ/4rq51elsOMqSbesYt5/ipmRR34LJ2LYwOkcOMqAK1
	tfM7yuvYIKWxiHB9V+gA2NLxjIHTqK6dyIOR59ydQrA==
X-Gm-Gg: ASbGncuVzG4EfL1Hv4dVlnkRiQyOcvNE0bpWsIGa9sWjAVTjqr7ZK+/BHPGsKEVOFCi
	9229PBJUwD+SEd2mRojppR2BUxj7Z0tYNbBtJqmq9iPo/mLBJnK9DfGQ//mc7Ic/ul7p/4WMR04
	UMD5WTCEYLgbPH52KWKySRqB7Z0P7fogEW2JPUrqCvCwBFiZ4PvR26a4rFhxd3YN51YKJXl3oPf
	G44j/KETKCoy+dAn4mfB9/ukpGZTA==
X-Google-Smtp-Source: AGHT+IGvGHloV1limtQ0fx79bfGJXQow2XXzmDst8EglcpB9EbNJ8pFYHIXf92/sCJscA5Ld0pw8fuj+myOX2Y7yQHE=
X-Received: by 2002:a05:651c:1ca:b0:36b:8361:15c7 with SMTP id
 38308e7fff4ca-37609ee797dmr50886881fa.42.1760351087667; Mon, 13 Oct 2025
 03:24:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250925221927.2610760-1-robh@kernel.org>
In-Reply-To: <20250925221927.2610760-1-robh@kernel.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 13 Oct 2025 12:24:36 +0200
X-Gm-Features: AS18NWDB8GoBtqV-UtGzBfY0pqqIxdxK6aWLKDGgXTJxVPFOQb277q1e2UR2gHY
Message-ID: <CACRpkdZH_Q18CHnT9rjhOGUx53L3pKrP6BrPkB0hSV7JB1N44g@mail.gmail.com>
Subject: Re: [PATCH v2] dt-bindings: pinctrl: Convert marvell,armada-3710-(sb|nb)-pinctrl
 to DT schema
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>, 
	Gregory CLEMENT <gregory.clement@bootlin.com>, =?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>, 
	Miquel Raynal <miquel.raynal@bootlin.com>, linux-clk@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 26, 2025 at 12:19=E2=80=AFAM Rob Herring (Arm) <robh@kernel.org=
> wrote:

> Convert the marvell,armada3710-(sb|nb)-pinctrl binding to DT schema
> format. The binding includes the "marvell,armada-3700-xtal-clock"
> subnode which is simple enough to include here.
>
> Mark interrupt-controller/#interrupt-cells as required as the users have
> them and the h/w is either capable of interrupts or not.
>
> As this syscon has 2 register ranges, syscon-common.yaml needs to be
> updated to drop the restriction of 1 register entry.
>
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

Patch applied!

Yours,
Linus Walleij

