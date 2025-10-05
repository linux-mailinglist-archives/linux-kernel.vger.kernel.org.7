Return-Path: <linux-kernel+bounces-842260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A389FBB95B0
	for <lists+linux-kernel@lfdr.de>; Sun, 05 Oct 2025 13:05:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87AFE1895858
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Oct 2025 11:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03A1326F292;
	Sun,  5 Oct 2025 11:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="sPx2C3dI"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768CD146585
	for <linux-kernel@vger.kernel.org>; Sun,  5 Oct 2025 11:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759662299; cv=none; b=IPFcsG6IA2J2+8A+7E/g1OzBXH1h08XVbjccyfYIwuFsTh5M0oYIREnPD5OU0vEzciGDec4p1Iih0lskLnX4LId7JcMdkIhOXc+JzCIAXXXmlb+bzHS6IJCI+rjJ+cihTdTIiutGb2Q+7vrITWStAteeNx+GhSEu2c9E6CWEjpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759662299; c=relaxed/simple;
	bh=zxCxml2xTMibvcKTUM6g0Bw/WZztapeGN9bqXDcfLv0=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pJ8lBsIL3rJc4qltv1hGtaN4142cLRYry/WqjHLsBpL9kdD3QYdApVGJ99zmdUqgxGVH8BxgkNWkD3xaJrVFSRN6f3iA3p+YdTbt1U1Dlvj3ikdjxFsW77s/OUeJW0wIZzCRiAbmF/w+i3wKXT6fe43Fgkad3NCKEI7cCcQfPTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=sPx2C3dI; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-361d175c97fso37927471fa.3
        for <linux-kernel@vger.kernel.org>; Sun, 05 Oct 2025 04:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1759662295; x=1760267095; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:references:mime-version:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=8xqOvlazB5Is3xhXduZ+JLL/yMhmBk64h+nNRMpQMg8=;
        b=sPx2C3dILzaWNTnxSz0N/1UicS00hpRvVggB1gTLBMTkTrl3hnJ/64ASCIaVvNxfhg
         26YgPKh5cJDqyGwIY9APPydoBhoHJm5isLt7Kmw3iYicd3NoKx5lg7/1KLhzJKHJm0Kr
         +9gsxbW/2W1rvbxNallzb9cnQvaKY2D1W/lbTr0HV6sr9F4Ms3XF7uIJNkaeYOH8qJv+
         FpZtmP1CoB4QQjnf4dQN0W3fjcRPYkxqRU6DleltWolus+GfPm2sM2C33MElJywrVDQi
         UKB0bI5FDEraH4bVC4j4SQGGW1odBo3kdeEPcsAlKxQjrM52K2boFXKhPldh/569Uhh7
         nkXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759662295; x=1760267095;
        h=cc:to:subject:message-id:date:references:mime-version:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8xqOvlazB5Is3xhXduZ+JLL/yMhmBk64h+nNRMpQMg8=;
        b=FHbO7pGgI+alVF2ofKhO+vYGcK3D5WdhS0ng35SVHZIEl+wIXSzRf6Cjk1WzmQEc14
         jZQqfbg8B4tc5mkGdvb4XST0n65h8JmNfmQAX+ctlyhF6dpUjd12V0/x/6er/7oJCK6B
         Y3gqR4p/ms4NdQ1QHDfpKzg3SHZEfkafYAoOCAgQAK6P/UFloQbWVj33N4Gxg+5FvPCy
         dBo42rhHAUs5E0T5q0swqbh37lsraCDgBrOzxZiHwQzD/07mNvXxu46vyi5vt8iwJgPZ
         FIgMnOyNf4aQsgiuo5IRV/HD4u+0jinLFGW33RmqmNXHYJ3LksgPgOVRc+c3nwbCAvwQ
         NjFA==
X-Forwarded-Encrypted: i=1; AJvYcCUBF9RUCGOd71jOZorKsVDbWF9jY32FD8jEnEnVQ+xzl7uOXltIBzz0KpRA/I5P9aWDoO60LcEaOwcj6Ig=@vger.kernel.org
X-Gm-Message-State: AOJu0YyH46aoDtKO5C0P+zue/3qxYbJDQX0kqO30xCgB1x2+UBHTZv2u
	lWSF94wSfFw9LlRdk1msJVjw6OnstlvPcPvyMVvSAqBKT2grZB4kXWh+RtFG9pmGdcqNJxMZ4jp
	Qm+3k6tqrAZw8xyTDRHIZ5V27kMsCzJnQMlnTNU6ISQ==
