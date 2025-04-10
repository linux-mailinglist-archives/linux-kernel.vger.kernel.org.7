Return-Path: <linux-kernel+bounces-598129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A614EA8425B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Apr 2025 14:02:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A49E217878C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Apr 2025 12:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3874E283CB2;
	Thu, 10 Apr 2025 12:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="jpv8Qax8"
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB42F15665C
	for <linux-kernel@vger.kernel.org>; Thu, 10 Apr 2025 12:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744286420; cv=none; b=pzgZxp+XC5jiRRXaf93IqUkbEAMZLzyXoFDtfQgT7S0WgJ53tBh8hvnvPa4kp9ZBSEFn4EWqvmQzB7NExGPK4ecrH+TAfxwCFLgdqNwOfOc058UBHrxUFMvlfw94EalgLvLHLHREic/ZY32bB5cz9cz8hoFoBKa99p3feMkNb1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744286420; c=relaxed/simple;
	bh=5mm+Kphz5zkDETPbnrIi5JurRLFbY8LismuTcSArxlA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WJGodw+Q5sEv/6EM6kwTXYhB4/G+RnA06sojgM4T3FjdVN/L+aelVMJ0/OICKFGXy9sucivy/+NDIM8Hj77Hrvl3T43zP7814kBjOG94mnOy49sXC43iUT93q43gQf2FNMiSDXQZYlhjlFXQNlBqT1Y9yFPVULzd+RLz9D7LRVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=jpv8Qax8; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3feaedb4d2cso423330b6e.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Apr 2025 05:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1744286418; x=1744891218; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5mm+Kphz5zkDETPbnrIi5JurRLFbY8LismuTcSArxlA=;
        b=jpv8Qax8nkR/HfugotclFo5ZTOKdvld2I43skmwlDVp6yfN4jWNgKKHDbF48a3z6bG
         yHR/fbvCpYq8Mt8vI/vqasl98sECtXdPDDlHoP/xQpKPEpHO3Jk6HJ3SbwrTdEx7UMix
         qAJwsmLumG+okDv8qRR6NXQOZr7Li1II5V6aRuSNmJ13IA4P9FwIcEAZwod8fYYVipB1
         AbyMRbMTJtEv+J5ji/LZtLBYhzES/CWi/49UU/86E6SiBl/JvNeT/lWrXZeATaj6HKI3
         tKvqwuXSJX2PI2HYsf8FT21CX/Z4+wjOCdmc/mrdrNvmmCMEvOyuPLb9ZzgA1NEAwz57
         yCuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744286418; x=1744891218;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5mm+Kphz5zkDETPbnrIi5JurRLFbY8LismuTcSArxlA=;
        b=mhH7v6ssVofPnDX1YbbEXVL13RlVIqvXpV/L7usOo6bIWpqOl9xruXfZGY2E8/wIvI
         sEnjzpSzPair+f8IogxsiBgDeD8Tfzrge10LJX0gEMH2o3BWacTJoppp6PnCYEG8Ym0a
         aEDv6c8qxhau5x4Xo2SC+tqvRQbpsp9pDWXEC6CVUYcoVPW+X7AwPtxENCU6FcczUbWz
         VdIk6XQDq7M6v9Az2bSfc3p+1CLxh+RZPZVBGEyavmL706an+yDCebu1BCncxOgjY/xP
         JFFesOThg6/3So3Kx6NCxg4pQ8x9uRox7ZdMWiLv5DlLFp41WFU+yF7fCWzQYaK49lBy
         rhJw==
X-Forwarded-Encrypted: i=1; AJvYcCXfFPbLI+P7/Tj+eEOXlr6gO3GRurHcUDip05XPJeXrheOzz9jR/ZTBEW2MvRn4232z7QsNh7NCTXMFhkM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0bcwqLuY2vQf/ZhmHciJ29Fk92qpvXZy/45FQbWPK7wzixnNg
	I3ogQZnW4CZ2hjmlmZ+ipe7k0t95RA0b+9+4hI2zaQMV8O13A1zqeDa6lU4DT98xZ7paN5WZ1zc
	YPeYBgVq9kK1yJn+5AJoB3Kgo+ImAWAUzKgyWgg==
