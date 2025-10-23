Return-Path: <linux-kernel+bounces-866417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20E79BFFB55
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 09:51:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90BA83AE484
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 07:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF58A2DCF5D;
	Thu, 23 Oct 2025 07:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=reznichenko.net header.i=@reznichenko.net header.b="DdadXaCA"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D282DCF65
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 07:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761205857; cv=none; b=D39eHfIh39EThWBo7RVGQuu+TYgwLei2otUxu1Q0GR8pM/rebj14n0Yg4ByWFGznXQH3xv/2RUetevqXDb+/59ygWIm7eRDvuSKsF/q/scw8Td4HbZeMYIR3ZfIpItlcBIoBEadN1etKEQrPahnxpupYuGah5PYKJo0/TL1vEL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761205857; c=relaxed/simple;
	bh=1hywAO6OmglGEJDv4dlqj7DVBEZf4btWfqp6klm/+u0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jefVouPEbonqJ1ah0l4IrMFQlWqhDy4zlNP/yFEc37XPh3YGADQ6KurnkKV1LEhqq8+7Y22hTwy6c5PYe2SIeEDJeA5Du2wbh8/aWzJp7RSQUSKTri1i9qeXo6HJ05lW32B5WKuMGcdN5yQHdyXZSKVlQjbkwgkfejDL2n3aUq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=reznichenko.net; spf=none smtp.mailfrom=dpplabs.com; dkim=pass (2048-bit key) header.d=reznichenko.net header.i=@reznichenko.net header.b=DdadXaCA; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=reznichenko.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dpplabs.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-339c9bf3492so689352a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 00:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=reznichenko.net; s=google; t=1761205854; x=1761810654; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ckf+WA/vGci5TKMGOHLvpH1kq+z/6nk6A9B9djwZ1Vk=;
        b=DdadXaCAsxeuRsSpN+Sdnn37yPc/OkFEl63jtTq/z8UFhC8nMrDu66q7IGiP/acqFV
         yANWLN1mFfSLl64lqnzKWdnVpSkTIcvKWSKhuiE2HIyaorhgIPuRz7Hjd+vzbjT9fqZM
         n15WKP7SOO/BoWlphq9F/IE/x+S1tZlnyQ3Zt1vtoBxo6nOfvoTs7k4dO7hrJeII6E9I
         6wzEFkoRCV0JA9LIfkLH5fyj4kOIBIgLQZXr12cOdRjIwJrUvyUpwHq86VJQE+czGytL
         TXY6aLh9GDUO9THRDwGPgcylt5FfsPu9apzDEhzanJS/goOHGiO8sBft1bwWUwOifoXX
         4O0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761205854; x=1761810654;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ckf+WA/vGci5TKMGOHLvpH1kq+z/6nk6A9B9djwZ1Vk=;
        b=TgnqiqOzdZNfx2SiW8F0GdhS2EWyinBVu7xWCaCvTMDYwsY71t4Z6w9hokepO+El+c
         XQed6+TjXo/cLUJoFvb4JrjOqToKv/KuyWzRgI/BULSu8/n8t2wNl28JaHAUnj0ssrWf
         9bUIKByHQpGj4oFHIMyavqSMZptzMbJL6IFLYUNkExpeYvIaHFyPNvTI2YANXdDvy3le
         K435sFhgzOvvzAgHZRk7XtIqxTAsDGk5nqiJrUzBqHdMYVhxvyIl5+JEtrD+W56tZtGV
         GTp7bcuXL6E/nP1ZjZyRM7twvzdTAmig5QFQTJqn41XvPHjevkDs8G+Tuz5N12t414cP
         EEYg==
X-Forwarded-Encrypted: i=1; AJvYcCW/LE3vrXLkyx7pqkQdxjZ4fkMK/pJe++j6An0sTts3RVqYdLqPA8zxP2jzPUKf2UHog1Q9YM7tiFtVAAY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzf3nYV1X7URS8MNi6HlfO6a8dCjGG4uMhKzWgZMGqXQG+OfAKt
	ZPRLn4WGo6fv8g9HAzTmxgnHesYoKc6bsYFz3WJo5lbZ6ObCMLrpIFukmqM8bddkZg0=
