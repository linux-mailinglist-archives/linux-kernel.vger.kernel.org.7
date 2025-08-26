Return-Path: <linux-kernel+bounces-785945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5163B352C5
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 06:38:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7FE8206370
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 04:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 493562DFA3A;
	Tue, 26 Aug 2025 04:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cDlTHPD0"
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7B72DF6FA
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 04:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756183087; cv=none; b=SgPjEdvf5vlTmqg+JRQjKY23J+o48RWsyLwIk7fMBuJGFvfOmb+byPV2X+FIjpS8/WgYJNJZ914YArCaGKYSJ4Ey2U5vRXggPuSQ0pVE+jvJYOohkgT82RWa/DZXt0En6Ww4Wm32yzrwGne4sxEptAFAbKtLk609ggpihAk/iRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756183087; c=relaxed/simple;
	bh=Ir/frvfBmigODOrYvDm8WE3XUGyT1Y+lDiZCsY2zFio=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NvaGDmbqnscWY9ItNFZLmV/w89RdXmZ/qltF7HiDroVVJXnYLirrTIqTrxmLmALuBgQscsVEZOuhszPRa87OHpuwFA8EucBsfBQideb8LcRJilRmlgA52vBKFEIPn8LuhKyb5UCa52zW69iD0KTVcbnFNI1LCBtWYfLcNi/D+IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cDlTHPD0; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3edcc634157so116725ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 21:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756183085; x=1756787885; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pSIP9ijZgGfEABMWvbRKzQBwbc6ygeewxm4dMOnxJUQ=;
        b=cDlTHPD0hv3BFVt75j7hYZJxnSe6tfkpO8uTNOBsruceN/G6iqIMUxbgd8+3wNiunU
         Wzvh5hWfSzInh/SIrNrgCNt5hwYjK/gfjmJo3hDTkDwGaPxtZecZ8iT6NXOqNIi8NWLJ
         aXLl1Y5Rgz+LmK+iBzUWUw0MZzruROtIGlNyQZTRmOvRvO8gmua87HSh7T3OntKVHeRQ
         n/xWk5FOOOBo0f1iY71Ix5YRTVyoOLJf8MoxErd1M+PguYXyoajLSRDHsMVvgBBZv2u+
         LuTkFN6lsbqr+GBdN5LowUnqyKJcXveDMrqsx385GEsdRho4Dnyff09qnqGdNwC8AC+S
         3t6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756183085; x=1756787885;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pSIP9ijZgGfEABMWvbRKzQBwbc6ygeewxm4dMOnxJUQ=;
        b=bA+VvX12rZCitI27X2nRn3tM/V8QqefkqmCiH28jotyrYw/M+9+xEsPXjFpvWx0ls+
         S0wB+NO1yPZ+8ZCyd1PYy2dnn+vZonYQBavu9E2gKr2aDRp321RPspLW2SQ6ZOdtMs2m
         Y+SS41JKKxNXvNpD9b1a4utOUIcawJWUogwo39qKki82dgABexNbBeQ7+6TQmNlAhzwm
         lGfdqz1+M5fFbULNUxKXboOz/P8WdhHLnF7qLFlu2pu29QVC/tD30pksqXH1FrS7yuSF
         uA8lmw6pzAjVB1Bhplu2Y4urIF6sXeLUy5FBc3KB19o0HYz1jnEPRwKDsHcJKKKbOYHw
         e7hw==
X-Forwarded-Encrypted: i=1; AJvYcCUMZq8f/nH6Z1lO/qXhFgbe04KNWmNDBXqKnp2xC8K239JgRDs5/coVcaVSV7P18kpfQiyRhU/8W0uWaJk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfNjQ3H4U3vss/5sDNdkHdgNTOPqi0BdXAibmX/GdfspFUx0r0
	HNqWKZSBhPTn4VernAjWo0BLlGNl+QsCZAbO6Mv2+5+edYc8YqHSBKHCPAC0aCwKY7DgTOZCmWG
	r53ZJyA4KQK1Ca2rPG7OxqRA965ZLHLVSnXnvNpsX
