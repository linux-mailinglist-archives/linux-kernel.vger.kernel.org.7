Return-Path: <linux-kernel+bounces-855464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7389DBE1555
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 05:12:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2967407129
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 03:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 946211F1513;
	Thu, 16 Oct 2025 03:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="cRwPDWwK"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B33194137
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 03:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760584352; cv=none; b=kE0t1D6bLlBlWMfacCblXfNJ645SwXTiX8pZTBhwFdywGliDHnas/EV7EOSRbXmH8IV+EB17UUpzqF/w+BFXIur0na0x7yffm28iQP2ytxGgtUpKibMkTsXEFXoz6Z2djUBYdZhO0zOwNMki5eGI3GI0jq1Ex2uY0CC7NNVwK5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760584352; c=relaxed/simple;
	bh=Gpr6pMpqmS7OWb9GJ+hOB+VkU40x5ZrX809MGULl4nY=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=U4HUSxl1wAGIANRoshhEo4qtl4CN/qUncJ9kkmXZXA7Vn71XEdGIFGjRFl465lTVgYtnZZ6qcKaDAWHESkebLR0RiLHl6EHvAy8todwhJcSHMp6UmONBd5Sj+WiRVI2STLyMiVDrpUjblh/5dqqYgGOcmiNVzeMjDGqIohQ+SAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=cRwPDWwK; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from ehlo.thunderbird.net (c-76-133-66-138.hsd1.ca.comcast.net [76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 59G3C9ZO2798968
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Wed, 15 Oct 2025 20:12:10 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 59G3C9ZO2798968
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025092201; t=1760584330;
	bh=Gpr6pMpqmS7OWb9GJ+hOB+VkU40x5ZrX809MGULl4nY=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=cRwPDWwK8J6lV0hGDPsJDidHXH9Y0YXu9Srb58bOctxF2mOLXqBQ0S5p3dpWmTeYK
	 LPvfmgFH2kCfxvihPM4shYZ9IF7Q3Tq3M96bEBAoOnGC4VXJ/z3NKtsK+F2HjpjD5X
	 UNrOrAwP/01PkPi+f58HzAYc1ewdNwWG5vyk7OoVMMsEBMk6HBU2F95vg2H7KaQsqB
	 T0Z2HjNk3sUAW9JJiX9I2mxQATqGRXm4FS0/6CkPaLxKxqAk0GuiJRZ6g8aX+Q/hcl
	 xDV7wndAEi31jr0hMnwwhbVyCSoHeYtGTI0T5S1pi/QcLRbzk5gUkIMT5KESS5Dn3f
	 wvsKlsL+EqPOA==
Date: Wed, 15 Oct 2025 20:12:08 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: Borislav Petkov <bp@alien8.de>
CC: Xin Li <xin@zytor.com>, Borislav Petkov <bp@kernel.org>,
        Xin Li <xin3.li@intel.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/cpufeatures: Correct LKGS feature flag description
User-Agent: K-9 Mail for Android
In-Reply-To: <20251015154911.GCaO_Cd0XNyE8bi5Db@fat_crate.local>
References: <20251015103548.10194-1-bp@kernel.org> <2dd4dbee-dc7d-4118-be6d-94bd6d0d5030@zytor.com> <329BCA65-5152-4892-AFEA-DF72DCCE80B6@zytor.com> <b632fc82-bef4-456b-ba62-939bda5a4361@zytor.com> <B72756BE-F15B-46D6-B44E-2FBC79E837C3@zytor.com> <530c3c1a-5fab-4798-830b-1fe0e8522bc9@zytor.com> <9B0843ED-5207-4A42-A95B-1DB5314DE747@zytor.com> <20251015154911.GCaO_Cd0XNyE8bi5Db@fat_crate.local>
Message-ID: <4CDD31CE-7040-4ADB-B3F1-E095E3C5BDF5@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On October 15, 2025 8:49:11 AM PDT, Borislav Petkov <bp@alien8=2Ede> wrote:
>On Wed, Oct 15, 2025 at 08:44:55AM -0700, H=2E Peter Anvin wrote:
>> >> Except that that is also wrong, because that's not all of what the i=
nstruction does=2E "Load user space GS" is really what it does, despite the=
 initiate historical naming=2E
>> >>=20
>> >
>> >Do you mean the load of GS attributes by LKGS is still missing?
>>=20
>> Yes=2E It's really a modified MOV GS,=2E=2E=2E instruction that loads t=
he base, limit, selector, and attributes; it just loads the base into a dif=
ferent place=2E
>
>Ok, "Load user space GS base" it is=2E Considering how you can't load any=
 other
>GS=2Ebase due to it GPing for CPL > 0=2E
>

No, "load user space GS=2E" It loads everything, not just the base=2E

