Return-Path: <linux-kernel+bounces-844690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B98CBC2823
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 21:28:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A18F44EF72E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 19:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FAEF231830;
	Tue,  7 Oct 2025 19:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="gl7ZowPn"
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7255A1C5F23
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 19:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759865317; cv=none; b=TL85Rh/rvJLlGpL9x3gDeBItDHlok2PPQ0JzSnjCyL06a1tHoGw89Ompo9WfQSYJ7cYJkVLHYEe18KjC3BJ/D+0stjsAOa69HEoTtepLCqOrT2+KK7qXxFRCfoYW25DHivhR0/amVoRTvuWQ/ANwCXuiA/0Vam2ik2i11M5uaU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759865317; c=relaxed/simple;
	bh=8o9bF8iyapjTsVg/hDsFbGPWEyB7pyDRmCb3bnkj1hk=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type; b=p6dXORMwXzsz8+TbWbDJBH3geOVsNQAEk2EDie5p0Xsu/9X8MEjlaemdNq8M/1W/A6Ndg4UaN6C62IDBs9u66PQijTtgodfjqfMLZg2ldmyMQbXuKf9Yk70XaArndmvduiGyc4f9vRHvaBDR3f8biHWtcGsBf4EORhTlMwm2X3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=gl7ZowPn; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id C7EDA240101
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 21:28:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de; s=2017;
	t=1759865313; bh=8o9bF8iyapjTsVg/hDsFbGPWEyB7pyDRmCb3bnkj1hk=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type:
	 Content-Transfer-Encoding:From;
	b=gl7ZowPn6jXN034+oPzpL2D08NO+Srh5sZmDGgYgLFDVJgTk6SsrSVHb3CXNSJQqg
	 JmorbaNr/tMcTe92zJKbRHi2YTclC2hyAnOYVvx9+RjEGlJJFVqpDEceIqXJrYhrWm
	 dBNS3mu8EyDVjytSP9+qRyDCPQ8kkqEQkhtqTJgGu02rgIw4wlp0oSigPoivSC1Z1y
	 ytIbLnbZBumtF13CwSIq2qSpnr1F4nehmBkwcZiwgU2shlifH85xqfxyYupOtaKtnw
	 KGbiGSTz5ITQq4yKhTY9Eyy2blnMc6wpHbOWzVA6CqXNIl6qXy36Pjnb9nTsuPqyHH
	 IiNrkXbBgiuEw==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4ch5lj3hlBz9rxD
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 21:28:33 +0200 (CEST)
Message-ID: <4a813594-8c34-4be9-9292-e576577e1648@posteo.de>
Date: Tue, 07 Oct 2025 19:28:33 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Andreas Kinzler <kinzler@posteo.de>
Subject: bug: CONFIG_SCHED_MC_PRIO has undeclared dependency on
 CONFIG_DEBUG_FS
To: linux-kernel@vger.kernel.org
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

please see https://bugzilla.kernel.org/show_bug.cgi?id=220638

https://elixir.bootlin.com/linux/v6.17.1/source/arch/x86/Kconfig#L1057 does not declare a dependency on CONFIG_DEBUG_FS. In fact CONFIG_SCHED_MC_PRIO requires CONFIG_DEBUG_FS because the function sched_set_itmt_support (https://elixir.bootlin.com/linux/v6.17.1/source/arch/x86/kernel/itmt.c#L108) creates debug fs entries and fails if CONFIG_DEBUG_FS is not set.

I found this bug because with my custom kernel CONFIG_SCHED_MC_PRIO functionality did not work because I did not enable CONFIG_DEBUG_FS. After enabling CONFIG_DEBUG_FS CONFIG_SCHED_MC_PRIO also worked.



