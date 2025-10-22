Return-Path: <linux-kernel+bounces-864398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EC07BFAB32
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 09:53:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D44E2487CFF
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 07:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 173D22FD688;
	Wed, 22 Oct 2025 07:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Ptf1SV2k"
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB6772FD1CF
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 07:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761119555; cv=none; b=P7DOE3JyVWOYsYwLnU5OHqYG4MSH6I1f1VQmVVJOOdAfOflqkqUwqNcutct/PqFgSrvYboAcja6TnVg0Jbrf+TANwm5mab4wZu7/dfG2RSJCff72u0LvoIrExzVv/AifZF+pQMHKkU++kFa0tYS/phvYy6vSdXpCumuLduWqOwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761119555; c=relaxed/simple;
	bh=rlMvOD5AeQ6KDpmk6ybghzAuvBOGcGG1LB9F+sDiuvU=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=cUHAp5m0faxt1nen25w2ADqFbCgcn2RQbfSujs/kGdmFQ3LjHruQj3ILBNXRIZ5z8aSISvGsp3eatxjJRpEzfEMbmVlNMaRNw5akL1G3GrYjF4Al5LJHcfr9IqbuAffiZwnqkUU/tIYKOKux5c6JpfWTuYEHWymKysEiLcd5VbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Ptf1SV2k; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <39c67bcd-5369-44e7-9c7e-e9702ff95d53@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761119549;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=JkvxiA15m8LIzHDIMK6e0GwIrZbRTroCc89AgizbxBU=;
	b=Ptf1SV2kG1sp0usJgAo9cL5Psn6sVeD65crSNni/cWyfgHwi3aS/us4cQJZh71wGrfwLdN
	R7ECVnq5m+23YPSswFC68zlhXzuydYFvCW62zKfA81UpSrgIDgw2RrPFr9Sb2pp5oxP/jQ
	VCLG8Xuh26f2ad2XE9xw0X1sMDJEe1k=
Date: Wed, 22 Oct 2025 15:51:38 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: ChenXiaoSong <chenxiaosong.chenxiaosong@linux.dev>
Subject: Where can I find nfs-utils?
To: chuck.lever@oracle.com, jlayton@kernel.org, trondmy@kernel.org,
 anna@kernel.org
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Greetings,

Previously, the nfs-utils repository could be found at 
https://web.git.kernel.org/ , but it can no longer be found there. Where 
can I find the nfs-utils repository now?

-- 
Thanks,
ChenXiaoSong.


