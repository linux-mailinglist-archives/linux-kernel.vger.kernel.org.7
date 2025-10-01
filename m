Return-Path: <linux-kernel+bounces-839469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14EB6BB1AD5
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 22:23:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3FE0189A15B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 20:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA1862FD1D7;
	Wed,  1 Oct 2025 20:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JHDsK5EQ"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD91F2EB841
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 20:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759350200; cv=none; b=VTyPL6ffytOnEboE1NatwJDdBSqrm5tx7BBZM3fAdgjVgCRB2f6Hh1f4ossMd6r/NRfT7SOvwAtp4qusmgMaKXNoPcpRWvSD0LNWG53LqT98loZBn+aDJ2wmhaGWoCRRLZrAJaEeGbVWkvc1pDIvIDQEtMjaGZ+ki6/sYZ6LsrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759350200; c=relaxed/simple;
	bh=sDgjk+ktzv45pAziz/W/rEGBe9ilvei4D3+TtKwEeiI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=icOrVWNc2CD6Ul0Idb5qe8B2KBz4CMXdTy/OrMpdEjQqaSk3HpjJU+7j5HbP7WkHtSFzOAMgzMsPvbNeGKXAs9w+ufaIKTKIP9cuuJIrUeoZwkyOEEyasvUqZ6juShfH8Q90kE1iLOXa1hxvU96tSzdU+Q22kQEhtquraxtL9t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JHDsK5EQ; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7811fa91774so327566b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 13:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759350198; x=1759954998; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sDgjk+ktzv45pAziz/W/rEGBe9ilvei4D3+TtKwEeiI=;
        b=JHDsK5EQA9BHU/k8SMTE81k07bDQYTd1EBvpaebK/gOi3/UEMH3D9fN2epj4eyHVpQ
         rHYPe5TeI91ZAyIi1fj06HInjed3SNKEOCECtaXs0Q1iGkMyZ1r8TVhpkOZZM70zo0Cr
         29Bn8dNCBUhYaBm2LW1enKIZLgMHnIg2t6qsH0HZfpy9bzZ0zXtdaA0R68Uk4r+4Wwg/
         n6UfTK8HJ9NEy2yIFsEsequfy4tUssjETMH4zVrG7vpptlO1fG95wyQovm9VFk8RJRIV
         0rHJgBH4RhbA4QY7EJEesrF/QV1LEnZUdNb54v1G6ymeqMg78KcsZYqF4+Vxxjdxe6Ae
         3BsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759350198; x=1759954998;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sDgjk+ktzv45pAziz/W/rEGBe9ilvei4D3+TtKwEeiI=;
        b=mxyjFxMMSGVJIWDlC8MQYgQaHsQ90pipgUmXZWgr/IFJdv2X14xIFdHUvU05j4tRaW
         jip7ZC/v1MjULpSIfRcOpUcJBsgJpczPIL45sYCIG2BgjNgiyYEJmutBmqzlFer8w361
         vbyTBrlfZsmJarCAMrfq/PK7myDwaMMJs10FsYySZArEUJMTdAqiosAd3Qf5JUT+f1MD
         UJ72wGF+ytuKqSlOp6QkhLyiLKaref9IBgWUkx1Yxd6/5ezbVVB9/QorYbMb9OGEWMx6
         AsxssyfC+8OmsF9wB+Ot2jrcDSpjkvZ26UfUfJRR2Dd4chPmFOT6/5TdA56VTRd8r6vc
         SsCg==
X-Forwarded-Encrypted: i=1; AJvYcCWT1a/WcJaOhUz/uaBMJnLZlOTNnqLJc89+X0saBOGqnGTgxXKEzZg2KPTNhXW6s4/YmlDa+p8nN6OFWSU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGVAPIMK0ii6ytjkRy8M4MTUvHbl7hDpZf02XpLhvfGH0XhyxT
	Sxwk9icLCVm0RkfIKNAWBBWge5qO/Ywu5He2dyjuzj3rSKadMDZ+6uaU
