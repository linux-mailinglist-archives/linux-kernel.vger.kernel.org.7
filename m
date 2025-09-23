Return-Path: <linux-kernel+bounces-829200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32D50B9681F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 17:12:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A005C16555F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 15:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA28025A34B;
	Tue, 23 Sep 2025 15:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ivk6Y6q3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3505025BF14
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 15:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758640305; cv=none; b=cljwSemUF76Cxp4zBe7Koa27xqJogY5RXotMUXz30P+sYI9ZZbF4HgCVmMpBLCFiRKZVja20Y+AukFfSgx1dJsy3b16p3X9iMcqO+F5nv6J646hhLbT8vEv4S8n9uH1y7syBSionuqn0UXII3lzdzA12INZ14hpCFGUWdWIz48U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758640305; c=relaxed/simple;
	bh=Jg8NyNnm3ygZruQrLaXKxRUkvldfXlHoI/AdM50St80=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=YPEN0RWjJw6NK9S8ocxaOM52mf875sWkR3vwqdE76iMd/Vzn6SMDsSp0b4AYToYDGmclXN9QqNfgsRELer2ZBIZwG6W1jTf+xTvsm+oegW07wEcaChHeb6+wjj7bqeCd1sOJAbuDSjjiXZqrcRMqh2aeqyfG/U7njBMQUzfwF3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ivk6Y6q3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B46A0C4CEF5;
	Tue, 23 Sep 2025 15:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758640304;
	bh=Jg8NyNnm3ygZruQrLaXKxRUkvldfXlHoI/AdM50St80=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ivk6Y6q3xxn+X3Ha4CWZJEPN49JWLEVeqMIIdmcFbM2VSIy7JUFVXKAgv4NgLwYCS
	 pcSKv2QEsBbzTvfkcMNvav8n/jGv6JRbTzLpVYG/Batrxxl1Th9DrTwJmRIRbqHmPX
	 6OdHzonAnMF9o08YmRPwF6h38bV9TiwiN6SYae+4/M6OBDn8QebZgVv4og2Gyx/kwB
	 ifKxeVUE3E8J+haL3NKu2fwH620gJx8pU+YaUYoAV7O9wYL0dK5DnUISPh3ni+yr8L
	 llCPrQDyYQRbYSwNfJLYwmvvM7SJEe4vX4nzbo45uL/fzi8ziUQUpxS3JDESPQTHLt
	 Dk0ea7gszxsVw==
Date: Tue, 23 Sep 2025 05:11:43 -1000
Message-ID: <986d447360eba95adf07c893b4a3a43e@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>, Christian Loehle <christian.loehle@arm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched_ext: Verify RCU protection in scx_bpf_cpu_curr()
In-Reply-To: <20250923091634.118240-1-arighi@nvidia.com>
References: <20250923091634.118240-1-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

> Andrea Righi (1):
>   sched_ext: Verify RCU protection in scx_bpf_cpu_curr()

Applied to sched_ext/for-6.18.

Thanks.

--
tejun

