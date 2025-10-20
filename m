Return-Path: <linux-kernel+bounces-860946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C251BF16A1
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 15:04:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C3B754F85AC
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 13:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36C053164A1;
	Mon, 20 Oct 2025 12:59:56 +0000 (UTC)
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92BA73148AD
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 12:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760965195; cv=none; b=eydFtiAd5E0tRZFroxitlJXWZKeMura4MNCP6vOK4ctMx8ReT4NTkhwu9fwHvRdTtMbs7FPBAndFcuteb5Z+BiM2F0pGYEkL8W0Xmcp9upHprS2PiuEocqmp6ymu6uuwPKPB0zhMr194O3i6RwZ5J6HXMSNS+FY/odkfZhSKrU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760965195; c=relaxed/simple;
	bh=hzUyPPbuX5n3KugTEY1eIbx8XCLAlqtP+aUQsryn418=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f0E04WOsmJN/RhTMQr42aJkEL/DiTMa3M/nzu5d43O2mH0TkF9JskKPw8OCsXd6XBfYPtfVIZxBTvm/6fl4N15tbWDRMOlqztwkWfELp6rlxUfXr/U4lfJmpj6TP/8dcG7sJRuCFcLRy1z2faJIOkW2MrQACZypm1+CwkhM1LmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [192.168.0.107] (unknown [114.241.85.109])
	by APP-01 (Coremail) with SMTP id qwCowAAHYKI6MvZo4TP9EQ--.2971S2;
	Mon, 20 Oct 2025 20:59:38 +0800 (CST)
Message-ID: <4a2312d1-5294-4621-8276-b7a9447b3e1a@iscas.ac.cn>
Date: Mon, 20 Oct 2025 20:59:38 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] riscv: tests: Make RISCV_KPROBES_KUNIT tristate
To: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
 Nam Cao <namcao@linutronix.de>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 Han Gao <rabenda.cn@gmail.com>, Icenowy Zheng <uwu@icenowy.me>,
 Inochi Amaoto <inochiama@gmail.com>, Yao Zi <ziyao@disroot.org>
References: <20251020-riscv-kunit-kconfig-fix-6-18-v1-0-d773b5d5ce48@iscas.ac.cn>
Content-Language: en-US
From: Vivian Wang <wangruikang@iscas.ac.cn>
In-Reply-To: <20251020-riscv-kunit-kconfig-fix-6-18-v1-0-d773b5d5ce48@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowAAHYKI6MvZo4TP9EQ--.2971S2
X-Coremail-Antispam: 1UD129KBjvdXoWrWr4DZFyftrWkKFyxKF4kZwb_yoWxXwb_uF
	4kWwn7Gws8CF40krWq9r95Gr93t3yj9ryUWryvgrWUCr9293ZrGw4DJFn2v3Z8Gr4vvFnx
	Wwsxur10kasrWjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbsxYjsxI4VWkCwAYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I
	6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
	8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0
	cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z2
	80aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAK
	zVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx
	8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF
	7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI
	8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AK
	xVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI
	8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280
	aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0x
	ZFpf9x07j0fOwUUUUU=
X-CM-SenderInfo: pzdqw2pxlnt03j6l2u1dvotugofq/

On 10/20/25 20:23, Vivian Wang wrote:

> Fix an allmodconfig warning on v6.18-rc1:
>
>     WARNING: 3 bad relocations
>     ffffffff81e24118 R_RISCV_64        kunit_unary_assert_format
>     ffffffff81e24a60 R_RISCV_64        kunit_binary_assert_format
>     ffffffff81e269d0 R_RISCV_JUMP_SLOT  __kunit_do_failed_assertion

For more context, I said this was to fix a warning, but I tried it out
anyway just to see what happens. Apparently, nothing. The kprobe tests
just don't run if RISCV_KPROBES_KUNIT=y but KUNIT=m.

So this config combination being just wrong is the problem, and the
warning is just a loud symptom.

Vivian "dramforever" Wang


