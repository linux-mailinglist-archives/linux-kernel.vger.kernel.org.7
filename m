Return-Path: <linux-kernel+bounces-891696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D421C43455
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 20:50:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69708188DD52
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 19:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D5BD279334;
	Sat,  8 Nov 2025 19:50:38 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5DBA23D7CF
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 19:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762631437; cv=none; b=VqvTXXpz0b3wUgMxJT6Wx9YTp39U1MK+4hEa2fOxkfDH/3Ey1/g7Trfg9iOJPRGYhl6+d9G+B7qgEELBpaeWhL1LTLE8cJNnICRefjk1ADKISe6NTp6ZYrsxmuM6idT5ZUJJ3kOgWxPfkc13Xgu5T0BxCw26gKZfYYimggdQ7OE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762631437; c=relaxed/simple;
	bh=AZHKqcihOLxQwKvDWw9badRats1tna8Se2zSVL4fDSk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j9ey4rCFx+VspyU5XE0sNYUQUyT/lQzMqzYismMjpdkT5IKtFU7+9JHQF21MNehuUxG+Gyo3NDO3RdAeAcDw+yCwz8WvQr3VHGPKF0k9cFS3VlBy/zQcAr8MgIspxhuzGQiQKOFE2VbwwVnoLpO2ajUb2O4feJh8UBd7SoXvjvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub4.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4d3mZx13jyz9sSV;
	Sat,  8 Nov 2025 20:44:09 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MLmBdmBkcqXZ; Sat,  8 Nov 2025 20:44:09 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4d3mZw6qjrz9sSS;
	Sat,  8 Nov 2025 20:44:08 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id C245E8B765;
	Sat,  8 Nov 2025 20:44:08 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id txhM0SZEkJy5; Sat,  8 Nov 2025 20:44:08 +0100 (CET)
Received: from [192.168.235.99] (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 4D5DF8B764;
	Sat,  8 Nov 2025 20:44:08 +0100 (CET)
Message-ID: <64df8b4e-6cd4-49e4-a0f9-c8f9c017b06c@csgroup.eu>
Date: Sat, 8 Nov 2025 20:44:08 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] soc: fsl: qbman: add WQ_PERCPU to alloc_workqueue users
To: Marco Crivellari <marco.crivellari@suse.com>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Tejun Heo <tj@kernel.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>,
 Frederic Weisbecker <frederic@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Michal Hocko <mhocko@suse.com>, Kees Cook <kees@kernel.org>
References: <20251107152950.293899-1-marco.crivellari@suse.com>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Content-Language: fr-FR
In-Reply-To: <20251107152950.293899-1-marco.crivellari@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 07/11/2025 à 16:29, Marco Crivellari a écrit :
> Currently if a user enqueues a work item using schedule_delayed_work() the
> used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
> WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
> schedule_work() that is using system_wq and queue_work(), that makes use
> again of WORK_CPU_UNBOUND.
> This lack of consistency cannot be addressed without refactoring the API.
> 
> alloc_workqueue() treats all queues as per-CPU by default, while unbound
> workqueues must opt-in via WQ_UNBOUND.
> 
> This default is suboptimal: most workloads benefit from unbound queues,
> allowing the scheduler to place worker threads where they’re needed and
> reducing noise when CPUs are isolated.
> 
> This continues the effort to refactor workqueue APIs, which began with
> the introduction of new workqueues and a new alloc_workqueue flag in:
> 
> commit 128ea9f6ccfb ("workqueue: Add system_percpu_wq and system_dfl_wq")
> commit 930c2ea566af ("workqueue: Add new WQ_PERCPU flag")
> 
> This change adds a new WQ_PERCPU flag to explicitly request
> alloc_workqueue() to be per-cpu when WQ_UNBOUND has not been specified.
> 
> With the introduction of the WQ_PERCPU flag (equivalent to !WQ_UNBOUND),
> any alloc_workqueue() caller that doesn’t explicitly specify WQ_UNBOUND
> must now use WQ_PERCPU.
> 
> Once migration is complete, WQ_UNBOUND can be removed and unbound will
> become the implicit default.
> 
> Suggested-by: Tejun Heo <tj@kernel.org>
> Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>

IIUC this patch is part of a wide work on workqueues. I assume the will 
go via the workqueue tree. Let me know if you want me to take it via soc 
fsl.

Acked-by: Christophe Leroy <christophe.leroy@csgroup.eu>



> ---
>   drivers/soc/fsl/qbman/qman.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/fsl/qbman/qman.c b/drivers/soc/fsl/qbman/qman.c
> index 9be240999f87..6b392b3ad4b1 100644
> --- a/drivers/soc/fsl/qbman/qman.c
> +++ b/drivers/soc/fsl/qbman/qman.c
> @@ -1073,7 +1073,7 @@ EXPORT_SYMBOL(qman_portal_set_iperiod);
>   
>   int qman_wq_alloc(void)
>   {
> -	qm_portal_wq = alloc_workqueue("qman_portal_wq", 0, 1);
> +	qm_portal_wq = alloc_workqueue("qman_portal_wq", WQ_PERCPU, 1);
>   	if (!qm_portal_wq)
>   		return -ENOMEM;
>   	return 0;


