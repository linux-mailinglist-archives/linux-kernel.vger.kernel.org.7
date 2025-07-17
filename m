Return-Path: <linux-kernel+bounces-734729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6DC7B0856A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 08:50:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EA24583E51
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 06:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09019217F36;
	Thu, 17 Jul 2025 06:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="nKS3kil0"
Received: from r3-11.sinamail.sina.com.cn (r3-11.sinamail.sina.com.cn [202.108.3.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F2020ADEE
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 06:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752734991; cv=none; b=cNjUMCC2zzez0h3sBkVFH458SAKY9VJzU1bPs5z7de1MEfEVNz/LKgj1qbuJr4X2ZDTKfdzMMDaEf5pMbwSTmT0HOaAQ72FpAKhD0ZueD6ALM0HlOxIGCOPMUxDmkh7iQeWg4QL2AebCJRvBOPt6Ez+UCMCsBZ+yZZhmq7dkRso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752734991; c=relaxed/simple;
	bh=wVsuCK14a1P6JMd16vHDqe5/2Xb3Aw0iQ2/sRnGhypU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oe1H2wujmVm/cB0lC5izBNsdGsnyWzeWxJlT9AZmpKaDOGvqpwSgNK59mJUBhi/auSkX8fp/zf7TPtq0g5D93jhIe9mioKc/CzGPj+41nC9/WigO8abKh1UF4zDoGMfs/awc2Md4qXrp7hHcf255Oudw+NCRm5G4rhGltDFU3Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=nKS3kil0; arc=none smtp.client-ip=202.108.3.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1752734986;
	bh=cV9LTDPQ1WlqYhemRhGNzLA+FZ8dwdIAovrSfPy+P8A=;
	h=From:Subject:Date:Message-ID;
	b=nKS3kil0XxQssQyRnuhsQKuvg1GYpj7xFSFiID34ItxMsi1ze/Cdxd66EoI4PYlG6
	 H1tRaIhYBOpBlpCMFZFe5YNuOE0rzD5LebeWBPDs5ZH1j9p2N6buVIrEcWrerluinv
	 6TgFlHsfGtzM8/ZGVhteKX0Gcqvjk3ZNxO2A01DM=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.34) with ESMTP
	id 68789CFE00000F89; Thu, 17 Jul 2025 14:49:36 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 1392216291954
X-SMAIL-UIID: 881A8BDE14F849969A789E1121C6494F-20250717-144936-1
From: Hillf Danton <hdanton@sina.com>
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: akpm@linux-foundation.org,
	mhocko@kernel.org,
	hannes@cmpxchg.org,
	Roman Gushchin <roman.gushchin@linux.dev>,
	shakeel.butt@linux.dev,
	yosryahmed@google.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] mm: introduce per-node proactive reclaim interface
Date: Thu, 17 Jul 2025 14:49:24 +0800
Message-ID: <20250717064925.2304-1-hdanton@sina.com>
In-Reply-To: <20250623185851.830632-5-dave@stgolabs.net>
References: <20250623185851.830632-1-dave@stgolabs.net> <20250623185851.830632-5-dave@stgolabs.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Davidlohr Bueso <dave@stgolabs.net> writes:

> This adds support for allowing proactive reclaim in general on a
> NUMA system. A per-node interface extends support for beyond a
> memcg-specific interface, respecting the current semantics of
> memory.reclaim: respecting aging LRU and not supporting
> artificially triggering eviction on nodes belonging to non-bottom
> tiers.
>
> This patch allows userspace to do:
>
>      echo "512M swappiness=10" > /sys/devices/system/node/nodeX/reclaim
>
When kswapd is active, this is not needed.
When kswapd is idle, why is this needed?

