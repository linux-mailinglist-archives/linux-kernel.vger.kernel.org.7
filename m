Return-Path: <linux-kernel+bounces-851560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AF381BD6C3E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 01:44:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9A8534E3740
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 23:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84C872EA476;
	Mon, 13 Oct 2025 23:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hxVw4jmG"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC19C2C3761
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 23:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760399087; cv=none; b=H/0yfyIh6D+uhv2m9pRITt+Q4ZHLPX4PTxXtk7ApyGjqIOd3mlcKCDLDmAcCAq4lcN0wdGyNz4Yjb/nUvAotba89+1fXBv39r4EVMCppgloVp0xBHaOmITfCesZFY75i/aJCNhOY99C8q+NU1xWjQdiJWW1+Wemf0AugtoVfEOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760399087; c=relaxed/simple;
	bh=vxmwWQ0DoVc1VJfpKsoyjTQLj22NklEz073s7lF3ARU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VutrxFMkGKEK1n5AgEsiAvbG6qXSSC6VWa8rIFGat9mE2ZI+x3KMIHuqi8msRRhGO9EyMzQiOeiebyVA2nh//FjX8WHpQvFNo2EHgqwtGSuV9VxBFydX+cvdNr5KvrNsNyW5XfZiQ2Ct9d4BuL1fuBZ/46VY4P9MdOQg0n5Jp+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hxVw4jmG; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b5ca0345de8so59737a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 16:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760399085; x=1761003885; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=25uGdd6TkjAY7Zck7/QAhkxlHv/+kj+Cc6pIb4oafgM=;
        b=hxVw4jmGGb/0GDkQp2p9TB+ETw1Oh7n4L2VEs0mi45Xl4Z2KWYFV2xouz2bXwwkQA9
         y3Q1GESz2DIvDGxcqgfesjqO5Adr3AnLEkD4qdgMXjYr0EAIE1OkutvpV46/OzKhL74D
         LBqSZHGqm36MClZzL/m+7e4kbWHuZpQH58BfdM+t0EmCVTujhoNm5xnIlRo7sWOD1nkM
         yeMAR5f6Y/BnRwUegYnxF0Ol5xIUUUUMHJ+n6nGV8wza/ilzIfUpF+52cNetP1B8FNDL
         2qMXDNoAbwh04EwQOoEIhq+7/wd8Ywk+iDwjEf9BTBp9RRfRgBAwYohjzTH9yexaFerN
         EIJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760399085; x=1761003885;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=25uGdd6TkjAY7Zck7/QAhkxlHv/+kj+Cc6pIb4oafgM=;
        b=eySNDxk/ejre+qlQUOO2fRrONfWbOjOUlU/J65GPI5JqmZS7HUkXIMXmxOEPj34kP6
         p4r2WIKsRercvlNQzKNJqQLHZMZ/swKo/a4ATeHoCCN4RdDv+las1wMGEGjopsLHfSfE
         WdiSFSv+o1GSVazlJle9ijryiZUcIMuCd5uG0EwT3BSakgDaodttL8mUxChYq/YPX6Rs
         u1FCfGpuwUmaRAbwkHirnW5srqThGq+GR0AOjVxmoo/H35xKKdIvoiB6Egv5xDmq8GyV
         HPpLGvLhafoVTiOkYTk3/ZboyAm4Gn8zO9VMsct6g0zEG7naN5GzHJrJREflz8JEW3Hj
         RaeQ==
X-Forwarded-Encrypted: i=1; AJvYcCVGVV3+FVuFJWpnV2SoGGvg5vMrAFdvYrpk/EgMPz9EvWDDaexB5lWxEZp32A9bWkSBqhQLD9l78sa1kKo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDTDn1P4oQOHPAnG8jHB2o79lLifb3US9A/PHJpBtvft6vmnf7
	Zampdzq+Jxg8j95RGZS87lZjBrdDXeNKWpkGGswrvvn39ZY+f0CVH74J
