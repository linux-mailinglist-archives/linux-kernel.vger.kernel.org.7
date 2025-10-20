Return-Path: <linux-kernel+bounces-861773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 85534BF3A33
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 23:06:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1273C350579
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 21:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E24A26D4E3;
	Mon, 20 Oct 2025 21:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OLF1VWJf"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1590615B971
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 21:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760994367; cv=none; b=Mg3CDlZjE+JgyjRTFI6XTMsRjC5lgNVt/bJd/bDN87Ji/t08BxmQU0+xtNMCLA3nGTBhEp2PP1Vzymr3hC0jy60hrMMHj9eQsUZzV6b1i25ykFISz/JB3LMK2Io/8+ZKUMFddOHVwwTTYJPWNk7T6Pl+3MgsTZG2CPseFWxnoB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760994367; c=relaxed/simple;
	bh=hJC6wrWvLGEYPpXdlMBPye+uWwg8bwB8IuKv8v2m3Qk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S62mflCNedeH2RrF10et24OBH7YIjYZmvP0/ERX9qdRUU73I2HwX84Kc8h5AVz5cKgL5Ztw1y8LUTZ+9w+JldrQDNpb72/ySDaVAYuz5Y+4nG4u0ljsSZaOL4pxrVpxxvR8+JCLyLFgxWgkr8B3PfTnxsexpTSZ//etvXS62G60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OLF1VWJf; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-36453927ffaso42307721fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 14:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760994364; x=1761599164; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hJC6wrWvLGEYPpXdlMBPye+uWwg8bwB8IuKv8v2m3Qk=;
        b=OLF1VWJfDnwC/YPBamHdiFxfR8WzcWlIMRMW1Vl7B/Hj0gXcZl4Tp6fHYG2zHFDiR/
         7LOKyucrMXZtbuWazf4guz9tp7Mi1/+zL1u5JnvghuOZW7KVTE2tkQ2NZ4yTBRbLXr4D
         2ttZBdxHPRD7I6uOuHkX6UmhHL7hM0W54NUYUcSNw81qAI3DZ+wcz0fM4CvrZHbDl9w5
         o4WUZW5CnKitDcrNCnUOTlqrNsinWTBPoDXIZIMYiiBfnDqhfYxNXzXBkgm17wRERepk
         Pah9527G3PSNYEsYt+2XaWeKO5KN0F/i93QU/GzNnRh2uY9bH9iXnDRe6oiux/cuuhuM
         X59A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760994364; x=1761599164;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hJC6wrWvLGEYPpXdlMBPye+uWwg8bwB8IuKv8v2m3Qk=;
        b=LeY2McNBCRNooE74egQ5WuGRUtbYoV9MzSH8CteP0mPUJjq8NgeMbysa4jHpSKwBFm
         oWcfftbYq+I5L4/ftbyVD+g6cgQg7MpRlDmpfzI+QVqyUoooVpLz0JFIXHsvvNVYTiGi
         zyZIrUYiAnN2PsnHO3DAVB9pVvaCXnQ+91lvhtSN4ysYpLh68jfsqqMtMquU/T9S/hio
         kJIxDSwWEKwPYODQS0Me4/TaEdY6hol0Mv6dc6uo8RS0f/NxBKfSbHybz2R2wCkKPV6Z
         VDNN8F3vz/98sNSidib7oKosGFG19ZIQmr2DcUTBhxv8c1w4omTVEfWLa5MfWsczNCYu
         s/Ng==
X-Forwarded-Encrypted: i=1; AJvYcCU9/PRPHOxEAi1mJJRSTe3qkQ4jWhwfXJhhXJAtjgnUvlWKnGZ3pW7YFtu09BG7OhDrt8FAeNq4rP5MXNs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyB/kY8PQwj1RCp5DOi6BZ7VmK1sBatIo/7E5EiYUlsCqIjmdsu
	wY+QZt16HhpryTBvvHdf7AMcJMgZsF9TjaD435fbP3CxsiMYwqWoF8u51UJOotNeur31MBGH1uX
	a/jQnyz9kCvf9t3Eha+vAC4wnRCYlWtCpqDCsDcG6bg==
X-Gm-Gg: ASbGncvXzty8YIbh5wDyQV5gJN+y0iTZ0eBP+ClGnnMfeuagr05/G7nCUtphbVD/F+A
	F6WTcCUSR6Do+08ors2r0MqFB9Y4qjY30jnR9x2NIrwDXE/aUPymezFWr2C/XZsRVe4YwbshLL6
	g63PP2yVyYn1fp+tzfKhsknLLEVHGkWeY9gO9Ju4b2PK3PREi1VeE7hqt7cCPpZqq+V5Xa9Sfzg
	gODsuRe48FSVeNfBzzHPeBTt039p0hZf0ZMlYQF2Lt2LApz7ihT/jBoma8nD4cHcXKjfYg=
X-Google-Smtp-Source: AGHT+IHqI5sn0aHZVxmgNoOeEHqPV/4OMj4aOHzfWKj6c+31WvQm9My5mBGOvht8/Q+3HwJ1qNC0mchFVak7q0/vhTw=
X-Received: by 2002:a2e:bc87:0:b0:372:8e46:3705 with SMTP id
 38308e7fff4ca-37797a8fa2amr46522241fa.44.1760994364136; Mon, 20 Oct 2025
 14:06:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251014-retype-limit-e6cbe901aa07@spud>
In-Reply-To: <20251014-retype-limit-e6cbe901aa07@spud>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 20 Oct 2025 23:05:53 +0200
X-Gm-Features: AS18NWAM_KkQJcc4_uDxnZUaq6pPWmRrcpznRb0EhOrILJeBdRjz8Rzkex7daQs
Message-ID: <CACRpkdadawJmrED-dPpnm+MKD1ndt4V86GOebkiQzU=d+-vHjA@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] Microchip mpfs/pic64gx pinctrl
To: Conor Dooley <conor@kernel.org>
Cc: Conor Dooley <conor.dooley@microchip.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
	Valentina.FernandezAlanis@microchip.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 14, 2025 at 4:36=E2=80=AFPM Conor Dooley <conor@kernel.org> wro=
te:

> From: Conor Dooley <conor.dooley@microchip.com>

> Following from my RFC recently [0] I've got a v2 here that's implemented
> the change from using the pinmux property to using functions and groups
> that you asked for Linus.

Overall I'm very happy with what I see, I see there are some comments
and my only comment would be to add

depends on ARCH_MICROCHIP || COMPILE_TEST

on the drivers so they get some proper compile testing, and I expect
we can apply v3.

Yours,
Linus Walleij

