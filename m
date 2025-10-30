Return-Path: <linux-kernel+bounces-878729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D42E8C2153E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 17:57:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7DD6C35041E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 16:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B8D02750E6;
	Thu, 30 Oct 2025 16:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="feigzhIk"
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE0B2153EA;
	Thu, 30 Oct 2025 16:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761843421; cv=none; b=sd0Y/e2TQNixPFjdNAXhT1KBD/HcSgru5DO0DAnroYAYIY+n4H3Nf7NFDxC3QkV/Zj/H6wzjzYkCmBndApo9ZbsntAnK1vwLXb2HLw5zI71vRz2CwBpLLuyQSMhL9tNv5fHHywGJk5HP3iPRLmIuQtNR26Z4EwXpg+e3ch0fxuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761843421; c=relaxed/simple;
	bh=ObCCgXAh3hKBEDn3O9+rFUOfycQWl5QhnD3UMAg9k0s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=edQHSnXceSTJVghqa7VgvheKYe0vv1Nj4dYtHXUIx229XUoNulwTKXalNNmeHg2AlJHsDcgf6mHobvcwnw2+2/Xg2m7rkHbPxaq4dfn8BDaDgohyx8+FqIKhxeYeKXjJDPib8654RYgavIhQb9z2AWw1XTpwUSzznQdy6ncluo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=feigzhIk; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4cy9J662Stz9trP;
	Thu, 30 Oct 2025 17:56:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1761843414;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/Ttz6snmnsibBpd8X+iGhr07gb4gBMz15P5Dl1gpIdA=;
	b=feigzhIknOmJCiqSJntXwgtVUgYp+r3hUJ4AiIcY0POzP7JnwQo9z2DLGjw01rPIMDmfFK
	WQXhIu7xz9Sg+FveiulwNoogOsngd6yh4zDNYteFIXTt3Vs5CLlwhnOQybhKmR5Mp3GI0j
	c7ehmYIMRkvxCnTGqnRriLbZlgzzh80fD1rG8stC4qCwiAHVBzpySjOJEiRhMxAaqOAeZU
	emAuLGoGDmRc9nwFhYiqQ75JnHT1HzqSanwNkB4k4OwT222oicJM7SMvrxD2nnC8N6Pk03
	AVPsEiSlpZFo3lMXdFVmKUVAY+dvArxQSgl/uD9m4Lb4x4TcvOTlXEaExIryeQ==
Message-ID: <bff8815c-e708-4573-a6f8-7fdec160a78f@mailbox.org>
Date: Thu, 30 Oct 2025 14:51:22 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] dt-bindings: gpu: img,powervr-rogue: Drop duplicate
 newline
To: Matt Coster <Matt.Coster@imgtec.com>
Cc: Conor Dooley <conor+dt@kernel.org>, David Airlie <airlied@gmail.com>,
 Frank Binns <Frank.Binns@imgtec.com>,
 Alessio Belle <Alessio.Belle@imgtec.com>,
 Alexandru Dadu <Alexandru.Dadu@imgtec.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Rob Herring <robh@kernel.org>,
 Simona Vetter <simona@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20251029194210.129326-1-marek.vasut+renesas@mailbox.org>
 <50c29b53-64b5-4ad4-a502-286248cbedfd@imgtec.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <50c29b53-64b5-4ad4-a502-286248cbedfd@imgtec.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 05f1c39c062893a7db8
X-MBO-RS-META: h7kpnyktco16tquosm7bezq1bnxciiwo

On 10/30/25 1:08 PM, Matt Coster wrote:

Hello Matt,

> On 29/10/2025 19:42, Marek Vasut wrote:
>> Fix the following DT schema check warning:
>>
>> ./Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml:103:1: [warning] too many blank lines (2 > 1) (empty-lines)
>>
>> One newline is enough. No functional change.
>>
>> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> 
> Good catch! Thanks for sending a fix. Does this also need:

Got a hint from Rob how to better scan bindings before sending patches, 
so the credit really goes there.

> Fixes: 18ff1dc462ef ("dt-bindings: gpu: img,powervr-rogue: Document GX6250 GPU in Renesas R-Car M3-W/M3-W+")
I am not sure about this one, I would say no because it has no 
functional impact on the kernel and/or does not fix any functional bug.

