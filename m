Return-Path: <linux-kernel+bounces-872547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D709C116C7
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 21:41:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0A2DF4E17B5
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 20:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F04231BC8F;
	Mon, 27 Oct 2025 20:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="adPyGM1X"
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC222E62C4
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 20:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761597697; cv=none; b=u8WyL4huMeHLQ57YeTHme+m4BNBePWWeTHdclfRTQNrZFAx4/QxDZVLqsAZQcG7GaCa1dlJo6w6S6ZnxqragkhfDaBfToJ6Yb8eWBtD9QO1dg1K2JRrULUQQBI5+UY+TT+vXac9SWjk7xBtdUYU1AcevubCsGC3MueJZAYRASJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761597697; c=relaxed/simple;
	bh=Bl32hd8+nZYs/Ek7MiWS9IBWG7+TZXS4JVZHy9gRrcE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nhoJ6UzC4blU1BlAW6ueIueBQsPgPOY4K/wpMsO+FwHy9hs2CJlqiHMA/v+25hR4optG6BfGl53FUp3Fmjn5nX0ZvkOV581F4Ik0z229GbzkHcr27hz6KEwJIynrs9mU3L8/t7laREgr0RuT6JAhixCSrK9JuAOO9SuvtMeEhdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=adPyGM1X; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-93e7ece3025so198511939f.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 13:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761597695; x=1762202495; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=V33D0O4zi9GNuJTw8vBA+/b7xPb0jr7CJbcC2/UPqBU=;
        b=adPyGM1Xx0Nj8+txk+x51KcgGxn06jsv3kG++ASxjvenokGtNRroEPOrlMW1jDlMCA
         Nf70uJ8hBCqNnS5GuKeWy5PFp704bF5Rqp9u7e4eI6qK4QP9RrFlFshBp6bR0D8w0jLu
         n+gl012JLgflqqtZ/fWqsxCSSWAmOSlb+u/Ytzu6ptZynBF4TsKCddLNsEcgbGBqGrbu
         9zpmk4BpGBp/vTF7l0QGHXWSiSTRBVouu1l/1vRdQGydr5bQzuDmd+RZHOSxHmBAEQ2N
         8zw8o7vdOZuE5CL+ykSWUXQ+fqZWy2mmWOPweFcJftQI7Ku0QbZXyGSi7JBy00xPnjU8
         thRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761597695; x=1762202495;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V33D0O4zi9GNuJTw8vBA+/b7xPb0jr7CJbcC2/UPqBU=;
        b=F/rH22hK94Fol2YKCLwtkesJiLefJoHVcnZv53ox9aNYXtilEAWCbNauur1AoKxn52
         pHcYHvUhOjvPZJXiNBCXEu/tt/9W6lP1/JCLjYnoSqN2GeC9gSERkRneU7RmOVsE6hf7
         Veo1h1NPfGV0esJjqHXM6yW8TuTupIzXEPXb7vl6j1z70FTSZ5os/YmnGdgFKl8HSRAz
         LN8TWE0+LFGUkJ+HM7442fycvBkaDbg2rdggwQqUoV2a+Rb9+dkZuXghlpU2iZ2xr0ur
         58sjrLsXiicWLN0j+l7h9pQ2X0HEsjS7deqGGb2EOwVqCbsrE5QtxL+C/QxEAnMz6mtt
         kpcw==
X-Gm-Message-State: AOJu0YyYYmCouWHIcmhnbRyIxKtJYD0j9Hli7Cj26Ezk1VolT1jUDKgf
	EkagFzbJiy8bhbOiDHosKT6YmxLB8lj9xK1tPKGDzgOdBOmBEuVX5SwQVhRyDID56+DQsHeN/5W
	Vu9kP8oPD+K8fqiIGJ5ceXINH59MmJwAjMbK2
X-Gm-Gg: ASbGnctGpez9XXK/Yq1Zg3xXlC8h8FRel/xQt0MPYhCaGMqp4IVxhhhtp7bOdR7HQFB
	+VEAfWuzB/Fr2OLNxqLnoNYq4jFte2+kMtvMuNia2upBoyRmWS6QSnEDdX9MVDO0l4HAMv3TICg
	idmv81+k2Ma0/VARJEdr4f+li3grNLwHlDjgfTvfZHGpjAzGcwMiBu480i5C8EHM+J09pQ7vUYI
	VjqyAo5CFeKmGRtptXACPAF47AW8I1fX6ID0E601/EHuauCBuIWUu2M192wbqdmwb2HSZjd9nZe
	2CdismWSLRQjrbJljQ==
X-Google-Smtp-Source: AGHT+IEZ+DZIZJ1CWo7CsrWyrGXK9IS7GuBDjbaYE1wEOR4WP9a33jOKRpIRTU18adKB6jZVbBnCpfWYdpXo5X0p0xo=
X-Received: by 2002:a05:6602:3fc7:b0:945:aa01:bab7 with SMTP id
 ca18e2360f4ac-945bb350edemr148478139f.5.1761597695479; Mon, 27 Oct 2025
 13:41:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAB95QARfqSUNJCCgyPcTPu0-hk10e-sOVVMrnpKd6OdV_PHrGA@mail.gmail.com>
 <20251026211334.GA1659905@ax162> <CAB95QASG1pZJT7HyqxM90_FExhSVjoHmPqYHeQWXnrAzCNErmA@mail.gmail.com>
In-Reply-To: <CAB95QASG1pZJT7HyqxM90_FExhSVjoHmPqYHeQWXnrAzCNErmA@mail.gmail.com>
From: Eugene Shalygin <eugene.shalygin@gmail.com>
Date: Mon, 27 Oct 2025 21:41:25 +0100
X-Gm-Features: AWmQ_bkzaHhB9CkmlReafi23CmCyQOI92OWB-Z9nDZJfXxx_hcQyxHwdSOVafLc
Message-ID: <CAB95QARmr9b-jVdgDLpA4Qq=3WN7CYS46YEH4Ok4gpSdZHpq5A@mail.gmail.com>
Subject: Re: Can't boot kernel 6.17.4+ via rEFInd
To: Nathan Chancellor <nathan@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Masahiro Yamada <masahiroy@kernel.org>, 
	linux-kbuild@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Nathan,

On Mon, 27 Oct 2025 at 20:35, Eugene Shalygin <eugene.shalygin@gmail.com> wrote:
> Neither the patch nor 6.18-rc3 work. I'm going to try to revert
> 5b5cdb1fe434e8adc97d5037e6d05dd386c4c4c6 together with anything that
> is needed to apply the reversing patch.

Replacing CONFIG_KERNEL_ZSTD with  CONFIG_KERNEL_GZIP made the kernel
bootable. What does that mean?

Cheers,
Eugene

