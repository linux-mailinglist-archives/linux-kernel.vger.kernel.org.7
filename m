Return-Path: <linux-kernel+bounces-850971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BF14BD51BE
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 18:37:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ADB35548339
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 16:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAC6530F538;
	Mon, 13 Oct 2025 15:54:44 +0000 (UTC)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0448730F529
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 15:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760370884; cv=none; b=TAIaAktur0hyxfRosWAspC4YX8X50biWy/5XTsndqrYAgCovOVQpYTfos/y9U0Ff5RH0+zcVAOZFK8PiXRwOEtf2zZLDpFVqLkMdfXGfW+xvHW5hwRIOL37ZaadLBkyPdqSwH7xX30BR45QShBMRnyK2qgI4ZdMkQIztugW2Qtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760370884; c=relaxed/simple;
	bh=+UssLPOno9XWeKCQGJZY3GRGKSjKPPao4Ev4zfFKhM8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nni/RCyKf26RwJ49F1xKP819ufdK6P7/9wAPPi9W+A9bx4hxiqDYgZ2D1FPl1TCk78H7zChQVTGDJ7z/spDS6q3D+KBXdOnHLxbXDj6lY8FWZ1TULrjJqjnJnXcpZuYOuSBAIVIXCwvKLgYB+y6ae+aR8gaMT9oHmfPdbl0EGyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=csie.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=csie.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-57f0aa38aadso5084950e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 08:54:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760370878; x=1760975678;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+UssLPOno9XWeKCQGJZY3GRGKSjKPPao4Ev4zfFKhM8=;
        b=oE1jJ2UjYpqkN3zvaZ/E60atHLaZxJN4u19VXFwvc+bFj5hCtSLkwv/6i3skakVBbn
         R3ftLL+krkpP3xY3sm1C0jNc5gzra/RrCG94qWLBCx6+0warWULQZf/sLaMJWN+Ff0OR
         XE/fmK5ONtDoFjL2AZG9kNUaprzeyJXnWry1E/+S6/+kJg0q8JvBZ3s+08JK0IuILLa+
         kpWbTIcYwR8czEQiCbpjr3bdd7xLTe1EBCkNtJJIT0iLGGjeEjpF+GoJBdhC1GiffF+0
         zOaV1vTCtSc7JnR/QBipgTiM9WwJ1wT14NUzFdnnhojKKs1ljN5/wxg26U/9WpV3XI5R
         6D2w==
X-Forwarded-Encrypted: i=1; AJvYcCVKLY300mziVOVY08VYWwDjmEvMrqXHJAdmJnHrdh+YWv0E6XHUfUlVEG/XOsrZQutfqWI//96IqOmtYfk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0uCP90EHj9UMVEDrJbyfAmPHDAEgVVBr+bg/nQ9lQl2rEtJUe
	EoemNVS9tTNCuiCbm6nIrPaDVPk4Ya/JxDOsTpu9yqDqmXoM7+uVbQ+j74jhCkbi
X-Gm-Gg: ASbGncs9StA1aOEhlIjTbJ3u/EVbRXYI8qlodTKDuIyvbdQdKvKEOgWjkx8oZWhPCxZ
	C3uSGxwcqXFgWRHx32xKyo6mdai911hCLO/bvcJYMQ/tsCm85+KVIAUkDMN5hD18COeQDBVHVg9
	Di5MY8Gk6vzM22AOlPj1EgJtG34exXOATl6YVPXWOgx0j33EZkF+f/BZ/3pGC2ld4WQsNTHNft4
	X+yRQItMMe0LMAHic1JjtRPjY/1Em79DezAnAGHv5rJ3b8srDFN88v/8j47ceCFV2WyH8rYzyu6
	qCuB9T/WNNBqjq262Jx8JCMg2OiJsYODBtTZvLaYIpyAurKGKAEVWOM/88N+6aihMUyqB2v1mtn
	BGr3eCvixt0dFvoTOnfoca6dyUMqxX4+UrfvyEgLr/a6N8oyhYa39E7Hm0lk/hr3bbmD7Qw==
X-Google-Smtp-Source: AGHT+IE9+VkMUgoUwZY5MiwRar9qtieReRxr+43VorLBKWnclx0wotY6MjOW0EPZLJwxXPL5OnR4vg==
X-Received: by 2002:a05:6512:2347:b0:57b:8a82:1dcf with SMTP id 2adb3069b0e04-5906d88b2d9mr5541011e87.18.1760370878312;
        Mon, 13 Oct 2025 08:54:38 -0700 (PDT)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-590881e4dd6sm4226779e87.17.2025.10.13.08.54.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Oct 2025 08:54:37 -0700 (PDT)
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-58d29830058so5384655e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 08:54:35 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVlvOK8uCvVFZ76MIPtLz4/bIYw3WdkXgpBYZ8zEr4ABukW4euCjnVBbQcUyXAdcR1Fb2nlvXPR7YrbHww=@vger.kernel.org
X-Received: by 2002:a05:6512:3e0e:b0:55f:71ad:590f with SMTP id
 2adb3069b0e04-5906daea8f6mr6270458e87.53.1760370875744; Mon, 13 Oct 2025
 08:54:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251013152645.1119308-1-richard.genoud@bootlin.com> <20251013152645.1119308-3-richard.genoud@bootlin.com>
In-Reply-To: <20251013152645.1119308-3-richard.genoud@bootlin.com>
Reply-To: wens@csie.org
From: Chen-Yu Tsai <wens@csie.org>
Date: Mon, 13 Oct 2025 23:54:22 +0800
X-Gmail-Original-Message-ID: <CAGb2v66nojdOfU5oDOCTDummqpcXYuu5665MKJRee2-QfhS36A@mail.gmail.com>
X-Gm-Features: AS18NWDKdIBd1rTcxTVsXd-_vXNa-9kC6YbGbqd54hyWKYs7fg_lZoQPdbhPU9g
Message-ID: <CAGb2v66nojdOfU5oDOCTDummqpcXYuu5665MKJRee2-QfhS36A@mail.gmail.com>
Subject: Re: [PATCH v2 02/15] mtd: rawnand: sunxi: move ECC strenghts in sunxi_nfc_caps
To: Richard Genoud <richard.genoud@bootlin.com>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>, 
	Vignesh Raghavendra <vigneshr@ti.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
	Wentao Liang <vulab@iscas.ac.cn>, Johan Hovold <johan@kernel.org>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, linux-mtd@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 13, 2025 at 11:27=E2=80=AFPM Richard Genoud
<richard.genoud@bootlin.com> wrote:
>
> H6/H616 has more ECC strenghts than A10/A23.
>
> Move the ECC strenghts array to sunxi_nfc_caps to make it ready for
> H6/H616 support.
>
> No functional change.
>
> Signed-off-by: Richard Genoud <richard.genoud@bootlin.com>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>

