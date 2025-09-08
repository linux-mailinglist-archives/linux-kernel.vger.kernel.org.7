Return-Path: <linux-kernel+bounces-806930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48984B49D8F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 01:39:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05D734E5AD7
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 23:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AE7A2FB093;
	Mon,  8 Sep 2025 23:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="VXVBtK6m"
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E841B87E8;
	Mon,  8 Sep 2025 23:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757374763; cv=none; b=QTkELTmBIlTxo0j36i95CdGoU0q6Y1iE4OBnYPO2saEM7GrAAGw+2Mjr4Aww7bsiaX+5X2DH3gMu0NlF7lU9+E/HUO/n7NU4HMlJI1nSqXFTHmd6cGc26Dg98kJc+QnhgnrchL2M8QKztFPaIxjCbmiyTkt3/2USFcHQsMU69Yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757374763; c=relaxed/simple;
	bh=Q03Q1QdCh+FVjubFdk49psMRgmBtn6TP8GD5Q0vmpcY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RDTY5D3TUiU32EDGlECwK+O/pG/8BGEXmQLE8uYd8m/bYvC3eNaaufarxb804jA8UwbBAWxdscftQlNkfMhPQeSZQnQv/6XQFo+QkhzvuuVMb8mze+Pzd+ttq+9hGsMEPbgiEaJmyGjIyIHlH5Nr4W9AxPf1c2XhRqr0+Ez+eoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=VXVBtK6m; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4cLNhP5g1xz9stK;
	Tue,  9 Sep 2025 01:39:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1757374757;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S6loKHnERR6UQJlGUtEQ3+3fogYBwTr8txF5Ji+qXuY=;
	b=VXVBtK6mXUfaVqVUbAwXZk4vf3gBlosdFyQkADIFM7YPJD0BuXmyZtLP/gWnX49fLxLWmS
	TvYWCqgevy3ANpxrGU1FuxPOfB02fv2PcckuuSfUtHsLqy9xmmdMFbY2v1e2Y98GOYUcGk
	FbBB/kiOVrj+Jre+jYhGFch8aPLgcRrNCtjGRIsS8zWOzLYfw+RXT/fR+Z2rPBB3LZgcCC
	S5QjAAzduh1mysaLLq6zphP+oa8kVMEVSASePJ+YwGA6tHUG2Qso8V+KUEMHf4/fQ1VLE1
	N6sG0fUjP+5898B4FVmylOx1Jm6DnKBsCiFnCRkwZyEz8ZUrVap7cZC/z8lbOA==
Message-ID: <afe58aa6-0c3e-4508-8133-8e7621a0484a@mailbox.org>
Date: Tue, 9 Sep 2025 01:39:13 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v1] dts: arm64: freescale: move imx9*-clock.h
 imx9*-power.h into dt-bindings
To: Peng Fan <peng.fan@oss.nxp.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Abel Vesa <abelvesa@kernel.org>,
 Peng Fan <peng.fan@nxp.com>, Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
 E Shattow <e@freeshell.de>
References: <20250831200516.522179-1-e@freeshell.de>
 <20250901032203.GA393@nxa18884-linux.ap.freescale.net>
 <3a165d77-3e36-4c0d-a193-aa9b27e0d523@mailbox.org>
 <05f7d69a-9c05-4b47-ab04-594c37e975eb@kernel.org>
 <51daddc4-1b86-4688-98cb-ef0f041d4126@mailbox.org>
 <8920d24b-e796-4b02-b43b-8a5deed3e8fb@kernel.org>
 <be2fc937-b7a6-49a7-b57d-6e3f16f4ccc3@mailbox.org>
 <20250904093442.GA13411@nxa18884-linux.ap.freescale.net>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20250904093442.GA13411@nxa18884-linux.ap.freescale.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: 6pky7gdj4zuqu4e5ou56mtyfkp7ssjjh
X-MBO-RS-ID: fbc66ab64366b5ef5dd

On 9/4/25 11:34 AM, Peng Fan wrote:

Hi,

sorry for my late reply.

>> Instead of playing this "I found this code somewhere, so I can do
>>> whatever the same" answer the first implied question - why these are
>>> bindings? Provide arguments what do they bind.
>>
>> I am not sure how to answer this, but what I can write is, that if I scramble
>> these IDs in either the DT or the firmware (which provides the SCMI clock
>> service), then the system cannot work. I am not sure if this is the answer
>> you are looking for.
> 
> Marek,
>    Some U-Boot code indeed directly use the IDs to configure the clock without
>    relying on any drivers. Since the SCMI IDs could not be moved to dt-bindings,

Why can they not be moved to DT bindings ?

They are part of the ABI.

This is the part I do not understand, the SCMI IDs are no different than 
any other clock IDs used in DT, is that not so ?

>    the possible method to do in U-Boot is to duplicate a copy of the file,

No.

