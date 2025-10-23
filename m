Return-Path: <linux-kernel+bounces-867794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76982C0382B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 23:19:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F0E619A6CE2
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 21:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9D01246798;
	Thu, 23 Oct 2025 21:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VjqIvMH6"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C2FF1DB375
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 21:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761254381; cv=none; b=am+q4eFOzXZIq/w83n0NbaBf1HE+VzyVddlgII9yhrAGGtEcHsYNkdsuDTsOhsjug8kV0EWKiR2WeAx7RsImpisACyqF77IN/L/Sc3fV0wOZwDk5LkRzn4uZHWO1MlGw7N6bt6vOkHR7mGf9sMr3FoTUSGhsf5qWBrNKrKPFCfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761254381; c=relaxed/simple;
	bh=Ei9tWnP6+7R+pnEA92XXsitmlozCSw49trfMXT8LTVk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jRUtz6da4dJo3qbGRnpSHXfiPZNw6fyWwP2cJp8X5gOwP/o7vChiz6N11oYpjsbjPUtj3qC12rOzm4NgR+4rLB1UVC5UQvckC0ifgKOBdH2TFN9MSPCDeikPc3eXvkcYhhm6eql+LyY/bBOZv547OVXtDvzULPcEz4c57o3poqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VjqIvMH6; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b6d53684cfdso304248866b.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 14:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761254378; x=1761859178; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ei9tWnP6+7R+pnEA92XXsitmlozCSw49trfMXT8LTVk=;
        b=VjqIvMH6EV5ydfWgtn/qIAFbrCsx5duAPkWliqBfVrOZcHVYpDdXDPS1nkbDOdnEcT
         EOJHvqyDUpyrRJo3ckLvzjrecb2tLw8VMymPGjibfeobz1uj+fszCjoj1NNve0Hjy/Bw
         XVvVTlifi5oEXnVTo7KzJS1wNdvPizUxyN4YKtGWXLCdECDOCukCxmFr2S1kZcy4CWS4
         fl8eEoGd/VgvwfAyP2irsq4+TTLQ97+GABnTYfRwuenCMQTZotSA6c/DuVxePW/oHyI6
         MRImOjxpM3Ih/I1OGS4Dc2LbxZ6YLcBSz/447vrU35QcK3Yf/JXVOTi/kI/1QGVbOIQK
         SDVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761254378; x=1761859178;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ei9tWnP6+7R+pnEA92XXsitmlozCSw49trfMXT8LTVk=;
        b=VecFGFL/orw2sT8IdGTR+X0zYCebuuTzPX0aKxTekCXTARBrDMQL0ISU0JzTtbBOx6
         k9i4CQDhiSffRT4D3agPVYGryVgqVS1q8NjGICyfd3D/TCJL1jIJ4Q9J6mCBsgTTHZnp
         Rb1bJ4WkInm5wGkM/PJp281YQcptDDE4TUmczQ3oVXzkxJtSnrT7lN6uBA2mYLkNhRAQ
         nzyH6jfxjWLJ9i3VtwqwRsfCZSy7yz8SOu66/76NmQADenJLCy9z8FE0f4PtIlqa6id3
         1QzBdP0S/WWdBZmBAo9ay3jkH/OYSldJP8vF92kKEGyOlwqjgQwsi5VEe7WZsH3txUCq
         1qbg==
X-Forwarded-Encrypted: i=1; AJvYcCU1fXexFExA+jJMSPBnQYYxogFzJ6vCATy82dkSMxFxU4gZczQ+kLGJOyeHbazvb0ha1TEuWc/ylWUFa9Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxokIsn96fnayWA32bCIkEIvMPJaFMPf2QcSaJOVkId8NrThkTk
	i5o3s/afwP4RfOnvVNeGOpiA0gvGS8DObQcSJvHLmd5k1Vi1wFGnozEg
