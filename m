Return-Path: <linux-kernel+bounces-889909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 90C1DC3ECF5
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 08:47:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E11064EBB19
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 07:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0193C2571C5;
	Fri,  7 Nov 2025 07:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="k+bClqF4"
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3F8262FC0
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 07:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762501612; cv=none; b=J1dtiCYrz22tzF1SPeLrb9S5dWkESw6JKKiT6dfrPpOEm9rR9rz1rJWXqjr/S8drH5cWXYX7T7dgMPj2wi4KsytArftui1xlGSc5dmnASD+KoORUUJHIBfGFhmA9PgtUmrOfUMrSGkzO5zLrnhDRG276ySHinQzVNA6GmPTGUOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762501612; c=relaxed/simple;
	bh=up3WN4y2iaAHVkgmKOuF19xMqSjPj8hRQ0/2Guibtpo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ubfvnFRNVFzxYyI6sFV5d6I6rXSSywRNm9OpcVuD2AIegXsONokf8e6deWbhSILdn6jPBiK2f55ecUp6dLZn8AwRaHXGU919kCRnSHJxMKuBNvleZH7Y95iOm9ieafP9bGEVLlqSObkgv3V/fcjwt5OCjvHBRgfd4uYaj8LEuLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=k+bClqF4; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 7 Nov 2025 15:46:40 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762501607;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bWV3OFRTCNAKsBedYT67BomPXMjaLCiUco2GhaTf0fw=;
	b=k+bClqF4XA4GZLSsMVcC4JpBztPM6DaIwF+4+MhuR0v+m0IO2O9SigAjsrr2iZzzDfgEtI
	4/4nozJFfpBwrLrYCWO/kTQe007F3NCPNYKHGUMFN8tKGpHg3HFVdcftKPD6uUxYkTZm0u
	qklEY0aV3aO/4Z1KU5PuZoGxTlcsStQ=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Troy Mitchell <troy.mitchell@linux.dev>
To: dongxuyang@eswincomputing.com, mturquette@baylibre.com,
	sboyd@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: ningyu@eswincomputing.com, linmin@eswincomputing.com,
	huangyifeng@eswincomputing.com, pinkesh.vaghela@einfochips.com,
	Conor Dooley <conor.dooley@microchip.com>,
	Troy Mitchell <troy.mitchell@linux.dev>
Subject: Re: [PATCH v7 1/2] dt-bindings: clock: eswin: Documentation for
 eic7700 SoC
Message-ID: <aQ2j4PtWm5vFBoAZ@kernel.org>
References: <20251023071658.455-1-dongxuyang@eswincomputing.com>
 <20251023071748.513-1-dongxuyang@eswincomputing.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251023071748.513-1-dongxuyang@eswincomputing.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Oct 23, 2025 at 03:17:48PM +0800, dongxuyang@eswincomputing.com wrote:
> From: Xuyang Dong <dongxuyang@eswincomputing.com>
> 
> Add device tree binding documentation for the ESWIN eic7700
> clock controller module.
> 
> Signed-off-by: Yifeng Huang <huangyifeng@eswincomputing.com>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Xuyang Dong <dongxuyang@eswincomputing.com>
LGTM. But as Krzysztof mentioned, it might not be on the
priority review list.

Acked-by: Troy Mitchell <troy.mitchell@linux.dev>

