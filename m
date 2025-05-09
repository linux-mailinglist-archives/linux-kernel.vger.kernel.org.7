Return-Path: <linux-kernel+bounces-641740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5AB9AB154B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 May 2025 15:34:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C07584A52DF
	for <lists+linux-kernel@lfdr.de>; Fri,  9 May 2025 13:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63F742918CE;
	Fri,  9 May 2025 13:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kcGO1I+B"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9BA72900AE;
	Fri,  9 May 2025 13:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746797613; cv=none; b=moOpFvi/pmMuJVLNAz+c5qsvgtdxNUQnGP8Tv2uXAaTJydhNeBcHpb0fs8cWjDUGrwRUFfMk925NYSfuZydrdDBTe2Yzqq2amupSX/G0mm6QrONU3+1dbfZddAeBl0I9jjmlb9/2P0yIoKfRXasFaCkuTVTT5gWjVunGhSFr6l0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746797613; c=relaxed/simple;
	bh=32hFsW28TKj8Y+S0m8jmXm0II7VOvGnGtspjW8Ik6nA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TYJC/lNqV4sdsv6461gpQsNlSpdBLFcdzDD1vOzU8c5lhjD+eCObr7Mo0ASuDbPc+aMF/qDxgP3zKI2cP7cMNB/PDBr00hOlWtk4kVKLQ5Bg6M2jXbuDuSgmQ3DPCuVHnNtyZiQpfv1RQa0MHk9P8xZxKsY9xWQ1+oOBFyWp/Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kcGO1I+B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0AAEC4CEEF;
	Fri,  9 May 2025 13:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746797613;
	bh=32hFsW28TKj8Y+S0m8jmXm0II7VOvGnGtspjW8Ik6nA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=kcGO1I+Bo/w8C9g+Q9gcuQfjOF89qik+m1D2z+SnsiyGDnQV1OiF8zhcK3rLP8cUP
	 ujPtTXrcOjuYNKymzuAu8EjXQ0WBLb9ioUbDJo4ZBiteSMA9EKuawqr5LXq4CRkVK2
	 ebfJAmgtIrK3No2WqUM/GUtT3grDlGa3boJaUaSxQp07rw+Luet30J8lrZntrrshOH
	 4ORrYGTvb8GNoVHBOdMC70hmgSyhrdPN+rCft7sL4Rnqv0eae5CD6HiatFh6lOZWBL
	 IeCbYxIYLPZZgpbcpjZuAC7OOv6gdZZHQVSlWjwFZNW7oWn87ErhLdcsfE6cso8Ich
	 nY08bMCJhXr4Q==
Message-ID: <cd25886b-9038-40f0-8404-0e0e5057e4a5@kernel.org>
Date: Fri, 9 May 2025 08:33:31 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/3] PM: sleep: Updates related to
 pm_suspend_target_state
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <5903743.DvuYhMxLoT@rjwysocki.net>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <5903743.DvuYhMxLoT@rjwysocki.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/9/2025 7:49 AM, Rafael J. Wysocki wrote:
> Hi Everyone,
> 
> This allows PM debug messages to be printed during hibernation (again) in
> patch [1/3], adds pm_suspend_in_progress() for checking if a system suspend
> transition is in progress (which does not cover hibernation) on top of that
> (patch [2/3]), and adds pm_sleep_transition_in_progress() covering both
> system suspend and hibernation (patch [3/3]).
> 
> Thanks!
> 
> 
> 

Thanks, LGTM!

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

