Return-Path: <linux-kernel+bounces-776531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5883EB2CE90
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 23:32:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC1053BCB02
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 21:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19996284896;
	Tue, 19 Aug 2025 21:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pinefeat.co.uk header.i=@pinefeat.co.uk header.b="eGXwtxI8"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D0A62620C3
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 21:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755639160; cv=none; b=HQSTP5Hyv47FTJFQ5r4H1uLMF/93VpW+/7U5a9I9MwDmVRD2Ynlrxss5wjm7bfi3wSPXraTd5sdprmdjqaokY4JJgiuEq5uHb76sumpl4hu5VTZd8dg/bgUAysCfBgzx7EeSJP0+qrkszOqBycuu2IhywEMRRs12fFaY3bGAdyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755639160; c=relaxed/simple;
	bh=jc3BvvZPYp6Ws/XW8HSSgCQw3zydyc5fLCTQ3ZrChS0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ylu8BJwABP+V6Gp5w25unP1aQ2M+HtIO+Z3yPbeXviU0wxAze7rJlR8c9j30QdeeumdBCks3zDDv7fnrLMQaqRUK+voyfYxLYd3KLmP/4ZaCS9xo+gLxamcn9xdvSnxn+tcSN05+U5sq9gXHbNL35JyRJO3Qo5R7mbBuC5jOfQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pinefeat.co.uk; spf=pass smtp.mailfrom=pinefeat.co.uk; dkim=pass (2048-bit key) header.d=pinefeat.co.uk header.i=@pinefeat.co.uk header.b=eGXwtxI8; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pinefeat.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pinefeat.co.uk
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-45a1b0d231eso32326395e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 14:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pinefeat.co.uk; s=google; t=1755639155; x=1756243955; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6BYh4GCaj3UOu780opvLnkEvnPL7yLCaLlvBDFyBcyI=;
        b=eGXwtxI8ii6Sw2dzensPh1P+zTTk+1PpIHrNiyyu5RX9lyyGZ1n76v6U5rwPwfGdOT
         0iIifOyvc752DSQikM8GDb16XELBuXScws/cYfipEVe4gh/ow6e9Zig6V9JKgsbRwuBo
         0c8+Pcjx3nJDqMolBjussNoNpnLWPX8HOHBcIiQhtVdwBHkx6TlQqfm5moxTSt0ISpgZ
         LhaqayK6nxzqp/KeOi13uXrdHM58NCNkZy5faiZhGS1q8m+R/7LlDDrSMoUk5WVaWQHv
         9X0+wLuDda1pcKsJDij9cUBwMOfEIFUb6CTwHGkvqtDHOZkNHxNkBdMwaLeQnHtPJpGJ
         qVgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755639155; x=1756243955;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6BYh4GCaj3UOu780opvLnkEvnPL7yLCaLlvBDFyBcyI=;
        b=sAPdWAlSEIyWpeN48ApnE0tjF3DVKl42WQFmbyDmJmA0LV3x+tvUJcW2IDLszDTcv2
         FCZaKjsqyiRj36OxP0tSdNnPk0HCBxdL1JpqoMjfQMi5+bm+YweAS/zKRVW9XTdzluZU
         azHVx7MRx3PgELUANQXI1NCt90J3xfyNSwKPRrenjyU/R5YwKQxX0iSLvDVtCrb6FX98
         jCOQ+9BEsVyXtvw7feIB4azZa7QXQdSs1z7+74imIuNdHMAR0qlFtVWkT74oafMv3FBq
         h31zKd2OBgC75dJhdmv3PmMqkyX2a5ReIS86UAbN65CcK+WLlXClsCKbB6F95pTk7xsC
         VwZQ==
X-Forwarded-Encrypted: i=1; AJvYcCWw2iS0KWKpXm9qiQbcDTNZyhKKI55MzJlkdh0+2u978sI9sPWD9WMsKxSO00grpB/C6gk9JhsI0yhv7B0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzg/DRM8/TscwrLA3u/x92It8pTVKxXO2iwmF2bbzO6lmgbcitp
	UzCQiBdqhmtiSFl9ZwaGHoC0v9ozNxSljLf9ve1xA8L1iIj3EFfGqMlHUQUyP2FfK7g=
X-Gm-Gg: ASbGnctRy/0ytkHrevwZSR7r5+ksIHuiDflsZVIwuGxATlblGZ4a+dDP2F9dKVpRlmG
	5q3hTrF00+nT5Ggr8pD9hE4wgkVg1vrPtGoFk+1nkl8nRNj3C02EYQrjyPm9yT76FF7+sp+EGnX
	jaJHx6em9aQbGTL9x3oSlqB+DYN1T6wnZDTtyhH75DNhORzkBrowhVFE0OS4JkJSjcl1ooa2vYX
	nF2EutBfWjAnBpW5ue1WC2WwndAFjul87u0oekKwsBjSu0MzlHctWeOWRM1QmcSLXPBHypSrUJv
	Ypuk7SrkZ8TTb48w/egMOqfeEjTVtCibRFkewwe2pE1ccMvMSvDHAhX9e96Edn4Zc7Gy6eA9m1M
	OP/Z3uM33uKao34h4saL0lCfztqRqHa99IhkYrHaZ
