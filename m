Return-Path: <linux-kernel+bounces-721564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D1FBAFCAE2
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 14:51:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FD8E173E49
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 12:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAFE12DCBF9;
	Tue,  8 Jul 2025 12:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Zl8jawXZ"
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08ACC1C5499
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 12:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751979085; cv=none; b=TODkFG60hktnEOz5J1HnO5UIAc3Ywjl255eFp7o80/YBXLIU1Xz0hfO/q+WjhAAr+mJj6E+2k/hjuMPuBTuz/vCJ9wVjIXlrVveqauITMx6yCucF3R2joYG93PyY0k4Zf/tYh216gUb48WSj/8xnWurW2E/Odp3/EVUaExDhdMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751979085; c=relaxed/simple;
	bh=QOFYPrp8fx065K2ZfqSqKamPxKcxM2CbqK5FTx2WjTg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O7Oj3nTZxdqfy0ZVLkTqJ/hpkJw22IMrDnaGWmA40nSQ/y6lZOdskjaAI3CVk09r6l6A7/EW7srJ3vo3fFHl/voR49PisjjXV0tTOCEnfcYwKxjHbN7U18nJb2obk9Mf5gDwqcEdIXO3WmAirnvcusi3dVL4TFSVyOJ1XFID8NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Zl8jawXZ; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 8 Jul 2025 08:50:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1751979070;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EuWJac7bIMMbrDLP0jqOSz/nHOanSt+qlzS+K+3StRk=;
	b=Zl8jawXZGHb2uwXHn5g/nzkV/spbb+A/yXlqkajRWj+ZZvyEODkFM1MYqp+rLP8Q7HS2Ev
	EteHOIk4f1LgGF2qsw7xV5ZYZ7OF7GCpRdQSO6gNccrV8tAW/p9DVCaqMns9HJaNhulJjY
	7J/dZFsKzygfuxYXyQ6WP5Ykl5vdZEA=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: George Hu <integral@archlinux.org>
Cc: linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 RESEND] bcachefs: use union for bch_compression_opt to
 make encode & decode easier
Message-ID: <c32zfpyool2mpjibvxp4rloegtsqfazuphxz5wqrdmjcnfnc7l@fyc5hjd7pmfo>
References: <20250617070036.10685-1-integral@archlinux.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250617070036.10685-1-integral@archlinux.org>
X-Migadu-Flow: FLOW_OUT

On Tue, Jun 17, 2025 at 03:00:36PM +0800, George Hu wrote:
> Eliminate redundant encode & decode function by using union for
> bch_compression_opt, which reduces code complexity.
> 
> Signed-off-by: George Hu <integral@archlinux.org>

Applied to testing

