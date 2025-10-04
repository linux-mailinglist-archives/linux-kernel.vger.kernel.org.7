Return-Path: <linux-kernel+bounces-842154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BC72BB9183
	for <lists+linux-kernel@lfdr.de>; Sat, 04 Oct 2025 22:00:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1866A4E8F8E
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Oct 2025 20:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3A98285CB9;
	Sat,  4 Oct 2025 20:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="gK3JVhjB"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA77217659
	for <linux-kernel@vger.kernel.org>; Sat,  4 Oct 2025 20:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759608025; cv=none; b=iFVymvsVDLaPoYT6af5037lZJLe6A1MlT+ean7NMyxREfCy3D1YdMEWa8txhJXz60N1McrEKAvNXVIG1SNONMcZn8v7Lj1tED8Ex9GXLP26K/zW3EJZ89obZz4LyoBmrI5dFityBkGqN1Sm0D7XA93KEqk4zmfC8gz9D3XeSsds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759608025; c=relaxed/simple;
	bh=Y7aP5ANWHznsHRPpXqT15itWt6xDKWtsAwFYNj6Ecek=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PNk2j6Cu8k33rMpD74+oavYNwLXfByf95Rxhxj2kdVudfCGPKzuft3oDYzlHJCyJ29qc1vu7plgUYsLsuc34iphVX6LHTzgogp+Pyh6m6BFPN0BTQpSK4rdvStVLVdwRs9vCjqcVzYxHUY6562VUbiVmCvbCiUMlsLJ4eafhGpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=gK3JVhjB; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-27ee41e074dso37465955ad.1
        for <linux-kernel@vger.kernel.org>; Sat, 04 Oct 2025 13:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1759608023; x=1760212823; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y7aP5ANWHznsHRPpXqT15itWt6xDKWtsAwFYNj6Ecek=;
        b=gK3JVhjBVzca2lJCqNHEZe4BhwnRugbTEFHsJWLYXZEfbfwMCqjEK1uPnVOPpNNBEd
         YE0Ab3rl3NuN6LSTtlB+YvmlQ6o+JTcFKIrnCXLUALmVj5dBdtPag3OYVHtjnZXa50by
         vXZ6+fGf/dtYMruvlzyA4fwH8O55UHQZteWg/IRzwR3X3WXMxceMqAUjNb4p8z6z+dPx
         sZVz5fOPIgwUKFeYwgZ5zcYIJqjTq0nv7eeqh0B0qmCpbYiqH3qpvLRxqaqQUQCdSQ9s
         CbCmnJz/LaKK+d61+xiPRxwS+u7vq9B+1CAy3WJYQ5BnAsWbx1BIFVZVx8jYiJ6HKIIx
         5ohQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759608023; x=1760212823;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y7aP5ANWHznsHRPpXqT15itWt6xDKWtsAwFYNj6Ecek=;
        b=sLGj/oIpCUHs8bPHSAs401scDJdPezGS2/LGICxD/wCAQ2il3OCna/gbNSoN+d+7pi
         eC+Q6B0D+GcAdbQLlrogRQoOOdGLJqqg6N9ltovBJwpfZOy1rRzspNP8MfI+uGP6QtGj
         oXvgtrCLFby8vLXDbGOVXldwhgY7km570o0U6x2lGQ0dcb8Wtqn1QXnMqNFiQtv8/jmc
         umFUHZn0T0YE3wz30QN6dEoQsrUTPQYLwOMafJuA38Rnd64CESIoH8XzYh38+kAc8hjM
         YVDfBeA6nCB/llwVV+628pLGxbOPXzHiNXvelaLNvhniePHz78SMvLATHa6Oc7LSY3cj
         AJmQ==
X-Forwarded-Encrypted: i=1; AJvYcCVdnx7q8LExDsVqBdUfyg/AwZrqqhonQU1L3iWCwPiYgt0bU5rjz2o/ZnwoLtLHNSdxFoguJFnh64C+GSE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJ83SKp/zfd5MpWcVWEtfY+mmnGBoVmP6mEpROAynNW/iVRVgE
	gN32/ye2DDe8gxEkIKkSArk/lcP+IFvmWd1AgE9qdrIFd27Pfu8kRTE/y2B2lFrkQWgE92PwDWV
	mEz6rJxivj2J5S2SX3CQgs37079jH1rY=
X-Gm-Gg: ASbGncu2PqLffRMXWCoBHs7Pwu8OfjqEjL0C5opO5NUgU8OWC7pXttWk8wTJaZrXntQ
	UM8a0mbCinGdzvDO2Kj9LJqM02m+ZdBf3+vbp/tls02/nmVM0IZtg6/wuOlEOaqTcaTeViKKq1u
	1TU2j0hPh9eGtkt45/nW4FvCkLhU56QcoFOl6gRb+bTKt5iMhzHzJ/qlI/GYYN24v3k1d29k5vH
	X4d5BKXcJnZs8ImvO7MVtwrOCcvnBJWzcDYU6xUWpz6z8EMkXa+4Tn5ggyjA/Dr
X-Google-Smtp-Source: AGHT+IGt39Nt9p5q066AwuwZ4TSsvdBdT0kbd0QVrdYOaUXToPuPqoewdXCA9vnV1UglZ/I0nfi7H/q2TLlH53BiA4k=
X-Received: by 2002:a17:903:b8c:b0:276:76e1:2e84 with SMTP id
 d9443c01a7336-28e9a542c2bmr87291145ad.3.1759608022835; Sat, 04 Oct 2025
 13:00:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250927125006.824293-1-christianshewitt@gmail.com>
In-Reply-To: <20250927125006.824293-1-christianshewitt@gmail.com>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Sat, 4 Oct 2025 22:00:11 +0200
X-Gm-Features: AS18NWCuGwewacgkM0Ab0HEEi4QG9Szb0DHvCKwfduJRn9-rG355CymOveg6Dfw
Message-ID: <CAFBinCD9qq0_ppwt9gbyKW3kcSr8PTX+rnVPbrM33YOABxSoGA@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: arm: amlogic: add support for Tanix TX9 Pro
To: Christian Hewitt <christianshewitt@gmail.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Kevin Hilman <khilman@baylibre.com>, 
	Jerome Brunet <jbrunet@baylibre.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 27, 2025 at 2:50=E2=80=AFPM Christian Hewitt
<christianshewitt@gmail.com> wrote:
>
> The Oranth Tanix TX9 Pro is an Android STB using the Amlogic S912 chip
>
> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

