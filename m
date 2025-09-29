Return-Path: <linux-kernel+bounces-835677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B413BBA7C8F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 04:04:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4906416A50A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 02:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3232A1F3FEC;
	Mon, 29 Sep 2025 02:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CHC/0eF3"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EEE914286
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 02:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759111450; cv=none; b=cQfdYLqsUC+5MvaTXjAEH1I2cU8gfO/ROkBEzhXJHeBK5/Qir2jnI2MAPHqNzMMx1C+gROeGEz16eg8fnLUNf0N0yCbbMK6C45Hk7th8L4yAPGWyNtfLCxqP1zR4HLnTZ74ytRZtOgVSk/sL4Vhbi75SEoOuExblo5AE0o7ycBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759111450; c=relaxed/simple;
	bh=9ymXlgAUqmg75QM146TgToxqAsl7Qc6Pl5KLISzPeto=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l4959mdoQ014Olf52jDAt+NB20ZGKT7kKskkDYd61wgh13BMUHXNKPKMH1hyzEMP+WHmr3B71JK2GcZtTD4Kk26YKSY/A2g/H+LcuTr71HV9C+zPwATI7KFxRn9rubsrVnDg4Ql0HcWIjW0T5Ad5ALIYpvuSstmMNET9X1HYP4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CHC/0eF3; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-32e715cbad3so4840346a91.3
        for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 19:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759111448; x=1759716248; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E3MzDeDyhYq3R8OvxgSeuu7T6Z83NvS5x4rRCPw7PVU=;
        b=CHC/0eF3HHxFQvLvZpaXQjgH6+3H1/b59lEV6PSdlXKe/TnEZWItDNjPUieTlNQokn
         LjjEElNL+vV0MzKo1de5K4uqxjTHYllJQAjCTF76tpFKkIcP4xRZV8UQM8E5Db6uY80U
         ukD/NxxSY71sSWCHyONPeQE6ak9yXD8tgIrtHiu1V4QsHnUjzj2F4oMe/am+4ER9SLot
         Me+nwFpSS0MDBGLtOsoMk04t32dU4beGFryi/s3H1s1nVF6uBbPtDP8QhbpaWdhzgrOh
         6lMjcomZvrh95cIdTdhBWOnUZKqiYYWpHrXbv5h1QXDApa13pyqIf0SzgEIQrstpuotf
         Jl4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759111448; x=1759716248;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E3MzDeDyhYq3R8OvxgSeuu7T6Z83NvS5x4rRCPw7PVU=;
        b=ZiPt4bsSOV4++E31gPiadLLLhS8T5q1H4n2K6YQJ3NO+vomnFMM68ZFqVib4PNVbei
         lMn0Q8awJd+92ssPdEoUa6xPD/AoaAUrt3aljLE6k4m//UuricwmGFyVMgjZtDUaKtCl
         UCOEDCbykt+OQn4LeoOcPs2pqPkAYXXgSS0JQcdED/hNxf5pCyMS+Frvpez4XreltpCO
         WZTiH6RCCVUCvN6sPvnYbkVoJFCQSQJ1Lj2Sqz/STNh86RJJ2HmE611Lgytb8MwUn0oS
         ooKC/dFxR8H+1nVUXPnNTEnT1Y3oaELji8Ucwkze9UGy3jkkx664ak07/3jKKCKuGGWT
         E7rw==
X-Forwarded-Encrypted: i=1; AJvYcCXiUg4/ntx44T9GTPtnHRgaXIuMsdeH76VNxpD9ZX4MFMkE580m2gi2p4Oc5aEhNJnZNZeCKRpaMQzgy34=@vger.kernel.org
X-Gm-Message-State: AOJu0YymV56wPRBg3lcvp2/kzRjVoPpqP064XyoPTQHaEHmS+PvNDxKp
	XDAvEoOdDhn3jQ6zdDlWBujwv8CVRPbrSRiC2JTLDWby31WI4PdytV1O
X-Gm-Gg: ASbGncv9fqeq6WOk7uxWWoYBdxJt/G9UJAxglWKaPHHbKV57V0EFuVGX65YGHTDCXX8
	QU9WJY4xdcpmp0GdZ9AfSu5CxBTpS9Y8DTd0zZU8Hr7ezd5It0seEO9YpPF8fcWD+WQzxMYibu5
	SMb+/npdkyXTnWXDqAy87U/VBx05VXEcyJbPhnMfcBoDJRzvW2dmjZmVfXh+G8SBNCQ4nnsEEex
	7bd2PLM5CjO9IvZK7HoVcXnGgFWZESBoW685i0KTo5Nhop/FoMSaM09OeHf2uekT6v2AyAOwHqO
	JcY1bVXvSnACUZcJ2IYcncC+ZWmZ12sxS1NGq6B4SFSorPaHuSs8+45AfIlGOpcA/Voat9XO9Qe
	+n7YJfen7RIKSAoGB6fz12Yan7yTunjeWow==
X-Google-Smtp-Source: AGHT+IGymq0r7t3+/dt2DFGlXKszVB1vTHi1oFb1DYHLzZCrXADl4zARLYFYykUgrI74v8+1nOxrWA==
X-Received: by 2002:a17:90b:4d8a:b0:330:6f16:c4d8 with SMTP id 98e67ed59e1d1-3344ae0aee3mr15189754a91.7.1759111448349;
        Sun, 28 Sep 2025 19:04:08 -0700 (PDT)
Received: from cacher.localnet ([2404:c0:5c60::47f9:1e95])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b57c53ca107sm9680873a12.13.2025.09.28.19.04.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Sep 2025 19:04:07 -0700 (PDT)
From: Fa-Iz Faadhillah Ibrahim <faiz.faadhillah@gmail.com>
To: jlee@suse.com, basak.sb2006@gmail.com, rayanmargham4@gmail.com,
 Armin Wolf <W_Armin@gmx.de>
Cc: kuurtb@gmail.com, ilpo.jarvinen@linux.intel.com,
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/4] platform/x86: acer-wmi: Add fan control support
Date: Mon, 29 Sep 2025 09:04:00 +0700
Message-ID: <6218970.lOV4Wx5bFT@cacher>
In-Reply-To: <20250923215205.326367-1-W_Armin@gmx.de>
References: <20250923215205.326367-1-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Wednesday, September 24, 2025 4:52=E2=80=AFAM Armin Wolf wrote:
> This patch series aims to add fan control support to the acer-wmi
> driver. The patches are compile-tested only and need to be tested
> on real hardware to verify that they actually work.
>=20
> I CCed three users who requested support for this feature. I would be
> very happy if one of you could test those patches and report back.
>=20
> Changes since v1:
> - remove unnecessary blank line
>=20
> Changes since RFC v2:
> - improve error handling when setting fan behavior
> - Add Reviewed-by tags
> - whitelist PHN16-72
>=20
> Changes since RFC v1:
> - remove duplicate include and replace hwmon_pwm_mode with
>   hwmon_pwm_enable in second patch
>=20
> Armin Wolf (4):
>   platform/x86: acer-wmi: Fix setting of fan behavior
>   platform/x86: acer-wmi: Add fan control support
>   platform/x86: acer-wmi: Enable fan control for PH16-72 and PT14-51
>   platform/x86: acer-wmi: Add support for PHN16-72
>=20
>  drivers/platform/x86/acer-wmi.c | 308 +++++++++++++++++++++++++++++---
>  1 file changed, 283 insertions(+), 25 deletions(-)

Hi,

I've tested your patch on my PHN16-72, Fan control works just fine, and it =
does=20
detect my laptop properly.

Thanks,
=46a-Iz Faadhillah Ibrahim




