Return-Path: <linux-kernel+bounces-808870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58C6CB505A8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 20:57:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 033FE44173E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 18:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF05A3168E1;
	Tue,  9 Sep 2025 18:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="kirVXiHo"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D666E146A66;
	Tue,  9 Sep 2025 18:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757444253; cv=none; b=hmMdWV3HjOFKCaAzup4TpHR5fxA0gx60rPZWbJI4IzBedCOBAoy9RXVSVi36vg+CeC2DFcqwyEGurh4QMvF5AjR1ZWsuR3REQpAmRizQIFlXQkbbVNx694Gi73LV50ePVOUuKmaE8h37LFl4YhBcYeokH51tVv44JAlOKTSlCG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757444253; c=relaxed/simple;
	bh=p0Bv5TmrcngOZl8WxUbf2ek/V5EqxTcV/eAOHyR1Kx8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Unqn40am9Ms3ZsEWzaZraPSLk4+dS14yv5uePyuDIeUxlAElMLGqCGpZup1paPSgVpq76GsIIAZaz8sGnMZuNo6xcDj94NrV5n0/65G093gyKQ7PCKcFARWObc72DQNLqSDB01FGgeTVIw5bTLlwqonoecEY5jjKISM+P5sUhuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=kirVXiHo; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net D797840AF9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1757444251; bh=aakfAt7u2qZZ/Sti9ZnFlm7QA/jarhANlSt/J68+KEU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=kirVXiHo5Rbhc5eTYlbNpBJ9WjGFbCvJKcbCz+EGXzJClnhPrKd+Rxyt5GmadfnR0
	 5qm/DxUXUHTC5HI2rgQ8l2PF8+JymWepjjgTZQX5GayG/PONR7DhD6ZqBFNTXEyZDj
	 v2QoJp7L4HRDTsTeNqp0fqrquo0jvRGIxmZLJZZX3PJ/Ju2OW/yOYs/cogXmQoyR+Z
	 OmEgXwonhsmh3CH9L4/Pk2CggHmGOR39EdntgmLAeUDihKbBdOGJfGZj4JEANNak2z
	 2w7oT0bBR0OQxugFTjEo8R5vKwhQgIa+9WYb3NXEgeZedI/FaxgK9Dw/WDfPRViU2i
	 NfJtyAFUkR20g==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id D797840AF9;
	Tue,  9 Sep 2025 18:57:30 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Bagas Sanjaya <bagasdotme@gmail.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Documentation
 <linux-doc@vger.kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Bagas Sanjaya
 <bagasdotme@gmail.com>, Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: Re: [PATCH] Documentation: w1: Fix SPDX comment syntax on masters
 and slaves toctree index
In-Reply-To: <20250909022142.18007-1-bagasdotme@gmail.com>
References: <20250909022142.18007-1-bagasdotme@gmail.com>
Date: Tue, 09 Sep 2025 12:57:29 -0600
Message-ID: <87tt1bv4h2.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Bagas Sanjaya <bagasdotme@gmail.com> writes:

> Commit e9bb627561535d ("docs: w1: convert to ReST and add to the kAPI
> group of docs") converts 1-Wire docs to reST alongside with SPDX
> comment, yet the comment is written in one dot as opposed to two in
> order to be recognized as comment directive, which spills it into
> htmldocs output. This issue is partially fixed in d8fb03e1ea64e7 ("docs:
> w1: Fix SPDX-License-Identifier syntax") as it only touches top-level w1
> toctree.
>
> Do the same fix on masters and slaves toctrees.
>
> Fixes: e9bb62756153 ("docs: w1: convert to ReST and add to the kAPI group of docs")
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> ---
>  Documentation/w1/masters/index.rst | 2 +-
>  Documentation/w1/slaves/index.rst  | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Applied, thanks.

jon

