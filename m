Return-Path: <linux-kernel+bounces-795649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D8A14B3F5E3
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 08:48:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4846E1A8686D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 06:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5E6B2E54A2;
	Tue,  2 Sep 2025 06:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cqsoftware.com.cn header.i=@cqsoftware.com.cn header.b="HhmamiIH"
Received: from mail-m49211.qiye.163.com (mail-m49211.qiye.163.com [45.254.49.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF352AF1B;
	Tue,  2 Sep 2025 06:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756795728; cv=none; b=KckKDIySGr4qMCL1EChh2lYvwLURsVRLxX39sRQYnQv7yNDu5Tp/X4ax8Y6asW8lzTGNkvyhOEiYYvXTguEP1cvtwgKkXTiTqX9mgYGZp0iJo4ruYI7hOb1mOi8QiZfpxp9/hJlu+Hdw7JeqPpn/oa1lDoN1VfwLtUwvjWWhMZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756795728; c=relaxed/simple;
	bh=Vqk4u5aiSb6hQfSRVBejkvhgqrTqyOSAY0HvzcEUkM4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jn8LHn8Yfu4cKq6ztiWnJTASHep4no/6DdfnTzE4IkuPAUa1aj24Kg1d6TSREK/S1GhPHgxMusj9qJA/gJxsfGy6WfEyo9KyEDqeBm1rPWnDxE2eFDB9Y5tJ6ovj+aUzG/S00MXKP1mrha6sBdzJzMDkAlyl8vj3VijHtvfD1js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cqsoftware.com.cn; spf=pass smtp.mailfrom=cqsoftware.com.cn; dkim=pass (1024-bit key) header.d=cqsoftware.com.cn header.i=@cqsoftware.com.cn header.b=HhmamiIH; arc=none smtp.client-ip=45.254.49.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cqsoftware.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cqsoftware.com.cn
Received: from fedora.localdomain (unknown [123.53.36.111])
	by smtp.qiye.163.com (Hmail) with ESMTP id 215dc3bd6;
	Tue, 2 Sep 2025 11:19:22 +0800 (GMT+08:00)
From: Shuo Zhao <zhaoshuo@cqsoftware.com.cn>
To: alexs@kernel.org,
	si.yanteng@linux.dev,
	corbet@lwn.net
Cc: dzm91@hust.edu.cn,
	zhaoshuo@cqsoftware.com.cn,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] docs/zh_CN: Add security ipe Chinese translation
Date: Tue,  2 Sep 2025 11:19:16 +0800
Message-ID: <20250902031918.591908-1-zhaoshuo@cqsoftware.com.cn>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a99086fb60009d0kunm47aa8d0c20b7d7
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCGB8ZVh9CT0NLSBhMHUxNT1YVFAkWGhdVEwETFh
	oSFyQUDg9ZV1kYEgtZQVlKSUhVTkhVSE1VSkpKWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
	VKQktLWQY+
DKIM-Signature: a=rsa-sha256;
	b=HhmamiIHgdANMhqWlOph+/B4kEDosg2a11HLRl+zyd1ywdtRSD074Ba8l1TqGFVnup1CFVoAUdgTUzuDRo85yjUnU4EiJ1pJgQwMat4u2EdpmlW9Njy+Yroa0UbKSYaWsEJ+t38k7yqz5dwmz748BRgKMJL/As38A7CYRjTywHE=; s=default; c=relaxed/relaxed; d=cqsoftware.com.cn; v=1;
	bh=YI7lm9EdBU+ebhMsrfiwOO+KmB9/RQY9jUz6lPnAQdU=;
	h=date:mime-version:subject:message-id:from;

Translate .../security/ipe.rst into Chinese.

Update the translation through commit ac6731870ed9
("documentation: add IPE documentation")

Signed-off-by: Shuo Zhao <zhaoshuo@cqsoftware.com.cn>
---
 .../translations/zh_CN/security/ipe.rst       | 398 ++++++++++++++++++
 1 file changed, 398 insertions(+)
 create mode 100644 Documentation/translations/zh_CN/security/ipe.rst

diff --git a/Documentation/translations/zh_CN/security/ipe.rst b/Documentation/translations/zh_CN/security/ipe.rst
new file mode 100644
index 000000000000..55968f0c7ae3
--- /dev/null
+++ b/Documentation/translations/zh_CN/security/ipe.rst
@@ -0,0 +1,398 @@
+.. SPDX-License-Identifier: GPL-2.0
+.. include:: ../disclaimer-zh_CN.rst
+
+:Original: Documentation/security/sak.rst
+
+:翻译:
+ 赵硕 Shuo Zhao <zhaoshuo@cqsoftware.com.cn>
+
+完整性策略执行（IPE）-内核文档
+==============================
+
+.. NOTE::
+
+   这是针对开发人员而不是管理员的文档。如果您正在
+   寻找有关IPE使用的文档，请参阅 :doc:`IPE admin
+   guide </admin-guide/LSM/ipe>`。
+
+历史背景
+--------
+
+最初促使IPE实施的原因，是需要创建一个锁定式系统。该系统将
+从一开始就具备安全性，并且在可执行代码和系统功能关键的特定
+数据文件上，提供强有力的完整性保障。只有当这些特定数据文件
+符合完整性策略时，它们才可以被读取。系统中还将存在强制访问
+控制机制，因此扩展属性（xattrs）也必须受到保护。这就引出了
+需要选择能够提供完整性保证的机制。当时，有两种主要机制被考
+虑，用以在满足这些要求的前提下保证系统完整性：
+
+  1. IMA + EVM Signatures
+  2. DM-Verity
+
+这两个选项都经过了仔细考虑，然而在原始的IPE使用场景
+中，最终选择DM-Verity而非IMA+EVM作为完整性机制，主
+要有三个原因：
+
+  1. 防护额外的攻击途径
+
+    * 使用IMA+EVM时，如果没有加密解决方案，系统很容易受到
+      离线攻击，特别是针对上述特定数据文件的攻击。
+
+      与可执行文件不同，读取操作（如对受保护数据文件的读
+      取操作）无法强制性进行全局完整性验证。这意味着必须
+      有一种选择机制来决定是否应对某个读取操作实施完整性
+      策略。
+
+      在当时，这是通过强制访问控制标签来实现的，IMA策略会
+      指定哪些标签需要进行完整性验证，这带来了一个问题：
+      EVM虽然可以保护标签，但如果攻击者离线修改文件系统，
+      那么攻击者就可以清除所有的扩展属性（xattrs）——包括
+      用于确定文件是否应受完整性策略约束的SELinux标签。
+
+      使用DM-Verity，由于xattrs被保存为Merkel树的一部分，
+      如果对由dm-verity保护的文件系统进行了离线挂载，校验
+      和将不在匹配，文件将无法读取。
+
+    * 由于用户空间的二进制文件在Linux中是分页加载的，dm-
+      verity同样提供了对抗恶意块设备的额外保护。在这样的
+      攻击中，块设备最初报告适当的内容以供IMA哈希计算，通
+      过所需的完整性检查。然后，在访问真实数据时发生的页面
+      错误将报告攻击者的有效载荷。由于dm-verity会在页面错
+      误发生时检查数据（以及磁盘访问），因此这种攻击得到了
+      缓解。
+
+  2. 性能:
+
+    * dm-verity在块被读取时按需提供完整性验证，而不需要将整
+      个文件读入内存进行验证。
+
+  3. 签名的简化性:
+
+    * 不需要两个签名（IMA 然后是 EVM）：一个签名可以覆盖整个
+      块设备。
+    * 签名可以存储在文件系统元数据之外。
+    * 该签名支持基于 x.509 的签名基础设施。
+
+下一步是选择一个策略来执行完整性验证机制，该策略的最低
+要求是：
+
+  1. 策略本身必须经过完整性验证（防止针对它的简单攻击）。
+  2. 策略本身必须抵抗回滚攻击。
+  3. 策略执行必须具有类似宽松模式的功能。
+  4. 策略必须能够在不重启的情况下，完整地进行更新。
+  5. 策略更新必须是原子性的。
+  6. 策略必须支持撤销先前创建的组件。
+  7. 策略必须在任何时间点都能进行审计。
+
+当时，IMA作为唯一的完整性策略机制，被用来与这些要求进行对比，
+但未能满足所有最低要求。尽管考虑过扩展IMA以涵盖这些要求，但
+最终因两个原因被放弃：
+
+  1. 回归风险；这其中许多变更将导致对已经存在于内核的IMA进行
+     重大代码更改，因此可能会影响用户。
+
+  2. IMA在该系统中用于测量和证明；将测量策略与本地完整性策略
+     的执行分离被认为是有利的。
+
+由于这些原因，决定创建一个新的LSM，其职责是仅限于本地完整性
+策略的执行。
+
+职责和范围
+----------
+
+IPE顾名思义，本质上是一种完整性策略执行解决方案；IPE并不强制规定
+如何提供完整性保障，而是将这一决策权留给系统管理员，管理员根据自身
+需求，选择符合的机制来设定安全标准。存在几种不同的完整性解决方案，
+它们提供了不同程度的安全保障；而IPE允许系统管理员理论上为所有这些
+解决方案制定策略。
+
+IPE自身没有内置确保完整性的固有机制。相反，在构建具备完整性保障能力
+的系统时，存在更高效的分层方案可供使用。需要重点注意的是，用于证明完
+整性的机制，与用于执行完整性声明的策略是相互独立的。
+
+因此，IPE依据以下方面进行设计：
+
+  1. 便于与完整性提供机制集成。
+  2. 便于平台管理员/系统管理员使用。
+
+设计理由:
+---------
+
+IPE是在评估其他操作系统和环境中的现有完整性策略解决方案后设计的。
+在对其他实现的调查中，发现了一些缺陷：
+
+  1. 策略不易为人们读取，通常需要二进制中间格式。
+  2. 默认情况下会隐式采取单一的、不可定制的操作。
+  3. 调试策略需要手动来确定违反了哪个规则。
+  4. 编写策略需要对更大系统或操作系统有深入的了解。
+
+IPE尝试避免所有这些缺陷。
+
+策略
+~~~~
+
+纯文本
+^^^^^^
+
+IPE的策略是纯文本格式的。相较于其他Linux安全模块（LSM），
+策略文件体积略大，但能解决其他平台上部分完整性策略方案存在
+的两个核心问题。
+
+第一个问题是代码维护和冗余的问题。为了编写策略，策略必须是
+以某种形式的字符串形式呈现（无论是 XML、JSON、YAML 等结构化
+格式，还是其他形式），以便策略编写者能够理解所写内容。在假设
+的二进制策略设计中，需要一个序列化器将策略将可读的形式转换为
+二进制形式，同时还需要一个反序列化器来将二进制形式转换为内核
+中的数据结构。
+
+最终，还需要另一个反序列化器将是必要的，用于将二进制形式转换
+为人类可读的形式，并尽可能保存所有信息，这是因为使用此访问控
+制系统的用户必须维护一个校验表和原始文件，才能理解哪些策略已
+经部署在该系统上，哪些没有。对于单个用户来说，这可能没问题，
+因为旧的策略可以在更新生效后很快被丢弃。但对于管理成千上万、
+甚至数十万台计算机的用户，且这些计算机有不同的操作系统和不同
+的操作需求，这很快就成了一个问题，因为数年前的过时策略可能仍然
+存在，从而导致需要快速恢复策略或投资大量基础设施来跟踪每个策略
+的内容。
+
+有了这三个独立的序列化器/反序列化器，维护成本非常昂贵。如果策略
+避免使用二进制格式，则只需要一个序列化器；将人类可读的形式转换
+为内核中的数据结构。从而节省了代码维护成本，并保持了可操作性。
+
+第二个关于二进制格式的问题是透明性，由于IPE根据系统资源的可信度
+来控制访问，因此其策略也必须可信，以便可以被更改。这是通过签名来
+完成的，这就需要签名过程。签名过程通常具有很高的安全标准，因为
+任何被签名的内容都可以被用来攻击完整性执行系统。签署时，签署者
+必须知道他们在签署什么，二进制策略可能会导致这一点的模糊化；签署
+者看到的只是一个不透明的二进制数据块。另一方面，对于纯文本策略中，
+签署者看到的则是实际提交的策略。
+
+启动策略
+~~~~~~~~
+
+如果配置得当，IPE能够在内核启动并进入用户模式时立即执行策略。
+这意味着需要在用户模式开始的那一刻就存储一定的策略。通常，这种
+存储可以通过一下三种方式之一来处理：
+
+  1. 策略文件存储在磁盘上，内核在进入可能需要做出执行决策的代码
+     路径之前，先加载该策略。
+  2. 策略文件由引导加载程序传递给内核，内核解析这些策略。
+  3. 将一个策略文件编译到内核中，内核在初始化过程中对其进行解析并
+     执行。
+
+第一种方式存在问题：内核从用户空间读取文件通常是不推荐的，并且在
+内核中极为罕见。
+
+第二种选项同样存在问题：Linux在其整个生态系统中支持多种引导加载程序，
+所有引导加载程序都必须支持这种新方法，或者需要有一个独立的来源，这
+可能会导致内核启动过程发生不必要的重大变化。
+
+第三种选项是最佳选择，但需要注意的是，编译进内核的策略会占用磁盘空间。
+重要的是要使这一策略足够通用，以便用户空间能够加载新的、更复杂的策略，
+同时也要足够严格，以防止过度授权并避免引发安全问题。
+
+initramfs提供了一种建立此启动路径的方法。内核启动时以最小化的策略启动，
+该策略仅信任initramfs。在initramfs内，当真实的根文件系统已挂载且尚未
+切换时，它会部署并激活一个信任新根文件系统的策略。这种方法防止了在任何
+步骤中出现过度授权，并保持内核策略的最小化。
+
+启动
+^^^^
+
+然而，并不是每个系统都以initramfs启动，因此编译进内核的启动策略需要具备
+一定的灵活性，以明确如何为启动的下一个阶段建立信任。为此，如果我们将编译
+进内核的策略设计为一个完整的IPE策略，这样系统构建者便能合理定义第一阶段启
+动的需求。
+
+可更新、无需重启的策略
+~~~~~~~~~~~~~~~~~~~~~~
+
+随着时间的推移，系统需求发生变化（例如，之前信任的应用程序中发现漏洞、秘钥
+轮换等）。更新内核以满足这些安全目标并非始终是一个合适的选择，因为内核更新并
+非完全无风险的，而搁置安全更新会使系统处于脆弱状态。这意味着IPE需要一个可以
+完全更新的策略（允许撤销现有的策略），并且这个更新来源必须是内核外部的（允许
+再不更新内核的情况下更新策略）。
+
+此外，由于内核在调用之间是无状态的，并且从内核空间读取磁盘上的策略文件不是一
+个好主意，因此策略更新必须能够在不重启的情况下完成。
+
+为了允许从外部来源进行更新，考虑到外部来源可能是恶意的，因此该策略需要具备可被
+识别为可信的机制。这一机制通过签名链实现：策略的签名需与内核中的某个信任源相
+关联。通常，这个信任源是 ``SYSTEM_TRUSTED_KEYRING`` ，这是一个在内核编译时就被
+初始化填充的密钥环，因为这符合上述编译进来策略的制作者与能够部署策略更新的实体
+相同的预期。
+
+防回滚 / 防重放
+~~~~~~~~~~~~~~~
+
+随着时间的推移，系统可能会发现漏洞，曾经受信任的资源可能不再可信，IPE的
+策略也不例外。可能会出现的情况是，策略制作者误部署了一个不安全的策略，
+随后再用一个安全的策略进行修正。
+
+假设一旦不安全的策略被部署，攻击者获取了这个不安全的策略，IPE需要有一种
+方式来防止从安全的策略更新回滚到不安全的策略。
+
+最初，IPE的策略可以包含一个policy_version字段，声明系统上所有可激活策略
+所需的最低版本号。这将在系统运行期间防止回滚。
+
+.. WARNING::
+
+   然而，由于内核每次启动都是无状态的，因此该策略版本将在下次
+   启动时被重置为0.0.0。系统构建者需要意识到这一点，并确保在启
+   动后尽快部署新的安全策略，以确保攻击者部署不安全的策略的几
+   率最小化。
+
+隐式操作:
+~~~~~~~~~
+
+隐式操作的问题只有在考虑系统中多个操作具有不同级别时才会显现出来。
+例如，考虑一个系统，该系统对可执行代码和系统中对其功能至关重要的
+特定数据提供强大的完整性保障。在这个系统中，可能存在三种类型的
+策略：
+
+  1. 一种策略，在这种策略中，如果操作未能匹配到任何规则，则该操
+     作将被拒绝。
+  2. 一种策略，在这种策略中，如果操作未能匹配到任何规则，则该操
+     作将被允许。
+  3. 一种策略，在这种策略中，如果操作未能匹配到任何规则，则执行
+     操作由策略作者指定。
+
+第一种类型的策略示例如下::
+
+  op=EXECUTE integrity_verified=YES action=ALLOW
+
+在示例系统中，这对于可执行文件来说效果很好，因为所有可执行文件
+都应该拥有完整性保障。但问题出现在第二个要求上，即关于特定数据
+文件的要求。这将导致如下策略（假设策略按行依次执行）::
+
+  op=EXECUTE integrity_verified=YES action=ALLOW
+
+  op=READ integrity_verified=NO label=critical_t action=DENY
+  op=READ action=ALLOW
+
+若阅读过文档，了解策略按顺序执行且默认动作是拒绝，那么这个策略的
+逻辑还算清晰；但最后一行规则实际上将读取操作的默认动作改成了允许。
+这种设计是必要的，因为在实际系统中，存在一些无需验证的读取操作（例
+如向日志文件追加内容时的读取操作）。
+
+第二种策略类型（未匹配任何规则时默认允许）在管控特定数据文件时逻辑
+更清晰，其策略可简化为::
+
+  op=READ integrity_verified=NO label=critical_t action=DENY
+
+但与第一种策略类似，这种默认允许的策略在管控执行操作时会存在缺陷，
+因此仍需显式覆盖默认动作::
+
+  op=EXECUTE integrity_verified=YES action=ALLOW
+  op=EXECUTE action=DENY
+
+  op=READ integrity_verified=NO label=critical_t action=DENY
+
+这就引出了第三种策略类型（自定义默认动作）。该类型无需让用户绞尽脑汁
+通过空规则覆盖默认动作，而是强制用户根据自身场景思考合适的默认动作是
+什么，并显式声明::
+
+  DEFAULT op=EXECUTE action=DENY
+  op=EXECUTE integrity_verified=YES action=ALLOW
+
+  DEFAULT op=READ action=ALLOW
+  op=READ integrity_verified=NO label=critical_t action=DENY
+
+策略调试:
+~~~~~~~~~
+
+在开发策略时，知道策略违反了哪一行有助于减少调试成本；可以
+将调查的范围缩小到导致该行为的确切行。有些完整性策略系统并
+不提供这一信息，而是提供评估过程中使用的信息。这随后需要将
+这些信息和策略进行关联，以分析哪里了问题。
+
+相反，IPE只会输出匹配到的规则。这将调查范围限制到确切到策略行
+（在特定规则的情况下）或部分（在DEFAULT规则的情况下）。当在
+评估策略时观察到策略失败时，这可以减少迭代和调查的时间。
+
+IPE的策略引擎还被设计成让人类容易理解如何调查策略失败。每一
+行都会按编写顺序进行评估，因此算法非常简单，便于人类重现步
+骤并找出可能导致失败的原因。而在调查其他的系统中，加载策略
+时会进行优化（例如对规则排序）。在这些系统中，调试需要多个
+步骤，而且没有先阅读代码的情况下，终端用户可能无法完全理解
+该算法的原理。
+
+简化策略:
+~~~~~~~~~
+
+最后，IPE的策略是为系统管理员设计的，而不是内核开发人员。
+IPE不涉及单独的LSM钩子（或系统调用），而是涵盖操作。这
+意味着，系统管理员不需要知道像 ``mmap`` 、 ``mprotect`` 、
+``execve`` 和 ``uselib`` 这些系统调用必须有规则进行保护，
+而只需要知道他们想要限制代码执行。这减少了由于缺乏对底层
+系统的了解而可能导致的绕过情况；而IPE的维护者作为内核开发
+人员，可以做出正确的选择，确定某些操作是否与这些操作匹配，
+以及在什么条件下匹配。
+
+实现说明
+--------
+
+匿名内存
+~~~~~~~~
+
+在IPE中，匿名内存的处理方式与其他任何类型的访问没有区别。当匿
+名内存使用 ``+X`` 映射时，它仍然会进入 ``file_mmp`` 或
+``file_mprotect`` 钩子，但此时会带有一个 ``NULL`` 文件对象
+这会像其他文件一样提交进行评估。然而，所有当前的信任属性都会
+评估为假，因为它们都是基于文件的，而此次操作并不与任何文件相关联。
+
+.. WARNING::
+
+  这也适用于 ``kernel_load_data`` 钩子，当内核从一个没有文件
+  支持的用户空间缓冲区加载数据时。在这种情况下，所有当前的信任
+  属性也将评估为false。
+
+Securityfs接口
+~~~~~~~~~~~~~~
+
+每个策略的对应的securityfs树是有些独特的。例如，对于一个标准的
+securityfs策略树::
+
+  MyPolicy
+    |- active
+    |- delete
+    |- name
+    |- pkcs7
+    |- policy
+    |- update
+    |- version
+
+策略存储在MyPolicy对应节点的 ``->i_private`` 数据中。
+
+测试
+----
+
+IPE为策略解析器提供了KUnit测试。推荐kunitconfig::
+
+  CONFIG_KUNIT=y
+  CONFIG_SECURITY=y
+  CONFIG_SECURITYFS=y
+  CONFIG_PKCS7_MESSAGE_PARSER=y
+  CONFIG_SYSTEM_DATA_VERIFICATION=y
+  CONFIG_FS_VERITY=y
+  CONFIG_FS_VERITY_BUILTIN_SIGNATURES=y
+  CONFIG_BLOCK=y
+  CONFIG_MD=y
+  CONFIG_BLK_DEV_DM=y
+  CONFIG_DM_VERITY=y
+  CONFIG_DM_VERITY_VERIFY_ROOTHASH_SIG=y
+  CONFIG_NET=y
+  CONFIG_AUDIT=y
+  CONFIG_AUDITSYSCALL=y
+  CONFIG_BLK_DEV_INITRD=y
+
+  CONFIG_SECURITY_IPE=y
+  CONFIG_IPE_PROP_DM_VERITY=y
+  CONFIG_IPE_PROP_DM_VERITY_SIGNATURE=y
+  CONFIG_IPE_PROP_FS_VERITY=y
+  CONFIG_IPE_PROP_FS_VERITY_BUILTIN_SIG=y
+  CONFIG_SECURITY_IPE_KUNIT_TEST=y
+
+此外，IPE 具有一个基于 Python 的集成
+`测试套件 <https://github.com/microsoft/ipe/tree/test-suite>`_
+可以测试用户界面和强制执行功能。
-- 
2.49.0


