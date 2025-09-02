Return-Path: <linux-kernel+bounces-796013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4144DB3FAEC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 11:43:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DA6A84E252A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 09:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A8352EC0AE;
	Tue,  2 Sep 2025 09:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bitology.eu header.i=@bitology.eu header.b="Apurbkx4"
Received: from smtp.domeneshop.no (smtp.domeneshop.no [194.63.252.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E3632ECD19
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 09:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.63.252.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756806167; cv=none; b=rjc36fAMdMdFsTRDsDcGaIGtJ+eyurvF1mxilcwFdgNFvwuVKUzwa5rRGOn8q/29v6csdB9gFxEsrNnTg30Cu+4uf56plYBOhmghXuwAsjq5ZC4aPFANoPAM38OUe1SmqYUWdkvf6k2F4WalCIodfdbw9T5Akq1o+2s1+TEegcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756806167; c=relaxed/simple;
	bh=w/kB0L/mS4RazOgYXIAgfWJnp76C9nk6C6dF6x31lJs=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=N3SJMN3cDPD08iFpFvwidmKya7QsEJ9BCsSye1lpajyHYXim+RL3SsHpI0VVg0GSDazlGnyaOPC7VFfhDCxX6JiFYzc8m0x1RAVhnfdKi9H3u6ZRNT7ktuPMDBJyGstcUE0HDK9Ec9hIipb5MNvDXIoKT7w9uMcrXUuZCY9VySk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bitology.eu; spf=pass smtp.mailfrom=bitology.eu; dkim=pass (2048-bit key) header.d=bitology.eu header.i=@bitology.eu header.b=Apurbkx4; arc=none smtp.client-ip=194.63.252.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bitology.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bitology.eu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bitology.eu
	; s=ds202506; h=Content-Transfer-Encoding:Content-Type:Subject:From:To:
	MIME-Version:Date:Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:
	Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=uCwOdzPph8YoM9Ph6fA/nKd5I+RBcFo/TU/iOtQ657w=; b=Apurbkx40bzZVfmdGLI6YkN7Ir
	V2Bl+uOWHQ3xPQHj+g8Ep+OG42RZpIFt0D4RoRZEOTpSeZDtzt3mNf865548HqnTQ/3lFrZAG4m/k
	Tfkp4biCv1ipQsZLMVaF4ohKooISWKa0aHfTfuilkC2R6IsLuiwPnv4nHQEq5W23Bgqt1x1d9TAra
	he1pf8Luxtq4RN1oKZgd9/2bRQRaMBQOXgYUBpfujrDaUxWh4C9nCUFrXA4KshN4Q0wAD9XTEJHO4
	k57i5KtiP3sZX1i6dzpSCTV//REugSp1ugoEiUMZ909LacTTgrcJNFkNTU7k+V9YkJUnq+DvgXcBo
	hVRWvg0A==;
Received: from smtp
	by smtp.domeneshop.no with esmtpsa (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	id 1utNXC-007Bv0-Dg
	for linux-kernel@vger.kernel.org;
	Tue, 02 Sep 2025 11:42:38 +0200
Message-ID: <82e93828-0484-4929-b957-9dcf2180c527@bitology.eu>
Date: Tue, 2 Sep 2025 11:42:37 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-kernel@vger.kernel.org
From: =?UTF-8?Q?Ywe_C=C3=A6rlyn?= <bit-budi@bitology.eu>
Subject: J Rewrite for Reality only basis, not rust / breakpoints outside
 scheduler etc
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Seems morale is low some places. Rust (even with Germ symbolism) seems 
to be about this, and breakpoints outside scheduler, etc.

An optimal programming language would be J, that can run natively on CPU.

It seems the JAVA CPU people want this to be taken over aswell, and is 
OK with it becoming J aswell.

C really is based on BCPL, which again is based on the Bit concept.

I am about the Bit concept, my project Bit 01, states how to write an 
operating system, and Unix is based on this. GNU is not Unix, is a coded 
version of this aswell. And Git too. Mandrake was also this, and several 
other distros. Red Hat easily being Bit Hat.

I have become a Budi for this, and I do believe nothing of this would 
happen, if I did not aim for this.

I approve only with basis in fact, that Bitstream OS, should be the 
standardization of all this, with a J version rewrite.

All of this symbolcorrect, as many like in the computer industry. Please 
just continue with that.

Light,
Ywe Cærlyn
Budi, Bitstreams OS
https://bitology.eu/



