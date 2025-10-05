Return-Path: <linux-kernel+bounces-842449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED2A6BBCC0E
	for <lists+linux-kernel@lfdr.de>; Sun, 05 Oct 2025 22:51:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A705A3B7FCA
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Oct 2025 20:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB5C41E412A;
	Sun,  5 Oct 2025 20:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="M19/OUmP"
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 434E71C9DE5
	for <linux-kernel@vger.kernel.org>; Sun,  5 Oct 2025 20:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759697506; cv=none; b=QKGyL8UcHiJRJHE/tIXJ/HAZc828vAnkm/UC7f8HCVGK4dUbZ/mkh9Gz/AuuQCJT57gjRNcRK88jndkSFAKUGKbvlKaRa7mrzkUjJk8ZRAB5auGlyKaAo1lJMgOj5n2oErrzxX8cJiLIJTwz4oclTf0NTVyeHG7z8kKNFbX6j+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759697506; c=relaxed/simple;
	bh=r+vKGYdrZRvVf2P0GDZt8T2Uvu1SoZaw2nypKR7w/js=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eisV+r5pZCG+2ilqkEIq86GvkLDoezucpHxqV9JIpL9eFu5xBUsQXduuKQkiX415xA3TOI4NNlPyWL8IJY6TyafypAKt//iPoM6jlJqyvNwW3aZjTIVNELlEOk6xVcTPhz0D/7C7wYopsh0BHBo1KpCl37nJO6o4VLwCPnLSiKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=M19/OUmP; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 98EC04E40EEA;
	Sun,  5 Oct 2025 20:51:41 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 681436065F;
	Sun,  5 Oct 2025 20:51:41 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A75A5102F1D0B;
	Sun,  5 Oct 2025 22:51:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1759697501; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=mu1tmBGNqYigMr52Y0gPpBtQh9KcecuwSGzGQQs95D8=;
	b=M19/OUmPz33S3Nsb2OQMbqihXLs02UOvQvq8Hm1BgjkXaWAQ8mZtEVQ4N4fRTp+yKnwtua
	sRqJZP3klksYPFE79d0PQN7naaGAPBXnjzHz3mG61vJUg0i7omvECN1ycR5Lb7qDEWR5Vl
	CqlcOmRjz5ffvZFOEwCIKKdG+iUG6Rxr5jfoRj2pRkIbNFcge82tO6ByFC0ePytOA6J0cJ
	PZVL70I5dr14YCTOZDx/2wK8DFfZkD0qe2/VuoH64OTF/iBIbql+Q+8UzblbP4/k8AEZdf
	I3/ZAsLeFwjS/8AXIGDbu4Q6yOPnHrymMtc3IjJNSoiQ1LRQGUIvVG2k91ziSw==
Date: Sun, 5 Oct 2025 22:51:40 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: =?iso-8859-1?Q?T=F3th_J=E1nos?= <gomba007@gmail.com>
Cc: linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rtc: sd2405al: Add I2C address.
Message-ID: <175969748507.3763428.11523548979589755615.b4-ty@bootlin.com>
References: <20250407-rtc-sd2405al-i2c-addr-v1-1-efdd951952c0@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250407-rtc-sd2405al-i2c-addr-v1-1-efdd951952c0@gmail.com>
X-Last-TLS-Session-Version: TLSv1.3

On Mon, 07 Apr 2025 13:48:49 +0200, Tóth János wrote:
> It is common to include the I2C address of the device in the source
> file.
> 
> 

Applied, thanks!

[1/1] rtc: sd2405al: Add I2C address.
      https://git.kernel.org/abelloni/c/75b002a38d4f

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

