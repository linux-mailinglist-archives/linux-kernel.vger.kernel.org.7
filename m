Return-Path: <linux-kernel+bounces-882631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D40DC2AF57
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 11:15:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 118DD4EE1E2
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 10:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22B922FD1BC;
	Mon,  3 Nov 2025 10:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QeTTng1v"
Received: from mail-pj1-f67.google.com (mail-pj1-f67.google.com [209.85.216.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 122891D5ADE
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 10:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762164925; cv=none; b=qF2cRrplm2xbuIAc0bRsomd9JTACWd9bBYu+1pv9gHsydy8fOP0biGiMztW9vh0ZxfuLoFCkWdmux4wVp4eThV0+1uiJkcIJMivehmUyiF9K+VP2DvKZOPs3kWx0GD+FDd6zhXUy8nKiUNV1334r14JZazV1XeBRc/UUXbbIziY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762164925; c=relaxed/simple;
	bh=xhQO8VSkQ5GiDk0IBRGYq79sb3rh8+nn0C4F5uknl2I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BmXaro9sBxNp6cN0C/2QpeX14Q5fTgqhlezIWWKbdUzrVFh0VLuu65dojQZa0SDQLr3+qub6LP7MQ96uZ3T1JO/sqpZMAhGZrmG1TwCqOwrdnZy0e06seaTGaRIKgr+vewL4EoBWI6QuYirtd7lfOE8k6bzs5TVdbdivABYnlkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QeTTng1v; arc=none smtp.client-ip=209.85.216.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f67.google.com with SMTP id 98e67ed59e1d1-340ba29d518so1542744a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 02:15:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762164923; x=1762769723; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iYBAGRnwsaVRtnZ90Ik3LNRr3AXYbWscAtBfejKw57Q=;
        b=QeTTng1vrLOWiJemyTTniBAa63osCa/SCR3fNHV6ob6biaBcEIA7iG9btGtoF8jJhv
         HzzDBNU8BdoTZ1wNVKdCvp3MHAX3GF5Gst9BxmJSlXCZk5MMXUSuSYNOwiXPkq0bBg0W
         WLqtxk5+zcgzekjKSuo9g0LDegOHkqk0OF+yDqDrg8gLPsFNnvSCUzh3sMNFFBYPXbDU
         982lmbdo/g/e3tTd5R7+1XmzEXsu31M/Wy0TgcZsZTBVW2MDNYWwgMQNu2L9YO1/zAto
         s1Bz1pxoSUGiXgbbbqTeIBhGabkI094vrMuzkVDTTiSDjfr4WRHakR1nOD4GCL7i3ciP
         HZjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762164923; x=1762769723;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iYBAGRnwsaVRtnZ90Ik3LNRr3AXYbWscAtBfejKw57Q=;
        b=j3AJBzRDP2RndmQBc+EaTFQVO1NULHKq/Rl2sn+9Lo1kuNmLxMWApZgAuQT1o0TFpv
         ZfZMzZZO9wnHU+xE1SCL9YkRfSaVXoEoHxBBAcYT4sPLUjdEIxCiQfL+jY5AAKvY8H4l
         ++jplF8J5xEpkD1inp0Rbk9jYm5mB1+M8q/q3+7EPDVLGjLXFHZGR0wLYXda4hVpmrpV
         N8e3uFTRRsGy9TSYw4yb8DYqZGJjg5n32YOvemReZBu5601xCmfiyVtAHQ60YMaOK+YP
         soKsjuZ40wrR0GSa3bHJ++tQngPnHU1nhrcMwEw3nSdMr9E9fDa06LFlNuaURAtOJe6d
         5bAA==
X-Forwarded-Encrypted: i=1; AJvYcCXNARjRBqVXnwhRmf9IICUg1PMIuA/ifEw/FYKz6jcaYSbky68gA5sSCuUx/x6g4U3yGs/6sRd8P7rXYkA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4dMK5AwuZaWlRQEV3onvUmWTekrEDWgs+MI6KLy7WJ9j1Qm+1
	Cq+XTy1KK8HWV/JF74kXbLrqxoOZn9CxRa8lL0jqC8dHH5dHM7WUVasLu6V1W2JeKbJ9v7XQCRh
	dW6SiE8wsdkSxM+brtuh+8EP437gcVhI=
X-Gm-Gg: ASbGncsL4qAQh1O8fmZ6AQdDsExAmvbuhLEJHA5npisr5L1/bD8dWHdNs88GW7pSe0p
	iFP+kehIsUq01A3GMRPUUt/+vsWHgIH0JVl4xytW475edTXR2xUYdLlkxq+kJQtDY7d34mT75Xp
	E2lpL3KRtyVHRRYQw6PdOmfIJlteSJqhs82mxXvqdCb+tMtETuJnhYh6MpS4vf7eh2esBLmJH5Q
	j2OfBv4nfMTIoZCzwvz4fwXdlm+srirhJjdiERCZi6JwFb/uRNaHgaAVGz/PU2Xi9VWUJk=
X-Google-Smtp-Source: AGHT+IH731P/OM4biNBl0y9xM2WQLcjL6aUh11HRLuKUDQBtvA91xGIKvKfLk6tpKhtCc/CbcHnr0Pf7BOct6oQgsj4=
X-Received: by 2002:a17:90b:3a10:b0:341:194:5e7d with SMTP id
 98e67ed59e1d1-341019461bamr5569334a91.24.1762164923261; Mon, 03 Nov 2025
 02:15:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251102001411.108385-1-francescopompo2@gmail.com> <CAMj1kXEUL-Uv4tCx5NLVHDRo-BdEK1xJdee-UYs-ymE-mLxv0Q@mail.gmail.com>
In-Reply-To: <CAMj1kXEUL-Uv4tCx5NLVHDRo-BdEK1xJdee-UYs-ymE-mLxv0Q@mail.gmail.com>
From: =?UTF-8?Q?Francesco_Pomp=C3=B2?= <francescopompo2@gmail.com>
Date: Mon, 3 Nov 2025 11:14:47 +0100
X-Gm-Features: AWmQ_bm6XkP9BhW1ynD6Eq0mHhXY8svSBp4RcRzoqXvfgMS3u1RZvKcKQbULyFw
Message-ID: <CADr=TJdTcss14P43_jAj4tsEYukt=Z18SnjUNqMD95O_5KkNVA@mail.gmail.com>
Subject: Re: [PATCH] efistub/smbios: Add fallback for SMBIOS record lookup
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Il giorno lun 3 nov 2025 alle ore 09:19 Ard Biesheuvel
<ardb@kernel.org> ha scritto:
>
> Hello Francesco,
>
> On Sun, 2 Nov 2025 at 01:14, Francesco Pompo <francescopompo2@gmail.com> wrote:
> >
> > Some UEFI firmware implementations do not provide the SMBIOS Protocol,
> > causing efi_get_smbios_record() to fail. This prevents retrieval of
> > system information such as product name, which is needed by
> > apple_set_os() to enable the integrated GPU on dual-graphics Intel
> > MacBooks.
> >
> > Add a fallback that directly parses the SMBIOS entry point table when
> > the protocol is unavailable. Log when the fallback is used.
> >
> > Signed-off-by: Francesco Pompo <francescopompo2@gmail.com>
> > ---
> >  drivers/firmware/efi/libstub/efistub.h | 17 +++++
> >  drivers/firmware/efi/libstub/smbios.c  | 99 +++++++++++++++++++++++++-
> >  2 files changed, 113 insertions(+), 3 deletions(-)
> >
>
> On which platform does this fix an actual existing issue?

Hello Ard,

My Macbook Pro Late 2013, product name Macbook11,3 is affected.
Specifically at least the firmware version 478.0.0.0.0, released on
01/13/2023. I have no way to downgrade to check for other versions.

From what I have read on internet this should not be the only model to
be affected.

The issue is that apple_match_product_name() fails to obtain its info
via efi_get_smbios_record() and makes apple_set_os() fail too.

-- 
Francesco Pompo'

