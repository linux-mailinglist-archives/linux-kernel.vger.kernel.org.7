Return-Path: <linux-kernel+bounces-892253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B4CBC44B67
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 02:10:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 279744E5A6E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 01:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE23021019C;
	Mon, 10 Nov 2025 01:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nU6CpfGx"
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F8420C023
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 01:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762737001; cv=none; b=SiJ/n5sNJt/4JQlAA+U6NKriz/IwbQFd/J2EpDrFGLTirSr5nNb9tcJ2LBeou9Jzc/yxnUSm66f3jbSV7uG7QwTc0jf5yasuQ+6sbnQFViiNXye7hrsxkmJbVPsC+S40g6SewmlAKUBfUi3da/vVUzK3MpexZ+sMXuk521MdXXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762737001; c=relaxed/simple;
	bh=7eX9gGzJac1YnRyU1DoWZcGMaFtLcH1z+haFd/emMM8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YnbjoCBXclf7r8kD5wAjxp4lyAo/KOrNgwfpVNciaEFOVWD1Hn7N1NQyr7w14VBBsv2FIwy3tUJ7B7DeiSBBrZkVJ5QlW3HvCaO+r5+ZTDoe4pa5O2AhQdgdFBVs1ykuGCY9cemiW4nmdVmxcbm0kQt8shQ5lCzKhlgx3690DmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nU6CpfGx; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-78682bab930so32748707b3.1
        for <linux-kernel@vger.kernel.org>; Sun, 09 Nov 2025 17:09:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762736998; x=1763341798; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7eX9gGzJac1YnRyU1DoWZcGMaFtLcH1z+haFd/emMM8=;
        b=nU6CpfGxK4RtSYk49yZMW3990JkMcS+XMUZJlO18sQKn7K/6sPy3+NGt8j08/vDxWY
         1ZMr8CCcTb0k2CyyLnJ+SptcK9oxeXS7Akvp59sA9Ig6Cqg+FE7HY7H4r57Agqw8geMk
         P1tjf4wHm/7ABUkAIlUc9+HJaIgfqtlZ6otyFs68MdgVC0SOCid8YHwoFQA5VqWdLg5Y
         BYjUeyjYTRWoo+WB3rrsA6Eg/r02LY0zNL8w8vrmxuKVjer+gmWhRM+wcMxy9WAoOvxI
         WcCUarRLf4Wwtl9aD028Gfm4wgfYc6cs4MIJXRzSR9ZsQtFzgkFZVhs8K9EeoxddmXNm
         homg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762736998; x=1763341798;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7eX9gGzJac1YnRyU1DoWZcGMaFtLcH1z+haFd/emMM8=;
        b=BOkeNTXN9IFTdVrrkm75Ykf5d9qPu9msJkT5NyYS4AzJlicbU1xSncQfUb9nWuntk4
         BuLMYeN9a2TEXFJ12ueySSlDBihr4lLPcKeWTN+uVsyd1xtosDKtWWdDMOqTfGrU6Xhz
         /tMx1ZeAMsBhaigawVgU0jNe69TWuPZdGWJOPWzwww3I404vD8TlOg04/HESX/T85Grt
         iXDylg8YfMv1kNRJ8jAIuv/eydF5T0vmNtiWOFllNQIvJUa21z/QRWffZQtmbmFuFKm2
         TT5Y4oAfjeVIX2TrFsxnfh0n/YuU6fO3zNujhJyn8Z3pJE92atg8RCDTAJVzpgpcO9w+
         nYvw==
X-Forwarded-Encrypted: i=1; AJvYcCWyTip1A/bfeRlb/+jxwOO7SCzmdJNGSadfxJGhGhvVkhTDC1BIB9eyeB8qgwdMc3Xok+kQOQpHh0hKQ90=@vger.kernel.org
X-Gm-Message-State: AOJu0YytAjx4jY0LymTotbWPKJGZAkHi8iCBlZcWOeF2rwLe00ESKLeA
	21qVIF8Otj0UjbCc7ne/eKICJWHyjsAYU75MxkvtRmJo66T+t+kDNTRDf9lyZLZOstua38N6Fgt
	gzpCcWjq6ipbfLEnxHmnDpBnz3rPo80E=
