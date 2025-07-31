Return-Path: <linux-kernel+bounces-752371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6922AB174B9
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 18:09:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06F71188A312
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 16:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77BDB21516E;
	Thu, 31 Jul 2025 16:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dZegm/RM"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E761DED5D
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 16:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753978184; cv=none; b=dmmF4G/VhlVaftwfDCRickZ1rsRPdl8efM4jBT8nPI0BplISrb8LnhiJeLDAMwjlbG+U3xKv11T4f3SOPKCob0dWGnHE6MiGRWGZoj+JAcHc6ad6N5cI6zHxu7TjIIbG0HJEjBMdJmNsRIJ5F6pGM3G+Sk5UQHGxIrMYkzpbKfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753978184; c=relaxed/simple;
	bh=UUbVgaWG1FBSW2udf9aTCPmOnPAnABB3Ya1UbXyvUfU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jsJn23FJm92MazWPljJ9XJz88EFVPp05ZSNO6fO3KOOhJf/inO9NbvKWC3g8Y2qdWh7oo+jnAcVLXROkESVsVV/29T7T9zld3MGeigUgCTh6vI0537Yu6/j0tD0ZT8Y6JdEBu0wgUv87vlw+E6ICISaMRO5D6JfDrGzeSImDIgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=dZegm/RM; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-31f4e49dca0so664175a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 09:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1753978183; x=1754582983; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v8c1vs297OuDQhw1rF/WqVEVYzpa4jaap14+9/4mG/U=;
        b=dZegm/RMZT4fpOJyAljY872rGRhIhTwh/Q1jO1MjTsBJ3CmLDgR9/53u1eWH+/xACa
         bkTIi9Ionq3ckaH83QaMcKwzqLKy9+hWckxale2KwDRAlRFiCyU2ifioRHdjVVSMkZKd
         z5WAX929e2LPu1thpxJ/l5+xarQu0RifzbbDA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753978183; x=1754582983;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v8c1vs297OuDQhw1rF/WqVEVYzpa4jaap14+9/4mG/U=;
        b=P9i+VYFYUuro6DBLPN0iql2r2OLbyDT6TmcQ/YVcPoTwlh1Kco9HpQKiJ8L4fNe8iV
         /2suXUl/V5lL37onY+zW1IXdjdP+8tezFlSl9IZGFPqUvQWbKeWhZwTtqmqvkXzF+SEo
         3m1ZonFkr0Isd0OUi5DQ2K+GmRIVigrvEHPlcxIxMP3g62tvfpDaopeCSn6bGzZcVC67
         vQezLRxZ0mmAMVB37TnuLkqZqCdadBW+Zona+rUBMhA5PRs6RUKeLLggmg4PFB4/KxnN
         McFW9ST+evUAXcc3K41q87zkwJ1cMBv1mcPpgCiUaMGsjT5WcijOuUVzGKW/0cwlefL3
         JeSA==
X-Forwarded-Encrypted: i=1; AJvYcCXtzrVnCqsHw3OwxNaWiLm7eF97ek3PGqRy5bRb9WnkpIESb3vNX7ZWJfuL8t9oABPX/rnn1oBdGl0+KzQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIJm4XKKllKh5hLehSIcXofExipc7vjr2z2Yq4WhEuNnVzbL6V
	YptOaR9VcIem+fyDKpP6ULR7X/3wD3Oi8DkSK3cEtPBwp7sXDTfKvfXJD4N4tJkbprEq7iyMPgO
	7b/0f+pMtNHOpm86ujFyZoiq164FcrJNs2rnWu2uP
X-Gm-Gg: ASbGncsMqRUDRv7/aT+Vg6Eu26zv6PKQ2egwmB6e8PbXmnpdvqxew9tw1Bb3E7hiA6C
	d60/Wu1E16t+znE3jb2lufM7+1LcGfmbPPvCuyVaLh88O5H3oYFQYCLDQk7Yc5BalLVXo0Kh2gD
	Ae4M6wQGxqDg+vWn9shIatQgukSxs8bIYyq3RFD3M2SbKabDUsVWH5ihP6FW2f78nh1/5LuU2Pb
	I1smCjmafvCHosVu8oYLAmtfoPk2r0sUQ==
