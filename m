Return-Path: <linux-kernel+bounces-870352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F9F5C0A82C
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 13:48:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2A1404EA35F
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 12:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 372B62E9EA6;
	Sun, 26 Oct 2025 12:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="1KFZMedX"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A8E32DC76C;
	Sun, 26 Oct 2025 12:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761482558; cv=none; b=SowvyVS6qc/LJNyNbQQycMdnfbdcBL6McrfUdhs1GcMymV0N3Qi4WsOZYP4zZusMuzvzXEdhTisKIHz2elb97uTkTEI25ich50ETQaKX0lrBJ4qB455e9S6vFEtzfCmx9EEkrZ7Y1xmNq9RjpuC249j0ZW1yzo0RrgAgEKKGExo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761482558; c=relaxed/simple;
	bh=pOqwtDHdRS58G7ZQ40ueHvkKEiOO/FXoywGUKaUsTkE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FfyAl/vb/o1P4fgptI/hLryW5mHHCyotF/PIsn0N2SvvW+piY2udEIAPcQaykuwEch0fn3gN2u9JNh25iRH67ufYryNCZnithcydvnrbV3wqRGGpy7cRjWfIWe3naYyF6pB65sAxHdt3P6RpJrAhZg8acidyNdHQlpj/53b01rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=1KFZMedX; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=ymzDNAJ8pWSBCtZPDPP82wHiAQGW1cXsJMWWKL0xjqs=; t=1761482553;
	x=1761914553; b=1KFZMedXWyAnls+A0wc9wULSHI/7NFFwpu4tvy91xQtPnw/rUPpxdzauiB/pN
	WpiDShzCctvKhc8ZgrDsVznnE1ps2cdcD2HRUOr46onHdRuNKqIpa1k2QKZqjD4IHqwCRksT8f/EQ
	8M+n2cNAtlERQ+6lou1CfSOdLDBdpaLgWU6ACzo5WETtsEvmzQkWRWAeD870ZjwWhOuG3Ta+MJfW9
	mVqFQZNYYiR05/1oTuu+tnwy8UIbkAs47Jc2R0SjKN1TEAMzJTQ23GITI6wDkZzlBjS65KkE0TjBo
	nXEnogtKX8FDsV213KXckVn+yPRpHofJF6u2gB5Hvn0XxRbHtQ==;
Received: from [2a02:8108:8984:1d00:a8ad:ebd4:6fc6:160] (helo=luggage.fritz.box); authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	id 1vD04t-001mYe-19;
	Sun, 26 Oct 2025 13:42:31 +0100
From: Thorsten Leemhuis <linux@leemhuis.info>
To: Jonathan Corbet <corbet@lwn.net>
Cc: workflows@vger.kernel.org,
	linux-doc@vger.kernel.org,
	regressions@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 24/30] docs: reporting-issues: improve text on bug verification
Date: Sun, 26 Oct 2025 13:42:15 +0100
Message-ID: <ef4323e031b04382b0c3bae7ceefd7d98e68c44c.1761481839.git.linux@leemhuis.info>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1761481839.git.linux@leemhuis.info>
References: <cover.1761481839.git.linux@leemhuis.info>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1761482553;4a80bc7e;
X-HE-SMSGID: 1vD04t-001mYe-19

Fine-tune the instructions about verifying the bug happens with a
suitable kernel.

This now heavily relies on
Documentation/admin-guide/verify-bugs-and-bisect-regressions.rst, which
describes the necessary steps in a better and more straight-forward way.

The new approach also makes things easier to follow for those that
already run a suitable kernel.

Regressions in stable/longterm are now covered by the regular steps to
make things less confusing, as this was something people struggled with.

Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
---
 .../admin-guide/reporting-issues.rst          | 560 ++++--------------
 1 file changed, 113 insertions(+), 447 deletions(-)

diff --git a/Documentation/admin-guide/reporting-issues.rst b/Documentation/admin-guide/reporting-issues.rst
index f891764d4f64ce..9611514d10414e 100644
--- a/Documentation/admin-guide/reporting-issues.rst
+++ b/Documentation/admin-guide/reporting-issues.rst
@@ -190,36 +190,72 @@ following the others is usually in your own interest.
 
  [:ref:`details <coarsely_repiref>`]
 
