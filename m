Return-Path: <linux-kernel+bounces-865932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6371CBFE5B1
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 23:56:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FCD93A7CBA
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 21:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A1C3303A1C;
	Wed, 22 Oct 2025 21:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h/ruL/Qs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC9B35B123;
	Wed, 22 Oct 2025 21:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761170173; cv=none; b=gYGlhihJkBHzVZ4MGP+KwgNvkCH5cagywWisD77PQ47m+PFnLd1caeTBOGth/W16f2acV96JcrLhb4nrDLUKP4z2F90XlJprfCr4dETEMXuGr3gnr5+kTPGnqNvA0nAAesbkofRn8mHgorIimMXHUd79XR8uTJmvUPCubEaxJX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761170173; c=relaxed/simple;
	bh=1gKB0nXP8kgeAcp5I6IH0jEpL4MMmJYOLrlYmv9Gl4U=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=WUSic6lQyRuGktgawA6YSsPuETd13am9T28JWPoCNp7tOkEzW1pJC9il/MlntWJyOM8LUBUiby9NckXMTZXulCZrPS9SvSjLxThtQxY+pFKXs3TtvjEqJaCRM4D5bMwIX4KuaVvukRqywkKj/UvzMs1wMlYRehr3rbDAobmQ50s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h/ruL/Qs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFB33C4CEE7;
	Wed, 22 Oct 2025 21:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761170173;
	bh=1gKB0nXP8kgeAcp5I6IH0jEpL4MMmJYOLrlYmv9Gl4U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=h/ruL/Qsp09JybMoXAyMMMCKs/jSlS6yXaGZ4d8npxNVbLBpEp5Nx9FzJNycUdrpn
	 gaXX0bTBs0b+SPBSmRtTbm70ZJ9fvsmsZg7g0g/9kOZIqzeeryUgTN5P4+72sFn165
	 /Jeq8nFZNQ+XOoKkXfVoLofm2rsfdVZDrQ8m3b/o+/mXAZYAJbEPLdkKRMLOThg4RP
	 P4Q3tgSPuISaGANHffOaL57hwBdp0fdBUpoHnXI1cgP0YQU1bR92JupvIYTmr16iwS
	 AxamLzvPNLDceTlUbxSdl0ACG1ItvlUo7nwDpFCJ0B7QT3ovaitnZ45Z9491RS9nqc
	 3tIgnvZ/anfAw==
Date: Wed, 22 Oct 2025 11:56:11 -1000
Message-ID: <3f1f44c285a850ecf2ce0937e1cde88b@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: void@manifault.com, arighi@nvidia.com, changwoo@igalia.com
Cc: linux-kernel@vger.kernel.org, sched-ext@lists.linux.dev
Subject: Re: [PATCH 1/7] sched_ext: Use rhashtable_lookup() instead of rhashtable_lookup_fast()
In-Reply-To: <20250922013246.275031-1-tj@kernel.org>
References: <20250922013246.275031-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

> Tejun Heo (1):
>   sched_ext: Use rhashtable_lookup() instead of rhashtable_lookup_fast()

Applied to sched_ext/for-6.19 with the suggested Requires tag.

Thanks.
--
tejun

