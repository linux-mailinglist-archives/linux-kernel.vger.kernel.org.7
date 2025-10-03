Return-Path: <linux-kernel+bounces-841175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CB88BB66A7
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 12:03:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2326A3C806B
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 10:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B62D22DE700;
	Fri,  3 Oct 2025 10:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="Ef38jl96"
Received: from smtp153-165.sina.com.cn (smtp153-165.sina.com.cn [61.135.153.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B4BC2628D
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 10:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=61.135.153.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759485823; cv=none; b=Vxu9zuk+JgQaNPpBTT+gHV7l0WiStVTPiy8rrAloYgvt0QOBckM0zZCHmA8NfNKet5GM++km66HIUjWMcDDp8KQA9iPfSTeH7dRc+goyc5jOsKwnHuoWzmhdtzZ45BbKR9r7RngLtwfNJbuOaiSSY9whMnrTCmFaCZ0z3O7PdP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759485823; c=relaxed/simple;
	bh=TVcw9qlqEGOxIlzqQwR0Ylkr6X/fy9mKM/EiPKB2VDg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dni1j7hIdFe+Hw25k7yyQPN9JyQojOMkTZ506mE+8QdKBQLH1K+ymSeXTUtugsCCdsuYDSXEStAtO6BDSzAdE58XY8vY94gTVfbKJd5mJFFXmtWFj5xV4Knv/BC7+eZQ+vhXgGr01gIJFLI00d1TS/Uer7Fp84fY3j0CrItPql4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=Ef38jl96; arc=none smtp.client-ip=61.135.153.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1759485816;
	bh=R4HQ0uAVuNYpOL8R6iiIPkx6KM+urvlZg5GZtsx+od4=;
	h=From:Subject:Date:Message-ID;
	b=Ef38jl968IrryoKBjWNk+vwNbGIwTkEVo7cSlZpA5WKJ4LCvVPgFbwRBMMqIzPakh
	 rBKFoM75X9/VA1NmmPOcB4gO8jJoiUksMdxh25vOqHu7d47Tk0frqIjm8p3P1fgB+g
	 9Mi/pgZrklQqLM2zcBazAKD3A9OyhhZztezaXB5o=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.32) with ESMTP
	id 68DF9F4F000025B7; Fri, 3 Oct 2025 18:02:58 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 3485894456768
X-SMAIL-UIID: 6D9997E2C9164F5BB6FF3147098067DD-20251003-180258-1
From: Hillf Danton <hdanton@sina.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Joshua Hahn <joshua.hahnjy@gmail.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH v2 2/4] mm/page_alloc: Perform appropriate batching in drain_pages_zone
Date: Fri,  3 Oct 2025 18:02:39 +0800
Message-ID: <20251003100245.8029-1-hdanton@sina.com>
In-Reply-To: <db51bcc5-aaf6-4cb4-ab62-fed9d40d6caa@suse.cz>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 3 Oct 2025 10:35:46 +0200 Vlastimil Babka wrote:
> 
> Also you should really stop dropping CC's on your replies, especially for
> maintainers of given code. I've only learned in the v3 changelog from "as
> suggested by Hillf Danton" that there was this subthread. This is not
> acceptable. When the feedback is wrong and uncorrected by others, it can
> mislead the patch author to do wrong changes in the next version.

The Cc list was cut mainly to avoid getting guys interrupted in accident
with Johannes Weiner still Cced. And nothing more.

