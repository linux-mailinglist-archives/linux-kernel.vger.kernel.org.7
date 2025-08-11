Return-Path: <linux-kernel+bounces-763425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8548DB21467
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 20:31:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15DA63E45AD
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 18:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBABE2E0B42;
	Mon, 11 Aug 2025 18:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="g2H4KWGH"
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E4BD2D6E42
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 18:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754936989; cv=none; b=I6whoH3OrYg3XLFFo7DUbmK2Gu92RT57h08CjiXUo6H3uls20VMSWzvxhcf7o7kGqOwOZVUGVblcxsrP87pistU3DpkF/Doyn1FlMBmzMtdkYsGJZ2dUJt2awbaVRu5eGpMtDBingidK0x8Iiyc94fyIqtcnj9OtmaCIPsh6lps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754936989; c=relaxed/simple;
	bh=hrEtBOvQnw6YW8KdGQJzpLlwiXbFkDUtjprkDcg04kk=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=JtW7swk9cxcwwiODSH/m9L694hX2SOZE5wytl8XICzkzh/3S4gyySz/JQSAmNkSuYm2U8AB4kOrBDBO2wf5OAw/wfof9S5vbGx7iBIyRwxQUNULOWvBjvK1eJTpMC359DL5p0WLOPJn7mW3uAGUyuVoHi+2FnP3HfJfDIXk3CCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=g2H4KWGH; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1754936984;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uKssGbguN0Up7XspWHdWQl8Ps3WGNN+kKJTTLCWt7Vk=;
	b=g2H4KWGHkB1lIozTBhDP6X72zzPC5+siYNPjSXcfCbZu6h+WO/46eMTc5nl1qZ3wtTtZoc
	ePHocETjDPJhIt+hFP+dfhq6GUTc75zyQTj55HQbwcz9AM+sea7WLWTdmIJnrC+OAHz6Ag
	XDjNdx5uWTaufhEKeG9JBeVvr425/qU=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH v2] perf/core: Replace memset(0) + strscpy() with
 strscpy_pad()
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
In-Reply-To: <20250811181802.72970-2-thorsten.blum@linux.dev>
Date: Mon, 11 Aug 2025 20:29:30 +0200
Cc: linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <27A3E6D2-3982-401A-8AEB-8E60DFCC45A9@linux.dev>
References: <20250811181802.72970-2-thorsten.blum@linux.dev>
To: Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>,
 Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>
X-Migadu-Flow: FLOW_OUT

On 11. Aug 2025, at 20:18, Thorsten Blum wrote:
> Changes in v2:
> - Keep strlen() as we're not checking the return value of =
strscpy_pad()
>  for string truncation
> - Link to v1: =
https://lore.kernel.org/lkml/20250811091637.4492-2-thorsten.blum@linux.dev=
/

Actually v1 was just fine because both source and destination buffers
have the same size 'TASK_COMM_LEN' and the string won't be truncated.

Sorry for the noise.


