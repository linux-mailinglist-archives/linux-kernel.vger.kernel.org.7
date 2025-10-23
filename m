Return-Path: <linux-kernel+bounces-867315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91AC3C023E0
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 17:50:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69A533A4DF2
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 15:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A7FB246BDE;
	Thu, 23 Oct 2025 15:49:12 +0000 (UTC)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F178E228CB0
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 15:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761234552; cv=none; b=WwD7xU19QM75xtRXQMUkQAkppurx09A9nCZtlMny1VHd93RakEeIiSDlIfsWLycLi6qyvalFuXnGhxvF2YVARJEQRQ6Mpqt/8fHe2WCeoueM1MZQba3ptFz/tnzDyvVpquu/XGidVhQlNOhEknVggNgcnwo26kCS0OINu9elLng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761234552; c=relaxed/simple;
	bh=iNbTotB8Ze9HdbF4V519dGyODiwS7G8eIvVGDtii7wU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qMKgvezn4Plk8snY/u+PQqMIRiGEekvKOl18TmW/El/kTiV18ILlFsXBEUhzntBmpsJdqFTjSpPZM0rIzOlaAWR5YR7MhBMYzXZLUI9IxDmY58huTA+HeZKaPgw7oqeDh390M0WwVkpetX2PxjvEkevlG5xQsxcom30Og5ZHW3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=isrc.iscas.ac.cn; spf=pass smtp.mailfrom=isrc.iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=isrc.iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isrc.iscas.ac.cn
Received: from Mobilestation.localdomain (unknown [183.6.59.216])
	by APP-03 (Coremail) with SMTP id rQCowACn7XdgTvpow9w+FQ--.772S2;
	Thu, 23 Oct 2025 23:48:51 +0800 (CST)
From: Yao Zihong <zihong.plct@isrc.iscas.ac.cn>
To: ajones@ventanamicro.com
Cc: alex@ghiti.fr,
	alexghiti@rivosinc.com,
	aou@eecs.berkeley.edu,
	cleger@rivosinc.com,
	evan@rivosinc.com,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	palmer@dabbelt.com,
	pjw@kernel.org,
	samuel.holland@sifive.com,
	shuah@kernel.org,
	zhangyin2018@iscas.ac.cn,
	zihong.plct@isrc.iscas.ac.cn,
	zihongyao@outlook.com
Subject: Re: [PATCH v3 2/2] selftests/riscv: Add Zicbop prefetch test
Date: Thu, 23 Oct 2025 23:48:18 +0800
Message-ID: <20251023154841.36007-1-zihong.plct@isrc.iscas.ac.cn>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20251021-01a9b77e3d88543581f1a7fb@orel>
References: <20251021-01a9b77e3d88543581f1a7fb@orel>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowACn7XdgTvpow9w+FQ--.772S2
X-Coremail-Antispam: 1UD129KBjvdXoWrZF48tF1xKw4DZw47KFyUZFb_yoWDArg_Zr
	yDJrnrJa9Fyr9Yqw47C3WYvrn3C34agr1UGw10qwn7tw18ZFZrCr4qvF9xJ3WDCw43Z3s0
	9wn8Kry3Aw13ujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb3xFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr0_Gr
	1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxa
	n2IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4
	AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE
	17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMI
	IF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4l
	IxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvf
	C2KfnxnUUI43ZEXa7VUbGQ6JUUUUU==
X-CM-SenderInfo: p2lk00vjoszunw6l223fol2u1dvotugofq/

> Undesired reformatting
My bad. It will be fixed in the next version.

> Should we just unconditionally register handlers for SIGSEGV and SIGBUS?
I think it depends on what the flags --sig{segv,ill,bus} are intended to mean:

  a) We intend to handle these faults that might be raised inside the test
     (i.e., catch and convert them into pass/fail results without crashing the
     test binary, rather than letting something else handle them externally).
  b) We expect these signals to be raised as part of the test scenario and
     handle them within the test program accordingly.

I'm not sure if (a) is appropriate, since it might mess up someone’s CI
or other automation setups.

If we’re going with (b), then registering handlers for SIGSEGV and SIGBUS
based on flags would be inconsistent with that semantics, since prefetch.*
should never legitimately raise them. In that case, this design probably
doesn’t make sense. Would it also make sense to rename the '--sigill' flag
to make this clearer?

Thanks,
Zihong


