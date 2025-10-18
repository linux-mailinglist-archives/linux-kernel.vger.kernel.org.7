Return-Path: <linux-kernel+bounces-859484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C0A65BEDCC3
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 01:05:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 632FB4E24E7
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 23:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CC7D2566E9;
	Sat, 18 Oct 2025 23:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J4/TpnMu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 007B8354AC9;
	Sat, 18 Oct 2025 23:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760828724; cv=none; b=KA3363kd3x1wCa7cnQ8alC7wev+CdTAixf7YyBWToKUSzdRdNLi5C5oys8KWa1BBN6JHWjCndwH8e2wo2QPu+EpIAqYbxi+rj97zhBmjDoiXNmMed5hXaDPXmImfk2scOrDUroh7A+kBNWMVr6jWvM/Ng/neiZhFLuWe+dvVCBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760828724; c=relaxed/simple;
	bh=E6Hx6lE9gcP6jwZSlDrrYe4CXVEMcRDKclDwfKJSHZM=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=pHq9yb9U7dUnpMvCYrIjoG0DJdZzs2axqwp+i0SA6NNcpjpKuu64nwdgvOeW4PUWesbuZRSbxUtjmjRQDJ8Wm+vZTUnEFfK/KMestiQHintxT20DZQomrwwO3o6WL5ssy3KJvA4LwDHLQ8Wz10OLBpZ9Ywcg8DRae3dhlqaYsqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J4/TpnMu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5618EC4CEF8;
	Sat, 18 Oct 2025 23:05:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760828723;
	bh=E6Hx6lE9gcP6jwZSlDrrYe4CXVEMcRDKclDwfKJSHZM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=J4/TpnMu97vTFMmqdRiUbbzh8mO6LcOk7Ke+kefTT6DGHuZEkyW85DLHba8N30L9a
	 ZqH7nb1UwOgeiyhpw68XKzM1Uhnm1mu1ZVvh8W+KHCJ0Zca0qoqplrrnXlIZxBAVZi
	 JrbQSwm3uxk0Ogg52zob29bn3Aod+3mVvuzkdWNrU7sUOZt+9mnbhGzRRMpblwjMY/
	 5AhRzvzNSKraYEUkrtOQMma75xb+dQARSB5nfLFrJ3OyxaB34DEujDc9r8rw3juEoj
	 eMyMQtLgQGf/HIkvRyDKqGNHHpgIyVp2O8Zj279LLzH7Ynq5qjlX/omwTHBAheMggY
	 wRxewCXbN18ww==
Date: Sat, 18 Oct 2025 13:05:22 -1000
Message-ID: <cb2ceae44e2a87287a146556f86dedd8@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>, sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched_ext: Allow forcibly picking an scx task
In-Reply-To: <20251018141014.212571-1-arighi@nvidia.com>
References: <20251018141014.212571-1-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

On Sat, Oct 18, 2025 at 04:10:14PM +0200, Andrea Righi wrote:
> sched_ext: Allow forcibly picking an scx task

Applied to sched_ext/for-6.19.

Thanks.

--
tejun

