Return-Path: <linux-kernel+bounces-806541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 17DB4B49837
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 20:24:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6F6D180002
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 18:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D7D831C56F;
	Mon,  8 Sep 2025 18:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WVE9Ic1V"
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C4E31B128
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 18:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757355822; cv=none; b=SO3TyNEERbnoFUHSPhQGwCeFnTdCcN5Sn8MLPCckNQaQPDtct0aGfIsBlEhMcFlqiRZZbB3iA1W3bRDwv7ojCmqylvqszrMzHb6kLM2PnKKtFNFSs6jWuXJh6550yt77yIegoOGkW2r2IaHsfbAwDdTpisEsnGpUWqZv1dViI54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757355822; c=relaxed/simple;
	bh=ZN5auoWNwkucX+8mRyjY7Bvceh7ymMYV0oFPboPYlLc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DPtnNKF5fGX/AGoKm6NDalWZwx+2WcbyzqdIODNbaCSmc/+WZn43+9sTjnMqerarOqsD6f/SMfpkZ+vcN05Mnl5JHe1zGPiQfXzVRYvfpVDQwqY7CuBziBTX+zOSeaYpP+c9tIkkOM32vkEEKvNHyrnQpdYtqENshKvLmadEt6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WVE9Ic1V; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757355818;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CnlFAVoCjOytx6Qrpgy/4Sf9XW0KPkCm2GkfJqhmFe8=;
	b=WVE9Ic1V1e40Rj5dce1HfALRsDV+uAObb1IUpr45wv2v/s/9lmu3pFajN3+z84O7eRwkii
	N1lg3UWPEd9U6b5EnJ10sMHAlSw1k4rJtMOWHUGkbqVKszHFRtmgz0zo/IHm5Jmklz4zk1
	PZAidQYANPFEkqm6qj6RO5EiMVt2V8A=
From: Oliver Upton <oliver.upton@linux.dev>
To: linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Wei-Lin Chang <r09922117@csie.ntu.edu.tw>
Cc: Oliver Upton <oliver.upton@linux.dev>,
	Marc Zyngier <maz@kernel.org>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Subject: Re: [PATCH v2] KVM: arm64: Remove stage 2 read fault check
Date: Mon,  8 Sep 2025 11:23:24 -0700
Message-Id: <175735577928.2363175.2398747869709964992.b4-ty@linux.dev>
In-Reply-To: <20250908064806.4093081-1-r09922117@csie.ntu.edu.tw>
References: <20250908064806.4093081-1-r09922117@csie.ntu.edu.tw>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On Mon, 08 Sep 2025 14:48:06 +0800, Wei-Lin Chang wrote:
> In the non-NV case, read permission is always granted when mapping
> stage-2, so checking for it doesn't bring much. On the other hand,
> shadow stage-2 for NV guests could potentially have non-readable
> mappings when we align the permissions with those that L1 set for L2, we
> shouldn't be checking for read faults in this case either.
> 
> So just remove this check.
> 
> [...]

Applied to fixes, thanks!

[1/1] KVM: arm64: Remove stage 2 read fault check
      https://git.kernel.org/kvmarm/kvmarm/c/756491dd8329

--
Best,
Oliver

