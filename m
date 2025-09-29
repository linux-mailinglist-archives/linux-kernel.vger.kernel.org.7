Return-Path: <linux-kernel+bounces-836465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD91FBA9C51
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 17:15:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E12E01891347
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 15:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75379309DD2;
	Mon, 29 Sep 2025 15:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bit-el.eu header.i=@bit-el.eu header.b="f2bsnJc5"
Received: from smtp.domeneshop.no (smtp.domeneshop.no [194.63.252.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988EE1D88B4
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 15:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.63.252.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759158923; cv=none; b=PrFB91LAOPMeL8m7jnVUPCy+AXMZdOXNHX3AdcM5nvaERfrjMS5L9o7DaTlJgw0AzFrBi7pr9a3Q5RahWdsyPQ6uJOA/j9sX9V9iEOVoyPNcSGo+ZQQwf/gsNsc7nACh+V/nce+APFvn/YPu0uycuN9CXK+6rUClPbnRjpOyzZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759158923; c=relaxed/simple;
	bh=gCoNGgbht8I90OOPt6iYyU5PLv2/ljTkg754r18wUWE=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=UAXBIQ726g3IqQvAY7omJHa3S6Li/J+Ryf+P3y2kcuE+z8gQmj/DQ3xYmGHIFK369FKtb5jTfS6/PTsq7lMGi/EN/srgx9LLRbKjLbdWwSOVnHxmTwjHyFM+xzXp1+vH4oz8Xr9o3fMxPiaP9HARX0VAsCOpH7mCoOTzG8a5yqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bit-el.eu; spf=pass smtp.mailfrom=bit-el.eu; dkim=pass (2048-bit key) header.d=bit-el.eu header.i=@bit-el.eu header.b=f2bsnJc5; arc=none smtp.client-ip=194.63.252.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bit-el.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bit-el.eu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bit-el.eu;
	s=ds202509; h=Content-Transfer-Encoding:Content-Type:Subject:From:To:
	MIME-Version:Date:Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:
	Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=gCoNGgbht8I90OOPt6iYyU5PLv2/ljTkg754r18wUWE=; b=f2bsnJc554MgjIg9KjPXGOUdyI
	5D/pORcZnF+N0nPEjelqhJS/O7KpqcWETE5+qZAWLN4QQAnfbiV6a9qEDSTCim5m25OXxqnUNYKHb
	PVFgXC0niOKYnMH+wmPvHOTm8ELohWYO7HU3TtdY1lk8rmCQZDfBtDCDB8jV8Zl4w/eWpESR311NH
	2WVTP7+rsSlKr/MuE4yubLhcbRK/wGvSyw0VHHG8P/bpwISI0rCrkc+bltv1FmNxGJSX3MglvC8ho
	Lj8qWzzbRxIpAMHKEXPWZ9AWNcAlpO0w2J7uvMpZGDLJ+anAZAtWike1hxWBxiarki7hyem/zvvT0
	11sfZYqQ==;
Received: from smtp
	by smtp.domeneshop.no with esmtpsa (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	id 1v3Fas-00AswK-9V
	for linux-kernel@vger.kernel.org;
	Mon, 29 Sep 2025 17:15:14 +0200
Message-ID: <771bafe3-ddba-4ea3-aa1f-761b9e01962e@bit-el.eu>
Date: Mon, 29 Sep 2025 17:15:14 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-kernel@vger.kernel.org
From: =?UTF-8?Q?Ywe_C=C3=A6rlyn?= <Budi@bit-el.eu>
Subject: Bit not Bug (was Unification in Bitstreams System,. Fair Pay
 Philosophy, Low JItter)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Many things are based on my work in Open Source.

Now another: Bug!

This complements the Bit perfectly.

Bit not Bug is a good phrase, for doing Bitstreams System.

I am now using this!

Light,
Ywe Cærlyn
Budi, Bit not Bug Hackers.