X-Gm-Gg: ASbGncsQ3SV/MEl8/V2Q+PJYoVjggmk95H0YfvQBZG1osmtXODUtccvmPHxfEIJdmSh
	uyo0WDgVoB2nt9NnDtisniqGHoGSrPDH+s/eZ0xjTHSVT8WMYr18fBWK9/BPCC71ogV7hEVuNsc
	lZN2A7/Gf5IBsoapszAXjAeQEVDCbZmPmbRfWu41nrjPGlcUhdulMWf0tCcjOIZ+MxCNPC2ADbK
	8oivAgvjSXocZ2PqY1FdqwWePs9uBhCV6Nvozm3nv0FkZA81TShOwgOcYoGxcA5H/yQu3J/nT51
	YivggtPp7StANUmhHrArWozew8Sv8OP4DaFDP4iYXJ16IQJQ5s5QAY2nS9G+iWCfroJZPFIw2IM
	kKFRGMvLy0t/rv/C6y1Dpq2msO5JCOBTnySmMUQ==
X-Google-Smtp-Source: AGHT+IHH2YaH2IA8SuLALE8JFm3JwRZhtF8KoJEy6Fp7EtPm+VJaZetsmBqbeL7ypSSJIOxasJruEg==
X-Received: by 2002:a05:6a00:2e04:b0:781:8ddb:f6c0 with SMTP id d2e1a72fcca58-793876369d2mr14310553b3a.5.1760399084598;
        Mon, 13 Oct 2025 16:44:44 -0700 (PDT)
Received: from localhost ([104.249.174.141])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992b0604cfsm13084588b3a.9.2025.10.13.16.44.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 16:44:44 -0700 (PDT)
From: Ben Guo <benx.guo@gmail.com>
To: Alex Shi <alexs@kernel.org>,
	Yanteng Si <si.yanteng@linux.dev>,
	Dongliang Mu <dzm91@hust.edu.cn>,
	Jonathan Corbet <corbet@lwn.net>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>
Cc: hust-os-kernel-patches@googlegroups.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH v3] docs/zh_CN: Add translation of rust/testing.rst
Date: Mon, 13 Oct 2025 23:44:01 +0000
Message-ID: <20251013234416.6172-1-benx.guo@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Complete the translation of rust/testing.rst and add the testing TOC entry
to rust/index.rst.

Add the translation based on commit a3b2347343e0
("Documentation: rust: testing: add docs on the new KUnit `#[test]` tests").

Signed-off-by: Ben Guo <benx.guo@gmail.com>
---
v2->v3: Resend without In-Reply-To header (no code changes).
v1->v2: Rebased onto docs-next (no code changes).
 .../translations/zh_CN/rust/index.rst         |   1 +
 .../translations/zh_CN/rust/testing.rst       | 215 ++++++++++++++++++
 2 files changed, 216 insertions(+)
 create mode 100644 Documentation/translations/zh_CN/rust/testing.rst

diff --git a/Documentation/translations/zh_CN/rust/index.rst b/Documentation/translations/zh_CN/rust/index.rst
index 10413b0c17c0..5347d4729588 100644
--- a/Documentation/translations/zh_CN/rust/index.rst
+++ b/Documentation/translations/zh_CN/rust/index.rst
@@ -47,6 +47,7 @@ Rust 支持在 v6.1 版本中合并到主线，以帮助确定 Rust 作为一种
     general-information
     coding-guidelines
     arch-support
+    testing
 
 你还可以在 :doc:`../../../process/kernel-docs` 中找到 Rust 的学习材料。
 
