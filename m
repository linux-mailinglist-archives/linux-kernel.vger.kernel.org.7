Return-Path: <linux-kernel+bounces-739171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89C2EB0C2C4
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 13:23:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA05C3AA4ED
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 11:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C62E296178;
	Mon, 21 Jul 2025 11:23:29 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFA721BD01F;
	Mon, 21 Jul 2025 11:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753097009; cv=none; b=UZcFH9qGlBS4v3XVW7OjYb0HrrlYJ+EQahocn5nBsYPlkFG0o5Lx6ojLowCMKpxKeWiYTj8VznjN8mN1qHXymkL3D8pyoQJUXMTw6QTpXaTXDrUrL+D0QwrG9+mklE5EZW1zTPtCJXS0H8ASmyNVeXQMSjF0iad0igzDPEDniTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753097009; c=relaxed/simple;
	bh=nMX86qWH/DokwcmCkPOp0pda2t9wzHzjzDDYj0/1ueo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vFMOm4cvBKImmT0Ezl2IHNjT2x6yXxlyCX+EmY9+c4dKnAeliUtvdfXPX8WMIguJA22Y4Y3tr0F7bdshlDgqnOop40fRyiTdoA9thgTmYtu1OdwGtwvkUl8PFjDSvr9gxROy8K2kTzDWofsA9eSqjO5jAcLx0ajvqkBtetPqkbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 619BE153B;
	Mon, 21 Jul 2025 04:23:21 -0700 (PDT)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D595A3F6A8;
	Mon, 21 Jul 2025 04:23:25 -0700 (PDT)
From: Suzuki K Poulose <suzuki.poulose@arm.com>
To: Yuanfang Zhang <quic_yuanfang@quicinc.com>,
	Dan Carpenter <dan.carpenter@linaro.org>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	James Clark <james.clark@linaro.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Leo Yan <leo.yan@arm.com>,
	coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH next] coresight: Fix a NULL vs IS_ERR() bug in probe
Date: Mon, 21 Jul 2025 12:23:13 +0100
Message-ID: <175309697456.771946.4131106247005398198.b4-ty@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <7bd9fae8-a15f-412a-8800-ce47acf0b5ce@sabinyo.mountain>
References: <7bd9fae8-a15f-412a-8800-ce47acf0b5ce@sabinyo.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Wed, 16 Jul 2025 14:38:30 -0500, Dan Carpenter wrote:
> The devm_ioremap_resource() function returns error pointers on error.
> It never returns NULL.  Update the error checking to match.
> 
> 

Applied, thanks!

[1/1] coresight: Fix a NULL vs IS_ERR() bug in probe
      https://git.kernel.org/coresight/c/f59b9437ac95

Best regards,
-- 
Suzuki K Poulose <suzuki.poulose@arm.com>

