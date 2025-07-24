Return-Path: <linux-kernel+bounces-744519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC512B10DE7
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 16:43:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C977561A43
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 14:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79A052E542F;
	Thu, 24 Jul 2025 14:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="WkMCGVKO"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD35C241CB6;
	Thu, 24 Jul 2025 14:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753368181; cv=none; b=j9TfSelgdyr5KbKVCFh2rCqsZGbu1ytbNQLSRp+H2/8rdbvYv+lTJke2lUEcVziQRlxOcl000LJKRxQKcgN8wliH/MZVG4lJwcxwHG+nvw+17/HkAudy/MkLNOeHlegB0XEHTxHJUmNZ3BEx2ItN5u96OcbbbH6xyFI01ZgQhbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753368181; c=relaxed/simple;
	bh=gWdqwwJRWgCCHxAKLC3KVDPQamVK6Ux+vM+aaJDtuQ4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VQkm94cjKFrbJLMsrq7+YU2+jqeSHuur5asxokfefnXOQRPAOZZ8f/Qk4fopsNu7jjtHzBw9vSTrsA9osAIG61aR85t1e7mknGWKlL2GWesUv3hCd4qiB8CHRbNif4qoAwXfM+h0F5onhDks8+VU5+UR2eekAACpbLkVxJQ3okY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=WkMCGVKO; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net E709C40AA9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1753368180; bh=dLLKTqBJqEdbTUtFmPcwiPVYUCE8arLRWG95PAklrHk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=WkMCGVKOXRXlvlnmNg3/3aJ5gA+P/XFvRQDw784XBR4GGC0AgEOI2Qfy3RsFw7pwm
	 acXhnl2jvlBf6ez1TaaeNI/nOdF+icmSMSBhV3bJoF2k/F0pmow5zNZNU8v/ouCwiB
	 ujXWqcQQ79pinGUlD1psPxC6DNrkSluiq+vPPaNCuIMZY1kHqP1ojBT6IHyqi4y5eG
	 TRG8L6dcjZhbuEjEex4D61lMbnGiWgZ82V+1s4GdUj0cWUuHPiLuqktOG6z6J+nOjs
	 kVFAnZdQ2yiiAlEp1GBcsL3aG4/Q9fuYg54WArMfQaRE5HFb12vaIGwbIoFOswsPE1
	 z/OaE9IwaymMg==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id E709C40AA9;
	Thu, 24 Jul 2025 14:42:59 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Laurent Pinchart
 <laurent.pinchart@ideasonboard.com>
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
 linux-kernel@vger.kernel.org, workflows@vger.kernel.org, Akira Yokosawa
 <akiyks@gmail.com>
Subject: Re: [PATCH v2 3/2] docs: changes: better document Python needs
In-Reply-To: <20250713002517.7f52b0e9@foz.lan>
References: <cover.1752307866.git.mchehab+huawei@kernel.org>
 <58c0cfb40e600af697b1665ffbc8e5bb3d859bb5.1752309145.git.mchehab+huawei@kernel.org>
 <20250712163155.GA22640@pendragon.ideasonboard.com>
 <20250713002517.7f52b0e9@foz.lan>
Date: Thu, 24 Jul 2025 08:42:59 -0600
Message-ID: <875xfhabv0.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:

> Maybe I can place instead CONFIG_DRM_I915_WERROR.

I've held off on this series on the expectation that a new version would
come.  I guess, at this point, it will be a post-merge-window thing?

Thanks,

jon

