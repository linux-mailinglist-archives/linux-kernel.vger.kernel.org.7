Return-Path: <linux-kernel+bounces-829468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 370A7B97237
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 19:56:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D40632E483F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 17:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D80CC2DF12B;
	Tue, 23 Sep 2025 17:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bf/KHlXO"
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD03F25EFBC
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 17:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758650200; cv=none; b=BMiXwWxOVO+XrwA/vYUglit5jMR9d6pi/0P2rpC8Wg+g7jPUhWStYitT13hWe74lAYeJgHz5wsYBeDvAY8evreJIys8CU2gkWYjGK+XMPqAtkuQqd4KoM5S7RHzMZg/DyE6f8+7M2LH1eLJEtb0AOW3wZ41jb0weAF+03BtbgK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758650200; c=relaxed/simple;
	bh=+2VyYQWo3bsBibTZIVLx3nWadN0J/BZKQdGjMX/uX1k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W6+sY53hIsQkMfL/L6mp/Cub+gqyPmBCMtF/g51WKTFtxdB86KvYO60pwlLv3Ar2CptVkdvrp9fZDGfl3XcPpygIdrZR1JxEDeuZUtLhHCiJsbS7DskfnfNtHDIWshFeEKhxsE6havRnaVRYGqdsLk8AIuyN++n2l/bwmjuNb1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bf/KHlXO; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-73ce0a60895so1757297b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 10:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758650197; x=1759254997; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7RBKxzZ6kU4c7lQtSNThN83j+ugKQYRphi2BaKEQ6gc=;
        b=Bf/KHlXOgjHZvLypdVJ6KMhZjIsdWPT1SZTuztKu1b9MKovaRA45FM+cE+YgKik3dW
         pGv3jcxcdsP+BTxn2pdGcCJAkAF7kP94iBGwtO5DVjpdoskAM4XXZyfhR6u3mFHESvet
         KmcgP70wG9G5atqoxuTdzqaFO4GGtzMQlR2r2idBRDpP5q1V0k8fjrDPTOlrclbTAm3g
         REjrHMurtmFUh83Vq+namEtqwudN/wBipDBNc1+clSSwqMnXDKpSI8YKkU2UqlDaLO5t
         /NIEGbVzlFmEXHvLlNi4pHP/mHspqS9tMR10pP+H/I1lXgfwyDjhcwG1PEZmGGzJ9yh4
         sUyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758650197; x=1759254997;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7RBKxzZ6kU4c7lQtSNThN83j+ugKQYRphi2BaKEQ6gc=;
        b=cll5bRV8Htn95JgrNkLRhO8TSKw1qJb/M4dHbYsEEMMepCcMrNHho8kIINq0S0LZXF
         4PTjaRXk4ovOpCTVFNuT5DxTjfJmb4vHgOF/HkKgcHscVmyc9SojfStN+oeEDTgy0dAw
         sUNFUgTucpRsHeRfBZkNtKNfe7vFCIGH+Nsx0NypFzWqx2Mm7M5YxKHdcDwV3K7QNa/3
         e8pH2HdHGizfF8dLnbcGl8+4lALIPLPaV1EmKj4RomBaGrWSzskpMzNmgNoCet39nhQ7
         IqoNd4T0P4su1n1PXULUfuVXbQoCia0liDK5GygJmSsJpRSe2SABn7r9AHLmf3KWiv0i
         rc2Q==
X-Forwarded-Encrypted: i=1; AJvYcCXiQuMXyq32UW3AQxA16+4NDipBLtE0LNWtfMjNYwfx6R5+117/WLKshpTNgIWROVvPwsVjBvmdEa0odR8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/3sDMeMxFnCh5URcyxFUB/DPxFZf1atx/pldrPuaAZxxyhqzY
	Zwi94oQ+Fo1jjATlFWvr8SkJv9ErJ5cNKGMzFnggGDU3zh/DuzPkicqPMj8yKYZXzNszR0OySTa
	YGTBXjZLx9WeRilfJ3eqyxvMuEFBFOD8=
