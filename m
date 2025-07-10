Return-Path: <linux-kernel+bounces-725040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5653AFFA1C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 08:50:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9F634E5CC1
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 06:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81EC0280328;
	Thu, 10 Jul 2025 06:50:36 +0000 (UTC)
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56489DDC1
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 06:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.236.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752130236; cv=none; b=q82EAaY9lZ/zsxdeYFdQy1lXFUEuFfVuAP8MiVLcQiP/akpgKlEO0A+QdJiO54LjF4OoiBDTgYCRYz3RozaL7r66vmQHMVJXunJuBXrcGAZHuhgnKn+D0CVQK3mJ2pWME7cvlJRmqs4fJyhKOGeub2WQhqf3Rg7j3A79AaT4VDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752130236; c=relaxed/simple;
	bh=KnGAdQxEVp5FaRAYi/FCTRHf4G7dnqfhDf42/ixgYCk=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=bKAUSJKgI41L4580ItrTIb7WbqIyZy5K8TrXawnei5DYkFs/tS+oIWXN/wN1bImFojtltCTS1UPqp5psPF90wzgte6uCrCp/gaUDo8Ex0dD9GOwmYCXOvLWogP9Tr6mX8qWssvBUSc+jmPYmH/v6Zz+eNEChkKfOtHl3HoidLCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.236.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
	by localhost (Postfix) with ESMTP id 4bd51H2snqz9tZl;
	Thu, 10 Jul 2025 08:44:35 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
	by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PD7tMD8jOn9n; Thu, 10 Jul 2025 08:44:35 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase1.c-s.fr (Postfix) with ESMTP id 4bd5145bZgz9tHZ;
	Thu, 10 Jul 2025 08:44:24 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id B8A8E8B76D;
	Thu, 10 Jul 2025 08:44:24 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id TUROZSHQu4HZ; Thu, 10 Jul 2025 08:44:24 +0200 (CEST)
Received: from [192.168.235.99] (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 842D18B763;
	Thu, 10 Jul 2025 08:44:24 +0200 (CEST)
Message-ID: <c947d537-cae5-44f0-abd8-0c558bac46d2@csgroup.eu>
Date: Thu, 10 Jul 2025 08:44:23 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [GIT PULL] SOC FSL for 6.17
To: soc@kernel.org, Arnd Bergmann <arnd@arndb.de>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Language: fr-FR
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Arnd,

Please pull the following Freescale Soc Drivers changes for 6.17

The tegra change is outside soc/fsl tree but it is acked by maintainer 
of DRM DRIVERS FOR NVIDIA TEGRA.

Thanks
Christophe

The following changes since commit 19272b37aa4f83ca52bdf9c16d5d81bdd1354494:

   Linux 6.16-rc1 (2025-06-08 13:44:43 -0700)

are available in the Git repository at:

   https://github.com/chleroy/linux.git tags/soc_fsl-6.17-1

for you to fetch changes up to 76760b9dbbf8088ef31afb60d92b955f88ad1288:

   soc: Use dev_fwnode() (2025-07-08 10:29:28 +0200)

----------------------------------------------------------------
FSL SOC Changes for 6.17:
- Use dev_fwnode() instead of of_fwnode_handle()
- Use new GPIO line value setter callbacks

----------------------------------------------------------------
Bartosz Golaszewski (1):
       soc: fsl: qe: use new GPIO line value setter callbacks

Jiri Slaby (SUSE) (1):
       soc: Use dev_fwnode()

  drivers/soc/fsl/qe/gpio.c  | 6 ++++--
  drivers/soc/fsl/qe/qe_ic.c | 3 +--
  drivers/soc/tegra/pmc.c    | 3 +--
  3 files changed, 6 insertions(+), 6 deletions(-)