diff --git a/Documentation/translations/zh_CN/rust/testing.rst b/Documentation/translations/zh_CN/rust/testing.rst
new file mode 100644
index 000000000000..ca81f1cef6eb
--- /dev/null
+++ b/Documentation/translations/zh_CN/rust/testing.rst
@@ -0,0 +1,215 @@
+.. SPDX-License-Identifier: GPL-2.0
+.. include:: ../disclaimer-zh_CN.rst
+
+:Original: Documentation/rust/testing.rst
+
+:翻译:
+
+ 郭杰 Ben Guo <benx.guo@gmail.com>
+
+测试
+====
+
+本文介绍了如何在内核中测试 Rust 代码。
+
+有三种测试类型：
+
+- KUnit 测试
+- ``#[test]`` 测试
+- Kselftests
+
+KUnit 测试
+----------
+
+这些测试来自 Rust 文档中的示例。它们会被转换为 KUnit 测试。
+
+使用
+****
+
+这些测试可以通过 KUnit 运行。例如，在命令行中使用 ``kunit_tool`` （ ``kunit.py`` ）::
+
+	./tools/testing/kunit/kunit.py run --make_options LLVM=1 --arch x86_64 --kconfig_add CONFIG_RUST=y
+
+或者，KUnit 也可以在内核启动时以内置方式运行。获取更多 KUnit 信息，请参阅
+Documentation/dev-tools/kunit/index.rst。
+关于内核内置与命令行测试的详细信息，请参阅 Documentation/dev-tools/kunit/architecture.rst。
+
+要使用这些 KUnit 文档测试，需要在内核配置中启用以下选项::
+
+	CONFIG_KUNIT
+	   Kernel hacking -> Kernel Testing and Coverage -> KUnit - Enable support for unit tests
+	CONFIG_RUST_KERNEL_DOCTESTS
+	   Kernel hacking -> Rust hacking -> Doctests for the `kernel` crate
+
+KUnit 测试即文档测试
+********************
+
+文档测试（ *doctests* ）一般用于展示函数、结构体或模块等的使用方法。
+
+它们非常方便，因为它们就写在文档旁边。例如：
+
+.. code-block:: rust
+
+	/// 求和两个数字。
+	///
+	/// ```
+	/// assert_eq!(mymod::f(10, 20), 30);
+	/// ```
+	pub fn f(a: i32, b: i32) -> i32 {
+	    a + b
+	}
+
+在用户空间中，这些测试由 ``rustdoc`` 负责收集并运行。单独使用这个工具已经很有价值，
+因为它可以验证示例能否成功编译（确保和代码保持同步），
+同时还可以运行那些不依赖内核 API 的示例。
+
+然而，在内核中，这些测试会转换成 KUnit 测试套件。
+这意味着文档测试会被编译成 Rust 内核对象，从而可以在构建的内核环境中运行。
+
+通过与 KUnit 集成，Rust 的文档测试可以复用内核现有的测试设施。
+例如，内核日志会显示::
+
+	KTAP version 1
+	1..1
+	    KTAP version 1
+	    # Subtest: rust_doctests_kernel
+	    1..59
+	    # rust_doctest_kernel_build_assert_rs_0.location: rust/kernel/build_assert.rs:13
+	    ok 1 rust_doctest_kernel_build_assert_rs_0
+	    # rust_doctest_kernel_build_assert_rs_1.location: rust/kernel/build_assert.rs:56
+	    ok 2 rust_doctest_kernel_build_assert_rs_1
+	    # rust_doctest_kernel_init_rs_0.location: rust/kernel/init.rs:122
+	    ok 3 rust_doctest_kernel_init_rs_0
+	    ...
+	    # rust_doctest_kernel_types_rs_2.location: rust/kernel/types.rs:150
+	    ok 59 rust_doctest_kernel_types_rs_2
+	# rust_doctests_kernel: pass:59 fail:0 skip:0 total:59
+	# Totals: pass:59 fail:0 skip:0 total:59
+	ok 1 rust_doctests_kernel
+
+文档测试中，也可以正常使用 `? <https://doc.rust-lang.org/reference/expressions/operator-expr.html#the-question-mark-operator>`_ 运算符，例如：
+
+.. code-block:: rust
+
+	/// ```
+	/// # use kernel::{spawn_work_item, workqueue};
+	/// spawn_work_item!(workqueue::system(), || pr_info!("x\n"))?;
+	/// # Ok::<(), Error>(())
+	/// ```
+
+这些测试和普通代码一样，也可以在 ``CLIPPY=1`` 条件下通过 Clippy 进行编译，
+因此可以从额外的 lint 检查中获益。
+
+为了便于开发者定位文档测试出错的具体行号，日志会输出一条 KTAP 诊断信息。
+其中标明了原始测试的文件和行号（不是 ``rustdoc`` 生成的临时 Rust 文件位置）::
+
+	# rust_doctest_kernel_types_rs_2.location: rust/kernel/types.rs:150
+
+Rust 测试中常用的断言宏是来自 Rust 标准库（ ``core`` ）中的 ``assert!`` 和 ``assert_eq!`` 宏。
+内核提供了一个定制版本，这些宏的调用会被转发到 KUnit。
+和 KUnit 测试不同的是，这些宏不需要传递上下文参数（ ``struct kunit *`` ）。
+这使得它们更易于使用，同时文档的读者无需关心底层用的是什么测试框架。
+此外，这种方式未来也许可以让我们更容易测试第三方代码。
+
+当前有一个限制：KUnit 不支持在其他任务中执行断言。
+因此，如果断言真的失败了，我们只是简单地把错误打印到内核日志里。
+另外，文档测试不适用于非公开的函数。
+
+作为文档中的测试示例，应当像 “实际代码” 一样编写。
+例如：不要使用 ``unwrap()`` 或 ``expect()``，请使用 `? <https://doc.rust-lang.org/reference/expressions/operator-expr.html#the-question-mark-operator>`_ 运算符。
+更多背景信息，请参阅：
+
+	https://rust.docs.kernel.org/kernel/error/type.Result.html#error-codes-in-c-and-rust
+
+``#[test]`` 测试
+----------------
+
+此外，还有 ``#[test]`` 测试。与文档测试类似，这些测试与用户空间中的测试方式也非常相近，并且同样会映射到 KUnit。
+
+这些测试通过 ``kunit_tests`` 过程宏引入，该宏将测试套件的名称作为参数。
+
+例如，假设想要测试前面文档测试示例中的函数 ``f``，我们可以在定义该函数的同一文件中编写：
+
+.. code-block:: rust
+
+	#[kunit_tests(rust_kernel_mymod)]
+	mod tests {
+	    use super::*;
+
+	    #[test]
+	    fn test_f() {
+	        assert_eq!(f(10, 20), 30);
+	    }
+	}
+
+如果我们执行这段代码，内核日志会显示::
+
+	    KTAP version 1
+	    # Subtest: rust_kernel_mymod
+	    # speed: normal
+	    1..1
+	    # test_f.speed: normal
+	    ok 1 test_f
+	ok 1 rust_kernel_mymod
+
+与文档测试类似， ``assert!`` 和 ``assert_eq!`` 宏被映射回 KUnit 并且不会发生 panic。
+同样，支持 `? <https://doc.rust-lang.org/reference/expressions/operator-expr.html#the-question-mark-operator>`_ 运算符，
+测试函数可以什么都不返回（单元类型 ``()``）或 ``Result`` （任何 ``Result<T, E>``）。例如：
+
+.. code-block:: rust
+
+	#[kunit_tests(rust_kernel_mymod)]
+	mod tests {
+	    use super::*;
+
+	    #[test]
+	    fn test_g() -> Result {
+	        let x = g()?;
+	        assert_eq!(x, 30);
+	        Ok(())
+	    }
+	}
+
+如果我们运行测试并且调用 ``g`` 失败，那么内核日志会显示::
+
+	    KTAP version 1
+	    # Subtest: rust_kernel_mymod
+	    # speed: normal
+	    1..1
+	    # test_g: ASSERTION FAILED at rust/kernel/lib.rs:335
+	    Expected is_test_result_ok(test_g()) to be true, but is false
+	    # test_g.speed: normal
+	    not ok 1 test_g
+	not ok 1 rust_kernel_mymod
+
+如果 ``#[test]`` 测试可以对用户起到示例作用，那就应该改用文档测试。
+即使是 API 的边界情况，例如错误或边界问题，放在示例中展示也同样有价值。
+
+``rusttest`` 宿主机测试
+-----------------------
+
+这类测试运行在用户空间，可以通过 ``rusttest`` 目标在构建内核的宿主机中编译并运行::
+
+	make LLVM=1 rusttest
+
+当前操作需要内核 ``.config``。
+
+目前，它们主要用于测试 ``macros`` crate 的示例。
+
+Kselftests
+----------
+
+Kselftests 可以在 ``tools/testing/selftests/rust`` 文件夹中找到。
+
+测试所需的内核配置选项列在 ``tools/testing/selftests/rust/config`` 文件中，
+可以借助 ``merge_config.sh`` 脚本合并到现有配置中::
+
+	./scripts/kconfig/merge_config.sh .config tools/testing/selftests/rust/config
+
+Kselftests 会在内核源码树中构建，以便在运行相同版本内核的系统上执行测试。
+
+一旦安装并启动了与源码树匹配的内核，测试即可通过以下命令编译并执行::
+
+	make TARGETS="rust" kselftest
+
+请参阅 Documentation/dev-tools/kselftest.rst 文档以获取更多信息。

base-commit: 344657696e9aa7bf89e48e1848fe0ce551bd1f4a
-- 
2.43.0


