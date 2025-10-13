Return-Path: <linux-kernel+bounces-849894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C6EBBD1346
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 04:19:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 541C04EA03B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 02:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55F871E4AE;
	Mon, 13 Oct 2025 02:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kIPkiHkQ"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B2F279795
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 02:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760321933; cv=none; b=Bh8L8tNg077SuwgQdtqCK3Yh13Il0qaDsaLqUaWEg4AIeEtwjOpOvVPisDbh04Ky+jTPMwLemPhFgyi46KWolY+b1D5JuYKMIKm1M2XbQbXs7nBFhw/HsORzD6Dh1vwVZct6jkQrM1KgqmYZbfquaTpgokieQNkiWO/XpSjnW2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760321933; c=relaxed/simple;
	bh=9PDrTUGmEtHhlWROJVzFemxew+01a7v8V9YahKSqAgw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Aw9SlHImqkq9gISlkO7TYy4g9DMNOgbDIhxnobTyuvRRLULSd8KvG6ykWh4j8i8i1D/VD+hHEEbVpKkzOPyyir2bfqfVfsdJZ3mp6cQzDMiaZ4bSx6qcWnVPRsIgeAK809EblvYcJELyrJbzFZ6EVR5VR2cc0unRypcBC8qWBLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kIPkiHkQ; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-579d7104c37so4544726e87.3
        for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 19:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760321930; x=1760926730; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9PDrTUGmEtHhlWROJVzFemxew+01a7v8V9YahKSqAgw=;
        b=kIPkiHkQTsEnp+Hl3dnoCd6vUP3X6XN5l4n9+ixvmJTjJ10hhqgA68j0wmm/5u3iZy
         DPmlmdWEgMAg/VqRQp/p/ConAqk5fkdUET2819ZYBHry+5pXknRSAW27uAeeicslb+py
         uSFPqa0iQelmQbHtwE1yXrgMFoNNDQVey4Oop+cW6puqav33Wji0VVQdqak9JQYuj1xu
         yj2os50x8xGvr62JRi2ylg5fMwBVREj06d6MkOPjzO+PCozaeJbd5Ap3TCzJaAs03pfL
         vndKRRLTb1a1E8/gRyfqwH44AHqf2kx1gcYSCPmwkGiKg3wB/sgs+uLWL/tpQPbsvUbB
         GJlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760321930; x=1760926730;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9PDrTUGmEtHhlWROJVzFemxew+01a7v8V9YahKSqAgw=;
        b=qVNnQNmyETjwOsFuAbMg4tG+GnKETZoH6pO/X3L3McF1Q+S2ddzMiXJUgP71LQ9sEO
         7I2HHAvOjHG/iij79nbCKIFI8hsKRov1dSU4uNRCTGja7Fm6TtOI8wQGctCtqfJrorXP
         sIleUTGC69rzxJINQWkeb5RIahEKEcKNsR945WGR6tnFY9KkHXVb6rRCSMI+z7MHHxtr
         DWnDcfmWPzPJs0PA6QibwlvVE4Yw3/6x45KE7QcK54hrlctZP285iaL4rzwoPUaCIQz6
         VnUZAVSEMV7ikq5QMavfmuQvdk7q1HDRD3FlcDZzZO3mmLEQdQsNQby4qi9/YTnMM78J
         R5YQ==
X-Forwarded-Encrypted: i=1; AJvYcCW36T56737dV1OTZeITSNJXVj3sxWcf+GrywTvKl0OVWt48mM/O3IbiY1tIYR1tvXI38i9hfZUWvkO2ioQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/3bQJCy4+ZjtXV2DJZqOGO18PSfmVLieajvkmSukbswLwITZN
	/LCB6mxQO+et/d8YgCR7oFSuqPgDri2o5wHm+Qji+ZKgm9FrZNzTbiIie2iTP6ub9GQ6Ngga4FY
	NeLdbnYjABdUVQVDrjMYbnlL5To+I1Lo=
X-Gm-Gg: ASbGncvTVhuqC/C8PUvveqpH+3YmipA0rWgJGzg2jyguj15NGy3dEowDSas5WGgNnqV
	OI3j72wwkke+emFNKZhC+l4rUUqPP19maYy7owrKj7vPNh3TN1otHU1Rs0tWukqB3ae09BVrKP5
	k0s0afEsaiJNEuKyXw6/csl4pMKK38CWeEH4GnqAUMMfW78eRfmRBYeBbBGAzJKjsFDN6akWloD
	31dlXCl4v20KsRFECtsbuEaKQ==
X-Google-Smtp-Source: AGHT+IFiw45hdvimFqGDURQaGtDLi9ENkklrzwLA8phy4Ic6ETpmgrs7KC/3t2Arw0r0YQyBDrm+0eG6CRv5jVYMkRw=
X-Received: by 2002:a05:6512:3082:b0:561:9635:5af5 with SMTP id
 2adb3069b0e04-5906dae7bb0mr5720922e87.48.1760321930016; Sun, 12 Oct 2025
 19:18:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909-tegra186-icc-v2-0-09413724e781@gmail.com> <5d7491b1-8f9a-4040-b854-ff0b94bfd24e@kernel.org>
In-Reply-To: <5d7491b1-8f9a-4040-b854-ff0b94bfd24e@kernel.org>
From: Aaron Kling <webgeek1234@gmail.com>
Date: Sun, 12 Oct 2025 21:18:38 -0500
X-Gm-Features: AS18NWAIF1xrgNjZf5B4apzT_7FVhvYHWdeOCO6h_dIwtjEyeBNHBiTCRjDDt_8
Message-ID: <CALHNRZ-okVZ8tzKYa=jqudDu3dZ_Yq1CkeErdcvxi5xJEgJFbg@mail.gmail.com>
Subject: Re: [PATCH v2 0/8] Support dynamic EMC frequency scaling on Tegra186/Tegra194
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 8, 2025 at 7:05=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.org=
> wrote:
>
> On 09/09/2025 15:21, Aaron Kling via B4 Relay wrote:
> > This series borrows the concept used on Tegra234 to scale EMC based on
> > CPU frequency and applies it to Tegra186 and Tegra194. Except that the
> > bpmp on those archs does not support bandwidth manager, so the scaling
> > iteself is handled similar to how Tegra124 currently works.
> >
>
> Nothing improved:
> https://lore.kernel.org/all/20250902-glittering-toucan-of-feminism-95fd9f=
@kuoka/

The dt changes should go last. The cpufreq and memory pieces can go in
either order because the new code won't be used unless the dt pieces
activate them.

Aaron