X-Google-Smtp-Source: AGHT+IH+w2hB9w50GxzxGlBRwTPS/DAt66aQNsJJcSJh0eSSExp3OpaWYiihvtaGYVhasRRauJvVuomLJpIbicNxMs8=
X-Received: by 2002:a17:90b:3d07:b0:31f:1a3e:fe31 with SMTP id
 98e67ed59e1d1-31f5dde8755mr12579873a91.11.1753978182602; Thu, 31 Jul 2025
 09:09:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250630141239.3174390-1-akuchynski@chromium.org>
 <20250630141239.3174390-6-akuchynski@chromium.org> <2025070143-safeness-prewashed-6e9f@gregkh>
 <CAMMMRMeKyi56Pha-X86BaQwcHGCx-xu5F67HCGZg=Yhxuk==OQ@mail.gmail.com> <CAMMMRMf_qc342=azkU-ceg=f-db2Z9NiONOu1_oRk8tmRL4RGg@mail.gmail.com>
In-Reply-To: <CAMMMRMf_qc342=azkU-ceg=f-db2Z9NiONOu1_oRk8tmRL4RGg@mail.gmail.com>
From: Andrei Kuchynski <akuchynski@chromium.org>
Date: Thu, 31 Jul 2025 18:09:30 +0200
X-Gm-Features: Ac12FXx94P8Xkhok4AYIXJ8K2qdSo2AVg2OAPp7s8VPn2NpKyCMBWlD2bnynfvo
Message-ID: <CAMMMRMeYG-bvYSiE7K8AutorvyoiXypHXv_1z62Rvh_JNazd9g@mail.gmail.com>
Subject: Re: [PATCH v2 05/10] usb: typec: Implement automated mode selection
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>, Benson Leung <bleung@chromium.org>, 
	Jameson Thies <jthies@google.com>, Tzung-Bi Shih <tzungbi@kernel.org>, linux-usb@vger.kernel.org, 
	chrome-platform@lists.linux.dev, Guenter Roeck <groeck@chromium.org>, 
	Dmitry Baryshkov <lumag@kernel.org>, "Christian A. Ehrhardt" <lk@c--e.de>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 24, 2025 at 10:39=E2=80=AFAM Andrei Kuchynski
<akuchynski@chromium.org> wrote:
>
> Proposed sysfs entries for V3:
>
> - portN/portN.M/priority, RW.
> This attribute assigns a unique priority to each mode. If a user
> attempts to input a value that is already in use, the existing mode at
> that priority will have its priority incremented by one to accommodate
> the new input. Users cannot disable a mode via this entry; disabling
> is handled by `active` for altmodes and `usb_capability` for USB4 mode
>
> - portN/mode_priorities, RO.
> Provides a prioritized list of all available modes for the port,
> formatted as a space-separated string (e.g., "USB4 TBT DP").
>
> - portN-partner/mode_selection, RW.
> Write: 1/0 to trigger or cancel mode selection.
> Read:  Provides a prioritized list of all available modes for the
> partner. Modes currently in progress are indicated by parentheses
> (e.g., "USB4 (TBT) DP"). Active modes are enclosed in brackets
> (e.g., "USB4 [TBT] DP").
>
> - portN-partner.M/entry_result, RO.
> Represents a mode state for this altmode, e.g. "none", "active",
> "in progress", "cable error", "timeout".
>
> - portN/usb4_priority, RW.
> - portN-partner/usb4_entry_result, RO.
> USB4 mode, not being part of `typec_altmode_group`, introduces
> additional attributes with the same meaning as alternate modes
> attributes.
>
> Please let me know if you have any questions, require further
> clarification on these proposed sysfs entries, or have objections to
> them.

Regarding the sysfs attributes, Heikki, do you have any suggestions or
disagreements? Please let me know your thoughts.

Additionally, for consistency, it would be beneficial to use names
"DisplayPort" and "Thunderbolt3" since they are already recognized
within the kernel. Using these full names rather than "DP" and "TBT"
would be preferable

Thanks,
Andrei

