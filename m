Return-Path: <linux-kernel+bounces-768250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 598F5B25EDD
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 10:31:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D37771CC02D6
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 08:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8AF22E7BAF;
	Thu, 14 Aug 2025 08:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Q9RYd+3P"
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0DDD2580D7
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 08:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755160172; cv=none; b=oG8/SyKkWXRSvEsod5vfkL6S0vSVUzIyTU+/cEa4qN63NYLMC2AvSlD9wqwE8cExeccyDQG2duB4DOYv2k8GchsDu0k/i5ytB/xVhkqVARmZMaH/Q1VC6x5Y1y/HsRI5F7PFKfwjZfpIz3We9VFz1O/WUbd4qyL/GPzOrKcn2v8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755160172; c=relaxed/simple;
	bh=DXoZWllPvSAlTn6cKguWUx5XsVI696Dlfnu+ADK3Vug=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M38ZQ/iur7FDXDhvHbnQkzP6G5eA1y2vur7cYVBJpkLfp5WnKgWGiqAj3c+q+fU7DX8qIP1yZoYKJAw0ibnbasqBjXh4auvg+KRAZ/JHJvrYwZEe3loSyau3iN8kRAPxdAIvDOBHRJVYcJq3zo0SU1ffAb5lin0YlIvZNjLQ6Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Q9RYd+3P; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-74381e0a227so513587a34.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 01:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1755160170; x=1755764970; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DXoZWllPvSAlTn6cKguWUx5XsVI696Dlfnu+ADK3Vug=;
        b=Q9RYd+3P2sO9P3u00p4EMb4DwZyoz5JHLIo5LaM39aA4zQjH2WGk5H520Kps7x4syI
         1iaz0J9ispXNnnIn6/rewskM3hVNGFz/soPMK7xtQYwHo9qW8b+fKZ2Fx3pCH6fdyrSW
         8ndTwPnoZTKdaH+s+rh2uyOYiMufAMcQXH6ns=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755160170; x=1755764970;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DXoZWllPvSAlTn6cKguWUx5XsVI696Dlfnu+ADK3Vug=;
        b=H+CW6p0W1R6p99poGY3qCCmgp352Pwo+IZZSx1hjlIGjnAXwYw9vTGQgQiaT7TwiVp
         cadDfIjSErWPs1iDVOdT+haDbZPSvmDSnr6zn+OAnoabLK4QG4Y5K5nuYc5isbTtul2L
         S+Pc4tg1TnmbCkRz4Pgd8fw4g5kDEjGnS1TFFG2btpLZh7UP9iPM5ep/a6AT4fa2W/o6
         5qjiOO9MJSmrNV5XUORp6EvlWtsS0LNEunDi/e+mi3av93LqC3dDJ6P3FHkXzAeIa63F
         HbvVSdPyjhXUBt+6mFUHPxLl1Dh6ZrmUCpo3lZkPz67D6QL6xwEWnRCDnRxACnfNYXJl
         mNFA==
X-Forwarded-Encrypted: i=1; AJvYcCV7pa27yrnT7PIeA0FhmKJdWVyOWckm757e0iT8ek/0D4K1Zfy7XMyZZ1SBhiOktIUPbB89m5B2txKdf60=@vger.kernel.org
X-Gm-Message-State: AOJu0YwP0eml9tlAx7RpBUap52H9PyM84JviRTMGcQYNkVrgc+SO+I44
	Q03zZj3vC03BBH4zO++iP1yYPrewi+Nled9qBM2f3KIET60+MlFX38/LDDjyhma4CfyBFTb75wX
	05Yx3ybRjsyAOPipsff4+eGqy+gVdRRNFYgXcMuc/XEOLcEepY8Au3g==
X-Gm-Gg: ASbGncuMhW5p8MuSD4sNPqXEe9A9h+c6LCoB6ZCPj73fE/GEbqFA7q01m85jxXeSkSP
	yGrhTnJON/BWPdi8S70DPVDcVmvln7du21gLJ1w2/z36g7HxIp3AZTr9e1wC9idNxQdW/KTidt7
	fZjgKC+nxEQizOVX0udgjjhPXdccV9M+C04wGSTTv8hj9jCl/9tQ2OJj39yJCSA4/TvRej7NIZE
	Zxue+yijjjy0OzwXMbiuKlIDeJm7VZZYw==
