Return-Path: <linux-kernel+bounces-861477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E40A4BF2D2E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 19:58:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 69F9D4E8269
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 17:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36C653328EB;
	Mon, 20 Oct 2025 17:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TB6sa/bx"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED758331A7E
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 17:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760983084; cv=none; b=P5/rXQs5m3cblhSgBdVGdt2kXdbngqLzhQd6mNoFO4wDPKJwW0Pl3xXotvkr09l+sawsbaSz2cOO2i+3bGD8cJq1mBz9PDbHfSyorw1CnUDyRrepaS2pOwCM2KTP+6plStjrcAVcKk/EbIXQEkWkm37CZaE4Ew829s1k7VW/I4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760983084; c=relaxed/simple;
	bh=iJYNXDViBNg9H23IU+cEG/iUlaVVosMhC4bKdCUk1To=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cppUy67ztXTPaFsneHK89ipdnIUdVfjPvkeLetpBS5Vngl/tg8YTMIpjraKkgrIT7S3D+o9i73bYJ/JPT2fZS7PqhG/rMxzKP8jhedwAai0vS4U8bGivm76AsngWgJamBbBry+v9wbdUQRxZM4ZEg+MKnHZ0iHhVg5hxiWBSD9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TB6sa/bx; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-426edfffc66so3444011f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 10:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760983080; x=1761587880; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iJYNXDViBNg9H23IU+cEG/iUlaVVosMhC4bKdCUk1To=;
        b=TB6sa/bx5bkTjJ5MaRhcpoj6Tf+mFleUpkzyR1LtkRSW/kXnqrrcGWLQ7C9+UprhCu
         K1XY1qd1HVhm3OvgiCsqJNj0FM4j2JMbZEDSRepw3+TdidZRy4/ZurPhN5XLQYdrbMmO
         Lsn/gkkqUQ/7qMWdk3UfjUTRMGxLLUJTKxihy2FsmjW/5+zCubXFEEs+/IaRPFEzQzEJ
         wJ7pyfU1HWpXxsuNJTR7E9RGoDFMVintFSrrcBougdWmQv/+YiDsKLoHahosFgX35b6R
         9i4JyJGfT0SlDNxpF2MpizZ67ZIo8q3L3+faAIJW6gXLbFpDbZUvzsbnJ8bJjvb24p4r
         LE7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760983080; x=1761587880;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iJYNXDViBNg9H23IU+cEG/iUlaVVosMhC4bKdCUk1To=;
        b=AKKjDP5Gi7zLVArRoLoV6JA6eprG+kVaWvjrRCKVrwd3UXC18VLhusJh5WQovpkvj5
         vWPXWWgyGdO69qCcwGTRYv4Zws4ty7+sEvv+BcbXOdPPrcP9XAK6gmHYryiAWkAyMvhk
         vlI7QrWSK7Jj9CEr9RevSOFHIQ7lwQIR90MBbkoJ0J6djrMHkAY8fh9ioXiS68lB1V3P
         rpmAN5AntEaSs227ya+T+LMTzePEZlq7iIzkKO9WNGJFftBkvkOLtABx1x5UblLkZQer
         WQD7dKIX+XbkZTRxvErS04o4CJrnVu4OPj8TpmNeScbc5m/mIT15a+E5O37P5mhalG/c
         UBVw==
X-Forwarded-Encrypted: i=1; AJvYcCXAR/y54Ugbsa64WeDcRNBFSr5emN5vDzf3K/Cq971RgjEhFkNF1bBggcpS8QrSqtLqvlxwxI+p/0wEx/U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwECvOLM7CIl0frphVSr0xIyz2HwnMpq/aoWMqcAuowJMGRZ4MT
	MeGMuvhe96628PWFPUsOON3XSbubL/WybQTgkRgH/0PsK5mkRd70aMKI
X-Gm-Gg: ASbGncsIGl37A/s1z8feOVXuFZSH3LQYAQ0uQaSV6fbj3F5xPoYwf50rDyGFRqa6PgX
	WR94Gsoe89ofeXWHXdhG1P/8doWDK9N2TP6+F0A2M7uA80LSgm9tcP8mCIwX3ktir5T/mFXzm+/
	qWlM4t5qnbUKvPWDzqzCt0VYo9umFC7n2R4Dj05KSvs/YppPdfHJUAT+uuyLgGPEZ6Svtdpl26f
	2nHeCOmj7rgMJm43f0czeNyp8V8K5qAqNb03HG4Dpd/IxLnp1n0KmDyoQkFE1WzDAu+n3jd6/3R
	uA7vKe56hFQri6QqQ/PP3y+VHdkW4K+Ni4UehVm8KU2ywoQ0sqmUZfjLfC2mAZul9L2WDefIRur
	Rv6fckJUlqhDlqJZBdK6K8CT7c2IN5JiNuxZX7cVUMpFMWnxWsoYaRB9qGZzdAPVHjX0mfqs4ac
	VWtC2s503WSAyW7bRv/KCAoKtmiwBrbRjkmp0N0N9DPM39/j5/J1qR1t8v6H0EV7d/yoFs
X-Google-Smtp-Source: AGHT+IEQQl9YZkR1BgzZ6Z2Nufpu9HBikDewEvyF4EuaS29j/RILS2DM6SBqWX87g+1TkKzsAinQ/A==
X-Received: by 2002:a05:6000:705:b0:426:f9d3:2feb with SMTP id ffacd0b85a97d-42704beea1emr10367539f8f.23.1760983080172;
        Mon, 20 Oct 2025 10:58:00 -0700 (PDT)
Received: from jernej-laptop.localnet (178-79-73-218.dynamic.telemach.net. [178.79.73.218])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427f00ce08asm16294878f8f.44.2025.10.20.10.57.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 10:57:59 -0700 (PDT)
From: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Chen-Yu Tsai <wens@kernel.org>, Jernej Skrabec <jernej@kernel.org>,
 Samuel Holland <samuel@sholland.org>, Mark Brown <broonie@kernel.org>,
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Vinod Koul <vkoul@kernel.org>, Chen-Yu Tsai <wens@kernel.org>
Cc: Chen-Yu Tsai <wens@csie.org>, linux-sunxi@lists.linux.dev,
 linux-sound@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH 07/11] arm64: dts: allwinner: a523: Add DMA controller device
 nodes
Date: Mon, 20 Oct 2025 19:57:58 +0200
Message-ID: <2324646.iZASKD2KPV@jernej-laptop>
In-Reply-To: <20251020171059.2786070-8-wens@kernel.org>
References:
 <20251020171059.2786070-1-wens@kernel.org>
 <20251020171059.2786070-8-wens@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Dne ponedeljek, 20. oktober 2025 ob 19:10:53 Srednjeevropski poletni =C4=8D=
as je Chen-Yu Tsai napisal(a):
> From: Chen-Yu Tsai <wens@csie.org>
>=20
> The A523 has two DMA controllers. Add device nodes for both. Also hook
> up DMA for existing devices.
>=20
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej



