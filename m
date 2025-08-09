Return-Path: <linux-kernel+bounces-760971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02BADB1F25B
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 07:41:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC2A1560F54
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 05:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9852827814C;
	Sat,  9 Aug 2025 05:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="enbtsZOZ"
Received: from terminus.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E032777E2
	for <linux-kernel@vger.kernel.org>; Sat,  9 Aug 2025 05:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754718101; cv=none; b=RPIoa7WDD4qnmQE9Ibt1novmUs/DRDAO0kEfVGXp1osmSiM36Zx364g4wEVfyL6rwdZ2YxLQyfsb7JBO7dkTCF+d5X3TMUHHTyEuSpbXYcZlzzkCm+42xHizDX3+edSl/9a6LZfWdNA8i8EmqQxI1Y6Ij2pO82MHjy0x+zSib4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754718101; c=relaxed/simple;
	bh=zVS+6jN1XQMX8SpxsVTR3vA1v6nRcUtoWHl8omQh2XI=;
	h=Date:From:To:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=Y0Koch3EfHJLR6rWNty9zokTXCdgklIfDlc6zCMBwL35pdUtQicQ+LRjsJmYZW7hTPNrjFuSVce1xhO4/c6qkQ8ctuoEJccsTcFidYNMKYAr3RDXIyYJSH/tvr4N7WsTm7jdIw56vyATMDZNS1YTcGKXZ+INKBUyqXJfV/DNSoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=enbtsZOZ; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] (c-76-133-66-138.hsd1.ca.comcast.net [76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 5795bs3Y910941
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Fri, 8 Aug 2025 22:37:55 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 5795bs3Y910941
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025072201; t=1754717876;
	bh=zVS+6jN1XQMX8SpxsVTR3vA1v6nRcUtoWHl8omQh2XI=;
	h=Date:From:To:Subject:In-Reply-To:References:From;
	b=enbtsZOZ8JluF/IW39Gsxo5EI5E2mpL7PW9okoUpTVsWeKxeB4xupakYJpeMNABbF
	 uqVh/3Kh4F0CgQpHb9yUFBVIsO87KrzX8gG6ArageHhJjvg8dZ5y2HFXyQ1Y09qjWv
	 nF7CBYDkidvTxK8rsuGL/dWDX1kXHRNW17XryTJkbx5rnqIC3vl16fn56xeku6oiMD
	 6EZhKMSs5IJfv5bMbm/pCP2cw0EgOIL8FvO0N1V01y5SoO2+aChhaWOd23HcJ/6TXY
	 4Ow8j3PXw4ghb+7SBj2Q2HRMTgjDJMzOAJgvehaiUsTcAbQmEHOHEa2jApgxP1N+8l
	 x8DGHoChBJxNw==
Date: Fri, 08 Aug 2025 22:37:53 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: andreasx0 <andreasx0@protonmail.com>,
        "CC:  Thomas Gleixner" <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: =?US-ASCII?Q?Re=3A_=5BBUG=5D_x86=5F64=3A_build_?=
 =?US-ASCII?Q?failure_in_switch=5Ffpu=28=29_?=
 =?US-ASCII?Q?due_to_missing_x86=5Ftask=5F?=
 =?US-ASCII?Q?fpu=28=29_declaration_=28v6=2E16=29?=
User-Agent: K-9 Mail for Android
In-Reply-To: <sKlZWc4ZTdYjcxIz044xyWaiwKFcUX0hvTA1IJ_QTzQ3sXhTuLidgIZS2d51P-t1TQHt3F4eXLfXLGbXpisbBqpsZxCsWhpbWUoNe4ESC-o=@protonmail.com>
References: <sKlZWc4ZTdYjcxIz044xyWaiwKFcUX0hvTA1IJ_QTzQ3sXhTuLidgIZS2d51P-t1TQHt3F4eXLfXLGbXpisbBqpsZxCsWhpbWUoNe4ESC-o=@protonmail.com>
Message-ID: <24FFA367-A571-4C61-9D09-C226CDD05E42@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On August 8, 2025 6:18:12 PM PDT, andreasx0 <andreasx0@protonmail=2Ecom> wr=
ote:
>Hello,
>When building Linux kernel v6=2E16 for x86_64, I encountered a build fail=
ure:
>
>=C2=A0 In file included from arch/x86/kernel/process_64=2Ec:46:
>=C2=A0 =2E/arch/x86/include/asm/fpu/sched=2Eh:37:39: error: implicit decl=
aration of function =E2=80=98x86_task_fpu=E2=80=99; did you mean =E2=80=98s=
et_task_cpu=E2=80=99? [-Wimplicit-function-declaration]
>=C2=A0 =C2=A0 =C2=A037 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 struct fpu *old_fpu =3D x86_task_fpu(old);
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 ^~~~~~~~~~~~
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 set_task_cpu
>=C2=A0 =2E/arch/x86/include/asm/fpu/sched=2Eh:37:39: error: initializatio=
n of =E2=80=98struct fpu *=E2=80=99 from =E2=80=98int=E2=80=99 makes pointe=
r from integer without a cast [-Wint-conversion]
>
>
>Thanks
What is your =2Econfig file?

