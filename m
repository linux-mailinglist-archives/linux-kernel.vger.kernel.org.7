Return-Path: <linux-kernel+bounces-846061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 03C0EBC6EDC
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 01:38:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E83444E7D52
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 23:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2CB22D0C64;
	Wed,  8 Oct 2025 23:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vw7Bb92h"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D052D061A
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 23:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759966510; cv=none; b=ICYq6OPVMaW5KLutdCcjKAFpgilMzJANvXKk2Stv2ucoP/T+JUy5T693Cf0jS1oToldkCBrd0KaZ3xpTgD1CVRbXNoP3hnGx4A4yxdfqyCs9ektd8BJiwuLqwbVt3RwDZKm0VbsD5JHFpW/A4PnJRLUFdx+u7ysgW1vimVUYh/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759966510; c=relaxed/simple;
	bh=9igNQRi1zsIULgFOJ+Hpha80v02kSWzsiG8eRfeHWOg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WWibqGkRgTsO57+Zremnz6uJuV5L8gqXoCLuIzi7g48AkNmciNRy5bf2W/lGXU2xTc/lxfpQoPV5awiSF/dFCrn6AkusHAyxnr7INOBXwybp79Y5cKT8oOE4n0biYhvoJpex4I4HPonPFrvczSZdoahlH+w+CGfHJXahRkeFDcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vw7Bb92h; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3f0ae439bc3so189473f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 16:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759966507; x=1760571307; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9igNQRi1zsIULgFOJ+Hpha80v02kSWzsiG8eRfeHWOg=;
        b=vw7Bb92hM90H9chxoWRY7TYUuNiZkaPWRN8l+Rh0APRdDAgKPQijy8I0B0+/yG+vMS
         2QxwPhHyOzPjOqQXmGf7kto9UTlPIOkm+SSSU7J8EQHt2gO5keOeUlQM3uZDLzkBoVcX
         Nb2y9450owpUl9irmBkbQdw61by0hcAWmRc6csFjcEVypZeVemzjBtr2KlTfD3JcHfMP
         BpiuQa+9pKuuCpQfg5+wl2RUHJWLvb7yZ5Pvsw56ModGSQ3MLHnNJb18K7nPgJWMtlSN
         X9avtg1e0LT8tvXdEk7B+F19TrJgDB3vKjdFmZ5mlx34Mu56ePezV8zS2/o2xDeuDnSH
         jlXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759966507; x=1760571307;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9igNQRi1zsIULgFOJ+Hpha80v02kSWzsiG8eRfeHWOg=;
        b=hFK7+i8AEYOBHylI08fM69y3ZwjSuQjjOE+ycfLPQe/YKRJC8KJ0Ya1emvw3v8Vf1J
         F3Hx6aktIp5ucOkpV1qBRotNvirdiAB0sjHkZ++uRx72b73fPCKJz/0uAokhzEj82BCU
         uphavwrW92fDHGQfcMLTWfGKkKJ0AEKqrzfadje3a3KSD8MS/27Ktmqd6/iRfwp5SVo1
         K8q2jGOBGvFjsROjPaO49aPNby5URZRdN7LDuvIopgc2lwnm62u15kU8Rv9SAPp3LNiS
         //FrpPHgan/cVqYwWf6/U9/u6cgSHrQ1hkg8r35Ezco6jnHuvswqeicRZx2exILS1Z1R
         Uc4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUeHdWpLESYxqB8gi7sNGJFi7WTdjnXptJ4Xu2tMqMLe1chVxrUiBkBJQCqbFWQGqINEDYlXN28ev3a704=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+dqZeRDXXyEeW1ql/6IMnWF6IFNegfmh0uekTpkeCPorSPzh9
	rmkOd4G4VztQT9OVETzA2cke65O0eT5oi+9dHuUF1HP4ZoXeHxLWaWngYKK+Rhzh8VrLJdiNIYI
	rYWyZlbBAOsvaYWOE1ZQ9OHl5ZbwdFlBN69krLvUe
X-Gm-Gg: ASbGncvjqc6T+wCFh3rBb4p9TFRRNSjc/hTzIZQ0NwQ7eoXQQDLfMmMeu3Z2QluWv0/
	HVJRjs9IuFXNGAQN62DDtkZDgS41Jod5rHsoKBMdizVSXxL+0Dy9HVQEzPfb0tNRpvgOjAqD347
	iXG1ckKZCAiYnTpkETeRNQjf62/85Jy8jibQLWiRc0SSd3AW7BFrn6xOyj1ote/7gFkn59OT7aI
	ryYPKKXY8+xq3/lysNDVexN84v3GV6NjPJU97bn6UrFdr5pt330UKi9RFz5INHXkGGr6XKa35wR
	C0Pc4bdabdUDYg==
X-Google-Smtp-Source: AGHT+IEqmdZ9VxhWMpDcRldSURNd0QiDBJUs0+1kYdV5l/JzukTnaa5H9DzGsLurz4/S6KkfONlhR48b+fTHniX4RxU=
X-Received: by 2002:a05:6000:4313:b0:3ea:6680:8fb5 with SMTP id
 ffacd0b85a97d-42666ab29d5mr2881250f8f.2.1759966506486; Wed, 08 Oct 2025
 16:35:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251001193346.1724998-1-jthies@google.com> <20251001193346.1724998-4-jthies@google.com>
 <aOZUq6K8bZtciL6Q@kuha.fi.intel.com>
In-Reply-To: <aOZUq6K8bZtciL6Q@kuha.fi.intel.com>
From: Jameson Thies <jthies@google.com>
Date: Wed, 8 Oct 2025 16:34:54 -0700
X-Gm-Features: AS18NWDl9Wn1v62FRwVNd2rJ20xgecQEZIHrqIoqrT8lQI_Q_BqxHXid5fR55og
Message-ID: <CAMFSARfn_ULu2+JXjGSjz4KPDOSD=MAcKS8XwZNqbHf7YL6JBg@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] mfd: cros_ec: Don't add cros_ec_ucsi if it is
 defined in OF or ACPI
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: akuchynski@chromium.org, abhishekpandit@chromium.org, krzk+dt@kernel.org, 
	robh@kernel.org, bleung@chromium.org, ukaszb@chromium.org, tzungbi@kernel.org, 
	devicetree@vger.kernel.org, chrome-platform@lists.linux.dev, 
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> If you are not using that for anything, then couldn't you just use
> acpi_dev_found("GOOG0021") ?

Thanks, this is a good suggestion. I'll switch to acpi_dev_found() in
the v3 update.

> Can there be multiple UCSI interfaces on these systems?

None of our devices will support multiple UCSI interfaces.

