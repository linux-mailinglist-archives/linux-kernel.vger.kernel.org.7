Return-Path: <linux-kernel+bounces-746916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E4BEB12D06
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 00:49:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEF87189DA9F
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 22:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FE73202C26;
	Sat, 26 Jul 2025 22:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="aHVnJ41J"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E02DA93D
	for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 22:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753570175; cv=none; b=vAGetEHxzTQYCXH7vaMaaMl7PzV53BQd6u1TRDjSTkdBmNbo6SbgC2nr2tYI9XOiKJlzsBee37tf70ykHEIXDFa/qGVcvwBOZdfxp2DtcdpSGlEr0YDmHro4+Qdav0wJiNW1VoJQkGMhycJQdFKT1KkIMuq/3KZLCsz8hwzurDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753570175; c=relaxed/simple;
	bh=6yIC4YvsCT35fS4oqSfF3JTHx+mKVqoRptg5b5fa1Vs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O2k6gPu0uo7G2LXUXg2hOdiiyngjZH8HbIUb7UckOfYHA60zMgqS6zYn8qLsz1c4E2IhrZWGUDCURyc3Pa7cFImRJG1Pnw11Oz4e+uIJmne77dLTFjgOC2o8Kkfgu/tE1A/G2Q13aV4CP3B9Jlkl+jpklORnoNdio/LCnH+aBj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=aHVnJ41J; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-acb5ec407b1so543922166b.1
        for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 15:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1753570172; x=1754174972; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FejLseDlrgreUB7h9wwVgMEXbB2gwRb7bBKpnRNEAa0=;
        b=aHVnJ41JT3L976C/aW9oICXJBA0GPouuyKD6r35x6iCfNo6ttIarXRDrdgTN730wDL
         ZjEZbTqKO2cjelhUMAZgwxY+UQE7BlHFP2cp/7YZtxAS025j7HcGBsT1l0tgodP0oU3t
         /OuypJxH/vHt5nIzbNjheDNz//vHPBoYJ1CH0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753570172; x=1754174972;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FejLseDlrgreUB7h9wwVgMEXbB2gwRb7bBKpnRNEAa0=;
        b=n1M+2TGSD0plbT9okRJfseCiZ/Hdu5ozeap4wnQYiQ30fxxoFPePYUkPum2EOjQQUh
         jLotiLl2S6yKSVsrwdlGzWAIB0o2vFgq9wuZIhZvFZ6GA+PdqL2EnaQxyza/Ndh11M4+
         muX46tEoXwEZWDhKwe2I+/cscXPRS/emcmSXQeOengP6ppLWWQg1vmju/16jnhFPEefa
         MsqjZmqJ07d/LGmr6Mm7m9Rdq15i7G2hg/G/5GyDFf/zqXijfhbkjq2fPxppfGSA5EQO
         bvh/18xiU9fl24HAKKYrq22hImEaducZjCVVFXhUBop3Q+ShCEQw5MBPHAkjJnuT8cSO
         cb1w==
X-Gm-Message-State: AOJu0YwGkFSwP/GSqrshVBJOta6/2zKdhoQoM1u/6nZfOvaC4cnSEty7
	pF+kl4hs/0R9kOm4R4Io9jdBxZ1qKdblMKI71rGNtArF9nCTk4qit4NaIKwIaj8+zOGWaMNQ8Cd
	obT5QOXA=
X-Gm-Gg: ASbGncuQUmpnweCA/wdo5Red8w2ES4igcHLJmCndjQqLaaHMbd6bzZaGjc19n8oQqNL
	1LtpOkV8KvAPicYkfD3FkvWU03sq/kxIYk03ENhGXL689sHQ2Es4NBSqLUj0AEVjDO2CcjMX6op
	4VUEq/iq1OvddemO8GwJtiPxt4/0iD+jVKWMXBnQrpfuCLF7eFDUuOpTqlPG7PeSoZ0/Oqg3fE8
	GZbWhmfqpr/hSumYIw3GCriqKr7YGaRCpn7S1WuFfBgDpZWYLmux12ffAp1QO+NXAUBo+dplShk
	pyw9URKEwY8IDsREtyzK9ymtUyKzw3gOxjzfIf3Tt3c/KsYBRsKyHSwuJjj2ajGZkktk/RpJaoH
	EDx3sOTqp4WGqBJwmG4SL9KrZ8WdIwoG4a0OLtGpWf3eblwzKu3CpqJFYdIVLGPbkDjxdAEEd
X-Google-Smtp-Source: AGHT+IGGaHRGM+jtkBNDg2w+GhoDM2/1FP3cj2wJFf3Hwn0dh/KEta3U+MT3lUI8y3sd7RZmb9WD3g==
X-Received: by 2002:a17:907:3d9f:b0:ae2:9291:9226 with SMTP id a640c23a62f3a-af61dd51de5mr675283266b.59.1753570171571;
        Sat, 26 Jul 2025 15:49:31 -0700 (PDT)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af635a63a5bsm205333966b.93.2025.07.26.15.49.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Jul 2025 15:49:30 -0700 (PDT)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-612a8e6f675so5425873a12.3
        for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 15:49:30 -0700 (PDT)
X-Received: by 2002:a05:6402:2810:b0:60c:4667:b29e with SMTP id
 4fb4d7f45d1cf-614f1f1cc72mr5816106a12.31.1753570170393; Sat, 26 Jul 2025
 15:49:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202507261437.F2079B3B7@keescook> <202507261442.5B0F37DA@keescook>
In-Reply-To: <202507261442.5B0F37DA@keescook>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 26 Jul 2025 15:49:14 -0700
X-Gmail-Original-Message-ID: <CAHk-=whLyN+e_J3xdgTHrWuKMG_7VpqRFdNM3ydqPf_YfJk18Q@mail.gmail.com>
X-Gm-Features: Ac12FXyRClPDO8l-OI1q-3VUADayTqr4t4FxNKoVRjaxXOnhIONKkr9RUTkoX2c
Message-ID: <CAHk-=whLyN+e_J3xdgTHrWuKMG_7VpqRFdNM3ydqPf_YfJk18Q@mail.gmail.com>
Subject: Re: [GIT PULL] execve updates for v6.17
To: Kees Cook <kees@kernel.org>
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 26 Jul 2025 at 14:44, Kees Cook <kees@kernel.org> wrote:
>
> This should obviously be for v6.17-rc1 ... Let me know if you'd like a
> resend with a more accurate tag name.

I'll figure it out ;)

             Linus

