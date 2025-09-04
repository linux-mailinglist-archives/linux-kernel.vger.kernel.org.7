Return-Path: <linux-kernel+bounces-800601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CB69B439B5
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 13:17:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 216141B2546B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 11:17:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E33A32EE260;
	Thu,  4 Sep 2025 11:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R/8ALW52"
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D554A29B8E1;
	Thu,  4 Sep 2025 11:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756984647; cv=none; b=Eab1VVWfBJGkleD2VGYAu4uRKkrCgfc5gs6OddTxYYZyPybOvgUJVVGBuZzSDA2C2wx9xAiYjY2q3QFJaxUuddSzUeMKwFm/8usMWgElaQ/QJxE/X/1qknK2Eog2dCBF/wzh7kPS3fdSnqrR5VJlxOg5NW/6Z8FQO0Q2PXoc9zU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756984647; c=relaxed/simple;
	bh=ADHM1YG+qcPKuj4TGL4SHfNSlRB1a/79FANTPnw/Fik=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T3QEKSgylri5gQ+a39u8BQ8vmNdbDv1gPMPzBfY4HaZ9KmzVvWwe8K9OK/XZHriOOLBNkTOmTt3TAPm+AqjKJA3iIjf6VcXQdWhWiS/qSO7plu/3tzR5IW157bUyPSnBrtlBtxkeEKr82909WM4Wj7HCH/dcCNSDnu+6H3upEk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R/8ALW52; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3f664c47ad2so9861465ab.2;
        Thu, 04 Sep 2025 04:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756984645; x=1757589445; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FevmIjnGLzL+vnOv7ajDIjX5AeN2/FSgvjUim7dAHaw=;
        b=R/8ALW52URJJPYamME3qzmUq/6V7PzgNTlwY+K8h5cRiv00ug0z6A3QcFN/BJ4x5ad
         qO1msqzoyQXvckOKdqo7WIsp88xa2TNddW8UmNpK/m+xjC6hyYnyVriaGo/4trFktrDP
         J/j7z9NgmJOYHY69sM/M9jwQ4S/WxMKDvFnpOi2IlVtP6zC/6/J8wk9/c0mi31b1fFQu
         wyhKfHdjE3SYGbzSSMvXD6OBK/QhKyRVo/PlcPilSQtmo4KIEqcmvsAxxtqnIm4aE0dl
         CkTy3F1LPCHuwZf0I3dnGOwTWT21vL1oxWoEHfvnz1JTtYNj2ujOTYHMySSMgZ0RmjwS
         GQUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756984645; x=1757589445;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FevmIjnGLzL+vnOv7ajDIjX5AeN2/FSgvjUim7dAHaw=;
        b=eWImiH1IyCymnHnd60DM/nE93eqpXa2BQtlSdn2GfYROf8n/lnYkL60/k2eitHdaq6
         uptZSwLdIubmI+Jtjpjqul0IZLOPiNYVcSBQ0nmbqun+fQg0oBPYhRq7Xq1PA7T0zlaH
         xt1Km7LANP9YoC6VVPsXkVtW/4Qtmn6UZAg8JLwiMEZybuBuUOV/MRdf03Y8kjf+t16u
         kylw1TAr1ftkLDBqIb6fbijxHHyQz1qTm/kySVEykiW5uixXBsewQKS0OAnIIw5zvtvB
         1jH+FGCu+nJ9Jeb5B+gLOrwWNSY2orDojTGjue48W9f9uHq1XLfkl06ph0D/qET7sZK5
         TRvA==
X-Forwarded-Encrypted: i=1; AJvYcCVNBX+3AOqXcq+Sgy83m1XmiSyvEDL8ERNsdCuxDQ1fZBL6yxBGPRJ5NnSC7Cji/1VWcluRt7X95u0z@vger.kernel.org, AJvYcCX7HpxKi0MgOC0Nnc3mlZK49aI4/yqOFO9vBwzkkUm3id2qC7RBH29mUnIFr0O1DJaJwqpJMnfK/ET1EUW7@vger.kernel.org
X-Gm-Message-State: AOJu0YwZD4Wu7G78c2qeUCoCohzJnOtBQw0OnicglmdxSZ9YJwgXpUYo
	KYKO6RHOmXkUTdMIikKtix9mxoTeaauB5Q3rzPbT1FNHo3L0pS/UOfdFNXka4pFpNT+cTqwY5q7
	uLsMV10sURt3NBOqUr8ZsIZPETzEbjGI=
X-Gm-Gg: ASbGnctr8bz01JyQnbwyrEnDAucB9mZONblwhaUvFaR6+GMBuXg3Rxi3Cy1XWKqfgWc
	ZvD2tAvt0e+jXNhQqZwL8CADLZA7Ieoqj7rk26/n1vuSxXgG4hJaNaQOY6gWbtt/DEWPtWfzyOR
	zHu52Diq3ek7lsOQfSCRgnMVBzUrlel2Tnemeruu2Nr596z5Z1GkUEI1I83b7yKZr9oesdbo2MU
	pqnBprINv3NcXg0Gw==
