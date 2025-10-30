Return-Path: <linux-kernel+bounces-879283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24B8FC22BCA
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 00:46:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D84E3B5CDE
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 23:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 183BF33E377;
	Thu, 30 Oct 2025 23:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ZJXolIxN"
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3695333E360
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 23:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761867841; cv=none; b=FeFSMQywcF9A5Ooemkrz8/fP1ojBXv7q+So54mHBQH/Vb4Dfhtayite0VKF+xmAJjQxYYA0kqYfvmOnguhFIlEsmXYUs3ml45SKnU710P0uqzj9VLa/SS71It+MYulLYqMwujvCgbqQauwIPXJayS2zDwvFk3Bsep7ur1diURRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761867841; c=relaxed/simple;
	bh=sfXUb0zQLHRdVgpDwmAMmTjlkR9si9zD62LTECO0l+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hZ9iHkYSUS5pRQIk2LjLZ/R1ZRxpSkFrpoGzhqByy5X3eqI6y6hXrxeE0eVSaIXeNzT22/0hG5+grPl2KQhVKxCdaTeeWVreycfqFOETQHYaUYYvqEpHoTgBrFhr1hC21xT5V884nbxziX/ZzgCd+oFYNxyyBHfEilvNX+N/qZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ZJXolIxN; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 6706A4E41406;
	Thu, 30 Oct 2025 23:43:56 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 3720560331;
	Thu, 30 Oct 2025 23:43:56 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 77C5D1180CD97;
	Fri, 31 Oct 2025 00:43:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761867835; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=qvxEnhZb6oDPTVmo+kM1osfS4tfXtLekEB3w4t8Vy7o=;
	b=ZJXolIxN8r/swzcYwB9QjHmVjIjk5u1keTmpiV/nlGeVAMyxYnoxwl8M7SAnfqdlbV/wiu
	MYv0oHdYuq+S55XaMBPQS7OsgBEQ3oOo30HMBz7pxLnq0gGsqUWrkuNt2DwBOFio+NzN/9
	1HOJo/ifDgmMAGjK51Fq+b2fHEoWWKxBE7vnno9hCVjKOeoj5QGKcNusg+dVK3KTDVu/PP
	T36qtEDUgOR392RICvI7tXwJiml1HqWzVzWOWqdSDxpMjBgIRdOHfYUTayLkplqIPu+1pA
	du2urNzAeAEADzpvYeMN0xHHLKbj8j9GdtsLBF1eL7v3JGIkn5/3a1F94i1NnQ==
Date: Fri, 31 Oct 2025 00:43:53 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: frank.li@nxp.com, miquel.raynal@bootlin.com,
	linux-i3c@lists.infradead.org,
	Stanley Chu <stanley.chuys@gmail.com>
Cc: linux-kernel@vger.kernel.org, tomer.maimon@nuvoton.com,
	kwliu@nuvoton.com, yschu@nuvoton.com
Subject: Re: [PATCH v2 1/1] i3c: master: svc: Prevent incomplete IBI
 transaction
Message-ID: <176186765080.475593.4340016806079643013.b4-ty@bootlin.com>
References: <20251027034715.708243-1-yschu@nuvoton.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251027034715.708243-1-yschu@nuvoton.com>
X-Last-TLS-Session-Version: TLSv1.3

On Mon, 27 Oct 2025 11:47:15 +0800, Stanley Chu wrote:
> If no free IBI slot is available, svc_i3c_master_handle_ibi returns
> immediately. This causes the STOP condition to be missed because the
> EmitStop request is sent when the transfer is not complete. To resolve
> this, svc_i3c_master_handle_ibi must wait for the transfer to complete
> before returning.
> 
> 
> [...]

Applied, thanks!

[1/1] i3c: master: svc: Prevent incomplete IBI transaction
      https://git.kernel.org/abelloni/c/3a36273e5a07

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

