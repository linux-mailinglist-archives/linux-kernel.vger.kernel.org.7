Return-Path: <linux-kernel+bounces-777547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3A7CB2DAC3
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 13:20:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7990A3A14F9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 11:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB1BB2E4242;
	Wed, 20 Aug 2025 11:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lanxincomputing-com.20200927.dkim.feishu.cn header.i=@lanxincomputing-com.20200927.dkim.feishu.cn header.b="WZs4rKGN"
Received: from sg-1-12.ptr.blmpb.com (sg-1-12.ptr.blmpb.com [118.26.132.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049CE35335B
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 11:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755688626; cv=none; b=JV2V7JJnt1EeViu4tcoYp/2vToWMcRiXDZ+mkrMr5kU4INvILPiqtrpkURKcFzCB1eL1zr3ON/00ZL9az3xZ5kvRFYJrvQYUnCd0sq3oyNsct64ASq06/SpN1DWrSKEMJ4mpyYlksuiolZyvYGA8mOgpv36Q9TY5rD7vUmCdzYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755688626; c=relaxed/simple;
	bh=mzjRYT0rbzh6fz3WHdLobxA8DIlPVPxQ8fNKl0ROwWg=;
	h=References:Mime-Version:In-Reply-To:From:Date:Content-Type:To:Cc:
	 Subject:Message-Id; b=JsJZKYIIbNFcm51dZwhPlYL2t8njwuFv0RlkIH5H+47FyMQqvvy3ukh06G5ZVCDbRml5PyvS6zc1WeCkO/MsGtKZZvLY2JTXKQD9MMyjicgAvCycgO+aHmiUpuNvyGKsoqSL/7LVadqIY7EL+Wv98jzxOhpuSjjLk18g6iHs+0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lanxincomputing.com; spf=pass smtp.mailfrom=lanxincomputing.com; dkim=pass (2048-bit key) header.d=lanxincomputing-com.20200927.dkim.feishu.cn header.i=@lanxincomputing-com.20200927.dkim.feishu.cn header.b=WZs4rKGN; arc=none smtp.client-ip=118.26.132.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lanxincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lanxincomputing.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=lanxincomputing-com.20200927.dkim.feishu.cn; t=1755688614;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=mzjRYT0rbzh6fz3WHdLobxA8DIlPVPxQ8fNKl0ROwWg=;
 b=WZs4rKGNAiVBUVAN987iRAzrCQuRlEqBEwwV60b9hNKLl6lyYhmST7WhCjtaHzpGg/xVAv
 iXu/hMI6miT0IRHzBIyp5azjmbVPzm+F6IBPOTYImvTPt8nsa2y4eDxhUZ40VDvvOIb8Mp
 R3jMeG2JVYc0GsCvzJD7PM3vXuWx2kexHPSMXvfPtp2ynMrejbqSTFKo0xLqGbH7jZjMzM
 VEaD5D2Y2Q5n5xVfWw7fgKW+iu3M0t4p8q4J62Aceax8GVxJMtO+Q8lSCoKhHv9WFRff8q
 smqyjli1s2oGEaMX+iXOaBDxyed7j4RAJHfM8KE9dIf/Nw57NkyDzGyLE0Y0qg==
Content-Transfer-Encoding: 7bit
Received: from LeonHXL.localdomain ([116.237.111.137]) by smtp.feishu.cn with ESMTPS; Wed, 20 Aug 2025 19:16:52 +0800
References: <17ba1116-35bc-4a47-ab51-0626006ee35a@web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
In-Reply-To: <17ba1116-35bc-4a47-ab51-0626006ee35a@web.de>
From: "XianLiang Huang" <huangxianliang@lanxincomputing.com>
Date: Wed, 20 Aug 2025 19:16:43 +0800
X-Lms-Return-Path: <lba+268a5aea5+3fc0d2+vger.kernel.org+huangxianliang@lanxincomputing.com>
X-Original-From: XianLiang Huang <huangxianliang@lanxincomputing.com>
Content-Type: text/plain; charset=UTF-8
To: <markus.elfring@web.de>
Cc: <alex@ghiti.fr>, <aou@eecs.berkeley.edu>, 
	<huangxianliang@lanxincomputing.com>, <iommu@lists.linux.dev>, 
	<joro@8bytes.org>, <linux-kernel@vger.kernel.org>, 
	<linux-riscv@lists.infradead.org>, <palmer@dabbelt.com>, 
	<paul.walmsley@sifive.com>, <robin.murphy@arm.com>, 
	<tjeznach@rivosinc.com>, <will@kernel.org>
Subject: Re: Re: [v4] iommu/riscv: prevent NULL deref in iova_to_phys
Message-Id: <20250820111643.19464-1-huangxianliang@lanxincomputing.com>
X-Mailer: git-send-email 2.34.1

> Does it trigger undesirable communication difficulties?
No, and I agree that both subject and summary phrase can be improved

And now I do learn from this, thanks.
> Your patch will almost certainly get comments from reviewers on ways in
> which the patch can be improved, in the form of a reply to your email. You must
> respond to those comments; ignoring reviewers is a good way to get ignored in
> return. You can simply reply to their emails to answer their comments. Review
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst#n310

Regards,
Xianliang

