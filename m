Return-Path: <linux-kernel+bounces-734579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 742BDB0835F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 05:22:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB5EF4A6DAC
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 03:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E28541EBA19;
	Thu, 17 Jul 2025 03:22:16 +0000 (UTC)
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [13.75.44.102])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D689313AD38;
	Thu, 17 Jul 2025 03:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.75.44.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752722536; cv=none; b=Qn36oLmGez5XE5ByhG0WLl7Mw27YyL83LDfSLRcht040VW3OaDe7ljrgjHiKmJ1uNC1jqRusq1OgJTacA7Cqmlv7Nncra5wu7Z9VVdUQBuJg+BLvdnqfiLWaR8Tg9c2cxsqNXg+DkiUS1NGHNJBINSR63dA8hlhlc9tyLLAm51g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752722536; c=relaxed/simple;
	bh=W96+LDyE1irEgxC7jxOOdGc0NuKEL30Q9vj/5P7B59U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pubR/NvSe4PWc8RaTNQVL9MXTAIDw8IVIaMe3zCyiREfLj62lsToTuguxyO2I1PhiMUghXYbiEMS+kivYYXyFKvLa4n74Wv129mGs3yd61kjfxisd7iPSpSj3ci2OLM7iH+5zdU4q46j3AtChofVo+1PqQAtufcTdpO+bJauNYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hust.edu.cn; spf=pass smtp.mailfrom=hust.edu.cn; arc=none smtp.client-ip=13.75.44.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hust.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hust.edu.cn
Received: from hust.edu.cn (unknown [172.16.0.52])
	by app2 (Coremail) with SMTP id HwEQrADnx+webHho67DgAQ--.19054S2;
	Thu, 17 Jul 2025 11:21:02 +0800 (CST)
Received: from [10.12.169.51] (unknown [10.12.169.51])
	by gateway (Coremail) with SMTP id _____wBH5JgcbHho4NgnAQ--.34638S2;
	Thu, 17 Jul 2025 11:21:01 +0800 (CST)
Message-ID: <62791237-0194-42c1-9c9f-d4d4d06b8af6@hust.edu.cn>
Date: Thu, 17 Jul 2025 11:21:00 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Docs/zh_CN: Translate ubifs.rst to Simplified Chinese
To: shao.mingyin@zte.com.cn, mudongliangabcd@gmail.com
Cc: seakeel@gmail.com, alexs@kernel.org, si.yanteng@linux.dev,
 corbet@lwn.net, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 yang.yang29@zte.com.cn, xu.xin16@zte.com.cn, yang.tao172@zte.com.cn,
 ye.xingchen@zte.com.cn, wang.yaxin@zte.com.cn
References: <20250717111632142lkEfTvZNyiwIN73cdQ5J9@zte.com.cn>
From: Dongliang Mu <dzm91@hust.edu.cn>
In-Reply-To: <20250717111632142lkEfTvZNyiwIN73cdQ5J9@zte.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:HwEQrADnx+webHho67DgAQ--.19054S2
Authentication-Results: app2; spf=neutral smtp.mail=dzm91@hust.edu.cn;
X-Coremail-Antispam: 1UD129KBjvJXoW3XFyDAr43Jry3Jw1rCr1kuFg_yoWDJFyxpF
	n7GFWxKry8Jry8Cr12gw1UX3sFyr1rA3WUXr1xJF17Jr1vyrWIgr1qqrn09r18GrW8AFyU
	Zr4DJry7ur15ZrDanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmYb7Iv0xC_Cr1lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
	cIk0rVWrJVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjx
	v20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK
	6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1ln4kS14v26r
	1Y6r17M2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI
	12xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj64x0Y40En7xvr7AKxV
	W8Jr0_Cr1UMcIj6x8ErcxFaVAv8VW8uFyUJr1UMcIj6xkF7I0En7xvr7AKxVW8Jr0_Cr1U
	McvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCF04k20xvY0x0EwIxGrwCF04k20x
	vE74AGY7Cv6cx26r4fZr1UJr1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_
	JF0_Jw1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1V
	AY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAI
	cVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42
	IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIev
	Ja73UjIFyTuYvjxUVoGHUUUUU