X-Gm-Gg: ASbGncs56RBjdxfV6dbs9wLug7tbeFArMYe1qrWKdbp2PmxPaBM1uURqpGaEL9g7Ah3
	LlkmzRixpGNrh3nOjB5ewZf68p8OClzhN60bt8hUPJ9cTf04KY7EVK2QSil6u3L4nSBb9gQQKdD
	TPgSL+A/S0Ak0pCpyrfKSPAxxPNrKo1NTZqh/+v10PjObbCkaoBioWImVE2+9N7jR84d5LMkuw0
	NY1Gszra2i2QFspF6uI1saj7Hw6enETQ82oRZUFdDVHs5Wv5cfkP6SEzoexMvcZEUowQtVnMA==
X-Google-Smtp-Source: AGHT+IGEE+Eg34IJb5gk0UQZ+9TAT/AJPZ1WKGrlIYktXDLHHoLBVVVnFnig1r/7UBbYKc+IW06j/fvcPvWNpvsVJHc=
X-Received: by 2002:a05:6e02:1a26:b0:3ec:248b:8752 with SMTP id
 e9e14a558f8ab-3eea533b741mr2065885ab.9.1756183084969; Mon, 25 Aug 2025
 21:38:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250801034004.3314737-1-guanyulin@google.com>
 <20250801034004.3314737-4-guanyulin@google.com> <2025081313-senate-unhearing-4396@gregkh>
In-Reply-To: <2025081313-senate-unhearing-4396@gregkh>
From: Guan-Yu Lin <guanyulin@google.com>
Date: Tue, 26 Aug 2025 12:37:00 +0800
X-Gm-Features: Ac12FXyrsaQaSQQAtxIKd8teOzzdh7UoyIQaCcqwuim-2OB2cCzW4g8cT2KxRFw
Message-ID: <CAOuDEK2=UyjYbPQeSxVSmiLu6A36m4Tt9xADHyamJHM61-vhmQ@mail.gmail.com>
Subject: Re: [PATCH v15 3/4] xhci: sideband: add api to trace sideband usage
To: Greg KH <gregkh@linuxfoundation.org>
Cc: mathias.nyman@intel.com, hannelotta@gmail.com, zijun.hu@oss.qualcomm.com, 
	xu.yang_2@nxp.com, stern@rowland.harvard.edu, 
	andriy.shevchenko@linux.intel.com, ben@decadent.org.uk, 
	quic_wcheng@quicinc.com, krzysztof.kozlowski@linaro.org, 
	dh10.jung@samsung.com, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 13, 2025 at 10:51=E2=80=AFPM Greg KH <gregkh@linuxfoundation.or=
g> wrote:
>
> On Fri, Aug 01, 2025 at 03:39:32AM +0000, Guan-Yu Lin wrote:
> > +config USB_XHCI_SIDEBAND_SUSPEND
>
> Again, why is a new config option needed here?  Why can't we just use
> the existing one?  Why would you ever want one and not the other?
>
USB_XHCI_SIDEBAND focuses on the normal use case where the system is
active, while USB_XHCI_SIDEBAND_SUSPEND enables the sideband during
system sleep (Suspend-to-RAM). The design allows the user to determine
the degree of support for the sideband in the system. We could add the
"select" keyword to automatically enable USB_XHCI_SIDEBAND once
USB_XHCI_SIDEBAND_SUSPEND is enabled.
>
> > +EXPORT_SYMBOL_GPL(xhci_sideband_check);
> > +#endif /* IS_ENABLED(CONFIG_USB_XHCI_SIDEBAND_SUSPEND) */
>
> #ifdef in .c files is generally not a good idea, is it really needed
> here?  Maybe it is, it's hard to unwind...
>
> thanks,
>
> greg k-h

Given that CONFIG_USB_XHCI_SIDEBAND_SUSPEND depends on
CONFIG_USB_XHCI_SIDEBAND and adds only a single function, I think it
is preferable to place the new code in the same file. This approach
prevents unnecessary code fragmentation and improves maintainability
by keeping related functions together.

Regards,
Guan-Yu

