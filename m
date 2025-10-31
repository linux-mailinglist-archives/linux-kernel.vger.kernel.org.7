Return-Path: <linux-kernel+bounces-879948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F08BAC2473C
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 11:27:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5B034017FB
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 10:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3100033FE02;
	Fri, 31 Oct 2025 10:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="1XTiHZWL"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94FCC2EB87C
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 10:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761906437; cv=none; b=s+tI8bJLjOTwiLhqa/HCVlplSwBDI0vIZC+904M1O7iUsOd+FsTex1hDWLs/b16NaT6aHhbxmzOk1gshLXwbIBrb6NmMr1nKLpbrUXhrRrgDTM2vKB8mIyPmGLRy9cK0YZ26biEfDDMs8Yl1CBTrV8QdkU+se0bWaaJLfs2AcaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761906437; c=relaxed/simple;
	bh=LZJjK3oBrjpMjUbg96mJVTjbUwuIdFSzDRhJE0m26JQ=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SURAWQ863akM3xAo1iyplAvET6lQursJEBDOVKL4dW06ZE89OvVAfDh4PdchwZPvm29KY+mBs1Ka7UU9DVgzJlZBaWQWyvV1SwpGR/DKE6dW2qoCG/MmEDAJ6yU8yIxlT8gQbcUd7Y2ZhlXaMYIeF0NQl40XHxImNqs2F1pLW6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=1XTiHZWL; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-36bf096b092so19157501fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 03:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1761906434; x=1762511234; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:references
         :mime-version:in-reply-to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pNOU1iRdcbi0x6KU+9+XlLF3cgDUgehMK+0RcldpnIE=;
        b=1XTiHZWLRywz1jgUl5oU4KKcSWlnxkl5AuoB8ztAuIRNjofKjiZOl5QQMN213ASpIk
         /63Kvs8dR43qiY5kzd64ke4Np6NVDZuUScBIiCkfnJKQ4kUWDOPPl/9ti6nBMAPcOvff
         XyC3XkfvGHRb04KpmvzUtiejHsDeyOdzsi/LWG3R1y/Dv7ZC80cuwTY9k6Ld3U0hnTgr
         1tENe9LJB2Vkg+511sjc4hJP6RyWJFyD3bLfBbpJSHDFqo7Gx41t4j8YBNYZX/TzU2wo
         5+32MNlcWW0qxZJA9ZFTw3rnqCEZlHIyjIZME/HeQSodN6HyEpJgBKRvwfqM580XMLXV
         FBGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761906434; x=1762511234;
        h=content-transfer-encoding:cc:to:subject:message-id:date:references
         :mime-version:in-reply-to:from:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pNOU1iRdcbi0x6KU+9+XlLF3cgDUgehMK+0RcldpnIE=;
        b=Lb2nBCNfr3zlIyqDeOxEUr7sXHsUo+DynYvEOUIAqXdkYxhNwaMbJNlGmxMBecJ/k4
         BolqARjn5ZL8nRCod/TfX4++0Hapin/3gSbfTGyHnVC/IV6YzuTFqtpE+A/u5Xwj1WGo
         tKDhrGB/yr7330MkF4KN8I4cIUmZUPGBopZh4uhEB0I/qK8w0OdP972K6RWbGLcTTk54
         U3FlvlaUgUl5T8U7kgnUSGzF+lqKroNqTQa3yFvtoWHdhP4Bai7Oo/eUeGCbzDWXBoSi
         AIM3F1yCtKlfiibkHJ7GUnAaAE/2TugF5GvX8SYkJIdoBTPWQpGAWYWSW+JPA1DNuryj
         R4jg==
X-Forwarded-Encrypted: i=1; AJvYcCVDuH4KQZcLByYjHdZQou9GULavY+8LJlOiBedf5vV/D7tBHoCXxX8PIEFMZa7BNvd6owEnP0UvyqH3M/k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6b87TZmjnYEdOUWNTqBD1GjtYHPNi2rLxdVj/QVo3/OZk58K5
	PcaaKktvJ1j3MRkD16Tg9tRgi1X/R7ezXSCjvDHvgCSA8+96wOEaGQpsXas7oq4o9MsMcsTaAIc
	oQaZdxtSR6Tm/ivkqeeVKmljeM5jN3YSWCWeBCF6FLA==
X-Gm-Gg: ASbGncvm5PEsS6naCv12h0W7gNt5VGXOPZzpvUTzmpPUIZQhGHCwzPqntjaGLPEDIdg
	AqXYTSe1b3KgdbXIe2dzlGVKUvTa6rbR6MN46PleUx5g/NuWJaizeyFv2rMWYrIOAhututIQdvS
	vy8hONj4zYiThElQC6IYhXbGaE6MRuLZFl7TSYqKNGJep+xZBqdD+obNlIQ+wMEoBXznH49GlsO
	rRsk4n+KpilEB0iL1/QEL/Op55Zac+IlJRh8JiWt2sgdYZIV2Pi7npHYxE/k+llYYOiyw16XNL/
	m8Y9LrmGuvo/dsYF
