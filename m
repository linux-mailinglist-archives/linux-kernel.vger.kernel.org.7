Return-Path: <linux-kernel+bounces-878886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 483F2C21AF6
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 19:09:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E145D1A620CB
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 18:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5984624111D;
	Thu, 30 Oct 2025 18:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F+BayPTU"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BFB41DB127
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 18:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761847535; cv=none; b=EpQxGjGsHf98S5WWtwpsz8K4OHeZZDrLAdiLagVn30k9VAvuezrBAiATVJY045o3ljtnKGPUiUPhJF50P0gw4D7hvIK78o13I7EGSNqPvMA8sUqghVZMLKWCbysDb0R+x8oYFwRdDxobRkKyBXGm3zkd0/iMZD9wZtoIUkwlsSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761847535; c=relaxed/simple;
	bh=ffUErFjwH6FPsyyAXYKD8BwCvRk0j0ovrU1IvwXLog8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RV27kfWt4avRq4gYzDoIdaNvY3CbQRkVIcmFZf4upqE7SyvusXHdbiDP4wFthaQUYNTStykpB4NkIqHCpGCQVZmhpFIaIilDG/9g8OH/5zBKJOkwsbKW8DBHAMPPkPjGVi0nUcEEkX2muq+bcw88Omk2qGYRckiYPBm9roj70Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F+BayPTU; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b7042e50899so129533866b.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 11:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761847532; x=1762452332; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ffUErFjwH6FPsyyAXYKD8BwCvRk0j0ovrU1IvwXLog8=;
        b=F+BayPTU1Q6Cpm5ENh6iPONnAUCGG8+52U3h7aSx4rQRSMlUT9V8aUhem2lI3aGjO3
         TKkTX0wuI8t5bjae93QVjUJOrh/PF7U6/8LeN3b3piaSZFZZAnsQcVwbRfyN3Pm9V8TP
         U/WS+FM/5eoaE3OuEuSEo0uFShC5xEGkeKzf0ngouG+KVvrqnCbRb53h5TD0KabdEHgI
         2Dn0uQrZecIQmGLCmUxYGKJ27phFnhFSLWVbdTxViUjuUFEziTNsCko35mSaCYs2MDZV
         J6F3CsLRGiRt57M4Oc0ecxNYzNlAq+6vDwAvc/gtP7jQH2mTxvRtKzecpVrMiBblPde1
         KXmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761847532; x=1762452332;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ffUErFjwH6FPsyyAXYKD8BwCvRk0j0ovrU1IvwXLog8=;
        b=Co2kX8VwwLyQz78cT5+991PyLHr01/C9A/Yis0lTavTUfQ3HCvgBRsPGUy3V+LeLiy
         P0p30Q3x63eVw0zghqAz7Dpx0zExUnf2e0kosVoS3dbDLaopjxViWtzz5nBnuiJFKjAl
         XNFdJB4suv/4Mxcx1KaTQleWiV7nRHQLo4sBOmtWUK7vkkFacv67i6UzNhOscODJU5uI
         WMYMVKr/iIHqbcOPpAwlE63BfpHLZVBK9NhDbrgrZKBdrjrsBpaowYCgySCAJvuL0zTC
         KN0bq4rfW+xGXWJkH4HcVAWwvb78hCWgh4JouUlAwxdMGj/l1pQIqcnU06MqjwfXHtJU
         0uAg==
X-Forwarded-Encrypted: i=1; AJvYcCXsPswHoDtmi4Iik7eT2oxOAxpCBmVGLew3EpK4zj1CU26QMe7hgz8FwCNxayXyFyXnL6g9mOCyLhbq1oQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjrL3gfWLyJjciJCPrT4f6/iMcUHL245UbopncCkpAc/YRMCEv
	k4izz6igtIJWqtgqL0PhfMhIO4hKQpAMCyIKm75zR+haPwRX9tIyut1s