- * Ensure your system does not enhance its kernels by building additional
-   kernel modules on-the-fly, which solutions like DKMS might be doing locally
-   without your knowledge.
-
- * Check if your kernel was 'tainted' when the issue occurred, as the event
-   that made the kernel set this flag might be causing the issue you face.
-
- * Write down coarsely how to reproduce the issue.
-
- * If you are facing a regression within a stable or longterm version line
-   (say something broke when updating from 5.10.4 to 5.10.5), scroll down to
-   'Dealing with regressions within a stable and longterm kernel line'.
-
-After these preparations you'll now enter the main part:
-
- * Unless you are already running the latest 'mainline' Linux kernel, better
-   go and install it for the reporting process. Testing and reporting with
-   the latest 'stable' Linux can be an acceptable alternative in some
-   situations; during the merge window that actually might be even the best
-   approach, but in that development phase it can be an even better idea to
-   suspend your efforts for a few days anyway. Whatever version you choose,
-   ideally use a 'vanilla' build. Ignoring these advices will dramatically
-   increase the risk your report will be rejected or ignored.
-
- * Ensure the kernel you just installed does not 'taint' itself when
-   running.
-
- * Reproduce the issue with the kernel you just installed. If it doesn't show
-   up there, scroll down to the instructions for issues only happening with
-   stable and longterm kernels.
+.. _verify_repisbs:
+
+* *You must* report the problem using a kernel suitable for reporting -- so you
+  have to verify it happens with such a kernel, unless you already run one. In
+  case of a regression within a stable or longterm kernel, *you must*
+  furthermore check if the latest mainline kernel is affected as well. For
+  regressions in general, it is also recommended to locate the culprit using a
+  Git bisection.
+
+  There are two approaches to realize those three requirements:
+
+  * Follow 'Documentation/admin-guide/verify-bugs-and-bisect-regressions.rst',
+    which is the recommended way.
+
+  * Handle all tasks that document covers on your own:
+
+    * For regressions within a stable or longterm series, check if the series is
+      still supported by ensuring `kernel.org <https://kernel.org/>`_ lists it
+      without an 'EOL' tag. Then verify the problem still happens with the
+      latest release from that series; afterwards, check if the latest mainline
+      kernel is affected as well. When testing, ideally recheck with a vanilla
+      version of the working kernel and rule out a config change as the root of
+      your problem by building all newer Linux versions with a .config from the
+      latest working kernel processed by ``make olddefconfig``.
+
+    * In all other cases, check if the bug happens with a release, pre-release,
+      or snapshot of Linux mainline ideally less than one week old and two at
+      maximum. The latest release from the newest stable series might work out
+      as well, while longterm kernels rarely will.
+
+    All kernels used for verifying additionally must meet the following
+    criteria:
+
+    * The kernels should be 'vanilla', e.g., built from pristine Linux sources
+      -- albeit reports from kernels built from lightly patched sources such as
+      those used by default in Arch Linux, Debian GNU/Linux, Fedora Linux, and
+      openSUSE Tumbleweed often work, too, as long as they are fresh enough (see
+      above). The kernels of most other distributions are unsuitable; this
+      includes those Ubuntu and its derivatives use by default.
+
+    * The kernels must remain 'vanilla' and thus never load any externally
+      developed modules, no matter if they are proprietary or Open Source. This,
+      among others, means that you will have to steer clear of Nvidia's graphics
+      drivers and OpenZFS as well as drivers VirtualBox or VMware Workstation
+      install.
+
+    * The kernels should not be 'tainted' before the issue occurs. If yours is,
+      rule out that it has anything to do with the problem -- and if that really
+      is the case, mention the reason for the tainting in your report later.
+
+  Once you used either of the approaches to verify the problem with a suitable
+  kernel, you are free to move on with this guide and report the problem. Note,
+  though, in case it is regression not yet known, you most likely will be asked
+  to perform a bisection. So if you feel like it, start one right after sending
+  the report -- or perform one before sending it, which will tell you to whom
+  the report needs to be sent.
+
+  In case you failed to reproduce a problem with mainline: Is it a problem that
+  is not a regression? One you want to see resolved in a stable or longterm
+  series? If all that is the case, head over to ':ref:`Handling non-regressions
+  only occurring in stable or longterm kernels' <readysolved_repisubs>`.
+
+  Note: Don't take the requirements in this step lightheartedly, as otherwise
+  there is quite a risk your report will be fruitless or even ignored.
+
+ [:ref:`details <verify_repiref>`]
 
  * Optimize your notes: try to find and write the most straightforward way to
    reproduce your issue. Make sure the end result has all the important
