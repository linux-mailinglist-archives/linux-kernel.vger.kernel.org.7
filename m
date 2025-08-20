Return-Path: <linux-kernel+bounces-777703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D8A01B2DCE9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 14:46:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BEDA5A2BD0
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 12:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4962311C0C;
	Wed, 20 Aug 2025 12:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="tCVO9yWV"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BABA9308F05;
	Wed, 20 Aug 2025 12:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755693760; cv=none; b=jDYoSzHXBeuoGVq3iZtvKipUWEFlrzsS/XOmdjpx5h+EJJDWjLPTIr9bmvX5JyFBTPQvQNOcxi/PQfFIUlUgx0OHWX3EfIoZ7HAsZHtG/dpXEK9TA/U1TWOaVPNrWP1OuDtrO8wC/cGadWxhE/WHSPxRED+2yDJkVTNDhsqLmxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755693760; c=relaxed/simple;
	bh=hLiAIf3ysBiuk0Pn1wvbfd7grr945aO2V4eRGHGq/QY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Pjk7jm6T0yJ6DV5yBm6Vk2MCmfvG1BjuCT3P0pmap/1JEtQ1y3lG4nDaaskW45OEEmpPyCGiGjIh/k4lSL7e9ipZcGqeY9v2jfyKohUx9ZpfWtgE6A0hhGB+6Alxub4JfpqRlCTYeAeV2E30QGLAr2p3ctrGV0BUX9qCEChHruM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=tCVO9yWV; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 13CA940AD8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1755693751; bh=CrN/QXHYTFWh2aboZ2TiLbJ4hoWKn/LbxR1uhwr2IGM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=tCVO9yWV9hMlS6raQBMqFTMGXmDhM71qzb1LJpS+3UEd7lrz6VNm7MPwoLg33eaaZ
	 6KRoT/SzLaFD0RtYlyIbzJNIiyojLA2TJOdTQBHC3I0gnNZV9LncF+Ut3/2BLhPxMj
	 PAPOFLEBL7pgef25IF29D9RMvH4s9sTLKqCF9AnXPSxT1m0RcTDelxFgQznX3JpSfq
	 Ppxp1TxckjZ6mmRO9EnjZz3OFP/QveDL6+2jNUmM20HiMVNMlUQyneg4ZpLuydI8Tf
	 zrGFtzRMC1uEY9pgyuwU/C9DshiI8bxWbjtgMBjjbkrq2oMaZvEHXLsmVUwYgQx2+r
	 koi652mnmtFyw==
Received: from localhost (mdns.lwn.net [45.79.72.68])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 13CA940AD8;
	Wed, 20 Aug 2025 12:42:31 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Linux Doc Mailing
 List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Mauro Carvalho Chehab
 <mchehab+huawei@kernel.org>, Kees Cook <mchehab+huawei@kernel.org>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: kfigure.py: don't crash during read/write
In-Reply-To: <df1602df0da3a6254d58a782654e7f2e60512dc8.1755680997.git.mchehab+huawei@kernel.org>
References: <df1602df0da3a6254d58a782654e7f2e60512dc8.1755680997.git.mchehab+huawei@kernel.org>
Date: Wed, 20 Aug 2025 06:42:29 -0600
Message-ID: <87wm6ytb9m.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:

> By default, Python does a very bad job when reading/writing
> from files, as it tries to enforce that the character is < 128.
> Nothing prevents a SVG file to contain, for instance, a comment
> with an utf-8 accented copyright notice - or even an utf-8
> invalid char.

Do you have a locale that expects everything to be ASCII?  This seems a
bit weird.  I would expect utf8 to work by default these days.

> While testing PDF and html builds, I recently faced one build
> that got an error at kfigure.py saying that a char was > 128,
> crashing PDF output.
>
> To avoid such issues, let's use PEP 383 subrogate escape encoding
> to prevent read/write errors on such cases.

Being explicit about utf8 is good...but where are the errors coming
from?  Is this really a utf8 file?

Thanks,

jon

