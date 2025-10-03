Return-Path: <linux-kernel+bounces-841648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50A8EBB7E82
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 20:44:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0594C4A6146
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 18:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73F742DC774;
	Fri,  3 Oct 2025 18:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RbY9W+59"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25EE82DC767
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 18:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759517055; cv=none; b=b+VZLc8CFmXSZZMIxUPCivswVrRjx1azz2knjEG4v6MSlZHWAO517kC+s7iYBIN3509752WzaR9MoRZZLfLFa+L24kJXY8d92B2aNlWgwQH9tWEPojE/JM1aOzGslb5x4gbmriLS5FwXEkcqyFR3vUsQWCrssRI38XhilQN/wg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759517055; c=relaxed/simple;
	bh=xyuE14DxlDz2HfrhfyleFTggC3yW/RUkLxL0tsrQ6XA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Noexfu/LHBa7I4xoYHeFdM8O37cNt9fiCaqkDmxWZ3+diJj/nRISyMii8sDYSN5D2/UIRmDDYDkivJcK2O8Th83GALpskBS+/zsmXgnuBaEP9CpZxj1oVe3viLLnepx0c11OaKH2FBz67c6Iy2rfjvlddzRndLtoZ2ElJD1Q9sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RbY9W+59; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5797c8612b4so3322158e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 11:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759517052; x=1760121852; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xyuE14DxlDz2HfrhfyleFTggC3yW/RUkLxL0tsrQ6XA=;
        b=RbY9W+59TNw6CKMmN5l9yFJj+avt1jloNcOz9pIWFZYQdGFhclDoQzaXoOha4UW8pH
         oEylxrQwCESCyjYV9K81+Ml+UCEVSxhe4kxHSZzaMjVub+D2VmF4uHZ17m1Pn6+ML2vQ
         b7neQi2oYaU5OZq6mgbHqlOc68yf0M5YJA1fkKxTTE6ud19Bf/If6Am4oDqAljS3jr6R
         eGABWCV9TkKZqCz8O0YoTRsFuLOhJ1io76aMOhQ/HKwUhn1GTfs1hILb2hb1M9Sh4KYS
         XMmEjvqeDbrvLQslzg7+MgYK0+q1zb5bhD8MxzxW9yt7Ga0ZV3ezDHJTzzj+H3KF+QFS
         UQLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759517052; x=1760121852;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xyuE14DxlDz2HfrhfyleFTggC3yW/RUkLxL0tsrQ6XA=;
        b=gnKdjowKzfCVBoLUY3wTCSQ51nR3P/WifPRO/US3MOvCAxcstPy15NrweFCI2Q6f4N
         T1rBw1ETUZpul8tHSkcqCmCAywvdjpgESVUurnohd7UrtOb4lCgpud8FKopn+k3dASJa
         6MUZ6B1h07UWr6oWr8qJlbYI9qs6iYEx3esjdLekgk/5BmIUp0L5JNzdAaVBOc0AuiMx
         4408yMLUij5gpvE1d7Wl9hM+GCgpIZTZ7AVBnm2efb5jvKmXQlDOXIu747UG/fkURI8l
         hScbwT2TgefcBqQOAO4dR7ldaR/LMp4GjZXF7DZZdzQnGGWa4zBmxQR2H4iVQ+IK6NiX
         5eOA==
X-Forwarded-Encrypted: i=1; AJvYcCViIaQm9LqM7+OFlQ4llpuosEEW9UkPs3xeOomHkrW9jvysoIEyl9qP5FJOvgyLs414Tg0Yz2F9wMuH5Zo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyr1S9aVDE/b0ogDtpFRBXjaKjQ4LJCOk2+jKbah20NfJxYuVEg
	+n8aHrnpfzgj2iQLNmKfgq3xZC5wpO4SL2RzX430LeedT851nV2E+0t5fkIPndKbXfQtPLgjBWC
	s23xsq45etkTFeTGedeXoW2KsdzVXF8s=
