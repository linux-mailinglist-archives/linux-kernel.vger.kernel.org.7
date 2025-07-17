Return-Path: <linux-kernel+bounces-734578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3617B0835D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 05:21:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27AC11C2690F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 03:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB7E51F4169;
	Thu, 17 Jul 2025 03:21:22 +0000 (UTC)
Received: from zg8tmja5ljk3lje4mi4ymjia.icoremail.net (zg8tmja5ljk3lje4mi4ymjia.icoremail.net [209.97.182.222])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF8AB1E9B31;
	Thu, 17 Jul 2025 03:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.97.182.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752722481; cv=none; b=J78zmPIZUAjJAHV5NzyH30IZZl6JmT23C5+oZHKZnGIzQBe+WSNKeDu6/RPNBUbsHll929rAm1KZYntONgp4hdC02ecPhh4i64dBrIH0NKjVXtSGwXYzH7ptIPsSWWgKRZcH0ZDlIjV8NkWON2IVO9Telf160+oLttbkVERc2hU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752722481; c=relaxed/simple;
	bh=V3Ae8zPeZowSxtzELDuak4LXUrDGSFQhmmEK7xC2JVQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LWLb3a2DtEFiyUlxD8nRxbyKxXUbknJaMTe+WZsCTbCyTcdTd4kbEeTJBUYRQxsGy6kvwed3f9+8aSIcZHjKNqA1ogDMOZO8qy8xVswfd982UNfYUWV4P/QgiAKEzJ5xcAVo5j3ptJceiSg47Wnq3dbjxEJhRmRKPjbS+v9jPhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hust.edu.cn; spf=pass smtp.mailfrom=hust.edu.cn; arc=none smtp.client-ip=209.97.182.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hust.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hust.edu.cn
Received: from hust.edu.cn (unknown [172.16.0.52])
	by app2 (Coremail) with SMTP id HwEQrACXnnb2a3hoorDgAQ--.19409S2;
	Thu, 17 Jul 2025 11:20:22 +0800 (CST)
Received: from [10.12.169.51] (unknown [10.12.169.51])
	by gateway (Coremail) with SMTP id _____wDXkpnya3hoF9gnAQ--.42960S2;
	Thu, 17 Jul 2025 11:20:21 +0800 (CST)
Message-ID: <c4880812-e968-488c-9df0-2208f7f4fcb0@hust.edu.cn>
Date: Thu, 17 Jul 2025 11:20:18 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Docs/zh_CN: Translate ubifs-authentication.rst to
 Simplified Chinese
To: shao.mingyin@zte.com.cn, seakeel@gmail.com
Cc: alexs@kernel.org, si.yanteng@linux.dev, corbet@lwn.net,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 yang.yang29@zte.com.cn, xu.xin16@zte.com.cn, yang.tao172@zte.com.cn,
 ye.xingchen@zte.com.cn, wang.yaxin@zte.com.cn
References: <20250717110513773fyfRnUCJdXpLjkcN-21jJ@zte.com.cn>
From: Dongliang Mu <dzm91@hust.edu.cn>
In-Reply-To: <20250717110513773fyfRnUCJdXpLjkcN-21jJ@zte.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:HwEQrACXnnb2a3hoorDgAQ--.19409S2
Authentication-Results: app2; spf=neutral smtp.mail=dzm91@hust.edu.cn;
X-Coremail-Antispam: 1UD129KBjvAXoWfurW8tF1xGFy3KF4kWr4kJFb_yoW8Kry7Zo
	WUuryfuw47Jr13XrW5Jw18Xr4DJ3WUWrnFyay7tr17Gryjy3WSyF1UJw13G3y5Ar45K3W5
	ta4rJr13Aa15XF15n29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUOk7k0a2IF6F4UM7kC6x804xWl1xkIjI8I6I8E6xAIw20EY4v2
	0xvaj40_Wr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7
	IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xv
	wVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2kKe7AKxV
	WUXVWUAwAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY
	07AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VACjcxG62k0Y48FwI
	0_Gr1j6F4UJwAv7VCjz48v1sIEY20_GFW3Jr1UJwAv7VCY1x0262k0Y48FwI0_Gr1j6F4U
	JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41l42xK82IYc2Ij64vIr41l42xK82
	IY6x8ErcxFaVAv8VW8uFyUJr1UMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v2
	6r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17
	CEb7AF67AKxVWUtVW8ZwCIccxYrVCIc48FwI0_Gr0_Xr1lIxkGc2Ij64vIr41lIxAIcVC0
	I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04
	k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7Cj
	xVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU0uHq3UUUUU==
