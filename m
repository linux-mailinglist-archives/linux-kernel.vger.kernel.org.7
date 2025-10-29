Return-Path: <linux-kernel+bounces-875872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EB28C1A04D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 12:30:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD4465622A4
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 11:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 502AE32E121;
	Wed, 29 Oct 2025 11:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dxt7xc37"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE5D2E2EFC
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 11:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761736936; cv=none; b=jKQZvnRU/fEVEGvqJfiL0+sQYjX/vWDomRACLl3zKsTZYiYlt6RHOXcRA+HW2fNKWoGP5396huyvHtaverrFNFmAg6G1EQTxNs+RvW7G16O5eSKaaBBbffv4KawtDx0NX5iDZQYFrEJiceb5XMZ1nbIieewb2ALUjq4OLOVaT9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761736936; c=relaxed/simple;
	bh=EDUtqO8PePY47rqraTgqQcnx+NDx1LFP7gvDlG+r7fU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E9fPxJd//iv4JTBqBW02SiX3JSVzyir2BSN/l30qWbG+/RUHelNi0wyxbah5cQrc0R4HejdtPVKKAcBUDZCKfJJGoxMqYDFk0768Z9dk2Ij0LSi7NdrQ477UFRFS+UEKkQo8ybWK4AhdN3qmgEXRALGG5RbdHZ5cFTsq+Kvp1kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dxt7xc37; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-59052926cf9so3193568e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 04:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761736933; x=1762341733; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EDUtqO8PePY47rqraTgqQcnx+NDx1LFP7gvDlG+r7fU=;
        b=dxt7xc376bmsPY89zw356rMpGf4Vyp0Axzh+cK6h/NKDJpjxbfQxwtd+sg40RTRd9Z
         Wh9y8IOvu79rKshKWXK/QkzdYlJK2Ducb8646aR4zb1CQqp2bkKFnf7toFACkhUB+7sT
         b8gF1a0ehaGjU4qh1wHX3MZ/pbBaMQ9S7fQXwmaj/gwZx0iC7j/AQVA0tSdHZiV+b/q5
         pAidlLMkSmAVPJQFSxWGa2KynKvd1C3Hhan+Fk2fYLImQvfxkduOggdyzxjVu12dFX+3
         u2ZNEkb5Z4Mr5QMRCvvuDAwsVuBm4eJYiZXdUqfuauxAf9i/cX7b52flY386SnyKeLLb
         VZ9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761736933; x=1762341733;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EDUtqO8PePY47rqraTgqQcnx+NDx1LFP7gvDlG+r7fU=;
        b=xIs8ocKNDTN5dLbYnkFCokNDABv9TrElmkneNj0fEySf9OBimmbiHnk+rZss33tNAT
         KDHF32ON2Wd3gcVMIkjbn1jDzW6k+VZ1QsnFC2KftgQvnzWB0d+aU5aJsbfsGxB50omv
         YLQMep4MAzLjJo+qK5iqietFnKTy0Haoo4A0g6/bNVm4+One/ho34naesfnH/mdAVdMz
         G4hj/w217aOvBFtgScSt69mYI37B9j3FBzmgcm5rHtWaCwF3gEA1VJ+5imMHpeiKJBcc
         JXFCEFl+qjUJNT0R3gZ5UsZDiqmLQrfl2OYu4u2qg1SIVA/oSGMG7OdhUUQPEvN3lVDO
         hNOA==
X-Forwarded-Encrypted: i=1; AJvYcCUGTukEfrTd8tUe3W2TyuPF4Ct/WXw8LaV08ylTPK4ZW4mkl15cLpGpeKhZoAKz172r6lz7zAoTVVelJiY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw18ZtawXXuabLrquOB9t4xE+2ohnHj/sPDRaYNTC+pHATPT8Bg
	ObB7ghteHcbULXoodX7oRyJ7aBhN/7GKRHcHeprg9vI/2ZQA95x5/j7ct6hpWMSj4A5a9t24mHF
	GJg7k5bRRn7WzO3UmOMFG+Pr+YOKOios=
X-Gm-Gg: ASbGncuzJ5L45g00u0HxIdhlM6cZE5CAawnRG28WrI/6oSoqRTQb+aMoYVyRu3gYYmO
	y0R0T27c6r6okgha9vGLz1f/Iyvoix7b49Pt+PD43M3XztSwDsNYMMZnONs6BkoyAhSdpaLWLjV
	7JVOkWJRlYlc9RLL1W5IGV7Q2kA7hUw5AaOGKUw6vfD701g/NqWz/UWvxxAIydOzRnRyToO9oCj
	NIIEa8b64GM8JEXNzjT7hw62gpGA+kwLde0Dr1EVjZ6vj0CnjeDX4MF0bk3Hztif6DjgYzTX75W
	u3OnRkgrXmec1va4+X1x4MIE2btfAstS/lOu7A==
X-Google-Smtp-Source: AGHT+IHc4LI3CCYCeXedzWEMPrCQwraenU/iOkhCterIRDyKhtcKSuDxLJCCmfvBj668P02zxck5F1RCdCRawh/y0mQ=
X-Received: by 2002:a05:6512:6c9:b0:560:8b86:75d9 with SMTP id
 2adb3069b0e04-59412a3d1femr855771e87.14.1761736932471; Wed, 29 Oct 2025
 04:22:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251029075117.104758-1-hsukrut3@gmail.com> <aQHMvdQXD4eRvPSV@smile.fi.intel.com>
In-Reply-To: <aQHMvdQXD4eRvPSV@smile.fi.intel.com>
From: sukrut heroorkar <hsukrut3@gmail.com>
Date: Wed, 29 Oct 2025 16:52:00 +0530
X-Gm-Features: AWmQ_blOcs28nOwA4mRzZbzsddmE8hj5NWFZNo5p4Pwmd7EkxFCZpTsV9vvv3Oc
Message-ID: <CAHCkknoUyV3erQa2QJUY_MzPXuybQMv1neXJQJsZFS8epsyBiA@mail.gmail.com>
Subject: Re: [PATCH] iio: backend: document @chan in iio_backend_oversampling_ratio_set
 kernel-doc comment
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Nuno Sa <nuno.sa@analog.com>, Olivier Moysan <olivier.moysan@foss.st.com>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	Andy Shevchenko <andy@kernel.org>, Pop Ioan Daniel <pop.ioan-daniel@analog.com>, 
	"open list:IIO BACKEND FRAMEWORK" <linux-iio@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	shuah@kernel.org, david.hunter.linux@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 29, 2025 at 1:43=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Wed, Oct 29, 2025 at 01:21:16PM +0530, Sukrut Heroorkar wrote:
> > Buidling with W=3D1 reports:
> > Warning: drivers/iio/industrialio-backend.c:727 function parameter 'cha=
n'
> > not described in 'iio_backend_oversampling_ratio_set'
> >
> > The @chan parameter was added when iio_backend_oversampling_ratio_set()=
 was
> > updated so the contexts could specify the channel, but the parameter wa=
s
> > never documented. Document @chan to silence this warning.
>
> There is already more comprehensive patch available:
> https://lore.kernel.org/linux-iio/20251028093326.1087660-1-kriish.sharma2=
006@gmail.com/
Thanks for the update, Andy.
Regards,
Sukurt Heroorkar
>
> --
> With Best Regards,
> Andy Shevchenko
>
>