@@ -230,9 +266,6 @@ After these preparations you'll now enter the main part:
  * If your failure involves a 'panic', 'Oops', 'warning', or 'BUG', consider
    decoding the kernel log to find the line of code that triggered the error.
 
- * If your problem is a regression, try to narrow down when the issue was
-   introduced as much as possible.
-
  * Start to compile the report by writing a detailed description about the
    issue. Always mention a few things: the latest kernel version you installed
    for reproducing, the Linux Distribution used, and your notes on how to
@@ -257,70 +290,46 @@ After these preparations you'll now enter the main part:
    help yourself, if you don't get any help or if it's unsatisfying.
 
 
-Reporting regressions within a stable and longterm kernel line
---------------------------------------------------------------
-
-This subsection is for you, if you followed above process and got sent here at
-the point about regression within a stable or longterm kernel version line. You
-face one of those if something breaks when updating from 5.10.4 to 5.10.5 (a
-switch from 5.9.15 to 5.10.5 does not qualify). The developers want to fix such
-regressions as quickly as possible, hence there is a streamlined process to
-report them:
-
- * Check if the kernel developers still maintain the Linux kernel version
-   line you care about: go to the  `front page of kernel.org
-   <https://kernel.org/>`_ and make sure it mentions
-   the latest release of the particular version line without an '[EOL]' tag.
-
- * Check the archives of the `Linux stable mailing list
-   <https://lore.kernel.org/stable/>`_ for existing reports.
-
- * Install the latest release from the particular version line as a vanilla
-   kernel. Ensure this kernel is not tainted and still shows the problem, as
-   the issue might have already been fixed there. If you first noticed the
-   problem with a vendor kernel, check a vanilla build of the last version
-   known to work performs fine as well.
-
- * Send a short problem report to the Linux stable mailing list
-   (stable@vger.kernel.org) and CC the Linux regressions mailing list
-   (regressions@lists.linux.dev); if you suspect the cause in a particular
-   subsystem, CC its maintainer and its mailing list. Roughly describe the
-   issue and ideally explain how to reproduce it. Mention the first version
-   that shows the problem and the last version that's working fine. Then
-   wait for further instructions.
+Handling non-regressions only occurring in stable or longterm kernels
+---------------------------------------------------------------------
 
-The reference section below explains each of these steps in more detail.
+Follow the next few steps only if the step-by-step guide sent you here. That is
+the case when you are (a) facing an issue in the latest release of a still
+supported stable or longterm series that (b) you were unable to reproduce in
+the current mainline and (c) is not a regression. If all of that holds true,
+follow these steps:
 
+* Be aware: it is possible the issue will not be resolved, as the fix might be
+  too big or risky to backport.
 
-Reporting issues only occurring in older kernel version lines
--------------------------------------------------------------
+* Search Linux' mainline Git repository or `lore
+  <https://lore.kernel.org/all/>`_ for the change resolving the issue. In case
+  you have trouble locating it, consider using a bisection; alternatively ask
+  on the list of the affected subsystem for advice while CCing the relevant
+  maintainers and developers.
 
