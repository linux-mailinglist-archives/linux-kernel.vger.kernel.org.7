Return-Path: <linux-kernel+bounces-887470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB03DC384FE
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 00:15:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2000D18C42E4
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 23:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B21F2C08C8;
	Wed,  5 Nov 2025 23:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dIX3GK0J"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E52A246BD5
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 23:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762384520; cv=none; b=c/BNYSW2r/PnK3pf8wu7VGvvhyHIRx9xPD3F3z7JE73Ul7FCOib3A+E/JJOSWLXsbJuAYCTTDo2tbLI6WuFsj0euVMfdSBbJn8WqxmM8FKqHHUSNCBKhpKFf4BAi9/KFy8bGcbJn6EexGeKsyU9NASfnJXDqhlyyWZcZ2tfg2RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762384520; c=relaxed/simple;
	bh=uJ6eK1K7iuFQJd4+QggbM8riyIDRbNBTKvudser/8xI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YC1Y72Kk0IHBPnmYeVDWiKnHnKXdPvRzdFkQuDnsvugx7dl3OSKsiYVbxDBlRrNl/kRCn7zD5xmzfM5tOxZAdGbnq2yXpU8Wbny8EQYsn50Ok3BflAFmNwW7C1z3kNeFX4lAtOHpwbjD9Oi1ZUbgIt5+U5Mm4LhrK4zqVUzCplU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dIX3GK0J; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762384518; x=1793920518;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=uJ6eK1K7iuFQJd4+QggbM8riyIDRbNBTKvudser/8xI=;
  b=dIX3GK0J5aPRw1WXOC4q649MW0i2vFvgYNbnH1P9ioUUWh5K5CpTNMK2
   1My+fz5989U7j+TQ/YdDozs8g9NMX3WSqfL3Jl5jrRAEGaYJ0E1v13ue+
   eWByCC4e6fw757YDZ/rbdZlppheIhXPfoFoD9asfDqAKXz98DB4WER66x
   MSGYHcn7MneZwrAWkhGjDIN8Vak5Es1uQo2DfXCf+zugEQL/+lRzMCVi1
   cQxqBvk8rJEspxYJ1GzI4/R8aXbDn4F6j0KU5YmSf0Ufg/jdSPiNs3MSY
   t5G347AW17ZUt/HOXlqi7g/ucJV2smu7die0bCdbnd5823dzY+tKbQlEW
   Q==;
X-CSE-ConnectionGUID: U2ytbNZoRyyUBcDWnurAYQ==
X-CSE-MsgGUID: 3/gtNri3QbizGE+T/EVwpw==
X-IronPort-AV: E=McAfee;i="6800,10657,11604"; a="68372380"
X-IronPort-AV: E=Sophos;i="6.19,283,1754982000"; 
   d="scan'208";a="68372380"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2025 15:15:17 -0800
X-CSE-ConnectionGUID: INN/+MzJSK6ZYPIVJGnSSw==
X-CSE-MsgGUID: hTcbfvUFSlev1Ms5P2Uxkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,283,1754982000"; 
   d="scan'208";a="187434381"
Received: from davehans-spike.ostc.intel.com (HELO ray2.sr71.net) ([10.165.164.11])
  by fmviesa006.fm.intel.com with ESMTP; 05 Nov 2025 15:15:17 -0800
From: Dave Hansen <dave.hansen@linux.intel.com>
To: linux-kernel@vger.kernel.org
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Theodore Ts'o <tytso@mit.edu>,
	Sasha Levin <sashal@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Kees Cook <kees@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Subject: [PATCH] [v2] Documentation: Provide guidelines for tool-generated content
Date: Wed,  5 Nov 2025 15:15:14 -0800
Message-Id: <20251105231514.3167738-1-dave.hansen@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the last few years, the capabilities of coding tools have exploded.
As those capabilities have expanded, contributors and maintainers have
more and more questions about how and when to apply those
capabilities.

The shiny new AI tools (chatbots, coding assistants and more) are
impressive.  Add new Documentation to guide contributors on how to
best use kernel development tools, new and old.

Note, though, there are fundamentally no new or unique rules in this
new document. It clarifies expectations that the kernel community has
had for many years. For example, researchers are already asked to
disclose the tools they use to find issues in
Documentation/process/researcher-guidelines.rst. This new document
just reiterates existing best practices for development tooling.

In short: Please show your work and make sure your contribution is
easy to review.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Theodore Ts'o <tytso@mit.edu>
Cc: Sasha Levin <sashal@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Kees Cook <kees@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Miguel Ojeda <ojeda@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>

--

