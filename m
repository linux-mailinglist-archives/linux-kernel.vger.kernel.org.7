Return-Path: <linux-kernel+bounces-852268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C14BBD88EC
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 11:49:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E59E234E197
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 09:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8ECD220686;
	Tue, 14 Oct 2025 09:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ClkgYJg3"
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 451D62D9492
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 09:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760435313; cv=none; b=spryI06pxTCMQGq+nnzrKLidcbNxGSyDd+fg7AaznS/2wfK4SYbdm8CnxU8r4se1pNgBRtnsd2A6DmqvOXtjyBHaJh2Cpiuoy8QWlZhCTpxpEVudjrsVnpf34sB9IzUV2uO/KVrpnic2OdT9E6bKA1NC1IucIMedlGB9NL87tbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760435313; c=relaxed/simple;
	bh=kHtxBRJjtARoemyv0wYK4lb2xYVXtiqIKZY9jw9d9PU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=I3o5yPxzQWEinBK7hsEgmpQ0y7zQyytOfCYgwjVNV+BXA2ga0gfQdlbZQ7mXc6JjvxjYW98M4LAh8TT9tLY7SX3CsXJ95kVEpb+c7daNUDAJCiOoWT3d1VgIYurRLII8cuOSflBUU7ZddQie7jQ6ZnOHQF4nz7C1CEgZopfd2wU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ClkgYJg3; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-8e261568020so948888241.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 02:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760435310; x=1761040110; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LG0ED4pWkkVj5n94lraCEC5DO5yZd4ntTF5w7MamzsU=;
        b=ClkgYJg3ZFFg/dqfrMmCuaIbGbomsnLKgHgxxwSFZsR7yXtwgtmGUoS+2XAMqDzDVv
         vLXfo7iY76PzIxEpm1iPMkDS21jCur0PYugttmX6/ngvGWGLqaOwIAAFdikhGSyMRx23
         r+XrXloDipTpfiI+JV48nbZCo1tfT+vQ0DoVkGeWS+nUL3RQlLvfFz7vCX42TvCrYskn
         6hq0+qhMWwMENx5F2hJ4GFU3ksYXhMuhQnn750VklgpMKdAGoKUDitPnBinOol2itdaJ
         UL4VUM1f+GByKDnR7ZWyh3NrqSFJcSttBhdLbJ+4OQkdEXj8L7mqAj90jCsH35iR6Ymb
         u9MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760435310; x=1761040110;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LG0ED4pWkkVj5n94lraCEC5DO5yZd4ntTF5w7MamzsU=;
        b=mVeZKHGz27SI6x5sb7smFE0nsc7IpP7Vbac9WUEf/oj3+cPnoRBadBDY9FEJKdDe4y
         w5+MCThOrexZaIBiIIVD09hmD3uPGFtzpvkX0m4Y5QK6ioIHeP2UjMX6xPv9qloV7PWO
         9jE9hGfJ3ccooaofRQtbvF7xxqrgKSA/YXpez79zu41g8E2RVzOxdxByc+GcFs+YMAlg
         On7ITAGq9+ArPPX89IQEUNcfdKimlzpiRSDAXe2DHDsfTqDfkmWjeRPNZc0cG9h+9bnK
         McbE5yHL2kHeuYKSSf23uO2OTjqfKUm/32FLPnv1YhF0DAC9tNcORvbzEDvBX+07mV+3
         zTgw==
X-Forwarded-Encrypted: i=1; AJvYcCXQGxXHHjwgrIOc++N3isEa77URzCBggrDPRILUpOtB4AWX1yZULKhbK80AWFyVoUbwnFRhPOTjOMEJhTs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/pHrSeIOmsCEVpJXu030t7kgUw+fThXYp3TS/cviWcwRZ+2gr
	JpS82Rd/8CPVRdIsp77+9/KJ88xUReeQrSN/qZZ6fS1k0Sxo6ELWZzx2
