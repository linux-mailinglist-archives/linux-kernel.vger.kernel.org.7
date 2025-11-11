Return-Path: <linux-kernel+bounces-895390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E917C4DA2E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 13:20:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36D0B189B01F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 12:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B9063587C1;
	Tue, 11 Nov 2025 12:20:37 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B0443396E4
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 12:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762863637; cv=none; b=uni/bch1Lbgy/3p66qNLxNFlggomJyYBR33n8SNMSaa2JbU6OHM5zd61JTBkfKOyeqK/DJUe016zWTqUFOsbgunQ5jEQaAFcqDxID4aTPmrScmMeAwPDtah4DouWzlAT1djBSO5euYuZOSnD8gRPNZQgzIMnoMPXJR7CZS10eRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762863637; c=relaxed/simple;
	bh=jEfT5oEDkTXfaSrL//TSxyvl1d1kWkGcMdexzvnF9yc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=loeRU2huauBLcoNWDNZUrMb6jy6OVXWCH2nomgFhwGhbmiHxvm6vsfu1shItgkeaYDqePRqGd5o2Y3IIXooaCpqndqrUCA3ByLjLtaJBW3KKOvvwDi/oEZJselQ+jbzmJSSH2pqenEgV+gZJkfKF47aPpateCxRejlAxVrsVASQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub4.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4d5PyG409Hz9sRy;
	Tue, 11 Nov 2025 12:51:34 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7vf6vUqyXpgl; Tue, 11 Nov 2025 12:51:34 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4d5PyG32vjz9sRh;
	Tue, 11 Nov 2025 12:51:34 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 557318B764;
	Tue, 11 Nov 2025 12:51:34 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id dvZM4UXbgX0y; Tue, 11 Nov 2025 12:51:34 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 1E5368B763;
	Tue, 11 Nov 2025 12:51:34 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
	by PO20335.IDSI0.si.c-s.fr (8.18.1/8.17.1) with ESMTPS id 5ABBpPQp477406
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 11 Nov 2025 12:51:25 +0100
Received: (from chleroy@localhost)
	by PO20335.IDSI0.si.c-s.fr (8.18.1/8.18.1/Submit) id 5ABBpOrG477404;
	Tue, 11 Nov 2025 12:51:24 +0100
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Marco Crivellari <marco.crivellari@suse.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>, Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Michal Hocko <mhocko@suse.com>, Kees Cook <kees@kernel.org>
Subject: Re: [PATCH] soc: fsl: qbman: add WQ_PERCPU to alloc_workqueue users
Date: Tue, 11 Nov 2025 12:50:37 +0100
Message-ID: <176286176938.477075.17121782345964029950.b4-ty@csgroup.eu>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251107152950.293899-1-marco.crivellari@suse.com>
References: <20251107152950.293899-1-marco.crivellari@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=692; i=christophe.leroy@csgroup.eu; h=from:subject:message-id; bh=GMT1UkVoLHWjDk9aJk0jE8Gn1Xu0+OncH316VCEY/xA=; b=owGbwMvMwCV2d0KB2p7V54MZT6slMWQKKwv8/D7BT+1Sd2dER8tf1zb1YHmTCh9Ni6fKcRPWJ 7Wv+xPbUcrCIMbFICumyHL8P/euGV1fUvOn7tKHmcPKBDKEgYtTACYibMrI8Co102RBaNTkCar8 hjEHzFJ/i76tnWqRsFXB/r167vbXIgz/Y423r234fVxr8vMV+1T/7W761GWxZfLbLcI+evo3Yrf X8AAA
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=openpgp; fpr=10FFE6F8B390DE17ACC2632368A92FEB01B8DD78
Content-Transfer-Encoding: 8bit


On Fri, 07 Nov 2025 16:29:50 +0100, Marco Crivellari wrote:
> Currently if a user enqueues a work item using schedule_delayed_work() the
> used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
> WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
> schedule_work() that is using system_wq and queue_work(), that makes use
> again of WORK_CPU_UNBOUND.
> This lack of consistency cannot be addressed without refactoring the API.
> 
> [...]

Applied, thanks!

[1/1] soc: fsl: qbman: add WQ_PERCPU to alloc_workqueue users
      commit: bdedc7414642e9c3793933d43b72c67f3b7db326

Best regards,
-- 
Christophe Leroy <christophe.leroy@csgroup.eu>