X-CM-SenderInfo: asqsiiirqrkko6kx23oohg3hdfq/


On 7/17/25 11:05 AM, shao.mingyin@zte.com.cn wrote:
>> From: seakeel <seakeel@gmail.com>
>> To: Shao Mingyin10345846;
>> Cc: alexs <alexs@kernel.org>;si.yanteng <si.yanteng@linux.dev>;dzm91 <dzm91@hust.edu.cn>;corbet <corbet@lwn.net>;linux-doc <linux-doc@vger.kernel.org>;linux-kernel <linux-kernel@vger.kernel.org>;Yang Yang10192021;Xu Xin10311587;Yang Tao10262512;Ye Xingchen10329245;Wang Yaxin00350371;
>> Date: 2025/07/17 09:39
>> Subject: Re: [PATCH] Docs/zh_CN: Translate ubifs-authentication.rst to Simplified Chinese
>> <shao.mingyin@zte.com.cn> 于2025年7月15日周二 15:26写道：
>>> From: Shao Mingyin <shao.mingyin@zte.com.cn>
>>>
>>> translate the "ubifs-authentication.rst" into Simplified Chinese.
>>>
>>> Update to commit d56b699d76d1("Documentation: Fix typos")
>>>
>>> Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
>>> Signed-off-by: yang tao <yang.tao172@zte.com.cn>
>>> ---
>>>   .../translations/zh_CN/filesystems/index.rst  |   1 +
>>>   .../filesystems/ubifs-authentication.rst      | 334 ++++++++++++++++++
>>>   2 files changed, 335 insertions(+)
>>>   create mode 100644 Documentation/translations/zh_CN/filesystems/ubifs-authentication.rst
>>>
>>> diff --git a/Documentation/translations/zh_CN/filesystems/index.rst b/Documentation/translations/zh_CN/filesystems/index.rst
>>> index faaa0f097223..3c25b39739db 100644
>>> --- a/Documentation/translations/zh_CN/filesystems/index.rst
>>> +++ b/Documentation/translations/zh_CN/filesystems/index.rst
>>> @@ -27,4 +27,5 @@ Linux Kernel中的文件系统
>>>      debugfs
>>>      tmpfs
>>>      ubifs
>>> +   ubifs-authentication
>>>
>>> diff --git a/Documentation/translations/zh_CN/filesystems/ubifs-authentication.rst b/Documentation/translations/zh_CN/filesystems/ubifs-authentication.rst
>>> new file mode 100644
>>> index 000000000000..3e57f1eaebdc
>>> --- /dev/null
>>> +++ b/Documentation/translations/zh_CN/filesystems/ubifs-authentication.rst
>>> @@ -0,0 +1,334 @@
>>> +.. SPDX-License-Identifier: GPL-2.0
>>> +
>>> +.. include:: ../disclaimer-zh_CN.rst
>>> +
>>> +:Original: Documentation/filesystems/ubifs-authentication.rst
>>> +
>>> +:翻译:
>>> +
>>> +   邵明寅 Shao Mingyin <shao.mingyin@zte.com.cn>
>>> +
>>> +:校译:
>>> +
>>> +   - 杨涛 yang tao <yang.tao172@zte.com.cn>
>>> +
>>> +============================
>>> +UBIFS认证支持
>>> +============================
>> Hi mingyin,
>>
>> Please take care of the rst file format first.
>> https://en.wikipedia.org/wiki/ReStructuredText
>>
>> Thanks
>> Alex
>>
> Hi Alex,
>
> Thanks for your feedback!
>
> I have  taken care to ensure that the document conforms to the RST format.
> 1. I use the reStructureDext plugin in VSode to perform syntax checks
> on the document to ensure there are no errors or warnings.
> 2. By executing 'make htmldocs', the corresponding
> ubifs-authentication.html can be generated.
>
> Could you please further explain the specific issue with the RST format?


