Return-Path: <linux-kernel+bounces-813304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AE2DB54357
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 08:53:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0B38440C25
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 06:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2325B28C841;
	Fri, 12 Sep 2025 06:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="e5OMHdDB"
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6FED8488
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 06:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757660016; cv=none; b=HzB0ReRjQlhuyGB0cAzEpBeksqchYRlCDCCyRYrrK8r5wDAgJI0cA3P3R0ZCjj57Is0yeqOGjL9S5JC6RHRvns6FPcCBhrd6AzdnTUEA52xK4i0xMWRmzV0EHYRB+AiNKuQQlqLlDIkxK/6NH0bigR467ZyR5aKomFzUv34mdtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757660016; c=relaxed/simple;
	bh=mPsbodAtPjiJ3OKduxPpYJ0o4XxyNaptVm2EuskVmXc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u9BNH80/BnAmrZA/498Yg1p47FVXWSs+Kr3ROx8/TRcOswut0Vci/ceNs8jXiw4dciB2L666PALUM3ajRuHklI4TqHTra5XbHzfcl7swnORaCL4sv95IqqSx1eh0XG4FHhv7RUnw4Y+UotYyt3TQMH1WUZOkyXuQucPy1vcnlHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=e5OMHdDB; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <f0426e43-3d3e-4dc4-aa6b-31db8b2a2a53@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757660011;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mPsbodAtPjiJ3OKduxPpYJ0o4XxyNaptVm2EuskVmXc=;
	b=e5OMHdDBLdx8/XLMpjj24B/LxKFBdKo3LrNueZMlFYbDu8OplqFkfmJwV8zzUIR5POZ0hR
	IxFhM4pvm935YDaU//okrX/mNzl+UWlcLNBHvoGnnCuWplR/ckoeYJgZyAd6vhPQspGqHE
	5sf/MFGwJc+n5FuLIAGL5EdvYp3qtUU=
Date: Fri, 12 Sep 2025 14:53:24 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 4/4 v3] Docs/zh_CN: Translate timestamping.rst to
 Simplified Chinese
To: wang.yaxin@zte.com.cn
Cc: alexs@kernel.org, corbet@lwn.net, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, xu.xin16@zte.com.cn, yang.yang29@zte.com.cn,
 fan.yu9@zte.com.cn, he.peilin@zte.com.cn, tu.qiang35@zte.com.cn,
 qiu.yutan@zte.com.cn
References: <20250830170157045JsLLov8_im0lUELq88aLu@zte.com.cn>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yanteng Si <si.yanteng@linux.dev>
In-Reply-To: <20250830170157045JsLLov8_im0lUELq88aLu@zte.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


在 8/30/25 5:01 PM, wang.yaxin@zte.com.cn 写道:
> +
> +3.2.4 MAC 驱动程序的其他注意事项
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
There is an obvious misalignment here. I'm curious, have you tried building tests?


Thanks,

Yanteng


