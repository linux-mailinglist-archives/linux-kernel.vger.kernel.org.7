Return-Path: <linux-kernel+bounces-829016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6725CB960CD
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 15:44:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 239773BE6EA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 13:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95DCC327A0F;
	Tue, 23 Sep 2025 13:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="hXbOO4+m"
Received: from sonic308-19.consmr.mail.sg3.yahoo.com (sonic308-19.consmr.mail.sg3.yahoo.com [106.10.241.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2124204E
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 13:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=106.10.241.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758635053; cv=none; b=qxsL0NOYNs/uS2oTgA2WD9GfwOB8RJetrOxaDROhvnr1hQtryGdv67prYiFmC/005NH73hQLZbvWJEY10H345ii7g+0Akz9/8hOGU6AGI/nwHVvOQ9RtL6HmPmGIok3kCthbBD4rSWerow/VwI4GeIEH374IzSbRldsVZryDZWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758635053; c=relaxed/simple;
	bh=yd1cpLLfQcHwI3mATOIzXz5vu6mrl+DoW1ozUOgg5rQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RSSSj6bPnehZZrOSW0d3RoY+f5wsUMqkDSvnBru+a9Hv9qqK9CUOJdVESoAtaeBgRN/ypJQpVA3VUuowInCOUvCZabg33RGkgghpdL5qz9ApoX4TZKN+FnOtV+ueLSzS0cy0V3FGiiBelIezrkkU7vvezCTjdef40XLphQg8wdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=hXbOO4+m; arc=none smtp.client-ip=106.10.241.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1758635049; bh=yd1cpLLfQcHwI3mATOIzXz5vu6mrl+DoW1ozUOgg5rQ=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=hXbOO4+mTmAHD0npFiInbxb028PQHjgXyB622yYWTPCbJ06EyFTm8pLJgKqH35TseJG2XWlgXX99XNcm+ds1QCQ2IhlPxScA9OvLlnW6BIKIZchlAPAZiW9IKJLBIJztVn7UMv2T3amAre/AJt7j0JG2uRuLEwD8zSnaOMwNJxDktyBz/TIqlqSLL9Z/yKoCbMo5h+kNEMscBUvn+DKMadSrqJXWYzFgizWZKdUltPi0yeoiuVJKPQ8C/MWM/tPaXbo+NopW1yKvbRsKp0cvrvvl3JK+z/8kgGKaeYmehmEpXD2nEaNFxCCipsREG0ZiM9dssQo+bXH7XwD5HdoJvA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1758635049; bh=vJRWkDDRnIgjk5KVLqs9TlYlFfJci2wgcNt9bB5y7Jj=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=kObJHr0pYiiDCDdcXqeDqbVgE468Be+MrtujVrJYy37dU5m2RN8eH1Tec8vqr3SkbtliVCizYxybHg7Z05qKukdgt/s0ayXocYKeSIruBm1LRQzIbEjhz1UvIdnOCqbIoBmYy2K2GhfFcwZZ2ypwuHC8zMz6yCpv7Pa6MhE3QjkTKArtjmVfCGS1leTMKc9DoSrNjDgsa+52ZWGIwjB32g6vP69ymth3KLsayHQ4LNVR92TW+4+OYroIExi4OmCyzkSNRom7V44IJkMjCNhim/HHFPqHj0QPYW+s5qU3hPhCS87wMBqNYWVJWaz5dpmSmTDAqKSkE0bR74vboes6PQ==
X-YMail-OSG: 5_2A6u8VM1lg9iSqldO9T0blGH2a37pYfr1RoFXtfy540X_d0xzb.ae4LTLmYuL
 sNb8RgvVa4GWstzueDFGPIiEktycQk9QUiSAdViBX2xlsqjnrfvAhQHenek7y6DLROHx09R5mLKS
 pZyPU7hyrlE1xW7071QZfzKYgyYEcaHkoSGBxS7oQ.D9lcLSZfMy3YPNzcbA7RxgNxXKYHv2hdmB
 oA1Paun.adVuuF_ipiq.JO7tO8O0FABrokE29stZDCe3E9j1Xt2vPhWj5ScTmBMAyWZiUh.RXNhD
 .jDwl7wOEe3qjvihVTpmNkEkBhESI4ePhsd_WqVdHZ14DPHCNQU0HorkA94gl29MPdi48NLoy4vr
 jjsfqviFGZky84Rq919Hs_zjb7t7pWEqYaeoy.nv4lUZCXd9mb2evWbU6yon9vFdXkjfJJsvCHGt
 se_5WGsnMVgDsb7Sg4EbERB7n3MWHtc0WTMfzmpv8vyP6mHfyIj0muLnhfrU83jqCwCxkJqTRjby
 1x.urFs0RBZUvNVXA8mybBkOeTIEnluCbNrCqZuIVcsDJwkyZ1gM7I67dH6ReLtHyloHQVM_1CTN
 9u.U_5r4I3G9c9qed9VRhbOV050AWrUVMXWExHgnVo9AtnOeGdJ0WkzqI0c4FKcDhacmrd5XgUWt
 .cs1zf1k6Ki5x1n.FRXkSu1AeMpfxOFNWE.PaCCyjx6wi6oByowCfY3cZ8eW4mXZKpb8jEywd.gu
 734N04T8c_KL2GpSlEVUozaFUdSyyB0fUMRNrfEakw5ABmRmJ2NHdFeVNv1QXXUn0.M8GEWZqlub
 0SlOLQkpJgXTyMXX13OnfmmDQ7mgFUr1detYZILhLQEuIztnDXbDXceiHCwIT8n_7UwQeGDUJRos
 Ase0DulDNz.8Of5kTCn2V58GsLtg_x8E53jza2LerUmssRrNh5wS2a9A9VOYn_2JrUm9qOwkCW1o
 gdRO4E2zG5ukJJr7O9dMohSsbLd1fHrEuVgLojsVa4N4CThGQClA7e0n6BwWvAAVT1WHZz4mgOZK
 C.b7iupdJEh48t6NV3Wj1WFKsGDKT.vpY9hWvaiosBpmAjFtKpXzmpB6i6DEEkVAWuhNXLbvDFQ0
 ZvISFno48n.B_VMBgVVot2llBrarEg7OunXSagq3oyBKS3c1T4XyoKApV4oEpnr6rahosaOTfbil
 ZN.qxOCTUiNhe831813.YSl1HKppB0MX7LyJOjqx_Rfr4I9s1KhWokVbMabelp7xtX2eXPWowdNR
 oqQVwj5vZ3Ien1qO01dxMzTdGYw7NKMEKbluBNVncy8t4hqvE7igyCQdgXdHqjrBfzCOtqn9Rwk7
 7YXwOm8d5NkeML33vHfp_SWJ9ri3uHkie9vgupVtDXshzbImdS8vcAZYSFzq0Ddp6HSWoaKznFju
 TFoLLeM4sIEt7XxNj3KaYpyOLE6QCl2eCPSgXGYGm3DQg15as3ZCH4BieUOG2wxlGJSEvcZYINR1
 qGItpnwH1v6K9QecadLrRGs4ydZlGryZvd_doDzCjMuauB6.BpHASFvS8yWs5NVrfQZL_bDZhsu0
 pPXL4tDVkVhtjwLRFgCeIkXOFFgYeQyGg3O8Yws.p7NmZbrSzS2t9DTwF.F7X8jSS1S2.RAnoDpk
 FLNoAykUHKQmTzRPPF6VOFo9vw0QqHkyauk70rLEBWptMhmolGTSv4pUvop9PjsnUs4xFwK_wmXC
 2pgOxxzcoIy4v4Ahka0T16R96kxWXnG1Kr1cCy8PPlFaxU6FqrEsmobCHHzvSxPSvf53Q1xbSa8e
 TaBGPAK_f9mGddj_jvma9LZMRnkGqell1yYRCvnYt1Cn2D8UrJKMmU0ugLC_xhYWlOSRW6uHZsZG
 OA0cGpn7hFcExO5SgVChuHI_hXXGqcl.AikQuFe1XltcqKm2Ez6ZVePouW1dP6_tZq6Anbt9Zo7O
 9c_htrJqjvXNOWjzZTme1wWeS8xTboHPmdl4_BnLOtxnRrnWaWPsdDC_dPEN8t8NYazp5YqW3K5P
 zZLo7.0N.1EK.rIpthjOud3iXR3eB2sSQ1.T54k4zzKJe9mr8P1CX39IoT0YaYCkR83QO71_J_an
 Q2J4UYs6RPghFiM3GHOxiizD9P._O4NqKoKtmprSwijdlltHe4dhvZaWKKPKgai_s94RVPdzg4qO
 d3kFqgAr.ohXVuDUhfpl1fNUs.dr4bC.2EIbVC73O2sxnKtc.lyCI1RFo8UEJPnx6hPD2NuXz5aO
 ualRHkCZpIRVpuuEC3BbWmAM2ea1agZEb36tHsI4P2yuFwc5jFoZnd81UF8clrx7FUOER7rD1PX4
 meoJTiYo0oF0-
X-Sonic-MF: <sumanth.gavini@yahoo.com>
X-Sonic-ID: 52be80ae-1744-43ee-96f7-11a0fc5dda32
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.sg3.yahoo.com with HTTP; Tue, 23 Sep 2025 13:44:09 +0000
Received: by hermes--production-ne1-6b9c565dcd-npnnn (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID ef9c3dcafa6eacd1c26e38b32d340bfb;
          Tue, 23 Sep 2025 13:13:40 +0000 (UTC)
From: Sumanth Gavini <sumanth.gavini@yahoo.com>
To: tglx@linutronix.de
Cc: boqun.feng@gmail.com,
	clingutla@codeaurora.org,
	elavila@google.com,
	gregkh@linuxfoundation.org,
	jstultz@google.com,
	kprateek.nayak@amd.com,
	linux-kernel@vger.kernel.org,
	mhiramat@kernel.org,
	mingo@kernel.org,
	rostedt@goodmis.org,
	ryotkkr98@gmail.com,
	sashal@kernel.org,
	stable@vger.kernel.org,
	sumanth.gavini@yahoo.com
Subject: Re: [PATCH 6.1] softirq: Add trace points for tasklet entry/exit
Date: Tue, 23 Sep 2025 08:13:33 -0500
Message-ID: <20250923131334.66580-1-sumanth.gavini@yahoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <87ldnavsse.ffs@tglx>
References: <87ldnavsse.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Thomas, John,

Thanks for the feedback. Just to clarify — my intention here was only to backport the already accepted upstream changes into this branch. I do not plan to introduce any additional modifications or syzbot-only patches.

Thank you for your time and consideration.

Regards,
Sumanth Gavini

