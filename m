Return-Path: <linux-kernel+bounces-896572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A627CC50B3A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 07:27:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5386934A415
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 06:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B77632DD60E;
	Wed, 12 Nov 2025 06:27:33 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 659812D6409
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 06:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762928853; cv=none; b=p2CHcBOviB0OAdTIHaKmkA5iH0F9bSJioCTmPemdiL1EtSI/9IZeAsR0n5eWSGc+iTsw701WQ98jgPsAbUft2GmIpx5EdNEGOIyZ12n0LDg7H9WRCgnwWmeEf7912pckX144LGfCWSs0lU2ZFn784ctz5JnpJv+x0P0owrRrpCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762928853; c=relaxed/simple;
	bh=hyP2mu8Bl3tEOnaKH4FeSK4LtjSpUUwu+x4dHknwys4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aWs6bKqsyBc4AzyntnhqbE/gsZ4uM4gmWDgj0VXp7xGMMZrTQhACYcJ+H7nKCVFyYAkAFYNw8hqxz4pArh8ipRSJhRDy9qmEWsTxt7EWvz/xCyua91oScWBEk0p83q3E075fk8rrPEFtW8qx8Ke0DOxCxKC/CtM9ePAAbV+6yOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ECAC51515;
	Tue, 11 Nov 2025 22:27:22 -0800 (PST)
Received: from MacBook-Pro.blr.arm.com.com (unknown [10.164.18.56])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7E4473F5A1;
	Tue, 11 Nov 2025 22:27:27 -0800 (PST)
From: Dev Jain <dev.jain@arm.com>
To: catalin.marinas@arm.com,
	will@kernel.org
Cc: ryan.roberts@arm.com,
	rppt@kernel.org,
	shijie@os.amperecomputing.com,
	yang@os.amperecomputing.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Dev Jain <dev.jain@arm.com>
Subject: [PATCH 0/2] arm64/mm: A fix and a documentation bit for change_memory_common()
Date: Wed, 12 Nov 2025 11:57:14 +0530
Message-Id: <20251112062716.64801-1-dev.jain@arm.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The first patch is a fix to prevent suppression of error encountered during
linear map alias permission change. This is needed because the rodata=on
security measure requires us to proceed only if we first do the linear map
alias protection change.

The second patch documents why linear map split failure during the vfreeing
path isn't problematic.

Dev Jain (2):
  arm64/pageattr: Propagate return value from __change_memory_common
  arm64/mm: Document why linear map split failure upon vm_reset_perms is
    not problematic

 arch/arm64/mm/pageattr.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

-- 
2.30.2


