Return-Path: <linux-kernel+bounces-765305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7477B22E6D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 19:01:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D3EB1889BB1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 16:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 140232FABEB;
	Tue, 12 Aug 2025 16:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b="RcV+n56/"
Received: from gentwo.org (gentwo.org [62.72.0.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 051582C3749
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 16:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.72.0.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755017831; cv=none; b=JIvOVHxuIB5ib42YwyXYKHAG3ZExS/+5/ZTa7u+TYdMdD7Yu0oK8YpY9ajGvHI1vxYfuYoxNP8w1xmxLJ4g5oYT2ptRi03aS87PeFthm+o6nxsHWW5PuHt7nNyAHQvvKXfZiteNfN1JgKTXMqjczdMwUr5kMzxn+zysomFifbUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755017831; c=relaxed/simple;
	bh=LITNVwYsu3oS8l/rbSIF4z8H+oLpOrzXSpVP2kU7r8k=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=sl3zzzuPzgOUwsxjtAYVhR2aAfQzlm+uwCwoRAluIgHJsKa89XEPIOaVn1aqI0O5GZP1xALIMc7KAO7goUncwvLMHxHQ8cqifAK68v7b+Qdh1IUILbdc4Fewew8HPuhUwu2uJIkuKOhP/I4FdvkZoyJKPf+xik4p0gRQ+t86VLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org; spf=pass smtp.mailfrom=gentwo.org; dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b=RcV+n56/; arc=none smtp.client-ip=62.72.0.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentwo.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.org;
	s=default; t=1755016387;
	bh=LITNVwYsu3oS8l/rbSIF4z8H+oLpOrzXSpVP2kU7r8k=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=RcV+n56//A5TUysROsD7GbH1UfQ2bKozgbi5OYUlMnxswa/FA+2vGCd3rSJaPwyJP
	 bk+elX6ttJIr4JNVohG341E+D0QGpH5wl0/VUYQUfMUxyozSiFtaYp0u5a2RlZLVJb
	 FW2YTV5+geG2g6GeAJzdhQbIYAVyk1s5Dx+d57Qs=
Received: by gentwo.org (Postfix, from userid 1003)
	id 72FA14025D; Tue, 12 Aug 2025 09:33:07 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by gentwo.org (Postfix) with ESMTP id 72019401EB;
	Tue, 12 Aug 2025 09:33:07 -0700 (PDT)
Date: Tue, 12 Aug 2025 09:33:07 -0700 (PDT)
From: "Christoph Lameter (Ampere)" <cl@gentwo.org>
To: Jeremy Linton <jeremy.linton@arm.com>
cc: Huang Shijie <shijie@os.amperecomputing.com>, catalin.marinas@arm.com, 
    will@kernel.org, patches@amperecomputing.com, 
    Shubhang@os.amperecomputing.com, krzysztof.kozlowski@linaro.org, 
    bjorn.andersson@oss.qualcomm.com, geert+renesas@glider.be, arnd@arndb.de, 
    nm@ti.com, ebiggers@kernel.org, nfraprado@collabora.com, 
    prabhakar.mahadev-lad.rj@bp.renesas.com, 
    linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: defconfig: enable CONFIG_SCHED_CLUSTER
In-Reply-To: <e47757c3-6091-43b5-ba28-52e11de7d86a@arm.com>
Message-ID: <cb383a76-8848-44cd-6f32-fd30478d9ebd@gentwo.org>
References: <20250808025533.6422-1-shijie@os.amperecomputing.com> <e47757c3-6091-43b5-ba28-52e11de7d86a@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 11 Aug 2025, Jeremy Linton wrote:

> From what I've seen, SCHED_CLUSTER seems to be a bit of give and take
> depending on benchmark and machine. I'm not sure if it should be default
> enabled or not, but it would really be nice to have at least a larger sweep of
> benchmarks/machines in order to be sure of the decision.

If the hardware provides a clusterid then I think this clusterid should be
used for the sched domains. CONFIG_SCHED_CLUSTER does that. So it should
be the default.

If there is no cluster information then these domains should not be
created. I think that is already the case?



