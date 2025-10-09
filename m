Return-Path: <linux-kernel+bounces-847558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B2F5BCB304
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 01:22:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 698854271B9
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 23:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53A252882CE;
	Thu,  9 Oct 2025 23:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="a86MTxSZ"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA91825784B
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 23:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760052145; cv=none; b=cnCzW/gQlj+wmTmzQ1b0GNJpwRDVEkFqr43T0s6DzyKKAqPFqV4VdZqPGsKoiF7RwmJXKaceAczED95I53trQv8BGKm+tnyDRchbJcUobJ2xvrryNN7cT41irb6qiKP5rImMLRacTKc2nXa/IPwkGBiTofW/NWCnCAAfRtacGWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760052145; c=relaxed/simple;
	bh=Z7V2fyIsD3KUcuMip0jmVGKXdlDJ/mp6UgCQ0j4X3jA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XdwCdw4koz41Y/916ikoJKMWbdHy0EAqVI0toQ+kBjfoEhqubv7T6kQXS1oGnq2bPYSpqL5+Kaw7xecJiAHXn4abVrsBye0GmMBTEbLihHgt3vzS3CrSDntCVSnzgIjLjOdMbDDpK6mOsqTrLxMIbbieGgEDApNoYn2ntFhXupo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=a86MTxSZ; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 731B440E01F9;
	Thu,  9 Oct 2025 23:22:20 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id DcANd3HgogI6; Thu,  9 Oct 2025 23:22:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1760052135; bh=Mu2pGaRxqly8+IXt2LQ5PK7EnlgUtQAK/JS9TAOQnxQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a86MTxSZhWJYVeY1H7Moti3w4pZamIkM8AFA93dr+U9B2z17UhFNGxv/6NW3vCMcZ
	 MGlpofg5HqbMr9AxF1Y465YM/BJILWgn+zWuIsGwq419iaL9UHO9bbzf2u7h4lOVCM
	 PvoOOrAAyx7wi65eurpIHbdQtPY+VwDwsBRD1C+9qw/qbd+3w0nidYZq8+Z4okOQH6
	 2mW1Dc17ovCYTSFzEcNnYU4meKJxO5lEq/250NDU73V7bM8bwBGRYVCFXX2AQqX+hO
	 7JNSxXCbiN7wwgxodOpvOzX0J10yTCpkA9u9wVUNArqCSf9WlsdpB1hoqphEtMijLM
	 4Lrs7sU3+ZN8CmRVu3TsHd5xyJg2sDXPUSvEKTSXuqIGQ26YncWhtdpM79yzu5/Y4a
	 readh8mQtX2P53NbbDwYkcD82Nf2/92vvFVnUDIrlMCkUmD0oBDIeRyLnkk28mjda1
	 Iac03B5J4EwKXeu3rjYm7CLV17oWhPXzlmkE5KEr+dJ6BdRrU4LelWQySdlV4Ee+sR
	 6z4Pa2vMDcLbogUkaUC8/D6PFipFrFCDmGNjwSaYn/4WrTWG0yNMENuGwqktXysv3s
	 j8522PpbDkOD7eYlUjF/1BBkCUkNrP3wMD1s2lABwn+5hdf6touL+ICcYJ7GaMK01T
	 1wvzt3KZcsPi4+56Sv+3UAqk=
Received: from zn.tnic (p5de8ed27.dip0.t-ipconnect.de [93.232.237.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 91E4F40E0194;
	Thu,  9 Oct 2025 23:22:01 +0000 (UTC)
Date: Fri, 10 Oct 2025 01:22:00 +0200
From: Borislav Petkov <bp@alien8.de>
To: Babu Moger <babu.moger@amd.com>
Cc: tony.luck@intel.com, reinette.chatre@intel.com, Dave.Martin@arm.com,
	james.morse@arm.com, tglx@linutronix.de, mingo@redhat.com,
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
	linux-kernel@vger.kernel.org, peternewman@google.com,
	eranian@google.com, gautham.shenoy@amd.com
Subject: Re: [PATCH v3] x86/resctrl: Fix miscount of bandwidth event when
 reactivating previously Unavailable RMID
Message-ID: <20251009232200.GDaOhDmBfQVJOQjETG@fat_crate.local>
References: <8eace6e47bb7e124ffb6c10150d1b7d38c2f5494.1760034251.git.babu.moger@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8eace6e47bb7e124ffb6c10150d1b7d38c2f5494.1760034251.git.babu.moger@amd.com>

On Thu, Oct 09, 2025 at 01:29:17PM -0500, Babu Moger wrote:
> -	*val = get_corrected_val(r, d, rmid, eventid, msr_val);
> +	switch (ret) {
> +	case 0:
> +		*val = get_corrected_val(r, d, rmid, eventid, msr_val);
> +		break;
> +	case -EINVAL:
> +		am = get_arch_mbm_state(hw_dom, rmid, eventid);
> +		if (am)
> +			am->prev_msr = 0;
> +		break;
> +	default:
> +		break;
> +	}

What's the point of this switch-case?

Why is this not better?

	if (!ret)
		...
	else if (ret == -EINVAL)
		...


	return ret;

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