X-Gm-Gg: ASbGnctr6q+g7j2HE/3nIY3zeTno8AxxbcH/Vxh7qOqHV4/ex/kmt5z/UXvqhDAitlx
	gyESibphE2/EkBP7LzIE4f3jtw7LZq5fx3UyPAtR2RdV2T3EnzvdNvIZYZaZ7E1Ie21Wh2BV2hd
	5PPAkamhNmsabIQ3hnPJORVtDW1c+/uG648dOlxfGkGFTpP0Qr8x+WGSRWBl7d+nMlRAiiWNLuy
	7IjMOdOVjCWgKtLXBBcULu1ESHwh5VqhHG9h7mDsH9lsGtIGuppjA6901w0GjjE87HtlaIIxNRa
	EoLOm5gx6bUmq1P2t4dI0Kq/7ZmFI+1iZdzgnmEE6yfDifsGRnPHs/oCmLbmtj2RVhFjUsjg6oZ
	VN5gSSpYhuh9ubAiazWWHewfEkpnVoq4r57sgFe0Isu1S
X-Google-Smtp-Source: AGHT+IF6H47KZGz8Lq6nVOeRN/dL+wwxgitHPIZLOq8wuKUhsfrWL6NL4IjUjZ54gMcdy/8Rww7YmQ==
X-Received: by 2002:a05:6102:2acd:b0:5d5:fefc:9fd0 with SMTP id ada2fe7eead31-5d5fefca0d5mr4008750137.0.1760435310123;
        Tue, 14 Oct 2025 02:48:30 -0700 (PDT)
Received: from localhost ([2800:bf0:82:3d2:875c:6c76:e06b:3095])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-930bf6ce034sm3474678241.7.2025.10.14.02.48.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Oct 2025 02:48:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 14 Oct 2025 04:48:28 -0500
Message-Id: <DDHY8FVSX42E.1SG926NXKG2FL@gmail.com>
Subject: Re: [PATCH v2] platform/x86: alienware-wmi-wmax: Fix null pointer
 derefence in sleep handlers
From: "Kurt Borja" <kuurtb@gmail.com>
To: =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, "Hans de
 Goede" <hansg@kernel.org>, "Armin Wolf" <W_Armin@gmx.de>, "Kurt Borja"
 <kuurtb@gmail.com>
Cc: <platform-driver-x86@vger.kernel.org>, <Dell.Client.Kernel@dell.com>,
 <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>, "Gal Hammer"
 <galhammer@gmail.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20251013-sleep-fix-v2-1-1ad8bdb79585@gmail.com>
 <176036823039.2473.15648931584117338012.b4-ty@linux.intel.com>
In-Reply-To: <176036823039.2473.15648931584117338012.b4-ty@linux.intel.com>

On Mon Oct 13, 2025 at 10:10 AM -05, Ilpo J=C3=A4rvinen wrote:
> On Mon, 13 Oct 2025 00:26:26 -0500, Kurt Borja wrote:
>
>> Initialize `awcc` with empty quirks to avoid a null pointer dereference
>> in sleep handlers for devices without the AWCC interface.
>>=20
>> This also allows some code simplification in alienware_wmax_wmi_init().
>>=20
>>=20
>
>
> Thank you for your contribution, it has been applied to my local
> review-ilpo-fixes branch. Note it will show up in the public
> platform-drivers-x86/review-ilpo-fixes branch only once I've pushed my
> local branch there, which might take a while.
>
> The list of commits applied:
> [1/1] platform/x86: alienware-wmi-wmax: Fix null pointer derefence in sle=
ep handlers
>       commit: 5ae9382ac3c56d044ed065d0ba6d8c42139a8f98
>
> --
>  i.

Hi Ilpo,

Gal has just noticed this approach prevents the old driver interface
from loading, which is a huge regression.

Do you prefer to drop this commit or should I submit a revert?

Thank you for your patience!


--=20
 ~ Kurt


