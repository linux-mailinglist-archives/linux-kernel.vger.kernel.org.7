Return-Path: <linux-kernel+bounces-750271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9F57B1595A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 09:12:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C282C3AF5CD
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 07:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1C59224256;
	Wed, 30 Jul 2025 07:12:06 +0000 (UTC)
Received: from unicom145.biz-email.net (unicom145.biz-email.net [210.51.26.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ACB021FF2B
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 07:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.26.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753859526; cv=none; b=EuucnsbRhKWbM/bY+ARJP0NQG14VX5N5rlLVKCJEQxDGHQb4zrUq9OsImFqM6BJb17APBOZCnO0ybQeNLqtGILtCODBef/sSb34YaOBSeL9r4RxflS5azoSGsmqCQUltR7Dyuuzk8sfCUfL0tqp256FGN6sw2xs/D1U2gYaxL1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753859526; c=relaxed/simple;
	bh=2fWlqY22QCcbwVVuEaZ1oytimU7BimITytlXmQs7NNw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i9oCzWahVH7H5haQK2IoB7pVzIu794HSTeYwbTgYcNrbFyXZKjpIAUhKvfkpzKoy+K6tCca3sp1FC0rPDS0OfUTykRjLCPh+kMKOLpICv/qltF4cFkyMeSKaNFqzYccz8HOiMACc8l/d2IHL+uqFTxdGAlhiqYOsORF+nPzfAEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.26.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from jtjnmail201603.home.langchao.com
        by unicom145.biz-email.net ((D)) with ASMTP (SSL) id 202507301510512893;
        Wed, 30 Jul 2025 15:10:51 +0800
Received: from localhost.localdomain.com (10.94.10.113) by
 jtjnmail201603.home.langchao.com (10.100.2.3) with Microsoft SMTP Server id
 15.1.2507.57; Wed, 30 Jul 2025 15:10:49 +0800
From: chuguangqing <chuguangqing@inspur.com>
To: <lkp@intel.com>, <maarten.lankhorst@linux.intel.com>,
	<mripard@kernel.org>, <tzimmermann@suse.de>, <airlied@gmail.com>,
	<simona@ffwll.ch>
CC: <llvm@lists.linux.dev>, <oe-kbuild-all@lists.linux.dev>,
	<dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] gpu: drm: fix compilation errors in drm_vram_helper
Date: Wed, 30 Jul 2025 15:09:17 +0800
Message-ID: <20250730071002.2697-1-chuguangqing@inspur.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <202507300646.kTchyjvh-lkp@intel.com>
References: <202507300646.kTchyjvh-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
tUid: 2025730151051cdb962acdcf8dce77254f561bd1f48ac
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

I see. This compilation error was caused by the configuration option not automatically selecting DRM_TTM_HELPER. A revised version of the PR has been submitted.


