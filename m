Return-Path: <linux-kernel+bounces-724296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 31B28AFF0E8
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 20:28:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6BBA7A3EA9
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 18:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A85F239E68;
	Wed,  9 Jul 2025 18:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gateworks.com header.i=@gateworks.com header.b="H8ME28SI"
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB94421C161
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 18:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752085710; cv=none; b=Jj2Qg0YV+aXOtO6cw0GVwSNsn9QS7Q9/LwIbBqmCpC4183pjR24RyB1fCT8rcsEXL8aeNTojT8N58bx4Bzgcvd7f29ROCgmQFYUrPdmaij1NwaHfo9vSFEkZsjdFe982OiVFiqJELU9Vo9AsbL2ACwvJyXjoAHQNq6LSm5I9JG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752085710; c=relaxed/simple;
	bh=EF3tKvm/yLMAj5ER680mB6JtKaeBj11j3qvBwe39Xuk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TNfqYIxfx6lo8jfiH1oJoLgeXYtADpCohJxWKsAhxvxl3URLA/WqaqHCWIjDLSBGhag7rIwfS7tZVT9MeUcdicXr5DcmotHMjgwkM4YXHU/G6WhqUIeXzSF0I2wLJaWSrpEPNDX8qopocJZnmtjUJvU3MaZoDS8hY3lz9Z+HNfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gateworks.com; spf=pass smtp.mailfrom=gateworks.com; dkim=pass (2048-bit key) header.d=gateworks.com header.i=@gateworks.com header.b=H8ME28SI; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gateworks.com
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-2eb5cbe41e1so119543fac.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 11:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks.com; s=google; t=1752085707; x=1752690507; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EF3tKvm/yLMAj5ER680mB6JtKaeBj11j3qvBwe39Xuk=;
        b=H8ME28SI88T7KV4iza04m90UknkvT+YN8pex4F3nWv2uXe56mZIrW6VXM2Y0gAY13G
         zDC1UJW8vizf9I7paUec8GHzd6uh2JsOustKLeCIi5uQGCTH5Lo3ivRnYm/bYuBYt0b6
         tP57WdPXwiL/oozU0fIaanLSFYHRVi4edFz57EEh/aOvf+9X5pbLLUBH7esDux8U3cfm
         zte35ZplHrfvUoEYZ90ulCkMV6wymsYM0SNz7QatYP4wAwKVY3vk5emz16jOi6djb3Nl
         A7aHjZOqMlxM4ItyLu8mF3eR4mE3rk5TI5Y0oHcYnCpGB9MbHhWG33dQsLwAuohdNeq7
         GbEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752085707; x=1752690507;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EF3tKvm/yLMAj5ER680mB6JtKaeBj11j3qvBwe39Xuk=;
        b=qUkoQqWBC5VVDev7h5q4SoM1TTCrw5Yvpi9pJvapOBnsPB0xnwL7RhAWt/oIFewBTW
         X7ggnemA7GJzll9fwtnand+sqqJ8zNOsvzvCrv5ziJJcw5IclANJMIcbIvP4irF3bB0v
         kA0u/f5HOPrSz4tNLtijl1Gire0qSTKvaZKlbDAPjQezIAiCNgcJ25r4f3ZL4rvDGf7D
         G23tcu2+2pA+18xZr3s0013dN1Njmg80HBSpBN269Vd/H/ImBBqHaCWQxGB/181ic3wy
         lZ6iEe9A47NrXHO5r45pB01bOGt3v5ukWdVq77rAbF9UK/UO6Yd/4T2xAHbG1rB1cOcw
         CiOQ==
X-Forwarded-Encrypted: i=1; AJvYcCVeEV6/CVioL4snu/C80+SRDidvDJynfnnD2FvJXFCJUGuLWXCjsCf/RZb3ab3d6Klmbwq6Oqw4xMww2Nw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBldWY1LrNUtBNmljylWZnB8ruQgs6QPQGwtTTUfICSon1uFS3
	LKzW2jq7PT4NPj+TjtxgbKx6byOJAWtGe4fnLDFGR7/a/7pImfBRX5M9xBwWLK8lmi8XDjAkzFa
	jpv9d9K2zo8oXjs6B2e+dTe5PwFgpODypvcFhb4L++XUGt8nf8xF6tfU=
X-Gm-Gg: ASbGnctZXgUCVUNq07jtaGTE3Kej1gpNCIjXMrAgnW/cYSZClAaxiLu/YfEGmTQoBlq
	W7KS0kgaz/yluda2DlgDIywbkr6ZDqwrJkmFtdnNPWsBp1OTpny5pfNLOtmWacbl5uWa5VSsFcT
	ADAl8XpsvRpAGgou+OUXdkTdlT7tGgTbNvVNAgdHDaY5Q=
X-Google-Smtp-Source: AGHT+IHA/hKgmN+ZQ0rDeLHDX1FbU4i9gta+XOUEkPAn4h5OjDz1rrmG5m9UAzx1iDyyI0XUhyXd80xd6NkdtMblp0Y=
X-Received: by 2002:a05:6870:3329:b0:2eb:a8fb:863c with SMTP id
 586e51a60fabf-2fef871c3b9mr2622993fac.19.1752085706812; Wed, 09 Jul 2025
 11:28:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250709-gw-dts-lic-v2-1-ac3b697f65d5@prolan.hu>
In-Reply-To: <20250709-gw-dts-lic-v2-1-ac3b697f65d5@prolan.hu>
From: Tim Harvey <tharvey@gateworks.com>
Date: Wed, 9 Jul 2025 11:28:15 -0700
X-Gm-Features: Ac12FXwOfyTS8C_-y9vSRPj-Ar_ANH_aFSj6ux_UPjsJxqIi195A9XgvWe9uzG0
Message-ID: <CAJ+vNU2JZCpRdJqUn5mki31oziTMvmpz=oBjGcJoWhDTcvTHMA@mail.gmail.com>
Subject: Re: [PATCH v2] ARM: dts: imx6-gw: Replace license text comment with
 SPDX identifier
To: =?UTF-8?B?QmVuY2UgQ3PDs2vDoXM=?= <csokas.bence@prolan.hu>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 9, 2025 at 12:26=E2=80=AFAM Bence Cs=C3=B3k=C3=A1s <csokas.benc=
e@prolan.hu> wrote:
>
> Replace verbatim license text with a `SPDX-License-Identifier`.
>
> The comment header mis-attributes this license to be "X11", but the
> license text does not include the last line "Except as contained in this
> notice, the name of the X Consortium shall not be used in advertising or
> otherwise to promote the sale, use or other dealings in this Software
> without prior written authorization from the X Consortium.". Therefore,
> this license is actually equivalent to the SPDX "MIT" license (confirmed
> by text diffing).
>
> Cc: Tim Harvey <tharvey@gateworks.com>
> Signed-off-by: Bence Cs=C3=B3k=C3=A1s <csokas.bence@prolan.hu>
> ---
> Fix up Device Tree files by replacing the license text in comment blocks
> by a `SPDX-License-Identifier`.
> ---
> Changes in v2:
> - Fix msg
> - Link to v1: https://lore.kernel.org/r/20250702-gw-dts-lic-v1-1-7aac2d00=
488f@prolan.hu

Hi Bence,

Thank you.

Acked-by: Tim Harvey <tharvey@gateworks.com>

Best Regards,

Tim

