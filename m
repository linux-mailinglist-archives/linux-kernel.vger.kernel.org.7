Return-Path: <linux-kernel+bounces-896309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25F06C5014D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 00:40:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA1623AC6A9
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 23:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF0072F49F5;
	Tue, 11 Nov 2025 23:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CT3yFC3d"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC422E7167
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 23:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762904441; cv=none; b=S/fdcBywXtiMPs0pZRxOOXK9JIiyFXmkgyiwEd3NZiGIfmJzte+aatNgwDBqcrOiS6nYARF5Q1cP7pZoUO2Ai+xrYkphNGAeLEVvOjghn7hTC51kFwy/M+WY3pXOtfvYQCZDU7SuFYGSwIpiru1lEH3/8jFAjoG3AypYEJ3jg4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762904441; c=relaxed/simple;
	bh=9RPQUOuGiXuyRIeacRdgwahUNW5ZX4sjETV5RA9uMQE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=WbwBbxWxIvZyzFeLAeQJr53H2OyEH52Vju1mvjDpfGDY5+D78GUQpRvIv+KpINR9e9inAOErtXQHD4KjXDKIyHbS+YBrsYAS4lmzjoK6FUC0VexgTWrwZO35uDw/Oc9xq4btFU+PBJZBhpdd7+Qewm0YDuOnBGq6qtDrSw67kFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CT3yFC3d; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5942ee7bc9dso205619e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 15:40:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762904438; x=1763509238; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1PtCNESExEoUzTotaWXK9jDj+telQPBVwoETJ1KCuJU=;
        b=CT3yFC3dArWInUXUt025Q7YvJ1PieSM9y4BPYEgfv4QBSU6NjgbNQ3VTBnkrDNhaYM
         YZiJYs0w8ClVOlR82D4jp6q1T8xlFC2+vkrCK56S87hzm7cenhwnBP6pHOjiKA7cAzYu
         4ibLAqq+M6QeIYADvxMuG2tLzSe7XZ7Zm5cnsEWMXV/dvTLouFeZ8+6Xkhg1ELr1GMex
         J1EsHjxiHsvGbcATA9kP7Qd7xT+fMaof+CLiltjo911Q6D9AN2pl3VtNLG/UGBF1SLI6
         vvrYV7Uzs6az9eDN55Fdq2BRDVN2ZhHN8dqcwDIb0ktfw4St9WNkKPHaixTTA8nsfS/s
         dAJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762904438; x=1763509238;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1PtCNESExEoUzTotaWXK9jDj+telQPBVwoETJ1KCuJU=;
        b=mX7mNOzlgn0B6p9NME5ShWbORumKkXnvJ4S5KTxzXCESI0MRPvDXSyLgyKZx0/XX03
         TQgTa2P5h4AZfO01Jtq6CXhLZKk2B4ioMEMg6oLGyJA3PsAHunPqgk4YaxvFuIdHFNUh
         WVtFH/FffJyzSuJYqkzRmLln4xzgVRxnh1dslWqAn9PN5kwumURJ8EJPZ4bSD5qP+O/h
         Ikl5FG39opnS8MLBbxnDEqLnW4cYG0l03yAV2VdoU1mDGusCBFJ6psjs5Q7/XmHsF36n
         BAU/5sqFBzQQYXKkUk/AFZO1ScMnVGfqBUb2RrtbPg3itlDFjHe3vxmftHsGJKyT9HVC
         sfPA==
X-Forwarded-Encrypted: i=1; AJvYcCVeamkoM79EuWXM20w5LyX4+57+iBQnQu9+IKk4azdm4P9+EE9MCm8vDmNVmCNmWie8AjPMmwwZqRVR2aA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8qW9CcOaa2tP9EDOCYegN/P5nqPEYJUP7T7Tyt/gdnx2p9Zx+
	Pp2NVfec41AD505MxEyA7/VcBH07j9daRVdcZynQBg79LdPMZw0FEMQUkaE4LKN3SUVG61c84il
	duvX4PKa88HwsQEeqklQipR0PovLh+qhMKO+Q15Lo
X-Gm-Gg: ASbGncsSy8daEtSqwaUxlxJS0DYqyL/y2TgIuXDnLCSW8pHZsxJXElRxB+WS8xygLpo
	+K+KLxU/3uWLeWQ/8Rw/yiYixiDYklXB2i3rGGdsRLTQy85Xyxeuo9qmnqhNRfML2nWggHp0SpJ
	vZVeRrfWNn6v5IG/cU1FwAgtaBQ22cVXzd2TvvP44/SFti/+GtOxOW+PCKSY0q80ReTXyavD/m1
	mIG5iPlLC86gwZ1LLw/r3Gwlg1O6pYfHYqjqlAtAzdJ6Y82wkNzbEd/se/i40Vtl4eVQX3Q25dx
	K9SU+2rJcNsk60oshzerL9TwgWUUUpXKECBD
