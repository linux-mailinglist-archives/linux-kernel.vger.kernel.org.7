Return-Path: <linux-kernel+bounces-749912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DEE3B154B0
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 23:33:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0E6918A1C3F
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 21:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE76C221FBD;
	Tue, 29 Jul 2025 21:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WbVmLPt/"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E597E202C45
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 21:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753824827; cv=none; b=CL48nDWHjTYBGn2S3UV7N/TNhUy0c4hrxDVfAVm12CDq9ooYHZ7Z0+sMfjmZ4uK5oPVRKYAzoAzhVtXcwqDKH1m2xBwqlIZT1SiZbuPjecS0RTCyHbwXKggUZpKVHGv6YqavS+i04q9N6w9OEMw/P4i3VUTL6JW+Bl2NzXBVs3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753824827; c=relaxed/simple;
	bh=oK3zudS5L3oyJg6+qzi2hiSX0O/6W697rLcB9Z7qPcI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mS6klnd5i9O0XHdLgAxnejvg7rTLSEprSe0AwVYX92Mah6+R7xbGO9VN7a/bbE2Ibq9/lBJR6SJfQ4EXWS1WstOAl/WI0lKgOnJKVbanzqOpW/BheKrOMgOUAGSrTUmMIAHhzPRNs+x5d0iv0rwum4PHpc3SFTq0KcCKCaFpBrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=WbVmLPt/; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b31f0ef5f7aso3325077a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 14:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1753824824; x=1754429624; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oK3zudS5L3oyJg6+qzi2hiSX0O/6W697rLcB9Z7qPcI=;
        b=WbVmLPt/lMwoYjz2tfPeV2l5rP87nFDByOBrjdbmAx0ZzzMU5OTHwoE2x1dAjGeeHO
         FBzTpvylzU0lZPmvnE5mXLR29nixzN6i91I5E0MxvmpRyMmK7gT9FpVP1aDILTBagtsQ
         xoPLRw48X/waQHjyd0tVzzI9V2u9RSoEp5/aE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753824824; x=1754429624;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oK3zudS5L3oyJg6+qzi2hiSX0O/6W697rLcB9Z7qPcI=;
        b=QVXAZK1oVadN1qLTlui9V5BSHppXEOqHljwEWPNzUUsYFtI6G5ZdMYFZiimqkRMsE2
         Sgo1rUP5siqt1Ssy9nNyTIk1KE8kUFIHcrKLf7i5D7kRPso3OVb4hgpU/AZei7OtaIlm
         FVtSNoco+ai+afwrVn6YkLbRzP1UpC6SN4qrEUqiGxZ4VB16Oq373XWaYh9+vpaw3Jas
         +QwCwLLrff3Mb9E47vrPrAqNNbqCN93YrFReokWb17QJQ48Od7CLjuLu64315QyY1eXe
         6YHp0QXpPhM3YghetJatlXr6SAOeuYxtc3sUh/Lv3wI7KiS4n7qrERxR7k0q3Mo6k4yg
         gsxQ==
X-Forwarded-Encrypted: i=1; AJvYcCVhVLtXBOXwIj6FwBWyYS7OIzYagEh/dIENND0Bqd6fB6991rWGN6X7qjnHToDR0ZJ/GClWIqvHVOBgFck=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuqeAFbi6xFrP+T/kMY3Fw0ItqRucHtnLcZta5HUaMfT0QjL//
	b8bzNVWmzvF8rsdAAW0sQEkr2yHwTyRll5+/HZfuGfSxfhfcANwLV/5glTdRODh6+NM6Ne0dNLi
	p2Xk=
