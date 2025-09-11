Return-Path: <linux-kernel+bounces-812398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3477FB537AF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 17:27:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A11AB16FA81
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 15:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BB4C34F48C;
	Thu, 11 Sep 2025 15:27:19 +0000 (UTC)
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C65B34DCE1
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 15:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757604438; cv=none; b=qchpuWE/ZWSbdZswF2cLxiJReRBZ0i801f+EU0eKAa8eUkeQ54EZHNz15c9SK9J0sXcR5usZCPiG/hIlBDQAewfQ5ijs8CnagJolbf+5uXlbe2Rdyz4LxY+OeUM2yfSL0Jf8G5UobgOJ6goyzVCbXrCjNI1yXDMA95t0JOZOUWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757604438; c=relaxed/simple;
	bh=QP8zVxm3a3UK1G9l3fTpfk+VR1gAC1g6wpjwqtTIoMs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RbL1w35UMGJDU2qXV+dGJUfjsuK5KdeVttKHSK6LkPHoboeXb7W7Fvn5PthA/++nGlGUxe96fW02F5tA/qWMVCoVptqTdw8hxGELj1rW3QjaO+ssZQ1Mw0Ru3yJsHwO69ee9ZU7EM/ktjZQiyqoI0OkrRaxDAXRKEaX8AvE5JSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-892196f0471so340453241.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 08:27:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757604435; x=1758209235;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lPc2XsAxmYi3h6MxGsxCl43YcyPTx0afvcilP6Ob1WA=;
        b=Ru0fqkP1K+6wFPdjJFnuy/VQlrg+Ig49cMhzlxZyyADGHGC9sLznkchQZI9BwgPsjd
         O3DTfsui0rGCezl/hDeTSQRa0yJ1e7DMzq2zDL0jSODv+C4OUWCBakeNo56MQiFiweD/
         4RejQcOP65bvX+7oPm65Mzr9SynBmoekkyDIZPEkmWYBnRWvJ3kCShX3sQU6r5ptmmp8
         vJk6/AZQetwH9WCULh+m8Ph6rM9b4Xhu9jekIjPWXRKC4LdBOPy3YLglr1MUdLRXyJGE
         Rp5bQCdOf1GWpOTpaZyOShYdKR1bLaWziGZbjKHbnnCfDRjnyCwy8C5TxfzdTGMkmKE+
         C7zA==
X-Forwarded-Encrypted: i=1; AJvYcCXw0FS2savpxFSJYsIdIwnjAklO1zW4dLepYSJ+KPq8uYOB2hLl9aQsWzkUtyJzBVLwSK2t/6JDaKxSyq8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2v49ncGDtmil5znAeCWcYC7b7BTypTTHk/XYqm3Z4pertXg5e
	cyWZt40WKmxSHYXp+Du5UiOXAZeuRNiJrEZ1j0Xt+v3RtR8OFfFm6hDyVZYdWfRQ
X-Gm-Gg: ASbGncs+0g76KmkyCKCxAn078BCfwCGjn1q+EYrXwxmyrds+w1t74Zok44LYzpqz3g6
	6L+i9sjDsONNo21mzAkfvjbGNKokFohHbNG4PeaXUASFalFBk+aPOw6L7DxZ1BEDrCzHoGe5zKs
	e5qhwUn6+LO4IuLect+Aqk1vM4G1IgJbpkf+yWVUZC5iMK9B/YZQ6B/z5KRQkrt0XfU7nBalV9L
	R+jSh8WEMSbm/Oiicqu9Z/rtoCSRJxTp4GRaelZatW4tMPfV+VuXI403HTiF0jkuI0YJs2JBDTH
	TcUUGxVnO8lK4ROQnrrYubVAZ5/vlNhEHocRGmvOJvdgXIDR6JVunOupzk/oIFJ5QY5f0tErGsr
	sLezhdaPCUZznbQKh698OD1zq3+w1yEnykod0uMWrXsx9juPNl+VMJpvZfYRcXQnrr297RLc=
X-Google-Smtp-Source: AGHT+IHoycy/QcCf/bvF+GIiW6a/oAubzkCXCSsJkE6f+xS0wd4ZYE4nJ2sAo1uAn6MEho2JKR5FCQ==
X-Received: by 2002:a05:6102:3706:b0:4e7:b728:e34b with SMTP id ada2fe7eead31-5560908cee0mr1839137.3.1757604434835;
        Thu, 11 Sep 2025 08:27:14 -0700 (PDT)
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com. [209.85.217.50])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-55375d5b89esm384726137.13.2025.09.11.08.27.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Sep 2025 08:27:14 -0700 (PDT)
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-52a80b778e7so323986137.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 08:27:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXwj554TPXa3UiubX6mO4fmkNEm0I3bH/A7HcTCnvrIXmJwPYEIds9pyuHD3xzD6OstLsbSHkjEf+L9hV4=@vger.kernel.org
X-Received: by 2002:a67:e705:0:b0:522:2b10:7d07 with SMTP id
 ada2fe7eead31-53d160d3c64mr6513188137.30.1757604433799; Thu, 11 Sep 2025
 08:27:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250817145135.166591-1-biju.das.jz@bp.renesas.com> <20250817145135.166591-2-biju.das.jz@bp.renesas.com>
In-Reply-To: <20250817145135.166591-2-biju.das.jz@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 11 Sep 2025 17:27:02 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXHzk30U09bLOzwMD6SsP_jVJ60r7feDGiaP=9VFgsYVA@mail.gmail.com>
X-Gm-Features: AS18NWCEx-CGg4oNyhEX62psOpxj-1sWUL_xztZ7vzAgM6MsdT2-vWQYD8op1dY
Message-ID: <CAMuHMdXHzk30U09bLOzwMD6SsP_jVJ60r7feDGiaP=9VFgsYVA@mail.gmail.com>
Subject: Re: [PATCH 1/2] arm64: dts: renesas: r9a09g047e57-smarc: Fix gpio
 key's pin control node
To: Biju <biju.das.au@gmail.com>
Cc: Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Biju Das <biju.das.jz@bp.renesas.com>, linux-renesas-soc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"

On Sun, 17 Aug 2025 at 16:51, Biju <biju.das.au@gmail.com> wrote:
> From: Biju Das <biju.das.jz@bp.renesas.com>
>
> Adding pin control node to the child won't parse the pins during driver
> bind. Fix the issue by moving it to parent node.
>
> This issue is observed while adding Schmitt input enable for PS0 pin on
> later patch. Currently the reset value of the PIN is set to NMI function
> and hence there is no breakage.
>
> Fixes: 9e95446b0cf9 ("arm64: dts: renesas: r9a09g047e57-smarc: Add gpio keys")
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v6.18.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

