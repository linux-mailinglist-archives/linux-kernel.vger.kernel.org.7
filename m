Return-Path: <linux-kernel+bounces-824617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D89F1B89ADF
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 15:30:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72DE63AA829
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 13:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B3CB30FC29;
	Fri, 19 Sep 2025 13:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BT8lHOM3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DADA72F83BA;
	Fri, 19 Sep 2025 13:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758288609; cv=none; b=di9JvXDE9MSHUPRFWbk2kdch4EF5ntf9DD5s086i1hatHKBp+y5wsJqNS0oobuOXcJiFeq5x8l1hlzeQ0Xijygtc8/qmLVWk/E2RdX3bk8RigHINWfDlXnxK0pCyELhnkgc5rPlRjnf1uvpxwfR64FxI4VdpeMlERKN20FuGgCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758288609; c=relaxed/simple;
	bh=LUp0Tnx3fiLxfm7kQ6s7noGa/CaWiOokB9OgbwxfWS8=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KcG1PMb8FAX3nTE2cX51OM5wvTYihT2Trg6TOwGo0IJK6T0wxPdNHkgq7Mf4fyvfhTIxpoP6mVc0wby0PP4KizEZn1waapHM7xBMbqUMFv32N+vVONha2cic65sALmfwl6LVm6u4dUw5iVLYSEMkAh3eu/MMFDAxrp/mwDcwCYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BT8lHOM3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2AB7C4CEF0;
	Fri, 19 Sep 2025 13:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758288608;
	bh=LUp0Tnx3fiLxfm7kQ6s7noGa/CaWiOokB9OgbwxfWS8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BT8lHOM3I4bB2m5+2+AEpLV7ee9YuEzThzZXU6Nggv6cs/ik2l0a6NeAxgI5XY4ZJ
	 7/q2l6us8LuJSJT/ACJx+H5P69sAjiqpb2jUKpA9KvEtb4oFX/Ezmm3FJtxiFvBDrY
	 TGo9hy+HjXz4csvOmIoJIPj/k8xXb9/j4oMmzOhfBY/RLy+a8P1P/ksEJln733vEXe
	 GMHcHxgoZny42Rhb6ZWoSJ34oDwK6t05WwbU5PUM7TkLLW4w1vCRYpKtHxNyo53Nsz
	 dNgVpgEzhPO3itr9+pwUe2P4LOPpt+R367ejuRgezbzFJJbOGtxatPh1jqyUXDHYxR
	 3dNPdP1ULihEg==
Received: from 82-132-233-255.dab.02.net ([82.132.233.255] helo=lobster-girl.misterjones.org)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <maz@kernel.org>)
	id 1uzbBd-00000007muj-41hV;
	Fri, 19 Sep 2025 13:30:06 +0000
Date: Fri, 19 Sep 2025 14:29:59 +0100
Message-ID: <87348izi20.wl-maz@kernel.org>
From: Marc Zyngier <maz@kernel.org>
To: James Clark <james.clark@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Oliver Upton <oliver.upton@linux.dev>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Leo Yan <leo.yan@arm.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-doc@vger.kernel.org,
	kvmarm@lists.linux.dev
Subject: Re: [PATCH v8 07/12] KVM: arm64: Add trap configs for PMSDSFR_EL1
In-Reply-To: <20250901-james-perf-feat_spe_eft-v8-7-2e2738f24559@linaro.org>
References: <20250901-james-perf-feat_spe_eft-v8-0-2e2738f24559@linaro.org>
	<20250901-james-perf-feat_spe_eft-v8-7-2e2738f24559@linaro.org>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL-LB/10.8 EasyPG/1.0.0 Emacs/30.1
 (aarch64-unknown-linux-gnu) MULE/6.0 (HANACHIRUSATO)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-SA-Exim-Connect-IP: 82.132.233.255
X-SA-Exim-Rcpt-To: james.clark@linaro.org, catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com, corbet@lwn.net, oliver.upton@linux.dev, joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com, peterz@infradead.org, mingo@redhat.com, acme@kernel.org, namhyung@kernel.org, alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com, leo.yan@arm.com, anshuman.khandual@arm.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, linux-doc@vger.kernel.org, kvmarm@lists.linux.dev
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

On Mon, 01 Sep 2025 13:40:36 +0100,
James Clark <james.clark@linaro.org> wrote:
> 
> SPE data source filtering (SPE_FEAT_FDS) adds a new register
> PMSDSFR_EL1, add the trap configs for it. PMSNEVFR_EL1 was also missing
> its VNCR offset so add it along with PMSDSFR_EL1.
> 
> Tested-by: Leo Yan <leo.yan@arm.com>
> Signed-off-by: James Clark <james.clark@linaro.org>

Given that this is completely independent of this series, and that KVM
is already aware of FEAT_SPE_FSD (if only to make sure the registers
actively UNDEF), I'll take it into the KVM tree directly.

	M.

-- 
Jazz isn't dead. It just smells funny.

