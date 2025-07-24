Return-Path: <linux-kernel+bounces-743826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A1DDEB103C6
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 10:39:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81EE27AE6CD
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 08:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE6872750E7;
	Thu, 24 Jul 2025 08:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PQIdcdgC"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE2F7274B3E
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 08:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753346354; cv=none; b=LqWDbuGaYY/QUfxYMqvas1EfALpNwIA062ahV9jPzdLooyMALW4CtRNNvsU66n+vJnpfUu9hBflN4W8nWqDzWsYEgO8++auKrIZuu/5GVIf8Z1d67yoa1/mFeiMJIP8Zdluk6U0wbI/SzspHRmao2Lae4TxF1kl73E7QErcCaJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753346354; c=relaxed/simple;
	bh=DPnU95ZJtHDimTEnJ4WU3skY6t7lEUuN/QC7PlHSgdg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KR9Ionrs9UBTbVr+MCiZWUYYBEF510CHApE8GA9IPStIa/6+TvDiYBPK18JwsgKVJJFSPROVemd7V3xThInoCZTij2rFcsrzFpSNwPJglc3+oUkMX1LMQ+/qPYXuOT+04+TdQfME9D+v6UHRRA+qd/pdMnNR4YOTAB08UbZAPYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=PQIdcdgC; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-31223a4cddeso623215a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 01:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1753346352; x=1753951152; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=X0HMsTBmbQ4+9APSf+6vM24W99brsJT2SqN+LugoyEE=;
        b=PQIdcdgCHk4ie4jfyyVGcVF0PGD2IHxurDTf+t82dxpMJv7voPv76msuOhK0zu2P8K
         REoCSJU92BMI6KgMs9UBAE/OEAMwC7SJGBi2n/axMgfDYtZQq8mYp/snWU4ajjQRTPX2
         T9zBXfWeIWWEKgqlE+py0zwPPsJDRWccV/Hac=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753346352; x=1753951152;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X0HMsTBmbQ4+9APSf+6vM24W99brsJT2SqN+LugoyEE=;
        b=nWXEA5OeEk+qudPRDdImTp9woh1ba2bfWYtkT5u4Wg3FbnEaka1hgo6wYfxh0Wl3DC
         Qe/CCAVD4tr3B1rlJGcgsUPt5h3BEIjc4AQZyIbptCyx94szptSEKyWdmiNjFxg536pU
         1CUOPEg3RJwBkvt2WsK1dU4gYh86St6PY7iENzDvrjDERSCB8IsvSvNY56yW9FHdZ6SL
         UFOETL14DUJzyYdcKzCQTkCKgrGmFjeLEIKXmk3UkMPnQdPWqKhSiOKrDBNaZLXpaSvp
         wiCyh/jfKifxUmGk5sGPnXj5Y9+Adtdmz2jiwffXJxPs4U/WBeWRb2dJxPLc8sTg9Q4t
         R1mw==
X-Forwarded-Encrypted: i=1; AJvYcCVH577uYPoFSNmM8wPZq/HKI/sW85imMjbbDwhedQMa3R3t071ahdAc93B/FpcoZJ7Y47aRXPBwieIV0HA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1Yw2hXUnEo0I1iM1V/Mh1wi1x2mxLPl3t9GlJ9P/TNjKg/cz8
	bEl2a5yMJ/55i4v8i+vgOnum3QvWyT/gsnETw/q7TDKXxUixwruoXDtNMtcU4ZdD7gUKCdXdUQy
	1aqAZCLSfly6ntceV6grI3xZDFfm32NAl1QcAZDmC
X-Gm-Gg: ASbGncux7lWW/5bMXiPXlDFPJPpeQXs52w+lf8en3DtTjngErynAvPbiQqIeCZXNXy3
	j+BAGsOWVRz4mC9fN299CufX76tZpJf/IIcIafUqKbs2bLliMgSzK0fNyZ4TEgKOugm3vZwcNpQ
	VrOAtkCa3rMTpWK5z3f6IlMc1jebeAySEAxvdk+k4YLFi9fxzWBC5GZHpBByCLGj3cR6iShhTkc
	N29YqDT8312g3WHuBPPPYuUbiHElqAROg==
X-Google-Smtp-Source: AGHT+IF6GlHoPfQBE7VcJ/+n3gkrTpAcXrzNcm2cizHwNSOzKAmihYyhhHBa69uI0PTyutNd71gW6mxdz1twf+0MKAQ=
X-Received: by 2002:a17:90b:6cb:b0:313:1a8c:c2d3 with SMTP id
 98e67ed59e1d1-31e508172ebmr7030678a91.22.1753346352248; Thu, 24 Jul 2025
 01:39:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250630141239.3174390-1-akuchynski@chromium.org>
 <20250630141239.3174390-6-akuchynski@chromium.org> <2025070143-safeness-prewashed-6e9f@gregkh>
 <CAMMMRMeKyi56Pha-X86BaQwcHGCx-xu5F67HCGZg=Yhxuk==OQ@mail.gmail.com>
In-Reply-To: <CAMMMRMeKyi56Pha-X86BaQwcHGCx-xu5F67HCGZg=Yhxuk==OQ@mail.gmail.com>
From: Andrei Kuchynski <akuchynski@chromium.org>
Date: Thu, 24 Jul 2025 10:39:00 +0200
X-Gm-Features: Ac12FXzobt46uNoTI8Mrqq6Cj9erlIAHq47itWaRXovYE0fFMCg2hJa92bbZ6uk
Message-ID: <CAMMMRMf_qc342=azkU-ceg=f-db2Z9NiONOu1_oRk8tmRL4RGg@mail.gmail.com>
Subject: Re: [PATCH v2 05/10] usb: typec: Implement automated mode selection
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>, Benson Leung <bleung@chromium.org>, 
	Jameson Thies <jthies@google.com>, Tzung-Bi Shih <tzungbi@kernel.org>, linux-usb@vger.kernel.org, 
	chrome-platform@lists.linux.dev, Guenter Roeck <groeck@chromium.org>, 
	Dmitry Baryshkov <lumag@kernel.org>, "Christian A. Ehrhardt" <lk@c--e.de>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Proposed sysfs entries for V3:

- portN/portN.M/priority, RW.
This attribute assigns a unique priority to each mode. If a user
attempts to input a value that is already in use, the existing mode at
that priority will have its priority incremented by one to accommodate
the new input. Users cannot disable a mode via this entry; disabling
is handled by `active` for altmodes and `usb_capability` for USB4 mode

- portN/mode_priorities, RO.
Provides a prioritized list of all available modes for the port,
formatted as a space-separated string (e.g., "USB4 TBT DP").

- portN-partner/mode_selection, RW.
Write: 1/0 to trigger or cancel mode selection.
Read:  Provides a prioritized list of all available modes for the
partner. Modes currently in progress are indicated by parentheses
(e.g., "USB4 (TBT) DP"). Active modes are enclosed in brackets
(e.g., "USB4 [TBT] DP").

- portN-partner.M/entry_result, RO.
Represents a mode state for this altmode, e.g. "none", "active",
"in progress", "cable error", "timeout".

- portN/usb4_priority, RW.
- portN-partner/usb4_entry_result, RO.
USB4 mode, not being part of `typec_altmode_group`, introduces
additional attributes with the same meaning as alternate modes
attributes.

Please let me know if you have any questions, require further
clarification on these proposed sysfs entries, or have objections to
them.

Thanks,
Andrei