X-Google-Smtp-Source: AGHT+IFo3peC5StgeTxxGQqDBXnQdp1UAiFfDKKeZSL+XtcRWdzRvlhIPKe567Wwjp5cIPhZ6+UfJrC81qMWudtMilk=
X-Received: by 2002:a05:651c:31d4:b0:36c:7a76:d17a with SMTP id
 38308e7fff4ca-37a18d87b15mr10021321fa.9.1761906431943; Fri, 31 Oct 2025
 03:27:11 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 31 Oct 2025 05:27:10 -0500
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 31 Oct 2025 05:27:10 -0500
From: Bartosz Golaszewski <brgl@bgdev.pl>
In-Reply-To: <aQSFDhUp89xul2AP@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251029-reset-gpios-swnodes-v3-0-638a4cb33201@linaro.org>
 <20251029-reset-gpios-swnodes-v3-2-638a4cb33201@linaro.org>
 <aQMxNgC9SWQp-yUy@smile.fi.intel.com> <CAMRc=Md=Dcwj0qDu5ysDafjuV0Ud9z2Ky3PQpDzfiKRt2L-HgQ@mail.gmail.com>
 <aQRztwrOFCWk8IG8@smile.fi.intel.com> <CAMRc=MezQ7RC=ZjiKkMa0qiaKTRXePOKxOCDjjV=-qUYto2jqA@mail.gmail.com>
 <aQSFDhUp89xul2AP@smile.fi.intel.com>
Date: Fri, 31 Oct 2025 05:27:10 -0500
X-Gm-Features: AWmQ_bmvuRg5selCz60KVvdQ444EnQp28Ff1ZBUj00ynWwJi8NQDD4tLMKkPhnk
Message-ID: <CAMRc=MdfbbkWBeAgw3G=k7xgSc8TPhZQ56ks9Or9p9Ah-y5YQw@mail.gmail.com>
Subject: Re: [PATCH v3 02/10] software node: increase the reference of the
 swnode by its fwnode
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, Linus Walleij <linus.walleij@linaro.org>, 
	Daniel Scally <djrscally@gmail.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Krzysztof Kozlowski <krzk@kernel.org>, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-acpi@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 31 Oct 2025 10:44:46 +0100, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> said:
> On Fri, Oct 31, 2025 at 10:03:47AM +0100, Bartosz Golaszewski wrote:
>> On Fri, Oct 31, 2025 at 9:30=E2=80=AFAM Andy Shevchenko
>> <andriy.shevchenko@linux.intel.com> wrote:
>> > On Thu, Oct 30, 2025 at 03:33:02AM -0700, Bartosz Golaszewski wrote:
>> > > On Thu, 30 Oct 2025 10:34:46 +0100, Andy Shevchenko
>> > > <andriy.shevchenko@linux.intel.com> said:
>
> ...
>
>> > > Andy: the resulting code after patch 3/10 looks like this:
>> > >
>> > > struct fwnode_handle *refnode;
>> > >
>> > > (...)
>> >
>> > Let's say something like below to be put here
>> >
>> > /*
>> >  * The reference in software node may refer to a node of a different t=
ype.
>> >  * Depending on the type we choose either to use software node directl=
y, or
>> >  * delegate that to fwnode API.
>> >  */
>>
>> But this is incorrect: we're not really doing that. We either use the
>> firmware node reference directly OR cast the software node to its
>> firmware node representation. We ALWAYS use the firmware node API
>> below.
>>
>> This really *is* evident from the code but if it'll make you happy and
>> make you sign off on this, I'll add a corrected version.
>
> The comment should answer to the Q: "Why the heck are we calling fwnode A=
PIs here?"
>
>> IMO It's completely redundant.
>
> This is unusual case for swnode API (see other functions, they call direc=
tly
> the low-level implementation instead of going to a round via fwnode). Tha=
t's
> why I insist on a comment of this piece. It may be obvious for you, but t=
he
> unprepared read would be surprised by this inconsistency.
>

I propose to have the following:

+       /*
+        * A software node can reference other software nodes or firmware
+        * nodes (which are the abstraction layer sitting on top of them).
+        * This is done to ensure we can create references to static softwa=
re
+        * nodes before they're registered with the firmware node framework=
.
+        * At the time the reference is being resolved, we expect the swnod=
es
+        * in question to already have been registered and to be backed by
+        * a firmware node. This is why we use the fwnode API below to read=
 the
+        * relevant properties and bump the reference count.
+        */

This at least adds relevant information on *why* we're using the fwnode API=
.

Bart

