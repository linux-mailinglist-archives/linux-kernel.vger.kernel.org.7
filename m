Return-Path: <linux-kernel+bounces-885852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DDD7EC340BE
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 07:27:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 596E64E1FAC
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 06:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63AAB2C08C4;
	Wed,  5 Nov 2025 06:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YctSue6G"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 489B72BEC34
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 06:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762324053; cv=none; b=QEXJxyr6fdRVRoV8rW3oYgriguYMe+ajWdtjUrV5eGGRDo65XSUi+H/0QOWJnIVg/NX3KBpjRP0+21y/zN2mB+N/sEG9u67nHcPB4K+BiwZNOtU+BUwLFDn9Sqm9aDy7rSfO6ALNNxipB0cu4wPOdCAO7I+idb9jFJzVBvtVk1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762324053; c=relaxed/simple;
	bh=M6FUQeUrV5rYIQp0llWDN3mc7Yy127273TKo86Q9E1o=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mPIfWmqz0WAXN020v1A3yHlr4tNhdfwmZzX1zK/C1y52gdhEti546Y2WVIZi65eWbvcWSYpDLimww0d+MuhtttjVhs81d2Z1lBh+OtT/5evn3Ba6m+bb8FPNOPBx/kNAV+vgg3VdlOtf9n/Gpg71bPAT+KJ88klmhHoKbfqg/Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YctSue6G; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-780fc3b181aso4525814b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 22:27:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762324052; x=1762928852; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qRgQgDQGc0CtCpQFbq1uegdY2ZYKmCrZ81QG9UF3aXw=;
        b=YctSue6GHuVbKwzerLpAKfKHFlDkM+OmFKklCH//rfpl1MnUJsO/n9dwzOig9S2Ix3
         UEw5hivpJUPDueR1c4IW3TsUbp0s4tIJXFMuIEerd3KWfWMJ3dFpsl+BGfO/5imiHMy4
         VtXaf6lPu0JDs4eoo/8WM0/4DCqBblakFobeKMPqyzXlUq5Hzf4B15cb5Ru2Dm92wmR0
         IT0mBo/MvzAN3hfdCjKe4WMcHtLatmsVN00+krMgVcrQdoM5DT55brHOaFlJA8hcFG1S
         Sx9jog7Ho3T9Y5LesfC5lCfP1l8+6/iE7vFHNstIk8EmIiud0XeDxxiiIqMLa4j1WwW/
         b8Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762324052; x=1762928852;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qRgQgDQGc0CtCpQFbq1uegdY2ZYKmCrZ81QG9UF3aXw=;
        b=AQfzCMgvEhpfJu1UMv91ycAv1XEturUvGEmUrpIHTGYfqaXXgcc0eZ4pgYOcEppXY2
         IwvNRqA+DxmamPzRjtw+dMnPsl6GUwPiynchtrwN2u9Y/KZDssp9qjRifovPvmU4wU7V
         3R7FqXcDb6frL7ZVAFySYYPTNCKnlrZLdWFRAPz1wH2gy0sWeX9+ZXH8sHGm8z8foToO
         be6VwVB0lqLjwWB3sG6F5Zkvdd4DGoy9TIlZcv4/r+JOjFYox/NOikb4bFRijtfx5lz2
         EirtNB8saAC1Ris7M9GbBxq3nbtA8togqF11H/CJ35VwQQh1IqpC7TAif8kSbiYudzWo
         ZEyg==
X-Forwarded-Encrypted: i=1; AJvYcCWkQ3/V46U7/g0Sc6TJ3wvTXikPXIbVahyxIN2HmdbJsTKkSW//MWPfTKPkhqu/WsgafgfOKRi0h3QGx6A=@vger.kernel.org
X-Gm-Message-State: AOJu0YziNFNADYNXLbBJnaQNrb2oTToHibmmf9orUPJx63VmIG8TyCII
	tl3Eyvo2EXZiR/IJ7eeISxGbGyuL3sfGwzfT8n6yCaqL7f+HiBlXfFqp
