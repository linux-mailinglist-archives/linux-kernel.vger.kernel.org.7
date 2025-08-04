Return-Path: <linux-kernel+bounces-755443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41CF8B1A658
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 17:46:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8DC83A7375
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 15:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 135AD26E140;
	Mon,  4 Aug 2025 15:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simplextrading.com header.i=@simplextrading.com header.b="S1afkD96"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38BC120E717
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 15:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754322339; cv=none; b=D2xyul5yr8U8ZYXlY+YirMnkNWBoYVuADZJMpIuh3tOEOU3Fwv5kWOXaanvJdM5KFtY59BAKik0YN4sFVy7w/f328F4hG2B1rx1x1M4j59VPOOt6z51EKn0BhrzMuRXC7a2ET0DDLctyyk2xerMZnp2J9AWf4W8I78oG6q6P/NQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754322339; c=relaxed/simple;
	bh=SQOT+ox7/x0RpNuqtXs2fpjAevfZM2dslAmPmg6urws=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rjP5IsOy8gNLCyrW4OIpsquMTOmyx6am0sV3PN3JohaO57NVoiGeut0PzlxMoReVjY9cu1r/l5X5jbNcsM6l8MxZEBaPydH8AonPclIW1OxyJh7EUtDE4fJwXW3ErZ4X2Z9ZjAhlLnUzH/QgOZ9tcsgQjRYfnI5M4poqt86Oyxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simplextrading.com; spf=pass smtp.mailfrom=simplextrading.com; dkim=pass (2048-bit key) header.d=simplextrading.com header.i=@simplextrading.com header.b=S1afkD96; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simplextrading.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simplextrading.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-61580eb7995so10078529a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 08:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=simplextrading.com; s=google; t=1754322333; x=1754927133; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SQOT+ox7/x0RpNuqtXs2fpjAevfZM2dslAmPmg6urws=;
        b=S1afkD96H8tQcwS6kuzbP+LptRznXDosZklgacQSXuCsFZmEQ3mTNM7enKTQNxQAkv
         kutERa1AwzRwY3TqqJvWBj5HtpqSiLWSsj7vKXGuTTWV4CkmxOHRf6epX6kYxrxXIQfw
         X6cqnFehJsaipbsYTpN9MFb714CD/UZ6JAoR1wwhjBgO+UPe8Ptle1kU9Y6zKEO5/v8y
         AA6uqGLbl2bkf9SrJbrGLZC7Va5+Xf/ocXsNcKUHLRYj1S893ZHGsFJlpFuh1MzWDYpQ
         uY4Lv0fcKMT2b+xghEcitDCzwr9hB2oYnkLX7XlGgwdFOpjT/JRX+zTTjHGbz6Qihtw8
         b6jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754322333; x=1754927133;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SQOT+ox7/x0RpNuqtXs2fpjAevfZM2dslAmPmg6urws=;
        b=aD2tz1dp+xAVWot0QADpSCM/3hNHGGWjZWOfD6DE/9qdZv1HD4Ho6xkKVI94/HDulh
         1je5N59DD0QhPPjHTobnKNS6s5KM3V74pznrtcMkjmsavgtrCtmypB782Ou3gICgm4ZD
         CnmLaEs3h+Wjy1KTh8i7FgkYIDmK2cno4dYUhO4sdAHqoQ8da7z0wmDSZ/BHjpvS6oYA
         vlShHnxaE4AtJNBlFHVrwn3XQCfGqJckPhcwrJvwRLXf+Vm40XgNWjmWpBcG5rsI3g2s
         EfWwvpYYax/MpvPPfgrI2YmZTocFInGORS5S8RBQ1bgMyI7ThRS3a55rikcuC1X+VeRD
         QKdw==
X-Gm-Message-State: AOJu0Yy33o5NwWhULor0BPtAsZ7GK5Dr0ca2KnTu5KkLvYO2gDwUEuUW
	nhdQjLDzpx76rj6wjizVXdQFZRsDbX4j/VoLpIRasC8BjLMBzciReP8AreKBQxOt7ddETxTyBha
	R3neWeiY6+Gb5gMwsAz074umEcZl57C5rjcaUe/Fh9sWjh2yf9HNTpRjW4JZ+zBdnFNTk5EFRI7
	JULki0U7ccMyDEBUBxGq0zJ1Gj1GFPjg6G9RSuU2UlAm2p8BQfpoDgLlwax6ir3YX++Uy1+6Mbt
	AEqx2/xTTnNcXbly3HXMSX/ddDUAvkfY4wRTZozUU6LgENNlAZm9Fg1Ak5ANtCBE+J9xiVKGLLb
	rfx3/tRkQ5GSoO/juA==
X-Gm-Gg: ASbGncvUsE09Aoy87tBLN2eAClb6gBFmcDJeEVJ/pk9YVCEZGKkEK/N+23i7xqMgT4G
	O/Jy6bkbtVdc/aUz4OCiY056zYNfrTgayHPwjJFZVrP4x1p0lVb5NimN8gtNri81D4/8JPuA4D3
	F3vz70X++XbhcAxQguToN4911gEBhsTK4//jxXpUflkXmn4WAo20LFCvoWi5HUulsbKY5ntmC+a
	4SiIOQ1bKzbso5LjRI=
