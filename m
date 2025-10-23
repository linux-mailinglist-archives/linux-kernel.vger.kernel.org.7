Return-Path: <linux-kernel+bounces-866245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A943BBFF4A5
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 07:59:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9FA1F4F0AA6
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 05:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C3A025DD07;
	Thu, 23 Oct 2025 05:59:08 +0000 (UTC)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB66C2417C6;
	Thu, 23 Oct 2025 05:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761199148; cv=none; b=KjYw/0lYspwGCl0h8o69e8YIWsqFXOjKJ/w1+IDvIdSQnIO6jhLDtA6RwKdEWI75k3DsszDdGNa9FvLiBtncr26vkcOCfc+RZxVIYRNwvMRwWCVO7Xbcsh9e6VuJDbdHtrOhSWUfnQ+gd9FrD5eyi9asSsyQxNKjjklMUTEIgcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761199148; c=relaxed/simple;
	bh=9/L8LEUc6VUV0Tkz9CaaJqqFbpSu6Z2TmhoSS7imJLw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NcIaXLY3M6OoGZbb0R+i09Fg2lu74z8fi6lnv2kesEMIOZXK5ImOgJUwdV6LsGLE1KsmsEsdByJexGqQWG94IOJMnYZDGk2v/A7YyrKQti0bW+ENIzZCa4QnvfeEH7BgRUwQx1sMt6Nc8J2CLdq906cnYi8ngBrmVJsVYK3HbGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [192.168.0.105] (unknown [114.241.85.109])
	by APP-03 (Coremail) with SMTP id rQCowABXqIL9w_lo3ZHFFA--.967S2;
	Thu, 23 Oct 2025 13:58:22 +0800 (CST)
Message-ID: <f8a55f89-2612-49e3-88c6-acb523ac74d3@iscas.ac.cn>
Date: Thu, 23 Oct 2025 13:58:22 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] riscv: dts: spacemit: add Ethernet and PDMA to
 OrangePi RV2
To: michael.opdenacker@rootcommit.com, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>,
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>
Cc: Emil Renner Berthing <emil.renner.berthing@gmail.com>,
 devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
 spacemit@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20251022201807.1474789-1-michael.opdenacker@rootcommit.com>
 <20251022201807.1474789-2-michael.opdenacker@rootcommit.com>
Content-Language: en-US
From: Vivian Wang <wangruikang@iscas.ac.cn>
In-Reply-To: <20251022201807.1474789-2-michael.opdenacker@rootcommit.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowABXqIL9w_lo3ZHFFA--.967S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tFyDAryrWFWrGr13Aw4rAFb_yoW8Jw4DpF
	4xWr1Yyrs8Cr48tw4xXw429a4rWw4kJ3yDA3Z0grZ8C3Z8XFyFqrs2qwnxuFW5K34fGayj
	vFW7ua4FqF1UAaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvlb7Iv0xC_Zr1lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwV
	C2z280aVCY1x0267AKxVWxJr0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
	F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r
	4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kIc2xK
	xwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJV
	W8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF
	1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6x
	IIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvE
	x4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvj
	DU0xZFpf9x07jeoGQUUUUU=
X-CM-SenderInfo: pzdqw2pxlnt03j6l2u1dvotugofq/

Thank you so much for the patch and testing results. Only some nitpicks
follow.

On 10/23/25 04:18, michael.opdenacker@rootcommit.com wrote:
> From: Michael Opdenacker <michael.opdenacker@rootcommit.com>
>
> The OrangePi RV2 board ships two RGMII ethernet ports.
> Each has an external Motorcomm YT8531C PHY attached, the PHY uses GPIO
> for reset pin control.
>
> Enable PDMA for the SpacemiT K1-based SoC in the OrangePi RV2 board.
>
> Signed-off-by: Michael Opdenacker <michael.opdenacker@rootcommit.com>
> CC: Emil Renner Berthing <emil.renner.berthing@gmail.com>
> CC: Yixun Lan <dlan@gentoo.org>
> CC: Vivian Wang <wangruikang@iscas.ac.cn>

Firstly, it is usually spelt "Cc:", with one upper-case C and one
lower-case c.

Secondly, "Cc:" should not be necessary in the patch/commit message.
From Documentation/process/submitting-patches.rst:

    If a person has had the opportunity to comment on a patch, but has not
    provided such comments, you may optionally add a ``Cc:`` tag to the patch.
    This tag documents that potentially interested parties have been included in
    the discussion.

If you look through the git logs of Linux, Cc tags are really not a
regular occurrence except those marking patches as suitable for
backporting to stable.

Thanks,
Vivian "dramforever"


