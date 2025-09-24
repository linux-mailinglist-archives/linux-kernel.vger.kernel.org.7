Return-Path: <linux-kernel+bounces-830904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 545E1B9ADA9
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 18:20:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F13AB3ADA7B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 16:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03F6A31329C;
	Wed, 24 Sep 2025 16:20:38 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD34A1EF091
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 16:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758730837; cv=none; b=txNWz/x7WnFEdDQ8lDDZrZAvM49WrEnJu1hpoQfjEIp/+tG+wR3c9rdvYuX8dDad1COdK9n+wvkiaL7MSH4UgkXq1qT0ZR5pDU2LxOgIoWmmA+ngMmIiuWyMZFsutoiv/sOsKOzGAlaN8ptLz2pYQe9RXb+kYc56e/aPG1FZ6eM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758730837; c=relaxed/simple;
	bh=+M9kI5puvs6+L8yEYgsKp+kkZvQcLsagU1dBNyCsDTY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=CQub1/8wdK2eU6yfICvKpdZP01CDn2fqVL2Rps0pf4mtR7ysNDzBR92dowZv0lCXgStj1qMVIULOBq0B8IeBzPsd3ampRA9F3Krj3R9fMoIMnIF7IHfWfAcUqyPughO3ApFrFC0eh2TJX4J4JBwQSlc9EQZb7z45kGCt0ES8cmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub4.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4cX1pJ594cz9sSp;
	Wed, 24 Sep 2025 18:02:48 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2C3WRkuK0BC9; Wed, 24 Sep 2025 18:02:48 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4cX1pB5TL1z9sST;
	Wed, 24 Sep 2025 18:02:42 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id AD7AF8B763;
	Wed, 24 Sep 2025 18:02:42 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id 0UckyDH9Fa_j; Wed, 24 Sep 2025 18:02:42 +0200 (CEST)
Received: from [192.168.235.99] (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 45BB28B768;
	Wed, 24 Sep 2025 18:02:42 +0200 (CEST)
Message-ID: <26615a15-3494-435f-b0c1-861122b4b5e1@csgroup.eu>
Date: Wed, 24 Sep 2025 18:02:41 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [GIT PULL] SOC FSL for 6.18
To: soc@kernel.org, Arnd Bergmann <arnd@arndb.de>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Language: fr-FR
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Arnd,

Please pull the following Freescale Soc Drivers changes for 6.18

The bus/fsl-mc changes outside soc/fsl tree are acked by maintainer of 
QORIQ DPAA2 FSL-MC BUS DRIVER.

Thanks
Christophe

The following changes since commit 8f5ae30d69d7543eee0d70083daf4de8fe15d585:

   Linux 6.17-rc1 (2025-08-10 19:41:16 +0300)

are available in the Git repository at:

   https://github.com/chleroy/linux.git tags/soc_fsl-6.18-1

for you to fetch changes up to 5498f07842cbddd86c725b960acb8e478684ca45:

   soc/fsl/qbman: Use for_each_online_cpu() instead of for_each_cpu() 
(2025-09-22 21:31:08 +0200)

----------------------------------------------------------------
FSL SOC Changes for 6.18:
- Use for_each_online_cpu() instead of for_each_cpu() in qbman
- Update FSL QUICC ENGINE GPIO driver to a standard platform driver
and stop using legacy-of-mm-gpiochip.h header
- Misc fixes on bus/fsl-mc

----------------------------------------------------------------
Chelsy Ratnawat (1):
       bus: fsl-mc: Replace snprintf and sprintf with sysfs_emit in 
sysfs show functions

Christophe Leroy (2):
       soc: fsl: qe: Change GPIO driver to a proper platform driver
       soc: fsl: qe: Drop legacy-of-mm-gpiochip.h header from GPIO driver

Fushuai Wang (1):
       soc/fsl/qbman: Use for_each_online_cpu() instead of for_each_cpu()

Salah Triki (1):
       bus: fsl-mc: Check return value of platform_get_resource()

  arch/powerpc/platforms/Kconfig          |   1 -
  drivers/bus/fsl-mc/fsl-mc-bus.c         |   9 ++-
  drivers/soc/fsl/qbman/qman_test_stash.c |   2 +-
  drivers/soc/fsl/qe/gpio.c               | 139 
+++++++++++++++++---------------
  4 files changed, 82 insertions(+), 69 deletions(-)