X-Google-Smtp-Source: AGHT+IEcyNrxp3SHEyt2CBRL9VUsDkFP7P0pHC4zqMyxndYLah7gl2FLCMywmLM6ECrvuDEPDmirIA==
X-Received: by 2002:a05:600c:1988:b0:459:d645:bff7 with SMTP id 5b1f17b1804b1-45b479b57a0mr3202945e9.12.1755639155215;
        Tue, 19 Aug 2025 14:32:35 -0700 (PDT)
Received: from asmirnov-G751JM.Home ([2a02:c7c:b28c:1f00:f371:d547:373f:e542])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c077c56454sm5090606f8f.58.2025.08.19.14.32.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 14:32:34 -0700 (PDT)
From: Aliaksandr Smirnou <support@pinefeat.co.uk>
To: jacopo.mondi@ideasonboard.com
Cc: conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	krzk+dt@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	mchehab@kernel.org,
	robh@kernel.org,
	support@pinefeat.co.uk
Subject: Re: [PATCH v3 2/2] media: i2c: Pinefeat cef168 lens control board driver
Date: Tue, 19 Aug 2025 22:32:34 +0100
Message-Id: <20250819213234.18378-1-support@pinefeat.co.uk>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <4qxxvvzxbbdukjn5ykjxhgj6kp2yqd4bidpl74ozbrwtt2jgjj@ipleqjgnnpys>
References: <4qxxvvzxbbdukjn5ykjxhgj6kp2yqd4bidpl74ozbrwtt2jgjj@ipleqjgnnpys>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Jacopo,

Thank you for the review. Your remarks are very helpful. While I'll apply
most of them, could you clarify the one regarding pm_runtime_ for me?

On Tue, 19 Aug 2025 15:47:54 +0200, Jacopo Mondi wrote:
> > +#include <linux/crc8.h>
>
> Do you need to "select CRC8" in Kconfig then ?

Yes, I'll include it.

> > +#include "cef168.h"
>
> Why an header file ?

Ok, I'll remove the header moving everying in the .c file.

> > +	for (retry = 0; retry < 3; retry++) {
>
> This seems a bit random, why do you need to retry three times ?

The driver retries writes to work around an issue in the Raspberry
Pi's I2C hardware, where the BCM2835 mishandles clock stretching.
When the slave stretches the clock, the Pi can misread the SCL line
or sample data too early, making it think the write failed. To
improve reliability, the kernel driver automatically retries the
write, effectively compensating for the hardware's timing bug.

> > +	    ctrl->id != CEF168_V4L2_CID_CUSTOM(data) &&
> > +	    ctrl->id != CEF168_V4L2_CID_CUSTOM(focus_range) &&
> > +	    ctrl->id != CEF168_V4L2_CID_CUSTOM(lens_id))
> > +		return -EINVAL;
>
> If you mark them WRITE_ONLY wouldn't the core take care of this ?

These controls are read-only. The data they return depens on the lens.

> > +	struct cef168_data data;
>
> I thought the compiler would complain for variables declared not at
> the beginning of the function

Ok, I'll move the variable at the beginning.

> > +	pm_runtime_set_active(&client->dev);
> 
> Is the device powered up at this point ?
> If you depend on the pm_runtime_resume_and_get() call in open() to
> power the device up, then you need to depend on PM in KConfig ?

Yes, the device powers from 3v3 rail of a SBC, which makes it powered
up as soon as the SBC is up. Given that, should I remove all code
around Power Management Runtime (pm_runtime_*) as redundant?

> > +#define CEF168_V4L2_CID_CUSTOM(ctrl) \
> > +	((V4L2_CID_USER_BASE | 168) + custom_##ctrl)
> 
> I think you need to reserve space for your controls in
> include/uapi/linux/v4l2-controls.h
>
> otherwise this will never be visible to applications ?

I found there is no need for that. Custom control become available
automatically by name via the v4l2-ctl utility. For example, the focus
range can be read directly in the terminal as follows:

v4l2-ctl -d $DEV_LENS -C focus_range

> > +/**
> > + * cef168 data structure
>
> No need to kerneldoc unless you properly document all fields and
> include the file in some of the Documentation/

OK, I'll remove the comment above the structure.

Kind regards,
  Aliaksandr

