Return-Path: <linux-kernel+bounces-894073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C4293C49353
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 21:19:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 005ED4E4F4B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 20:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 436B32EA16A;
	Mon, 10 Nov 2025 20:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="EARyUQnV"
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0614E2E8B60
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 20:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762805986; cv=none; b=M4qSkN+w11gmTYGVaOWkdAKSk7eZ+9pQsAUUACXygJP1jxyRPOtOIttHLb3gCtkipEPgDeNDo022SbWcYErKxUIzX8Fz+r3IcW2OyXvCaiWLawwN2xWd5/HyA7phRdAW1KjYxLqesH2Nupmll1b3B/moxLEa81gY4uuWFxiwWv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762805986; c=relaxed/simple;
	bh=9v9++OA9cIJhvT0eKRdiOOu8490H3SixxGQOWwhedd8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JV6ueKtHpl8FmhiuXHpXK0OrEpPzwBB2EGHwWc1y/O0AHuVrpHRwcZEBOcCZ2UkHdSdFB+sE/TJvO/wgWF5nDhcxjPu+bbsXWSzykLFddJmvXgYp2abvC2xFDIVji4NKJ3Pj0jgSkv4BN74y3Vq0LZHX9gENYUMpNr14JuXRcX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=EARyUQnV; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-122-154.bstnma.fios.verizon.net [173.48.122.154])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 5AAKJXmC009830
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Nov 2025 15:19:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1762805975; bh=XuNPATJHIZqaQ2tHE6vIjR+2AYXe/lFA1UKMDSwl9lQ=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=EARyUQnVdrh/iSMn4TEmyk29zOSAaxGPnL0EndZCGFrVbGIfk48HhYZLXk+Fo9kxv
	 GaVGGNY1dYwpBtE0ncN4vbhawz1fbTVOr+XAiO9XQpZjDDj10EB5UieCU70pDm8dSc
	 r/0kJohxzgVqHPbHCE/BSz8/MxgMfA26IdDVmzRqqBQ2YjqevpZlpVEMIz1ckg016j
	 8aotsyyXleX8ezN4sfWLFSSDbzqNBGvFZP7en6i97VW7Pv8SsShTVbuV36ygaJDtRW
	 zDePABD64Kk7F8GAbDJrOHh9Dstq/Mzyh11CHSlFUHxf0n3kl9Nz1nUiWWRSmqsONq
	 hclihBYZTuVaA==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 334442E00D9; Mon, 10 Nov 2025 15:19:33 -0500 (EST)
Date: Mon, 10 Nov 2025 15:19:33 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Maarten Brock <Maarten.Brock@sttls.nl>
Cc: "H. Peter Anvin" <hpa@zytor.com>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: RFC: Serial port DTR/RTS - O_NRESETDEV
Message-ID: <20251110201933.GH2988753@mit.edu>
References: <bb44f856-10a2-40c7-a3f7-be50c8e4b0a9@zytor.com>
 <20251107173743.GA3131573@mit.edu>
 <dc42f5d4-a707-4442-bda6-1c1990666f54@zytor.com>
 <20251110033556.GC2988753@mit.edu>
 <ADB50E23-DC8B-43D0-A345-E10396A3DFD4@zytor.com>
 <AMBPR05MB11925DA076098B05E418BF64283CEA@AMBPR05MB11925.eurprd05.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AMBPR05MB11925DA076098B05E418BF64283CEA@AMBPR05MB11925.eurprd05.prod.outlook.com>

On Mon, Nov 10, 2025 at 10:06:02AM +0000, Maarten Brock wrote:
> I fully agree that you cannot expect users that wired something like RS485 Driver
> Enable or a microcontroller reset to RTS or DTR to write their own kernel driver.
> And you need to open the port to make the appropriate settings. But opening a
> port should not e.g. claim the RS485 bus and mess up whatever communication
> was going on there.

Again, the existing seral driver code *will* mess with RTS and DTR at
boot up because that's part of the autoconfiuration code, and that was
added because it was needed for some number of serial ports.

If that's going to "mess up" the RS485 bus, maybe we need accept that
RS-232 != RS-485 and have a different driver for the two.  That's
going to be a lot simpler than trying to make the same code work for
both RS-232 and RS-485, and claiming that the existing RS-232 code is
"fundamentally buggy" when it interacts poorly with something that has
very different requirements than the historical RS-232 use cases.

              	  	     	    - Ted

