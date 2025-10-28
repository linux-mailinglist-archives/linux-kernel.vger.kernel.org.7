Return-Path: <linux-kernel+bounces-873510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E06CC14177
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 11:25:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FCB31982959
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 10:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BBC2302158;
	Tue, 28 Oct 2025 10:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="BS3ygGzm"
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E841D2620DE
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 10:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761647129; cv=none; b=oyPlU8tlb2ckscwNOiZRNVOndou6sY1CnFAdG4FqyJ3brdWxyWuMbO92sx8TJMlQeObx537EEo/Gazqn2vD+g/KaEl7Jt2vdJI4O3/k0fDLvS+UYRhx6f120GsXRLHmrwOvnubP274d1FZhPWOw4NkHIBnvsrMJtA5J/wAZg1Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761647129; c=relaxed/simple;
	bh=vpnZOflEafx5pUZuzJOkCnbNldhDh1oeW3mXtlKrwzY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ptd9+LOfpCUhBFmzjcQ1cZhlk9fDVu/JTsfYec9AH7sXD0X2phKfEcHjSyLP89S9q15hpqmcIzThuwSM5po1AVNy9lr71HMJRI1A7HeUMoHsH7WQDW0gz63qjTMXd6wbavqi4+Erw5Qs3YOV23U05YYrzpnKvIamaC+V3FddwfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=BS3ygGzm; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 299894E41393;
	Tue, 28 Oct 2025 10:25:26 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id DDE5B606AB;
	Tue, 28 Oct 2025 10:25:25 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 46D811179BD50;
	Tue, 28 Oct 2025 11:25:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761647125; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=vpnZOflEafx5pUZuzJOkCnbNldhDh1oeW3mXtlKrwzY=;
	b=BS3ygGzmNaMVmAsorukSGkU4Nvr25aMU+QmW6pKQEz+N8ORj81L09uGENntmwRddIM0vse
	2K/45R78iognBwgkmETcGfU6Yvo8Z9oh/BeH1WMYbzWoTah/s/2SZkDcMo3wLlEsEbqLdO
	8GUAKedqQY6mOAGAm/AAn4GGDJwLk0qHqNQCWmF/aWlCGCCoR+42/Vf0CWj2319L9dbI9N
	a7ME+E9rEiWXlrmN1WQb4Sk09qe/xJeLcYo3aubUjqbepa/8m3kjSobg6khla3i4ts1QH8
	bE5oER78e3REUCxKFufYYP1z9/dQIP+owtNlEKXacX2HRxNlAeu8X1Hg+kVtWA==
Message-ID: <d2bb7d0c-14bf-4421-912b-f9dada1fb847@bootlin.com>
Date: Tue, 28 Oct 2025 11:25:13 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] mux: mmio: Add suspend and resume support
To: Peter Rosin <peda@axentia.se>, gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org, gregory.clement@bootlin.com,
 richard.genoud@bootlin.com, u-kumar1@ti.com,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Andrew Davis <afd@ti.com>
References: <20251013-mux-mmio-resume-support-v5-1-de9467ceb2b2@bootlin.com>
Content-Language: en-US
From: Thomas Richard <thomas.richard@bootlin.com>
In-Reply-To: <20251013-mux-mmio-resume-support-v5-1-de9467ceb2b2@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Peter, Greg,

On 10/13/25 3:04 PM, Thomas Richard (TI.com) wrote:
> The status of each mux is read during suspend and stored in the private
> memory of the mux_chip.
> Then the state is restored during the resume.

Is there any chance to get this patch merged ?
Or maybe it is not okay for you ?

Best Regards,
Thomas


