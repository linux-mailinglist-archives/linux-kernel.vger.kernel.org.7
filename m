Return-Path: <linux-kernel+bounces-841314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 04737BB701E
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 15:26:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64C4C18978F2
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 13:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 151732EFD98;
	Fri,  3 Oct 2025 13:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="USl4xRXY"
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD6D12F2D
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 13:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759497976; cv=none; b=WvAI/MuNwVuXGOtCYCg/wtiowRDzSTVcaUHxIHrYZrXURJU+HaQf4j/cN8ZTNxRRcky1nPgGnxbFOghmSD+n0rz4EyiLt/w9cttJd/X4bo06pY+ylQ08b2jAuWFVucRRhR0F+Y6jb/sa0Zp2en52TUMOLzFnoTywVD2grg4W0zU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759497976; c=relaxed/simple;
	bh=McfIq4nefZYN5G9+pot4eBcPGCpYCB6FZH1gcGcVDoo=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=tQIk/681ScV3suMIf6o5BygCQm4c/A6hF9kc5izi7HcrGyfBsVv64Po9rpTr9q9a1vwrBw0Qwi5VEo1p2vXrYN/zVZrp5yKfict/jQGm1Y0lCOPrcKDRhxk4dn5SnfidlUk9DOfxC0CSnWgXXBaBv7kuESCliUSAtHGJP+3voKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=USl4xRXY; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1759497935; x=1760102735; i=markus.elfring@web.de;
	bh=McfIq4nefZYN5G9+pot4eBcPGCpYCB6FZH1gcGcVDoo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=USl4xRXYmAf1W3Y1T0syoB+Uw2esio06QNMBY9PkcHqGXtc5hPKmkSgPSymwYBTA
	 fvr3SxIYXg7OvG5Zx+8yP2DhjZ4uax3h7/yufBysNxPqTl6wZkSi4GoT7ZXfeGcxW
	 vY4PGYE48BZnwIDy+i37l9HerdhV+rOzsnsfCgbQbiNWQLSOB/WtLE2JV+gy4/tw7
	 EZrt8N4H1rmNbsaUmcTj8XJfE/RwuTUBZKtxr6mL6AIDpmwpFYjOrnuoMFQr89x9V
	 PQ7mkUgbz5FRvW5hjeBqN8kXiu+kwJu+rma1U+v+ouoSJY1WK41ukMSRTbVfeDT7D
	 +8UtPg45Hdgmc00Fqg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.196]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MlL9z-1uaaIt3Xob-00gcYI; Fri, 03
 Oct 2025 15:25:34 +0200
Message-ID: <d636ad52-2ec6-4b5c-9ded-a7dc1e1291be@web.de>
Date: Fri, 3 Oct 2025 15:25:23 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Alexandr Sapozhnikov <alsp705@gmail.com>, linux-nvme@lists.infradead.org,
 lvc-project@linuxtesting.org
Cc: LKML <linux-kernel@vger.kernel.org>, Chaitanya Kulkarni <kch@nvidia.com>,
 Christoph Hellwig <hch@lst.de>, Daniel Wagner <wagi@kernel.org>,
 James Smart <james.smart@broadcom.com>, Sagi Grimberg <sagi@grimberg.me>
References: <20251002092202.11-1-alsp705@gmail.com>
Subject: Re: [PATCH] nvme: target: fix error checking in
 nvmet_fc_schedule_delete_assoc()
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20251002092202.11-1-alsp705@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:i4BdscEo73r96DewLe2en/58NEL/o7c4xX2KkxJscGNS+0o3VBG
 umgwV2LltVxa22EuhrmAfbR/+OppRMCnckzWnJ3cou5N0of4GDcP6EbnW/2ZRbvXkcKpJb1
 w3/j/bAau0iz4arkbpdJ20jVbAcGsneb1tME/H5TmyV3T9J+92SWw3pZdn6on3iF7U7te1d
 qUOeAXDiqpChmEYzn6dhg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:WfOLgRGKaF8=;LFqS+X20dm6G7EZhRYMHt/gyPbL
 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
 nBsX8VJaaL4qQtDCj4dMDLg0hQeA+29c8ko=

> The nvmet_fc_tgtport_get() function may return an error.

Would a corresponding imperative wording become helpful for an improved change description?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.17#n94

Regards,
Markus

