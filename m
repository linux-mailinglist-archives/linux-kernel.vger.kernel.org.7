Return-Path: <linux-kernel+bounces-894580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E22E2C4B599
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 04:39:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FE841891980
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 03:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BEA53491D6;
	Tue, 11 Nov 2025 03:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iUGFXxSv"
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 604452F25F6
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 03:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762832335; cv=none; b=JZehyxoXzAa9Zfu25Gmb3ypJpxlvwEyojicryr/t1h54DFyBd9RTOUNPHOadamht9GtddiDhppZrKcIk4f6GCKs0ZhAJT5r/EvT3fmQgyLXxHC0bQv66Nud8nTGTHyQ73UUw64XkpEq2jxSuB8c3ghgKsTz+lmpHY2QNQwcBYKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762832335; c=relaxed/simple;
	bh=gqOCwtPQTZk3jpEdvZKI2Jr/kO5EH71V9WA5lAbRAuw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cU5WNachVTict2IN5ojvdzOGkbKxwmZUnR08haCLV3AGpPm4yuYqWC7pvMJzriTJQcWxHigd5FzsPpxZqvsEu9AYosAvETfFXjEXLpyQlKeAJTa3xU/xOF0yngYo0E3W/v66dljMq6MHoTWUhYj4a210uqjbN09W/Xz8DfT8XyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iUGFXxSv; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 11 Nov 2025 11:38:40 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762832331;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ksG87ws8ce649q0qBeX08n/5lShn7Ts8Rh+qqZIQlp4=;
	b=iUGFXxSvrGhyXJ0fgGLbylsJnJG9VaprjBi/297+63xAZqLtvM1oVmxkUHFZgv85Dw5LCy
	NBENUVQcAo6G7lrseU9rT0S/ZNi/BH5LtWCQT4w5WkkmkAxdy4pdIypJAqPrKPR+6/XVZp
	bJNPzjlOLF49UIltRIC5ZTD6ok2FS1w=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Troy Mitchell <troy.mitchell@linux.dev>
To: Xuyang Dong <dongxuyang@eswincomputing.com>,
	Troy Mitchell <troy.mitchell@linux.dev>, mturquette@baylibre.com,
	sboyd@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, bmasney@redhat.com, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: ningyu@eswincomputing.com, linmin@eswincomputing.com,
	huangyifeng@eswincomputing.com, pinkesh.vaghela@einfochips.com
Subject: Re: Re: [PATCH v7 2/2] clock: eswin: Add eic7700 clock driver
Message-ID: <aRKvwL-puEquiIOh@kernel.org>
References: <20251023071658.455-1-dongxuyang@eswincomputing.com>
 <20251023071814.568-1-dongxuyang@eswincomputing.com>
 <aQ2jbf2k3rwOZDuB@kernel.org>
 <74be57c4.45.19a7080fca1.Coremail.dongxuyang@eswincomputing.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <74be57c4.45.19a7080fca1.Coremail.dongxuyang@eswincomputing.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Nov 11, 2025 at 09:21:32AM +0800, Xuyang Dong wrote:
> Hi Troy,
> 
> The link [1] provides the official documentation for the EIC7700. 
> Section 3.2 covers the clock subsystem, where you can find detailed 
> information about the clock-tree.
Much clearer now. I suggest putting this link directly in the cover-letter
in the next version.
> 
> [1] https://www.sifive.com/document-file/eic7700x-datasheet
Thanks for your link.

                                  - Troy
> 
> Regards,
> Xuyang Dong