X-Gm-Gg: ASbGnct0srwP+diccT8eyYuFZfLS3LDxvR/vbFuiuIyW2fTQqa7bDrcGaTzU3VM5M2P
	fg4/kF81MBcmHlD+T9CiqVQNY1FIsoQxj7D0cjfVKqyLZm0njegZkUNMjn6+ljUNJCWkI4h8NDg
	dtTzHfPAZjOlJ9fpTzNCvPZ+jUoKm7ut4x6FpRF2fcDVSStg1f5nYJnP4DdAcEg18v9YoR1M7sv
	/klbvy4vjhmElde5zeaoJYsZU4HlNsRlL5y+N0EaUjfskW3ihhosQ4dbl1+ZyFhGZRjFVvvN7sx
	P4CgkYxXfiR3qzuI/CtNQ67b75pv5g8QUjeRa3KKTeRS7QbvdiIsSLIjT/I/LEqPugz3xmwQ7Ki
	JGNBc1e8GnyZl/lK4M69BY+Zguaj0SwtEbL9rnQDV0LQARTrITY0Girw0YelEYA==
X-Google-Smtp-Source: AGHT+IEL8bd3om6tlIeUHixpd9ijASPbZxfS5Fk01i2umGCOXesMkOpSRgoZH9ADRGaeQXijjMj3uA==
X-Received: by 2002:a17:90b:3d0a:b0:31f:42e8:a896 with SMTP id 98e67ed59e1d1-31f5ea4ca0bmr1092539a91.34.1753824823673;
        Tue, 29 Jul 2025 14:33:43 -0700 (PDT)
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com. [209.85.216.52])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31f63dc1bb7sm93001a91.10.2025.07.29.14.33.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Jul 2025 14:33:42 -0700 (PDT)
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-31f02b6cd37so2488735a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 14:33:41 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVeihGkKQ5FEw843rH1Sb9gJnpCOdB+Y2sFpcKUMuvUE2OBT5aOisXGaWbtV6aeyXbfD08cqKArd5Vt39c=@vger.kernel.org
X-Received: by 2002:a17:90b:5623:b0:31c:23f2:d2ae with SMTP id
 98e67ed59e1d1-31f5de41b29mr1394160a91.15.1753824821327; Tue, 29 Jul 2025
 14:33:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250729054435.1209156-1-me@brighamcampbell.com> <20250729054435.1209156-2-me@brighamcampbell.com>
In-Reply-To: <20250729054435.1209156-2-me@brighamcampbell.com>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 29 Jul 2025 14:33:29 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VUdfTT4AJk77BFXWy7q_je0EbRKWc=nUVevbgitkn0gw@mail.gmail.com>
X-Gm-Features: Ac12FXz30yn8dPIvGy4yhci1kLmxkqO0_5A7uc1Q2WfPuAiJM5bHgzJdAchVJwg
Message-ID: <CAD=FV=VUdfTT4AJk77BFXWy7q_je0EbRKWc=nUVevbgitkn0gw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] drm/panel: novatek-nt35560: Fix invalid return value
To: Brigham Campbell <me@brighamcampbell.com>
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
	airlied@gmail.com, simona@ffwll.ch, linus.walleij@linaro.org, 
	neil.armstrong@linaro.org, jessica.zhang@oss.qualcomm.com, sam@ravnborg.org, 
	skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jul 28, 2025 at 10:44=E2=80=AFPM Brigham Campbell
<me@brighamcampbell.com> wrote:
>
> Fix bug in nt35560_set_brightness() which causes the function to
> erroneously report an error. mipi_dsi_dcs_write() returns either a
> negative value when an error occurred or a positive number of bytes
> written when no error occurred. The buggy code reports an error under
> either condition.
>
> Fixes: 7835ed6a9e86 ("drm/panel-sony-acx424akp: Modernize backlight handl=
ing")

I think your Fixes tag is wrong, actually. I think it needs to be:

Fixes: 8152c2bfd780 ("drm/panel: Add driver for Sony ACX424AKP panel")

Even though that commit that you pointed at moved the code around, I
believe the code has been wrong since the start of the driver.

Other than that:

Reviewed-by: Douglas Anderson <dianders@chromium.org>