X-Google-Smtp-Source: AGHT+IGpLZ5D5OKWZTWLeH3TsPwenZWq0PAACyBixD1XRKbsVqVkCws7MNZmFCwC61LiajeLRRhN0KJyoRdVvIst79Y=
X-Received: by 2002:a05:6e02:1a8b:b0:3f6:609d:1855 with SMTP id
 e9e14a558f8ab-3f6609d2eb6mr76703435ab.31.1756984644753; Thu, 04 Sep 2025
 04:17:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250903123825.1721443-1-syyang@lontium.com> <20250903123825.1721443-3-syyang@lontium.com>
 <24rahlm4kkob7knapdxxnjixye3khx3nv2425y4kkirat4lmam@gjey7zqsnzks>
 <CAFQXuNZUfAJe4QEDfi+-1N99xO0_z5_Omnsn_-SXr2QPtvdL_g@mail.gmail.com> <e2c40d56-e0aa-45fa-958d-97dcf4f92a6c@kernel.org>
In-Reply-To: <e2c40d56-e0aa-45fa-958d-97dcf4f92a6c@kernel.org>
From: =?UTF-8?B?5p2o5a2Z6L+Q?= <yangsunyun1993@gmail.com>
Date: Thu, 4 Sep 2025 19:17:12 +0800
X-Gm-Features: Ac12FXwWY13jiEIokP_wWXDkVpoD5cdJII0KZ8QBhaK5G6WDofGKHIoKI31db64
Message-ID: <CAFQXuNa0-_kLpoy9EE3rrQvPZj0XPaSp8F6u7wYZb8TEJ72hcQ@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] This patch adds a new DRM bridge driver for the
 Lontium LT9611C chip.
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, syyang <syyang@lontium.com>, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org, 
	Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se, jernej.skrabec@gmail.com, 
	devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Krzysztof Kozlowski <krzk@kernel.org> =E4=BA=8E2025=E5=B9=B49=E6=9C=884=E6=
=97=A5=E5=91=A8=E5=9B=9B 19:04=E5=86=99=E9=81=93=EF=BC=9A
>
> On 04/09/2025 12:48, =E6=9D=A8=E5=AD=99=E8=BF=90 wrote:
> >>> +
> >>> +static void lt9611c_cleanup_resources(struct lt9611c *lt9611c)
> >>> +{
> >>> +     struct device *dev =3D lt9611c->dev;
> >>> +
> >>> +     if (lt9611c->work_inited) {
> >>> +             cancel_work_sync(&lt9611c->work);
> >>> +             lt9611c->work_inited =3D false;
> >>> +             dev_err(dev, "work cancelled\n");
> >>
> >> Why???
> >>
> > ?? I don't understand.
>
> You need to explain why that line - printing error - should be here. And
> focus on "WHY" part.
>

I understand. Thks.

> >
> >>> +     }
> >>> +
> >>> +     if (lt9611c->bridge_added) {
> >>> +             drm_bridge_remove(&lt9611c->bridge);
> >>> +             lt9611c->bridge_added =3D false;
> >>> +             dev_err(dev, "DRM bridge removed\n");
> >>> +     }
> >>> +
> >>> +     if (lt9611c->regulators_enabled) {
> >>> +             regulator_bulk_disable(ARRAY_SIZE(lt9611c->supplies), l=
t9611c->supplies);
> >>> +             lt9611c->regulators_enabled =3D false;
> >>> +             dev_err(dev, "regulators disabled\n");
> >>> +     }
> >>> +
> >>> +     if (lt9611c->audio_pdev)
> >>> +             lt9611c_audio_exit(lt9611c);
> >>> +
> >>> +     if (lt9611c->fw) {
> >>
> >> You definitely don't need firmware when the bridge is up and running.
> >>
> > The previous text has already described the working logic of the firmwa=
re.
> >
> >>> +             release_firmware(lt9611c->fw);
> >>> +             lt9611c->fw =3D NULL;
> >>> +             dev_err(dev, "firmware released\n");
> >>> +     }
> >>> +
> >>> +     if (lt9611c->dsi0_node) {
> >>> +             of_node_put(lt9611c->dsi0_node);
> >>> +             lt9611c->dsi0_node =3D NULL;
> >>> +             dev_err(dev, "dsi0 node released\n");
>
> Your driver is way, way to noisy.
>
> Please read coding style - what does it say about driver being silent?
>

Thank you for your guidance.  I am learning how to make the driver silent.

>
> Best regards,
> Krzysztof

