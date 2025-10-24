Return-Path: <linux-kernel+bounces-867973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B3D8C040AA
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 03:47:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9CCA1891CF0
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 01:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8BC014386D;
	Fri, 24 Oct 2025 01:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="c1eb24y6"
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 530AB24B28
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 01:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761270449; cv=none; b=b2aRG3a0qf7mFFMGDlzUIrVZlan5bItlCRZpykhQyHslfCtb5uVVtsS26ccwSzaBTpCCuWyTreMHgXuQCMhYwpdsTaLCdHu/8tswFmMHmfpb9ei6+YZHig6VHzfyoLC/y/WV+tWsF0cTwNv3G2CCC7nSs0Ds/5kTkwiiQ8/xtCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761270449; c=relaxed/simple;
	bh=QELNA6nhX4nNTYx0aRq6taWLbP4BTxLUPBN9KDBIgtE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cE5JTt5+lg2WPw4Ph0Ljwb1+L6MM23hslsOWnn5SYkvfLxBUjrVprMfuFZi7wMQrkT65hvb96lOmzh+jcwcEbhwxV1didL2p5/IAIX3mUNUgAc/JYjokB5qCDt0dUogIlFBpHYzv+TuD6UTouzKGNAQ78Fbr2xGyVG0Y0sR1WnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=c1eb24y6; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <a5bafe85-5749-412a-b152-1480ecac353a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761270435;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=STflXpCWJ0a/kLZXXC4hXtGrl5H77gGbSnIMfRZiCBo=;
	b=c1eb24y6ch3LD8JM6vrSlyHnFy5bC8IqtuP87eoylAOZTtFTcfJXDMNp393MXln4ynkXtb
	BPgJ4PeTpY5tBMoZ3AkSOBW8rXaH7kAOWrGilEnbIRRPOyPyvfyS75DFcveofInlx52NtM
	RKTVbNFlPpzZNc5d6hSGCW5pQnrJPBU=
Date: Fri, 24 Oct 2025 09:47:06 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] docs/zh_CN: Add keys ecryptfs Chinese translation
To: Shuo Zhao <zhaoshuo@cqsoftware.com.cn>, alexs@kernel.org, corbet@lwn.net
Cc: dzm91@hust.edu.cn, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251021024219.752487-1-zhaoshuo@cqsoftware.com.cn>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yanteng Si <si.yanteng@linux.dev>
In-Reply-To: <20251021024219.752487-1-zhaoshuo@cqsoftware.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


在 2025/10/21 上午10:42, Shuo Zhao 写道:
> Translate .../security/keys/ecryptfs.rst into Chinese.
>
> Update the translation through commit ff348763775e
> ("doc: Fix acronym "FEKEK" in ecryptfs").
>
> Signed-off-by: Shuo Zhao <zhaoshuo@cqsoftware.com.cn>

Reviewed-by: Yanteng Si <siyanteng@cqsoftware.com.cn>


Thanks,
Yanteng

