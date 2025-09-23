Return-Path: <linux-kernel+bounces-829655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AED6B978E0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 23:16:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA1444C3291
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 21:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD6B130BBB7;
	Tue, 23 Sep 2025 21:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Uy1/8ZTm"
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24FFE134CB
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 21:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758662177; cv=none; b=chLzFqju6OyIeP1vLwoKlxxCeaaWm0Me39PQDZzYwolfhqUVxxQsaeVeN9fOaeMw3wCBuBb3XeY0OVZaE8qN28xiLglLD/MBTmfbbcifPtDgUeTXbDagNzLLtTzXMTPGly4VnhEuQ+7JCk+1ltWJY22qzfyUr/MHONepMgAMyjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758662177; c=relaxed/simple;
	bh=NsZHFrbFKWMpGB71OcoS9l7zf1qReKVOm/SjLnAM70s=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=ipP4h4APsugHbU0N9HBanqHkAbxBPJTUNl++BAuf9x8zx7qAN0bwA5WxoqU5JIr9QvhUjn0n0E3w3TR0go3lZKRZT92/HmkMFXVSl61e2gVNTZl3LWQnFob9UUsuz5ZhXXE3fmknlgLBfvncCEYRo/BOmQ25Eaw9QtFZOJ2MWKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Uy1/8ZTm; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758662160;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NsZHFrbFKWMpGB71OcoS9l7zf1qReKVOm/SjLnAM70s=;
	b=Uy1/8ZTmSWzA9dhrn0hu8AlYX+zeX+aYCe8xPLIQO76WbmZDHeK4VzE2dZw8o8/Y3u+Ix7
	2I0MGm94Yhfy9NW/NCawHYvTPniEAJsO5LZPRee2BFRjPrNWWvFvubzdeHTSY3rwDQKowA
	TNYHteFsQ6nDv02VkInFG0cEQdN6UmA=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH RESEND] scsi: hpsa: Replace kmalloc + copy_from_user with
 memdup_user
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
In-Reply-To: <SJ2PR11MB8369DC643759199AD1642C1FE11DA@SJ2PR11MB8369.namprd11.prod.outlook.com>
Date: Tue, 23 Sep 2025 23:15:47 +0200
Cc: "<James.Bottomley@hansenpartnership.com>" <James.Bottomley@HansenPartnership.com>,
 martin.petersen@oracle.com,
 storagedev@microchip.com,
 linux-scsi@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <14365372-FCDF-4830-B999-317C7D7E28DB@linux.dev>
References: <20250923171505.1847356-1-thorsten.blum@linux.dev>
 <SJ2PR11MB8369DC643759199AD1642C1FE11DA@SJ2PR11MB8369.namprd11.prod.outlook.com>
To: Don.Brace@microchip.com
X-Migadu-Flow: FLOW_OUT

Hi Don,

On 23. Sep 2025, at 21:40, Don.Brace@microchip.com wrote:
> ...
> Thanks for your patch.
>=20
> We do not normally make changes to this driver as it is in maintenance =
mode.

Is there a general way to check if a driver is in maintenance mode?

Did you get a chance to look at my other patch [1] yet, which fixes a
potential memory leak in this driver? That's probably more important
than the refactorings.

Thanks,
Thorsten

[1] =
https://lore.kernel.org/lkml/20250919092637.721325-1-thorsten.blum@linux.d=
ev/