X-Gm-Gg: ASbGncv2QgxewZSe6y7i43CUdNxhi3Cb4CpZHchSB2fAXZeG8jC3mW4J9gj5uF3SPG2
	AWPbohvEV7kuX5yzyD36T5v+6y6NDxBGKpnned3hRbO3BybfH8I1Q5ckB31HfFdSb6yBh09iC4u
	o/QUcPOb1OzkFhCN2Qa/4JoEuniJfdp/uldwNkHkbWDVIeqKAAa8W43OPCL49fItyNbY0wY5BXK
	15PRZBkKAUNraoILxKHKcPjtb2WQfUBh9b2PzRKNlMZVmfl/js=
X-Google-Smtp-Source: AGHT+IHFYFnbDFoI8nXPm/DbKE6WwSpo1v/Alo1pPkP09kUWL9d8Oowjt7g3OspcbiGB8leMO3y3rMrtwX3aXsOxGiM=
X-Received: by 2002:a53:e035:0:b0:628:3892:b666 with SMTP id
 956f58d0204a3-636047726bbmr1466398d50.5.1758650196488; Tue, 23 Sep 2025
 10:56:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250820102607.1.Ibb5b6ca1e2c059e04ec53140cd98a44f2684c668@changeid>
In-Reply-To: <20250820102607.1.Ibb5b6ca1e2c059e04ec53140cd98a44f2684c668@changeid>
From: Andrey Ryabinin <ryabinin.a.a@gmail.com>
Date: Tue, 23 Sep 2025 19:56:12 +0200
X-Gm-Features: AS18NWARQQsHpK2MdVqC8zgUyvOCYrPAmI9se1FvWZJ1HDiZT1pR2BaT5dqzbC8
Message-ID: <CAPAsAGx6C4PdODuTVxc2un=wpDC1azcO5GUa5cH7KwC=bHF-7w@mail.gmail.com>
Subject: Re: [PATCH] PCI/sysfs: Ensure devices are powered for config reads
To: Brian Norris <briannorris@chromium.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, Brian Norris <briannorris@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 22, 2025 at 10:10=E2=80=AFPM Brian Norris <briannorris@chromium=
.org> wrote:
>
> From: Brian Norris <briannorris@google.com>
>
> max_link_speed, max_link_width, current_link_speed, current_link_width,
> secondary_bus_number, and subordinate_bus_number all access config
> registers, but they don't check the runtime PM state. If the device is
> in D3cold, we may see -EINVAL or even bogus values.

I've hit this bug as well, except in my case the device was behind a
suspended PCI
bridge, which seems to block config space accesses.

>
> Wrap these access in pci_config_pm_runtime_{get,put}() like most of the
                       accesses

> rest of the similar sysfs attributes.
>
> Fixes: 56c1af4606f0 ("PCI: Add sysfs max_link_speed/width, current_link_s=
peed/width, etc")
> Cc: stable@vger.kernel.org
> Signed-off-by: Brian Norris <briannorris@google.com>
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> ---
>
>  drivers/pci/pci-sysfs.c | 32 +++++++++++++++++++++++++++++---
>  1 file changed, 29 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index 5eea14c1f7f5..160df897dc5e 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -191,9 +191,16 @@ static ssize_t max_link_speed_show(struct device *de=
v,
>                                    struct device_attribute *attr, char *b=
uf)
>  {
>         struct pci_dev *pdev =3D to_pci_dev(dev);
> +       ssize_t ret;
> +
> +       pci_config_pm_runtime_get(pdev);
>
> -       return sysfs_emit(buf, "%s\n",
> -                         pci_speed_string(pcie_get_speed_cap(pdev)));
> +       ret =3D sysfs_emit(buf, "%s\n",
> +                        pci_speed_string(pcie_get_speed_cap(pdev)));

pci_speed_string() & pcie_get_speed_cap() don't access config space,
so no need to change this one.

> +
> +       pci_config_pm_runtime_put(pdev);
> +
> +       return ret;

