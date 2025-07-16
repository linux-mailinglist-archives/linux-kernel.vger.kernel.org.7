Return-Path: <linux-kernel+bounces-733824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C101CB07973
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 17:20:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96CDE3A4CA6
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 15:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DCCD26E6F4;
	Wed, 16 Jul 2025 15:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mareichelt.com header.i=@mareichelt.com header.b="CLTw1qAc"
Received: from antaris-organics.com (mail.antaris-organics.com [91.227.220.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A35A23496F;
	Wed, 16 Jul 2025 15:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.227.220.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752679207; cv=none; b=CxtiCv4Iwbk+okY/aEIQPRCvIzI7SpKF1s3RdGqw5753zCMR0aDuaNq8kH9KGI+UoWSNgctvSktgFWjKuhp9jBGbSzZ41GEb4LHffNQ5QWUv1WrhovVMf9OF9WRFyPgquoo83n02FtY7FZ+FcCwM8bEKknO+xFtWf3R0fgi/z9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752679207; c=relaxed/simple;
	bh=oecc7htTRAI8K/kgvLOnaN0LvqWXXNDtsy9buyaK2LY=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lM9MLfnuviIKI6GKRDYMa2mhqRVgdxEwZlfxhn8XRMVDWMUJFBTm9GNBD13oQ+AjBLDj24aU52ebB5kv3f76IOETkt+so7wqMY5Mi9c1QGiVzrBZvIRe729XQRZRLo+k6e+bfmEJlKckjVRbw/IiRMJ/XDryleupSZecnFgK/W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mareichelt.com; spf=pass smtp.mailfrom=mareichelt.com; dkim=pass (2048-bit key) header.d=mareichelt.com header.i=@mareichelt.com header.b=CLTw1qAc; arc=none smtp.client-ip=91.227.220.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mareichelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mareichelt.com
Date: Wed, 16 Jul 2025 17:10:19 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mareichelt.com;
	s=202107; t=1752678620;
	bh=oecc7htTRAI8K/kgvLOnaN0LvqWXXNDtsy9buyaK2LY=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To:Cc:Cc:content-type:content-type:date:date:
	 From:from:in-reply-to:in-reply-to:message-id:mime-version:
	 mime-version:references:reply-to:Sender:Subject:Subject:To:To;
	b=CLTw1qAcfycakuu1HGNNougnmVzcaPSGn4AwPjvJG6gGBQuux2CZkYjWBJWC/Pz/b
	 xCFdxR4qxw2C2gU+hLAICtY8tf3yNYDtesFUCH4dOByNmj8qMGwO8s4rN3L0Bhakqx
	 +wGZlFOfqQgj8vLbfIrvtAaT58i5sco1ePWq4H6oxzfD7Rea82PY0ncBXzDBLLVOcx
	 SADEuY1FgLUY2B4Hjfy+gqJUEIoWQpyh2ikPr5fR5QzLwRmmUj4nywYDDkVKOZcjGn
	 oMR3CODA2tbo7DFW0QvELd57UKgHXxXpJ1evUxWs367X304WhYhNukhKvFPSL5AG+J
	 J8E6+y+tYQoNw==
From: Markus Reichelt <lkt+2023@mareichelt.com>
To: stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6.15 000/192] 6.15.7-rc1 review
Message-ID: <20250716151019.GC3473@pc21.mareichelt.com>
Mail-Followup-To: stable@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250715130814.854109770@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250715130814.854109770@linuxfoundation.org>

* Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> This is the start of the stable review cycle for the 6.15.7 release.
> There are 192 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Hi Greg

6.15.7-rc1 compiles on x86_64 (Xeon E5-1620 v2, Slackware64-15.0),
and boots & runs on x86_64 (AMD Ryzen 5 7520U, Slackware64-current),
no regressions observed.

Tested-by: Markus Reichelt <lkt+2023@mareichelt.com>

