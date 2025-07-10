Return-Path: <linux-kernel+bounces-725761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F691B00360
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 15:31:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AF893A4509
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 13:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF0972586EE;
	Thu, 10 Jul 2025 13:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="unknown key version" (0-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b="pyXsQ8kI";
	dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b="Soi8njJ7"
Received: from e2i340.smtp2go.com (e2i340.smtp2go.com [103.2.141.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC87258CDF
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 13:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.2.141.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752154288; cv=none; b=je21m5ytn3uZxLXpUqFpL+8xelNWviQqiyyqIE6iLzvjFUPV1a++Gl7xoVB1Alh/+HRe3UUfh927BrRAs2Pf4HUKsrmB3qdKJ6Gg6dNzMP+H+fT8k9h9Q92NRy1ezC3iabHuuSGzLPN72JAaK2XN/jEz9vwy25iJrYQnqGVLOYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752154288; c=relaxed/simple;
	bh=aGkY5FkpXlRasmX7IkSFUC1z895PdUw3R9nsi4qUscU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kIqdfu87mwnPyFfByh+2OXerX8BRUCe+fB2J8ifwIIk78fHEqBy+BihysY2Mzr3LUoX0pHDgrn1r3qZmF5mLqwE2g5VAnhyRu/1VTZRIBLBlQDyB52cQ6CNwoxR35uGfjY/Pfd6WLn7rCdePXFrd+gSBpXW06l3VGAnPxfIoqcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt; spf=pass smtp.mailfrom=em510616.triplefau.lt; dkim=fail (0-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b=pyXsQ8kI reason="unknown key version"; dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b=Soi8njJ7; arc=none smtp.client-ip=103.2.141.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em510616.triplefau.lt
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=smtpservice.net; s=maxzs0.a1-4.dyn; x=1752155185; h=Feedback-ID:
	X-Smtpcorp-Track:Message-ID:Subject:To:From:Date:Reply-To:Sender:
	List-Unsubscribe:List-Unsubscribe-Post;
	bh=BsR5rXUF8TnVSQ9rfmGhuw/H5eoO2vMI7vkzhS8PYSI=; b=pyXsQ8kIWWZo7xuIf0mA/5pS2B
	ZGDy6xxBByQIi8CPLrno/9QYX263U7LTSdDP8VH3j2ObM6l0anTRFJ91JxTVWUCx6aFHIKPewilUj
	jGjmEsaCAkQbav7/A1fBykW0xogfWcdKrV3VTAqh4GUpREzrxRSAOm8l0O+F91PccikHKAMO4+XT8
	15Fijk9ZQntrZxbOdmcVK7arZs4uNL7UGCXwX0WLj/nPI0i5kvAPllfTPrO5sqdRpxdjErk+brLOH
	YhOKkXIrAhXK24IARvSdITqH1QfqHxsCBSpSSa7Tfx+KLSzU5z9+xaLvhsQrht1nnhItP5JZ9bCzc
	Ws31uHdQ==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=triplefau.lt;
 i=@triplefau.lt; q=dns/txt; s=s510616; t=1752154285; h=from : subject
 : to : message-id : date;
 bh=BsR5rXUF8TnVSQ9rfmGhuw/H5eoO2vMI7vkzhS8PYSI=;
 b=Soi8njJ7RC/Y1BWmQygyM81xuNSHZTp/klZ3uWjJiUMYoKiP0Ad3lkojPtBLbq0CGB4Fx
 bPwzx4XByQvOhiuZ0E5Jhwz56Dl6UoYZI8Oo/Y3ZD5jCoR05n59UEEDvmI5gWLigB5M+88q
 jZ0OY21KacC7knA3VxOTZcxwsQy9O9rSlsMF1/txcWhc/cT/9OHLV309MSWoYzQID5Iyq42
 JxxAuJNdHcWms46GxyowKZOVbXIs3sRG88XaCO0+RlP3vNhHGnsw5UzjKeHR3FfpCu84Byz
 O0LqHHNa2PQItwfus8jdFIVCZltsKp/35bzan+AV5tNjTvDE8HtqFFuthPeg==
Received: from [10.172.233.45] (helo=SmtpCorp) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.94.2-S2G) (envelope-from <repk@triplefau.lt>)
 id 1uZrMh-TRk6GJ-S4; Thu, 10 Jul 2025 13:31:07 +0000
Received: from [10.12.239.196] (helo=localhost) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.98.1-S2G) (envelope-from <repk@triplefau.lt>)
 id 1uZrMh-AIkwcC8oc00-JHJu; Thu, 10 Jul 2025 13:31:07 +0000
Date: Thu, 10 Jul 2025 15:21:08 +0200
From: Remi Pommarel <repk@triplefau.lt>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH wireless-next 0/3] Allow non-MLD sta to roam between MLD
 AP links
Message-ID: <aG--RKqY7RBfkvLR@pilgrim>
References: <cover.1751057146.git.repk@triplefau.lt>
 <4d50e8de5750cd6b915f209b9d3ab26f34efda99.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4d50e8de5750cd6b915f209b9d3ab26f34efda99.camel@sipsolutions.net>
X-Smtpcorp-Track: YIUk9EE3nAFH.rGYknxYEP2UB.GkZX2A0ig8g
Feedback-ID: 510616m:510616apGKSTK:510616sQxsm_LMAk
X-Report-Abuse: Please forward a copy of this message, including all headers,
 to <abuse-report@smtp2go.com>

On Tue, Jul 08, 2025 at 11:00:26AM +0200, Johannes Berg wrote:
> On Fri, 2025-06-27 at 22:46 +0200, Remi Pommarel wrote:
> > 
> > To fix that, the first patch of this serie does not report management
> > frames with a link id (link id == -1) and let hostapd do the freq to
> > link conversion to respond. This relies on the fact that hostapd knows
> > how to do this freq to link conversion which is needed anyway for the
> > first pre-association scan. We can also do this conversion in mac80211
> > instead if it is deem preferrable.
> 
> You should probably send patches as RFC if you have things like that.

Sure. Some subsystems have a tendency to ignore those RFCs patches but
that does not seem to be the case for linux-wireless.

> 
> > This serie along with the mentionned hostapd patch allowes a non-MLD
> > STA to successfully roam between several MLD AP links with hwsim.
> 
> Maybe so, but does anything _else_ MLO related still work? Surely it
> cannot, given you just unconditionally made it no longer have a link ID
> ... And indeed most of the EHT hwsim tests no longer pass, and even
> crash the kernel.
> 
> Since you clearly were running hwsim tests, please run the existing ones
> too :)

Agh, sorry about that. I was not running the hostapd's hwsim tests
because I just discovered they exist. With the mentionned hostapd
patch most of them pass, but yes of course, let's not break old
wpa_supplicant/hostapd with kernel changes.

Doing freq to link id conversion instead makes all eht test to pass (I
will of course also add a hwsim test for this specific issue).

> 
> Also, I suspect that https://lore.kernel.org/linux-
> wireless/20250630084119.3583593-1-quic_sarishar@quicinc.com/ might go
> some way towards fixing this as well?

No I am afraid this one won't help.

The issue here is receiving off channel management frames and using the
link id the sta is currently associated with to report them to userland.
For example if sta is associated with link 0 and send a probe request on
link 1 (off channel scan), this frame should be reported to hostapd with
either no link id or a link id of 1.

Thanks

-- 
Remi

