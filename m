Return-Path: <linux-kernel+bounces-827239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BCC8B91405
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 14:53:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C60E189317D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 12:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C19F03093B6;
	Mon, 22 Sep 2025 12:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="Csm8zjyF"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 578B53081C1;
	Mon, 22 Sep 2025 12:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758545632; cv=none; b=nrscvOHRml06Kh8wi2jzS0eyKpnSsxLEd8nNDqrwI5INTY7ctIAX9p7OUzLBtZ97YZVhjRmr/5SVzeC3ZBQZidBv4wElAYlkRuBA3betN64kAbWjFhub2awgc1Rt89uP+wkgYnUEBgMUiIjc5CZK4TVqR3vEf+/Y/sKHolY9cnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758545632; c=relaxed/simple;
	bh=LfoJQ8S0OE5Gm+JpV4NFrZ6MM77Y90rkMiXBOjFpSV4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=T61/GjcaGpE34AyOMx0LiKjCKqJlE/EZJ2UfyPLLhL35nifaGA2gY3tUs7ds8SvHfZghT8prCckjSWeC9H44RD44woYLNGID2aC9elvccx6mCJxwOCqr9LEW+EvC0Yi7RofcKjtp8JnqCuh2HQUU9U62H9cgnBurcwtycNOTFLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=Csm8zjyF; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 432B3406FB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1758545628; bh=LfoJQ8S0OE5Gm+JpV4NFrZ6MM77Y90rkMiXBOjFpSV4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Csm8zjyFSoEVN6aoDpsECH6QrfIsz6YXB3jPBegIYDypWaIfKLGoCTWXSz+mKio+D
	 nK7hLzfPdgVBAvzuv8696U0fSi6e1J2vOnWV95vtFtOEKX/k0ON2pqUB5MjRzKeugG
	 fJuHQpDzKhttt1zNiQa2HHoWnUcQpGRK7vCuR0DU+ZNBHeh8vV/BLhXYNKfXOV8vfD
	 1eB4QDnmnSfp73U58+FkzrdiNJOaoldReoMpBtaTKyE1FaFZhqlcEGGWpau2QQAHvk
	 KOpmDCijepaU7hpqjru6S6393TaVV11q+7wJZ85iQxj0WlnxaBqv/pR0cG2UfOPJmZ
	 5xEuY86MVrQvg==
Received: from localhost (mdns.lwn.net [45.79.72.68])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 432B3406FB;
	Mon, 22 Sep 2025 12:53:48 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Bagas Sanjaya <bagasdotme@gmail.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Documentation
 <linux-doc@vger.kernel.org>, Linux Kernel Workflows
 <workflows@vger.kernel.org>
Cc: Dante Strock <dantestrock@hotmail.com>, Randy Dunlap
 <rdunlap@infradead.org>, Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH v2] Documentation: process: Arbitrarily bump kernel
 major version number
In-Reply-To: <20250922074219.26241-1-bagasdotme@gmail.com>
References: <20250922074219.26241-1-bagasdotme@gmail.com>
Date: Mon, 22 Sep 2025 06:53:47 -0600
Message-ID: <87h5wu8x7o.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Bagas Sanjaya <bagasdotme@gmail.com> writes:

> The big picture section of 2.Process.rst currently hardcodes major
> version number to 5 since fb0e0ffe7fc8e0 ("Documentation: bring process
> docs up to date"). As it can get outdated when it is actually
> incremented (the recent is 6 and will be 7 in the near future),
> arbitrarily bump it to 9, giving a headroom for a decade.
>
> Note that the version number examples are kept to illustrate the
> numbering scheme.
>
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>

Just FYI, I've pretty much shut docs down for the upcoming merge window.
I'm probably not the only one.

Thanks,

jon

