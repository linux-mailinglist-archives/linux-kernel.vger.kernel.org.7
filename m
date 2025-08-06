Return-Path: <linux-kernel+bounces-757600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B58A7B1C413
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 12:14:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E186F1856C7
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 10:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2425A28A414;
	Wed,  6 Aug 2025 10:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lanxincomputing-com.20200927.dkim.feishu.cn header.i=@lanxincomputing-com.20200927.dkim.feishu.cn header.b="PBnTemmG"
Received: from va-1-15.ptr.blmpb.com (va-1-15.ptr.blmpb.com [209.127.230.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C47289377
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 10:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754475280; cv=none; b=KTgWH3Z56Y+snZ07IWWf89cEbz3DuHYvpiqIhGOqNLecs+PiiyUT8Z5PmBORCd/WDlEkq6MtB3owNmeFYFL2Ft7mnD05M9/UkcRnS2vfd8l2VzNyKcH0PZkPJe5NS7YwMkwCKqoCLU7UwoXKRMJiXJE9vZE9CfhwcPa7y5wchJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754475280; c=relaxed/simple;
	bh=N6l+1yHhMqXCPPSV577+GHyz1ZJez474BAHAo4bn/W0=;
	h=In-Reply-To:Message-Id:Mime-Version:References:Date:Subject:
	 Content-Type:Cc:From:To; b=OVlZVUFE1JLY8y7gm3LG5o6FOgSW3nxKdYBGUZ1hiQQ/HVMelKt3zVEeGS6EQyjPHraSQvxUeWodddCHnnPxl9DTgYZV6bZNjcoLmyJPv30EIpAI3zj2YBhlvwGnRdbJVLW7S3lpbPwu35dgSX1K64ZehWNBybHD3zqQi6qh1+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lanxincomputing.com; spf=pass smtp.mailfrom=lanxincomputing.com; dkim=pass (2048-bit key) header.d=lanxincomputing-com.20200927.dkim.feishu.cn header.i=@lanxincomputing-com.20200927.dkim.feishu.cn header.b=PBnTemmG; arc=none smtp.client-ip=209.127.230.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lanxincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lanxincomputing.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=lanxincomputing-com.20200927.dkim.feishu.cn; t=1754475226;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=N6l+1yHhMqXCPPSV577+GHyz1ZJez474BAHAo4bn/W0=;
 b=PBnTemmGDtL8WKUAg4buc23CSkgO2ucFQD5y3zZ2aM+7kiOoyfsiKt5TuyfEfbmRsH9r3V
 M4/rV30WLymf1TX1b1z7A/kB9vN+hCX4e1w4+EJo2Rsp1c5udE7h6KWW9xkw84QbIUOwre
 YDY5g13myROwr+OLymIqYWp7YG0iLzEJql/ckASP+hmQyMcj8z0EDUyPSSbrEveYrZm0cV
 ouovMlgCksGzDUsVpG9E0WmoKfHxHiQB2AmMx+VrnZozTPkUDO2omfcjBOSNtcKqyGxAE4
 7OGhdRAzmioLO9NhRNqe9Iqtsb/T/J7AFAC1bmiBRDDi8m32m/1OegA0DudRwA==
In-Reply-To: <1f419739-4233-474d-b00a-4e1237352691@web.de>
X-Mailer: git-send-email 2.34.1
Message-Id: <20250806101337.3350-1-huangxianliang@lanxincomputing.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Received: from LeonHXL.localdomain ([116.237.111.137]) by smtp.feishu.cn with ESMTPS; Wed, 06 Aug 2025 18:13:44 +0800
References: <1f419739-4233-474d-b00a-4e1237352691@web.de>
Date: Wed,  6 Aug 2025 18:13:37 +0800
Subject: Re: Re: [PATCH] iommu/riscv: check pte null pointer before use
X-Original-From: XianLiang Huang <huangxianliang@lanxincomputing.com>
Content-Type: text/plain; charset=UTF-8
Cc: <alex@ghiti.fr>, <aou@eecs.berkeley.edu>, 
	<huangxianliang@lanxincomputing.com>, <iommu@lists.linux.dev>, 
	<joro@8bytes.org>, <linux-kernel@vger.kernel.org>, 
	<linux-riscv@lists.infradead.org>, <palmer@dabbelt.com>, 
	<paul.walmsley@sifive.com>, <robin.murphy@arm.com>, 
	<tjeznach@rivosinc.com>, <will@kernel.org>
From: "XianLiang Huang" <huangxianliang@lanxincomputing.com>
X-Lms-Return-Path: <lba+268932ad8+86d4b4+vger.kernel.org+huangxianliang@lanxincomputing.com>
Content-Transfer-Encoding: 7bit
To: <markus.elfring@web.de>

Sure, will change to "Check the pointer before..." in a new version, thanks.

Regards,
XianLiang

