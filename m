Return-Path: <linux-kernel+bounces-862084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 46E40BF4654
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 04:42:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 062B34E84BD
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 02:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0C66262FEC;
	Tue, 21 Oct 2025 02:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cqsoftware.com.cn header.i=@cqsoftware.com.cn header.b="J2T/uNZR"
Received: from mail-m15597.qiye.163.com (mail-m15597.qiye.163.com [101.71.155.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD4717B43F;
	Tue, 21 Oct 2025 02:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761014557; cv=none; b=SDibE9ws7lbD0gUZBFbRD5Rm1NB/aI/+UxY9wyc1s9uEy21oDzDxN+V+29zx8wOCOEi0vAqNNEJLhRweh1L+rMw0zVnaezSzKxj0Sa7yWYktwCXA+aSbpxDv4XzBstpjah98/dNXGTWULFhZLa3FbLXsEbHHzVIiC/lF/Lb19GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761014557; c=relaxed/simple;
	bh=JmWywGJL/0qjCIH8yFJqS1NeOIUTYN9SDlZvv/jVS+w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ExnkXDrEZPWky0m9VuEW5zzQX1qlDxXemAjhnGxd1RAks25yx1OLkgxBNJoLzdUPgTY+UzGy+FBc5i3ujeC57UShKp/IWGpJ4+lYntL9+T2ibDZ5NckoGOV4uRpIWHXOgqmYYl79CbFDrlIlvB48DPk8CWp4bLz/iY7ex5pUu/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cqsoftware.com.cn; spf=pass smtp.mailfrom=cqsoftware.com.cn; dkim=pass (1024-bit key) header.d=cqsoftware.com.cn header.i=@cqsoftware.com.cn header.b=J2T/uNZR; arc=none smtp.client-ip=101.71.155.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cqsoftware.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cqsoftware.com.cn
Received: from fedora.localdomain (unknown [1.193.59.83])
	by smtp.qiye.163.com (Hmail) with ESMTP id 2696ffc25;
	Tue, 21 Oct 2025 10:42:22 +0800 (GMT+08:00)
From: Shuo Zhao <zhaoshuo@cqsoftware.com.cn>
To: alexs@kernel.org,
	si.yanteng@linux.dev,
	corbet@lwn.net
Cc: dzm91@hust.edu.cn,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shuo Zhao <zhaoshuo@cqsoftware.com.cn>
Subject: [PATCH] docs/zh_CN: Add keys ecryptfs Chinese translation
Date: Tue, 21 Oct 2025 10:42:18 +0800
Message-ID: <20251021024219.752487-1-zhaoshuo@cqsoftware.com.cn>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9a04a5719f09d0kunmbb2918ed18705a7
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaGh9IVk9MS0NPGhpMTk4YTlYVFAkWGhdVEwETFh
	oSFyQUDg9ZV1kYEgtZQVlKVUpCSFVOQlVDSFlXWRYaDxIVHRRZQVlPS0hVSktJT09PSFVKS0tVSk
	JLS1kG
DKIM-Signature: a=rsa-sha256;
	b=J2T/uNZRvhp1kZSLiTZMLW1iT3apAk7FLEARgtt+YQQ8C0p9FoKvS2/+MLTw60+c65TuIYbhIvOl2J2kSp+wRUQdoLGauD2LO26COSsOpV3WatrwjtJ58X7PAE7muFuP9Xqbxipb9yfFQEYFcJhIABRTapK2/DzWeciap0Ck2Cc=; s=default; c=relaxed/relaxed; d=cqsoftware.com.cn; v=1;
	bh=ZcDlgUKlvxynyM0gVWb7zaf8gAUNWUkYBkqzwyNqMpU=;
	h=date:mime-version:subject:message-id:from;

Translate .../security/keys/ecryptfs.rst into Chinese.

Update the translation through commit ff348763775e
("doc: Fix acronym "FEKEK" in ecryptfs").

Signed-off-by: Shuo Zhao <zhaoshuo@cqsoftware.com.cn>
---
 .../zh_CN/security/keys/ecryptfs.rst          | 69 +++++++++++++++++++
 .../zh_CN/security/keys/index.rst             |  2 +-
 2 files changed, 70 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/translations/zh_CN/security/keys/ecryptfs.rst

diff --git a/Documentation/translations/zh_CN/security/keys/ecryptfs.rst b/Documentation/translations/zh_CN/security/keys/ecryptfs.rst
new file mode 100644
index 000000000000..6c2792ad31ff
--- /dev/null
+++ b/Documentation/translations/zh_CN/security/keys/ecryptfs.rst
@@ -0,0 +1,69 @@
+.. SPDX-License-Identifier: GPL-2.0
+.. include:: ../../disclaimer-zh_CN.rst
+
+:Original: Documentation/security/keys/ecryptfs.rst
+
+:翻译:
+
+ 赵硕 Shuo Zhao <zhaoshuo@cqsoftware.com.cn>
+
+==========================
+eCryptfs文件系统的加密密钥
+==========================
+
+eCryptfs是一种堆叠式文件系统，它可以在文件级别上实现透明的加密与解密。每个文件都会
+使用一个随机生成的文件加密密钥（FEK，File Encryption Key）来进行加密。
+
+每个FEK又会通过一个文件加密密钥加密密钥（FEKEK, File Encryption Key Encryption Key）
+进行加密，这个过程可能发生在内核空间或用户空间的守护进程“ecryptfsd”中。在内核空间中
+FEK的加密和解密操作由内核的CryptoAPI直接执行，使用一个由用户输入的口令派生出的 FEKEK。
+在用户空间中，该操作由守护进程“ecryptfsd”完成，并借助外部库以支持更多机制，例如公钥
+加密、PKCS#11，以及基于TPM（可信平台模块）的操作。
+
+为了存储解密 FEK 所需的信息，eCryptfs 定义了一种称为认证令牌（authentication token）的
+数据结构。目前，这种令牌可以存储在内核的“user”类型密钥中，由用户空间的实用工具mount.ecryptfs
+（属于 ecryptfs-utils 软件包）插入到用户的会话密钥环中。
+
+为了与eCryptfs文件系统配合使用，“encrypted” 密钥类型被扩展，引入了新的格式 “ecryptfs”。
+该新格式的加密密钥在其载荷（payload）中保存了一个认证令牌，其中包含一个由内核随机生成的
+FEKEK，并且该FEKEK又受父主密钥（parent master key）保护。
+
+为了防止已知明文攻击（known-plaintext attack），通过命令‘keyctl print’或‘keyctl pipe’
+获得的数据块并不包含完整的认证令牌（其内容是众所周知的），而只包含经过加密的 FEKEK。
+
+eCryptfs文件系统能够切实受益于加密密钥的使用，因为管理员可以在系统启动时，在受控环境
+中通过“trusted”密钥解封后安全地生成所需密钥并挂载文件系统。此外，由于密钥只在内核层
+以明文形式存在，因此可以避免被恶意软件窃取或攻击的风险。
+
+Usage::
+
+   keyctl add encrypted name "new ecryptfs key-type:master-key-name keylen" ring
+   keyctl add encrypted name "load hex_blob" ring
+   keyctl update keyid "update key-type:master-key-name"
+
+Where::
+
+        name:= '<16 hexadecimal characters>'
+        key-type:= 'trusted' | 'user'
+        keylen:= 64
+
+使用eCryptfs文件系统时加密密钥示例：
+
+创建一个长度为64字节的加密密钥“1000100010001000”，格式为‘ecryptfs’，并使用之前加载的用户
+密钥“test”保存它::
+
+    $ keyctl add encrypted 1000100010001000 "new ecryptfs user:test 64" @u
+    19184530
+
+    $ keyctl print 19184530
+    ecryptfs user:test 64 490045d4bfe48c99f0d465fbbbb79e7500da954178e2de0697
+    dd85091f5450a0511219e9f7cd70dcd498038181466f78ac8d4c19504fcc72402bfc41c2
+    f253a41b7507ccaa4b2b03fff19a69d1cc0b16e71746473f023a95488b6edfd86f7fdd40
+    9d292e4bacded1258880122dd553a661
+
+    $ keyctl pipe 19184530 > ecryptfs.blob
+
+使用创建的加密密钥“1000100010001000”将eCryptfs文件系统挂载到‘/secret’目录::
+
+    $ mount -i -t ecryptfs -oecryptfs_sig=1000100010001000,\
+      ecryptfs_cipher=aes,ecryptfs_key_bytes=32 /secret /secret
diff --git a/Documentation/translations/zh_CN/security/keys/index.rst b/Documentation/translations/zh_CN/security/keys/index.rst
index 7c28d003fb0a..6c6bd3517b34 100644
--- a/Documentation/translations/zh_CN/security/keys/index.rst
+++ b/Documentation/translations/zh_CN/security/keys/index.rst
@@ -14,9 +14,9 @@
 .. toctree::
    :maxdepth: 1
 
+   ecryptfs
 
 TODOLIST:
 * core
-* ecryptfs
 * request-key
 * trusted-encrypted
-- 
2.49.0