X-Gm-Gg: ASbGnctyTRttZ2SG4t+i2oCh+wRRM0z7svobkcaqUCnDN80tBu71LL0QGMd06A1g5nV
	vWA4PaTL4b5oMmmEouyL7OTCMsub3YV0MgDucuPicRYSB/slmVzS2Gw2RCuCS9e5rKAo4RlYFlG
	vhWZBj6DVEAla5oXNf9qf++/qPbnzBEBR2PEspw1+V6mGRyklSFI+LdpZvzneTWwxGTpAlT3y+G
	0MvYvuvPHPSwU82YT+Fl+zCoqyTnicCtSK62qXItEvr+DaPiV3VAIxZCp+0YgpjnTAeEtfFal+T
	pO4ZX5oycAh+K1Ia1rD+3smd17J5Pbwd4a60jLGvjn913JZgbf/xt7YJeaMknYNJJ/Q4pJuPPjn
	ZvjFZvUPdOGpQI7HFNH582qcdJMO86A8EoxZl2nMRnX6BqJOdST4WiwUB9CI70xMNntFMdkruBC
	SEWLE4xC2Ek5OjLYRGFf8wMAX3cRGkoRnISY5FSeJ2ylfJ5KqaBvSJHYSJFDvlj6U2Cw2FsOCR6
	DcfH1v1J1mxG3h1s+OqxRPszZZfSyJWtFWRj/fJmSL1Pdk9+U4JCPw=
X-Google-Smtp-Source: AGHT+IGJV/I1/C7aO/ht8j1BD1EQXUXgawrmeYdDSw5EX8PS0SBYhLW9fl4h/IWLZ5+YHnJQFCdfnw==
X-Received: by 2002:a17:907:94c5:b0:b04:2533:e8dd with SMTP id a640c23a62f3a-b7070870952mr42287966b.60.1761847531886;
        Thu, 30 Oct 2025 11:05:31 -0700 (PDT)
Received: from ?IPv6:2001:4c4e:24cb:f700:23e8:3719:bda9:8268? (20014C4E24CBF70023E83719BDA98268.dsl.pool.telekom.hu. [2001:4c4e:24cb:f700:23e8:3719:bda9:8268])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d853696a3sm1801921066b.27.2025.10.30.11.05.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 11:05:31 -0700 (PDT)
Message-ID: <32ed124e9d603cad950c4836c7a14a3ba8bc2068.camel@gmail.com>
Subject: Re: linux-next-20251029 - build error in amdgpu
From: Timur =?ISO-8859-1?Q?Krist=F3f?= <timur.kristof@gmail.com>
To: Valdis =?UTF-8?Q?Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>, Alex
 Deucher	 <alexander.deucher@amd.com>
Cc: Leo Li <sunpeng.li@amd.com>, David Airlie <airlied@gmail.com>, 
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Date: Thu, 30 Oct 2025 19:05:30 +0100
In-Reply-To: <1043551.1761844832@turing-police>
References: <1043551.1761844832@turing-police>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-10-30 at 13:20 -0400, Valdis Kl=C4=93tnieks wrote:
> Hit this error while building next-20251029 with W=3D1 and gcc (GCC)
> 15.2.1 20251022 (Red Hat 15.2.1-3

Hi,

Can you say how to reproduce that?
I use the same version of GCC but it hasn't given me any warning or
error for that patch.

Thanks & best regards,
Timur

>=20
> =C2=A0 CC [M]=C2=A0
> drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_stream_encoder.o
> drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_stream_encoder.c:157
> 1:69: error: positional initialization of field in 'struct' declared
> with 'designated_init' attribute [-Werror=3Ddesignated-init]
> =C2=A01571 | static const struct stream_encoder_funcs
> dce110_an_str_enc_funcs =3D {0};
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> ^
> drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_stream_encoder.c:157
> 1:69: note: (near initialization for 'dce110_an_str_enc_funcs')
> cc1: some warnings being treated as errors
>=20
> Caused by:
> commit deb072d241c906ae378bc88ff91dfcdc34ebe71a
> Author: Timur Krist?f <timur.kristof@gmail.com>
> Date:=C2=A0=C2=A0 Fri Sep 26 20:01:51 2025 +0200
>=20
> =C2=A0=C2=A0=C2=A0 drm/amd/display: Implement DCE analog stream encoders
>=20
>=20
> > > > > > > > >=20

