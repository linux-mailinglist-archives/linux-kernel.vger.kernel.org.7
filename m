Return-Path: <linux-kernel+bounces-831919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F56DB9DDF5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 09:37:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1759A1B23544
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 07:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE27E285CB5;
	Thu, 25 Sep 2025 07:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="yay6zV83"
Received: from smtp153-163.sina.com.cn (smtp153-163.sina.com.cn [61.135.153.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC4D2E7BAA
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 07:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=61.135.153.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758785862; cv=none; b=p3UMW18V7PJrzrfhkZE48nurUCrYwHRmDZDgAPGRAOfr34TuKNUNcbQZgBNsY1oJOtMH6b2DcyrfH8wGDZIH7qU74Gf566M5WbpGNBpzueFCyll9yLbzs/LYEI3Eb9A2dM+dt9DwoJcflNbGmvU3evdLjwryxvArKJ995LI8YD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758785862; c=relaxed/simple;
	bh=ejbHEFq7nNOogqrVj4mFAXwNk8YZkMcEwqEBrCEZjxE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tr46fvXnyDKy3ezcEimbHvB08rMzb4cuQkKfefdP46YzeOQkX0Y8l5tP41ENhzJYGoA+B3bgwfKHk/yfyWDnPXOyXZ979YYoFwzonW7WhCRTsoHdirvmK6HdfXEjRPxJYT6MSgBtRCIXmf5R4Ewr08nU3wKU5Io0o0t1Jq2J4x4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=yay6zV83; arc=none smtp.client-ip=61.135.153.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1758785853;
	bh=WF0Zwge9l0piqg44Z4D2UOH7b6x7wNsnsGqwfiNP8Tw=;
	h=From:Subject:Date:Message-ID;
	b=yay6zV83QeUEGGQHMpBIC8YQTtZ5kKxf81HFCmf4BEDpvMVcZZAOlgrt+3vzk7KQF
	 Jp3fYMyhIZuY0uknSex4XenWjqphV16i85tOukuxrZ2QRqIV44zSI0XTa4+0ZYnSqO
	 HJNrY0rGh/hCGy8xOC5SqJxh68p4TwZ1GHltOkTw=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.32) with ESMTP
	id 68D4F13700004E9B; Thu, 25 Sep 2025 15:37:30 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 2029404456667
X-SMAIL-UIID: CE2854044B5840A2B9AFADC84C604907-20250925-153730-1
From: Hillf Danton <hdanton@sina.com>
To: lirongqing <lirongqing@baidu.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] hung_task: Panic after fixed number of hung tasks
Date: Thu, 25 Sep 2025 15:37:16 +0800
Message-ID: <20250925073717.7636-1-hdanton@sina.com>
In-Reply-To: <20250925060605.2659-1-lirongqing@baidu.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 25 Sep 2025 14:06:05 +0800
> From: Li RongQing <lirongqing@baidu.com>
> 
> Currently, when hung_task_panic is enabled, kernel will panic immediately
> upon detecting the first hung task. However, some hung tasks are transient
> and the system can recover fully, while others are unrecoverable and
> trigger consecutive hung task reports, and a panic is expected.
> 
> This commit adds a new sysctl parameter hung_task_count_to_panic to allows
> specifying the number of consecutive hung tasks that must be detected
> before triggering a kernel panic. This provides finer control for
> environments where transient hangs maybe happen but persistent hangs should
> still be fatal.
> 
Given transient, bumping sysctl_hung_task_timeout_secs up alone helps.

