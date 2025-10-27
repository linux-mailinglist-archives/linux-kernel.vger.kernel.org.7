Return-Path: <linux-kernel+bounces-872283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70496C0FD06
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 18:57:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31A4B3B1EA3
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 17:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95085315785;
	Mon, 27 Oct 2025 17:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IS5CI5rQ"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 996C22D248E
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 17:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761587814; cv=none; b=mOjZzkdlAEk5zBimpXvVi1ik0v3xZqjhE0HIOJL1Jx5UTV2RghEd4E99EiflqOcbHiCVOtuV5jiZc/2M1NleTNEioOFS4k4l8mah2j+11wgTNt9MOkY2yj7RrPVqhTcra5zt/E0hIkWOvwDs1lOthB/itaLhES+x3sEaAl2hOd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761587814; c=relaxed/simple;
	bh=SCIPeksxx2uDarfAhuXFCN/oVVLcwA7r7uPbkIEyGqU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I76Hyt57PLHsyXebhAvy/VgYggsPUXBwF7kz4A0Vye5Rt6beBkGKOKzDex2GAR9bYXF9QylV/nxcqC8xT9GnmfVo3O5kh216K8B8n3Nldcr6rDIv4ZsrYr0tqvKjEvD21NugT1ljudMFGyJtZxefAVPSGOSP4lntlICAh5JjyBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IS5CI5rQ; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-475dae5d473so26858515e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 10:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761587811; x=1762192611; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SCIPeksxx2uDarfAhuXFCN/oVVLcwA7r7uPbkIEyGqU=;
        b=IS5CI5rQdF27eg/WCpXgLI2Zyv+9BcInRCb9Eu9VOCfKCHxPuKzd3ul3LeVDp2Rz25
         gv5lDFoGKy+UukPfyev+KGMqnFRw8ZBsw49dGyuiQERap0Ekw2dz9pzDLupUR5pqeAfG
         tsJloMnfa2Bi7Mo3FtfHqxVSuOLOVuePsGJzdqNtmAQT28TIyIJ1uddZevmBbmJDzSUx
         KIFizCr2A6Axgcwcj3YBPoyk7AUqNr4zLmghZ827LJZ7qi+z9A6hUVc1akUwjUFQ+Qu/
         JUhawW2kDFauJuWErOZ9Ho2AYfzYlK3l7gmMQYL9r/QAbDv9ycriWM3IWUOQ9O7tZind
         H8gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761587811; x=1762192611;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SCIPeksxx2uDarfAhuXFCN/oVVLcwA7r7uPbkIEyGqU=;
        b=baU+x2Lmkd/W15cy4V4W1T3UJEYJnjtqx1PHaUegbVmzcv8qRYT6d3lZUriytyroPz
         B2rb28WmbCrHM0cgry/27u0yYktewrAje0Sb9W+cGbVjFMeH0wEPIEUAbHaMiNb7GOEt
         qBZ4XgM69i41Q4SPpR7iYkYQ9657YkE+puaNC/hWZDxODpEcKmUFyQQpw3nZ2kJ24nM3
         vISl3kI6E03ISnCi1K935w6NpopCQjtyeLyHIrgFqzeOnYwHBdEfTSnLFF4YzTilwY2j
         UKL6UMIerAbfBIuFsYi93lCfyBv4tEa8weqQnl7iMY6rTY7+DzW+ao9Wmew4Oz3ea2r4
         XMEg==
X-Forwarded-Encrypted: i=1; AJvYcCW1MlNqA55M7FkKCh6uSeYr90OVFlbqNP38Vnsix9DxBryfU8gs+KpRoOOr4aODLHYlNwIQZ/eqzh+SshY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+WXiyzkZ2g5lPQME5vOHnUps7m6iC7/RUglMZ9adRUMxzgrP0
	9LstxazlSOD5JH3CLea40E9kjDrlVWtmSD0TKYEJEQ3Opxlrmbnb2KeJ
X-Gm-Gg: ASbGncsl7nf6ZmoPcDtu+CV1qOVLxiiVyzC6NP1PyNMTRf3B1d8XrDzs0sfea54yg0A
	NKk6gekoLqIWw4HK+iNIyciMmuMNx0e+FLCrzYZ2wzBHCuIk0NaX7ZLzVDA5pgSM7breR7FLSMR
	nuCtvx0CbmZ/obz5ThHl8zsSfRJwt03SvYl2ljqB+cL+IWkzwxqwVylnvAHUW+4+4BsG7hyXzyi
	MMjYuUHETnIXQthEqRs8WkSlQGx7gSCr7FovAcGikWxlZ/UuFq+ppgVPVZCdT/UBWrUsJx7npd7
	jYF32OKelzX2IJI2828PkslsbVlElveZ6IUTlvNtNe8HoCvjk5LazRVD0O0ml6t3ivx8Ql1qmpb
	474T1PZiovg+63i0RxXk7M9QpCcBmY9j3vUp83FsNYR68icb2umwGT0gcB2xSC8Hy7gxFaMVhJz
	shVmSRIuwkp0XofyZh1Ry0EHwjtU5XF1779sPdhujtWkehYVhK5T7NU2jjug==
X-Google-Smtp-Source: AGHT+IEihm/mMfPTi4flOTdp91sIkNaqwi2a8InYOu2pJ2ai1utyKQHaHYaafUG+/91FRnDBC8gdGw==
X-Received: by 2002:a05:600c:64c4:b0:46e:1abc:1811 with SMTP id 5b1f17b1804b1-47717e512bamr4754785e9.27.1761587810623;
        Mon, 27 Oct 2025 10:56:50 -0700 (PDT)
Received: from jernej-laptop.localnet (178-79-73-218.dynamic.telemach.net. [178.79.73.218])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475dd4cc596sm152270065e9.15.2025.10.27.10.56.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 10:56:50 -0700 (PDT)
From: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Chen-Yu Tsai <wens@kernel.org>, Jernej Skrabec <jernej@kernel.org>,
 Samuel Holland <samuel@sholland.org>, Mark Brown <broonie@kernel.org>,
 Vinod Koul <vkoul@kernel.org>, Chen-Yu Tsai <wens@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-sunxi@lists.linux.dev,
 linux-sound@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, dmaengine@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH v2 04/10] ASoC: sun4i-spdif: Support SPDIF output on A523 family
Date: Mon, 27 Oct 2025 18:56:49 +0100
Message-ID: <6204310.lOV4Wx5bFT@jernej-laptop>
In-Reply-To: <20251027125655.793277-5-wens@kernel.org>
References:
 <20251027125655.793277-1-wens@kernel.org>
 <20251027125655.793277-5-wens@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Dne ponedeljek, 27. oktober 2025 ob 13:56:45 Srednjeevropski standardni =C4=
=8Das je Chen-Yu Tsai napisal(a):
> The TX side of the SPDIF block on the A523 is almost the same the
> previous generations, the only difference being that it has separate
> module clock inputs for the TX and RX side.
>=20
> Since this driver currently only supports TX, add support for a
> different clock name so that TX and RX clocks can be separated
> if RX support is ever added. Then add support for the A523.
>=20
> Signed-off-by: Chen-Yu Tsai <wens@kernel.org>

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej



