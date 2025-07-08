Return-Path: <linux-kernel+bounces-722248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EEA4AFD6E8
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 21:10:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5622C582FFC
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 19:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94F272E6122;
	Tue,  8 Jul 2025 19:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jI+t2zQw"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 242958488
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 19:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752001797; cv=none; b=fVA4xrsM+bSZ9tAuKFeJStZmrRdwWRGcNXIxzNVZVuY1ovKQLhonF/hb9F8h6TKF4RiHy+JABBUf7pNIwEb+ybOmppc+hC1NKbxzS8E154CSjMTGpCfd77X6aSIzwY9MLl1OGFqnMB10NvXveQ8nFokVbZjUWB5CKq9nVrvPtUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752001797; c=relaxed/simple;
	bh=rYVTpZKN3pXmydkDpLtXQzpbF3ivuXWhDthP0ZCgqvA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=afQMjlwaSfrlWRoT8PvobtVIo1JBwnvm9CDE3iWqxgIW8oUm8798QR4FeXreQ3I0Zse3+RSF8nqQtecW2/LeawFMLHChIhfES/+kdqaVmgF/szYJZZFKzTZekd8h+MfC8wSvy1ZnlXJX9anlebV+msKiYvVBG75FQ1dhttGExNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jI+t2zQw; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-55622414cf4so4426313e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 12:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752001792; x=1752606592; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BBmIZ/72TeWIcKTjEO97sep+39k5b0ipJBxEHB576K0=;
        b=jI+t2zQwA4IbAgmGYp/GpyPxnWiqoWGFxcm7Nvt3MQJHipv/dxa1tCgLxsO9UrWNve
         Ee69t/cdKu+Jy5NQ4/GBGZCTubN8sfIVwFuaaxZsT1wkbR4WJaAVCu18C6gVN01dezxb
         MHhJlIwXnVVQ73vhxLU/94IOIG5f9hpqdnhlnAkUYziCnPDTtSRGBBLHwarQtmkxzSlM
         5Tkptjba1t2uYOmNzJWMnMYyOPWjDEh0tNfqFMigRS+Ot8+u8Ot9j3Og78+6glvS6Ygl
         p35pyRdLFUmNcJGPmmjkzFiqMY4OciKS7f2AhHcBFMjgIgHx7s5G9x6DZIbc7L0sYXFy
         MIrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752001792; x=1752606592;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BBmIZ/72TeWIcKTjEO97sep+39k5b0ipJBxEHB576K0=;
        b=bCB6NNwJc9KW/cDfHPAge1DtRuLo+ChCHT8iBnjPcUsvc1zCl1Jikh6RlfYv/ZqlsR
         lt/PPIoQZBguweYbeA/T1gSE0HSZhVyFttNXR24b1/O2qzDDjgRFTInvc2VWN29mC54u
         n6UhQctUmSKElSOPqAzeh/W0q36yDBYlk5sqBcq8hU2yCp9G8dZRHDI2wANOrY1dCNaI
         OqKj3fsT8/8vzC1ten1YdxxHufcLSmFW4nE7Db5ICac9wjep+RUUcIRb463HuZBfb2ZD
         vrG7DaZHLOBh8kVVC63LIkECJIRSP31xalyBjKXB3T6KDr6QRckBsRyQAgbCTPlLBmWn
         2yaQ==
X-Forwarded-Encrypted: i=1; AJvYcCX2wrjfykF26RamaT8z0aduG+YwP1ysOWn5iB/W1ueC7jvsdAyyw2ty+qmBk13LA2sw9L4IeYRvKg+RGCQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLLEICsvb7zsVbam5GtKV5e6MKawba2IyCIl3lmbdHnfMqOJQF
	GERfYaKl2MKAdZGRnYQp71sroIS3wHmQiKD6xZxKOj8FuWl7OKgAy8/v7MK9m7cTGf3GWSkSgYr
	AaXiKHb7a4tc4zYCuHAvhOZLBXBELf44ZVEWawJw=
