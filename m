Return-Path: <linux-kernel+bounces-858462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B19BBBEACB0
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 18:37:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BCBF1AE005F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 16:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 397672C11FA;
	Fri, 17 Oct 2025 16:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="XZ3kb1k2"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DBCE29994B
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 16:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760719037; cv=none; b=qT3HgxBi2fU894zFDVzB85lbcrPUzoW/jNcrGJLe0bnqJSJg7ipw8cBX50B/AjSVCFAWxuIcPCeJ2Noc6n/B5Rzfotv1XXPuWxpz7nTTFzjmCGH3bEVsG73z4FclGGw4nJgoRok0vpgAbs+bY17zthjGMeaEfx4p60r6B7+xwm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760719037; c=relaxed/simple;
	bh=kZhZMKdJxPsAnWJ7mrihCtVss6hKyjqr8ecic8kLF14=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h8KJV0oOHT+QAbGleG13/qNy/dkKhGy/l6qjdoCm7y9eX9JiKrmLjTEEc2CGChAy+Z1GGfJe9OquZ8+4djLBcnf8j6e3a1sDdKuqj13QunoMvQNOPYFDsKYxvaYTC6B5PS/E9XXyDXuz3HJz00KWDGXRZX5Sq+ZCJonYWYVMnC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=XZ3kb1k2; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 8A4B540E01F9;
	Fri, 17 Oct 2025 16:37:05 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id cNeotR6H3pks; Fri, 17 Oct 2025 16:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1760719022; bh=UqFZ9+pNFaaMivLnR1R24/1kxaEI92Ow6XPenGXkDaY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XZ3kb1k2KcKwE3gBBBaaFIPOyOKfArFkaZH6kVKwrS08OVVYr1iX+N3Rga9DfWbDK
	 OBFswYsYDFkGlaJ4yxr5BE3vnPyHzIU/om3We4y48AZQ4oGdiwYJ+QX1rXqYrDUtTR
	 v2ZRBjVkr0wnOZ0sjMxUi/aJLNkEl7PHg1l2XTxjtM8gwHWLUTdRk1ZxtRfd2YloOf
	 QDH871zgTT6NLYUCIdcvqJma5oSc3HKMVNLghJBYxONbPcut0KOtg6AV1MnUcDzmiM
	 +yrqMoJAY1sixqRJqNMdFsFiCguCv7Gn6VHh/gyOKNDWu+ZfcrTg1lEK7vprNwmQ+c
	 naKlONJFaRaIN4BpS3ORqF7mLW9jcSuKZrB9E1Ia8rcj+SZVapqOuvG3ZLEZF6rH/m
	 NXtbRcBn2iXnocWwK+7u9rzNoqV+2P++uQZReNPfB4COXQWqC5OPs6UIcT5i3WiAq7
	 HWXEqVt/eZXFrsve34llCrDtnmUPS6aV1/oZxZsGXL6IQD8ORE/EHhB7WIURak5Acp
	 XQmiN9Jh9dEtkxAVYuzWM6dFNnmV33hHrIQs9nzWBHJZtLx2vLL2KwGgVLvf/wFM17
	 jcp2oEJQWxfvsgvBsYFqRqEnj+KnEHxdu0DZPZHmcy1wUOwuXoZfhb2Dvdjr61eKCk
	 86jZoue1GqkDG14LORZks970=
Received: from zn.tnic (pd9530da1.dip0.t-ipconnect.de [217.83.13.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id D864540E01C9;
	Fri, 17 Oct 2025 16:36:49 +0000 (UTC)
Date: Fri, 17 Oct 2025 18:36:44 +0200
From: Borislav Petkov <bp@alien8.de>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: "Kaplan, David" <David.Kaplan@amd.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>,
	"H . Peter Anvin" <hpa@zytor.com>, Alexander Graf <graf@amazon.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 03/56] cpu: Reset global mitigations
Message-ID: <20251017163644.GGaPJwnNnZUHIlL3KF@fat_crate.local>
References: <20251013143444.3999-1-david.kaplan@amd.com>
 <20251013143444.3999-4-david.kaplan@amd.com>
 <fxgzzp3yokq24swgfkokdnqb7jf53s3na2wjitr5koiamfizgm@d7uvxnuzkebd>
 <LV3PR12MB926591EA45E7186AA3BD2A7E94F6A@LV3PR12MB9265.namprd12.prod.outlook.com>
 <LV3PR12MB92656CCC8F8776F50FE92B8894F6A@LV3PR12MB9265.namprd12.prod.outlook.com>
 <lrwbwfedilu4x3rizxn4i7pg3nuvoolbsnpfyb3ijbtf4ttjet@amyxglszq2fi>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <lrwbwfedilu4x3rizxn4i7pg3nuvoolbsnpfyb3ijbtf4ttjet@amyxglszq2fi>

On Fri, Oct 17, 2025 at 09:03:08AM -0700, Josh Poimboeuf wrote:
> I'd say generic is probably the way to go, as the sysfs files and
> mitigations= interfaces are already generic, and users might want this
> on other arches eventually.

Then users will do the move then. What's the point of making some Kconfig glue
generic if there's no other-arch implementation in the works?

And if other arch does that, they can do those minor Kconfig modifications
then. We don't do "someone might want this" code design anyway...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