X-Google-Smtp-Source: AGHT+IFdyHZnZmcx5AqZq4K03fZDeIkTW6HxXLVck8QsyUpBefwLMov4XSw/XSii0vbA5mgjC9Y7ebYF07bhufOSR3k=
X-Received: by 2002:a50:9f02:0:b0:615:3667:f4eb with SMTP id
 4fb4d7f45d1cf-6177b0304c8mr50259a12.6.1754322333204; Mon, 04 Aug 2025
 08:45:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKJHwtOw_G67edzuHVtL1xC5Vyt6StcZzihtDd0yaKudW=rwVw@mail.gmail.com>
 <aIsUwT1Ai0zcMRpT@jlelli-thinkpadt14gen4.remote.csb> <CAKJHwtOZkrR9kEj+tffq=o0i1fPi3P+8BTHz3RyPDmn=uDOF7g@mail.gmail.com>
 <aIyDfs1Dh0OGJEgM@jlelli-thinkpadt14gen4.remote.csb> <CAKJHwtOdiFTenF=zCL7_8c148Qs37r53k9uAKURLjq1JFJGeXg@mail.gmail.com>
 <aJDIZNyoehnzIqS2@jlelli-thinkpadt14gen4.remote.csb>
In-Reply-To: <aJDIZNyoehnzIqS2@jlelli-thinkpadt14gen4.remote.csb>
From: David Haufe <dhaufe@simplextrading.com>
Date: Mon, 4 Aug 2025 10:44:56 -0500
X-Gm-Features: Ac12FXzLStI_i2ob8pPTFgzj8gx5i4b7aYD6Wv3tQj_bKFwto3Zg6cMCCkz1F_8
Message-ID: <CAKJHwtMker+LXNk9L4Vp6nAKjW1P-T0n1VXSLn3piMwHsTWmqA@mail.gmail.com>
Subject: Re: Kernel 6.14.11 dl_server_timer(...) causing IPI/Function Call
 Interrupts on isolcpu/nohz_full cores, performance regression
To: Juri Lelli <juri.lelli@redhat.com>
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

My apologies, I see what you mean now. add_nr_running() is not being
invoked if it is the dl_server. We are still trying to get this branch
to boot to verify ourselves. We will be on the lookout for this to be
merged for release.

Thanks again,
Dave

On Mon, Aug 4, 2025 at 9:49=E2=80=AFAM Juri Lelli <juri.lelli@redhat.com> w=
rote:
>
> On 01/08/25 10:28, David Haufe wrote:
> > I am sorry, but we cannot get this branch to boot on our hardware.
> > Looking through the code of the branch, it will not address the issue.
> > I believe the issue is more fundamental. In
> > fair.c->enqueue_task_fair(), dl_server_start() is called when the
> > single fair/SCHED_OTHER task is added to the isolcpu/nohz_full core.
> > The check here is simply checking if there is 1 or more process and
> > kicks off the dl_server_start() and the housekeeping timer in
> > start_dl_timer(). Once this timer is running, it will invoke
> > dl_server_timer() continuously. This timer calls __enqueue_dl_entity()
> > and then inc_dl_tasks(). inc_dl_tasks() increments
> > dl_rq->dl_nr_running++ and invokes add_nr_running(). This code will
> > eventually call the sched_can_stop_tick() function but
> > rq->dl.dl_nr_running now !=3D 0, so this function will always return
> > false. Something needs to be done to prevent this timer from running
> > in the first place, or maybe have some checks around single
> > "fair/SCHED_OTHER/etc" process running on an isolcpu/nohz_full core
> > which prevents the need for the deadline code to run for the core.
>
> The fix commit I mentioned should at least make entering nohz_full work
> again even when the dl_server is active (but deferred). We still have
> the 1 dl_server_timer firing each second (after recent additional fix by
> Peter), though. At least this is what I am seeing at my end.
>
> Will try to see if we can remove that periodic timer once nohz_full mode
> is entered.
>
> Thanks,
> Juri
>

--=20
DISCLAIMER: NOTICE REGARDING PRIVACY AND CONFIDENTIALITY=C2=A0

The information=20
contained in and/or accompanying this communication is intended only for=20
use by the addressee(s) named herein and may contain legally privileged=20
and/or confidential information. If you are not the intended recipient of=
=20
this e-mail, you are hereby notified that any dissemination, distribution=
=20
or copying of this information, and any attachments thereto, is strictly=20
prohibited. If you have received this e-mail in error, please immediately=
=20
notify the sender and permanently delete the original and any copy of any=
=20
e-mail and any printout thereof. Electronic transmissions cannot be=20
guaranteed to be secure or error-free. The sender therefore does not accept=
=20
liability for any errors or omissions in the contents of this message which=
=20
arise as a result of e-mail transmission. Simplex Trading, LLC and its=20
affiliates reserves the right to intercept, monitor, and retain electronic=
=20
communications to and from its system as permitted by law. Simplex Trading,=
=20
LLC is a registered Broker Dealer with CBOE and a Member of SIPC.

