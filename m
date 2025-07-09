Return-Path: <linux-kernel+bounces-724521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F309AAFF3ED
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 23:30:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE1297A36A9
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 21:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CE2D1FC109;
	Wed,  9 Jul 2025 21:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=frame.work header.i=@frame.work header.b="RzZtrXwX"
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6435421FF39
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 21:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752096610; cv=none; b=DygWDbzo1UBLsMeund7IspEUFxJ6G/Jp5RJS19svNL6OhTTeSunkAkl3YdNolXbVtlD8k21CyF5yuB5BqSVWCQl/r/P5Fce8A+b2/8ddGW4Xkk4j5rjpl2VdS0o64pYpICb4oUiTcN0MrIpcPqHDBeV88uPsraXZ6yzpURRQF04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752096610; c=relaxed/simple;
	bh=3AKXY6KIFSkR824wpfOMbdEKHzSAI9V2/86D74V3JQg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rQKO+eIp0IO5LYh8Ay35nqyQAJCyZM5OQZvbH5dzsTs2a4g6eO9XhSA+xCGbyiYjUY0LiZ4r/YiuTngRc2QUwQheQSckl8OmcJFnvrE4T7os4AHJJlNtsNOsT1CngIB5Ii8m62hka2Hx0H1vZjBrCDYxebji59uD/0yXazZdg1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=frame.work; spf=pass smtp.mailfrom=frame.work; dkim=pass (2048-bit key) header.d=frame.work header.i=@frame.work header.b=RzZtrXwX; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=frame.work
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=frame.work
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-712be7e034cso4144627b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 14:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=frame.work; s=google; t=1752096608; x=1752701408; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3AKXY6KIFSkR824wpfOMbdEKHzSAI9V2/86D74V3JQg=;
        b=RzZtrXwXaWFkc8PpqifjN6S0EWAwtt7ceIML7jof7+WlGSdFBcfd12CTU3jVzKdOSS
         tl/0th9w1dNoRTPk4YN3FWtJb7bfwqHAhvraZRIG0AhratiRzT9uKnNcjKS7URdLRDqN
         y8MHsvRGyZNoTUOS+4YY3lvVm7wJKP9+hG4yhsT4ENLdiru1Qj6lvaiQWQL6r997pSjB
         lufQtNBHxEAJrXPGjEVPSqM6KKuseOfRu/U0YMQ39OPOwl4AOfraOH0fA0lDUfLnhnJQ
         5kn2GgteOfHxlaBFUt1RtOlqUlPsac4YGaavGmExU7j1XDsV/yMbwrxJgIKmQea0lwKC
         2aOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752096608; x=1752701408;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3AKXY6KIFSkR824wpfOMbdEKHzSAI9V2/86D74V3JQg=;
        b=UtfH6BJ1c0ry6YzXD5eP2CwoMdexzRzUp4r/wb0yy3MnpcN4kd/Yc2EtQVS4iUxLUp
         vawq7Ax7vB2GdecgxeTf4XOa+AKAHusiYEympE1yxYkI5ThpK9V/sq/M0Y2ciIF7ppfX
         mptSg5L8NS/rVxwfMjImMy0ga9Na0DKTHSVOG5myhQ0wD7Yo4VA5KY/RGiIodff6Sa3q
         q3vtjfoeeTLwX6GimMmDGFuogC5xnT8gVkULBEY+JGgCZClkCzaDX+HUx3piImT52RpG
         9SpzJ+MvmMcZD9QVh7ih5k3ZskXvdrnW9VlcRM1zAaOZC91+YPW62cioi1KtdbqthLTF
         jsGQ==
X-Forwarded-Encrypted: i=1; AJvYcCWfDlbCV564n5vjhQeRqkk2Hep/nmd57fP3juiwb/qQsAzfaBDjjPJk7dfzCzSiHOLaklQ2qtw1e4S6ong=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmhiDC526fs5htY7ClmGAWQ6OQa6nrSJBJs609zdElfRrj6n/+
	f3ld76QfjFjGH7J6sXUvgMCdbNw/isFdZydr+X7m6K/44QqniD2kGUiVngd4KxSS+E2IEnPxiKl
	1u2/TU2o91tnQapARnbSjXkqqfbYvRSZ7QAUt09s6BA==
X-Gm-Gg: ASbGncuIAtUCIaAf1nJeQi3eILv9Lvob9QeSBz2VgnmXv8q/ZPZupXKE6f92EwJTrhn
	T9bkacAT1qGNO+XjTZWCEuyjjFVU7+19v8T3VWR+Z3jMGp/L14ekqaL8fIOdiHL7WMwG+elJGnp
	WPJXD1WMp0Es31+rp/aNIWN8/fTHzbETbCZUDPenODGQ==
X-Google-Smtp-Source: AGHT+IFA/TyZV8EGMF9IO4hNKLPs7QqkYpSA7lLh6/jJatQA3DN6SKf0unViUObnrSN6U2H3b26xG3/2UTAwiVdEKWo=
X-Received: by 2002:a05:690c:640b:b0:710:ead5:8a95 with SMTP id
 00721157ae682-717c4652de5mr6850687b3.14.1752096608346; Wed, 09 Jul 2025
 14:30:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250708162236.549307806@linuxfoundation.org> <75a83214-9cc4-4420-9c0c-69d1e871ceff@heusel.eu>
 <2025070909-outmatch-malt-f9b7@gregkh>
In-Reply-To: <2025070909-outmatch-malt-f9b7@gregkh>
From: Alexandru Stan <ams@frame.work>
Date: Wed, 9 Jul 2025 14:29:31 -0700
X-Gm-Features: Ac12FXwEdWtlHSc6c1BAt6plMlo5XE4LaJAIba1E3cFVgzAQ_-C7cnhnPzezAR0
Message-ID: <CAORQ5J5my3cd-nb=6wJ68s8wJ5BPi+JSu1Mo7JdHiLTD+XnB6Q@mail.gmail.com>
Subject: Re: [PATCH 6.15 000/178] 6.15.6-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Christian Heusel <christian@heusel.eu>, stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org, linux@frame.work
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hey Greg,

On Wed, Jul 9, 2025 at 10:20=E2=80=AFAM Christian Heusel <christian@heusel.=
eu> wrote:
> on the Framework Desktop I'm getting a new regression / error message
> within dmesg on 6.15.6-rc1 which was not present in previous versions of
> the stable kernel series:

I debugged with Christian a little bit, turns out that particular
device ("arch-external") had a PD/UCSI firmware bug (which we have
fixed since). Perhaps the new kernel just exposed some more of the
broken firmware behavior. It does not reproduce with newer firmware.
I think we can safely ignore it for now.

On Wed, Jul 9, 2025 at 12:12=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> And maybe if my Framework Desktop would ever get shipped to me, I could
have debugged this ahead of time :)

Stay tuned ;)

Sorry for the false alarm,
Alexandru M. Stan (amstan)