X-Gm-Gg: ASbGncvvBH1FSRRIBeEzBIE9pemCkTIzX9+2z/UcTzWYLHrIW8RYrTOPV9XoMJwhzbT
	tcp4/xicAdBhmApEay1AntWFGoFqqmEhdcK5J/ortQ0BPAXb0W3CA90LSYr4FReeV00OmoTs3So
	/OHal4ZlyYZd9eAeMdqux6XvELLO4xWONYsseUBiUV0bX8+/Fd+FhTztqgchzntUfeO1uOspUdk
	h0hWohf1pemS9ciX1RG/R/N/70eGwUXJEfybPkVUtdw+AmmCqXnVULA6/C0WrvF8tEJ85hh5PLa
	CcalapZaXQg5dsbi6axl+83TBPlXr69fKQ3lNpDE0zUJ2t4Tk8w11k61djaBv9HevmXl6ZZDz3O
	39NBA7M29leVMGh1n1JCJTCOwjJ4775tb7J44qcuewyl4/eJVaM8yO/Cq1duautD+A6RPLqo9Ei
	i4lVuhSZd6d0ex/yb99w==
X-Google-Smtp-Source: AGHT+IGxBmhQYX3R+zPm2DZoyJZbHJDy6/9CVQ6y+y0VxQf1BMG2L8qFAVrrjtQYPgaGrb29h3irDw==
X-Received: by 2002:a17:90b:44:b0:32b:623d:ee91 with SMTP id 98e67ed59e1d1-33bcf8fd82dmr28272717a91.27.1761205854513;
        Thu, 23 Oct 2025 00:50:54 -0700 (PDT)
Received: from z440.. ([2601:1c0:4502:2d00:2035:6c3d:cc34:bc90])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33dfb1dbddbsm3809280a91.0.2025.10.23.00.50.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 00:50:53 -0700 (PDT)
From: Igor Reznichenko <igor@reznichenko.net>
To: linux@roeck-us.net
Cc: conor+dt@kernel.org,
	corbet@lwn.net,
	david.hunter.linux@gmail.com,
	devicetree@vger.kernel.org,
	igor@reznichenko.net,
	krzk+dt@kernel.org,
	linux-doc@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	robh@kernel.org,
	skhan@linuxfoundation.org
Subject: Re: [PATCH 1/5] drivers/hwmon: Add TSC1641 I2C power monitor driver
Date: Thu, 23 Oct 2025 00:50:50 -0700
Message-ID: <20251023075050.254998-1-igor@reznichenko.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <be691214-bac6-43d4-be62-daa57c833fe7@roeck-us.net>
References: <be691214-bac6-43d4-be62-daa57c833fe7@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Guenter,
Thanks for the detailed feedback. I will address it.

> Please send a register dump.

Here's register dump after init during run: 

tsc1641 1-0040: 0x00: 0x003f
tsc1641 1-0040: 0x01: 0x0253
tsc1641 1-0040: 0x02: 0x0dc0
tsc1641 1-0040: 0x03: 0x0053
tsc1641 1-0040: 0x04: 0x0250
tsc1641 1-0040: 0x05: 0x0033
tsc1641 1-0040: 0x06: 0x0000
tsc1641 1-0040: 0x07: 0x0000
tsc1641 1-0040: 0x08: 0x01f4
tsc1641 1-0040: 0x09: 0x0000
tsc1641 1-0040: 0x0a: 0x0000
tsc1641 1-0040: 0x0b: 0x0000
tsc1641 1-0040: 0x0c: 0x0000
tsc1641 1-0040: 0x0d: 0x0000
tsc1641 1-0040: 0x0e: 0x0000
tsc1641 1-0040: 0xfe: 0x0006
tsc1641 1-0040: 0xff: 0x1000

> > +
> > +	/*
> > +	 * Disable alert mask first, then write the value and enable alert mask
> Why ? 

The idea was to prevent potential previous alert from propagating when changing 
the value, plus to only enable alert when crit/lcrit value is non-zero. 
But given your response below this is not the right thing to do.

> Disabling alerts if the limit is 0 is wrong: The limit can be set
> to 0 on purpose. Only unmasking the limit if a limit is set is just as wrong.
> Either limits are enabled and reported, or they are disabled and the attributes
> must not be generated. Mis-using the ABI to declare "If the limit value is
> 0, mask the limit. Otherwise set the limit and unmask it" is unacceptable.

Thanks for clarification. So would you recommend then that all alerts should 
be always on/unmasked for this chip or to add custom sysfs attributes to control 
them, since it has this capability?

> Either report as standard voltage (in0_input) or drop entirely.
> The shunt voltage can be calculated from the shunt resisor value and
> the current. A non-standard attribute to report it does not add value.

I'll drop it since the shunt voltage resolution is 2.5uV and it won't give 
accurate information to report it in mV.

Thanks, Igor

