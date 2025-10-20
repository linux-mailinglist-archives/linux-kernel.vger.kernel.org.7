Return-Path: <linux-kernel+bounces-861201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DE76BF20C9
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 17:17:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AF7384F4386
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 15:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 579551C84C0;
	Mon, 20 Oct 2025 15:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SRiXGueT"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA041E1DE5
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 15:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760973422; cv=none; b=JJfxA9edIQZ/vA0X+d2HIG0kGdCK+kftFj0MFnLNZAvK7Nq0nFjRmPAgnrFe4K/snqHHB4t57uaNwhFYqvjVoBKS8LkIC7bWKLYlsJmERWpV5g3Tqec4nBNyGZypP72FmzvL1ulOUcnb4SJVVbhnKr0DJDRkn2fhtFOTDkn1i8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760973422; c=relaxed/simple;
	bh=WDTK735AtuvvXpuAH2jZcOxzUM5aYc0QEvIl8NwZbRs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P7jWEppn03MPYtlnTfReVX86erUg4T5+0NStyuhOZaJ4HDQp3YadfMqO+TWWLUA5nTRePmmBVticSsTY3RRVLxPvE9zKSgrYXIlDPGrV66EAiUi7jO5jya1jZjOZ4lsIoh4RtW/lNUgvSAVzPUBimoWv4ZNTsRFN2JRzxApm5Ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SRiXGueT; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-4270a3464caso1916279f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 08:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760973419; x=1761578219; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WDTK735AtuvvXpuAH2jZcOxzUM5aYc0QEvIl8NwZbRs=;
        b=SRiXGueTdxt8eS8QXd711Cog78PGb0iByc3KPrGU4YYcu9rpr0snwSInYB+mmNRYBd
         lp9s7OD36FfYZUrn6sZ0xB9Riq7ppm9bG+HCJpLI71Ltb8+8Bp24lizCrZBNlUe2cBi3
         pW81BuTJ5iXbmdPtgnN7t2T8+sA6Uz0WaC047cG0O3DdJsZjoLzyKLTgwW+O2YnKVSh+
         9hLlL1bo8u3l/Jm5ZTEAwbz843juSE00hWAjwS6K1VEiw9waWT6uD0mlOTpY8Fpd8P8r
         PZX5vrITqFKNr0+JFSY8iYe8ZmM4JK6gI2BrqLVDYo5hXCfeazLUIHc+531kNeTs+yVP
         Iraw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760973419; x=1761578219;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WDTK735AtuvvXpuAH2jZcOxzUM5aYc0QEvIl8NwZbRs=;
        b=UuSFsQpXeh8BD293R2F+0gEoSIIqSWXeuNlWNQ/C2juUt1CptHEjgDHKemgpK1VZ4v
         XFcvM3GuALUgP9VMx7hE/icsG7Ukjtj/wcLMvzJFYy3ItU1noQYO++dRHqI5LBmuh7dV
         7v9DVTq3MYOyUFYNHutyoMUH3xInMuR7NEvKPq9f3/eQI6Aplf7rh50I+CYXqDMrRQ/a
         f6rilBt2Bcyi/tlwCfXo3DNU2IMaCf4ABADswVoVmobUMsOELTRUVYefqviZnm17H+Cx
         OWKUZvTTgxX+sR4/poKLtZySSiMoJUOo5bcxcTLOZjb4h7k2DRBhS4ynzakvgTwB6kOr
         /+Gg==
X-Forwarded-Encrypted: i=1; AJvYcCVcwos3GKuM/ckIusqDCQWlNwxLz8w7meO0OGiPUi1wB7RTVoS71bLLSd+3GoLFVaaR4u1mfYggV3W2ync=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKibD/noZkEg08X86jbLAcAFksy9p8jR5SlJpSrhes/AHPoe0b
	L26JygWrnXDC5SLXdIAiRM6laoGPuAAcFUQrZu7pifHnbbAOLCTPJWZr
X-Gm-Gg: ASbGncuGWxAVXqTKn0fTt5Zv3OZ1TpNHsybjEgktPZ8rA67g0HvArddX1hpvWbLUjtP
	5MjSxZcihnE90dXZzzQAv6CkakWNnd0kBv3NKrvpxSNAoFnAlVjQ5pXWJhPnFZ/riOLRdVq/K4Q
	tDd/Tf1bWJtHxD8iUxMY9nFGDTMiKCqDpEsf3vsZlCY1VvWQt82z/QMP7yj1PengHSt+mW9CdY2
	XnRnRnpS8mAF6jfIHbva+hX5rLGNQEI3os5ekHc5jSG2ubKuNWupHc984Zkqf/UzpWS/X44jLjS
	QnvLnsq7IIMb5IAOxt9K+EJ69dPp/sCrdHiKzwdqIJ6zpDlNsyVNEwfLj3TM5+iSO8CsE+YE0zl
	Uc6WibFAhoE025pb5yG9rnx1iTST6/2xa6iBMKV9i5jN66uNajB9x7kUZJb+aQtFs0Q3+8nN7E8
	14WkfLUKaDMvAeZxgZQTJZetRXxKxqUjCmtb9ZmWHYR0W/uYKALlKGd/KQ/3vvaSqh1aXYcVDbA
	QWDzg==
X-Google-Smtp-Source: AGHT+IHuatsA0TU0EmQKM+VXdnR7vrkcGarcXxG+sRi8D6g2SyDjbiauw6mlCHoTUL7foxjJl83n3g==
X-Received: by 2002:a05:6000:400a:b0:405:ed47:b22b with SMTP id ffacd0b85a97d-42704d8352cmr9048390f8f.10.1760973419140;
        Mon, 20 Oct 2025 08:16:59 -0700 (PDT)
Received: from jernej-laptop.localnet (178-79-73-218.dynamic.telemach.net. [178.79.73.218])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427f00ce56csm15655444f8f.50.2025.10.20.08.16.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 08:16:58 -0700 (PDT)
From: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Chen-Yu Tsai <wens@kernel.org>, Jernej Skrabec <jernej@kernel.org>,
 Samuel Holland <samuel@sholland.org>, Chen-Yu Tsai <wens@kernel.org>
Cc: Lee Jones <lee@kernel.org>, Maxime Ripard <mripard@kernel.org>,
 linux-sunxi@lists.linux.dev, dri-devel@lists.freedesktop.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH resend] MAINTAINERS: Update Chen-Yu's email address
Date: Mon, 20 Oct 2025 17:16:57 +0200
Message-ID: <2801089.mvXUDI8C0e@jernej-laptop>
In-Reply-To: <20251020045603.2573544-1-wens@kernel.org>
References: <20251020045603.2573544-1-wens@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Dne ponedeljek, 20. oktober 2025 ob 06:56:02 Srednjeevropski poletni =C4=8D=
as je Chen-Yu Tsai napisal(a):
> The email forwarder I'm using has run into severe problems with Gmail
> lately. Switch over to my kernel.org address for kernel development.
>=20
> Signed-off-by: Chen-Yu Tsai <wens@kernel.org>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej



