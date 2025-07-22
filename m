Return-Path: <linux-kernel+bounces-741298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C79D2B0E28A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 19:24:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E71473B76E0
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 17:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EE2C27FB16;
	Tue, 22 Jul 2025 17:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="eTb0juXG"
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D3DD27EFF7
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 17:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753205062; cv=none; b=LZDgg+LTMPj14IHfxYYzE/MqaOskx9jkz5PzrSVEkwGNzRl2tB8Ti/rVR38mLl3uQYu7l8aAwGnp1Dvaj5LGV0l4UDyM4b/owbOdTJ+xM5M4S+5XGIN6KYKPUjiDEsOg6ZzJGA25tShJJtAxQptpp6bHCvXAE638L0lC/5T6k1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753205062; c=relaxed/simple;
	bh=gemG5XdIWo8Z1eAMmrs7Z9IQB2iDErAEEL3wAyDHimo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hcoGUrFo1x8FJuqiAYufhowSFRsXP5Vv2f7kBlRVoQ/3+aZBQ6p0OxRuoMGu8n2gJulFbjL9ylVy6HPwjIIB0AbdjePIKpy3r2Jb5mADZpH6u28Z8VDTQG23SCMYX1+Gn8VEUwrZMdL7F6pI0+5RU+ByGzQZfVi1SLTyaOoIXEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=eTb0juXG; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 22 Jul 2025 13:24:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753205056;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Q//YOtUY8g12wy14pHQG1qeeIrHLNrzTQdAwi8fa3ec=;
	b=eTb0juXG7LxiMee5K5mOhjcvKpo2O4M4feytC8VJettHc3Z+BcpZJSJilLh0hOFCOljxab
	5RkYxzZJp5jhS1O6a4JKFF0KanQ6xnIk9IpTRNyGiWH5zM6v9Gzziw3pXb15s4J+i3/2mS
	GAZpbmDmutH+YTiT+Mk6Xy1rP8snqT0=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Parav Pandit <parav@nvidia.com>, Petr Mladek <pmladek@suse.com>
Cc: syzbot+622acb507894a48b2ce9@syzkaller.appspotmail.com, 
	linux-kernel@vger.kernel.org
Subject: Re: syzbot -  possible deadlock in console_lock_spinning_enable
Message-ID: <feqgte34le3igwa43l4si5gmlct64ibjvjbd3vr44jggktk25b@csf4dnpz5dkx>
References: <6v5z7ckfff46tbrjmeupaiwm2pm23yuvbrmy6kbe6tq2vl5e42@3cew7z6fgpye>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6v5z7ckfff46tbrjmeupaiwm2pm23yuvbrmy6kbe6tq2vl5e42@3cew7z6fgpye>
X-Migadu-Flow: FLOW_OUT

On Tue, Jul 22, 2025 at 01:15:57PM -0400, Kent Overstreet wrote:
> Someone set this to bcachefs, and it's not mine...
> 
> https://syzkaller.appspot.com/bug?extid=622acb507894a48b2ce9

#syz set subsystems: serial

