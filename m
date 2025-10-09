Return-Path: <linux-kernel+bounces-846589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8BE5BC8704
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 12:16:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 943CE3C6532
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 10:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC68C2D9496;
	Thu,  9 Oct 2025 10:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="ED7XXkT5"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D93B67E
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 10:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760004992; cv=none; b=TjrEru1/AVuuih0JRAJtgvQhxZLzII2y5/dL30kVeyZex2alqNOZWd7AVD1jcuub0l+NG6iz0IwPnY/vFEND225tlOJulgh28jbnvj2HsbX2t8u6r4IhSetrv6ifwKBasovkB4edg0DLWAqJSM0KBC6I/MwdMZjfNFHIKESxulM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760004992; c=relaxed/simple;
	bh=l07FkYOJppRdV3pAtVcvo6Ehpj3PK6L7gG616NbL9Dw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YeDcMG2wtnxhD+TnDUkWJe59o6XqL4uL0vHZYg9FhkWXEU7XRKKVWc9E+VLxKj/wgcsQZWGGn4vdNbkJy0W7S40ueP//dZ05BXqX0S/L1RLbfBbLjtqRwv8SouPXClGM5dh+J+hSbl2HrHdagrVBYW6DZ6NXGlFAC/uQl/ezcug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=ED7XXkT5; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 2A9A640E01C9;
	Thu,  9 Oct 2025 10:16:19 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id UeaHryJfg6pq; Thu,  9 Oct 2025 10:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1760004974; bh=SxmRPr3A4T+jirsVUQtEo6zS3Mv8rIG0o6okyWeb1xM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ED7XXkT59+v2n9Q22N9BIs89hCoUSE7hHEmnyt4zCZjstunTu+vCg/mBdBIEgE+si
	 L4lu1QzcXwetGqMKQ1T9WP2K2DMH+7N7sQSW3zjSWCECNb5C7dBDf3Zdy54As9eaHA
	 j8GoNjRIqGgoDQjhioZlkpOSz0q9f4GjXs0DP8MWawz2WIaBe7AQxVyGusF+yaOhXL
	 /bKkm3KOjz5GBMvCmvg57Ko/N20wVDU3GSoSngNO9VtdH3K3/qsZHg202JG05UgCYl
	 p5lOlcbGc2dv/7/Az2POGCxkeICV/TyRlMI3k/SM3pPM865rJTESf+Rewlmg4if+HZ
	 suWnrgFFCAYOnU305EX7atGM6NFbZJD8VrJNC8ptNKWgLC1l/mUDdQ39TVCE1C09FE
	 UAeu6piuNkaSUAB1PUV8qgdROUZ9+6ZAoLeOjZLK9iDYViKYGy2Tqw2tccTTQ0XnYB
	 vVgBgV2NNtYMwU77fdeJZi/dE2tHOHNs71JSIsDgyierNt6OCS9ZDe2akv7lsYQiuG
	 cjx9iSFLkKYVAMl4k7tRzQ1x28Q8IaYziNs2LysaQxXWOp1nnRDGtdwA7HKXYknBK0
	 H6Ly1VMBYTglsbkWU16jkz8OpKuO0CbrTs3EkLx7gS4NPukcDHhMt4vz/RZveO1WpS
	 dDQy2WvK/CqvTR36O9GSbPmc=
Received: from zn.tnic (p5de8ed27.dip0.t-ipconnect.de [93.232.237.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 7452940E00DD;
	Thu,  9 Oct 2025 10:16:03 +0000 (UTC)
Date: Thu, 9 Oct 2025 12:15:57 +0200
From: Borislav Petkov <bp@alien8.de>
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>,
	"Kaplan, David" <David.Kaplan@amd.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Klaus Kusche <klaus.kusche@computerix.info>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/bugs: Qualify RETBLEED_INTEL_MSG
Message-ID: <20251009101557.GAaOeLXYDjOnyFTWdg@fat_crate.local>
References: <20251003171936.155391-1-david.kaplan@amd.com>
 <20251006131126.GBaOO__iUbQHNR6QhW@fat_crate.local>
 <LV3PR12MB9265B9AA81E01A539214764A94E3A@LV3PR12MB9265.namprd12.prod.outlook.com>
 <20251006140442.GDaOPMemqB7SRJSHWL@fat_crate.local>
 <20251007182257.ywrqrrhgrtrviila@desk>
 <20251007221229.GAaOWQTadGWlZSeAo_@fat_crate.local>
 <20251007230821.5shpa3pusyzaohb2@desk>
 <sb7p6quwxkn4w4etgsxlqd6fcsia4xobf73d3fnybxafxrmvwi@ajg5lkdxtnfy>
 <20251008102136.GAaOY7MBd4_VBPBNtG@fat_crate.local>
 <pnobm2r4icma6xzxvzklxoyoy3a4yhhxuxdoq2srmz6rpnegms@qneijnfu6fmz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pnobm2r4icma6xzxvzklxoyoy3a4yhhxuxdoq2srmz6rpnegms@qneijnfu6fmz>

On Wed, Oct 08, 2025 at 11:04:32PM -0700, Pawan Gupta wrote:
> Thats a lot. OTOH, most of the bugs.c is __init code, do you think it is
> still problematic?

What is wrong with aiming to not have dead code in the kernel if it can be
removed cleanly?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

