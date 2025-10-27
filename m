Return-Path: <linux-kernel+bounces-872503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A4DDC11594
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 21:15:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E40765617A8
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 20:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BD9331D749;
	Mon, 27 Oct 2025 20:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oBZW4aEo"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B38D31D75C
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 20:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761595983; cv=none; b=aA8fvdvdqg0FS6vfuMAcsw4OKXNJCmK/V4/zguqyExgn0L6h2w/Q6TNRXBuu99fTsp48MP5wEGutjYEzyyUXLuItAIU2i9MVmxm3T2jd/uE1gGSJGYYhuPkspm2zpy2mqYgkNOqJ8p48FM95mtUzNwFPAh4XC5N94w3xCbNhgIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761595983; c=relaxed/simple;
	bh=4UBw7aiqjq1jkpFNuS2ywr6GozO/Ts3eh3c3uvkiJfg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=HbQpNJY+gDE+WYGIw7CTP57ex9DEO8P9gLjingXAi9+8mavWLBwv14vxW3W9oBIKXBcMpQxUHjhc8UK7ADrJpgAkC/rzLr5xwK3mNDgpyI2j7uqL91ZaIV7Eds8WN0dQfTJ04WsL6Qp4x+MDYFAWSKBKFovZzzHBVEB1aIfTLwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oBZW4aEo; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761595981; x=1793131981;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=4UBw7aiqjq1jkpFNuS2ywr6GozO/Ts3eh3c3uvkiJfg=;
  b=oBZW4aEookTw4s+5PBrNkhQjEWtBjxo0EvSNqL5oVrz/r+JTfVHExMLL
   1dxhXTDa0bM1/H8VIgoTvuiW7mBF20ERNYBUCn//Mp78PaQR00E9Onxdl
   KcknXBDmHp9nLKJueCq3wdpGPNtqIDMEroN0j+xwfhHejOwgoH4d1wjcm
   ogKHUkep157COjasTNRWV1tecdYiNAVaF0YK6fMiZD+cxuEU99h3cg3lB
   QCL0dJJi0KYPKWC9X7jb6tRgq7/z3S3o9z1TrKcgVdr0WxOwVekXohZVB
   0x/DXq4w7Q00t6bR1PoPhv2stctgFt1N06gD8LPgGJRHHGBGs/tFjwz7A
   Q==;
X-CSE-ConnectionGUID: Mpx9FR6XSfS/oOXiLGn3+w==
X-CSE-MsgGUID: CudCXf+QR4610Xzbvh3YlQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="63388503"
X-IronPort-AV: E=Sophos;i="6.19,259,1754982000"; 
   d="scan'208";a="63388503"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2025 13:13:00 -0700
X-CSE-ConnectionGUID: RxpenxMNT0CfOtyqbqm6og==
X-CSE-MsgGUID: u07pw1GgTAukRS+mjAYn1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,259,1754982000"; 
   d="scan'208";a="185042087"
Received: from davehans-spike.ostc.intel.com (HELO ray2.jf.intel.com) ([10.165.164.11])
  by orviesa007.jf.intel.com with ESMTP; 27 Oct 2025 13:13:01 -0700
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
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Shuah Khan <shuah@kernel.org>
Subject: [PATCH] Documentation: Provide guidelines for kernel development tools
Date: Mon, 27 Oct 2025 13:12:04 -0700
Message-Id: <20251027201204.352890-1-dave.hansen@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
just reiterate existing best practices for development tooling.

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
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Shuah Khan <shuah@kernel.org>

--

This document was a collaborative effort from all the members of
the TAB. I just reformatted it into .rst and wrote the changelog.
---
 Documentation/process/development-tools.rst | 92 +++++++++++++++++++++
 1 file changed, 92 insertions(+)
 create mode 100644 Documentation/process/development-tools.rst

diff --git a/Documentation/process/development-tools.rst b/Documentation/process/development-tools.rst
new file mode 100644
index 0000000000000..ab6596cc595ac
--- /dev/null
+++ b/Documentation/process/development-tools.rst
@@ -0,0 +1,92 @@
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
+ - Reformatting, like running scripts/Lindent.
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
+Some examples:
+ - “checkpatch.pl --fix” output, or any tool suggested fix.
+ - coccinelle scripts
+ - ChatGPT generated a new function in your patch to sort list entries.
+ - A .c file in the patch was originally generated by Gemini but cleaned
+   up by hand.
+ - The changelog was generated by handing the patch to a generative AI
+   tool and asking it to write the changelog.
+ - The changelog was translated from another language.
+ - Detection of a problem is also a part of the development process; if
+   a tool was used to find a problem addressed by a change, that should
+   be noted in the changelog. This not only gives credit where it is
+   due, it also helps fellow developers find out about these tools.
+
+If in doubt, choose transparency and assume these guidelines apply to
+your contribution.
+
+Guidelines
+==========
+
+First, read the Developer's Certificate of Origin:
+``Documentation/process/submitting-patches.rst`` Its rules are simple
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
-- 
2.34.1


