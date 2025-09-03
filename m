Return-Path: <linux-kernel+bounces-799555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 844B3B42D7D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 01:38:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BCEF4877CC
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 23:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97FF027A12D;
	Wed,  3 Sep 2025 23:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hJ6TjoOb"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6446A24677D;
	Wed,  3 Sep 2025 23:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756942675; cv=none; b=hI98lgSr5nM66b+X7TPWjvPfaQygR025jRWalbIGIEgNBZ2hstmsDx9vr0dV+aFStY44ZydlCyB9b7s6QskzWbc6ZkUCxvcPmV/w0bsO+5mwx0qvI/WVVzmip+iS6HyGl49JCI6VRyV8Qu4BjYULT1PRnA4n9Dd7zwS6qi2e8G4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756942675; c=relaxed/simple;
	bh=stw58zCoGvddooZhq93UKDXlgwE9hSJd7dCfuvUXu1I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PChnkhBR7O4J1gMwU6MSxwhGFAgwsoisYp5lcefp2CLgtHtpqZVgFzxu5MIMYjqvFkf+6q5bPyPbHFhnuQ/7tXQmurJWCUhvDY7oJUybRTa00zNe6wJ7+ub9HO9DZtwaLk9DFhAurV+9HL7FmCRlGzd8rL4/MZDff8xbwVL354U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hJ6TjoOb; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-336b071e7e5so3540461fa.1;
        Wed, 03 Sep 2025 16:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756942671; x=1757547471; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tv/e5+QmWiSB8PrnuSDhZ46U1TqYFEGl3buUo+cKFiE=;
        b=hJ6TjoOb6PPZa3++LLtROGKGT/sdIoYhPwUanl9/MiFtKaCqDpy6YyJnbRM6xU1y5Z
         v4PSINJsDRTBySt4XgbY34efntbeYY4+ibBFGRqmrg5gjOQ/Zzl8tLOV0CdI7k06ONz4
         Li78/XpJ3fol96GkJ+Y9Kq8Lb2oVcmyofCDpsDhmrdZE0q4QPFL7P3Ed/gCR5uYhxuxk
         zYNUs0UTcthzx0vPmqb0X7YH3F4bCr/tn3MtpxYHTaUFgl0v25yIXFJejbkyRUweysaK
         CG6L1q8BYps4aDeTtxCN5VSb/RUPXLaxL19RhiZswsWizOI/x9sbECS59LUnoScNuAgd
         G3uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756942671; x=1757547471;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tv/e5+QmWiSB8PrnuSDhZ46U1TqYFEGl3buUo+cKFiE=;
        b=D5HSgO7tVmu5LNZ8Qy+OS/ev9DAH+gFWarxWSPehpn64nAijsHAuHI+jOnMpaIN6uM
         APCajjYNmAFXR7h0uorezwjbXFgfoC5m9Dys/Ll7WT7cblbajdBk1K83USNRCghGyCy0
         D6TcvwIk7aZCYUSZoy4F9tlfM2EvMDG90GEpLZPJREl3AyBcL9d0XXqLJhg3cD0CdODr
         4vK0fGSlsyieFuLcDefGy6vSJYb4LxclcwLUndq4liZZSsTyVX4VUdi/yoHDAtZtuH89
         xr3ib70I57ZAB7yXYWZKoCjqsYgF0wK4QV1GplC2XiHFRyDow5v/DOa6vmMgQvWfPZLR
         3mpA==
X-Forwarded-Encrypted: i=1; AJvYcCXaxoHgqQteN+CGeHnNbWOOA83Hm/U2+dxutB/vvrkhUSklBEk/PNZREkKif+3z9nDGTXjm2rTM58K+cyTK@vger.kernel.org, AJvYcCXsZ+8fwG6sZSj22FhPgx77+CKUewR+opYXEj7HqzGbCKNOoFtmfX3uKB2Xs4DwsWEXB8ZdanFhXr+N@vger.kernel.org
X-Gm-Message-State: AOJu0YzejZV/AJ0xYLtPVnq/nWsv10SGvfUMHNIA8C7gepJeITLYXWl0
	+8vDBMrG4oZKNheWcF4u66DpO8OpJ3tsvuBS3YAlOCjWcOuczcwSBMmMgrfLJUIbVTBk3KEpx7g
	EtynXNwHyKt6Z0BKGZCaZEx9vjm0GBDw=
X-Gm-Gg: ASbGncuH3lWDR8H/lEQWc2HvjM9JxG1+YUidA+gOc97E+AxZ5mlU8eCN6fo3QqDJQjx
	ajfsQrNqWPxpFhfvD4Ks9ri0IQdgR+JzO+wvS4k1GVc7kzYihQNI1gWubkA/rauSfalZ0FJVS5v
	DE4EPY4dSnQSk56xzcSBDoB9SCJDa4VE/wH8UldHYe7Sg94WP3VfjZKGLrPcmqqBCNM5xmMYQT9
	K7PU2pnM14PL1SCZKEDaWmCxAH3xT4l52qmilobxthtNmOG8w==
X-Google-Smtp-Source: AGHT+IFYFXtX+tu/KEl7pQSY71FNh6F7y1XpLJcTeG502OgoDXb/vUP+HRDx37HC/Vxfaeu0jNJZux+/9gdjOo9o0+E=
X-Received: by 2002:a05:651c:221a:b0:338:164:905c with SMTP id
 38308e7fff4ca-3380164ae7bmr15568211fa.40.1756942671236; Wed, 03 Sep 2025
 16:37:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250903-imx6_dts_warning-v1-0-1e883d72e790@nxp.com> <20250903-imx6_dts_warning-v1-5-1e883d72e790@nxp.com>
In-Reply-To: <20250903-imx6_dts_warning-v1-5-1e883d72e790@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 3 Sep 2025 20:37:39 -0300
X-Gm-Features: Ac12FXyZOBrMIjlst-APzm8-fpvaAVU9IDxp1yLvwRyOjk9Sn4UouD6F8_4boGQ
Message-ID: <CAOMZO5AGv2ykKmL631A6O2yas-1ffmFaZdHFGMxrFx93G9t8XA@mail.gmail.com>
Subject: Re: [PATCH 05/16] ARM: dts: imx6qdl-aristainetos2: rename
 ethernet-phy to ethernet-phy@0
To: Frank Li <Frank.Li@nxp.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Russell King <linux@armlinux.org.uk>, devicetree@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	hs@nabladev.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Frank,

Thanks for working on this series.

On Wed, Sep 3, 2025 at 5:20=E2=80=AFPM Frank Li <Frank.Li@nxp.com> wrote:
>
> Rename ethernet-phy to ethernet-phy@0 to fix below CHECK_DTB warnings:
>   arch/arm/boot/dts/nxp/imx/imx6dl-aristainetos2_4.dtb: ethernet@2188000 =
(fsl,imx6q-fec): mdio: Unevaluated properties are not allowed ('ethernet-ph=
y' was unexpected)
....

> -               ethphy: ethernet-phy {
> +               ethphy: ethernet-phy@0 {
>                         compatible =3D "ethernet-phy-ieee802.3-c22";
> +                       reg =3D <0>;

Are you sure the Ethernet PHY is actually at address 0?

The board schematics are often needed to get this information.

I'm adding Heiko on CC in case he can confirm.

