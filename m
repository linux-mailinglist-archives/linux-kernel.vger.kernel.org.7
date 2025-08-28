Return-Path: <linux-kernel+bounces-789323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D9B4CB393EC
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 08:39:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03F2C18800DC
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 06:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 881F7278E41;
	Thu, 28 Aug 2025 06:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="gxeyeFyO"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B86230BD9
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 06:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756363167; cv=none; b=sly4h0vmjsp8AN8DDaL2PBYc3rPr0J3CleJUl+LKxYx5cWG6x/05VSsV74VR6waJCSaT6t1slO9xd8+tjQKfYD5XvRIVcOT5tET/4EkE6RgY79VgUM9QUsH685Ysror+s5B0OJkkzdWfQ7oPeO7q7CNRWPmGCLMVofn4bbNKS2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756363167; c=relaxed/simple;
	bh=n/NTSle39sbeJOwM4/74tFwwpPd9WemH/yjiQJAFUTk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dtjaiNlYiSUxPTnP5XrmFOqJ1NAwx2ipRyf0y7IEAMlCI2/uo1X4vyDD5jAimN6WpSOxTwdUTutQo+LIWxH2+LgnpNh2Mnce2D948wn8q2NPIZPPX1cpA5N9SssCpUhoQu+Ua7dxcTGZDAxtnvmnfcABtOSMLNzBhXcAwfNAJQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=gxeyeFyO; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Message-ID: <ac38020d-313e-40cc-be7b-f77c69cb5634@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1756363158;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Kbb69Qm3MwS0jgme1lHWlQ9eEDgvWU8URtSpvjipqT0=;
	b=gxeyeFyON1+QgG7hXe1i7ONXrVoH4HtFxpvjR9UzpEip35J6xyQcQkf6EpsSRxn3ax1Rr+
	V15Ma+WB6YyER9vLXqAFiV5TrFnTvOnpaGbtTZ40S5w7YgnZSEzd73hd3SKPWJ3Opfq4vV
	IT0aJ47h8mWD8L9mcRR+1PUzm9jbjMEHfWb0QA4dFypXGbXVAgv7LWI+acXYhbAmkMq0tm
	+NynwnP+CAUTegCSxBbH2ksbm3tQ3D6T/h9rtdqX0GmHQk6QUi1KYVlJZkUc5GG7qVwZ//
	mawSTqnlRcgB5iC1V25fym37De7jsUGzbIQlOhOPRz8yMQS6Hwjm0ad1tZTbXA==
Date: Thu, 28 Aug 2025 08:39:16 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 0/5] drm: panel-backlight-quirks: Do partial refactor
 and apply OLED fix
To: Mario Limonciello <mario.limonciello@amd.com>,
 Antheas Kapenekakis <lkml@antheas.dev>, amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Robert Beckett <bob.beckett@collabora.com>
References: <20250827174400.3692549-1-lkml@antheas.dev>
 <607d5062-1734-46c4-b851-782bd7ad3ec7@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Philip_M=C3=BCller?= <philm@manjaro.org>
Organization: Manjaro Community
In-Reply-To: <607d5062-1734-46c4-b851-782bd7ad3ec7@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=philm@manjaro.org smtp.mailfrom=philm@manjaro.org

On 8/27/25 20:38, Mario Limonciello wrote:
> Can you double check with Phil?  I thought there are two affected Zotac 
> devices, but I could be wrong.  If we can get both in a single go let's 
> do it.

Yes, the new model is called G1A1W and has the same panel as G0A1W. We 
might still work with the vendor to get a firmware update. However, so 
far we can keep the quirk for that model as well. If needed I could send 
a patch to remove it.

-- 
Best, Philip