X-Gm-Gg: ASbGncuPH5GC5n64iLWVFbdZyWhkNydeN/n1WD7/nJfHfUK45Bnxj406nN0tBQ92DNH
	tHPRBcHgyXYMP9mEk9WDMOuGQ/UTy4f9h5ep4WLyYQABYqmCS7pIbPloL+XoW747RnESurIPWYc
	dQy19mhgFt/qcxDOCgrQQoxSpD9Er71Sy2OFI=
X-Google-Smtp-Source: AGHT+IHnIkLhJSlykiL5+8dA4EH7szMcIvgklodE7+WTDUEy7LpwoBs7LW+GqU/QKHiXK02SspcXIuFT3Z+1S4josm8=
X-Received: by 2002:a05:6808:1913:b0:3f9:a187:1f2e with SMTP id
 5614622812f47-4007bce6f9fmr1034213b6e.18.1744286417769; Thu, 10 Apr 2025
 05:00:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250408061200.76148-1-cuiyunhui@bytedance.com> <84bjt6rg5z.fsf@jogness.linutronix.de>
In-Reply-To: <84bjt6rg5z.fsf@jogness.linutronix.de>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Thu, 10 Apr 2025 20:00:05 +0800
X-Gm-Features: ATxdqUGmV_COFuXW5jSk7h9F_60UtswUBGPXQaHRFerxEPGhqq_pxAaQhTYV53I
Message-ID: <CAEEQ3w=ukrmTE-x6+td6Sv10Qc2Kcc1jVMYkaVrmVQBid2tJ1w@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v2] serial: 8250: fix panic due to PSLVERR
To: John Ogness <john.ogness@linutronix.de>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org, pmladek@suse.com, 
	arnd@arndb.de, andriy.shevchenko@linux.intel.com, namcao@linutronix.de, 
	benjamin.larsson@genexis.eu, schnelle@linux.ibm.com, matt.porter@linaro.org, 
	tim.kryger@linaro.org, markus.mayer@linaro.org, 
	heikki.krogerus@linux.intel.com, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi John,

On Tue, Apr 8, 2025 at 8:28=E2=80=AFPM John Ogness <john.ogness@linutronix.=
de> wrote:
>
> On 2025-04-08, Yunhui Cui <cuiyunhui@bytedance.com> wrote:
> > When the PSLVERR_RESP_EN parameter is set to 1, the device generates
> > an error response if an attempt is made to read an empty RBR (Receive
> > Buffer Register) while the FIFO is enabled.
> >
> > In serial8250_do_startup(), calling serial_port_out(port, UART_LCR,
> > UART_LCR_WLEN8) triggers dw8250_check_lcr(), which invokes
> > dw8250_force_idle() and serial8250_clear_and_reinit_fifos(). The latter
> > function enables the FIFO via serial_out(p, UART_FCR, p->fcr).
> > Execution proceeds to the dont_test_tx_en label:
> > ...
> > serial_port_in(port, UART_RX);
> > This satisfies the PSLVERR trigger condition.
> >
> > Because another CPU(e.g., using printk()) is accessing the UART (UART
> > is busy), the current CPU fails the check (value & ~UART_LCR_SPAR) =3D=
=3D
> > (lcr & ~UART_LCR_SPAR), causing it to enter dw8250_force_idle().
> >
> > To resolve this issue, relevant serial_port_out() operations should be
> > placed in a critical section, and UART_RX data should only be read
> > when the UART_LSR DR bit is set.
>
> The UART_LSR_DR check still has a race condition if the console is in
> RS485 mode and !SER_RS485_RX_DURING_TX. It seems DW supports this mode
> as there is code in dw8250_rs485_config() that sets DW_UART_TCR
> differently for this.
>
> In this mode, serial8250_console_write() will call the callback
> ->rs485_stop_tx(), which for DW is serial8250_em485_stop_tx(). And this
> calls serial8250_clear_and_reinit_fifos().
>
> To really close this race, all UART_RX reads would need to be under the
> port lock. Most of them already are.

Oh, yes. If there is another reader, there will be a problem. I'll
update it to version 3 to fix this issue.

>
> John Ogness

Thanks,
Yunhui

