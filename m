Return-Path: <linux-kernel+bounces-759646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 35C5AB1E0A5
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 04:43:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2140618A09F2
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 02:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 922F786352;
	Fri,  8 Aug 2025 02:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lanxincomputing-com.20200927.dkim.feishu.cn header.i=@lanxincomputing-com.20200927.dkim.feishu.cn header.b="fghKz6D5"
Received: from va-1-20.ptr.blmpb.com (va-1-20.ptr.blmpb.com [209.127.230.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DCFE367
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 02:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754621006; cv=none; b=NuxdE1n3cpfXWtH0sRzqtmwiQ1fxjeZxZjvS6Umlv1UEaTSiII052sIRXSpnlxQF+s2vOZ4XXDxJ12HPlzOK2cbW/YyI5akSxI8LBwVpJIQsF8FouqCjDSu5OUXX25jSJ4dSQ2/ph7VPdc86DCsSFCn9oErWYS7sas+qPlcRxaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754621006; c=relaxed/simple;
	bh=07ONC8WlXPk8jptQtuzE5Qmo9lm76KsnOsxW1x29sbg=;
	h=To:Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:
	 References:In-Reply-To:From; b=f23W5UI0u1rsyoxC1Fg9OYtUZtgkaiv1O2XXcuuJVZPAuic3NKwRLtdLudqza0+u7BoOEN8ia5VpfAuBJiDB2DOJP5Tv8d66ribAYQ8ezJsPvtDXtNBCGmWN9CKeKjSEQuuQoBMz+WN24jthltYMpQAMCac0gRPjfQt/ncFmbXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lanxincomputing.com; spf=pass smtp.mailfrom=lanxincomputing.com; dkim=pass (2048-bit key) header.d=lanxincomputing-com.20200927.dkim.feishu.cn header.i=@lanxincomputing-com.20200927.dkim.feishu.cn header.b=fghKz6D5; arc=none smtp.client-ip=209.127.230.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lanxincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lanxincomputing.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=lanxincomputing-com.20200927.dkim.feishu.cn; t=1754620938;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=07ONC8WlXPk8jptQtuzE5Qmo9lm76KsnOsxW1x29sbg=;
 b=fghKz6D5f8uxOEZnZUWsXleorTqETF/thXjUiMvIqIpLC3l9kB64+slU7AWGMFx8iHOTn0
 zJ2nZC9oj6hpujGu3NRulUJhUclyHy3BD4DvdpiGPPKAkyck67vA4+34AXZECVzhTDOXi9
 mBsoxoiOycQdGeYFObju+bq8FuC8XE6Oje99k+3yeTNsojrGK4K6LwxKC4yGZfN9ETMnZB
 ySuZbtIdHjXJYi27nhe3Xi+Kx+OInPTkitBDFQEiG1iSMR+K2TTInpJnHy4r8MQxnMiCx4
 XVWw6hIIGCuxvFISJd6dFFxKpf9zkomizt5rjqbk7xQHplMonMpIUPWlNuAuAA==
To: <markus.elfring@web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Original-From: XianLiang Huang <huangxianliang@lanxincomputing.com>
X-Lms-Return-Path: <lba+268956408+07bb2c+vger.kernel.org+huangxianliang@lanxincomputing.com>
Content-Type: text/plain; charset=UTF-8
Date: Fri,  8 Aug 2025 10:42:03 +0800
Message-Id: <20250808024203.16672-1-huangxianliang@lanxincomputing.com>
Content-Transfer-Encoding: 7bit
Cc: <alex@ghiti.fr>, <aou@eecs.berkeley.edu>, 
	<huangxianliang@lanxincomputing.com>, <iommu@lists.linux.dev>, 
	<joro@8bytes.org>, <linux-kernel@vger.kernel.org>, 
	<linux-riscv@lists.infradead.org>, <palmer@dabbelt.com>, 
	<paul.walmsley@sifive.com>, <robin.murphy@arm.com>, 
	<tjeznach@rivosinc.com>, <will@kernel.org>
Subject: Re: Re: [PATCH v?] iommu/riscv: check pte null pointer before use
References: <effb29be-6d14-47e5-ab71-454119467750@web.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <effb29be-6d14-47e5-ab71-454119467750@web.de>
Received: from LeonHXL.localdomain ([116.237.111.137]) by smtp.feishu.cn with ESMTPS; Fri, 08 Aug 2025 10:42:15 +0800
From: "XianLiang Huang" <huangxianliang@lanxincomputing.com>

Sure, 'prevent' is much appropriate than 'check' here...

Prevent null pointer dereference in riscv_iommu_iova_to_phys(). Now, when
it's called with an unmapped iova, the kernel will not crash here.

