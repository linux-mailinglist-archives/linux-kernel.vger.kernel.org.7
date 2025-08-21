Return-Path: <linux-kernel+bounces-780529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC397B30315
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 21:41:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4823F17E144
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 19:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A5A834DCC0;
	Thu, 21 Aug 2025 19:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="Hj1siROD"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C8B29BDBC;
	Thu, 21 Aug 2025 19:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755805281; cv=none; b=GspsvsOWTDnGdNX2cxN6lxUWZNWnzSaSxt2LfiqRCwS8rCfA82Sx3pTsfCEYYD1242fxcnMK4ixD/ZrX89aLzgSF09tTNPvaqvZPbeGS05BkuqgCDLgFogIgNsk65TZoa8aiIAdotTuJtvQF+P3hlynTiBf+8MvgNkbTFHrQNL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755805281; c=relaxed/simple;
	bh=5sq6UFbL2LJqPXyUS1beAWwgmWTnVpdRfFcCoEwBlyA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kYSi/SPlt3NxPz9CIy5UE4sXOtThhJdtZfaDlgzVBm0H3MEgteHCqXs5PSt2O/uEHjoj1QunNoHFiyq76wOCzFEAjdZ9nICSVEluun3vH/n6v67PgxAY+9Ea9xRP96gu2GlR9qk/yFOt6OvGjCKprFQ6IHOXk/NpXxiFOJY2EzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=Hj1siROD; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 6727940AD5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1755805279; bh=tpGi6HPKJ5MrsE5fB/SkNNS5T4ARV5hWwuC6kVpbs2A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Hj1siRODlWKFymBQRDeWepk36HdrLPGGJVbQvUAzKLAXNK1HAhWCdu0kJt5oHk2zY
	 EngpFbdiIxbXBzBh4WYBHBBxXLvbXz+rBtxr6uIsPkhSesJhVeWzW28JtTqUmx7Lul
	 eldgGoAhxyB43HvK3auvhxmd4SuSDPBig5VYIZXU1e4HIdTI4YOIzOs1NghtahFG/r
	 mXPVi/eEIt3XmXIHLeRZVAGW/vEdyaKcUDon+iB72UUzmi6haRFXacvZey0KkmIiwn
	 x2LZECH1DRFp9bArKus5GsThZXtv4ABvUZjfEp9q60aDVxMfpPVgYlGQLr1Q0MSGJk
	 iGkUjDERIjfoQ==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 6727940AD5;
	Thu, 21 Aug 2025 19:41:19 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Linux Doc Mailing
 List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Mauro Carvalho Chehab
 <mchehab+huawei@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/11] scripts: sphinx-*: prevent sphinx-build crashes
In-Reply-To: <461e00fe7ce75eaac90d98572bb93910b39361e2.1755258303.git.mchehab+huawei@kernel.org>
References: <cover.1755258303.git.mchehab+huawei@kernel.org>
 <461e00fe7ce75eaac90d98572bb93910b39361e2.1755258303.git.mchehab+huawei@kernel.org>
Date: Thu, 21 Aug 2025 13:41:18 -0600
Message-ID: <87sehk5uox.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:

> +        # The sphinx-build tool has a bug: internally, it tries to set
> +        # locale with locale.setlocale(locale.LC_ALL, ''). This causes a
> +        # crash if language is not set. Detect and fix it.
> +        try:
> +            locale.setlocale(locale.LC_ALL, '')
> +        except Exception:
> +            self.env["LC_ALL"] = "C"
> +            self.env["LANG"] = "C"

In my years of writing Python, one of the most insidious things I have
encountered is this sort of wild-card catch; it can hide all kinds of
bugs.  There must be a specific exception you can catch here?

Thanks,

jon

