Return-Path: <linux-kernel+bounces-811589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 06E90B52B34
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 10:08:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C7701C2116B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 08:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64FE72D63ED;
	Thu, 11 Sep 2025 08:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fra0lWFH"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5990B2D5933;
	Thu, 11 Sep 2025 08:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757578106; cv=none; b=qjbcw910WRFBaBtbaZbFdNCcawBYEH+QSG0Xz5T+ljH3/b6kx6VHDmud1y633PyKq/NxK17PG+GrqVqzXQePqAyEEh0C4PnWf5UdaVZ4Fz8DYkCUQoEcTiDx59mILt+aklXYM54Sj86l66zPi8Wvw4ZDoogKicjdAhckM3Dchqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757578106; c=relaxed/simple;
	bh=yWZc8TqB1iXVf2SuiFfDpIJC0os90AJ8zoKq9v5Sveo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qcOjeXvey5T+l8We/mqbAbURtVXHRUXCfh0avh+5Z2K55F2se4IyiwEuLFQeZUKX6tsI/MqF5wNdbSblemLtmv5wJ/6Ot/QOXLVGLgR/hj0D5YLBM+u30jjACxP6N9mC1qveUyfzFOySvZSIQiGJpqRrokfY/bUwhM19HSYSnNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fra0lWFH; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-32da35469f7so365815a91.1;
        Thu, 11 Sep 2025 01:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757578104; x=1758182904; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yWZc8TqB1iXVf2SuiFfDpIJC0os90AJ8zoKq9v5Sveo=;
        b=Fra0lWFHrEkU3bOSsQ+EG7AxCs4bDoCvMH7MWVLUNM66/FU0tE7WNrZKwmo47O1Uqb
         anD8eT7vHIciICzhx+wIycI3q9UvV12TZViHRak0BdpOvPdZB+c/Yg4T25grxOJ0CFST
         e16PWZkSpp1oInlYDYUrNgt3y4UImgDWiQLSdINf68D/SEubq+RfRcfVFs+NWDr8M8GX
         40gVvvRqaXK7tn6XQU4ipzTKmVjw/aU3M8IPtRnLjmbji6nt8Tid7t+ENIKqLFIbzotA
         vbpzw0ZK5iSjZIxGjdKZI6v5a1Dly8QPyraR3nhMBYbxJt/GKpHVBjJRd/pRYNhY7ALh
         WQ6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757578104; x=1758182904;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yWZc8TqB1iXVf2SuiFfDpIJC0os90AJ8zoKq9v5Sveo=;
        b=ctfXStuDx+1ouYoEUj7m7OQLIq64unQ6kjdcVqkih+q90PBLeYi/hOhQVuSUbc31XY
         moSSJVSNMrbZ3EUQkGZy0YQLOvgQZzYkxDAPtguOCjRO5GI3aesVah4p0+OYmWMZkx2q
         bHxFMqK8OyqaMJN1TXsBbRk9u90WDOHYjRLqyMEVKDgEB/Sa7Cd2tF7yNojfp3KsdkRG
         Ogc/t7EyvOreGWuMCljxVtQeUKTzxBalZZVwmWOEJr0A7eLI9qLPF+d84hlVNpYO9tq6
         aa7Z+cXi5x8jpxKUhBvNetbJTM84yseeRyizcgCKgMRGyyvfnZ47UygWt/QZQUW8Hwtr
         B4Hg==
X-Forwarded-Encrypted: i=1; AJvYcCUzolV0ABH5GDABmPOMoxKwwKlYmgOYOIui3f7xMKj50aocJDBLLk1DxOMjl2cVNKe/ZnqAYfmrdKa7wgFY@vger.kernel.org, AJvYcCWkQHdJYWoNe8aqo2ffP96X4gSNLezhVlAnONQYI/MhPBys2PZzwFDmqUQftXl/4Ij7k1KpeNYymeAs@vger.kernel.org
X-Gm-Message-State: AOJu0YzAl+d8xQkDAAG8VMoFxfIYiJ73dxiAGf9lw53gQtgol+xmHcXF
	0tYs0FOQmFY5854dIYUfUUq74FR/k4fOG2Evj5sYoNQYNJD2NXWAx8VOPiLuqfJfxOLZJF9P5Lp
	6ZdvWHPkVZ/wjPYhPrbLFSNswtxp0pEc=