-This subsection is for you, if you tried the latest mainline kernel as outlined
-above, but failed to reproduce your issue there; at the same time you want to
-see the issue fixed in a still supported stable or longterm series or vendor
-kernels regularly rebased on those. If that is the case, follow these steps:
+* Check if the change is already scheduled to be backported by searching the
+  patch description for a 'stable tag' (a line like 'Cc:
+  <stable@vger.kernel.org>' and the patch's title in lore.kernel.org:
 
- * Prepare yourself for the possibility that going through the next few steps
-   might not get the issue solved in older releases: the fix might be too big
-   or risky to get backported there.
+  * If the change is already scheduled for backporting, it usually will be
+    picked up within one or two weeks after being mainlined. Note though, plans
+    sometimes change; a comment next to the stable tag might also limit how far
+    the fix is backported and thus exclude the series you care about. If there
+    are good reasons for this, you are out of luck. If you can't spot any:
 
- * Perform the first three steps in the section "Dealing with regressions
-   within a stable and longterm kernel line" above.
+    Send a reply asking the involved developers if backporting to the series is
+    an option. Note though, the developers might greenlight backporting, but
+    unwilling to handle the work themselves -- in which case you or somebody
+    else must test and submit the fix and everything it depends on as explained
+    in Documentation/process/stable-kernel-rules.rst.
 
- * Search the Linux kernel version control system for the change that fixed
-   the issue in mainline, as its commit message might tell you if the fix is
-   scheduled for backporting already. If you don't find anything that way,
-   search the appropriate mailing lists for posts that discuss such an issue
-   or peer-review possible fixes; then check the discussions if the fix was
-   deemed unsuitable for backporting. If backporting was not considered at
-   all, join the newest discussion, asking if it's in the cards.
-
- * One of the former steps should lead to a solution. If that doesn't work
-   out, ask the maintainers for the subsystem that seems to be causing the
-   issue for advice; CC the mailing list for the particular subsystem as well
-   as the stable mailing list.
-
-The reference section below explains each of these steps in more detail.
+  * If the change is not scheduled for backporting, search `lore
+    <https://lore.kernel.org/all/>`_ for the review of the fix and check if
+    backporting is planned or was rejected. If it is neither, send a reply
+    asking the involved developers if backporting to the series is an option.
+    Just as mentioned in the previous paragraph, you might need to handle
+    backporting on your own.
 
 
 Conclusion of the step-by-step guide
@@ -958,212 +967,25 @@ the verification.
 [:ref:`back to step-by-step guide <coarsely_repisbs>`]
 
 
-Make sure your kernel doesn't get enhanced
-------------------------------------------
-
-    *Ensure your system does not enhance its kernels by building additional
-    kernel modules on-the-fly, which solutions like DKMS might be doing locally
-    without your knowledge.*
-
-The risk your issue report gets ignored or rejected dramatically increases if
-your kernel gets enhanced in any way. That's why you should remove or disable
-mechanisms like akmods and DKMS: those build add-on kernel modules
-automatically, for example when you install a new Linux kernel or boot it for
-the first time. Also remove any modules they might have installed. Then reboot
-before proceeding.
-
-Note, you might not be aware that your system is using one of these solutions:
-they often get set up silently when you install Nvidia's proprietary graphics
-driver, VirtualBox, or other software that requires a some support from a
-module not part of the Linux kernel. That why your might need to uninstall the
-packages with such software to get rid of any 3rd party kernel module.
-
+.. _verify_repiref:
 
-Regression in stable or longterm kernel?
-----------------------------------------
-
-    *If you are facing a regression within a stable or longterm version line
-    (say something broke when updating from 5.10.4 to 5.10.5), scroll down to
-    'Dealing with regressions within a stable and longterm kernel line'.*
-
-Regression within a stable and longterm kernel version line are something the
-Linux developers want to fix badly, as such issues are even more unwanted than
-regression in the main development branch, as they can quickly affect a lot of
-people. The developers thus want to learn about such issues as quickly as
-possible, hence there is a streamlined process to report them. Note,
-regressions with newer kernel version line (say something broke when switching
-from 5.9.15 to 5.10.5) do not qualify.
+Verify the problem with a suitable kernel
+-----------------------------------------
 
+  *You must report the problem using a kernel suitable for reporting -- so you
+  [...] In case of a regression within a stable or longterm kernel, you also
+  must check*  [:ref:`... <verify_repisbs>`]
 
-Install a fresh kernel for testing
-----------------------------------
+Following the instructions in this step dramatically increases the chance some
+developer will look into the report, as it ensures the bug is actually present
+in a codebase they care about; for regressions in stable or longterm series,
+they furthermore determine the right point of contact for the bug, which
+depends on whether the problem happens in mainline as well.
 
-    *Unless you are already running the latest 'mainline' Linux kernel, better
-    go and install it for the reporting process. Testing and reporting with
-    the latest 'stable' Linux can be an acceptable alternative in some
-    situations; during the merge window that actually might be even the best
-    approach, but in that development phase it can be an even better idea to
-    suspend your efforts for a few days anyway. Whatever version you choose,
-    ideally use a 'vanilla' built. Ignoring these advices will dramatically
-    increase the risk your report will be rejected or ignored.*
-
-As mentioned in the detailed explanation for the first step already: Like most
-programmers, Linux kernel developers don't like to spend time dealing with
-reports for issues that don't even happen with the current code. It's just a
-waste everybody's time, especially yours. That's why it's in everybody's
-interest that you confirm the issue still exists with the latest upstream code
-before reporting it. You are free to ignore this advice, but as outlined
-earlier: doing so dramatically increases the risk that your issue report might
-get rejected or simply ignored.
-
-In the scope of the kernel "latest upstream" normally means:
-
- * Install a mainline kernel; the latest stable kernel can be an option, but
-   most of the time is better avoided. Longterm kernels (sometimes called 'LTS
-   kernels') are unsuitable at this point of the process. The next subsection
-   explains all of this in more detail.
-
- * The over next subsection describes way to obtain and install such a kernel.
-   It also outlines that using a pre-compiled kernel are fine, but better are
-   vanilla, which means: it was built using Linux sources taken straight `from
-   kernel.org <https://kernel.org/>`_ and not modified or enhanced in any way.
-
-Choosing the right version for testing
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-
-Head over to `kernel.org <https://kernel.org/>`_ to find out which version you
-want to use for testing. Ignore the big yellow button that says 'Latest release'
-and look a little lower at the table. At its top you'll see a line starting with
-mainline, which most of the time will point to a pre-release with a version
-number like '5.8-rc2'. If that's the case, you'll want to use this mainline
-kernel for testing, as that where all fixes have to be applied first. Do not let
-that 'rc' scare you, these 'development kernels' are pretty reliable — and you
-made a backup, as you were instructed above, didn't you?
-
-In about two out of every nine to ten weeks, mainline might point you to a
-proper release with a version number like '5.7'. If that happens, consider
-suspending the reporting process until the first pre-release of the next
-version (5.8-rc1) shows up on kernel.org. That's because the Linux development
-cycle then is in its two-week long 'merge window'. The bulk of the changes and
-all intrusive ones get merged for the next release during this time. It's a bit
-more risky to use mainline during this period. Kernel developers are also often
-quite busy then and might have no spare time to deal with issue reports. It's
-also quite possible that one of the many changes applied during the merge
-window fixes the issue you face; that's why you soon would have to retest with
-a newer kernel version anyway, as outlined below in the section 'Duties after
-the report went out'.
-
-That's why it might make sense to wait till the merge window is over. But don't
-to that if you're dealing with something that shouldn't wait. In that case
-consider obtaining the latest mainline kernel via git (see below) or use the
-latest stable version offered on kernel.org. Using that is also acceptable in
-case mainline for some reason does currently not work for you. An in general:
-using it for reproducing the issue is also better than not reporting it issue
-at all.
-
-Better avoid using the latest stable kernel outside merge windows, as all fixes
-must be applied to mainline first. That's why checking the latest mainline
-kernel is so important: any issue you want to see fixed in older version lines
-needs to be fixed in mainline first before it can get backported, which can
-take a few days or weeks. Another reason: the fix you hope for might be too
-hard or risky for backporting; reporting the issue again hence is unlikely to
-change anything.
-
-These aspects are also why longterm kernels (sometimes called "LTS kernels")
-are unsuitable for this part of the reporting process: they are to distant from
-the current code. Hence go and test mainline first and follow the process
-further: if the issue doesn't occur with mainline it will guide you how to get
-it fixed in older version lines, if that's in the cards for the fix in question.
-
-How to obtain a fresh Linux kernel
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-
-**Using a pre-compiled kernel**: This is often the quickest, easiest, and safest
-way for testing — especially is you are unfamiliar with the Linux kernel. The
-problem: most of those shipped by distributors or add-on repositories are build
-from modified Linux sources. They are thus not vanilla and therefore often
-unsuitable for testing and issue reporting: the changes might cause the issue
-you face or influence it somehow.
-
-But you are in luck if you are using a popular Linux distribution: for quite a
-few of them you'll find repositories on the net that contain packages with the
-latest mainline or stable Linux built as vanilla kernel. It's totally okay to
-use these, just make sure from the repository's description they are vanilla or
-at least close to it. Additionally ensure the packages contain the latest
-versions as offered on kernel.org. The packages are likely unsuitable if they
-are older than a week, as new mainline and stable kernels typically get released
-at least once a week.
-
-Please note that you might need to build your own kernel manually later: that's
-sometimes needed for debugging or testing fixes, as described later in this
-document. Also be aware that pre-compiled kernels might lack debug symbols that
-are needed to decode messages the kernel prints when a panic, Oops, warning, or
-BUG occurs; if you plan to decode those, you might be better off compiling a
-kernel yourself (see the end of this subsection and the section titled 'Decode
-failure messages' for details).
-
-**Using git**: Developers and experienced Linux users familiar with git are
-often best served by obtaining the latest Linux kernel sources straight from the
-`official development repository on kernel.org
-<https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/>`_.
-Those are likely a bit ahead of the latest mainline pre-release. Don't worry
-about it: they are as reliable as a proper pre-release, unless the kernel's
-development cycle is currently in the middle of a merge window. But even then
-they are quite reliable.
-
-**Conventional**: People unfamiliar with git are often best served by
-downloading the sources as tarball from `kernel.org <https://kernel.org/>`_.
-
-How to actually build a kernel is not described here, as many websites explain
-the necessary steps already. If you are new to it, consider following one of
-those how-to's that suggest to use ``make localmodconfig``, as that tries to
-pick up the configuration of your current kernel and then tries to adjust it
-somewhat for your system. That does not make the resulting kernel any better,
-but quicker to compile.
-
-Note: If you are dealing with a panic, Oops, warning, or BUG from the kernel,
-please try to enable CONFIG_KALLSYMS when configuring your kernel.
-Additionally, enable CONFIG_DEBUG_KERNEL and CONFIG_DEBUG_INFO, too; the
-latter is the relevant one of those two, but can only be reached if you enable
-the former. Be aware CONFIG_DEBUG_INFO increases the storage space required to
-build a kernel by quite a bit. But that's worth it, as these options will allow
-you later to pinpoint the exact line of code that triggers your issue. The
-section 'Decode failure messages' below explains this in more detail.
-
-But keep in mind: Always keep a record of the issue encountered in case it is
-hard to reproduce. Sending an undecoded report is better than not reporting
-the issue at all.
+The step-by-step guide outlines the gist of the required tasks; if you need
+more detailed instructions, follow Documentation/admin-guide/verify-bugs-and-bisect-regressions.rst.
 
-
-Check 'taint' flag
-------------------
-
-    *Ensure the kernel you just installed does not 'taint' itself when
-    running.*
-
-As outlined above in more detail already: the kernel sets a 'taint' flag when
-something happens that can lead to follow-up errors that look totally
-unrelated. That's why you need to check if the kernel you just installed does
-not set this flag. And if it does, you in almost all the cases needs to
-eliminate the reason for it before you reporting issues that occur with it. See
-the section above for details how to do that.
-
-
-Reproduce issue with the fresh kernel
--------------------------------------
-
-    *Reproduce the issue with the kernel you just installed. If it doesn't show
-    up there, scroll down to the instructions for issues only happening with
-    stable and longterm kernels.*
-
-Check if the issue occurs with the fresh Linux kernel version you just
-installed. If it was fixed there already, consider sticking with this version
-line and abandoning your plan to report the issue. But keep in mind that other
-users might still be plagued by it, as long as it's not fixed in either stable
-and longterm version from kernel.org (and thus vendor kernels derived from
-those). If you prefer to use one of those or just want to help their users,
-head over to the section "Details about reporting issues only occurring in
-older kernel version lines" below.
+[:ref:`back to step-by-step guide <verify_repisbs>`]
 
 
 Optimize description to reproduce issue
@@ -1239,60 +1061,6 @@ be required to retrieve the relevant details. Don't worry about that, if that's
 needed in your case, developers will tell you what to do.
 
 
-Special care for regressions
-----------------------------
-
-    *If your problem is a regression, try to narrow down when the issue was
-    introduced as much as possible.*
-
-Linux lead developer Linus Torvalds insists that the Linux kernel never
-worsens, that's why he deems regressions as unacceptable and wants to see them
-fixed quickly. That's why changes that introduced a regression are often
-promptly reverted if the issue they cause can't get solved quickly any other
-way. Reporting a regression is thus a bit like playing a kind of trump card to
-get something quickly fixed. But for that to happen the change that's causing
-the regression needs to be known. Normally it's up to the reporter to track
-down the culprit, as maintainers often won't have the time or setup at hand to
-reproduce it themselves.
-
-To find the change there is a process called 'bisection' which the document
-Documentation/admin-guide/bug-bisect.rst describes in detail. That process
-will often require you to build about ten to twenty kernel images, trying to
-reproduce the issue with each of them before building the next. Yes, that takes
-some time, but don't worry, it works a lot quicker than most people assume.
-Thanks to a 'binary search' this will lead you to the one commit in the source
-code management system that's causing the regression. Once you find it, search
-the net for the subject of the change, its commit id and the shortened commit id
-(the first 12 characters of the commit id). This will lead you to existing
-reports about it, if there are any.
-
-Note, a bisection needs a bit of know-how, which not everyone has, and quite a
-bit of effort, which not everyone is willing to invest. Nevertheless, it's
-highly recommended performing a bisection yourself. If you really can't or
-don't want to go down that route at least find out which mainline kernel
-introduced the regression. If something for example breaks when switching from
-5.5.15 to 5.8.4, then try at least all the mainline releases in that area (5.6,
-5.7 and 5.8) to check when it first showed up. Unless you're trying to find a
-regression in a stable or longterm kernel, avoid testing versions which number
-has three sections (5.6.12, 5.7.8), as that makes the outcome hard to
-interpret, which might render your testing useless. Once you found the major
-version which introduced the regression, feel free to move on in the reporting
-process. But keep in mind: it depends on the issue at hand if the developers
-will be able to help without knowing the culprit. Sometimes they might
-recognize from the report want went wrong and can fix it; other times they will
-be unable to help unless you perform a bisection.
-
-When dealing with regressions make sure the issue you face is really caused by
-the kernel and not by something else, as outlined above already.
-
-In the whole process keep in mind: an issue only qualifies as regression if the
-older and the newer kernel got built with a similar configuration. This can be
-achieved by using ``make olddefconfig``, as explained in more detail by
-Documentation/admin-guide/reporting-regressions.rst; that document also
-provides a good deal of other information about regressions you might want to be
-aware of.
-
-
 Write and send the report
 -------------------------
 
@@ -1689,108 +1457,6 @@ easier. And with a bit of luck there might be someone in the team that knows a
 bit about programming and might be able to write a fix.
 
 
-Reference for "Reporting regressions within a stable and longterm kernel line"
-------------------------------------------------------------------------------
-
-This subsection provides details for the steps you need to perform if you face
-a regression within a stable and longterm kernel line.
-
-Make sure the particular version line still gets support
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-
-    *Check if the kernel developers still maintain the Linux kernel version
-    line you care about: go to the front page of kernel.org and make sure it
-    mentions the latest release of the particular version line without an
-    '[EOL]' tag.*
-
-Most kernel version lines only get supported for about three months, as
-maintaining them longer is quite a lot of work. Hence, only one per year is
-chosen and gets supported for at least two years (often six). That's why you
-need to check if the kernel developers still support the version line you care
-for.
-
-Note, if kernel.org lists two stable version lines on the front page, you
-should consider switching to the newer one and forget about the older one:
-support for it is likely to be abandoned soon. Then it will get a "end-of-life"
-(EOL) stamp. Version lines that reached that point still get mentioned on the
-kernel.org front page for a week or two, but are unsuitable for testing and
-reporting.
-
-Search stable mailing list
-~~~~~~~~~~~~~~~~~~~~~~~~~~
-
-    *Check the archives of the Linux stable mailing list for existing reports.*
-
-Maybe the issue you face is already known and was fixed or is about to. Hence,
-`search the archives of the Linux stable mailing list
-<https://lore.kernel.org/stable/>`_ for reports about an issue like yours. If
-you find any matches, consider joining the discussion, unless the fix is
-already finished and scheduled to get applied soon.
-
-Reproduce issue with the newest release
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-
-    *Install the latest release from the particular version line as a vanilla
-    kernel. Ensure this kernel is not tainted and still shows the problem, as
-    the issue might have already been fixed there. If you first noticed the
-    problem with a vendor kernel, check a vanilla build of the last version
-    known to work performs fine as well.*
-
-Before investing any more time in this process you want to check if the issue
-was already fixed in the latest release of version line you're interested in.
-This kernel needs to be vanilla and shouldn't be tainted before the issue
-happens, as detailed outlined already above in the section "Install a fresh
-kernel for testing".
-
-Did you first notice the regression with a vendor kernel? Then changes the
-vendor applied might be interfering. You need to rule that out by performing
-a recheck. Say something broke when you updated from 5.10.4-vendor.42 to
-5.10.5-vendor.43. Then after testing the latest 5.10 release as outlined in
-the previous paragraph check if a vanilla build of Linux 5.10.4 works fine as
-well. If things are broken there, the issue does not qualify as upstream
-regression and you need switch back to the main step-by-step guide to report
-the issue.
-
-Report the regression
-~~~~~~~~~~~~~~~~~~~~~
-
-    *Send a short problem report to the Linux stable mailing list
-    (stable@vger.kernel.org) and CC the Linux regressions mailing list
-    (regressions@lists.linux.dev); if you suspect the cause in a particular
-    subsystem, CC its maintainer and its mailing list. Roughly describe the
-    issue and ideally explain how to reproduce it. Mention the first version
-    that shows the problem and the last version that's working fine. Then
-    wait for further instructions.*
-
-When reporting a regression that happens within a stable or longterm kernel
-line (say when updating from 5.10.4 to 5.10.5) a brief report is enough for
-the start to get the issue reported quickly. Hence a rough description to the
-stable and regressions mailing list is all it takes; but in case you suspect
-the cause in a particular subsystem, CC its maintainers and its mailing list
-as well, because that will speed things up.
-
-And note, it helps developers a great deal if you can specify the exact version
-that introduced the problem. Hence if possible within a reasonable time frame,
-try to find that version using vanilla kernels. Let's assume something broke when
-your distributor released a update from Linux kernel 5.10.5 to 5.10.8. Then as
-instructed above go and check the latest kernel from that version line, say
-5.10.9. If it shows the problem, try a vanilla 5.10.5 to ensure that no patches
-the distributor applied interfere. If the issue doesn't manifest itself there,
-try 5.10.7 and then (depending on the outcome) 5.10.8 or 5.10.6 to find the
-first version where things broke. Mention it in the report and state that 5.10.9
-is still broken.
-
-What the previous paragraph outlines is basically a rough manual 'bisection'.
-Once your report is out your might get asked to do a proper one, as it allows to
-pinpoint the exact change that causes the issue (which then can easily get
-reverted to fix the issue quickly). Hence consider to do a proper bisection
-right away if time permits. See the section 'Special care for regressions' and
-the document Documentation/admin-guide/bug-bisect.rst for details how to
-perform one. In case of a successful bisection add the author of the culprit to
-the recipients; also CC everyone in the signed-off-by chain, which you find at
-the end of its commit message.
-
-
 Reference for "Reporting issues only occurring in older kernel version lines"
 -----------------------------------------------------------------------------
 
-- 
2.51.0