X-CM-SenderInfo: asqsiiirqrkko6kx23oohg3hdfq/


On 7/17/25 11:16 AM, shao.mingyin@zte.com.cn wrote:
>
> > On Thu, Jul 17, 2025 at 9:41 AM Alex Shi <seakeel@gmail.com> wrote:
>
> > >
>
> > > These 2 patches could be sent out as a patchset.
>
> > >
>
> >
>
> > I will explain this statement a little further. Since your two patches
>
> > both modify translations/zh_CN/filesystems/index.rst, they have their
>
> > own dependencies or orders.
>
> > In other words, this patch should be merged before the other one.
>
> >
>
> > In this case, it's better to submit a patchset (patchset has internal
>
> > orders, patch 0/2, patch 1/2, patch 2/2) to reviewers and maintainers.
>
> >
>
> > Dongliang Mu
>
> >
>
> Thanks for your feedback!
>
>
> I understand your explanation.
>
>
> In addition to these two documents, I also translated gfs2.rst and
>
> gfs2-events.rst, which also require modifications to
>
> translations/zh_CN/file systems/index.rst. Therefore, should I submit
>
> these four patches as a patchset?
>
Correct
>
>
> Best regards,
>
> Mingyin
>
> >
>
> > > Thanks
>
> > >
>
> > > <shao.mingyin@zte.com.cn> 于2025年7月15日周二 15:15写道：
>
> > > >
>
> > > > From: Shao Mingyin <shao.mingyin@zte.com.cn>
>
> > > >
>
> > > > translate the "ubifs.rst" into Simplified Chinese.
>
> > > >
>
> > > > Update to commit 5f5cae9b0e81("Documentation: ubifs: Fix
>
> > > > compression idiom")
>
> > > >
>
> > > > Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
>
> > > > Signed-off-by: yang tao <yang.tao172@zte.com.cn>
>
> > > > ---
>
> > > >  .../translations/zh_CN/filesystems/index.rst |   1 +
>
> > > >  .../translations/zh_CN/filesystems/ubifs.rst | 111 
> ++++++++++++++++++
>
> > > >  2 files changed, 112 insertions(+)
>
> > > >  create mode 100644 
> Documentation/translations/zh_CN/filesystems/ubifs.rst
>
> > > >
>
> > > > diff --git 
> a/Documentation/translations/zh_CN/filesystems/index.rst 
> b/Documentation/translations/zh_CN/filesystems/index.rst
>
> > > > index 9f2a8b003778..faaa0f097223 100644
>
> > > > --- a/Documentation/translations/zh_CN/filesystems/index.rst
>
> > > > +++ b/Documentation/translations/zh_CN/filesystems/index.rst
>
> > > > @@ -26,4 +26,5 @@ Linux Kernel中的文件系统
>
> > > >     virtiofs
>
> > > >     debugfs
>
> > > >     tmpfs
>
> > > > +   ubifs
>
> > > >
>
> > > > diff --git 
> a/Documentation/translations/zh_CN/filesystems/ubifs.rst 
> b/Documentation/translations/zh_CN/filesystems/ubifs.rst
>
> > > > new file mode 100644
>
> > > > index 000000000000..27997777f4ea
>
> > > > --- /dev/null
>
> > > > +++ b/Documentation/translations/zh_CN/filesystems/ubifs.rst
>
> > > > @@ -0,0 +1,111 @@
>
> > > > +.. SPDX-License-Identifier: GPL-2.0
>
> > > > +
>
> > > > +.. include:: ../disclaimer-zh_CN.rst
>
> > > > +
>
> > > > +:Original: Documentation/filesystems/ubifs.rst
>
> > > > +
>
> > > > +:翻译:
>
> > > > +
>
> > > > +   邵明寅 Shao Mingyin <shao.mingyin@zte.com.cn>
>
> > > > +
>
> > > > +:校译:
>
> > > > +
>
> > > > +   - 杨涛 yang tao <yang.tao172@zte.com.cn>
>
> > > > +
>
> > > > +===============
>
> > > > +UBI 文件系统
>
> > > > +===============
>
> > > > +
>
> > > > +简介
>
> > > > +============
>
> > > > +
>
> > > > +UBIFS 文件系统全称为 UBI 文件系统（UBI File System）。UBI 
> 代表无序块镜像（Unsorted
>
> > > > +Block Images）。UBIFS 
> 是一种闪存文件系统，这意味着它专为闪存设备设计。需要理解的是，UBIFS
>
> > > > +与 Linux 中任何传统文件系统（如 Ext2、XFS、JFS 等）完全不同。UBIFS 
> 代表一类特殊的文件系统，
>
> > > > +它们工作在 MTD 设备而非块设备上。该类别的另一个 Linux 文件系统是 
> JFFS2。
>
> > > > +
>
> > > > +为更清晰说明，以下是 MTD 设备与块设备的简要比较：
>
> > > > +
>
> > > > +1. MTD 设备代表闪存设备，由较大尺寸的擦除块组成，通常约 
> 128KiB。块设备由小块组成，通常 512
>
> > > > +   字节。
>
> > > > +2. MTD 设备支持 3 
> 种主要操作：在擦除块内偏移位置读取、在擦除块内偏移位置写入、以及擦除整个擦除
>
> > > > +   块。块设备支持 2 种主要操作：读取整个块和写入整个块。
>
> > > > +3. 整个擦除块必须先擦除才能重写内容。块可直接重写。
>
> > > > +4. 擦除块在经历一定次数的擦写周期后会磨损，通常 SLC NAND 和 NOR 
> 闪存为 100K-1G 次，MLC
>
> > > > +   NAND 闪存为 1K-10K 次。块设备不具备磨损特性。
>
> > > > +5. 擦除块可能损坏（仅限 NAND 
> 闪存），软件需处理此问题。硬盘上的块通常不会损坏，因为硬件有坏块
>
> > > > +   替换机制（至少现代 LBA 硬盘如此）。
>
> > > > +
>
> > > > +这充分说明了 UBIFS 与传统文件系统的本质差异。
>
> > > > +
>
> > > > +UBIFS 工作在 UBI 层之上。UBI 是一个独立的软件层（位于 
> drivers/mtd/ubi），本质上是卷管理和
>
> > > > +磨损均衡层。它提供称为 UBI 卷的高级抽象，比 MTD 设备更上层。UBI 
> 设备的编程模型与 MTD 设备非
>
> > > > +常相似，仍由大容量擦除块组成，支持读/写/擦除操作，但 UBI 
> 设备消除了磨损和坏块限制（上述列表的第
>
> > > > +4 和第 5 项）。
>
> > > > +
>
> > > > +某种意义上，UBIFS 是 JFFS2 文件系统的下一代产品，但它与 JFFS2 
> 差异巨大且不兼容。主要区别如下：
>
> > > > +
>
> > > > +* JFFS2 工作在 MTD 设备之上，UBIFS 依赖于 UBI 并工作在 UBI 卷之上。
>
> > > > +* JFFS2 没有介质索引，需在挂载时构建索引，这要求全介质扫描。UBIFS 
> 在闪存介质上维护文件系统索引
>
> > > > +  信息，无需全介质扫描，因此挂载速度远快于 JFFS2。
>
> > > > +* JFFS2 是直写（write-through）文件系统，而 UBIFS 
> 支持回写（write-back），这使得 UBIFS
>
> > > > +  写入速度快得多。
>
> > > > +
>
> > > > +与 JFFS2 类似，UBIFS 支持实时压缩，可将大量数据存入闪存。
>
> > > > +
>
> > > > +与 JFFS2 类似，UBIFS 能容忍异常重启和断电。它不需要类似 fsck.ext2 
> 的工具。UBIFS 会自动重放日
>
> > > > +志并从崩溃中恢复，确保闪存数据结构的一致性。
>
> > > > +
>
> > > > +UBIFS 
> 具有对数级扩展性（其使用的数据结构多为树形），因此挂载时间和内存消耗不像 
> JFFS2 那样线性依
>
> > > > +赖于闪存容量。这是因为 UBIFS 在闪存介质上维护文件系统索引。但 UBIFS 
> 依赖于线性扩展的 UBI 层，
>
> > > > +因此整体 UBI/UBIFS 栈仍是线性扩展。尽管如此，UBIFS/UBI 
> 的扩展性仍显著优于 JFFS2。
>
> > > > +
>
> > > > +UBIFS 开发者认为，未来可开发同样具备对数级扩展性的 UBI2。UBI2 
> 将支持与 UBI 相同的 API，但二进
>
> > > > +制不兼容。因此 UBIFS 无需修改即可使用 UBI2。
>
> > > > +
>
> > > > +挂载选项
>
> > > > +=============
>
> > > > +
>
> > > > +(*) 表示默认选项。
>
> > > > +
>
> > > > +==================== 
> =======================================================
>
> > > > +bulk_read               批量读取以利用闪存介质的顺序读取加速特性
>
> > > > +no_bulk_read (*)        禁用批量读取
>
> > > > +no_chk_data_crc (*)     跳过数据节点的 CRC 校验以提高读取性能。 
> 仅在闪存
>
> > > > +                        介质高度可靠时使用此选项。 
> 此选项可能导致文件内容损坏无法被
>
> > > > +                        察觉。
>
> > > > +chk_data_crc            强制校验数据节点的 CRC
>
> > > > +compr=none              覆盖默认压缩器，设置为"none"
>
> > > > +compr=lzo               覆盖默认压缩器，设置为"LZO"
>
> > > > +compr=zlib              覆盖默认压缩器，设置为"zlib"
>
> > > > +auth_key=               指定用于文件系统身份验证的密钥。
>
> > > > +                        使用此选项将强制启用身份验证。
>
> > > > +                        传入的密钥必须存在于内核密钥环中， 
> 且类型必须是'logon'
>
> > > > +auth_hash_name=         用于身份验证的哈希算法。同时用于哈希计算和 
> HMAC
>
> > > > + 生成。典型值包括"sha256"或"sha512"
>
> > > > +==================== 
> =======================================================
>
> > > > +
>
> > > > +快速使用指南
>
> > > > +========================
>
> > > > +
>
> > > > +挂载的 UBI 卷通过 "ubiX_Y" 或 "ubiX:NAME" 语法指定，其中 "X" 是 UBI 
> 设备编号，"Y" 是 UBI
>
> > > > +卷编号，"NAME" 是 UBI 卷名称。
>
> > > > +
>
> > > > +将 UBI 设备 0 的卷 0 挂载到 /mnt/ubifs::
>
> > > > +
>
> > > > +    $ mount -t ubifs ubi0_0 /mnt/ubifs
>
> > > > +
>
> > > > +将 UBI 设备 0 的 "rootfs" 卷挂载到 /mnt/ubifs（"rootfs" 是卷名）::
>
> > > > +
>
> > > > +    $ mount -t ubifs ubi0:rootfs /mnt/ubifs
>
> > > > +
>
> > > > +以下是内核启动参数的示例，用于将 mtd0 附加到 UBI 并挂载 "rootfs" 
> 卷：
>
> > > > +ubi.mtd=0 root=ubi0:rootfs rootfstype=ubifs
>
> > > > +
>
> > > > +参考资料
>
> > > > +==========
>
> > > > +
>
> > > > +UBIFS 文档及常见问题解答/操作指南请访问 MTD 官网：
>
> > > > +
>
> > > > +- http://www.linux-mtd.infradead.org/doc/ubifs.html
>
> > > > +- http://www.linux-mtd.infradead.org/faq/ubifs.html
>
> > > > --
>
> > > > 2.25.1
>
>
>
>


