Return-Path: <linux-kernel+bounces-835517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AE99BA75B1
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 19:48:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C45CA1896152
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 17:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5B62253957;
	Sun, 28 Sep 2025 17:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qb0zuWnG"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BDC31EA7C9
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 17:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759081684; cv=none; b=gSNJFYhK27GON6rqXw/e5PP+MB4lrQ7BggviG4XJdyK7TE+uqMshl/MLQmPz0K+UXADa3QNKVeIlztXUNTWaIi+1ai5jQ9FqVClXOMXopisDmCpDZnmTEEpgVlid2jDCQOFRcdI1wh3kMCXHWuLJiSX1z3joflE2jVVNXaE3Nqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759081684; c=relaxed/simple;
	bh=bb144XaT3ozq0w1qVMTiSOGlsjiwTNHYJ14plQdks2w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RLbZpnUpqmQOfFgfNk9f9KFBDmDZ4DwEd0iKsb8eDTIBHOZ4NxeuV6b6U0gJLOI/cLLVMu3u24X8oVI58YNLhhNQNCD6J9hHp4blvhPgArVeeE+4jnHGzEFyaXtqZWr9I7ZmaAIJo3zoZ7JzkHJUN1ai7ztEVucUCuk9fv4QcNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qb0zuWnG; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b57d93ae3b0so1753526a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 10:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759081682; x=1759686482; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bb144XaT3ozq0w1qVMTiSOGlsjiwTNHYJ14plQdks2w=;
        b=Qb0zuWnG7QsrX/EU9TbJnVXw4X5o8e31mNf+on9sXdE1YI5XWKrRTWkEjS7IM+9RVW
         uechN8gGX5DTdFPKQjG+mzpbae0lYH+ScjU7crsVuW5yOZ0RMpM30ev9cYR6cmj8AfoF
         ywfs/kfzrjRChzNR4vaRfotI9XMCcZ/zSTWccbByOnWDZUNPE/QDzvpcc3jTIwAPHVFt
         nzGcOwB3vIZCZNmAMZ2xS+nNJ0kuD7ZbRW6f77tLn8vBiqqWkE55buYvHvRa2jsn3BFP
         QS9h3/i3xvQ7kr+uhwC8wqFD5mItEKAE+JW9WogderX7yim21ES9H1W6rLcPK5rDW8TR
         prcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759081682; x=1759686482;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bb144XaT3ozq0w1qVMTiSOGlsjiwTNHYJ14plQdks2w=;
        b=NfIn19lW/loYsooia8pLKqhHyBax96UYfR1q7c+d3Y1ZOLMyz1tnxreS4PZ69Ar1bt
         udboaCVvuoxzq3rgHDWIewUmhtBzRVhztaTR9kixDnl+Rz3Xa1ZIZcMdrROC6D07GzIE
         4sxM0OPk4ZVBpCmmuu6rR5lA9AB1Gf2phcutRNSBJbuqzm4vCH/e49T4Mai8rUV8sPxP
         Pig4mvC5O8GhDnriwVsuyakXIw6vkg/10KAz/FY3SXlWOv063PfX7d0R4BePnsY96Rei
         YTpwSmPEvyAxEiDWvUAGl0E/i/xFG+AEid+RktO0247VFAm2NTxtzdLfJi1MTDcbP54R
         CAaA==
X-Forwarded-Encrypted: i=1; AJvYcCXAcmj57sssFUQqJ9bh1yxqEvwq+w7HrRk4ldbL/odM5KxxP1ASylgdtC3h0iXwv4kpDO52Jy/Cg/conBs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwX6q68R08KwsUxyHbTGF0ue+ZjmuanTYhj+AWZcZG5lqW85LxO
	VIfU13pQxkACPvKSdYZ73C8AmSL9USL2wohswEdQ1HZWh+IXtAf9yRYeZqbM4bUGdk0SUsD/1p1
	OQi7VS516aMZelDOs96gJIYuMwTFT4pQ=
X-Gm-Gg: ASbGncsl4r+mFKHQxmX7ui589PFEN2MbDoWPDF85mDI4xhoU1hyf7F73x1Cf57OzUs+
	1GXiRKNRe4qvOs11iWVdydSSCctqLhML5ad+zX8yZobLlx8HYDpPAaa1bn4sbjsk/Pl1u8FKo1t
	jSam8Vfzo1xYq3zFitlptgzbvsbkZrskVn5gymsbeYkHSlCA0fNVmKf7Uz9nRbSShhDOEgA8XbL
	T00rBC9gydOCXXZRP4=
X-Google-Smtp-Source: AGHT+IGIhTRX0vPWXRnKGbM7/t9PfWgMfG3icRhXm/bikRRYDgSLLR3zWm4hL7da1xUZ+6JNLVBVdbp7N1oWnUBqBMY=
X-Received: by 2002:a17:902:cf0d:b0:27d:69bd:cc65 with SMTP id
 d9443c01a7336-27ed4a96a83mr141161955ad.45.1759081681919; Sun, 28 Sep 2025
 10:48:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOprWosSvBmORh9NKk-uxoWZpD6zdnF=dODS-uxVnTDjmofL6g@mail.gmail.com>
 <20250919-lurking-agama-of-genius-96b832-mkl@pengutronix.de>
 <CAOprWott046xznChj7JBNmVw3Z65uOC1_bqTbVB=LA+YBw7TTQ@mail.gmail.com>
 <20250922-eccentric-rustling-gorilla-d2606f-mkl@pengutronix.de> <CAOprWoucfBm_BZOwU+qzo3YrpDE+f-x4YKNDS6phtOD2hvjsGg@mail.gmail.com>
In-Reply-To: <CAOprWoucfBm_BZOwU+qzo3YrpDE+f-x4YKNDS6phtOD2hvjsGg@mail.gmail.com>
From: Alexander Shiyan <eagle.alexander923@gmail.com>
Date: Sun, 28 Sep 2025 20:47:49 +0300
X-Gm-Features: AS18NWDPKklTiLrxKFeYvofRAgeM8OwBQfBPUfJA357z4XaPxxHtrQTv3DSxvMw
Message-ID: <CAP1tNvTD2uhK79VB_PT0JByv_VVy245WH-3a1ZaG1-Khw5_vaw@mail.gmail.com>
Subject: Re: Possible race condition of the rockchip_canfd driver
To: Andrea Daoud <andreadaoud6@gmail.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Heiko Stuebner <heiko@sntech.de>, 
	Elaine Zhang <zhangqing@rock-chips.com>, kernel@pengutronix.de, linux-can@vger.kernel.org, 
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello.

> > > Could you please let me know how to check whether my RK3568 is v2 or v3?
> >
> > Alexander Shiyan (Cc'ed) reads the information from an nvmem cell:
> >
> > | https://github.com/MacroGroup/barebox/blob/macro/arch/arm/boards/diasom-rk3568/board.c#L239-L257
> >
> > The idea is to fixup the device tree in the bootloader depending on the
> > SoC revision, so that the CAN driver uses only the needed workarounds.
> >
>
> Thanks, it is not easy to correlate this because I am currently not using
> barebox. I'll try this later.

I think this can be done from the userspace.
Build the driver as a module, get the SoC version, then modprobe it
with an alias for the desired version.

