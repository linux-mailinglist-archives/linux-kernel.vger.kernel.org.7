Return-Path: <linux-kernel+bounces-815719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 28549B56A51
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 17:49:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16EB57A1AA9
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 15:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C2502DAFA7;
	Sun, 14 Sep 2025 15:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redadmin.org header.i=@redadmin.org header.b="vtYY5cpM"
Received: from www.redadmin.org (ag129037.ppp.asahi-net.or.jp [157.107.129.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E13D82DC796
	for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 15:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=157.107.129.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757864935; cv=pass; b=AnuBxKxECQPOa2Oq15Qosz7WkIE13iMAqY8O0cdplNT0OwsoVePYN3E85T/Qd8yNHE6a1PKBURKVZ2P6370WPijBEK4QhPG7v841sxSVYai4o5hOcVvBwagFLbHug4571mQIY490MXOgM3ZDrQf++8S6ndq4IHGYMRPycK0olt0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757864935; c=relaxed/simple;
	bh=lVQJuPxiLf6UCmoABIYz8VQVgoteFvwlN3g6Z9gFj4g=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=tdSwyOv55N15QrL+S76ouXdPQysL56M8iXKDMgvqfD+SwCVNINrggzHCOce4rR4Ygzhh3YBFLf7g+dHlgMHZoBmmoWYlVyghWqw9v6NPuAM+YiTa4z6i/7Uej5ZNSalji/MrcueR1AKyywduzyqZ0y1sjni43+cLmCthwPiWodE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redadmin.org; spf=pass smtp.mailfrom=redadmin.org; dkim=pass (1024-bit key) header.d=redadmin.org header.i=@redadmin.org header.b=vtYY5cpM; arc=pass smtp.client-ip=157.107.129.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redadmin.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redadmin.org
Received: from localhost (localhost [127.0.0.1])
	by www.redadmin.org (Postfix) with ESMTP id C5FCA10776D8B;
	Mon, 15 Sep 2025 00:48:50 +0900 (JST)
X-Virus-Scanned: amavis at redadmin.org
Received: from www.redadmin.org ([127.0.0.1])
 by localhost (redadmin.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GM_EwLPAkHrL; Mon, 15 Sep 2025 00:48:47 +0900 (JST)
Received: from webmail.redadmin.org (redadmin.org [192.168.11.50])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-256) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: weibu@redadmin.org)
	by www.redadmin.org (Postfix) with ESMTPSA id 547C310776D89;
	Mon, 15 Sep 2025 00:48:47 +0900 (JST)
DMARC-Filter: OpenDMARC Filter v1.4.2 www.redadmin.org 547C310776D89
Authentication-Results: www.redadmin.org; arc=none smtp.remote-ip=192.168.11.50
ARC-Seal: i=1; a=rsa-sha256; d=redadmin.org; s=20231208space; t=1757864927;
	cv=none; b=gZGSTu2w31SXR28tzjD58VWpXAs/mDCPoBClGXThIYUK8IrsPxYNaiiUobE91ZQ6bC7QOPzmHSUFO4URSKrw3jd5b3O1LlJB9S71k5IW/PbzBBev4OOljEcPFjd8rys16vqt9uSqiuspC66Ta7+rlOJ2+tgEpSphZ5TPvTQ2hgw=
ARC-Message-Signature: i=1; a=rsa-sha256; d=redadmin.org; s=20231208space;
	t=1757864927; c=relaxed/relaxed;
	bh=yam6LNz9D6qltmak1FlG5ouCGLlLYJvWE5jyC+Yrg70=;
	h=DKIM-Filter:DKIM-Signature:MIME-Version:Date:From:To:Cc:Subject:
	 In-Reply-To:References:Message-ID:X-Sender:Content-Type:
	 Content-Transfer-Encoding; b=G+ECQ+kbgwBeUJzIutqrw453BIBUTQRG1hP7vvuFR8dVqt3X+Bb7T6vWe6oGJFcTqR2DdJxtfS/UZncHJeRN0PLSvgxJ1deHYAbh6DENhWrga0S3fCfIQrYHfs+EdkSq2gW6+ZsJUOqXqBU1i2unNHNXj8umSpKr7T+Gv3dsNH8=
ARC-Authentication-Results: i=1; www.redadmin.org
DKIM-Filter: OpenDKIM Filter v2.11.0 www.redadmin.org 547C310776D89
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redadmin.org;
	s=20231208space; t=1757864927;
	bh=yam6LNz9D6qltmak1FlG5ouCGLlLYJvWE5jyC+Yrg70=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=vtYY5cpMPG/8ktjKXVrDVLoBCDU1N26RjYkNz20xjBnp/G4v3i7l5ulEmhhUgbrMF
	 5okCYWADkqU5YVzdz+Jn8fxaFdyoJQGXYCARL4bsCpvEu3O+GUA7WUEqpBwCvMAE2x
	 thEbxfWMMM/I1dbbPHzLLRwFEBD3crF4BbTa8KQk=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 15 Sep 2025 00:48:47 +0900
From: weibu@redadmin.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8723bs: rtw_efuse.h: Fix prototype whitespace
In-Reply-To: <1d0fdc3bde254057539b7e8506d0c211@redadmin.org>
References: <20250913112458.910059-1-weibu@redadmin.org>
 <2025091454-popular-overall-9864@gregkh>
 <1d0fdc3bde254057539b7e8506d0c211@redadmin.org>
Message-ID: <174fe5db36d1371c0c111c9b75729784@redadmin.org>
X-Sender: weibu@redadmin.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit

Hi Greg,

Quick follow-up: after rebasing onto your staging.git `staging-testing`,
the change turned out to be already present and there’s no delta left.
Please ignore this patch; I won’t resend v2.

Thanks,
Akiyoshi

2025-09-15 00:29 に weibu@redadmin.org さんは書きました:
> Hi Greg,
> 
> Thanks for the heads-up. That patch was generated against linux-next
> (next-2025-09-12). I’ll rebase it onto your staging.git 
> `staging-testing`
> branch and resend it as v2.
> 
> Thanks,
> Akiyoshi
> 
> 2025-09-15 00:09 に Greg KH さんは書きました:
>> On Sat, Sep 13, 2025 at 08:24:58PM +0900, Akiyoshi Kurita wrote:
>>> Several function prototypes in rtw_efuse.h contained extra spaces
>>> between the type and variable name of the last argument.
>>> 
>>> Remove these spaces to conform to the kernel coding style.
>>> No functional change is intended.
>>> 
>>> Signed-off-by: Akiyoshi Kurita <weibu@redadmin.org>
>>> ---
>>>  drivers/staging/rtl8723bs/include/rtw_efuse.h | 6 +++---
>>>  1 file changed, 3 insertions(+), 3 deletions(-)
>> 
>> This does not apply to my current tree, what did you make it against?
>> 
>> thanks,
>> 
>> greg k-h

