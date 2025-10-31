Return-Path: <linux-kernel+bounces-880157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 28932C24FE6
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 13:27:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 98E133511F3
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 12:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3CDF348467;
	Fri, 31 Oct 2025 12:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Dt6ITrFV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F7C534845E;
	Fri, 31 Oct 2025 12:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761913627; cv=none; b=Uk5Hpv5kWGYfKpSuTxDWfhE7G9+LCustWmlFeby9kCxRWKzEv25rT4SgW8I1HNTwIGnz+gziKuelBaV81/lLQdxbo3/GjXhSkpQe50rCTeOH1F5yr0fAOB/DcZ/eN3bi51YhCO0JQm4QotBtOt8aveSBf6wOlEZNeCrQcWsf4yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761913627; c=relaxed/simple;
	bh=RCW/NGhtrZbMiM2IHWS3n40LEepZGpSaey0rTMR2euM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E5KIRTQYTbHAB0NVOEC8NXwXz5KijE6Jkzch0vDwafo9kQXydEBzdI9hSufdIMPfCa9/Tx1pT41cntIv9NvjUkOHS+Ubhv00NUbVMTGJhlKfv5kHCXeATVGg1MCz5DyXaNw4MOtvNjrNGe2ZfYgDt7JzRNzcN7/kESgK6PvSwvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Dt6ITrFV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FB57C4CEE7;
	Fri, 31 Oct 2025 12:27:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1761913626;
	bh=RCW/NGhtrZbMiM2IHWS3n40LEepZGpSaey0rTMR2euM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Dt6ITrFVrDYzYXId/FS1iclpFNVXcECxEt4H4Wyuf++dExc3dvd2DRxE9nLc3bPwo
	 ZDSHslx9aGfLIOzG2TskVqJidL6ZhSFuOAo4sW1e2pWdpoo2Gj93FMD8NiOwWqw5rQ
	 HV9fPsaLdHBTluo288j7zmJUKKpRh0ogrt11XcNU=
Date: Fri, 31 Oct 2025 13:27:03 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: stable@vger.kernel.org, Doug Berger <opendmb@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Doug Berger <doug.berger@broadcom.com>,
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	"open list:SCHEDULER" <linux-kernel@vger.kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	bcm-kernel-feedback-list@broadcom.com
Subject: Re: [PATCH stable 6.12] sched/deadline: only set free_cpus for
 online runqueues
Message-ID: <2025103157-effective-bulk-f9f6@gregkh>
References: <20251027224351.2893946-1-florian.fainelli@broadcom.com>
 <20251027224351.2893946-5-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251027224351.2893946-5-florian.fainelli@broadcom.com>

On Mon, Oct 27, 2025 at 03:43:49PM -0700, Florian Fainelli wrote:
> From: Doug Berger <opendmb@gmail.com>
> 
> [ Upstream commit 382748c05e58a9f1935f5a653c352422375566ea ]

Not a valid git id :(

