Return-Path: <linux-kernel+bounces-841088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9300FBB63BB
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 10:21:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B2803BF43F
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 08:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 442C8263C8F;
	Fri,  3 Oct 2025 08:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=computerix.info header.i=@computerix.info header.b="wotxcd0F"
Received: from www74.your-server.de (www74.your-server.de [213.133.104.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A2625EFBE
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 08:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759479687; cv=none; b=nYvukHoMiU0btstkugGxzdHXRoCYsGEfmBIFQzRMzIUfE/qi2gXB5aVD4OeAWkmt2AeY2ide8seXqa2a3ur2DBTF11HrEom3AtmNNaRbBD+FGeBOraEi5CtlBM0aAqdIqTWVdNDO6ZYxGvYQFlJ3zYyLdQzPhNKTzRcqOUsMESY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759479687; c=relaxed/simple;
	bh=1XMXcwJD3ako1gEWiqz9ifqDLHIbiQot16DMD6xBCA0=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=E+ZkfOWrfzeJcubAmDOzy9iLdfL+/NHF8dh45gTrrM9ISKpWCJ0aC3OTr4HcPYGGfC1n7yZye3fkEzHDeCt+tboDYZ/zyNv40RKCu71RFYmGmjupA+jJhvO6IV5q+It3lpBVz8ecCUkEQDnjp5iAnwjf/4YwjeIKcfx9B7PVyLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=computerix.info; spf=pass smtp.mailfrom=computerix.info; dkim=pass (2048-bit key) header.d=computerix.info header.i=@computerix.info header.b=wotxcd0F; arc=none smtp.client-ip=213.133.104.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=computerix.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=computerix.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=computerix.info; s=default2306; h=Content-Transfer-Encoding:Content-Type:
	Subject:From:To:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=s8nhOqyzysSdDZ2feet7mWAKD0gB30BEoSWBeA91qBA=; b=wotxcd0FH9Ax8f7+kR/+unmQUM
	lTRcfXU0KcHPftPc1pJNHjasiqiBKBvKuD/LAxLVa5u8ScfkW7CJR2dujOA/iuTNwoJ/Pnhszob5S
	/vkXfoCDK69EcGB05CyvIpdR92eSMUfnhcKkCZPreCgDN1J1WkNkI88XdO/MWWIL7u6iVhM3kjNkB
	ubpkorgXJQxNQGTgM1i/m20mEAr5xWJEzkGhX0P8iJY9nqU6awVTZgTa2AcHQR5rYjWY2LEgSwuV0
	e+6uxfCahRpvseHl4iYyORqABtp0Yt1ZZH9r299a16u+YUi/6ALWPxqOGP2fnYE7Oy+YJq6dk/+aM
	XheFKAYA==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
	by www74.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <klaus.kusche@computerix.info>)
	id 1v4alR-000BNJ-2w;
	Fri, 03 Oct 2025 10:03:41 +0200
Received: from localhost ([127.0.0.1])
	by sslproxy03.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <klaus.kusche@computerix.info>)
	id 1v4alR-00084n-1V;
	Fri, 03 Oct 2025 10:03:41 +0200
Message-ID: <84d9984a-e0f6-46e7-848a-31c52ca0d71b@computerix.info>
Date: Fri, 3 Oct 2025 10:03:41 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: tglx@linutronix.de, linux-kernel@vger.kernel.org, david.kaplan@amd.com
From: Klaus Kusche <klaus.kusche@computerix.info>
Subject: 6.17.0: New, annoying error message about Spectre mitigation and
 retbleed
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.0.9/27780/Thu Oct  2 04:58:32 2025)


See https://bugzilla.kernel.org/show_bug.cgi?id=220624

Could we please have a fix backported to stable 6.17?

-- 
Prof. Dr. Klaus Kusche
Private: Söllmnitz 32 d, D-07554 Gera/Söllmnitz
+49 36695 859909 klaus.kusche@computerix.info https://www.computerix.info
Office: DHGE Gera, Weg der Freundschaft 4, D-07546 Gera
klaus.kusche@dhge.de https://www.dhge.de


