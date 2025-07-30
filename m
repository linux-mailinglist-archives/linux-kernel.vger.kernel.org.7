Return-Path: <linux-kernel+bounces-750229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B946B158E3
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 08:20:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D2603ABE46
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 06:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 901181F418E;
	Wed, 30 Jul 2025 06:20:41 +0000 (UTC)
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99A0C199BC
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 06:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.236.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753856441; cv=none; b=eesE2olVYsvh1UlYJK/tfg0Yj3ekqq09zSHLuEUC8BRYo6d7HRfXpbJn0fzNfpOyxZfwg95HrVemaUOtDEYA1RBGBaBLoc2qRy+7xoh4RcP9wAhqrYE3V+RjKXtgsEq6gYg4wINB/Mv4KYmOZIpoDXbbyqOFwUHRVraFiZsbmQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753856441; c=relaxed/simple;
	bh=nKY0YqG4t9mznqNAUvd95M6TzmSQjIk5LRlskSPR1Ik=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L+KoG8c29Kzj2JBUYjH+H+n9I9tekiCFYu8K5+B+gjtTgzyFDcPO1gzAx9jeh5mQvEMbrc9mvWiJ2M0eB2zaC77LP7VPGEy3G3EL0v7cKVOBdXGNXMGgCUI+4X+iqw8Cy9Ec/fEATEFIcu2DcDjuog8RKDNdCXyyBij1TMDi3x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.236.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
	by localhost (Postfix) with ESMTP id 4bsMJX4rC6z9sN6;
	Wed, 30 Jul 2025 08:10:20 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
	by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kvx3b491i35a; Wed, 30 Jul 2025 08:10:20 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase1.c-s.fr (Postfix) with ESMTP id 4bsMJX41K8z9s92;
	Wed, 30 Jul 2025 08:10:20 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 7FE3B8B76C;
	Wed, 30 Jul 2025 08:10:20 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id 3j76NxDL4snr; Wed, 30 Jul 2025 08:10:20 +0200 (CEST)
Received: from [10.25.207.160] (unknown [10.25.207.160])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 57D8F8B763;
	Wed, 30 Jul 2025 08:10:20 +0200 (CEST)
Message-ID: <b885d194-dee0-4cc8-ad85-25949baf02b3@csgroup.eu>
Date: Wed, 30 Jul 2025 08:10:20 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] SOC FSL for 6.17
To: Krzysztof Kozlowski <krzk@kernel.org>, soc@kernel.org,
 Arnd Bergmann <arnd@arndb.de>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <c947d537-cae5-44f0-abd8-0c558bac46d2@csgroup.eu>
 <cb913a0a-0f3f-4890-aa1f-1b01ec9c564e@kernel.org>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <cb913a0a-0f3f-4890-aa1f-1b01ec9c564e@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

Le 18/07/2025 à 11:23, Krzysztof Kozlowski a écrit :
> On 10/07/2025 08:44, Christophe Leroy wrote:
>> Hi Arnd,
>>
>> Please pull the following Freescale Soc Drivers changes for 6.17
>>
>> The tegra change is outside soc/fsl tree but it is acked by maintainer
>> of DRM DRIVERS FOR NVIDIA TEGRA.
>>
>> Thanks
>> Christophe
>>
>> The following changes since commit 19272b37aa4f83ca52bdf9c16d5d81bdd1354494:
>>
>>     Linux 6.16-rc1 (2025-06-08 13:44:43 -0700)
>>
>> are available in the Git repository at:
>>
>>     https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgithub.com%2Fchleroy%2Flinux.git&data=05%7C02%7Cchristophe.leroy%40csgroup.eu%7C2a2edd9aede449ece30d08ddc5dccf65%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C638884274336423091%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=t2mexcfPjeKLqozoB28iCbWbrQY40jEdaaJ%2FHnyKSEY%3D&reserved=0 tags/soc_fsl-6.17-1
>>
>> for you to fetch changes up to 76760b9dbbf8088ef31afb60d92b955f88ad1288:
>>
>>     soc: Use dev_fwnode() (2025-07-08 10:29:28 +0200)
>>
>> ----------------------------------------------------------------
>> FSL SOC Changes for 6.17:
>> - Use dev_fwnode() instead of of_fwnode_handle()
>> - Use new GPIO line value setter callbacks
> 
> It has been many days and I still do not see this patch in linux-next.
> Please confirm that you properly feed linux-next and for how long this
> patch was sitting there (BEFORE you send them to upstream maintainer).

Until recently I was relying on my branch poping up into linux-next once 
merged into the soc tree.

Since monday last week it is now included in linux-next independently.

Christophe