X-Gm-Gg: ASbGncvQ+eiRItsZZZW5GmzYxI0TsIKsnbZlhIS/YHoCXq2VmuTtLCCKw3eAxPCFjAb
	Nov1fnf9eajzQJs8rLmcNpvtPEoWUI99dLiaNhVgUmmn9bZID6VO3dycKCRchU6BscbYt72XJJQ
	Sbe52lTd0FZ2Mvu3dOMpkndfWCvTg5EQQu5qG8pYpZ6rOUr97JAxz+3VHH9BjdnuOelyqQYuEW4
	T0bRK231gYf+OiOacR07Sp3cCWZXara2SaeWMCHOkJE8kvwLCybjeoqJNR/zipxvIUvLBHf5X4X
	yTSuww==
X-Google-Smtp-Source: AGHT+IG+CYWgOqOKulCdN8Yazwf+YU8Cv8POaXoSZ+NDltxvwpRzupcwLo7PooHvhIBsmf6LQty0AKdRu+LzJWLeS8E=
X-Received: by 2002:a17:90a:da90:b0:32b:8b8d:c2c6 with SMTP id
 98e67ed59e1d1-32d43f2f458mr20260397a91.14.1757578104427; Thu, 11 Sep 2025
 01:08:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250910030301.1368372-1-linchengming884@gmail.com>
 <20250910030301.1368372-2-linchengming884@gmail.com> <20250910-godlike-berserk-sambar-cd25f7@kuoka>
In-Reply-To: <20250910-godlike-berserk-sambar-cd25f7@kuoka>
From: Cheng Ming Lin <linchengming884@gmail.com>
Date: Thu, 11 Sep 2025 16:05:21 +0800
X-Gm-Features: Ac12FXz4c-ZW_4rN1oqVd4xLR1hown8Pq90Ds8_JG-yDyxe8dzsU5NnL_4sRICw
Message-ID: <CAAyq3SZO3miC0S14DmgLvZ1dnVXkAVS_j61+erE8c7A-yYJWMw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: mtd: spi-nand: Add
 enable-randomizer-otp property
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	tudor.ambarus@linaro.org, mmkurbanov@salutedevices.com, 
	Takahiro.Kuwano@infineon.com, pratyush@kernel.org, 
	linux-mtd@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, alvinzhou@mxic.com.tw, 
	Cheng Ming Lin <chengminglin@mxic.com.tw>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Krzysztof,

Krzysztof Kozlowski <krzk@kernel.org> =E6=96=BC 2025=E5=B9=B49=E6=9C=8810=
=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=887:40=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> On Wed, Sep 10, 2025 at 11:02:59AM +0800, Cheng Ming Lin wrote:
> > From: Cheng Ming Lin <chengminglin@mxic.com.tw>
> >
> > Add a new boolean property "enable-randomizer-otp" to enable the
> > randomizer feature on supported SPI-NAND devices.
>
> What is randomizer feature? Subject, commit msg, description - none of
> them explain me that. Is this some standard for NAND? Why is this a
> common property?

To the best of our knowledge, Macronix was the first vendor to
implement this feature in hardware to enhance data reliability and
endurance, especially under high P/E cycle stress.

Since this is a vendor-specific implementation rather than a common
NAND standard, I agree that this property should be handled within
the Marconix driver specifically, not as a common property. I will
make the necessary adjustments.

>
> So many questions and zero explanations in the commit msg. Instead you
> just wrote what we see in the diff - that's completely redundant.

Thank you for your feedback. I apologize that the commit message was not
clear and did not provide sufficient context for this feature.
Your questions are very valid and I should have included these details from
the beginning.

According to JEDEC standard JESD22-A117E, no single data pattern
represents a universal worst-case for all NAND flash failure mechanisms.
Different patterns, such as fully programmed, checkerboard, or mostly
erased, can disproportionately stress specific cells (e.g., programmed,
erased, or those influenced by adjacent states).

Given that no fixed pattern can cover all scenarios, the use of a
randomized data pattern is a practical and effective mitigation strategy.
Our hardware implements a randomizer feature that scrambles user data
before it is written to the flash and restores the original data upon read.

This ensures the data stored on the media is more evenly distributed,
thus reducing pattern-dependent degradation. This is especially crucial
for preventing errors caused by unbalanced data (e.g., all zeros or
all ones) in blocks with high program/erase (P/E) cycle counts.
Ultimately, the randomizer improves the long-term reliability and
endurance of the flash device.

Please refer to the following link for randomizer feature:
Link: https://www.mxic.com.tw/Lists/ApplicationNote/Attachments/2151/AN1051=
V1-The%20Introduction%20of%20Randomizer%20Feature%20on%20MX30xFxG28AD_MX35x=
FxG24AD.pdf

>
> Best regards,
> Krzysztof
>

Best regards,
Cheng Ming Lin

