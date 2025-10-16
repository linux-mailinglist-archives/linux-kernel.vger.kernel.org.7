Return-Path: <linux-kernel+bounces-856197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 47548BE3743
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 14:41:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 53C664FA674
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 12:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17C4832D45F;
	Thu, 16 Oct 2025 12:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="JeDFAWIy"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D002DECCB
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 12:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760618502; cv=none; b=uaCRqWFTTCdHu18yUWsxvyTmwAEqmfJM0YlvJUManZjvdMAnOmloOAZeB1oBSZrGqMno2hnPOlAFoAeBaX8WE5ucbmBj5qrr+oYbXcPgT7euDuSjiU1hr+yJw1u4b41mA8hGzaAzanUAXLjRLAdYU+ZZi6zPhhnCl7WWr5DTmYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760618502; c=relaxed/simple;
	bh=PfDRGPYm3GOftJkwHhaslN/Hdx8FoZy15oE2mprd2NA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mt3aGMkKUU5r17TnC/TVa8foi5+DAipKM3j7xr9Dw9uYGPxheKrG9G5cfXyx8cBE+BLcBL7d7UqN6U7YUOAN0xU04bptM8odsYIxy0HJnwziFZuUrTkMpxA1YMO9WV6DkmWUnggOqP6Wji5/CP5ldifidiqOV9X+vjf6mtHnKkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=JeDFAWIy; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 5E96B40E016E;
	Thu, 16 Oct 2025 12:41:35 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id ga4Y4jr_15NI; Thu, 16 Oct 2025 12:41:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1760618490; bh=fuej1Edvtyxr6SG6uYHpBMJhv3emGGMdAQmA+1btR8E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JeDFAWIyZb8QLX/tSimI9qtIc5hL8FKCmkupHdUOJ3v/LlteiRsXE3Af3PQheifQq
	 bgTpUDRsoA/1QbOIJRSsiv13ZDl2Iry6076pAvljCOx5ArH+8DDcOXHKD6SOuI6NSE
	 s4fdTy+SW+q0Auf3fUBfU95OaPbd0z0C9V4GFF2rNI76DtoZZBeJnlJH/XASo4KjVM
	 dCBJj7DWucMuk6YzHHESuICGWXSjI87S2MoVocESvQwKRV5NDEN7kswqrDgG+7hybx
	 sKUQsItzLgpuHkQkwePmi2HBjon2BrLTiImPFWxmnXsSBgsxd+quQUG1iYr8GO0k1W
	 jtIifDx3xC2AOT9tCK3S9d90vy4JtvHJyIrFJm3wQCJo0339KlGi5S/qpSZsC220bB
	 leJFcjgRmznIL08xEhb1Tjb7LZIX4n1YYGA12t3iTH93MIhSlqj7MHSD4fB9GxR5AN
	 YgHGMPZTWxHSbWp31upjfsjpSR2RtAyfyFm5Bba7lKuobp/NsR4i9bVJ/xp/NN59yw
	 815REnq26HQ7aSzdx6VtObEwxj/6elA9d7gv/NIyrTCLtDINOq6sMimE8Y0C5rxdl8
	 SnW2d1kdZ1t47h1UmrTblBOJNl9Ml24tCvvw+t43/yj2131Db3un/E+aEdsjyy1mAo
	 ooV5lTqFEWDcNBSSbYYDjuUg=
Received: from zn.tnic (pd9530da1.dip0.t-ipconnect.de [217.83.13.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id AF59740E00DE;
	Thu, 16 Oct 2025 12:41:24 +0000 (UTC)
Date: Thu, 16 Oct 2025 14:41:18 +0200
From: Borislav Petkov <bp@alien8.de>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Xin Li <xin@zytor.com>, Borislav Petkov <bp@kernel.org>,
	Xin Li <xin3.li@intel.com>, X86 ML <x86@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/cpufeatures: Correct LKGS feature flag description
Message-ID: <20251016124118.GAaPDn7nLmV2zNSlKo@fat_crate.local>
References: <20251015103548.10194-1-bp@kernel.org>
 <2dd4dbee-dc7d-4118-be6d-94bd6d0d5030@zytor.com>
 <329BCA65-5152-4892-AFEA-DF72DCCE80B6@zytor.com>
 <b632fc82-bef4-456b-ba62-939bda5a4361@zytor.com>
 <B72756BE-F15B-46D6-B44E-2FBC79E837C3@zytor.com>
 <530c3c1a-5fab-4798-830b-1fe0e8522bc9@zytor.com>
 <9B0843ED-5207-4A42-A95B-1DB5314DE747@zytor.com>
 <20251015154911.GCaO_Cd0XNyE8bi5Db@fat_crate.local>
 <4CDD31CE-7040-4ADB-B3F1-E095E3C5BDF5@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4CDD31CE-7040-4ADB-B3F1-E095E3C5BDF5@zytor.com>

On Wed, Oct 15, 2025 at 08:12:08PM -0700, H. Peter Anvin wrote:
> No, "load user space GS." It loads everything, not just the base.

My aim is to have the comment be maximally helpful:

#define X86_FEATURE_LKGS                (12*32+18) /* Like MOV_GS except MSR_KERNEL_GS_BASE = GS.base */

This is the gist of what's in the FRED spec.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