X-Gm-Gg: ASbGncvN7uHq9vM72jb3GXx2H5a3scdoO0uNyv1PpgWwJbOoF+PFDiAjl2Aq1OoGdUp
	vB+f2E91dnGMyOp69oAdzMK72eNzCbT592wbwB9O3X6ckR4rbQeEU+b0bNkiEb/Bbb2lrY1oK65
	gUAxxdDORrZa4cLSdkQawe1IeKRisBII2q8n0aVXQtVk2mqWDsW+C+o/SuvKhWBqVQoUKIWSn9
X-Google-Smtp-Source: AGHT+IFWF7LZHx3nXpiJoB0IW90/W+d3LJqVwJy96jOg+MappwCC4jcuM87nAo8P7b8tVdwLPFqEZDpFBPyfPll5MKU=
X-Received: by 2002:a05:6512:b25:b0:553:2c01:ff44 with SMTP id
 2adb3069b0e04-558f9a193d9mr84537e87.2.1752001792002; Tue, 08 Jul 2025
 12:09:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <txyrr26hxe3xpq3ebqb5ewkgvhvp7xalotaouwludjtjifnah2@7tmgczln4aoo>
In-Reply-To: <txyrr26hxe3xpq3ebqb5ewkgvhvp7xalotaouwludjtjifnah2@7tmgczln4aoo>
From: John Stultz <jstultz@google.com>
Date: Tue, 8 Jul 2025 12:09:40 -0700
X-Gm-Features: Ac12FXwbkgvr1g6ENIgsAuAAMqXYkYu3gUgSioftbW8cqYw2DNqf3oIGuNaWM0g
Message-ID: <CANDhNCoRZOs0qNdJqUF=5RBWP0MCCC_4zbvvftzNWwvuX087xA@mail.gmail.com>
Subject: Re: [PATCH] timekeeping: Always initialize use_nsecs when querying
 time from phc drivers
To: =?UTF-8?Q?Markus_Bl=C3=B6chl?= <markus.bloechl@ipetronik.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, 
	"Christopher S. Hall" <christopher.s.hall@intel.com>, 
	Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>, Stephen Boyd <sboyd@kernel.org>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 8, 2025 at 9:46=E2=80=AFAM Markus Bl=C3=B6chl
<markus.bloechl@ipetronik.com> wrote:
>
> Most drivers only populate the fields cycles and cs_id in their
> get_time_fn() callback for get_device_system_crosststamp() unless
> they explicitly provide nanosecond values.
> When this new use_nsecs field was added and used most drivers did not
> care.
> Clock sources other than CSID_GENERIC could then get converted in
> convert_base_to_cs() based on an uninitialized use_nsecs which usually
> results in -EINVAL during the following range check.
>
> Fixes: 6b2e29977518 ("timekeeping: Provide infrastructure for converting =
to/from a base clock")
> Cc: stable@vger.kernel.org
> Signed-off-by: Markus Bl=C3=B6chl <markus.bloechl@ipetronik.com>
> ---
>
> Notes:
>     We observed this in the e1000e driver but at least stmmac and
>     ptp_kvm also seem affected by this.
>     ice was recently fixed by a5a441ae283d ("ice/ptp: fix crosstimestamp =
reporting").
>
>
>  kernel/time/timekeeping.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
> index a009c91f7b05..be0da807329f 100644
> --- a/kernel/time/timekeeping.c
> +++ b/kernel/time/timekeeping.c
> @@ -1269,6 +1269,8 @@ int get_device_system_crosststamp(int (*get_time_fn=
)
>
>         do {
>                 seq =3D read_seqcount_begin(&tk_core.seq);
> +               system_counterval.use_nsecs =3D false;
> +

So if the argument is the local system_counterval structure isn't
being fully initialized by the get_time_fn() functions it is passed
to, it seems like it would be better to do so at the top of
get_device_system_crosststamp(), and not inside the seqloop.

But having the responsibility to initialize/fill in the structure
being split across the core and the implementation logic (leaving some
of the fields as optional) feels prone to mistakes, so it makes me
wonder if those drivers implementing the get_time_fn() really ought to
fully fill out the structure, and thus the fix would be better done in
those drivers.

thanks
-john

