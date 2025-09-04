Return-Path: <linux-kernel+bounces-800915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 17EF0B43DA9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 15:48:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2790B7B89F3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 13:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91CFD2EC54A;
	Thu,  4 Sep 2025 13:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="TDfLMupa"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27AD3043B2
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 13:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756993709; cv=none; b=pYfWdCgW3COGQg99sCLjZiEUVpJJrWTs0fhr4lrm7eyDqnjGCG9FbqBbvH9tQpScHkk2Llqu8ynttOBdJ3F31WMO0w94e9lez5A2tFxfqPPfMJfH4FOxR7IFMH4Im3hOR7I5D9lHjyLnH78bZLhJFtc55hazvdGOtFXESf29P1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756993709; c=relaxed/simple;
	bh=qj7TYM6aBzp1mFs6qz3iXy6diX/4QJq+uiR7/XGCy5g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pxyPtLPw+BmVuvMgymK1QKZAE7Ks65m+hbViDWp0fKmEfapF/QSBVh9S1s9qyt+lPGiN1HpSGNKTJerDTp5Zlwkxi80Peg22DKmDnQqE4qpBIy8Zjd6ljyRKGMwS3dV8rZvmxYuwDfrJA/5jbNPAFdgYDk/xqkvFej7s6wG0M+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=TDfLMupa; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 324FB40E01BB;
	Thu,  4 Sep 2025 13:48:21 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id s4HTTzl8Bmr1; Thu,  4 Sep 2025 13:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1756993697; bh=Hgsa2OSmHiAK6uGiLLCaZxDJkvjo2nf4oP3qPFLSiz4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TDfLMupaYMB4YUgzMltvZHnG2j0LSKVfbgDQhJcLyEDGdYrzrW99clg0I2HsxoJhM
	 CzctUctnRia2LXYASbXyVpu86T0YTiKR4Eo21i7wFzhXFXF0IDuGkcuPp0+KqiIzC/
	 JHMKZ57ORufn+hLy2ZcB7UUnLvgvvzmIySXyq6omWIJOZWWTs1U79coSR0TmaEJgJ+
	 EgEkxzbDuSuGJDblO8O/Qe6j+vkiHXs8p0MKXgM84T1vQOe1K3ZgCZwLlgUphVrfMn
	 zG04KUrNO3wL68dPKE2RItCWKUmkFQ5a4DFJ0Ia4WNM5L0fcjQRJUZyVpZfnKLP7+E
	 uZFDXLmOh2WSOU7k3xBQKcO6TygCGcal/R5+FIUGXogolSp4oDnReD+UE8S+DFO+zq
	 196ZDg14XxDBm2tezIbAKPQov8ees6W9UX+vOwLy9sdzLLhslyowBdqu5VLncNwI0V
	 hfXkwzRWnYdE3gkCtlOMnU5wwqxN4q9H0TFm1oVKO6t2wPky3xpW3z+kjFGsCPAfKL
	 BKxpkyb0a4i5n1Br3Qsy4oQ6lRv0/Yilict4gufoy49YNrOdbQyTJl7ljCwyriQtO4
	 X8P9ar7Ve+rxbYbFIYOknAOaeFa1YnQ0a2P9DGmINPL3tjHmk2eWdp09UbfAuld3ZD
	 MNZ77udMQROxiTLzSsex57FQ=
Received: from zn.tnic (p5de8ed27.dip0.t-ipconnect.de [93.232.237.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 59CD840E0174;
	Thu,  4 Sep 2025 13:48:09 +0000 (UTC)
Date: Thu, 4 Sep 2025 15:48:02 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Chang S. Bae" <chang.seok.bae@intel.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de,
	mingo@redhat.com, dave.hansen@linux.intel.com, chao.gao@intel.com,
	abusse@amazon.de
Subject: Re: [PATCH v5 4/7] x86/microcode/intel: Define staging state struct
Message-ID: <20250904134802.GLaLmYksBaQgtonEp3@fat_crate.local>
References: <20250813172649.15474-1-chang.seok.bae@intel.com>
 <20250823155214.17465-1-chang.seok.bae@intel.com>
 <20250823155214.17465-5-chang.seok.bae@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250823155214.17465-5-chang.seok.bae@intel.com>

On Sat, Aug 23, 2025 at 08:52:07AM -0700, Chang S. Bae wrote:
> To facilitate a structured staging handler, a set of functions will be
> introduced.

No need for that sentence.

> Define staging_state struct to simplify function prototypes
> by consolidating relevant data, instead of passing multiple local
> variables.

That's clear enough.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