X-Gm-Gg: ASbGnct+uXj9DxLPFLQESLLvPKPpMhmZXVJm09OLNKE8/te/24PY2Qz3MrbWKJYhAGU
	nvg6oQf7DKOocpT5kya80QCmTtmpn0mCARCeQnmT8aT6TynorUi3o9wcAOEUAy6BrYA4EwdFi8v
	O1S7x4447Ep9lQAyBzbcA5FJJtVhbnesywHRihFVay7CYu1GwhbTOOWEqPBNzmm1sryHn6SUlF/
	xsGqOBNuN2aYfHfh+qsnlNdkicC4+vT8dw2GdHLtUmCPRZw0GgUctMGMEseTXuC6XwXt/og+gT6
X-Google-Smtp-Source: AGHT+IFGjI23yu+zZGYIIYp5GAvADK1Td8K5f92lbt6d4punv+uO2Xi2qzgSwr+Eyr8h+dgbxKZKruLqIS6Oqk0H0Go=
X-Received: by 2002:a05:6512:1245:b0:560:9993:f154 with SMTP id
 2adb3069b0e04-58cbbdd8224mr1238522e87.35.1759517051928; Fri, 03 Oct 2025
 11:44:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250924175743.6790-1-hsukrut3@gmail.com> <202509272320.3K8kdDCw-lkp@intel.com>
 <bb9d90ca-aa4d-4168-bdc5-543109c74493@gmail.com> <CAHCkknrZ-ieNKeg-aj3-NVqgGSk770jJpUpCvn_SuffkPu+ZrQ@mail.gmail.com>
 <edccab86-321b-4e6e-998f-3ce320ee0193@gmx.de> <41ef536d-2399-43f8-8041-c6b0e642aba2@suse.de>
In-Reply-To: <41ef536d-2399-43f8-8041-c6b0e642aba2@suse.de>
From: sukrut heroorkar <hsukrut3@gmail.com>
Date: Fri, 3 Oct 2025 20:43:59 +0200
X-Gm-Features: AS18NWCgP_BX7ybrXY0sJ6ucNdQs1TMwDO0SWiLqnHgEzd_63diU8v-qea2nPRE
Message-ID: <CAHCkknrAKGxzAYE-R3QX20W4faR9Wfjgn37peyHRJcZ6PRLENA@mail.gmail.com>
Subject: Re: [PATCH] fbdev: udlfb: make CONFIG_FB_DEVICE optional
To: Thomas Zimmermann <tzimmermann@suse.de>, Helge Deller <deller@gmx.de>
Cc: David Hunter <david.hunter.linux@gmail.com>, kernel test robot <lkp@intel.com>, 
	Bernie Thompson <bernie@plugable.com>, Arnd Bergmann <arnd@arndb.de>, 
	Randy Dunlap <rdunlap@infradead.org>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Zsolt Kajtar <soci@c64.rulez.org>, 
	Gonzalo Silvalde Blanco <gonzalo.silvalde@gmail.com>, linux-fbdev@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, 
	skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Thu, Oct 2, 2025 at 8:52=E2=80=AFAM Thomas Zimmermann <tzimmermann@suse.=
de> wrote:
>
> Hi
>
> Am 02.10.25 um 08:41 schrieb Helge Deller:
> >>>> kernel test robot noticed the following build errors:
> >>>
> >>> Did you compile and test this code before submitting this patch?
> >>
> >> Yes, I had compiled & loaded the udlfb module with no errors. Please
> >> let me know how to proceed in this case.
> >
> > Look at the reported build error, which seems to happen in dev_dbg().
> > So, maybe in your testing you did not have debugging enabled?
> > The report contains the .config file with which you can test.
>
> Can we rather make an effort to remove the udlfb driver entirely? A few
> years back, there was one user who was still using it because of some
> problems with the DRM udl driver. But I think we've addressed them. The
> discussion is at [1].
Should I send a patch series to completely remove udlfb, since [1] echoed t=
hat
DRM udl driver is good enough?
>
> [1]
> https://lore.kernel.org/dri-devel/20201130125200.10416-1-tzimmermann@suse=
.de/
>
> Best regards
> Thomas
>
> >
> > Helge
>
> --
> --
> Thomas Zimmermann
> Graphics Driver Developer
> SUSE Software Solutions Germany GmbH
> Frankenstrasse 146, 90461 Nuernberg, Germany
> GF: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman
> HRB 36809 (AG Nuernberg)
>
>

