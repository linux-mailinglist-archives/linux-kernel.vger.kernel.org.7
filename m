Return-Path: <linux-kernel+bounces-876663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB5EAC1C02D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 17:19:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05EE4661AF9
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 16:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67E6D2C237F;
	Wed, 29 Oct 2025 16:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="afGpRvZ+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9E31DEFE0
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 16:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761754063; cv=none; b=hkybRnqjb5TtNV+fbKTFmoFvZV8E816N2MbWXMoBdFoXOu3VGmw3pAECItOslHIVGoaPw7j6atWEctoIP4jYoKvQscqu8Prh6BokbAAqFFTopwXHPjiXFIhl5EUxHIF7VDVetDV1xXoJQrBD1ibnHagNSN5hazqVaCDRhG/1BQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761754063; c=relaxed/simple;
	bh=F5+Hw1BLHdd/jOpifshQgHGM/MjPHsTkf301Hl25/QM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NbPtRIysF2gkYNi5t+8aSZGBUXEs285Z8KFq6hgKi2QK6GYd+0nmw0AqZECyYs3XcviN9m97jbbvJKakSIg2/k6ES9IPOf/0qZtO1efwKIk6x/WpklKnKhaqCi+vNyDmenp5mCh8qw18y90hfgLOgOBTVOtx38x3eU51Ww48DQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=afGpRvZ+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B173C116C6
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 16:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761754063;
	bh=F5+Hw1BLHdd/jOpifshQgHGM/MjPHsTkf301Hl25/QM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=afGpRvZ+BUQkZZN4tAn6Zcb6yp4ha+EWuH1pLCq21d0CIqP0WvSHqBKMgs3gSN90C
	 iy8GSuq1op3iwgoOo+mj3yoOsYkTZwNZeGW21ZH2Omw+hrppimrxKooIzMsgdUk1gi
	 mE6BLNmdKG8y+Z7Gjxln6y6qWZfZvYyWlS4QKImEYKc6yj882iWelIUSG/QjHSdJQv
	 8XAZtujQL7kCqLbBYe+YmESIwmhppcBWltjmj8fgLKzvaC4sL/RQ4hlYZe6rEmIyzu
	 0xPu2m0xBa2whsslaK1p7JpGbN8pDSPJ2qfti5SjKyq/d7e5xS9aZ8gMdeotoOaIQ8
	 GNMS22URwARsA==
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-44d9d7aacc5so24696b6e.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 09:07:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVDndz+6oPjcAFb1KyV9hfVmoIzO/ntregs28aTRZAVVamPfI681lt3Te4KiJtVtEjiwdHHeJjFfCo+XfI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKEyXLbIWqo4cN3QpJFmfIKFirhzj8Vz6MqVgkvEtR8ZQmya1q
	CI39PpG8rNr0LQWqChLh0NPt5vj4dJ/GLMy92JNn9s/co6vcwHXIdRUSw3iCED3NafnblAwjyL1
	uWHSkcapPpXoPIwYVEfXpx6G9yw3yS08=
X-Google-Smtp-Source: AGHT+IEbzw7Oo24iBx/i5pLAvUOqV49daxyoxh0Zst0nRDhzzuj4dZSkbx+qzIQEpV908Ef4LcFLiMCpaQk0k3UlWJo=
X-Received: by 2002:a05:6808:2225:b0:43b:426b:fbeb with SMTP id
 5614622812f47-44f7a7a9e93mr1512151b6e.27.1761754062653; Wed, 29 Oct 2025
 09:07:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5935682.DvuYhMxLoT@rafael.j.wysocki> <4dd9d86f-7c20-40fa-838c-b7634bbebf9a@kernel.org>
In-Reply-To: <4dd9d86f-7c20-40fa-838c-b7634bbebf9a@kernel.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 29 Oct 2025 17:07:31 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hXFtCcon6uBfjXVtst=zDQ6_o-O3aBt4-SH_auw0YBEg@mail.gmail.com>
X-Gm-Features: AWmQ_blvJ_9P1rUGl3893iYEqZa5Dq74kJVWCTqPKMtbs9EWSV31Imp3LVTF2qc
Message-ID: <CAJZ5v0hXFtCcon6uBfjXVtst=zDQ6_o-O3aBt4-SH_auw0YBEg@mail.gmail.com>
Subject: Re: [PATCH v1] PM: sleep: Allow pm_restrict_gfp_mask() stacking
To: Mario Limonciello <superm1@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
	Askar Safin <safinaskar@gmail.com>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 29, 2025 at 4:22=E2=80=AFPM Mario Limonciello <superm1@kernel.o=
rg> wrote:
>
> On 10/28/25 3:52 PM, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Allow pm_restrict_gfp_mask() to be called many times in a row to avoid
> > issues with calling dpm_suspend_start() when the GFP mask has been
> > already restricted.
> >
> > Only the first invocation of pm_restrict_gfp_mask() will actually
> > restrict the GFP mask and the subsequent calls will warn if there is
> > a mismatch between the expected allowed GFP mask and the actual one.
> >
> > Moreover, if pm_restrict_gfp_mask() is called many times in a row,
> > pm_restore_gfp_mask() needs to be called matching number of times in
> > a row to actually restore the GFP mask.  Calling it when the GFP mask
> > has not been restricted will cause it to warn.
> >
> > This is necessary for the GFP mask restriction starting in
> > hibernation_snapshot() to continue throughout the entire hibernation
> > flow until it completes or it is aborted (either by a wakeup event or
> > by an error).
> >
> > Fixes: 449c9c02537a1 ("PM: hibernate: Restrict GFP mask in hibernation_=
snapshot()")
> > Fixes: 469d80a3712c ("PM: hibernate: Fix hybrid-sleep")
> > Reported-by: Askar Safin <safinaskar@gmail.com>
> > Closes: https://lore.kernel.org/linux-pm/20251025050812.421905-1-safina=
skar@gmail.com/
> > Link: https://lore.kernel.org/linux-pm/20251028111730.2261404-1-safinas=
kar@gmail.com/
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Great idea.  Looks good to me, and it passes the S4 tests on my side.
>
> Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
> Tested-by: Mario Limonciello (AMD) <superm1@kernel.org>

Great, thanks!

