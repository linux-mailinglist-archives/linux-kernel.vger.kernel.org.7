Return-Path: <linux-kernel+bounces-827354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 996C0B9186F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 15:54:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CE022A018A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 13:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87BE630E0F2;
	Mon, 22 Sep 2025 13:54:01 +0000 (UTC)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6D93093B8
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 13:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758549241; cv=none; b=enV74dKx89W57oVQjDybgtifZPWJHgEeWSllLtkjkRX42BG2RvIEm93EtkcEYiP2MyQG2Ti1+hR0QjtMAUonAgI4vefODg95JW0+r0MKAiDZ6xuWPaIn+fL3d8OnDO9UJ8nCik1f8WRBSgXr48Gi9I28cS9+XabOqCVaR6M+XkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758549241; c=relaxed/simple;
	bh=ZGK42wnotMYf7K1kLNSn8pbuRtOaeuEb5oNxCeAp0zI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X6lrluEwmTRu+rO0or205E7OzuXvGj7ik4Dv6pp5ZcRdipAeDncQk100ekeb8hDj8pwFiX2eKY8gwjBQCe2nhA8NXCLb2BD6H8qJnKY2t7vukVwbVZTyMsFpIcSqMP0dLgzaVaAOF4qd9+wedAIhGVo9WvjUPQhqMFG46JVxW98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=isrc.iscas.ac.cn; spf=pass smtp.mailfrom=isrc.iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=isrc.iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isrc.iscas.ac.cn
Received: from Mobilestation.localdomain (unknown [183.6.59.140])
	by APP-03 (Coremail) with SMTP id rQCowAD3C4bjVNFop7xEBA--.8159S2;
	Mon, 22 Sep 2025 21:53:40 +0800 (CST)
From: Yao Zihong <zihong.plct@isrc.iscas.ac.cn>
To: zihong.plct@isrc.iscas.ac.cn
Cc: alex@ghiti.fr,
	aou@eecs.berkeley.edu,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	palmer@dabbelt.com,
	paul.walmsley@sifive.com,
	zhangyin2018@iscas.ac.cn,
	zihongyao@outlook.com
Subject: Re: [PATCH v1 0/2] riscv: hwprobe: add Zicbop support
Date: Mon, 22 Sep 2025 21:53:31 +0800
Message-ID: <20250922135337.38493-1-zihong.plct@isrc.iscas.ac.cn>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250911121219.20243-1-zihong.plct@isrc.iscas.ac.cn>
References: <20250911121219.20243-1-zihong.plct@isrc.iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowAD3C4bjVNFop7xEBA--.8159S2
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYc7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E
	6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28Cjx
	kF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8I
	cVCY1x0267AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIE14v26r1j6r4UM28EF7xvwVC2z280aV
	CY1x0267AKxVW8JVW8Jr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE
	5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeV
	CFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1l
	42xK82IYc2Ij64vIr41l4c8EcI0Ec7CjxVAaw2AFwI0_Jw0_GFyl4I8I3I0E4IkC6x0Yz7
	v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF
	1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIx
	AIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI
	42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWI
	evJa73UjIFyTuYvjfUoOJ5UUUUU
X-CM-SenderInfo: p2lk00vjoszunw6l223fol2u1dvotugofq/

Hi all,

It’s been about two weeks since I posted this patch.
Could someone take a look when convenient and let me know if there are
any concerns or improvements needed?

Patch links:
https://lore.kernel.org/linux-riscv/20250911121219.20243-1-zihong.plct@isrc.iscas.ac.cn/
https://lore.kernel.org/linux-riscv/20250911121219.20243-2-zihong.plct@isrc.iscas.ac.cn/
https://lore.kernel.org/linux-riscv/20250911121219.20243-3-zihong.plct@isrc.iscas.ac.cn/

If useful, I can resend with updates if needed.
Thanks for your attention.

Zihong


