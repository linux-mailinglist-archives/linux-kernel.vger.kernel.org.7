Return-Path: <linux-kernel+bounces-885383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9AEEC32BE5
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 20:14:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 978EC3BB698
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 19:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8E6133F8C0;
	Tue,  4 Nov 2025 19:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LOrJwED+"
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B69133B962
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 19:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762283673; cv=none; b=cx4lRE++9cYw/AmEjtJpJji7PL2xPmObHmCitFrFfl/N0p8XzK9UcsporV07a1UHjCObxsrG7Q5DKskVxpTckx3ZjLUfdaeC9i+uxhBKN6KDNRxmxs33SVs2quMXBo32wClKjfpiVgBn+5O5HFu+jogo2JOdvymEW1GjRik/k7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762283673; c=relaxed/simple;
	bh=4HphiyOJB+DGoDMwRatATOHhn0V8FfMVXm7yAAKfASk=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=MxMKyBBTaXGRx+aNvQ7OzNjJEwnHCF6+6g1k68Zzo9vERucKCY3W1uXmXYaMcGa635w6pIq8wPAZP2fLnFfCykSrHrVxkNye3auA1ArY12KXuqQ3SG/sf+jY0MG16k4gQsCP2x+fXjsTo+v5sm9B/DBZWfAk6gLbAzXiOS1NXXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LOrJwED+; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762283658;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=teUzLVutU2wEhi59c9nxHdIb4v8e+TJnHcVw62s8I4k=;
	b=LOrJwED+by6PaVmR6+mElAE24+06UeYmxMy6FW9HRr/lBGFCCN4d9JewdNyIx3LzcDY31+
	2KT49ba5vSlJ0mSDqnMGFY3pQrWFW4nxu0QGnocPATKbAYVrN6Jgc44injtQN8CGggyrVk
	RCEe+2Y3X4xBv8FPl8hwLEqgqnx7nNw=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH] x86/sgx: Fix typos and formatting in function comments
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
In-Reply-To: <717cb54f7ac6dd1f94a5c57c10a8cb377eb199bd.camel@intel.com>
Date: Tue, 4 Nov 2025 20:13:43 +0100
Cc: "jarkko@kernel.org" <jarkko@kernel.org>,
 "x86@kernel.org" <x86@kernel.org>,
 "bp@alien8.de" <bp@alien8.de>,
 "hpa@zytor.com" <hpa@zytor.com>,
 "mingo@redhat.com" <mingo@redhat.com>,
 "tglx@linutronix.de" <tglx@linutronix.de>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <71675CA4-D76B-4B81-B71B-8C2B79AAAC3C@linux.dev>
References: <20251103090103.1415-2-thorsten.blum@linux.dev>
 <717cb54f7ac6dd1f94a5c57c10a8cb377eb199bd.camel@intel.com>
To: "Huang, Kai" <kai.huang@intel.com>
X-Migadu-Flow: FLOW_OUT

On 4. Nov 2025, at 00:47, Huang, Kai wrote:
> It seems we don't have a consistent way of describing return values in =
the
> k-doc comments in sgx/main.c.  E.g.,
>=20
> /**
> * sgx_unmark_page_reclaimable() - Remove a page from the reclaim list
>=20
> ...
>=20
> * Return:
> *   0 on success,
> *   -EBUSY if the page is in the process of being reclaimed
> */
>=20
>=20
> /**
> * sgx_alloc_epc_page() - Allocate an EPC page
>=20
> ...
>=20
> * Return:
> *   an EPC page,
> *   -errno on error
> */
>=20
> Perhaps we should make them consistent in format.
>=20
> But I think this can be done separately from fixing the typos.  Maybe =
you=20
> can split out the typo fixing as a separate patch, and have another =
patch to
> fixing the return value description?

I used the style mostly found in main.c and ioctl.c - would that be the
"correct" format for the others as well? Happy to submit a separate
patch if it's worth it.

Thanks,
Thorsten


