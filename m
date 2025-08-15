Return-Path: <linux-kernel+bounces-770886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7352CB27FF3
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 14:26:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 021E07AE4FA
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 12:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBC68347C3;
	Fri, 15 Aug 2025 12:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iht3SdZa"
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA256278157
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 12:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755260777; cv=none; b=mpg2RrGFTiDWfqBeRhsaICnICNOSD4YQCdsSDaC0uoSLB//8JGmI5NZhRRp9OyTHQwi/0185kHL8hrZpa7H0cloKAHAujdirwR+2JLqqKOkU0EG44Km4uPfFPvutw9cE+VYifxOTbFXLp4hX5lkRlUqTOqK54o+w4FEHYCMxbiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755260777; c=relaxed/simple;
	bh=DQX/325BTJnKHkvFsWcPtvM5Q7ywGneVXSiEXQCqUS8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qzwgmCoaVbysb9SYtTGw6XXdjAp6/Gqc+PuGxLzqMvxHZ2MpIHpvmUxbzF3dJrCcq+ZnbxEgkkepUMoankJfS2zdAtMGeZwQ7DO/Tx9duNQHGBvnmDtAj9vJ9TmOglfuoCNf9V73s/PUJGpBywafOdZaGjETK2nmBbZUn4/YYfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iht3SdZa; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e931ccaa44cso1942156276.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 05:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755260775; x=1755865575; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DQX/325BTJnKHkvFsWcPtvM5Q7ywGneVXSiEXQCqUS8=;
        b=iht3SdZas2mQXu3/dhjbElUy4wg0D7jCLT4ogv3RCeCd7qTGPHIaqJ8MzfLMsKYWdD
         w58TDST0AK6JUacwn+bTqrEGcOn7y9WQOxoKfDx/Miuh8SxdmOR2+7ho3URk1r5XhbBA
         GeiTKvGTHUM1RoBtpYqj2MPZlCs7h4T5RvjiCHrTyUbdafAKoQAmmO0k1ITxtYouGvcI
         rHBm9n1MK2bo0sQRR5ig+7lZxT0lEq3IEdd4XDar3t88LLeE8gFG6vW9D0V5ffDd5TT7
         Yvzel+n1HDoOrIp83HGvwaenw/YjsO22L4+qq2CQVGV2PJbCvcGyxjt8USuXXakO2vw0
         dOmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755260775; x=1755865575;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DQX/325BTJnKHkvFsWcPtvM5Q7ywGneVXSiEXQCqUS8=;
        b=YU/hKkYxKngVeu0Vkd3L6qnuS45csORy9fsvlnhtE73Vx4PjBsvwsvwp/KFsWzvAcw
         m0zYQLh8kpENehpVvf4MjQZN6av+asOlJrmkwsUlM5WnBKaRXUEzUmvlETF8/ngHpmcz
         FL8Drczh0O7SNlFgYB5sx5L+TomUk8sbT6YS6EoyP0N1QgzlQoQdL8EZ25uEsC+vIWA1
         WijJ9p05GJ4wxwEL+8/mBsAfP7JAXy/92bZoZghmskhybi2xGti6p1qU/wEyvPLm6NXo
         8ya4GKkH1ILf9aMt8v0MzU6423VeO6k+OsldrwLBjMIn778HECulaiAeuMwWZL6o/kBH
         lu3g==
X-Forwarded-Encrypted: i=1; AJvYcCXQFlIBpYZz+fo5/QO/svc2IVCwo1iVnj6UZLdB04WaFLH4W851AXjCsFn7MuV2eLMAIyei+qN2NIAuszg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8QUXwXjfCIVlxxnezSGaKIsAkVoXYVdtmzq1aSD9lFs206HEY
	xWSLyUBASoKUvLZZ8FcvHhOP7Z/MXn+squyoThJvdQcBLu4mUV3uZnHuSO1GemTuAccgQaXi/wo
	2MNQfnaBMkr1Hx82uS7rhzEGSWcT5gOTcZjdMeMOuGA==
X-Gm-Gg: ASbGncvp2tb+NTvmmuTKx5zcgCxJax4RO4e36ICSud3SPgSFREiaIJWS5vfpsosoNLC
	GOJkfR0BT3oS1n9+M2ZqbN41T3bBlJh8YAnjPyLbNwz+uENTIQ7UX5MYXq3c9VYTIpeBL1jm8cO
	tNO4mAN/HDyhoLcwH4+BuR3BwmGeUUbjhWlMVeZ84pG1pLVjGqndFcYKBpvPlAbW5D1B0A6+DWE
	1PvVsGe
X-Google-Smtp-Source: AGHT+IGVoF64dU58ys34hvl+sIzQbOqcLwGqOY2pYfPr1ee69oOhAIvxgZmb6HK1gQ9HxhwTtrIryKzZXt5l7++Kafc=
X-Received: by 2002:a05:690c:4b8b:b0:71a:1c70:c20a with SMTP id
 00721157ae682-71e6de43d96mr25006987b3.35.1755260774882; Fri, 15 Aug 2025
 05:26:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250716-mobileye-emmc-for-upstream-4-v3-0-dc979d8edef0@bootlin.com>
 <CAPDyKFqa6ut25uaDN6pP50wGi2+DZ8MJ6_OZ6ujtgjfHz4hxzg@mail.gmail.com> <4977174.OV4Wx5bFTl@benoit.monin>
In-Reply-To: <4977174.OV4Wx5bFTl@benoit.monin>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 15 Aug 2025 14:25:38 +0200
X-Gm-Features: Ac12FXx4tr2FImgs2XwKqj-A11Qn4v2kO0YkD0oNl-AEmBzNU2XnHeUCkbheHm4
Message-ID: <CAPDyKFrfV_VpX0dRJGMHLNgfYPW5njGCHZghtb3Oos-6CjV5DQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] mmc: introduce multi-block read gap tuning
To: =?UTF-8?Q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
	Tawfik Bayouk <tawfik.bayouk@mobileye.com>, Gregory CLEMENT <gregory.clement@bootlin.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 14 Aug 2025 at 16:07, Beno=C3=AEt Monin <benoit.monin@bootlin.com> =
wrote:
>
> Hello Ulf,
>
> On Friday, 18 July 2025 at 15:04:18 CEST, Ulf Hansson wrote:
> > A quick review made me feel a lot better about this, thanks!
> >
> > Although I will need a few more days for review and possibly it's
> > getting too late for v6.17 for me, but let's see, I will do my best.
> >
> Any update on the review?

Sorry for the delay. Just a minor comment on patch5, but the rest
looks good to me!

>
> I have a new version with the small changes suggested by Adrian. I can se=
nd
> it but I'd rather wait if you also have some comments to avoid doing two
> separate versions of the patchset.

Thanks for pinging me! I will try to be quicker next time.

Kind regards
Uffe

