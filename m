Return-Path: <linux-kernel+bounces-772975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D32FB299FA
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 08:45:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA2511888CC3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 06:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D79A827604B;
	Mon, 18 Aug 2025 06:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="ha6c0mCf"
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F10427602B;
	Mon, 18 Aug 2025 06:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755499503; cv=none; b=FC9Uc7GIH5L45uJpo5f6zy1SxLfdXQXi3uO6lYyH6NzZ6JA5XyvPT3oVASqsCht1xznYhq3ivkcuvY6q+GpwJK4rLmbI/V8FHTdDfF6CebfXBccgNdgDvyeOaDJi2v+jL8WRTVfRilFU3e3y0YUag5yxfvHw8mRVrWs3m1ooee8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755499503; c=relaxed/simple;
	bh=OQlSCLqwRf7x5rQvC9ykAk0WzQoiF6ynQnh+SrK2/cM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B7IdL6DlMdTTOwRI38GRanAIgbhTopcFreM0aKce2piK1MSYKWu/eZ1hiroOcb98u1nmHF3A6Ep5maIDgyyOz3+BnJenJxO6PRYQdfo/dYPHhHLACUFxg/K0PV1UI1uyIV/NaMZSRDCi4HuL3WOdyD1ydPbwFy/DYWDManv5uD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=ha6c0mCf; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=References:In-Reply-To:Cc:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=t9xBjIliI30mPWf9GfWyoiB27yUA1HKiB2NVq5VzTL8=; b=ha6c0mCfRqn0LPFrTIHubJkANH
	8j0rSB64jsVGW/AiH8UV4ub3RPkq4PngsSEt7j6Lb7EoIFbzhW6qWqaZYtc1LQ+8z0WMmSWxWiuO8
	HZXVRj4yZmi3hTk8HMdJad+1WET0+JZuLzKs/tnPWqJeszs6WX0H6NLneRPowHCmr/EQhOulStDF9
	T76OkMZa+K9f2WXo5NQPg9+CGBE4WH9+RsEweoBZrX6Enesqy0OVzZTnSjx3R+Mnz2vkM5mhSePfd
	sbC3xHLmHUBWttoIh7rYAOZ3JzGBFn05eYdJ3PiUEp1xIoLsoUaPYNJWj7cYA+/z+oeyIi3aIEeby
	qFQtT6SQ==;
Date: Mon, 18 Aug 2025 08:44:48 +0200
From: Andreas Kemnade <andreas@kemnade.info>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Sebastian Reichel <sre@kernel.org>,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 1/2] mfd: bd71828, bd71815 prepare for power-supply
 support
Message-ID: <20250818084448.03b5b331@akair>
In-Reply-To: <6ebcdc8b-0b8e-489b-9f93-ebfd2d850432@gmail.com>
References: <20250816-bd71828-charger-v1-0-71b11bde5c73@kemnade.info>
	<20250816-bd71828-charger-v1-1-71b11bde5c73@kemnade.info>
	<6ebcdc8b-0b8e-489b-9f93-ebfd2d850432@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Matti,

Am Mon, 18 Aug 2025 08:49:27 +0300
schrieb Matti Vaittinen <mazziesaccount@gmail.com>:

> > diff --git a/include/linux/mfd/rohm-generic.h b/include/linux/mfd/rohm-generic.h
> > index 579e8dcfcca41d2680283819684a1014617d0d4b..5e9d0da380ec0fc3245bee998c791a162a34e3fa 100644
> > --- a/include/linux/mfd/rohm-generic.h
> > +++ b/include/linux/mfd/rohm-generic.h
> > @@ -13,9 +13,11 @@ enum rohm_chip_type {
> >   	ROHM_CHIP_TYPE_BD9574,
> >   	ROHM_CHIP_TYPE_BD9576,
> >   	ROHM_CHIP_TYPE_BD71815,
> > +	ROHM_CHIP_TYPE_BD71827,  
> 
> Reading you drop the BD71827 support (which sounds like the right thing 
> to do) - do we still need this?

we do not. It just flipped through in all that harmless devices.

Regards,
Andreas