X-Gm-Gg: ASbGncvVoNIn9nDEUoocZHeIfA3KcA2scxfKrFwCbvHEVKPBU2n+Lgj/VxLeQFjfrY7
	GEBvYk585xamPxz9bExkyrMQm8Imnj7QYwHgT/EeaA7ieA525XJ1PieGgLws+nQXXPjfBASSogw
	ywR5gSCKsQx9G5JOr57GY9NmaKIYIXSIU8/PIxq2Qc80pJQ+EymZ1+qye47OSGCnz0PgwfKp4LJ
	zeKgMwzPShKUh0PsEVJ29pbkYo8U4y8kTU5c+ui/ABpEcjbVScaYFGSpLsEvaKxj+Rs7I8YvA==
X-Google-Smtp-Source: AGHT+IEWrSLBeSwh841ue8xWWBCz0IGazKam/utBDdjAnUP9kwq2WKJq3+X/Q+HwUi6cY6rSk6yrFl6UveVSx2vH8Ys=
X-Received: by 2002:a2e:be20:0:b0:371:fb14:39bb with SMTP id
 38308e7fff4ca-374c36cbf1bmr28532911fa.16.1759662295570; Sun, 05 Oct 2025
 04:04:55 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 5 Oct 2025 06:04:54 -0500
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 5 Oct 2025 06:04:54 -0500
From: Bartosz Golaszewski <brgl@bgdev.pl>
In-Reply-To: <DM3PPF63A6024A9796B12A990D023532081A3E2A@DM3PPF63A6024A9.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251004141539.6512-1-brgl@bgdev.pl> <CAMRc=Mepopam1zhUONtratqopa6zHhsJfah9JO9D2VKyXcqjEQ@mail.gmail.com>
 <DM3PPF63A6024A97A503FF0208F582651E1A3E5A@DM3PPF63A6024A9.namprd11.prod.outlook.com>
 <CAMRc=MdtkAFJBGN1biaGDLjgwjuzJ=kjDzEWbrX+DX27e8jYhg@mail.gmail.com> <DM3PPF63A6024A9796B12A990D023532081A3E2A@DM3PPF63A6024A9.namprd11.prod.outlook.com>
Date: Sun, 5 Oct 2025 06:04:54 -0500
X-Gm-Features: AS18NWA3dMnXk6NLg3KFRq-98BCFMhOi9RJcV2VAYJtCPLhiWPUX-c1aIwImAOs
Message-ID: <CAMRc=McJ649k44-Y9ugjq1-xKX9QL4c4MX_LeYs12N1SD4D7_g@mail.gmail.com>
Subject: Re: [PATCH] Revert "wifi: iwlwifi: mvm: remove support for
 REDUCE_TX_POWER_CMD ver 6 and 7"
To: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, "Berg, Johannes" <johannes.berg@intel.com>, 
	"Anjaneyulu, Pagadala Yesu" <pagadala.yesu.anjaneyulu@intel.com>, 
	"Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>, Bhaskar Chowdhury <unixbhaskar@gmail.com>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, "Peer, Ilan" <ilan.peer@intel.com>, 
	"Gabay, Daniel" <daniel.gabay@intel.com>, 
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Sun, 5 Oct 2025 12:04:51 +0200, "Korenblit, Miriam Rachel"
<miriam.rachel.korenblit@intel.com> said:
>>
>> To what? I'm already at iwlwifi-ty-a0-gf-a0-89 which seems to be the most recent
>> firmware for this card.
>>
> See https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/commit/?id=70fce2e71a3cbbf50cc57694b94dcb27eb9111f5
> This is the latest update of the FW of your chip.
>
> Miri
>
>

$ md5sum /lib/firmware/iwlwifi-ty-a0-gf-a0-89.ucode
dd86d097615ee98b64d1b78b73697a6a  /lib/firmware/iwlwifi-ty-a0-gf-a0-89.ucode
$ md5sum linux-firmware/intel/iwlwifi/iwlwifi-ty-a0-gf-a0-89.ucode
ae03ce5298a2280e3a22db16fbffb5db
linux-firmware/intel/iwlwifi/iwlwifi-ty-a0-gf-a0-89.ucode

So the 89 at the end of the filename is not the version of the firmware?
No the full version anyway? I wasn't aware of this. Where is the version
information encoded other than the linux-firmware git log?

Bart