X-Gm-Gg: ASbGncsMyiPR+I/doFrWr2kEO8junaFqxqAP4bmGy2x9YWBtqiRWkDAHyHzFeSy0Ecu
	e/pGLnI1E4r50fCJDX3ocFivR5mVcVn1912a5Hw7ApwJ0OMnuuApmLidoPZ07clZddXRG88Z6yM
	ccLY/IW4mrcPSm1b46ARwYLxLjZeeW9iHA+NqgLPddB13QZ+rIBM1dVWtopSFHCwNDSe+7yYIDE
	Dz7Bf6kfesrafKmXwkZVZbELTJ5jfFtkZgwCNgJABm9kOOWKb5c/CpVgkRMBSy+9lEp0i4jZ5nb
	ojktzoVXpBhK5sskgTNT4IFVp7rQhH73eDX5GbcaVeHhypyRDLaSGUICF397cFWhWYam2NsB15K
	Lxsr99Mh5GzpjjNoZPA652lDebmvwwGSSIboXBl8jwBtnnyYuxfl4c1q7uIzKV6SKPdH01Ws=
X-Google-Smtp-Source: AGHT+IEzLJ6xMI4TZdMZ4T+zFjMdd8zd+FBTLRL34IcHix6v7TwCxHpmo0m7KR94VG++00tXP6UsNg==
X-Received: by 2002:a05:6a00:8d3:b0:776:138a:ec97 with SMTP id d2e1a72fcca58-78af4176ab3mr5284861b3a.28.1759350197746;
        Wed, 01 Oct 2025 13:23:17 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:1ed4:e17:bedc:abbb? ([2620:10d:c090:500::6:420a])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78b01f9dae7sm531831b3a.9.2025.10.01.13.23.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 13:23:17 -0700 (PDT)
Message-ID: <fbbeeee096dc14332c50b1086b2089f1b2f496d9.camel@gmail.com>
Subject: Re: [PATCH] selftests/bpf: Add -Wsign-compare C compilation flag
From: Eduard Zingerman <eddyz87@gmail.com>
To: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>, 
	andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@linux.dev, 	song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, 	kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, 	shuah@kernel.org, matttbe@kernel.org,
 martineau@kernel.org, geliang@kernel.org, 	davem@davemloft.net,
 kuba@kernel.org, hawk@kernel.org, linux@jordanrome.com, 
	ameryhung@gmail.com, toke@redhat.com, houtao1@huawei.com,
 emil@etsalapatis.com, 	yatsenko@meta.com, isolodrai@meta.com,
 a.s.protopopov@gmail.com, dxu@dxuuu.xyz, 	memxor@gmail.com,
 vmalik@redhat.com, bigeasy@linutronix.de, tj@kernel.org, 
	gregkh@linuxfoundation.org, paul@paul-moore.com,
 bboscaccy@linux.microsoft.com, 	James.Bottomley@HansenPartnership.com,
 mrpre@163.com, jakub@cloudflare.com
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
 mptcp@lists.linux.dev, 	linux-kernel-mentees@lists.linuxfoundation.org,
 skhan@linuxfoundation.org, 	david.hunter.linux@gmail.com
Date: Wed, 01 Oct 2025 13:23:13 -0700
In-Reply-To: <20250924162408.815137-1-mehdi.benhadjkhelifa@gmail.com>
References: <20250924162408.815137-1-mehdi.benhadjkhelifa@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-09-24 at 17:23 +0100, Mehdi Ben Hadj Khelifa wrote:
> -Change all the source files and the corresponding headers=20
> to having matching sign comparisons.
>=20
> Signed-off-by: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
> ---
> As suggested by the TODO, -Wsign-compare was added to the C compilation
> flags for the selftests/bpf/Makefile and all corresponding files in
> selftests and a single file under tools/lib/bpf/usdt.bpf.h have been
> carefully changed to account for correct sign comparisons either by
> explicit casting or changing the variable type.Only local variables
> and variables which are in limited scope have been changed in cases
> where it doesn't break the code.Other struct variables or global ones=20
> have left untouched to avoid other conflicts and opted to explicit=20
> casting in this case.This change will help avoid implicit type=20
> conversions and have predictable behavior.
>=20
> I have already compiled all bpf tests with no errors as well as the
> kernel and have ran all the selftests with no obvious side effects.
> I would like to know if it's more convinient to have all changes as
> a single patch like here or if it needs to be divided in some way=20
> and sent as a patch series.
>=20
> Best Regards,
> Mehdi Ben Hadj Khelifa
> ---

I don't understand why this change is necessary.
Have you found any bugs while doing this conversion?

[...]

