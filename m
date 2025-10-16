Return-Path: <linux-kernel+bounces-856600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D23A0BE4932
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 18:27:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92C523B8E53
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 16:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4396C23EAAC;
	Thu, 16 Oct 2025 16:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="hKGGdTTG"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F30431C84D0
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 16:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760632062; cv=none; b=mCCuf4ohTgCy1b5QvI4DBkwtEpMKDraMzJ9FjLA/sSk3wa/MneyVhsyd3C7/DLdqXAlfkywUzED6JTJqYdcE3+CasRfMOrKrLxc0IKTjpL7KO+4+UTFoHNFqDOCCpuiDuXPEZtIOasKQPYJ7K4wRFwYWvJNu2GTeUVF+CNzVR9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760632062; c=relaxed/simple;
	bh=8XoOPYcNvWNi5CWD6ZBAUSFQsyBDRp11wyfWgoFIU9c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=doefwNNtTFLXV1b66+zuuJBUkd5fnxScvfcILUZxcBCa2yx48JdQCGzrDNFiebTCWswzQ1oLqnNwLEEChWIb7HBpG6PN4x5tJxvZlmdTgQDpTy8Eamn5DuIX+onoBBckTqwmFWiO8meXh32+mgqPKuyebu/yRYrf2RNDdS7mpvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=hKGGdTTG; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 6C97B40E00DE;
	Thu, 16 Oct 2025 16:27:38 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Y6ZwUH7X56RG; Thu, 16 Oct 2025 16:27:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1760632055; bh=6jmE4Bz01I78IdGJxMKqA/KtHVOKV/u7EDOmvtbyCkc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hKGGdTTG5ZU1xKzvSASvwQGsTVSnLt53z0urIsat3DTcmOEq9Qh6Dx84msL6dMPhP
	 19NMzhjeHKNCN85Vlao8oKHeazRUvIbye4EIQrHzBEVHIq0XTRoT1BOW8murEDPCTS
	 I9jV3yY3I1SBgULG7rc1f5zKYOIJnPaONOIST2JB94oKKmC79olKtsmQfq80gWkgNI
	 VDnClhjHZ5iDt0dD+nmvtVIHbK9SWJvw8Y6Z7jlLOHv1Q5hMZtZVIN3mL/kDYEh4VK
	 DxEsLjA8HhWYHvrjQ+HJhfIUa8h+OuFmQBllFwVtzXwkhq09rhUxFUhKgz4lFwl/3w
	 gzlyR0/uFow62/VfZn84WuZ2+EKQiGr/5RPAY1j2Cd9oRUyVmPl9bIgd2PFa8u/b//
	 hwYNhXA+EWco5qzBF9p9gc1O28DgIQgLFo+0PX6QQJekGcSlFEXE6piGxZKP7Sf5XV
	 yXgf1K+/MtnomiJyTX524A7O6G4G+kE8JiFRXB1PGbaw80bca/DSi6RDBPG+WKau6l
	 n/kNSO0JUJgv70Q9YyjCs8ScZ/mmDORAjHfSn2QXbAWBKFSUX5y82fiyXlqNV4zZ6n
	 IXkHbfQJbN8yFDxnzwiAGNa4Jv7GEDPR5ZVgEL7JAesSPP0lbZUGKGJUkzUaf5o1Lz
	 QqZjazADy7794myGZFGmLQ+U=
Received: from zn.tnic (pd9530da1.dip0.t-ipconnect.de [217.83.13.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id BBA2A40E015B;
	Thu, 16 Oct 2025 16:27:21 +0000 (UTC)
Date: Thu, 16 Oct 2025 18:27:16 +0200
From: Borislav Petkov <bp@alien8.de>
To: Dave Hansen <dave.hansen@intel.com>
Cc: "Kaplan, David" <David.Kaplan@amd.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>,
	"H . Peter Anvin" <hpa@zytor.com>, Alexander Graf <graf@amazon.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 40/56] x86/alternative: Use sync_core_nmi_safe()
Message-ID: <20251016162716.GDaPEc5NWGAHq5n6VV@fat_crate.local>
References: <20251013143444.3999-1-david.kaplan@amd.com>
 <20251013143444.3999-41-david.kaplan@amd.com>
 <20251016103549.GD3289052@noisy.programming.kicks-ass.net>
 <DS0PR12MB9273D987B842D9E80081261A94E9A@DS0PR12MB9273.namprd12.prod.outlook.com>
 <20251016144730.GC3245006@noisy.programming.kicks-ass.net>
 <DS0PR12MB92731E9877D21E36EC3EE4ED94E9A@DS0PR12MB9273.namprd12.prod.outlook.com>
 <9ca5a40c-1e9b-426d-8525-b1da39599731@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9ca5a40c-1e9b-426d-8525-b1da39599731@intel.com>

On Thu, Oct 16, 2025 at 09:15:32AM -0700, Dave Hansen wrote:
> On 10/16/25 08:34, Kaplan, David wrote:
> >> BTW, will AMD do that SERIALIZE instruction?
> > It is not supported on current parts, I can't comment on future ones.
> 
> I think that was Peter's nice way of asking AMD to go implement
> SERIALIZE. ;)

Why does it matter?

:-P

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

