Return-Path: <linux-kernel+bounces-777447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B30DB2D975
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 12:01:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1945C3A9D92
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 09:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E850B286D4E;
	Wed, 20 Aug 2025 09:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="X5kV6A+a"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE9E27781D
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 09:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755683787; cv=none; b=XLeRdjo5HO1AABXYcqvP5ry1lp7IE/A1KFT0AVxY94Tv0aF8lg6TyRskJEH6NKMk9xp9L/CoPD7btSV3TogNjDuJ2+D8L6yK8eO1S1DyXUUPVBCMW5/9lHOiYRm5coF/NYgfOXDprzYz5TzZN2fBwCDbXFWqR6Mnkq0wrZNo2D0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755683787; c=relaxed/simple;
	bh=xitfQrZetOKf8kCkoIvDPz3jhXBydEcE4Xi2KyvJ4IY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kZ8O88R3KcNEnY3yhB2LGpqV+oivr3FVVOXo1d3n2MJRCJlwaYQJ7C03mDRVc96xtGtbVnnJo0pSULvydiyzxaQHN4cnCqbhXAyxw55BxoAY2SqgCRmENnXfqfzrq/srX7vVO6dPtCnZAcCnqgxNCILT+ikCn9ZANj7B1PPH9aA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=X5kV6A+a; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 83D7440E0163;
	Wed, 20 Aug 2025 09:56:23 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Arg9dFQPpSFs; Wed, 20 Aug 2025 09:56:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1755683780; bh=deIAPLesfe6kpm1TjRfGB2nxLVtJgHVpEKomVozCfc0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X5kV6A+aHU17yDIEw0UGADPrdZvm2uiL1tFf0rLMwf4LB4RVrYjOVdTYw3IFicICX
	 7cBdzY8He4KPbiD+4Aph+8EKdHt0hyII7Jvi+YrxVOa7v4+N18VsV/V4Xt3iJxuFVC
	 cBSRFGkc5SyayHNnThv7OEQyrxsJVXdYJNb0NVxB8GRB8hVCrn9gwOIyx5l5F0/s4s
	 vBjZh2ubWhrfGSX8En1Goh2mS+3RHx6F44T/4nXVdWu+TGb+fNYB1N/f457CRkHf04
	 afN5GpxwTzARPkonk0RurrjL4tdJr2gFrEpl90XsSmamF50YxWoyEti24B5jCCpwXF
	 hB2OE0+CTfmzcF5IbzS52Np0F+15yofD4bAbvx84ZifvwI/alL5KP7HZpjWdCW9iyq
	 lLROqI5fcKpkPFJaV+UWevbBUVNV1UtIK4cBIst++/+vKYqjVWg+QbTYgmQQoI1Zpr
	 mkzKjvRURbSJT6wqD+1L6ad7tc0zxg/Hnf1rPeRghK6OPNhS57wbuWOkjW3KKsOBqb
	 tBJRLmZiF8HFdqXp7Xzf+5nXpHJm2mVyM6r3bPrSuIQlShjCB8pwAbDiUmHw3XHorO
	 KZ7iAyCpjSVy819dVHD+uCBqBenj5Z9lB3ceJl3oQztRyI3fXgnCmvOFb5QAwLe0ow
	 HgMjDaQauIRHvoSz/tGNqGTs=
Received: from zn.tnic (pd953092e.dip0.t-ipconnect.de [217.83.9.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 16F2F40E0206;
	Wed, 20 Aug 2025 09:56:02 +0000 (UTC)
Date: Wed, 20 Aug 2025 11:55:56 +0200
From: Borislav Petkov <bp@alien8.de>
To: Marcos Del Sol Vives <marcos@orca.pet>
Cc: "Ahmed S. Darwish" <darwi@linutronix.de>, linux-kernel@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Brian Gerst <brgerst@gmail.com>,
	Uros Bizjak <ubizjak@gmail.com>, Ard Biesheuvel <ardb@kernel.org>,
	David Kaplan <david.kaplan@amd.com>, Kees Cook <kees@kernel.org>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Oleg Nesterov <oleg@redhat.com>, "Xin Li (Intel)" <xin@zytor.com>,
	Sabyrzhan Tasbolatov <snovitoll@gmail.com>
Subject: Re: [PATCH] x86: add hintable NOPs emulation
Message-ID: <20250820095556.GEaKWbrMh24T7jTfBg@fat_crate.local>
References: <20250820013452.495481-1-marcos@orca.pet>
 <aKWR8e6VUEZEgbkw@lx-t490>
 <2cd7b099-095d-405c-a7d9-b0f1f72184c2@orca.pet>
 <20250820094347.GDaKWY02hR3AAoT7la@fat_crate.local>
 <be242e65-b056-4e12-93e7-9a297aaf231a@orca.pet>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <be242e65-b056-4e12-93e7-9a297aaf231a@orca.pet>

On Wed, Aug 20, 2025 at 11:51:27AM +0200, Marcos Del Sol Vives wrote:
> I mean, they should know what they need to recompile if they want to, not
> just that their machine is having a bug triggered by some binary.

And what's stopping you from writing a proper error message explaining that?

And issuing that error message *exactly once* instead of flooding dmesg for no
good reason?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