X-Google-Smtp-Source: AGHT+IFzeNU7id7rlH8AtFJTm1cePeOA784ZDto12yMUCjCqT2q+uwgR13V7z+m3dpw+DNaYtWcHDCtnfdbNOZZRXJk=
X-Received: by 2002:a17:90b:35d0:b0:321:27d5:eaf1 with SMTP id
 98e67ed59e1d1-32327b48f77mr3326450a91.25.1755159739419; Thu, 14 Aug 2025
 01:22:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250804090340.3062182-1-akuchynski@chromium.org>
 <20250804090340.3062182-5-akuchynski@chromium.org> <aJn9ZSy3w4zW4Xvq@kuha.fi.intel.com>
 <CANFp7mVUFZyF8z0dN-Mo7ntPOXh06ZD0RH5GyvJJymOXrhSD1g@mail.gmail.com>
 <aJsoS3EXgoLP-f-E@kuha.fi.intel.com> <CANFp7mW92PgjSWyJq7Bz6ZLJ8ZgnsCRw2kAYAjKX3yymKW9hBA@mail.gmail.com>
In-Reply-To: <CANFp7mW92PgjSWyJq7Bz6ZLJ8ZgnsCRw2kAYAjKX3yymKW9hBA@mail.gmail.com>
From: Andrei Kuchynski <akuchynski@chromium.org>
Date: Thu, 14 Aug 2025 10:22:07 +0200
X-Gm-Features: Ac12FXz1UN0w6EPEh01uDLgnpov_q6H22DAPFIMRA5Ihvr9O148EKDmKL8f4WE8
Message-ID: <CAMMMRMfo4n_xZPZG++OXoXJTeHuzzSBL0Bossn7+DMZMoRbqjQ@mail.gmail.com>
Subject: Re: [PATCH v3 04/10] usb: typec: Expose mode priorities via sysfs
To: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Benson Leung <bleung@chromium.org>, Jameson Thies <jthies@google.com>, 
	Tzung-Bi Shih <tzungbi@kernel.org>, linux-usb@vger.kernel.org, 
	chrome-platform@lists.linux.dev, Guenter Roeck <groeck@chromium.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, "Christian A. Ehrhardt" <lk@c--e.de>, 
	Venkat Jayaraman <venkat.jayaraman@intel.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 12, 2025 at 10:34=E2=80=AFPM Abhishek Pandit-Subedi
<abhishekpandit@chromium.org> wrote:
>
>
> We interpreted this a bit differently (as just rename it):
> https://patchwork.kernel.org/project/linux-usb/patch/20250616133147.18359=
39-5-akuchynski@chromium.org/#26431992
>
> Thanks for the clarification here. In that case, we'll get rid of
> `usb_priorities` and `usb_results` and just add a new alternate mode
> for USB4. The vendor ids list on usb.org
> (https://www.usb.org/sites/default/files/vendor_ids072325_1.pdf) shows
> 0xff00 for USB4 so that's what we'll use. So the attributes should be:
> .active (similar to other modes), .mode =3D 1 (unused really), .svid =3D
> 0xff00, .vdo =3D <usb eudo> (if supported).
>
> >
> > > As such, our current API recommendation looks like the following:
> > >
> > > * On each port, we lay out priorities for all supported alternate mod=
es + USB4.
> >
> > This first part I understand.
> >
> > > * We expose a file to trigger the mode selection task. Reading from i=
t
> > > gives you the current status of mode selection (single value).
> > > * Detailed results from mode entry are pushed to the mode sysfs group
> > > (via entry_results). Converting these to UEVENT is fine but a more
> > > persistent value in debugfs would be useful for debugging.
> >
> > This second part I would really like to handle separately, after we
> > have a solution for the first part.
>
> Ack. We'll reduce the series so it's easier to review for mode_priorities=
 first.
>

Hi Heikki, Abhishek,

Thank you for your review. I have addressed the feedback and plan to
resubmit the series.

Here are the changes I will make:
- The `typec_mode_selection_init` function and the `name` member
from the mode_selection_state struct will be removed.
- Patch 4 will be split into API and ABI parts.
- The entire series will be divided into `mode priority` (patches 1-4)
and then `mode selection`.
- The mode selection logic will be standardized to function
identically for all modes, including USB4.

Thanks again for your guidance.

Andrei

