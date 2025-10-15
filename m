Return-Path: <linux-kernel+bounces-854727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EA11BDF3EF
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 17:04:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3CA1350670E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 15:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A0652D7DDE;
	Wed, 15 Oct 2025 14:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redadmin.org header.i=@redadmin.org header.b="GdUyvDOb"
Received: from www3141.sakura.ne.jp (www3141.sakura.ne.jp [49.212.207.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD4E22C21EC;
	Wed, 15 Oct 2025 14:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=49.212.207.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760540240; cv=pass; b=SYA5voXhBnCnUoj/hQpG5TNLjKknia2HKkn/cKmPCCKF41lUuTEGmOsI3MFCvO4oUYGlZqiyEmS0XM0n1s0hSiC1PxDlOOaUqVZABQ0qaVz8c3bf7zcAXTfCAf16fyVUceXZhsTJude8aiug5qFw+OCC6tXpbd4gIMP88Lx8bYg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760540240; c=relaxed/simple;
	bh=m56SvGKojCd/FiCDBNV86ncNjpuFwiArIWrdPAwDCQI=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=GeEDIaE4+KQD+lnCIzisljx8TXqeEnCPVHvbQodZtR4WCiHdckKXP/5FsvceWu4xGoxBPf4v6r9Cy2d0vfiw8mUQ7aHGAF9KkM/eOosj4tH1OBLS1K4eIa8NzynX0Fc1cwif9Mg1xWkekjmPvDqf1ejORfrV/oRgG1rW3PPTRco=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redadmin.org; spf=pass smtp.mailfrom=redadmin.org; dkim=pass (1024-bit key) header.d=redadmin.org header.i=@redadmin.org header.b=GdUyvDOb; arc=pass smtp.client-ip=49.212.207.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redadmin.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redadmin.org
Received: from www.redadmin.org (bc043154.ppp.asahi-net.or.jp [222.228.43.154])
	(authenticated bits=0)
	by www3141.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 59FEvB8L083739
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 15 Oct 2025 23:57:12 +0900 (JST)
	(envelope-from weibu@redadmin.org)
Received: from localhost (localhost [127.0.0.1])
	by www.redadmin.org (Postfix) with ESMTP id 5F52510A0ECFC;
	Wed, 15 Oct 2025 23:57:11 +0900 (JST)
X-Virus-Scanned: amavis at redadmin.org
Received: from www.redadmin.org ([127.0.0.1])
 by localhost (redadmin.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6giJlY_y6ej4; Wed, 15 Oct 2025 23:57:07 +0900 (JST)
Received: from webmail.redadmin.org (redadmin.org [192.168.11.50])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-256) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: weibu@redadmin.org)
	by www.redadmin.org (Postfix) with ESMTPSA id 9A29B109D7EE3;
	Wed, 15 Oct 2025 23:57:07 +0900 (JST)
DMARC-Filter: OpenDMARC Filter v1.4.2 www.redadmin.org 9A29B109D7EE3
Authentication-Results: www.redadmin.org; arc=none smtp.remote-ip=192.168.11.50
ARC-Seal: i=1; a=rsa-sha256; d=redadmin.org; s=20231208space; t=1760540227;
	cv=none; b=u/WI/7K+G49rqDwm+4OQevoZqG470i+JUdyYhkLFfxRP5GE2wYXDhb+Ie+u5fqyL/bLAXoagEvmOQ7dYLuqy1g8oILTPvz97AEge7D+bN3xv1leTvaABlsdx/x+Y5UCm7Av7r82CrAzGdXLd3MkX+ObuWqsYr0s/mHx3GPW80mw=
ARC-Message-Signature: i=1; a=rsa-sha256; d=redadmin.org; s=20231208space;
	t=1760540227; c=relaxed/relaxed;
	bh=9jqi0qQeN0nBJ0KiS8nuOONUGF+AoS3LBJVNBbwEvcE=;
	h=DKIM-Filter:DKIM-Signature:MIME-Version:Date:From:To:Cc:Subject:
	 In-Reply-To:References:Message-ID:X-Sender:Content-Type:
	 Content-Transfer-Encoding; b=woYv44U3B3aA0rqfb2hCcoQICoVJHc5oukqisYOkogZIn9uCkczt4j2fl/JzURkT+ma0Z93tP5nmP67uTIPoU+CNR9+PPkbdw9IsvKh8euEbWbubAQ7las/AmdNcSH0k/1NQy12bExC1xl06fcnRdKRCvD7kh+NLXDMb7CKQi3s=
ARC-Authentication-Results: i=1; www.redadmin.org
DKIM-Filter: OpenDKIM Filter v2.11.0 www.redadmin.org 9A29B109D7EE3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redadmin.org;
	s=20231208space; t=1760540227;
	bh=9jqi0qQeN0nBJ0KiS8nuOONUGF+AoS3LBJVNBbwEvcE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GdUyvDObT5ILfk+5jZHdaNbGIm4qSWC7wUEKfY8oSaGf4j3thM9JepVqE2uUxThws
	 yEFuW1ZjLqoItRpcYW666PSDc18o1PXt4oxMPrwjepLhz614MOh0vH3iVwQreDxRNv
	 vSkeSY/71HDIZNk2/PvKLLKAoodu80IYi4K/piuo=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 15 Oct 2025 23:57:07 +0900
From: weibu@redadmin.org
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org, akiyks@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] docs: ja_JP: SubmittingPatches: describe the 'Fixes:'
 tag
In-Reply-To: <87jz0xbk6f.fsf@trenco.lwn.net>
References: <20250909022502.119560-1-weibu@redadmin.org>
 <20250924192426.2743495-1-weibu@redadmin.org>
 <87jz0xbk6f.fsf@trenco.lwn.net>
Message-ID: <11158ff57b6b33b31a2d2fcb78842d25@redadmin.org>
X-Sender: weibu@redadmin.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit

Thanks, I’ll follow up by moving this under 
.../translations/ja_JP/process/, converting it to RST, and wiring it 
into the Sphinx toctree so it’s built.

2025-10-15 00:02 に Jonathan Corbet さんは書きました:
> Akiyoshi Kurita <weibu@redadmin.org> writes:
> 
>> Sync the ja_JP translation with the following upstream commits:
>> 
>> commit 8401aa1f5997 ("Documentation/SubmittingPatches: describe the 
>> Fixes: tag")
>> commit 19c3fe285cba ("docs: Explicitly state that the 'Fixes:' tag 
>> shouldn't split lines")
>> commit 5b5bbb8cc51b ("docs: process: Add an example for creating a 
>> fixes tag")
>> commit 6356f18f09dc ("Align git commit ID abbreviation guidelines and 
>> checks")
>> 
>> The mix of plain text and reST markup for ``git bisect`` is 
>> intentional to
>> align with the eventual reST conversion.
>> 
>> Signed-off-by: Akiyoshi Kurita <weibu@redadmin.org>
>> ---
>> v5:
>>  - whole rewrite
>> ---
>>  .../translations/ja_JP/SubmittingPatches      | 28 
>> ++++++++++++++++++-
>>  1 file changed, 27 insertions(+), 1 deletion(-)
> 
> Applied.
> 
> That said ... this is not an RST file, and won't be pulled into the 
> docs
> build.  I would *love* to see a patch that moves this file into its
> proper location under .../process/ and brings it into the build.
> 
> Thanks,
> 
> jon

