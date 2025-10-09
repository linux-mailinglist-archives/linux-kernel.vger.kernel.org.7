Return-Path: <linux-kernel+bounces-847220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DBD7BCA452
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 18:58:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8E1424EBC1B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 16:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7AE62367D7;
	Thu,  9 Oct 2025 16:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A7c8o42W"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B58F22A7E0
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 16:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760029059; cv=none; b=dYw/258r6NwtZuT24ILr6QwY8xgYI0sg7uZtXB78krPXdUfTwIYDiRIJ5H02dXLhIl1rUv42OhgWJltYyTJEl8S2JlKD4UND1eTN1j4O9lMv6isEfiKrLyKThPXqk5Q/FT42kPxXM0WleiJJTOs7Y1LIpkFN8Bl5WloO6D45XTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760029059; c=relaxed/simple;
	bh=RF9ZSJQioRunccbOJ8PBKnVv5gI2HqZYf6M8L8RhwBc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FEuV/XWhEm6qzDhI+OOpJM1betocRTTZqCAgEsY6fKk/QDV3TkPnSYMMUKcfbj/kGBfISqTBD8AIK5C9gZuSmRNB2OvlpeKhIGnGBiK2GVLn+l3L0fmigt+ytdcoI0sRcIep3Oh46uxXlL61RjbzLCr4QLQf2neRK4mvl2Cp3rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A7c8o42W; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-637e9f9f9fbso2079236a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 09:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760029056; x=1760633856; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RF9ZSJQioRunccbOJ8PBKnVv5gI2HqZYf6M8L8RhwBc=;
        b=A7c8o42WIGU3OTQiIFlRbbz08yrpvjZUsLCUbGIvzT1sELosdWPF5Q1vKl9XqSFsD2
         rbAe3BHgfqamjmo98bOTJ0H6jIrz1m3slOoIEZQzoBsqjptIsqBh8eENTgPyxZYlUzW2
         zmQTk0+ygC6lyXe8G0g59NRXz+0wdCeemkZt+Ul9WTZRpy05R1D3iGo/dysZUnU3nF4U
         L5EBYrsPDEvtp+BQoWAJGoBGg+CUzjzjWJtFxcz1icMsT2Ch9d0LbWAcZknKyXUv7ntH
         Ie3VZ2vcp5IKRmEwQ2GjX2b3LboYhQl2PR7I0oH1uEH9+KgUCtg4RNvBn9xO0bKqzbXk
         321g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760029056; x=1760633856;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RF9ZSJQioRunccbOJ8PBKnVv5gI2HqZYf6M8L8RhwBc=;
        b=OYYvHbqqqbfTXoE3iOqRDLg5qcUIbc44C3BRn31fsKjR/oiPJZcn+42dHszDgBk6/e
         rxOuP/jpzYGy73RGw8Oe4AFZPUSGQz2SJHjciVMvca8fPqkDttrFGE1Kqn+17HY0KNqr
         g0pKtZND2tqY2ACtsRc7KYVHAC7VvMHd1EBSo5nOcC4QTFOML2O1XaAwVup2ImJmGUpd
         YrILdw2O8Ef5003Cpi/WJpm4UNoPckPE0JEHK2pwck9Xcmtizzt+dvkEy8QEy60xSJUE
         YASGJvls7yTAfasRUTNy8zR0nXeNZmNWedJN5GW2DTyLps9cams3Ozg5K3pXEnPiEJNJ
         3hgQ==
X-Forwarded-Encrypted: i=1; AJvYcCUDYYwphpJh25cqwc52DxClh09QksiEUbTcmcMkn+JWZCua+7riAQrEF38oOcv60z84YTGPoBiZdbJsI4E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFUFyGpGm/yzvyjpcFfyKTZNSBqwCbOk6HpAzuU9M8FWnNEMLv
	RXRQ0PbHovCivdTopaqyb/v0H/W1eibVHhewx4Nx03K+6UyoqMqAAfP9tjl7zbMaymxFhFiWKVL
	Gh18ZRbygnAM/q9QFr9HABK+6LPEzPwc=
X-Gm-Gg: ASbGncvU0SBxbPVcPpoT/OdsPW92uJO37dBKb4i8cawsDXjKit4T/BXzkEHrOHfJ1aM
	/PXMRu1MBYwAtABV35nwOOBF2ekf8KuLM5ofKfkK3aFEP0g0s9RaoMOC3SUzcf9WHOJJSFqGJMr
	ONjCG40ZYENW5qa8vJxqPKbuWVShI14zfDhmaTi/BZlqxLZDk60dbrbu23gnOSoqFHKZGRTEYr4
	Xn4jZWuQnAbix78jtLNgKj/jXJpPTtEJwo8UKuchOkNc8bRMomPbsw9RCOarYgCTV2CN9hazzi1
	NdOG
X-Google-Smtp-Source: AGHT+IHgAXC/qDv6DJSl3IbBYDZyNsei3ooyIM9aY+vI8wPwiiUSx8OQ+G2ng29IMa/tU47rvIJShBZrKGpVq0btB9o=
X-Received: by 2002:a05:6402:42c2:b0:615:6a10:f048 with SMTP id
 4fb4d7f45d1cf-639d5c6f3admr7423302a12.33.1760029055749; Thu, 09 Oct 2025
 09:57:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251001131409.155650-1-viswanathiyyappan@gmail.com> <20251006111211.28f018bc@kernel.org>
In-Reply-To: <20251006111211.28f018bc@kernel.org>
From: I Viswanath <viswanathiyyappan@gmail.com>
Date: Thu, 9 Oct 2025 22:27:23 +0530
X-Gm-Features: AS18NWCKulaivvxFZjI1XomTCbqny61jfhLMROFJeOwz26mAdFKX8RsAFt2auhg
Message-ID: <CAPrAcgMW=BLZkxhLq0ubRVvHQ7pNKGCCuGLSyoK_xh7XUUXv+Q@mail.gmail.com>
Subject: Re: [PATCH net] net: usb: lan78xx: fix use of improperly initialized
 dev->chipid in lan78xx_reset
To: Jakub Kicinski <kuba@kernel.org>
Cc: Thangaraj.S@microchip.com, Rengarajan.S@microchip.com, 
	UNGLinuxDriver@microchip.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, pabeni@redhat.com, netdev@vger.kernel.org, 
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
	skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev, 
	david.hunter.linux@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 6 Oct 2025 at 23:42, Jakub Kicinski <kuba@kernel.org> wrote:

> We need a Fixes tag

a0db7d10b76e ("lan78xx: Add to handle mux control per chip id") seems
to be most suitable commit: It added dev->devid comparisons to
lan78xx_read_raw_eeprom but did not move the dev->devid read before
the call (devid is the precursor to chipid and chiprev)

I feel like the patch title sounds a bit awkward so should I change it to

"Initialize dev->chipid before use in lan78xx_read_raw_eeprom"

since that sounds more standard

in v2

Thanks
I Viswanath

