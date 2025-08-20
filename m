Return-Path: <linux-kernel+bounces-776776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 56AF4B2D167
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 03:30:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0517C1BC6B6B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 01:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8BEE1DBB13;
	Wed, 20 Aug 2025 01:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="NEoVU50w"
Received: from mail3-162.sinamail.sina.com.cn (mail3-162.sinamail.sina.com.cn [202.108.3.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 421CF213E90
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 01:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.162
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755653402; cv=none; b=B6xFsI0C0L2iVIjK3LiGkA8CFl7xE5VVJLvBOXc1E3uk/XkjCMm1u3t9T0t35uH1v91WvQthL2XknWQ7Kxt8Nbprvtlv2Y4DVL89gcKSwyLfZh2ojPEqnfk0shkMdpIHEh71HQRXeFGb9wZ6rZ2X/mAyV0pvt0ScrGVOT0wfLTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755653402; c=relaxed/simple;
	bh=B7x9YJ2q7eYQKW40cQTMVihS5X2CsrLGTxTrSmXzj+Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t20DxSa17fEiUKuYjOGGdsRF/fC6J/Hh7l/wAsnBYmic/BZIaMsG5Pieda5l7OQXa4M4pDtSoOfDmcX15pWhElrL2ZyI7dOjM7jRiDBhkVAfAoH2SPnDrlumeAfDfE1YKoOeCU6rVM1qjwzYDObsRkmQuoCZ0NjB4iP3ETCML38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=NEoVU50w; arc=none smtp.client-ip=202.108.3.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1755653397;
	bh=IDafkYWgS7KusKN99KHqr7eNp5lhr4MsE3lDHCQLm5I=;
	h=From:Subject:Date:Message-ID;
	b=NEoVU50w6dOmGIw6VDutc8vKcAK4SSnkd27k1tFwVFDhZUUfxpcqWoGFcmAlnV5Ij
	 kOzMY4rF6Hqd2pa5reBp1SSqSbMv96Gf/uHj//02dw7dCBeHAHCsSZUekn6bMwNkKF
	 TKNLHRRe0DGzy3L0sYmxbcET/gF15IPzO3oiUkJM=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.34) with ESMTP
	id 68A524E600007DD3; Wed, 20 Aug 2025 09:29:13 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 894876291954
X-SMAIL-UIID: 7B0216A86C964D598B3BEA84EA01C3B9-20250820-092913-1
From: Hillf Danton <hdanton@sina.com>
To: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Chris Mason <clm@fb.com>,
	Michal Hocko <mhocko@suse.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/page_alloc: Occasionally relinquish zone lock in batch freeing
Date: Wed, 20 Aug 2025 09:29:00 +0800
Message-ID: <20250820012901.5083-1-hdanton@sina.com>
In-Reply-To: <20250818185804.21044-1-joshua.hahnjy@gmail.com>
References: <20250818185804.21044-1-joshua.hahnjy@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 18 Aug 2025 11:58:03 -0700 Joshua Hahn wrote:
> 
> While testing workloads with high sustained memory pressure on large machines
> (1TB memory, 316 CPUs), we saw an unexpectedly high number of softlockups.
> Further investigation showed that the lock in free_pcppages_bulk was being held
> for a long time, even being held while 2k+ pages were being freed.
> 
> Instead of holding the lock for the entirety of the freeing, check to see if
> the zone lock is contended every pcp->batch pages. If there is contention,
> relinquish the lock so that other processors have a change to grab the lock
> and perform critical work.
> 
Instead of the unlock/lock game, simply return with the rest left to workqueue
in case of lock contension. But workqueue is still unable to kill soft lockup
if the number of contending CPUs is large enough.

