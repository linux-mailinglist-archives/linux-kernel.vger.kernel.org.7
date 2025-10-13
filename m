Return-Path: <linux-kernel+bounces-849910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F7FCBD149F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 05:00:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7EFE34EC07A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 02:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8BC42EC08A;
	Mon, 13 Oct 2025 02:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cqsoftware.com.cn header.i=@cqsoftware.com.cn header.b="PA3oWr99"
Received: from mail-m49239.qiye.163.com (mail-m49239.qiye.163.com [45.254.49.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 483C41F5423;
	Mon, 13 Oct 2025 02:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760324337; cv=none; b=NR5RnLlRxT93NenIOX66fMa7qemmHKmsxgYvvsl5HgVU0pLtbsVKWxHWv/d/XF9UNxYwMzyac8ZTA8fLhyu/Y1P2ouWuKPDm8R/U8pybXVrU8Waus5vqq2dJk28fa95VP3gvOaVmVUeok0dgGTOA3vy+wt4vawSbe5GCmfnwdbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760324337; c=relaxed/simple;
	bh=+fBv2yrefiEFXAlI1AFivC+r4twp4/wVeMPP1LYrxw0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kUVyBzSfMbmX/vws0DJeqeRXjX3nAFkWHKMJTv7KDmKun9w59K3SJZsi0kv2dZJka04zVRKDwrai9x+y/IC2njZOrK4RZUH10v6BGkIvoPMiwlWd3sXxtrUfAlrKH8rKvi43hz3TZpf8yfIIV8wJczgiiUqNtVanDk9gtsmgzpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cqsoftware.com.cn; spf=pass smtp.mailfrom=cqsoftware.com.cn; dkim=pass (1024-bit key) header.d=cqsoftware.com.cn header.i=@cqsoftware.com.cn header.b=PA3oWr99; arc=none smtp.client-ip=45.254.49.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cqsoftware.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cqsoftware.com.cn
Received: from [192.168.6.2] (unknown [1.193.57.161])
	by smtp.qiye.163.com (Hmail) with ESMTP id 25a706556;
	Mon, 13 Oct 2025 10:43:27 +0800 (GMT+08:00)
Message-ID: <0b898b79-8944-489d-a428-ed4b99ef9ba5@cqsoftware.com.cn>
Date: Mon, 13 Oct 2025 10:43:29 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs/zh_CN: Add secrets coco Chinese translation
To: Yanteng Si <si.yanteng@linux.dev>, alexs@kernel.org, corbet@lwn.net
Cc: dzm91@hust.edu.cn, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251010054905.602278-1-zhaoshuo@cqsoftware.com.cn>
 <677a2dc3-9838-4a79-9b7a-888a81c7d4e7@linux.dev>
From: zhaoshuo <zhaoshuo@cqsoftware.com.cn>
In-Reply-To: <677a2dc3-9838-4a79-9b7a-888a81c7d4e7@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a99db738f1409d0kunm79d5f0862c420c4
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDHh0ZVkhCQx8aQhlMS0tJTlYVFAkWGhdVEwETFh
	oSFyQUDg9ZV1kYEgtZQVlKVUpCSFVOTFVKTUpZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0hVSktLVU
	pCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=PA3oWr99URB5mcQvYNod408+yk/bYhRM5gN0uNmwUAOyYpyl4ZK7wXDZha+0yYGe/NCRcvchutLDg4kRWe1no97PQ0bAOjmh22SuTkHg6j7dzHofXvdOzLrB+ctgcnVJTuoMDYc0yKU6q5MPKk8R3hj+F0D+MsTPAOgg8uV8yCg=; s=default; c=relaxed/relaxed; d=cqsoftware.com.cn; v=1;
	bh=LwbRDWvJ8rnzZS5/DjFCqJU+R8XkNYf2iJhw1fEF2uo=;
	h=date:mime-version:subject:message-id:from;


在 2025/10/13 10:34, Yanteng Si 写道:
>
> 在 2025/10/10 下午1:49, Shuo Zhao 写道:
>> Translate .../security/secrets/coco.rst into Chinese.
>>
>> Update the translation through commit d56b699d76d1
>> ("Documentation: Fix typos").
>>
>> Signed-off-by: Shuo Zhao <zhaoshuo@cqsoftware.com.cn>
>> ---
>>   .../zh_CN/security/secrets/coco.rst           | 96 +++++++++++++++++++
>>   .../zh_CN/security/secrets/index.rst          |  9 +-
>>   2 files changed, 99 insertions(+), 6 deletions(-)
>>   create mode 100644 
>> Documentation/translations/zh_CN/security/secrets/coco.rst
>>
>> diff --git 
>> a/Documentation/translations/zh_CN/security/secrets/coco.rst 
>> b/Documentation/translations/zh_CN/security/secrets/coco.rst
>> new file mode 100644
>> index 000000000000..057a8fdf1e3b
>> --- /dev/null
>> +++ b/Documentation/translations/zh_CN/security/secrets/coco.rst
>> @@ -0,0 +1,96 @@
>> +.. SPDX-License-Identifier: GPL-2.0
>> +.. include:: ../../disclaimer-zh_CN.rst
>> +
>> +:Original: Documentation/security/secrets/coco.rst
>> +
>> +:翻译:
>> +
>> + 赵硕 Shuo Zhao <zhaoshuo@cqsoftware.com.cn>
>> +
>> +============
>> +机密计算密钥
>> +============
>> +
>> +本文档介绍了在EFI驱动程序和efi_secret内核模块中，机密计算密钥从固件
>> +到操作系统的注入处理流程。
>> +
>> +简介
>> +====
>> +
>> +机密计算硬件（如AMD SEV，Secure Encrypted Virtualization）允许虚拟机
>> +所有者将密钥注入虚拟机（VM）内存，且主机/虚拟机监控程序无法读取这些密
>> +钥。在SEV中，密钥注入需在虚拟机启动流程的早期阶段（客户机开始运行前）
>> +执行。
>> +
>> +efi_secret内核模块允许用户空间应用程序通过securityfs（安全文件系统）访
>> +问这些密钥。
>> +
>> +密钥数据流
>> +==========
>> +
>> +客户机固件可能会为密钥注入预留一块指定的内存区域，并将该区域的位置（基准 
>>
>> +客户机物理地址GPA和长度）在EFI配置表中，通过 
>> ``LINUX_EFI_COCO_SECRET_AREA_GUID``
>> +条目（对应的GUID值为 ``adf956ad-e98c-484c-ae11-b51c7d336447`` 
>> ）的形式发布。
>> +固件应将此内存区域标记为 ``EFI_RESERVED_TYPE`` 
>> ，因此内核不应将其用于自身用途。
>> +
>> +虚拟机启动过程中，虚拟机管理器可向该区域注入密钥。在AMD 
>> SEV和SEV-ES中，此
>> +操作通过 ``KVM_SEV_LAUNCH_SECRET`` 命令执行（参见 [sev]_ 
>> ）。注入的“客户机
>> +所有者密钥数据”应采用带GUID的密钥值表结构，其二进制格式在 
>> ``drivers/virt/
>> +coco/efi_secret/efi_secret.c`` 文件的EFI密钥区域结构部分中有详细描述。
>> +
>> +内核启动时，内核的EFI驱动程序将保存密钥区域位置（来自EFI配置表）到 
>> ``efi.coco_secret``
>> +字段。随后，它会检查密钥区域是否已填充：映射该区域并检查其内容是否以
>> +``EFI_SECRET_TABLE_HEADER_GUID`` （对应的GUID为 
>> ``1e74f542-71dd-4d66-963e-ef4287ff173b`` ）
>> +开头。如果密钥区域已填充，EFI驱动程序将自动加载efi_secret内核模块，并通过securityfs将密钥 
>>
>> +暴露给用户空间应用程序。efi_secret文件系统接口的详细信息请参考 
>> [secrets-coco-abi]_ 。
>> +
>> +
>> +应用使用示例
>> +============
>> +
>> +假设客户机需要对加密文件进行计算处理。客户机所有者通过密钥注入机制提供解密密钥 
>>
>> +（即密钥）。客户机应用程序从efi_secret文件系统读取该密钥，然后将文件解密到内存中， 
>>
>> +接着对内容进行需要的计算。
>> +
>> +在此示例中，主机无法从磁盘镜像中读取文件，因为文件是加密的；主机无法读取解密密钥， 
>>
>> +因为它是通过密钥注入机制（即安全通道）传递的；主机也无法读取内存中的解密内容，因为 
>>
>> +这是一个机密型（内存加密）客户机。
>> +
>> +以下是一个简单的示例，展示了在客户机中使用efi_secret模块的过程，在启动时注入了 
>>
>> +一个包含4个密钥的EFI密钥区域::
>> +
>> +        # ls -la /sys/kernel/security/secrets/coco
>> +        total 0
>> +        drwxr-xr-x 2 root root 0 Jun 28 11:54 .
>> +        drwxr-xr-x 3 root root 0 Jun 28 11:54 ..
>> +        -r--r----- 1 root root 0 Jun 28 11:54 
>> 736870e5-84f0-4973-92ec-06879ce3da0b
>> +        -r--r----- 1 root root 0 Jun 28 11:54 
>> 83c83f7f-1356-4975-8b7e-d3a0b54312c6
>> +        -r--r----- 1 root root 0 Jun 28 11:54 
>> 9553f55d-3da2-43ee-ab5d-ff17f78864d2
>> +        -r--r----- 1 root root 0 Jun 28 11:54 
>> e6f5a162-d67f-4750-a67c-5d065f2a9910
>> +
>> +        # hd 
>> /sys/kernel/security/secrets/coco/e6f5a162-d67f-4750-a67c-5d065f2a9910
>> +        00000000  74 68 65 73 65 2d 61 72  65 2d 74 68 65 2d 6b 61  
>> |these-are-the-ka|
>> +        00000010  74 61 2d 73 65 63 72 65  74 73 00 01 02 03 04 05  
>> |ta-secrets......|
>> +        00000020  06 07                                             
>> |..|
>> +        00000022
>> +
>> +        # rm 
>> /sys/kernel/security/secrets/coco/e6f5a162-d67f-4750-a67c-5d065f2a9910
>> +
>> +        # ls -la /sys/kernel/security/secrets/coco
>> +        total 0
>> +        drwxr-xr-x 2 root root 0 Jun 28 11:55 .
>> +        drwxr-xr-x 3 root root 0 Jun 28 11:54 ..
>> +        -r--r----- 1 root root 0 Jun 28 11:54 
>> 736870e5-84f0-4973-92ec-06879ce3da0b
>> +        -r--r----- 1 root root 0 Jun 28 11:54 
>> 83c83f7f-1356-4975-8b7e-d3a0b54312c6
>> +        -r--r----- 1 root root 0 Jun 28 11:54 
>> 9553f55d-3da2-43ee-ab5d-ff17f78864d2
>> +
>> +
>> +参考文献
>> +========
>> +
>> +请参见 [sev-api-spec]_ 以获取有关SEV ``LAUNCH_SECRET`` 操作的更多信息。
>> +
>
>> +[sev] Documentation/virt/kvm/x86/amd-memory-encryption.rst
>> +[secrets-coco-abi] Documentation/ABI/testing/securityfs-secrets-coco
>> +[sev-api-spec] 
>> https://www.amd.com/system/files/TechDocs/55766_SEV-KM_API_Specification.pdf
>
> sev_CN will not introduce build warning.
>
>
> Thanks,
>
> Yanteng

Ok.


Thanks,

ZhaoShuo

>
>> +
>> diff --git 
>> a/Documentation/translations/zh_CN/security/secrets/index.rst 
>> b/Documentation/translations/zh_CN/security/secrets/index.rst
>> index 5ea78713f10e..38464dcb2c3c 100644
>> --- a/Documentation/translations/zh_CN/security/secrets/index.rst
>> +++ b/Documentation/translations/zh_CN/security/secrets/index.rst
>> @@ -5,13 +5,10 @@
>>     :翻译:
>>   -=====================
>> +========
>>   密钥文档
>> -=====================
>> +========
>>     .. toctree::
>>   -
>> -TODOLIST:
>> -
>> -* coco
>> +   coco
>
>

