Return-Path: <linux-kernel+bounces-667845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D4BAAAC8AA6
	for <lists+linux-kernel@lfdr.de>; Fri, 30 May 2025 11:24:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB0A27A41E2
	for <lists+linux-kernel@lfdr.de>; Fri, 30 May 2025 09:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54914220681;
	Fri, 30 May 2025 09:24:13 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97C2621E0BB
	for <linux-kernel@vger.kernel.org>; Fri, 30 May 2025 09:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748597053; cv=none; b=F+aNgizpGCXk4ok8Od27RRI0Y2Any6kWoC//U1c4c3F/qrV204dSjao1QLWaWIL+fkSz4Dyhp2NPv0D2RMRCxSKvJBxizSgnNv7q2AbD6ERaLG0qI1sly/7ng1TIeTo7x39CP61nCBwQK4ZVo6kxVyvItlvAsoVCJIp9WzYVNFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748597053; c=relaxed/simple;
	bh=fnG+0XDws3NnDGYdrEF+fT5VwwoGblIyqeGEyFrxjhA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=S4mLIO9opXquj1q/uxxo4BuXlOgBg/FPT6FdEXhGclav2osYmPoz7S98leo6KWRDmoHTMcPlw5EW1eKA2s21SAfCAwEs6IqSdtEHPp7dUMOEgmepN1GzO4GGrCXVzsIWYCnEv5hFq7h3D4zVJh2P8ie5OJNHmKrdUCUTR1hWFSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4ED8416F2;
	Fri, 30 May 2025 02:23:54 -0700 (PDT)
Received: from MacBook-Pro.blr.arm.com (unknown [10.164.18.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id DF2DC3F5A1;
	Fri, 30 May 2025 02:24:04 -0700 (PDT)
From: Dev Jain <dev.jain@arm.com>
To: dev.jain@arm.com
Cc: Liam.Howlett@oracle.com,
	akpm@linux-foundation.org,
	catalin.marinas@arm.com,
	david@redhat.com,
	gshan@redhat.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	lorenzo.stoakes@oracle.com,
	mhocko@suse.com,
	rppt@kernel.org,
	steven.price@arm.com,
	surenb@google.com,
	suzuki.poulose@arm.com,
	vbabka@suse.cz,
	will@kernel.org,
	ryan.roberts@arm.com,
	yang@os.amperecomputing.com,
	anshuman.khandual@arm.com
Subject: Re:  [PATCH 0/3] Enable huge-vmalloc permission change
Date: Fri, 30 May 2025 14:54:00 +0530
Message-Id: <20250530092400.19586-1-dev.jain@arm.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20250530090407.19237-1-dev.jain@arm.com>
References: <20250530090407.19237-1-dev.jain@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Brilliant, after running get_maintainers I forgot to Cc the
most imp people for this :( +Yang and Ryan, along with
Anshuman.