X-Gm-Gg: ASbGnctiKvpeJFkG0XfneSH7PNcVbdF/Um4ifxbQp2iwu8Zxw/tMTQSKhgX6jxKldZt
	UQUlF2yoS53rgv0TzAjKNK6muGCKQHipg/X/vlfpaKGeBJgzr6zf0EGXL1qUT+A/gg765g593NV
	b8QFcE6Sz1oF/Wk73ouVJBH1xx1NRJfGtSmcnu+Gjhgd8B437D8WWbYQYuEVTVBe1OI0Ij8Woqu
	TFBZwK0nqqdcTMGwZqrsE5vUYMqtEZnCWw+XMImp15E0qoRrsGBYVvubdq/Qw==
X-Google-Smtp-Source: AGHT+IE7viCJpPysTxjSYtoxvz6QMOaabnGiwqTrZ7JZS/uYgctgriankWFtobObgNaQUadLOO6MvQuYngmmgmrwvx4=
X-Received: by 2002:a05:690c:f0d:b0:786:6c3b:be0e with SMTP id
 00721157ae682-787caab1d62mr79881967b3.7.1762736998559; Sun, 09 Nov 2025
 17:09:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250926014552.1625950-1-jefflin994697@gmail.com>
 <20251106093131.2009841-1-jefflin994697@gmail.com> <aQxtjo-wl-FkUbOx@smile.fi.intel.com>
In-Reply-To: <aQxtjo-wl-FkUbOx@smile.fi.intel.com>
From: Jeff Lin <jefflin994697@gmail.com>
Date: Mon, 10 Nov 2025 09:09:47 +0800
X-Gm-Features: AWmQ_bmtnCyr53f4Zza1_7T9TDauePdOQvjG42BFkl-rnwyoUGpyddnT3ubcrew
Message-ID: <CAMdV+4ftKzSiPHWZNFqxythY_zmxNpCPA2WU6n5O8_WW1TVaOw@mail.gmail.com>
Subject: Re: [PATCH v2] drivers/hwmon/pmbus: Add support for raa229141 in isl68137
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Mariel.Tinaco@analog.com, cedricjustine.encarnacion@analog.com, 
	chiang.brian@inventec.com, grantpeltier93@gmail.com, 
	gregkh@linuxfoundation.org, jbrunet@baylibre.com, jdelvare@suse.com, 
	johnerasmusmari.geronimo@analog.com, kimseer.paller@analog.com, 
	krzysztof.kozlowski@linaro.org, leo.yang.sy0@gmail.com, 
	linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org, linux@roeck-us.net, 
	ninad@linux.ibm.com, nuno.sa@analog.com, peterz@infradead.org, 
	thorsten.blum@linux.dev, tzungbi@kernel.org, william@wkennington.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Got it. I resent a new email for v2.

Thank you

On Thu, Nov 6, 2025 at 5:42=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Thu, Nov 06, 2025 at 05:31:31PM +0800, Jeff Lin wrote:
> > The RAA229141A is a digital dual output multiphase (X+Y =E2=89=A4 12) P=
WM
> > controller designed to be compliant with Intel VR13, VR13.HC, VR14 and
> > VR14.Cloud specifications, targeting VCORE and auxiliary rails.
> >
> > The RAA229141A supports the Intel SVID interface along with PMBus V1.3
> > specifications, making it ideal for controlling the microprocessor core=
 and
> > system rails in Intel VR13, VR13.HC, VR14 and VR14.Cloud platforms.
>
> Avoid In-Reply-to: email headers. I.o.w. start a new email thread when is=
sue a
> new version of the patch or series.
>
> (No need to resend in _this_ case, unless maintainer requests to do so.)
>
> --
> With Best Regards,
> Andy Shevchenko
>
>

