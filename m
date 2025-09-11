Return-Path: <linux-kernel+bounces-812516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 496BFB53915
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 18:24:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40CD95A2297
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 16:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA67A35AAB9;
	Thu, 11 Sep 2025 16:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RpRkE62q"
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3D335A2B4
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 16:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757607772; cv=none; b=TqPfu1JdUagjYGvu5+usrUVq6850+s85S1meg/zv7kYv62N8ueRrMqv0BBga1C+R5xsv3nmtbPAw3K0XCeqEwCQKBghR8Rw7fUbII02dZW+rj/L+OtD6HGq4wyVLW52Vuwzz/yzghzKv5AVSwnVR6Aqju3FPdZGn3zGJKSPuqTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757607772; c=relaxed/simple;
	bh=Xu6ROB2iJBlOB3ife+XMQrejKQjN+28vFsRAOhZTeAQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Pdh2l2WPYAuQ4kaGmoH9+1SCloICyXpW50etZZiS+dVob5qUXPFOIOH27xKWrGLp4DrHRzxKJGbzqeKx+4yviRKAlgwTrw1649PHvghECt7aMEJIH9oaQ2CIkEZJtWkXdwX8/9Y39N645lYbhX3neij2fgI5IEq8SmaUYmVQXTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RpRkE62q; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-74a61973bedso869134a34.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 09:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757607768; x=1758212568; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Xu6ROB2iJBlOB3ife+XMQrejKQjN+28vFsRAOhZTeAQ=;
        b=RpRkE62qlrGIjXcRZs3oJfP13l4LU3O5HoicZLDK25K6AbfoWw0bSiXGVa0V7ZLT3G
         uDZ9bPK6GWcnxoNpuysiOXmohQbf25e7LdquLFEKrW2BSUnO733yAIlLFPpCuXnD6JAx
         NSQtIrh002IeEz4gl6otXdebV0kmA8U+pUSkphxx0sbIp/58oesnxU0Rh3MyTnmcKYXc
         WT9SqfhS5emcHMUyPnKMrWkXHhDHywgfc5t5rO5HOPB4pjdtzt9CSmDns5Elt6Gk/aJC
         Syj+vhbB37PtEORnhXQxmyH1C/RZ3mLAx345eXSVRWds+KUYT1msMSiOhGpxZOQOVAFu
         XS2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757607768; x=1758212568;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Xu6ROB2iJBlOB3ife+XMQrejKQjN+28vFsRAOhZTeAQ=;
        b=FXUWUcNFsjhSlsKVjTPtJqNxRxru6Kvyq60q+LjJa3yjBkeVvqWQjdYmHPgFoZWo/Y
         pIXlqgusVzmNc2IcjEvhxz2ChFof1Yr+0IThKLS3TVcN8C+bOC5AFb2zEHoFVRDuQmMK
         ZI73JWjgzCNd1/WxdMgnTnnTf6cC+csFXEtSk2p2u0f5pNz5vvLyLGfeP7IxOoDeFtJ3
         daO8WU4E43qQKEP0UGUN6Q5YDJyU/sXhuMzhD9Qv5iHf+3nt1mU2Vw6gh+M6nmifDEVz
         YV6fEGoG175okeCN5NEc4qrHccmrKO2bRSs6wuIe0trJ/IXbM3PzAENpUG2dG1/WXcnW
         BZIA==
X-Gm-Message-State: AOJu0Yw5+mKrW2Wj/XXAbx+m/lAZBNRWZwsyOmeU0iFv4HZqTy72UYVa
	powlpVz/QZQXXS7go5sA8kDTa4TGPlZQeT2eE9z38SW5GaLl1mSxLzsx
X-Gm-Gg: ASbGnctd7ZdyoUEgTGsrC3Yy+mAS1e4IuL9FGHPE4hbLaNoZVKXye611w8fTDPXmgfU
	5w9YdTthVcX4AqXMHOQ+7PjQVeYG8AobPSEMnoZADrrQn3YnOrldPm706l6I5dRpCayV+QAeXV0
	F35Vwfww64LiUQxZMEtkr1kY5/V4yQ57AtjqXBqeof+zutyIBm70f9BjvKUP/xWL1Etg+i0j0xj
	oWRzXqI9TJd37acRR/c5nqgAVxY+Ar8fJdJRrq6qAMMAx6PwjJ0LGqyTAxG+tBTSg2pS0BTcd7j
	B5SxIFS51dwomNn7ea/UkziGxoK9RqEcc47CBBVDMPLhJt0IubQ9C+VfU+7e48c0FvJ8husgfOo
	r3ZsehefEE9AVoMyZzwBMfMA=
X-Google-Smtp-Source: AGHT+IECctlFaz868hU/I7B6dJmVIqWLueZda9+UPQrP1OylkzpYavqojCcaxjupK+bo6Clm7vigeg==
X-Received: by 2002:a05:6830:3c04:b0:745:5320:c4bd with SMTP id 46e09a7af769-753552d595amr14583a34.28.1757607767743;
        Thu, 11 Sep 2025 09:22:47 -0700 (PDT)
Received: from [10.5.0.2] ([185.189.25.35])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-621b7bf520esm144468eaf.7.2025.09.11.09.22.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 09:22:47 -0700 (PDT)
Message-ID: <a34a18e85fcaefe0e91bf5ac69806e113099d3d9.camel@gmail.com>
Subject: Re: [PATCH 0/2] spi: axi-spi-engine: improve version checks
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>, Michael Hennerich	
 <michael.hennerich@analog.com>, Nuno =?ISO-8859-1?Q?S=E1?=
 <nuno.sa@analog.com>,  Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Date: Thu, 11 Sep 2025 17:23:07 +0100
In-Reply-To: <20250815-spi-axi-spi-enigne-improve-version-checks-v1-0-13bde357d5b6@baylibre.com>
References: 
	<20250815-spi-axi-spi-enigne-improve-version-checks-v1-0-13bde357d5b6@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-08-15 at 12:40 -0500, David Lechner wrote:
> We have a pending major version bump for the axi-spi-engine so to
> prepare for that, improve the existing version checks for feature
> enablement.
>=20
> Unless Nuno knows something I don't, it should be fine for the header
> file patch to go through the SPI tree.
>=20
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
> David Lechner (2):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 include: adi-axi-common: add version check=
 function
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spi: axi-spi-engine: use adi_axi_pcore_ver=
_gteq()
>=20
> =C2=A0drivers/spi/spi-axi-spi-engine.c | 17 +++++++----------
> =C2=A0include/linux/adi-axi-common.h=C2=A0=C2=A0 | 21 +++++++++++++++++++=
++
> =C2=A02 files changed, 28 insertions(+), 10 deletions(-)
> ---
> base-commit: bbe4656eae2729b8ca87116defa19c568898d08f
> change-id: 20250815-spi-axi-spi-enigne-improve-version-checks-cdceedf356d=
6
>=20
> Best regards,

LGTM,

Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>

