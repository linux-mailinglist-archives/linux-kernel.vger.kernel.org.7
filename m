Return-Path: <linux-kernel+bounces-805530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 685FDB489BA
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 12:14:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B264F1B25619
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 10:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B555A2F7ACB;
	Mon,  8 Sep 2025 10:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ih76/L2l"
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5FA2F7468
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 10:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757326431; cv=none; b=bY0VAUq1Y+iUDV5GSzvKbTFKyxkbsz32v7jzXOQxZFPWOGcgvaOVdcmQvWdQiD/iaDEU6fe56KoChhJAowQnoSTe1qxTGGNMmSw2SrM98nXxD8gms0ScQd+4p/7/n0PHO9BgXKnhxcl+a5Odv0e62nQcgNLY+BBxc1XZ6wJyyBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757326431; c=relaxed/simple;
	bh=3pvVKGd7pcGv4RXsx05CvvxQspqn3K5m7zfBYj1+QQA=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=DstNN8z7QKZOkOVOYVzIBLaUfXiyCUewipKdaYwzPT7HCt6SdT0nnv48tF6c7KeJR/UlUe+bjGrR5y66Oi3NiL3Kk9U6vt4QKtbGDNK/C5c4Mj7Sbr82jM7Aq6StVoJ4m7R2wiryaHOdtx/kniY5gzto0Si10v2INIteQjMB/3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ih76/L2l; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757326417;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ySYSYlIA/WaQQvWmLKzzHmlSzbnnjmLpztV22CiKLVQ=;
	b=ih76/L2lS8JBDzjzBYQzyoQ97mWRepyVcKp+RDwwuSie+Xq6sRUWWJqvd4fSWrsRAhOUMB
	si0E7Z+e0nvbcMEJiji+CPL75J5TLfNPPJvQj2KB2rh0E6KbozE8rBlnyKU6NRDg8PBeeU
	KvLX67GLefwHdZejGvHN4dAueGcETsY=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH] tracing: probes: Replace strcpy() with memcpy() in
 __trace_probe_log_err()
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
In-Reply-To: <20250825160540.9a5272a8a93a789eb36a7098@kernel.org>
Date: Mon, 8 Sep 2025 12:13:23 +0200
Cc: Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-hardening@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <635528D7-9B5F-4B7C-9568-87375BA866C3@linux.dev>
References: <20250820214717.778243-3-thorsten.blum@linux.dev>
 <20250825160540.9a5272a8a93a789eb36a7098@kernel.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
X-Migadu-Flow: FLOW_OUT

Hi Masami,

On 25. Aug 2025, at 09:05, Masami Hiramatsu (Google) wrote:
> On Wed, 20 Aug 2025 23:47:18 +0200
> Thorsten Blum <thorsten.blum@linux.dev> wrote:
> 
>> strcpy() is deprecated; use memcpy() instead.
>> 
>> Link: https://github.com/KSPP/linux/issues/88
>> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> 
> OK, looks good to me.

Did you forget to add a Reviewed-by: tag and/or to add it to your tree?

Thanks,
Thorsten


