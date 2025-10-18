Return-Path: <linux-kernel+bounces-859191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 99051BECFB2
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 14:46:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0ADFC4E687C
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 12:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1777027A130;
	Sat, 18 Oct 2025 12:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B+iQ3KKb"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC921E511
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 12:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760791568; cv=none; b=V0Oa/dQgJPPdxqXBeD063WC+74hFF7lJKwlXjFhs7QZZGVWKAJQPBLrdi5MRPbGdiojljvVagBxep9KIxbrpZXJ0BEmHj26xol62YxMvP3z5r5R0nAom9EEMegigN7xAduwGTDxMFZLY8bDJqqEvVe6ZqulqxXOWpeZTY1cwjSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760791568; c=relaxed/simple;
	bh=ipty/4H7+5rl8fNwSsr6VwqgKEA4Cfr81uIfdpGBaNc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rxCDZL5vIUTPk2Z0qmqrELxW6/RcoxxYtK9s9BYO3+EWWyOQ9oO+Ugeb/td+3ibTybXaMYSQX8u1MybDs/Nn+ZS9BpwKWW5w12mDuHEzg3Rdjd9Q3kRMYDGyGx08eelVllshtV/s0aRPzTMjg550lEgjWsWDV+WOjVCPCTAs49I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B+iQ3KKb; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-471b80b994bso5099715e9.3
        for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 05:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760791565; x=1761396365; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NRDae27n+EW9z3sFe7xVTYXCCUSru9GSplX7TwKn6SY=;
        b=B+iQ3KKbmm1KZlOPqFChHlqemLiRtnQiEhR/8JrouYBcjfkly0BvvfwmXEw/FILIjh
         BJ2NpApym07/4fE+eXQLmZtEIPyZYMyUa+GnLJO3Qn9rIe89icMWILkZVndb4DpkytKc
         qy4EM24zMdBs5Znmtp9vclB9A9cVp8G92drMAR2+QrwjOexh8R5q1GThSxnq6tv5kEAY
         VnZZ9Hk9bs35dbiwI8sNtmqfB9pW6pwLFXXRJk9ypEhPwKfCgb1u1Ofhr91HguQWaha0
         lU3RjtVMO8D6mrm5cVFF6ZcXrwgRCgEG595tWTcKIE2odU5Q2b6kyFCKpuifsYcuRC1l
         n8RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760791565; x=1761396365;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NRDae27n+EW9z3sFe7xVTYXCCUSru9GSplX7TwKn6SY=;
        b=gsIZk3+h5/ZyGnrit2YuHw/XnOhnz7MuaX6q1moQReAlAXH7S+qY/M8dCtzdRor1oG
         8uFozBEDtEN2abOeYivpLbkPKX+6BIfKuBOyi2GDrbVOihB7pA8f39Vz5S+fWT/l//aS
         uCbMJ2V9NxAbD81lWzsqT1spNod/ySfEbW51vpCFDX100rzrSL1ozxumZ54+bFCSTlqq
         c7zQryZZEDD9AIrVlaJAUBdq62Rxn4mVTq9pt10j92ouqWSD7d/gXsXI1vsHqylpOF5v
         cG2k60WvbOON18nzGNkc1BvJ0iulJkUy8c9+teCXiuj31SySeOcTrCBRB7Z+yTmtMR/1
         u+Bw==
X-Forwarded-Encrypted: i=1; AJvYcCUbIeH1lkyV7yza70MLdu9YJYJI4HqstwOd76CD1BY+XxIoEV1j9WvEzLAmYhtKQGwHvTvSCLBrYH8poNk=@vger.kernel.org
X-Gm-Message-State: AOJu0YylTgmdaUu48IAC8fmp+AUBUCqjaAmnF3H6cwJYR/G+RIgmXH64
	bHingEDNl9HkvJmJ30Zu1lRdd0lZFTu2DDkd9yRf3W2YNRtV4FV1q1SKezCPuA==
X-Gm-Gg: ASbGncsV0kDkgzArUVGOzNkQSRopBpo0QEzWatKOLg4EXGttIugLVj1fh5mmzh07ZQC
	93A2P2BHZXb3dr7o7tfSWQ24QSNC920khelg1SfaL7E9Iqc8ifb6acwhNwmXHetOqabnWoEaobo
	fEuWvxjAoiD0gjUSq/N3Fhq632KSgfYY5roH3WLtxxaHQuiMjykrCRJHdV9SN2B2C9oeqWFQZB/
	IiDRCsP6an4/+fTR3t/5MVli3GgBEB+e96HqCk4/0TadKMh2OZNJktlDL2ao1JmLU1aOaes4s8k
	bAXEfVEvytewsVcrR+S/xrXbvccJKJ1YvGVQFv/IjKINQQCqOig1/Eok/0o05rNnp++KjdQzTWj
	WwapSJBpMOsmCGlrP9ytgRjomxb+brywzBY8UCghn1lx2ltsoyjDLzNikOQlWVsQDiyPx6x0Wj/
	aWBAwN0X2rbZeWy2u0ZsQzs09cHHYuKDc3PIeDCJiQKSSbpSPifWAXoQG8P+8=
X-Google-Smtp-Source: AGHT+IFyFnknhz6DJpA/W+HnNJLeyvUwLECQ2dA/m7ZFwdVON8k8RALCON4xRrvUX069kqPawyiTZw==
X-Received: by 2002:a05:600c:3b83:b0:46e:3d41:6001 with SMTP id 5b1f17b1804b1-47117925171mr75159735e9.34.1760791564682;
        Sat, 18 Oct 2025 05:46:04 -0700 (PDT)
Received: from ?IPV6:2001:861:3385:e20:2acd:89a8:83d9:4be5? ([2001:861:3385:e20:2acd:89a8:83d9:4be5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4711c487dfesm106194605e9.17.2025.10.18.05.46.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Oct 2025 05:46:03 -0700 (PDT)
Message-ID: <3f97061a-4156-469e-b062-d6f7e68d4ad8@gmail.com>
Date: Sat, 18 Oct 2025 14:46:02 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] drm/sti: hda: add bridge before attaching
To: Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Alain Volmat <alain.volmat@foss.st.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: Hui Pu <Hui.Pu@gehealthcare.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20251003-b4-drm-bridge-alloc-add-before-attach-v1-0-92fb40d27704@bootlin.com>
 <20251003-b4-drm-bridge-alloc-add-before-attach-v1-1-92fb40d27704@bootlin.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?Rapha=C3=ABl_Gallais-Pou?= <rgallaispou@gmail.com>
In-Reply-To: <20251003-b4-drm-bridge-alloc-add-before-attach-v1-1-92fb40d27704@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 03/10/2025 à 10:59, Luca Ceresoli a écrit :
> DRM bridges should be always added to the global bridge list before being
> attached.
> 
> Link: https://lore.kernel.org/all/20250709-sophisticated-loon-of-rain-6ccdd8@houat/
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> ---
Hi Luca,

Acked-by: Raphael Gallais-Pou <rgallaispou@gmail.com>

Best regards,
Raphaël>


