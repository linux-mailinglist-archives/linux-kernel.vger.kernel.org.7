Return-Path: <linux-kernel+bounces-802545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 614F5B45393
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 11:41:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C95D7ACA9E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 09:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DABB1283683;
	Fri,  5 Sep 2025 09:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qQKQUc4r"
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896E3283FFA
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 09:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757065295; cv=none; b=nbFI4FQ3Fusl6Te/w7IGc/+uJh3GeSWFfeDYtk405UvXYrsGHS+rKoBRxk9R1sXsJzbqvnwchOfVGmIJ45VeaJzPFPENub/gZEG2Q6JUwUCXS7yBWsdFbwT+yUmiXiSlMHGBmbVlyOi7kgt7fYzCC72fe5S3J7yFJmbrRyvEE+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757065295; c=relaxed/simple;
	bh=WFFFe+YY5Z20PKUMXrEZ7PLZOjEeLnGn1ppTLHfM0HU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aqFPDm/9X9qFQ3iTc+PN4pSkxUl+On0iohxpa1OGxF2dws9to0q6ud9fYkDxqWjsCO4179+yNLYqGgpNLSrAEy1aUixg54kqfZ/d9nDTw/0lO9rqd+sJls5sWYKTsunkgdHI2mTNZTN3g5L8pABL7s3KWwO2kE+GfbpJHkrbHOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qQKQUc4r; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757065291;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iU8cYU3B3yAKoLkyUXfgY8bgL90q9YRQAluD1Tl1gR4=;
	b=qQKQUc4rbHC+yqm4Kw1VeM0/JPrfqHRYxOrwTqeA5pOc0roLCustMIbsbrG7juGN2ZgXRP
	72KpUaYOUhlowN4HRoX/+CdnjXthMu7ipFrjbsTPjf/ZMszRxqI7gksxdtcC+QMi40jmNK
	xYZKYe7wSpvtcR/MXTIzXtdtnjZhogI=
From: Oliver Upton <oliver.upton@linux.dev>
To: kvmarm@lists.linux.dev,
	Geonha Lee <w1nsom3gna@korea.ac.kr>
Cc: Oliver Upton <oliver.upton@linux.dev>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Marc Zyngier <maz@kernel.org>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Subject: Re: [PATCH] KVM: arm64: nested: fix VNCR TLB ASID match logic for non-Global entries
Date: Fri,  5 Sep 2025 02:41:10 -0700
Message-Id: <175706523473.1669883.17269564627952159753.b4-ty@linux.dev>
In-Reply-To: <20250903150421.90752-1-w1nsom3gna@korea.ac.kr>
References: <20250903150421.90752-1-w1nsom3gna@korea.ac.kr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On Thu, 04 Sep 2025 00:04:21 +0900, Geonha Lee wrote:
> kvm_vncr_tlb_lookup() is supposed to return true when the cached VNCR
> TLB entry is valid for the current context. For non-Global entries, that
> means the entry’s ASID must match the current ASID.
> 
> The current code returns true when the ASIDs do *not* match, which
> inverts the logic. This is a potential vulnerability:
> 
> [...]

Applied to fixes, thanks!

[1/1] KVM: arm64: nested: fix VNCR TLB ASID match logic for non-Global entries
      https://git.kernel.org/kvmarm/kvmarm/c/06f66db9bda4

--
Best,
Oliver