> ---
>   .../zh_CN/security/keys/ecryptfs.rst          | 69 +++++++++++++++++++
>   .../zh_CN/security/keys/index.rst             |  2 +-
>   2 files changed, 70 insertions(+), 1 deletion(-)
>   create mode 100644 Documentation/translations/zh_CN/security/keys/ecryptfs.rst
>
> diff --git a/Documentation/translations/zh_CN/security/keys/ecryptfs.rst b/Documentation/translations/zh_CN/security/keys/ecryptfs.rst
> new file mode 100644
> index 000000000000..6c2792ad31ff
> --- /dev/null
> +++ b/Documentation/translations/zh_CN/security/keys/ecryptfs.rst
> @@ -0,0 +1,69 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +.. include:: ../../disclaimer-zh_CN.rst
> +
> +:Original: Documentation/security/keys/ecryptfs.rst
> +
> +:翻译:
> +
> + 赵硕 Shuo Zhao <zhaoshuo@cqsoftware.com.cn>
> +
> +==========================
> +eCryptfs文件系统的加密密钥
> +==========================
> +
> +eCryptfs是一种堆叠式文件系统，它可以在文件级别上实现透明的加密与解密。每个文件都会
> +使用一个随机生成的文件加密密钥（FEK，File Encryption Key）来进行加密。
> +
> +每个FEK又会通过一个文件加密密钥加密密钥（FEKEK, File Encryption Key Encryption Key）
> +进行加密，这个过程可能发生在内核空间或用户空间的守护进程“ecryptfsd”中。在内核空间中
> +FEK的加密和解密操作由内核的CryptoAPI直接执行，使用一个由用户输入的口令派生出的 FEKEK。
> +在用户空间中，该操作由守护进程“ecryptfsd”完成，并借助外部库以支持更多机制，例如公钥
> +加密、PKCS#11，以及基于TPM（可信平台模块）的操作。
> +
> +为了存储解密 FEK 所需的信息，eCryptfs 定义了一种称为认证令牌（authentication token）的
> +数据结构。目前，这种令牌可以存储在内核的“user”类型密钥中，由用户空间的实用工具mount.ecryptfs
> +（属于 ecryptfs-utils 软件包）插入到用户的会话密钥环中。
> +
> +为了与eCryptfs文件系统配合使用，“encrypted” 密钥类型被扩展，引入了新的格式 “ecryptfs”。
> +该新格式的加密密钥在其载荷（payload）中保存了一个认证令牌，其中包含一个由内核随机生成的
> +FEKEK，并且该FEKEK又受父主密钥（parent master key）保护。
> +
> +为了防止已知明文攻击（known-plaintext attack），通过命令‘keyctl print’或‘keyctl pipe’
> +获得的数据块并不包含完整的认证令牌（其内容是众所周知的），而只包含经过加密的 FEKEK。
> +
> +eCryptfs文件系统能够切实受益于加密密钥的使用，因为管理员可以在系统启动时，在受控环境
> +中通过“trusted”密钥解封后安全地生成所需密钥并挂载文件系统。此外，由于密钥只在内核层
> +以明文形式存在，因此可以避免被恶意软件窃取或攻击的风险。
> +
> +Usage::
> +
> +   keyctl add encrypted name "new ecryptfs key-type:master-key-name keylen" ring
> +   keyctl add encrypted name "load hex_blob" ring
> +   keyctl update keyid "update key-type:master-key-name"
> +
> +Where::
> +
> +        name:= '<16 hexadecimal characters>'
> +        key-type:= 'trusted' | 'user'
> +        keylen:= 64
> +
> +使用eCryptfs文件系统时加密密钥示例：
> +
> +创建一个长度为64字节的加密密钥“1000100010001000”，格式为‘ecryptfs’，并使用之前加载的用户
> +密钥“test”保存它::
> +
> +    $ keyctl add encrypted 1000100010001000 "new ecryptfs user:test 64" @u
> +    19184530
> +
> +    $ keyctl print 19184530
> +    ecryptfs user:test 64 490045d4bfe48c99f0d465fbbbb79e7500da954178e2de0697
> +    dd85091f5450a0511219e9f7cd70dcd498038181466f78ac8d4c19504fcc72402bfc41c2
> +    f253a41b7507ccaa4b2b03fff19a69d1cc0b16e71746473f023a95488b6edfd86f7fdd40
> +    9d292e4bacded1258880122dd553a661
> +
> +    $ keyctl pipe 19184530 > ecryptfs.blob
> +
> +使用创建的加密密钥“1000100010001000”将eCryptfs文件系统挂载到‘/secret’目录::
> +
> +    $ mount -i -t ecryptfs -oecryptfs_sig=1000100010001000,\
> +      ecryptfs_cipher=aes,ecryptfs_key_bytes=32 /secret /secret
> diff --git a/Documentation/translations/zh_CN/security/keys/index.rst b/Documentation/translations/zh_CN/security/keys/index.rst
> index 7c28d003fb0a..6c6bd3517b34 100644
> --- a/Documentation/translations/zh_CN/security/keys/index.rst
> +++ b/Documentation/translations/zh_CN/security/keys/index.rst
> @@ -14,9 +14,9 @@
>   .. toctree::
>      :maxdepth: 1
>   
> +   ecryptfs
>   
>   TODOLIST:
>   * core
> -* ecryptfs
>   * request-key
>   * trusted-encrypted

