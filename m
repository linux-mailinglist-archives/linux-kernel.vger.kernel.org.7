Return-Path: <linux-kernel+bounces-779940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39955B2FB87
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 15:59:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B6A43AC810
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 13:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E11420C004;
	Thu, 21 Aug 2025 13:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=orca.pet header.i=@orca.pet header.b="WMfbOtDg"
Received: from smtpout9.mo534.mail-out.ovh.net (smtpout9.mo534.mail-out.ovh.net [178.33.251.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACAB6205ABA
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 13:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.33.251.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755783942; cv=none; b=S5xKnqGh1LP2WITjfTvWXLU+QF7RoZ0cmNJZZ2+j9HQdcD1ZiBFGyFbqXlws66Wkfu0mFcZahT3xwUU02kN3nTsYIq8zZAxi+5dW0kHdZiWVBRYDl9vfReWst3dDt/v/qhG4wbWRFF7Z9dqBZyqXtMw3ThJ+ykCJ2tvwtcu+j3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755783942; c=relaxed/simple;
	bh=4quadHfFtezURIkWRXVabZEgAmlOiHGhXnvjlAIzgVY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MQ7XKR/SgXasx2+MGRUkInEJgzIo1NJzzUp2CXAtk8r28EiO4SKw8/66iLglphZxUR0PGzyDWFDbmmh4KPty+8VDhCNeUdxWGdiTWQImJ2pv3gDm3eUG7OB4F59DS4IfHt+BbSzPBpfSJIpdlIbp4keUkt26cabyplT7DIkVaJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orca.pet; spf=pass smtp.mailfrom=orca.pet; dkim=pass (2048-bit key) header.d=orca.pet header.i=@orca.pet header.b=WMfbOtDg; arc=none smtp.client-ip=178.33.251.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orca.pet
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=orca.pet
Received: from director3.derp.mail-out.ovh.net (director3.derp.mail-out.ovh.net [152.228.215.222])
	by mo534.mail-out.ovh.net (Postfix) with ESMTPS id 4c74Mb2w9Lz6GWH;
	Thu, 21 Aug 2025 13:45:31 +0000 (UTC)
Received: from director3.derp.mail-out.ovh.net (director3.derp.mail-out.ovh.net. [127.0.0.1])
        by director3.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
        for <bp@alien8.de>; Thu, 21 Aug 2025 13:45:31 +0000 (UTC)
Received: from mta2.priv.ovhmail-u1.ea.mail.ovh.net (unknown [10.110.188.134])
	by director3.derp.mail-out.ovh.net (Postfix) with ESMTPS id 4c74Mb1Rmhz5wDl;
	Thu, 21 Aug 2025 13:45:31 +0000 (UTC)
Received: from orca.pet (unknown [10.1.6.8])
	by mta2.priv.ovhmail-u1.ea.mail.ovh.net (Postfix) with ESMTPSA id 1935B3E32C2;
	Thu, 21 Aug 2025 13:45:29 +0000 (UTC)
Authentication-Results:garm.ovh; auth=pass (GARM-106R00615733f67-033e-454f-9811-f14730d1c113,
                    684E78C7C579463DAB27E2CA1F9C4E28A39E1181) smtp.auth=marcos@orca.pet
X-OVh-ClientIp:79.117.22.109
Message-ID: <666f534d-b974-4f39-9356-3e2f1ab178f0@orca.pet>
Date: Thu, 21 Aug 2025 15:45:29 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86: add hintable NOPs emulation
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, Brian Gerst <brgerst@gmail.com>,
 Uros Bizjak <ubizjak@gmail.com>, Ard Biesheuvel <ardb@kernel.org>,
 David Kaplan <david.kaplan@amd.com>, "Ahmed S. Darwish"
 <darwi@linutronix.de>, Kees Cook <kees@kernel.org>,
 Andrew Cooper <andrew.cooper3@citrix.com>, Oleg Nesterov <oleg@redhat.com>,
 "Xin Li (Intel)" <xin@zytor.com>, Sabyrzhan Tasbolatov <snovitoll@gmail.com>
References: <20250820013452.495481-1-marcos@orca.pet>
 <20250821124804.GP3289052@noisy.programming.kicks-ass.net>
Content-Language: es-ES
From: Marcos Del Sol Vives <marcos@orca.pet>
In-Reply-To: <20250821124804.GP3289052@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 2520608420077459124
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduiedufeelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtvdejnecuhfhrohhmpeforghrtghoshcuffgvlhcuufholhcugghivhgvshcuoehmrghrtghoshesohhrtggrrdhpvghtqeenucggtffrrghtthgvrhhnpedtgedugfeiudfgkeduhfelgfejgfeuvdejffeiveegteejvddviefhiedujedvheenucfkphepuddvjedrtddrtddruddpjeelrdduudejrddvvddruddtleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomhepmhgrrhgtohhssehorhgtrgdrphgvthdpnhgspghrtghpthhtohepudekpdhrtghpthhtohepsghpsegrlhhivghnkedruggvpdhrtghpthhtohepuggrvhhiugdrkhgrphhlrghnsegrmhgurdgtohhmpdhrtghpthhtoheprghnughrvgifrdgtohhophgvrhefsegtihhtrhhigidrtghomhdprhgtphhtthhopegsrhhgvghrshhtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhnohhvihhtohhllhesghhmrghilhdrtghomhdprhgtphhtthhopehusghiiihjrghksehgmhgrihhlrdgtohhmpdhrtghpthhtohepphgvthgvrhiisehinhhfrhgrug
 gvrggurdhorhhgpdhrtghpthhtoheprghruggssehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkvggvsheskhgvrhhnvghlrdhorhhg
DKIM-Signature: a=rsa-sha256; bh=WBpANyQKSLHUucko2BsTZBGhCmR3nQaRHV8okAqrR8M=;
 c=relaxed/relaxed; d=orca.pet; h=From; s=ovhmo-selector-1; t=1755783932;
 v=1;
 b=WMfbOtDgsvo5quCArArgXQzkRF1wugwCPu5Heq7Lmu9fiehIpCaxtzhwD8+o2B3hQPo2Ayv/
 k6txLw/Ikg7DZdzxT0xzOibG/Of5p1sWp2rCMVuOD9gwG7c1Gkdb/QAY6kcSFDm0+mksbS2hp4T
 m4tQG8H11LfwFjJ068gsxdVl/wIUDdF0vd8Rm4FqyIfMTCkvBPAh0MaabVRnao+wJd5bFLX3Y+H
 V5/13zPTxtZ3Hlz/fOcG85LdzD4BOdHrPjneCIARudQUyDStZsDIf79c+bSHDXgcHfzRfNZr5Wm
 DDNjJWFCJnwh3Vc53EglmTEr/L0byiHWLiW8zYqmDoUGg==

El 21/08/2025 a las 14:48, Peter Zijlstra escribió:
> On Wed, Aug 20, 2025 at 03:34:46AM +0200, Marcos Del Sol Vives wrote:
>> +	/* Hintable NOPs cover 0F 18 to 0F 1F */
>> +	if (insn.opcode.bytes[0] != 0x0F ||
>> +		insn.opcode.bytes[1] < 0x18 || insn.opcode.bytes[1] > 0x1F)
>> +		return false;
> 
> FWIW, you need to check for insn.opcode.nbytes == 2.
> 

I can add it no problem for clarity, but would it be really necessary?

All opcodes in that range will have that length by the Intel SDM, so it seems
somewhat redundant, and if the opcode couldn't be read in full the decode
would've failed earlier.

insn_decode_mmio for example which I used as an example of software parsing
of instructions does not check any length if the prefix was 0x0f.