X-Gm-Gg: ASbGncvQOY3091P1Ck37b75XqVMWd+GLIYONw2vJ5K5zL8kEUEeZhgAeS/ycUjW1Uu7
	xpM3TOL6DLW6rmeCa6QNC6NwGKRszctGuxLhOUNNrW9/g7VA1/1IvhbgK7heX7eDI4qvTOhHkbR
	ixaP7MPxccWfVg+4QVKZ72iapkTF2qnlpTK+V1aT04ImrU5Agg4rm3rIr2ckoG1CzWf+I3NqqXm
	n4F++GNECEfW25BLKGPiYXFrn8nYPTlM1o7g3EUuN0NtDdJsWAqUUcjYd1tLrGCK8VtuRF4vBsN
	K7ofjdCozZFzSUszhhe+iZGvul5NmREzreodL+Pq/dkMiQXmhweIoPk4w/fqd8vJsx8k6EpxPXX
	YofrTiMuz0Bd0lXjZ66PgGBaFPAx9EYVAe+rkJl1fZdaVNbnGL59E4XcKYPvZTDv8cAxOyJoZmg
	NjPfZnLzvh8kIlLU9kkx9157ako3OWdydm4w6osBWXRYbFkUlbqBL1XGLx
X-Google-Smtp-Source: AGHT+IH0ilIhNZdTBWk7XhboQCM74tx7jK8m/eLziXPEBEYUaJoG0DUF30XGDfE2ZBdmNNzQKYsHEQ==
X-Received: by 2002:a17:907:9810:b0:b6d:6b56:bd7d with SMTP id a640c23a62f3a-b6d6b56c15cmr55871566b.16.1761254377896;
        Thu, 23 Oct 2025 14:19:37 -0700 (PDT)
Received: from 0.1.2.1.2.0.a.2.dynamic.cust.swisscom.net ([2a02:1210:8642:2b00:82ee:73ff:feb8:99e3])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d5144f786sm308476866b.59.2025.10.23.14.19.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 14:19:37 -0700 (PDT)
Message-ID: <d0af71bf7db6743dfcd0c53c2eacd32c56fa5b6e.camel@gmail.com>
Subject: Re: [PATCH v2 3/3] riscv: dts: sophgo: Add USB support for cv18xx
From: Alexander Sverdlin <alexander.sverdlin@gmail.com>
To: Longbin Li <looong.bin@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski	 <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Chen Wang	 <unicorn_wang@outlook.com>, Inochi Amaoto
 <inochiama@gmail.com>, Paul Walmsley	 <pjw@kernel.org>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou	 <aou@eecs.berkeley.edu>, Alexandre Ghiti
 <alex@ghiti.fr>, Thomas Bonnefille	 <thomas.bonnefille@bootlin.com>, Ze
 Huang <huangze@whut.edu.cn>
Cc: devicetree@vger.kernel.org, sophgo@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Date: Thu, 23 Oct 2025 23:19:37 +0200
In-Reply-To: <20251020083838.67522-4-looong.bin@gmail.com>
References: <20251020083838.67522-1-looong.bin@gmail.com>
	 <20251020083838.67522-4-looong.bin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.0 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Longbin,

On Mon, 2025-10-20 at 16:38 +0800, Longbin Li wrote:
> Add USB controller node for cv18xx and enable it for Huashan Pi, milkv-du=
o.
>=20
> Co-authored-by: Inochi Amaoto <inochiama@gmail.com>
> Signed-off-by: Longbin Li <looong.bin@gmail.com>

Successfully tested in host mode on Milk-V Duo Module 01 EVB:

Tested-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
(please don't forget to take this tag into your v4 if it still will apply)

> ---
> =C2=A0arch/riscv/boot/dts/sophgo/cv1800b-milkv-duo.dts |=C2=A0 5 +++++
> =C2=A0arch/riscv/boot/dts/sophgo/cv180x.dtsi=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 16 ++++++++++++++++
> =C2=A0.../riscv/boot/dts/sophgo/cv1812h-huashan-pi.dts |=C2=A0 5 +++++
> =C2=A0.../boot/dts/sophgo/sg2002-licheerv-nano-b.dts=C2=A0=C2=A0 |=C2=A0 =
5 +++++
> =C2=A04 files changed, 31 insertions(+)

--=20
Alexander Sverdlin.