X-Gm-Gg: ASbGnctAkE7ZerZzACSMuhyXtgGDS3t+wR5kd/OIUDGC259hSB3DleDQnb2r2hpVXS2
	56cLccuK2z9l6mcHA+FkUQeul4/8eWPQSrKtF3mN1iC/SnPa5sXZeqZ/r2+WmHAh5v+7SGy20Mh
	B6LyAl1Gxj8grNG8Eps55RT6dJaIuwwg3nFr5fEfKQZs13asEoSSB7kBEQVDceRzT5lDSS2z/0W
	fEh0qrQcqpxL44bzNBnSK0n7tygR3RYLgFKDcja1xUkHPkkToVm/hICNt4JWLQOVLmQDsdX++fT
	Oh5K9V20IYPVPmMEqZ+KWa6+JkWVnGG9Fk9yS3FH1vsgIFrviw0Q8ZrIGxuwj9WPZcSFrpBjr+y
	qsZNWVXhdGcbGq3gkuEHgvkwE3fr2sgYMkUVAuhd1cQPs7E372LVh3za9S+UpO3f58oiF172tEF
	VLMsoujNEn/mRpskE0M62hFlvYWwiCx+eVhouQ3Cap8MuaxixN
X-Google-Smtp-Source: AGHT+IH0CHanNbujuWYsueCqQMvQb7Pe6lyE4kMBe2/tOk0WkpZ70b1GaoCWJdrL37L5RenwOdPqcg==
X-Received: by 2002:a05:6a00:2382:b0:781:1b5a:95b2 with SMTP id d2e1a72fcca58-7ae1f9856c7mr2725237b3a.28.1762324051551;
        Tue, 04 Nov 2025 22:27:31 -0800 (PST)
Received: from ?IPv6:2401:4900:88f4:f6c4:1b8d:9d63:3da2:d477? ([2401:4900:88f4:f6c4:1b8d:9d63:3da2:d477])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ae9c8e19bfsm669795b3a.65.2025.11.04.22.27.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 22:27:31 -0800 (PST)
Message-ID: <5bcc00da02d4f5e44a8fabcde406402ca31f0491.camel@gmail.com>
Subject: Re: [PATCH RESEND v3] checkpatch: add uninitialized pointer with
 __free attribute check
From: ally heev <allyheev@gmail.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Dwaipayan Ray <dwaipayanray1@gmail.com>, Lukas Bulwahn	
 <lukas.bulwahn@gmail.com>, Joe Perches <joe@perches.com>, Jonathan Corbet	
 <corbet@lwn.net>, Andy Whitcroft <apw@canonical.com>,
 workflows@vger.kernel.org, 	linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Dan Carpenter	 <dan.carpenter@linaro.org>,
 David Hunter <david.hunter.linux@gmail.com>,  Shuah Khan
 <skhan@linuxfoundation.org>, Viresh Kumar <vireshk@kernel.org>, Nishanth
 Menon <nm@ti.com>,  Stephen Boyd <sboyd@kernel.org>, linux-pm
 <linux-pm@vger.kernel.org>, dan.j.williams@intel.com
Date: Wed, 05 Nov 2025 11:57:23 +0530
In-Reply-To: <CAMuHMdV+12MoAGNHC9kf==Bt0cLuJ39Fs+W61DN67sE_p-u=og@mail.gmail.com>
References: 
	<20251104-aheev-checkpatch-uninitialized-free-v3-1-d94ccef4917a@gmail.com>
	 <CAMuHMdV+12MoAGNHC9kf==Bt0cLuJ39Fs+W61DN67sE_p-u=og@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1-1+deb13u1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-11-04 at 14:28 +0100, Geert Uytterhoeven wrote:
> Hi Ally,
>=20
> On Tue, 4 Nov 2025 at 10:58, Ally Heev <allyheev@gmail.com> wrote:
> > uninitialized pointers with __free attribute can cause undefined
> > behaviour as the memory allocated to the pointer is freed
> > automatically when the pointer goes out of scope.
> > add check in checkpatch to detect such issues
> >=20
> > Suggested-by: Dan Carpenter <dan.carpenter@linaro.org>
> > Link: https://lore.kernel.org/all/8a4c0b43-cf63-400d-b33d-d9c447b7e0b9@=
suswa.mountain/
> > Acked-by: Dan Williams <dan.j.williams@intel.com>
> > Signed-off-by: Ally Heev <allyheev@gmail.com>
>=20
> Thanks for your patch!
>=20
> > --- a/Documentation/dev-tools/checkpatch.rst
> > +++ b/Documentation/dev-tools/checkpatch.rst
> > @@ -1009,6 +1009,11 @@ Functions and Variables
> >=20
> >        return bar;
> >=20
> > +  **UNINITIALIZED_PTR_WITH_FREE**
> > +    Pointers with __free attribute should be initialized. Not doing so
> > +    may lead to undefined behavior as the memory allocated (garbage,
> > +    in case not initialized) to the pointer is freed automatically
> > +    when the pointer goes out of scope.
>=20
> I think this is misleading, and can be improved: if the pointer is
> uninitialized, no memory was allocated?

yeah right. Will update in next version

Regards,
Ally