译文格式要求
------------

	- 每行长度最多不超过40个字符
	- 每行长度请保持一致
	- 标题的下划线长度请按照一个英文一个字符、一个中文两个字符与标题对齐
	- 其它的修饰符请与英文文档保持一致


Refer to how-to.rst [1] for more details.


[1] 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/translations/zh_CN/how-to.rst


Dongliang Mu

>
> Best regards,
> Mingyin
>>> +
>>> +引言
>>> +============
>>> +UBIFS 利用 fscrypt 框架为文件内容及文件名提供保密性。这能防止攻击者在单一时间点读取文件系
>>> +统内容的攻击行为。典型案例是智能手机丢失时，攻击者若没有文件系统解密密钥则无法读取设备上的个
>>> +人数据。
>>> +
>>> +在现阶段，UBIFS 加密尚不能防止攻击者篡改文件系统内容后用户继续使用设备的攻击场景。这种情况
>>> +下，攻击者可任意修改文件系统内容而不被用户察觉。例如修改二进制文件使其执行时触发恶意行为
>>> +[DMC-CBC-ATTACK]。由于 UBIFS 大部分文件系统元数据以明文存储，使得文件替换和内容篡改变得
>>> +相当容易。
>>> +
>>> +其他全盘加密系统（如 dm-crypt）可以覆盖所有文件系统元数据，这类系统虽然能增加这种攻击的难度，
>>> +但特别是当攻击者能多次访问设备时，也有可能实现攻击。对于基于 Linux 块 IO 层的 dm-crypt 等文
>>> +件系统，可通过 dm-integrity 或 dm-verity 子系统[DM-INTEGRITY, DM-VERITY]在块层实现完整数据认
>>> +证，这些功能也可与 dm-crypt 结合使用[CRYPTSETUP2]。
>>> +
>>> +本文描述一种为 UBIFS 实现文件内容认证和完整元数据认证的方法。由于 UBIFS 使用 fscrypt 进行文件内
>>> +容和文件名加密，认证系统可与 fscrypt 集成以利用密钥派生等现有功能。但系统同时也应支持在不启用加
>>> +密的情况下使用 UBIFS 认证。
>>> +
>>> +
>>> +MTD, UBI & UBIFS
>>> +----------------
>>> +在 Linux 中，MTD（内存技术设备）子系统提供访问裸闪存设备的统一接口。运行于 MTD 之上的重要
>>> +子系统是 UBI（无序块映像），它为闪存设备提供卷管理功能，类似于块设备的 LVM。此外，UBI 还处理闪
>>> +存特有的磨损均衡和透明 I/O 错误处理。UBI 向上层提供逻辑擦除块(LEB)，并透明地映射到闪存的物理擦
>>> +除块(PEB)。
>>> +
>>> +UBIFS 是运行于 UBI 之上的裸闪存文件系统。因此 UBI 处理磨损均衡和部分闪存特性，而 UBIFS
>>> +专注于可扩展性、性能和可恢复性。
>>> +
>>> +::
>>> +
>>> +       +------------+ +*******+ +-----------+ +-----+
>>> +       |            | * UBIFS * | UBI-BLOCK | | ... |
>>> +       | JFFS/JFFS2 | +*******+ +-----------+ +-----+
>>> +       |            | +-----------------------------+ +-----------+ +-----+
>>> +       |            | |              UBI            | | MTD-BLOCK | | ... |
>>> +       +------------+ +-----------------------------+ +-----------+ +-----+
>>> +       +------------------------------------------------------------------+
>>> +       |                  MEMORY TECHNOLOGY DEVICES (MTD)                 |
>>> +       +------------------------------------------------------------------+
>>> +       +-----------------------------+ +--------------------------+ +-----+
>>> +       |         NAND DRIVERS        | |        NOR DRIVERS       | | ... |
>>> +       +-----------------------------+ +--------------------------+ +-----+
>>> +
>>> +            图1：处理裸闪存的 Linux 内核子系统
>>> +
>>> +
>>> +
>>> +UBIFS 内部维护多个持久化在闪存上的数据结构：
>>> +
>>> +- *索引*：存储在闪存上的 B+ 树，叶节点包含文件系统数据
>>> +- *日志*：在更新闪存索引前收集文件系统变更的辅助数据结构，可减少闪存磨损
>>> +- *树节点缓存(TNC)*：反映当前文件系统状态的内存 B+ 树，避免频繁读取闪存。本质上是索引的内
>>> +  存表示，但包含额外属性
>>> +- *LEB属性树(LPT)*：用于统计每个 UBI LEB 空闲空间的闪存B+树
>>> +
>>> +本节后续将详细讨论UBIFS的闪存数据结构。因为 TNC 不直接持久化到闪存，其在此处的重要性较低。
>>> +更多 UBIFS 细节详见[UBIFS-WP]。
>>> +
>>> +
>>> +UBIFS 索引与树节点缓存
>>> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>> +
>>> +UBIFS 在闪存上的基础实体称为 *节点* ，包含多种类型。如存储文件内容块的数据节点
>>> +( ``struct ubifs_data_node`` )，或表示 VFS 索引节点的 inode 节点
>>> +( ``struct ubifs_ino_node`` )。几乎所有节点共享包含节点类型、长度、序列号等基础信息的通用头
>>> +( ``ubifs_ch`` )（见内核源码 ``fs/ubifs/ubifs-media.h`` ）。LPT条目和填充节点（用于填充 LEB
>>> +尾部不可用空间）等次要节点类型除外。
>>> +
>>> +为避免每次变更重写整个 B+ 树，UBIFS 采用 *wandering tree* 实现：仅重写变更节点，旧版本被标记
>>> +废弃而非立即擦除。因此索引不固定存储于闪存某处，而是在闪存上 *wanders* ，在 LEB 被
>>> +UBIFS 重用前，闪存上会存在废弃部分。为定位最新索引，UBIFS 在 UBI LEB 1 存储称为 *主节点* 的特
>>> +殊节点，始终指向最新 UBIFS 索引根节点。为增强可恢复性，主节点还备份到 LEB 2。因此挂载 UBIFS
>>> +只需读取 LEB 1 和 2 获取当前主节点，进而定位最新闪存索引。
>>> +
>>> +TNC 是闪存索引的内存表示，包含未持久化的运行时属性（如脏标记）。TNC 作为回写式缓存，所有闪存索引
>>> +修改都通过 TNC 完成。与其他缓存类似，TNC 无需将完整索引全部加载到内存中，需要时从闪存读取部分内
>>> +容。 *提交* 是更新闪存文件系统结构（如索引）的 UBIFS 操作。每次提交时，标记为脏的 TNC 节点被写入
>>> +闪存以更新持久化索引。
>>> +
>>> +
>>> +日志
>>> +~~~~~~~
>>> +
>>> +为避免闪存磨损，索引仅在满足特定条件（如 ``fsync(2)`` ）时才持久化（提交）。日志用于记录索引提
>>> +交之间的所有变更（以 inode 节点、数据节点等形式）。挂载时从闪存读取日志并重放到 TNC（此时 TNC
>>> +按需从闪存索引创建）。
>>> +
>>> +UBIFS 保留一组专用于日志的 LEB（称为 *日志区* ）。日志区 LEB 数量在文件系统创建时配置（使用
>>> +``mkfs.ubifs`` ）并存储于超级块节点。日志区仅含两类节点： *引用节点* 和 *提交起始节点* 。执行索
>>> +引提交时写入提交起始节点，每次日志更新时写入引用节点。每个引用节点指向构成日志条目的其他节点（
>>> +inode 节点、数据节点等）在闪存上的位置，这些节点称为 *bud* ，描述包含数据的实际文件系统变更。
>>> +
>>> +日志区以环形缓冲区维护。当日志将满时触发提交操作，同时写入提交起始节点。因此挂载时 UBIFS 查找
>>> +最新提交起始节点，仅重放其后的引用节点。提交起始节点前的引用节点将被忽略（因其已属于闪存索引）。
>>> +
>>> +写入日志条目时，UBIFS 首先确保有足够空间写入引用节点和该条目的 bud。然后先写引用节点，再写描述
>>> +文件变更的 bud。在日志重放阶段，UBIFS 会记录每个参考节点，并检查其引用的 LEB位置以定位 buds。
>>> +若这些数据损坏或丢失，UBIFS 会尝试通过重新读取 LEB 来恢复，但仅针对日志中最后引用的 LEB，因为只
>>> +有它可能因断电而损坏。若恢复失败，UBIFS 将拒绝挂载。对于其他 LEB 的错误，UBIFS 会直接终止挂载操
>>> +作。
>>> +
>>> +::
>>> +
>>> +       | ----    LOG AREA     ---- | ----------    MAIN AREA    ------------ |
>>> +
>>> +        -----+------+-----+--------+----   ------+-----+-----+---------------
>>> +        \    |      |     |        |   /  /      |     |     |               \
>>> +        / CS |  REF | REF |        |   \  \ DENT | INO | INO |               /
>>> +        \    |      |     |        |   /  /      |     |     |               \
>>> +         ----+------+-----+--------+---   -------+-----+-----+----------------
>>> +                 |     |                  ^            ^
>>> +                 |     |                  |            |
>>> +                 +------------------------+            |
>>> +                       |                               |
>>> +                       +-------------------------------+
>>> +
>>> +
>>> +                图2：包含提交起始节点(CS)和引用节点(REF)的日志区闪存布局，引用节点指向含
>>> +                    bud 的主区
>>> +
>>> +
>>> +LEB属性树/表
>>> +~~~~~~~~~~~~~~~~~~~~~~~
>>> +
>>> +LEB 属性树用于存储每个 LEB 的信息，包括 LEB 类型、LEB 上的空闲空间和 *脏空间* （旧空间，废弃
>>> +内容） [1]_ 的数量。因为 UBIFS 从不在单个 LEB 混合存储索引节点和数据节点，所以 LEB 的类型至关
>>> +重要，每个 LEB 都有特定用途，这对空闲空间计算非常有帮助。详见[UBIFS-WP]。
>>> +
>>> +LEB 属性树也是 B+ 树，但远小于索引。因为其体积小，所以每次提交时都整块写入，保存 LPT 是原子操作。
>>> +
>>> +
>>> +.. [1] 由于LEB只能追加写入不能覆盖，空闲空间（即 LEB 剩余可写空间）与废弃内容（先前写入但未
>>> +   擦除前不能覆盖）存在区别。
>>> +
>>> +
>>> +UBIFS认证
>>> +====================
>>> +
>>> +本章介绍UBIFS认证，使UBIFS能验证闪存上元数据和文件内容的真实性与完整性。
>>> +
>>> +
>>> +威胁模型
>>> +------------
>>> +
>>> +UBIFS 认证可检测离线数据篡改。虽然不能防止篡改，但是能让（可信）代码检查闪存文件内容和文件系统元
>>> +数据的完整性与真实性，也能检查文件内容被替换的攻击。
>>> +
>>> +UBIFS 认证不防护全闪存内容回滚（攻击者可转储闪存内容并在后期还原）。也不防护单个索引提交的部分
>>> +回滚（攻击者能部分撤销变更）。这是因为 UBIFS 不立即覆盖索引树或日志的旧版本，而是标记为废弃，
>>> +稍后由垃圾回收擦除。攻击者可擦除当前树部分内容并还原闪存上尚未擦除的旧版本。因每次提交总会写入
>>> +索引根节点和主节点的新版本而不覆盖旧版本，UBI 的磨损均衡操作（将内容从物理擦除块复制到另一擦除
>>> +块且非原子擦除原块）进一步助长此问题。
>>> +
>>> +UBIFS 认证不覆盖认证密钥提供后攻击者在设备执行代码的攻击，需结合安全启动和可信启动等措施确保设
>>> +备仅执行可信代码。
>>> +
>>> +
>>> +认证
>>> +--------------
>>> +
>>> +为完全信任从闪存读取的数据，所有存储在闪存的 UBIFS 数据结构均需认证：
>>> +- 包含文件内容、扩展属性、文件长度等元数据的索引
>>> +- 通过记录文件系统变更来包含文件内容和元数据的日志
>>> +- 存储 UBIFS 用于空闲空间统计的 UBI LEB 元数据的 LPT
>>> +
>>> +
>>> +索引认证
>>> +~~~~~~~~~~~~~~~~~~~~
>>> +
>>> +借助 *wandering tree* 概念，UBIFS 仅更新和持久化从叶节点到根节点的变更部分。这允许用子节点哈
>>> +希增强索引树节点。最终索引基本成为 Merkle 树：因索引叶节点含实际文件系统数据，其父索引节点的
>>> +哈希覆盖所有文件内容和元数据。文件变更时，UBIFS 索引从叶节点到根节点（含主节点）相应更新，此
>>> +过程可挂钩以同步重新计算各变更节点的哈希。读取文件时，UBIFS 可从叶节点到根节点逐级验证哈希确保
>>> +节点完整性。
>>> +
>>> +为确保整个索引真实性，UBIFS 主节点存储基于密钥的哈希(HMAC)，覆盖自身内容及索引树根节点哈希。
>>> +如前所述，主节点在索引持久化时（即索引提交时）总会写入闪存。
>>> +
>>> +此方法仅修改 UBIFS 索引节点和主节点以包含哈希，其他类型节点保持不变，减少了对 UBIFS 用户（如
>>> +嵌入式设备）宝贵的存储开销。
>>> +
>>> +::
>>> +
>>> +                             +---------------+
>>> +                             |  Master Node  |
>>> +                             |    (hash)     |
>>> +                             +---------------+
>>> +                                     |
>>> +                                     v
>>> +                            +-------------------+
>>> +                            |  Index Node #1    |
>>> +                            |                   |
>>> +                            | branch0   branchn |
>>> +                            | (hash)    (hash)  |
>>> +                            +-------------------+
>>> +                               |    ...   |  (fanout: 8)
>>> +                               |          |
>>> +                       +-------+          +------+
>>> +                       |                         |
>>> +                       v                         v
>>> +            +-------------------+       +-------------------+
>>> +            |  Index Node #2    |       |  Index Node #3    |
>>> +            |                   |       |                   |
>>> +            | branch0   branchn |       | branch0   branchn |
>>> +            | (hash)    (hash)  |       | (hash)    (hash)  |
>>> +            +-------------------+       +-------------------+
>>> +                 |   ...                     |   ...   |
>>> +                 v                           v         v
>>> +               +-----------+         +----------+  +-----------+
>>> +               | Data Node |         | INO Node |  | DENT Node |
>>> +               +-----------+         +----------+  +-----------+
>>> +
>>> +
>>> +           图3：索引节点哈希与主节点 HMAC 的覆盖范围
>>> +
>>> +
>>> +
>>> +健壮性性和断电安全性的关键在于以原子操作持久化哈希值与文件内容。UBIFS 现有的变更节点持久化机制专为此设计，
>>> +能够确保断电时安全恢复。为索引节点添加哈希值不会改变该机制，因为每个哈希值都与其对应节点以原子操作同步持久化。
>>> +
>>> +
>>> +日志认证
>>> +~~~~~~~~~~~~~~~~~~~~~~
>>> +
>>> +日志也需要认证。因为日志持续写入，必须频繁地添加认证信息以确保断电时未认证数据量可控。方法是从提交起
>>> +始节点开始，对先前引用节点、当前引用节点和 bud 节点创建连续哈希链。适时地在bud节点间插入认证节
>>> +点，这种新节点类型包含哈希链当前状态的 HMAC。因此日志可认证至最后一个认证节点。日志尾部无认证节
>>> +点的部分无法认证，在日志重放时跳过。
>>> +
>>> +日志认证示意图如下::
>>> +
>>> +    ,,,,,,,,
>>> +    ,......,...........................................
>>> +    ,. CS  ,               hash1.----.           hash2.----.
>>> +    ,.  |  ,                    .    |hmac            .    |hmac
>>> +    ,.  v  ,                    .    v                .    v
>>> +    ,.REF#0,-> bud -> bud -> bud.-> auth -> bud -> bud.-> auth ...
>>> +    ,..|...,...........................................
>>> +    ,  |   ,
>>> +    ,  |   ,,,,,,,,,,,,,,,
>>> +    .  |            hash3,----.
>>> +    ,  |                 ,    |hmac
>>> +    ,  v                 ,    v
>>> +    , REF#1 -> bud -> bud,-> auth ...
>>> +    ,,,|,,,,,,,,,,,,,,,,,,
>>> +       v
>>> +      REF#2 -> ...
>>> +       |
>>> +       V
>>> +      ...
>>> +
>>> +因为哈希值包含引用节点，攻击者无法重排或跳过日志头重放，仅能移除日志尾部的bud节点或引用节点，最大
>>> +限度将文件系统回退至上次提交。
>>> +
>>> +日志区位置存储于主节点。因为主节点通过 HMAC 认证，所以未经检测无法篡改。日志区大小在文件系统创建时由
>>> +`mkfs.ubifs` 指定并存储于超级块节点。为避免篡改此值及其他参数，超级块结构添加 HMAC。超级块
>>> +节点存储在 LEB 0，仅在功能标志等变更时修改，文件变更时不修改。
>>> +
>>> +
>>> +LPT认证
>>> +~~~~~~~~~~~~~~~~~~
>>> +
>>> +LPT 根节点在闪存上的位置存储于 UBIFS 主节点。因为 LPT 每次提交时都以原子操作写入和读取，无需单独认证
>>> +树节点。通过主节点存储的简单哈希保护完整 LPT 即可。因为主节点自身已认证，通过验证主节点真实性并
>>> +比对存储的 LTP 哈希与读取的闪存 LPT 计算哈希值，即可验证 LPT 真实性。
>>> +
>>> +
>>> +密钥管理
>>> +--------------
>>> +
>>> +为了简化实现，UBIFS 认证使用单一密钥计算超级块、主节点、提交起始节点和引用节点的 HMAC。创建文
>>> +件系统(`mkfs.ubifs`) 时需提供此密钥以认证超级块节点。挂载文件系统时也需此密钥验证认证节点并
>>> +为变更生成新 HMAC。
>>> +
>>> +UBIFS 认证旨在与 UBIFS 加密(fscrypt)协同工作以提供保密性和真实性。因为 UBIFS 加密采用基于目录
>>> +的差异化加密策略，可能存在多个 fscrypt 主密钥甚至未加密目录。而 UBIFS 认证采用全有或全无方式，要么认
>>> +证整个文件系统要么完全不认证。基于此特性，且为确保认证机制可独立于加密功能使用，UBIFS 认证不与
>>> +fscrypt 共享主密钥，而是维护独立的认证专用密钥。
>>> +
>>> +提供认证密钥的API尚未定义，但可通过类似 fscrypt 的用户空间密钥环提供。需注意当前 fscrypt 方
>>> +案存在缺陷，用户空间 API 终将变更[FSCRYPT-POLICY2]。
>>> +
>>> +用户仍可通过用户空间提供单一口令或密钥覆盖 UBIFS 认证与加密。相应用户空间工具可解决此问题：除派
>>> +生的 fscrypt 加密主密钥外，额外派生认证密钥。
>>> +
>>> +为检查挂载时密钥可用性，UBIFS 超级块节点将额外存储认证密钥的哈希。此方法类似 fscrypt 加密策
>>> +略 v2 提出的方法[FSCRYPT-POLICY2]。
>>> +
>>> +
>>> +未来扩展
>>> +=================
>>> +
>>> +特定场景下，若供应商需要向客户提供认证文件系统镜像，应该能在不共享 UBIFS 认证密钥的前提下实现。方
>>> +法是在每个 HMAC 外额外存储数字签名，供应商随文件系统镜像分发公钥。若该文件系统后续需要修改，
>>> +若后续需修改该文件系统，UBIFS 可在首次挂载时将全部数字签名替换为 HMAC，其处理逻辑与 IMA/EVM 子系
>>> +统应对此类情况的方式类似。此时，HMAC 密钥需按常规方式预先提供。
>>> +
>>> +
>>> +参考
>>> +==========
>>> +
>>> +[CRYPTSETUP2]        https://www.saout.de/pipermail/dm-crypt/2017-November/005745.html
>>> +
>>> +[DMC-CBC-ATTACK]     https://www.jakoblell.com/blog/2013/12/22/practical-malleability-attack-against-cbc-en
>>> +crypted-luks-partitions/
>>> +
>>> +[DM-INTEGRITY]       https://www.kernel.org/doc/Documentation/device-mapper/dm-integrity.rst
>>> +
>>> +[DM-VERITY]          https://www.kernel.org/doc/Documentation/device-mapper/verity.rst
>>> +
>>> +[FSCRYPT-POLICY2]    https://www.spinics.net/lists/linux-ext4/msg58710.html
>>> +
>>> +[UBIFS-WP]           http://www.linux-mtd.infradead.org/doc/ubifs_whitepaper.pdf
>>> --
>>> 2.25.1


