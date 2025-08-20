Return-Path: <linux-kernel+bounces-777336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0FA1B2D819
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 11:26:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A9A27BD136
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 09:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22F372E11D7;
	Wed, 20 Aug 2025 09:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lanxincomputing-com.20200927.dkim.feishu.cn header.i=@lanxincomputing-com.20200927.dkim.feishu.cn header.b="z3mXtNiU"
Received: from va-1-19.ptr.blmpb.com (va-1-19.ptr.blmpb.com [209.127.230.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 359C22DEA7B
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 09:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755681758; cv=none; b=G19X1K2rwVdA6Pgw3UP25Ri+po6gWqrk2QJxQsq0r9EkqeYp9RP+ALLMWmNdKQikJdoPMMjxIt+v8WTBwYuOTjI7cL8+IcDRG0Ljp/zka36fQQFrwbbgwdlMvU7H4VGnMKsJ6lsZQZtLjqPoaU3M5kNDugj0fJX3J0l0wY9GeVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755681758; c=relaxed/simple;
	bh=BgVYMUDchAWudzWUKpedFO6xiS7BV3++GzlHR+tYfHc=;
	h=References:Content-Type:Date:Mime-Version:To:Cc:In-Reply-To:
	 Message-Id:From:Subject; b=OBZKqGyW39907WVPu64s8fb+D+ByTtwSr+AceuXlhdOKm/q6xqy7Qqn3k3pBNTPE1rekoUBKBW3IfiBM5JYWjrJoxbnaqAGtq/lbFanzz7cqOs8aAr4yru+FDU3MT1aEWfa/gtIQs7BsyytK/TYvcp+jQRcEwsYaGgnm8CJpZas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lanxincomputing.com; spf=pass smtp.mailfrom=lanxincomputing.com; dkim=pass (2048-bit key) header.d=lanxincomputing-com.20200927.dkim.feishu.cn header.i=@lanxincomputing-com.20200927.dkim.feishu.cn header.b=z3mXtNiU; arc=none smtp.client-ip=209.127.230.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lanxincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lanxincomputing.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=lanxincomputing-com.20200927.dkim.feishu.cn; t=1755681700;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=26u28Ud/7i5hcKzRJDyQdYOfPIqHtE24mfxQ8LptvT8=;
 b=z3mXtNiUkxhHMDXpKd4Pg82xb9xvoc9gx/rM6ReuznEKIkf/7rgN03rLn2kFVs8JmIuMf+
 qm/2KlX7m5DanWNPsMx+ZXF0Q/uWziYp3xDY9BRvVyO7MaVd5VkBo1EC3bAIg98Z3sHens
 45+Y2HyGw+BsKpY9QpY0r3psl+2y9/mK02DsLND1MnEiXmWY89BIA126QJOuEcz1ZXB/up
 sE1F7Owxvr5fIfR0o2hrUD1WW6Th4IRPMVFoeQOU0JtBWsOfNMJWwwK9/fGwfdlongCQEn
 gHMoBdvuMNQvLYhOMV0N/gYdDghQxGgppXMHa1gvf0oXJDl51ALBhIM5Rwq5lQ==
References: <568d8b25-8cb5-48f8-850e-0298e3fc456a@web.de>
Content-Type: text/plain; charset=UTF-8
Date: Wed, 20 Aug 2025 17:21:28 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Lms-Return-Path: <lba+268a5939e+20cb95+vger.kernel.org+huangxianliang@lanxincomputing.com>
To: <markus.elfring@web.de>
Cc: <alex@ghiti.fr>, <aou@eecs.berkeley.edu>, 
	<huangxianliang@lanxincomputing.com>, <iommu@lists.linux.dev>, 
	<joro@8bytes.org>, <linux-kernel@vger.kernel.org>, 
	<linux-riscv@lists.infradead.org>, <palmer@dabbelt.com>, 
	<paul.walmsley@sifive.com>, <robin.murphy@arm.com>, 
	<tjeznach@rivosinc.com>, <will@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <568d8b25-8cb5-48f8-850e-0298e3fc456a@web.de>
Received: from LeonHXL.localdomain ([116.237.111.137]) by smtp.feishu.cn with ESMTPS; Wed, 20 Aug 2025 17:21:34 +0800
Message-Id: <20250820092128.8069-1-huangxianliang@lanxincomputing.com>
X-Original-From: XianLiang Huang <huangxianliang@lanxincomputing.com>
Content-Transfer-Encoding: quoted-printable
From: "XianLiang Huang" <huangxianliang@lanxincomputing.com>
Subject: Re: [PATCH v4] iommu/riscv: prevent NULL deref in iova_to_phys

https://lore.kernel.org/lkml/feb46658-5a3a-4403-b407-500566280eb3@web.de/

I updated the patch in v3, and updated change description accordingly:

In v1
> -	if (_io_pte_none(*ptr) || !_io_pte_present(*ptr))
> +	if (!ptr || _io_pte_none(*ptr) || !_io_pte_present(*ptr))

In v3
> -	if (_io_pte_none(*ptr) || !_io_pte_present(*ptr))
> +	if (!ptr)

but put your proposal at the patch Subject...
  v1: check pte null pointer before use
  v3: prevent NULL deref in iova_to_phys

> =E2=80=A6> ---
> > Changes
> > v4:
> > - Change the summary as Markus recommends
> >=20
> > v3:
sorry for making this messy.

Regards,
Xianliang

