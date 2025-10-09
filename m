Return-Path: <linux-kernel+bounces-846817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C331BC91EE
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 14:51:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E93313C6877
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 12:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8688A2E339B;
	Thu,  9 Oct 2025 12:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wdc9hLUu"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E85D2E1F06
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 12:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760014280; cv=none; b=MFILOsCnZzzNfVJmcR3kGyXjnS2RIukNug2xWXmtBVLSaHMK301pZYAK/qYFQd4trB9uq+qGeIETEjf/QOZXxRHI0EehScTJpLt2sv7uqPDs/qm+qjCVqlw+okcF9oAfea+d1PAxJXLyp50QSbpqlHQRLztyVvsGDHvIS5QFOe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760014280; c=relaxed/simple;
	bh=MDMFuxtj7DOoK9vdG1w2+Ih86u05O/nr3t6ARiKVfns=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JoNtTb3YmNbDNNlpwSiXKQh2KG9AbBDwIWnFD7m/l3JdUV0qwp31JqkGB13A5Q6fncqNUNE7qbSs8HzdnaoXNzQrkqZmbJhzWGgz1S97bFVd0MiX6msuOo/Gc0izQ60hhNSpVmsKS6eqUYRMLoBVIAPLhUf/xD+uPGqUTTVZIi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wdc9hLUu; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b551350adfaso750953a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 05:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760014277; x=1760619077; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MDMFuxtj7DOoK9vdG1w2+Ih86u05O/nr3t6ARiKVfns=;
        b=Wdc9hLUuJucwAMpLB2DINPGvByOuHXuXrfmBzAtrLNoR+o3hAxW+HL/WrrOQsQB+2t
         PObv5vNwkaEdjOhHTLFk4R0xJnX3Oj4HSGl4+KIx935kx2ihxNgFlJpqcrCOAPFKkoCL
         JXGyAvIUAmCPtoNRWI+XZm4MX1bfYSyf+cM3Uh1/znpWiPJo14gfwggNT/hSXBsxgB/Z
         x7W2+O2zBs66+YBefmdZxe9ZlB+Xypjv0sui4gyQyQ0gfbWjtQcPYX4PjxoTqUsU0vJx
         ODZXqh/NKl1nXaIq2mtm6DAORXAVZcZszCl6SsvcDe8+L74J8NZVvTaC2G44U415fzG8
         k/dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760014277; x=1760619077;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MDMFuxtj7DOoK9vdG1w2+Ih86u05O/nr3t6ARiKVfns=;
        b=m86q9uDP7xLwqPKOCN3UXcId4Timvq0UdY3T869QWYTH8yaWO4t9rurcAmov7z+GML
         apcTEOR3gBaNSCHPnXbT6DZTxCkJ4Q6U/RDVLrGbdAtehQ+0mYRBLS5HZEZEx7EE5Cq3
         yOFKbrxEI4KolNzL3YZK/tMKrR0WKk9DFn2maBUxYgKVOm1aFU2cn3yOQy8IGqaHc9SA
         MC64kOy/RssfFr+QohQCV+3WkZtJ9l6GPWVFTnhKkYql2NQFUpAJdIw7HPzEt/w4k8Mp
         0Q7DHJvFrmRsV2GiPwhgmlE/GTcVPGscE0CwDjYyBEXv2mqGPjEospLjmnUrL1f9m0q0
         ZeaQ==
X-Forwarded-Encrypted: i=1; AJvYcCUKhsgZQdrpcKoUgSZDcplwAis4YDFbNLGG6ETZ6AfTbtJKSCsUrzuhYZA+o/zOgmeb9HiI6tI3/7MP6sM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/mdfmQjs/IsVRlBQwEsQpm9u/HCCWCQzdcyQfTZhnK7AArOT2
	vjIEr6SdKIG0wnsuckt5Dv7YBG74C1B1LW5FrKBz9gP5hZEkR5/t3SNjCqsA02/uqI3LvLprJaf
	ViTkOkayxqAPyw4pMSQZY4unDERZrdvQ=
X-Gm-Gg: ASbGncuJtx2VIa8UYfaimU7Vp1wnBSAt8Xjyy7ivVhwDBjzUMAMAf8VhCJ3DvdGSWrK
	Du0s5HkUCauPa6lbvFQuSNcrNXQx9fMKFXgZ34DLVK0d3WIT5C1bgP6oryGf7wb4yuM+3yGxLY5
	wVmu06zVQ9B5uWmvpO3UzRwmD2eJDbA3Moll6SIBOZbYjLiWrDXH3yBXlfU9cM9yuh96Oft5K7J
	vLlRx+fe3JKeDYb0PjPN/iz7daGHJLL674fakaus5a8vA1q2k3v0Zoqbp1y
X-Google-Smtp-Source: AGHT+IEhAV1wqwmuEfqj9eDPRuTr5xhy6QzH+Fe4j6lHSFhQoyHt9bJp9C/EYN1+uc18PLR1t+1Bf7rHPlE1k2VNj6E=
X-Received: by 2002:a17:902:f608:b0:263:b8f:77dd with SMTP id
 d9443c01a7336-2902741d0a7mr98644915ad.57.1760014276668; Thu, 09 Oct 2025
 05:51:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250923053001.2678596-1-shengjiu.wang@nxp.com>
In-Reply-To: <20250923053001.2678596-1-shengjiu.wang@nxp.com>
From: Daniel Baluta <daniel.baluta@gmail.com>
Date: Thu, 9 Oct 2025 15:53:34 +0300
X-Gm-Features: AS18NWAD-sPW--RGZUkk020BQr_wBUAqvEISI-DaoXi4Qt_J4rUCZMsA_rvkqkw
Message-ID: <CAEnQRZCFk=07=tDgEPJeXx_xDp_6LGXi+2o9GAADoP86mWYZ2A@mail.gmail.com>
Subject: Re: [PATCH v7 0/7] drm/bridge: imx: Add HDMI PAI driver on i.MX8MP
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Cc: andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org, 
	Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se, jernej.skrabec@gmail.com, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
	airlied@gmail.com, simona@ffwll.ch, lumag@kernel.org, dianders@chromium.org, 
	cristian.ciocaltea@collabora.com, luca.ceresoli@bootlin.com, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	victor.liu@nxp.com, shawnguo@kernel.org, s.hauer@pengutronix.de, 
	kernel@pengutronix.de, festevam@gmail.com, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, p.zabel@pengutronix.de, devicetree@vger.kernel.org, 
	l.stach@pengutronix.de, shengjiu.wang@gmail.com, perex@perex.cz, 
	tiwai@suse.com, linux-sound@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 23, 2025 at 8:30=E2=80=AFAM Shengjiu Wang <shengjiu.wang@nxp.co=
m> wrote:
>
> The HDMI TX Parallel Audio Interface (HTX_PAI) is a digital module that
> acts as the bridge between the Audio Subsystem to the HDMI TX Controller.
>
> Add HDMI PAI driver on i.MX8MP to make HDMI audio function fully work.

Tested-by: Daniel Baluta <daniel.baluta@nxp.com>

