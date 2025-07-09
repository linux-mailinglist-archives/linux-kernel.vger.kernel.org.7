Return-Path: <linux-kernel+bounces-724457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49668AFF31D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 22:37:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A8317A8E1F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 20:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B02B23F40A;
	Wed,  9 Jul 2025 20:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YVq7VS6q";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yRhZHIaH"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46508239E98
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 20:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752093419; cv=none; b=J/NJYv5xzGIZleTM/Pkuk988KMXDhgF+QlZPABXsUgi00SKomEznwVLq7Hr18GA+ZHVl7lraoguP0vJzLULnxGCn3hwKX0kp7MmSRtwp8M5X7J6foUWck7YkS3ZCMEtW5aVSJlKn5wotM08C3DcQucXiv8LMgPYDCF8l+OQSdhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752093419; c=relaxed/simple;
	bh=Dymr53Nxs7UGaIprdBfXwsT1jc0Oz/dcE/dyErm8b/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jknq25Jj9mBJtjVto0rhkmYuNXxmpQ3cIXjdswF7MCeCsaAejHK7cFguAoNXGeYScvsXUVC80ugX/kemD5Bv9Fqs2jODDwL+9YTuUPhsLnE3eLY/Y5zqmNUQ9eqr52Tx1JsCpCi1WdcBFptzvO2RPG6LWmf2+i4S2Q4ATrVvATM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YVq7VS6q; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yRhZHIaH; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 9 Jul 2025 22:36:54 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752093416;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dw9RExOBeQ+XiJNbxz8Pwny25BlQM6qdg6ukBCaM9Qs=;
	b=YVq7VS6qtli7vK9dLwnK/uavl7OTo93ht5wpljEYsH/ekI+OkBkqyHrqsiX+laLnlIINpM
	HJiCU660L+pMxgvLJ2TPCwLpy2TvvzzGSoXw0p6tzMwZokHwoq1Ijajw/Mop2hrqJLqkNx
	pKyu/hHRSdPRSrTGx10Mkpck5EAw9Ie3uA0CAQUHpmwOFTHdCB18RIfm+XZ9FJQ1wLicjd
	xMw3JAXKb/k/gIiQQ19bhCdjsJgFYlxuB8zcb6SZPFIkS3q1CCo4JqyTQ1oMxtzAN/BUc/
	JA7csyVTW0l9opE/oYQs20T4siW3bEovHdkVyzY26JlWfIRE933DkMOLtcJXYg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752093416;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dw9RExOBeQ+XiJNbxz8Pwny25BlQM6qdg6ukBCaM9Qs=;
	b=yRhZHIaHVQF5cIzSDhLcle4uovF6Amy+YbIYumsxj11Gc3D2rapQfu4Kd87jv9IFeUaOL0
	ARpdqayUX830ZCCA==
From: "Ahmed S. Darwish" <darwi@linutronix.de>
To: Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	John Ogness <john.ogness@linutronix.de>, x86@kernel.org,
	x86-cpuid@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/6] x86: Disentangle <asm/processor.h> dependency on
 CPUID headers
Message-ID: <aG7S5hSo2MAXrlRT@lx-t490>
References: <20250612234010.572636-1-darwi@linutronix.de>
 <20250709202635.89791-1-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250709202635.89791-1-darwi@linutronix.de>

On Wed, 09 Jul 2025, Ahmed S. Darwish wrote:
>
> Changelog v2
> ~~~~~~~~~~~~
>

Sorry, not my best day.  This was meant as a reply to another PQ.

Kindly ignore this and check instead:

    [PATCH v2 0/6] x86: Disentangle <asm/processor.h> dependency on CPUID headers
    https://lore.kernel.org/lkml/20250709203033.90125-1-darwi@linutronix.de

Thanks,

--
Ahmed S. Darwish
Linutronix GmbH

