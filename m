Return-Path: <linux-kernel+bounces-854822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CDDCABDF7AA
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 17:50:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 64CFC4FF6B1
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 15:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9114F330D41;
	Wed, 15 Oct 2025 15:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="jsDJblCZ"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A5FB30C363
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 15:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760543372; cv=none; b=QqCIKkeoglDt8cVXh59ova6RHMYdTINPGNeZYnysBxp6yvdS2Nwb0rMc6iT7gwAN/p00j8OLa2Zz1tvE7UBuF4Afi5YWLSS5fnupJ25CFFfL+mDPiucOewhnYdo0CZeEgG3sy9IhgtVY8PqE1CKIutNY8ECVcjJ9QvdjXILeoOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760543372; c=relaxed/simple;
	bh=nvq9xBefH03JXdQMqIE12FVgBtG0T1sD1lw8rRTtYnE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gZZyLk3gAEl7lXECFOKpDwU1aDr3m/Y4OfpX8dCw+/muUvZHNkRfyqhmiSCnxKHYPV30UdQaG9/PknaWVjl/yuqpITkPqVMlWeb+FvaZlpwNz0xHYXlD2Sxr2wnrT7WwgNOYw74QHNfNCRSelxjXu+AukZ6jdkaDIueW94Uqtco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=jsDJblCZ; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 4A97740E016E;
	Wed, 15 Oct 2025 15:49:28 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id mMEpHj1_WwcJ; Wed, 15 Oct 2025 15:49:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1760543363; bh=ky0ptVsEtlR8ayqd1hVyH4+Uu0fakQE2sbFkoDvJ7vA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jsDJblCZeHZhbOaw40gnPmVPMSTJ63uvCgLOl1kau7ImlF4oeI5L7btCZVu0rdO1a
	 RCVo21DezD+ycVVn8tpvAE8ehA7Fgx7sWLRjA7pJvTZgyw537gV8w8vGr+71LxDyHK
	 Q/0OSp2FCjVoNdM/mDlGVneP7CNpYUCVGPK2tj2qhVDaThiy4xlyqpKPXg3OW3OlPG
	 pje3lgfJek7IlIudCAKvQ4grZR+iKAAsUmbxVqSFqhF2pgOqmuKCNtydMh9OvK1Hrx
	 ffCm/OTIpxeoxewA6eYlkWHzEjaHWuorKWK6RFFsIGCP9S4F3T47EdRXMoWOxxTRqy
	 uER5R5M0QtO3Bne6gUYtLbXxm1oJTHupqZ6MgM8+T/1dLKCEuz9G+fJOJ31fe09UW1
	 DSr4Rlnbw3bjty9tR7je7OvQc1t+TGAZ3Q0WAPLvYEeMZ+lOQXHG68yrXMrS/TuvWr
	 nKHA3wOsBNk5PujucvJ0aw0oqowgG3L25sTylX2stteBa/9xsgxn6d6JsYj5v9tBMo
	 3nGNDO2pTtKlOmH3doxQrte8VWEwUppUzMPwUe/HBdzVfHWJ+KPGPRCTwBY8t8udAZ
	 fBkFJckzU5+gYQQW0Es5xEfeKrbRfLE5rRwXDzFFHeEui+p6J1xO/AnadmI06ae6TK
	 XM7BCYbpnfOoiYDbOYVVHMjg=
Received: from zn.tnic (p5de8ed27.dip0.t-ipconnect.de [93.232.237.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 5864440E019B;
	Wed, 15 Oct 2025 15:49:17 +0000 (UTC)
Date: Wed, 15 Oct 2025 17:49:11 +0200
From: Borislav Petkov <bp@alien8.de>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Xin Li <xin@zytor.com>, Borislav Petkov <bp@kernel.org>,
	Xin Li <xin3.li@intel.com>, X86 ML <x86@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/cpufeatures: Correct LKGS feature flag description
Message-ID: <20251015154911.GCaO_Cd0XNyE8bi5Db@fat_crate.local>
References: <20251015103548.10194-1-bp@kernel.org>
 <2dd4dbee-dc7d-4118-be6d-94bd6d0d5030@zytor.com>
 <329BCA65-5152-4892-AFEA-DF72DCCE80B6@zytor.com>
 <b632fc82-bef4-456b-ba62-939bda5a4361@zytor.com>
 <B72756BE-F15B-46D6-B44E-2FBC79E837C3@zytor.com>
 <530c3c1a-5fab-4798-830b-1fe0e8522bc9@zytor.com>
 <9B0843ED-5207-4A42-A95B-1DB5314DE747@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9B0843ED-5207-4A42-A95B-1DB5314DE747@zytor.com>

On Wed, Oct 15, 2025 at 08:44:55AM -0700, H. Peter Anvin wrote:
> >> Except that that is also wrong, because that's not all of what the instruction does. "Load user space GS" is really what it does, despite the initiate historical naming.
> >> 
> >
> >Do you mean the load of GS attributes by LKGS is still missing?
> 
> Yes. It's really a modified MOV GS,... instruction that loads the base, limit, selector, and attributes; it just loads the base into a different place.

Ok, "Load user space GS base" it is. Considering how you can't load any other
GS.base due to it GPing for CPL > 0.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

