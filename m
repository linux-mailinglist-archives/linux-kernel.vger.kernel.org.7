Return-Path: <linux-kernel+bounces-869877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D6EDC08EB0
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 11:58:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D67A94E427A
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 09:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 769C42E8B95;
	Sat, 25 Oct 2025 09:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Q08AOXNr"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD53C29A9F9
	for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 09:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761386310; cv=none; b=aPiof8BNFImoCpzAU0PatKiF4l55px7sm29U0Habiz3SVB5Tg5mZFX3mQjLeV8XpdvBV4TdL0SXBXSzN4ehcdV2yUaKojDqKD21qsbOzHeq6q5hrH+p3mBDyMg/HbLw6PWcvVZLa1/RFPXsnq62bsSn0dpaFEQHymQw1TfsrDJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761386310; c=relaxed/simple;
	bh=6l5Vz51AkX9dE5U2M+eNhhHt7xZJ041bitE7mKLMDbk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R++7YcxlQi3IEQ/1lJCljLmxH1LpetyA9Ya13YKRsMcVcYapa1JwXgwpJgen/Gql+6972yaMHEXVyzSzTdAK6l0BaPgVlWMRXuAUg16wZQD5h+DrXusJMHMQ9J+vfs99MwNK39bBfz8hRO+c5y7ign5hh0TRLPBSo0vddl93pgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Q08AOXNr; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 4625140E01FA;
	Sat, 25 Oct 2025 09:58:22 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id cg6j5_G3VMKG; Sat, 25 Oct 2025 09:58:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1761386297; bh=Ms6OfP7fnnzpCwdbYToJLw7bxMeGDjNJVbU9DiQwtVI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q08AOXNrmI0dbWJn9pwr6BSQMn9Gj5/TVHljcN8YHbcvuD+VNTZRbqwL44BBvjVZr
	 uDc6PfQq6NipuOghVTnlFaX/RAvaXT3VI5iGphL5efzfi3wLXXYUw7gYs2plxRXfZH
	 In1Th1OjQzic6hFSn+qB6LuAl34Le0Q4Y0OLGxg4d/BikHHX6qTyq5byoBqvzTrMa3
	 5vxEBRuWO6nrk+gHIRjVeq5ndEqJS4pE6TGqZsWqLEe1GE41FIRupxCEeoNR3d2HcW
	 amMMjVwHAdUHhVeEnRjtTZbLdK6+PQWSz7WoI/AD5wC56JDv7O8C8EIykrnAEOaEMa
	 jrROfIb9JsMAQlIZIQC/YLFpnyIqCaCkK27wDMjZKy7l1L7b9vf8Y9QP72TAcnbW0s
	 uhDNewwmvUepZiPYFR7U/cypvdozm1R10BnRvPY3y1Fd1Julhawl8u5Tu6z3ziD9qu
	 9aohJHRmSqRwyh7+YjOAQ13nY+l50ZIsUCjRgb/lIPVsoEDEa5PicRQI1Vl+QXmDUR
	 IQeJnshJyT1d8x3bzTVz+jOP40CXW2NwqE2HeMDeQelEEr9dJtoPR3p9p39THROXFu
	 3lwQkxeWpS6cwbdlzpJSkrYdyN6WBQK1HB+sHX8DcegOZIciQwJNq090RfR949JAV6
	 eqKN1cBgm/zBdi36gQPiisQU=
Received: from zn.tnic (pd9530da1.dip0.t-ipconnect.de [217.83.13.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id E78F140E019F;
	Sat, 25 Oct 2025 09:57:49 +0000 (UTC)
Date: Sat, 25 Oct 2025 11:57:43 +0200
From: Borislav Petkov <bp@alien8.de>
To: Brendan Jackman <jackmanb@google.com>
Cc: Andy Lutomirski <luto@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>, peterz@infradead.org,
	dave.hansen@linux.intel.com, mingo@redhat.com, tglx@linutronix.de,
	akpm@linux-foundation.org, david@redhat.com, derkling@google.com,
	junaids@google.com, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, reijiw@google.com, rientjes@google.com,
	rppt@kernel.org, vbabka@suse.cz, x86@kernel.org,
	yosry.ahmed@linux.dev
Subject: Re: [PATCH 01/21] x86/mm/asi: Add
 CONFIG_MITIGATION_ADDRESS_SPACE_ISOLATION
Message-ID: <20251025095743.GUaPyfF5YRbZxTYu9s@fat_crate.local>
References: <20250924-b4-asi-page-alloc-v1-0-2d861768041f@google.com>
 <20250924-b4-asi-page-alloc-v1-1-2d861768041f@google.com>
 <20251024223746.GTaPv_uiyc0wd1fPjV@fat_crate.local>
 <DDQY0TEKY4MU.2MMSAEB8QQZ4S@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <DDQY0TEKY4MU.2MMSAEB8QQZ4S@google.com>

On Fri, Oct 24, 2025 at 11:32:30PM +0000, Brendan Jackman wrote:
> Sure, CONFIG_ASI sounds great to me, if it sounds good to you :)

Meh, I'm just being practical. :)

> And yeah if someone doesn't know what ASI is, they probably don't know
> what ADDRESS_SPACE_ISOLATION is either to be honest. The Kconfig file
> has a nice place to document it.

Right.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