This document was a collaborative effort from all the members of
the TAB. I just reformatted it into .rst and wrote the changelog.

Changes from v1:
 * Rename to generated-content.rst and add to documentation index.
   (Jon)
 * Rework subject to align with the new filename
 * Replace commercial names with generic ones. (Jon)
 * Be consistent about punctuation at the end of bullets for whole
   sentences. (Miguel)
 * Formatting sprucing up and minor typos (Miguel)
---
 Documentation/process/generated-content.rst | 94 +++++++++++++++++++++
 Documentation/process/index.rst             |  1 +
 2 files changed, 95 insertions(+)
 create mode 100644 Documentation/process/generated-content.rst

diff --git a/Documentation/process/generated-content.rst b/Documentation/process/generated-content.rst
new file mode 100644
index 0000000000000..5e8ff44190932
--- /dev/null
+++ b/Documentation/process/generated-content.rst
@@ -0,0 +1,94 @@
+============================================
+Kernel Guidelines for Tool Generated Content
+============================================
+
+Purpose
+=======
+
+Kernel contributors have been using tooling to generate contributions
+for a long time. These tools are constantly becoming more capable and
+undoubtedly improve developer productivity. At the same time, reviewer
+and maintainer bandwidth is a very scarce resource. Understanding
+which portions of a contribution come from humans versus tools is
+critical to maintain those resources and keep kernel development
+healthy.
+
+The goal here is to clarify community expectations around tools. This
+lets everyone become more productive while also maintaining high
+degrees of trust between submitters and reviewers.
+
+Out of Scope
+============
+
+These guidelines do not apply to tools that make trivial tweaks to
+preexisting content. Nor do they pertain to AI tooling that helps with
+menial tasks. Some examples:
+
+ - Spelling and grammar fix ups, like rephrasing to imperative voice
+ - Typing aids like identifier completion, common boilerplate or
+   trivial pattern completion
+ - Purely mechanical transformations like variable renaming
+ - Reformatting, like running Lindent, ``clang-format`` or
+   ``rust-fmt``
+
+Even if your tool use is out of scope you should still always consider
+if it would help reviewing your contribution if the reviewer knows
+about the tool that you used.
+
+In Scope
+========
+
+These guidelines apply when a meaningful amount of content in a kernel
+contribution was not written by a person in the Signed-off-by chain,
+but was instead created by a tool.
+
+Detection of a problem is also a part of the development process; if a
+tool was used to find a problem addressed by a change, that should be
+noted in the changelog. This not only gives credit where it is due, it
+also helps fellow developers find out about these tools.
+
+Some examples:
+ - Any tool-suggested fix such as ``checkpatch.pl --fix``
+ - Coccinelle scripts
+ - A chatbot generated a new function in your patch to sort list entries.
+ - A .c file in the patch was originally generated by a LLM but cleaned
+   up by hand.
+ - The changelog was generated by handing the patch to a generative AI
+   tool and asking it to write the changelog.
+ - The changelog was translated from another language.
+
+If in doubt, choose transparency and assume these guidelines apply to
+your contribution.
+
+Guidelines
+==========
+
+First, read the Developer's Certificate of Origin:
+Documentation/process/submitting-patches.rst . Its rules are simple
+and have been in place for a long time. They have covered many
+tool-generated contributions.
+
+Second, when making a contribution, be transparent about the origin of
+content in cover letters and changelogs. You can be more transparent
+by adding information like this:
+
+ - What tools were used?
+ - The input to the tools you used, like the coccinelle source script.
+ - If code was largely generated from a single or short set of
+   prompts, include those prompts in the commit log. For longer
+   sessions, include a summary of the prompts and the nature of
+   resulting assistance.
+ - Which portions of the content were affected by that tool?
+
+As with all contributions, individual maintainers have discretion to
+choose how they handle the contribution. For example, they might:
+
+ - Treat it just like any other contribution
+ - Reject it outright
+ - Review the contribution with extra scrutiny
+ - Suggest a better prompt instead of suggesting specific code changes
+ - Ask for some other special steps, like asking the contributor to
+   elaborate on how the tool or model was trained
+ - Ask the submitter to explain in more detail about the contribution
+   so that the maintainer can feel comfortable that the submitter fully
+   understands how the code works.
diff --git a/Documentation/process/index.rst b/Documentation/process/index.rst
index aa12f26601949..e1a8a31389f53 100644
--- a/Documentation/process/index.rst
+++ b/Documentation/process/index.rst
@@ -68,6 +68,7 @@ beyond).
    stable-kernel-rules
    management-style
    researcher-guidelines
+   generated-content
 
 Dealing with bugs
 -----------------
-- 
2.34.1