X-Google-Smtp-Source: AGHT+IHGSElGGtooRC7TQ039qyogOHBfVcO7RNEgG5nKV1i25mcxyV03qZmSHjN16RhCKD3VPAEXohYD4xoh1aKyZVw=
X-Received: by 2002:a05:6512:3c96:b0:594:2cdf:1941 with SMTP id
 2adb3069b0e04-59576e17a9amr360519e87.31.1762904437532; Tue, 11 Nov 2025
 15:40:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251111233818.4155828-1-svv@google.com>
In-Reply-To: <20251111233818.4155828-1-svv@google.com>
From: Siarhei Vishniakou <svv@google.com>
Date: Tue, 11 Nov 2025 15:40:20 -0800
X-Gm-Features: AWmQ_bnPWyAAx5nFfenvDitzrBP39xPMkF6iHyk7M3zv1-8U8D6_pm8Fl4NcJO8
Message-ID: <CAKF84v3FJLaNgQDAkkwgtYCWuaN8bfSLm1OSrPrd1n3m3V+Xiw@mail.gmail.com>
Subject: Re: [PATCH] HID: playstation: Center initial joystick axes to prevent
 spurious events
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
	Roderick Colenbrander <roderick.colenbrander@sony.com>, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=B2=D1=82, 11 =D0=BD=D0=BE=D1=8F=D0=B1. 2025=E2=80=AF=D0=B3. =D0=B2 15:3=
8, Siarhei Vishniakou <svv@google.com>:
>
> When a new PlayStation gamepad (DualShock 4 or DualSense) is initialized,
> the input subsystem sets the default value for its absolute axes (e.g.,
> ABS_X, ABS_Y) to 0.
>
> However, the hardware's actual neutral/resting state for these joysticks
> is 128 (0x80). This creates a mismatch.
>
> When the first HID report arrives from the device, the driver sees the
> resting value of 128. The kernel compares this to its initial state of 0
> and incorrectly interprets this as a delta (0 -> 128). Consequently, it
> generates EV_ABS events for this initial, non-existent movement.
>
> This behavior can fail userspace 'sanity check' tests (e.g., in
> Android CTS) that correctly assert no motion events should be generated
> from a device that is already at rest.
>
> This patch fixes the issue by explicitly setting the initial value of the
> main joystick axes (e.g., ABS_X, ABS_Y, ABS_RX, ABS_RY) to 128 (0x80)
> in the common ps_gamepad_create() function.
>
> This aligns the kernel's initial state with the hardware's expected
> neutral state, ensuring that the first report (at 128) produces no
> delta and thus, no spurious event.
>
> Signed-off-by: Siarhei Vishniakou <svv@google.com>
> ---
>  drivers/hid/hid-playstation.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/hid/hid-playstation.c b/drivers/hid/hid-playstation.=
c
> index 1468fb11e39d..fd9d3c901743 100644
> --- a/drivers/hid/hid-playstation.c
> +++ b/drivers/hid/hid-playstation.c
> @@ -718,12 +718,19 @@ static struct input_dev *ps_gamepad_create(struct h=
id_device *hdev,
>         if (IS_ERR(gamepad))
>                 return ERR_CAST(gamepad);
>
> +       /* Set initial resting state for joysticks to 128 (center) */
>         input_set_abs_params(gamepad, ABS_X, 0, 255, 0, 0);
> +       gamepad->absinfo[ABS_X].value =3D 128;
>         input_set_abs_params(gamepad, ABS_Y, 0, 255, 0, 0);
> +       gamepad->absinfo[ABS_Y].value =3D 128;
>         input_set_abs_params(gamepad, ABS_Z, 0, 255, 0, 0);
> +       gamepad->absinfo[ABS_Z].value =3D 128;
>         input_set_abs_params(gamepad, ABS_RX, 0, 255, 0, 0);
> +       gamepad->absinfo[ABS_RX].value =3D 128;
>         input_set_abs_params(gamepad, ABS_RY, 0, 255, 0, 0);
> +       gamepad->absinfo[ABS_RY].value =3D 128;
>         input_set_abs_params(gamepad, ABS_RZ, 0, 255, 0, 0);
> +       gamepad->absinfo[ABS_RZ].value =3D 128;
>
>         input_set_abs_params(gamepad, ABS_HAT0X, -1, 1, 0, 0);
>         input_set_abs_params(gamepad, ABS_HAT0Y, -1, 1, 0, 0);
> --
> 2.51.0.536.g15c5d4f767-goog
>

My apologies, I sent the wrong version of this patch. The values for
Z, RZ should not have changed. I will resend.

