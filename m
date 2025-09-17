Return-Path: <linux-kernel+bounces-820332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A609EB7F6E5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 15:40:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F2F93A6BFA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 09:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D69A309EEE;
	Wed, 17 Sep 2025 09:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="ftom3kH2"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA90E2C181
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 09:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758101225; cv=none; b=aOvkhHsuoVC1D3bbfMGN9E0s8Rle1AL8dgBBnngQ0jWlSydrQqAxB9yLyADMgVqYwR2aJ3cusaB9kQnd+pFrUFFyRVtRbxP3PkzGT52Kp6xVtkJfwFLGLv13N48wQX5FFISr2amRX+beoXWV+o84MpZzeXdt1noZETCDnq2Ll6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758101225; c=relaxed/simple;
	bh=JaVP9BG15QuKXb1gk7QU+lDM/U+ULJkt+RfzsjV1CUY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WnjY8O5tXuad0u0e2TYwb6B+QDiZR/DIRml97oMPriMUl1QeOZT2LhmA7rcjgQUcJFCcDnDctkQzKKmIVwE2N8pPBWGy+6jILaWK/6rZ03ntvnLmtC8IB4+u1dlHQpf6KDyzpuH67K5oq1cNEl48QWv6PxliJw8mTEMdK9d1Vsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=ftom3kH2; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id CCB6140E01A5;
	Wed, 17 Sep 2025 09:26:58 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id cX-5zdvozMQh; Wed, 17 Sep 2025 09:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1758101214; bh=hGpT1OkN1WEYpMVmrUYYT+6oX+YBbLGqX/JMZiZMYJE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ftom3kH2n1mJY2tOj6vk4nBNL/1rnc+VKeUU8hVC5OGUjIW9nNGtjW1XaLj7CVvn7
	 JjdKtNoG26GzcfHi7L8u1RLUHx00eyEAyo1jW9PgwDe2oDr6ZDKQ6FPKyImn0Fi+a2
	 usvVHpPl0ypPS3N1EU7mHOeMld4C5imrL/uXMP2y+vsOekR2BsKuyiIZ+SIB6+rLMG
	 XjB2zSvNEhVom/9cwmcq3neeLbX5MsVq0zScmzBLv6F4UxefvvDKYdIk9eOeuCLb+w
	 aBkSRT7qXTlZUqCJv9n/TGvCsCDpGvXFZXr2AcPcIcF7UiBGRQa1LZ5HRPi2NM8+y6
	 EnX/ZBUvQXwlaSWhajE2gapgTI5hk8f9R5caty4ljbxdL4gnPKaIs5UuwJy4ulVBZO
	 irURAMmKrurvUuz1CERCu6h05xK7OI0+Lndfn3nLjnqBs2pMVzBDzvJ4K9VpFkOqhm
	 P2z+NP7Rbym//MfSZonmUNoP4CfXGi0pnMJtT6j0XSP+INGdvKFfASI1FRUDGPRq1X
	 s2qcwAcbJUbAxtutkBtSZOzPWdRspHZnPIYEjr7oJRJyhjmxdLhuRPtQ4vv8ua5KXp
	 kgN9/L4RIsIxBaDGgPUckpKQvY6qFzxXmKLg6QkbsdJfinG5jBAPfJWK51S/FE6XJp
	 mQiAxsC92NjOJ81KP5PKDOCs=
Received: from zn.tnic (p5de8ed27.dip0.t-ipconnect.de [93.232.237.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id B3B6840E01A3;
	Wed, 17 Sep 2025 09:26:46 +0000 (UTC)
Date: Wed, 17 Sep 2025 11:26:39 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Moger, Babu" <bmoger@amd.com>
Cc: Reinette Chatre <reinette.chatre@intel.com>,
	Babu Moger <babu.moger@amd.com>, tony.luck@intel.com,
	Dave.Martin@arm.com, james.morse@arm.com, x86@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs/resctrl: Fix counter auto-assignment on mkdir with
 mbm_event enabled
Message-ID: <20250917092639.GAaMp-zzcfnpFkVUiG@fat_crate.local>
References: <9788ef37c17a9559a08019b694d2a47b507aa4ac.1758043391.git.babu.moger@amd.com>
 <437d6c22-f232-48a0-94db-a395aabe85d5@intel.com>
 <6d25c7a9-02f9-481f-9eb3-b1f6e3276e58@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6d25c7a9-02f9-481f-9eb3-b1f6e3276e58@amd.com>

On Tue, Sep 16, 2025 at 05:46:56PM -0500, Moger, Babu wrote:
> > It is not clear to me if the changelog will be acceptable and I provided alternative
> > text just in case. The fix looks good to me, for that:
> 
> Looks good to me.
> 
> Boris, I will send v2 with updated changelog. Let me know otherwise.

No need, lemme simply do that now.

Reinette, your version is exactly the structure one would like to read: first
you set up what the behavioral expectation is, and then you explain what the
issue is - i.e., what's wrong.

Good.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

