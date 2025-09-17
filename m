Return-Path: <linux-kernel+bounces-821214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B954B80BE4
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 17:51:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C99EE520DEB
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 15:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6611A341343;
	Wed, 17 Sep 2025 15:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m5CYZcEw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD171341369
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 15:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758124284; cv=none; b=lwkDktRUnd33wNPK8KRZssF+TJeOlnx0ttlqhR+V3Wt/0d7KCa24jybmu5NSz8OFgPtw8fDB77DCwQmNTGtltqmKfvgF0jksBf3Sk3GP11zESah2CTLh37rlIY4PyDaroYzkBkJI8Jfs+rorgcf/tvAZvCoxnBerUINjz5MWZiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758124284; c=relaxed/simple;
	bh=wSDjAsdy1ct1IIj9UD58mmKxQTBpcvJkQYhQiEXcDx8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hKFi70mOnyl1We87XvitSlI+xRiKcal301CWjOOohvRU0pSuCdd9C9zBGECg0uEuD+GEIAkqbQnYIFFrjoAd6oGCcuMH2pnmBnZCJRl8kj+93usRllWGkrsDVkVYY20ZcWT6fg2QabP4S4LofIMzixmW1bxpM3SnyKeXvhHmkJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m5CYZcEw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DD42C4CEFD
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 15:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758124284;
	bh=wSDjAsdy1ct1IIj9UD58mmKxQTBpcvJkQYhQiEXcDx8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=m5CYZcEw9I7nmEIE1Tq0HNpmDpKsZ1VUBbba1N5sdJ0CX8Q4ypsTVJjSlKRXJW2Rr
	 NTgculME0vaLnuJuSi62owwSgX0hy5Dmi94lgSKJJnXK1zpWo4bTd/2/Uu4KycQYsj
	 o0OpgT504LLvqN4xqLDUxA/UDM0aB15rOIERiroBl4rfx0EUD7zQpxIoW28L/Pgc0D
	 7E6/qjsAbXGsTo/ck4fJFBqPj5fChfKABMOg32HCxB0QFRMS38DHSuzUqlIzkEimQT
	 TieR8DnY0w3AeXYtKU14PvlDCupoO+78nYY8MsZmIJ+LepTvcqF6mPdOazTc/FBXzh
	 uU9MDAKZ6GEgg==
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-62f799a5b72so3156448a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 08:51:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXTyaFKeQn65ehMJM6RtAF3xmKfTFVb7273oaOrlgN0/ztZDKsjFAdGrx/wnvte5zfokiBUTQAPdPa7Qbw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7VtxNzX1Tw73Gb5tq9wnrTOZQud0TIzIpfgRDnWXDZsr/Rx2D
	65ravCxGNJ60eey/A626B0mQ1EelQTUjZTJ5aydu+fspeSM//lazoQcQOrmwOL/1I+7vwy+LEkN
	IjXZTh8g3ZeJw2DnPAb7UKzbt5YBYzg==
X-Google-Smtp-Source: AGHT+IEQUNiSULF4RZPxrd843RJxsNMWcyn4gHHJzWTPo6m9QAE6ENXTlI1iqzcmMiugwwweVXgbQDyWGm2y+akvks8=
X-Received: by 2002:a05:6402:254e:b0:62f:1e7a:f842 with SMTP id
 4fb4d7f45d1cf-62f84430f45mr3188147a12.27.1758124283072; Wed, 17 Sep 2025
 08:51:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916171327.3773620-1-Frank.Li@nxp.com>
In-Reply-To: <20250916171327.3773620-1-Frank.Li@nxp.com>
From: Rob Herring <robh@kernel.org>
Date: Wed, 17 Sep 2025 10:51:11 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLghe-hR--D_Mm_rCnEDegLeaEQyZm2=yVVwhnf93QTsg@mail.gmail.com>
X-Gm-Features: AS18NWDNgIjfZE_pIRM9cY13pxhbKfJyaLfWDBALsl3X2phF46vfhhDL8g2VqE4
Message-ID: <CAL_JsqLghe-hR--D_Mm_rCnEDegLeaEQyZm2=yVVwhnf93QTsg@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] dt-bindings: input: convert tca8418_keypad.txt to
 yaml format
To: Frank Li <Frank.Li@nxp.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, 
	"open list:INPUT (KEYBOARD, MOUSE, JOYSTICK, TOUCHSCREEN)..." <linux-input@vger.kernel.org>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	imx@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2025 at 12:13=E2=80=AFPM Frank Li <Frank.Li@nxp.com> wrote:
>
> Convert tca8418_keypad.txt to yaml format.
>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> change in v2
> - add TCA8418 to title
> ---
>  .../bindings/input/tca8418_keypad.txt         | 10 ---
>  .../devicetree/bindings/input/ti,tca8418.yaml | 61 +++++++++++++++++++
>  2 files changed, 61 insertions(+), 10 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/input/tca8418_keypa=
d.txt
>  create mode 100644 Documentation/devicetree/bindings/input/ti,tca8418.ya=
ml

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

