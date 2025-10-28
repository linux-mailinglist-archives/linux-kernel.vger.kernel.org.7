Return-Path: <linux-kernel+bounces-873269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 634B4C138C1
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 09:30:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9C0A44F4440
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 08:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B55A02D73A1;
	Tue, 28 Oct 2025 08:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="xqYXaRHW"
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18887221F20
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 08:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761640040; cv=none; b=HGhdDrWrMB6J6IDDeR80siddcloYlgHgvuwHtMUnTkTgCPGmERyRqeozafiY/TXc88tlIJ+ayCC0DMLkTcEdH2N1Ce7J1injNoCbFHOIGiR5RSkmTAB4YyagmyYTjAjlH+VYkFnaI/vJHOWPCv3GMZ5zeMB8jTi7Y3pGfVkuIAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761640040; c=relaxed/simple;
	bh=lcDPwhI4X4O0peklMvAXteLSRXQvq8rc96Y4feNDRn0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gajgrqVeJOuEgXFm+8fpLyWE7uwmqMS7dteJ5SEYZaY1O+apwXFyWx3gi76TCBPlDjorlRv4C5y1pFlLM6e5+oG83bcou82F2Ik0Se1y+wHK3Qc1euzsCeAAub3o+HFnMgGuaAyJXebkj3L7gE1ML5gRI2KkUE8ydpoSkKt5IJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=xqYXaRHW; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 5B9DD1A16F7;
	Tue, 28 Oct 2025 08:27:14 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 3250F606AB;
	Tue, 28 Oct 2025 08:27:14 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 05C29102F2514;
	Tue, 28 Oct 2025 09:27:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761640033; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=lcDPwhI4X4O0peklMvAXteLSRXQvq8rc96Y4feNDRn0=;
	b=xqYXaRHWkaeTfZKskE3O6LOyNz59C+Ey7wzDspyRSDl6ZHTxyjClu9UlvsEl6Nwj05Zcu9
	cH5MBEed7+sXxT2IiJfb/l7bqEfkeT8UEwt5byU9jlr83+KBjPGGFReXae9rIPCnn3qaM+
	t9nvDwx8Nv8I/pNdoCHdqrCrGF4KStgyyDi62ONLkGAbo18uzjSuhrXosN7ZWFdu76HiK9
	cR2njlCPvBxVyq6x/jOBGsQ68z/+LwVCvInGGyKzFGlu6gSiG/XKplPfpjkg/IVQ1/AhME
	gA7FfeJKlG/6i1BdzZyM6eQkYUCiR41YxCYYCOIqSkWhwwnnkiD/Z3dVfXjx6A==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Frank Li <Frank.li@nxp.com>
Cc: Stanley Chu <stanley.chuys@gmail.com>,  alexandre.belloni@bootlin.com,
  linux-i3c@lists.infradead.org,  linux-kernel@vger.kernel.org,
  tomer.maimon@nuvoton.com,  kwliu@nuvoton.com,  yschu@nuvoton.com
Subject: Re: [PATCH v2 1/1] i3c: master: svc: Prevent incomplete IBI
 transaction
In-Reply-To: <aP/ezI2mTDo5hig7@lizhi-Precision-Tower-5810> (Frank Li's message
	of "Mon, 27 Oct 2025 17:06:20 -0400")
References: <20251027034715.708243-1-yschu@nuvoton.com>
	<aP/ezI2mTDo5hig7@lizhi-Precision-Tower-5810>
User-Agent: mu4e 1.12.7; emacs 30.2
Date: Tue, 28 Oct 2025 09:27:10 +0100
Message-ID: <874irjwhwh.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

Hello,

On 27/10/2025 at 17:06:20 -04, Frank Li <Frank.li@nxp.com> wrote:

> On Mon, Oct 27, 2025 at 11:47:15AM +0800, Stanley Chu wrote:
>> From: Stanley Chu <yschu@nuvoton.com>
>>
>> If no free IBI slot is available, svc_i3c_master_handle_ibi returns
>> immediately. This causes the STOP condition to be missed because the
>> EmitStop request is sent when the transfer is not complete. To resolve
>> this, svc_i3c_master_handle_ibi must wait for the transfer to complete
>> before returning.
>>
>> Fixes: dd3c52846d59 ("i3c: master: svc: Add Silvaco I3C master driver")
>> Signed-off-by: Stanley Chu <yschu@nuvoton.com>
>> ---
>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks,
Miqu=C3=A8l

