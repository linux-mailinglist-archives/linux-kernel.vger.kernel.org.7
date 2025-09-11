Return-Path: <linux-kernel+bounces-812534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A5ACB5394C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 18:31:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5CD4AA2168
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 16:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 595A935A287;
	Thu, 11 Sep 2025 16:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EQVSBVlH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B16BD1DBB3A
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 16:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757608152; cv=none; b=P6ITjuFWhV/ceuH8DfI6cHY+SON9ugAJR/YOSthCCERXdKyoGor/ZUYqYj2CNHoByXWxSQWyUkjCbpdEePK67zSefomXXd5lI5NMKAD5cjZlYX2qbfSvOsdHmiRX8WqN4Z4s2FrCLKj+2Wlriz/2BdxbwAY73H+m4KyEAneMBNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757608152; c=relaxed/simple;
	bh=TW/QWdcOac5VMW5eGwM2hpRoSflukqeI/0uzgGAsdAQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TiCCRt7+hFvUZDK4FjDA743EgbgKVuLM4JvQdtI9a0gpHz3kliJfQqBicdk913SUWyDduPwdkBI7zrPo7IusX15R4wcgyaj+2TNE9mza7U7QYjAMzdnHypaQsc2/RyOKNfKSN3Veft8PzMdrVe6Z6sVo+ku+R+3Blz8d8YR8ESE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EQVSBVlH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2670C4CEF0;
	Thu, 11 Sep 2025 16:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757608152;
	bh=TW/QWdcOac5VMW5eGwM2hpRoSflukqeI/0uzgGAsdAQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EQVSBVlHaZBXIpMs/HCN17KmwuHBtbC6mimWSrLqNpcdwT0penDM/ARYWkCD3tHaH
	 NWDdL9DIOApPBq4aWUr7+2YnhhgzGSE3RgroymftTgfBCoQ0Q7Zi0BFGUvH6mvsCWQ
	 ZarpBYfAptquCqOwR6mVQieHHsVwVTgHiPebTzPkuC+ndZ5VuCRTooqYU+dKYlLeoG
	 azfhd2++Qq9Bz44H4rKSDy7vwW5Ovq8483Lo618qOErldJROcn3rVA0YGBvMvT3lby
	 MVfey2gD509vza60EAokTaQlp51Zr0dWbhNgqt1Pnm2vNqk0ZsfIgjNt5J5QHZTa13
	 M19UbK4T0U5ew==
Date: Thu, 11 Sep 2025 18:29:09 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Phil Auld <pauld@redhat.com>
Cc: bsegall@google.com, dietmar.eggemann@arm.com, juri.lelli@redhat.com,
	linux-kernel@vger.kernel.org, mgorman@suse.de, mingo@redhat.com,
	peterz@infradead.org, rostedt@goodmis.org, tanghui20@huawei.com,
	tglx@linutronix.de, vincent.guittot@linaro.org,
	wangtao554@huawei.com, zhangqiao22@huawei.com,
	Waiman Long <longman@redhat.com>
Subject: Re: [PATCH] sched: Increase sched_tick_remote timeout
Message-ID: <aML41e2csdTdSTNU@localhost.localdomain>
References: <aMLs5G3WvlXOAxuY@localhost.localdomain>
 <20250911161300.437944-1-pauld@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250911161300.437944-1-pauld@redhat.com>

Le Thu, Sep 11, 2025 at 12:13:00PM -0400, Phil Auld a écrit :
> Increase the sched_tick_remote WARN_ON timeout to remove false
> positives due to temporarily busy HK cpus. The suggestion
> was 30 seconds to catch really stuck remote tick processing
> but not trigger it too easily.
> 
> Signed-off-by: Phil Auld <pauld@redhat.com>
> Suggested-by: Frederic Weisbecker <frederic@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Frederic Weisbecker <frederic@kernel.org>

Acked-by: Frederic Weisbecker <frederic@kernel.org>

-- 
Frederic Weisbecker
SUSE Labs

