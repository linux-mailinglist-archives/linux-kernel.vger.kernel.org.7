Return-Path: <linux-kernel+bounces-870340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A48FBC0A7FF
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 13:45:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E6D218A0F3B
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 12:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A5352E3703;
	Sun, 26 Oct 2025 12:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="vashsqxB"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E60D2DA776;
	Sun, 26 Oct 2025 12:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761482555; cv=none; b=bOiPB3X0yArEXxQfKcqo0gys3ePqiOhDv3yTUf/kXpNsCRVRKbSFNrwAPBLd6k++oWtFKMUAgoyUqj7ueratvlNm8Ft6cb/+1alNPzaENw4xRsa4VoI+5Xd9CEnIRg02kptDsLoIA11+zT5R4IK8k3kxtQLEpbxj0f+lhysl9eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761482555; c=relaxed/simple;
	bh=Jzpn3cEHJuR4e/7Diq2X/A/kIMNuV6RmqTVz+GOnCgQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pVi5mpLFqHdniYDMTJJxqTrBVKwjfacO1zwI5h+Oj2qm3l4Q3toYyEKnq7BbfxjplZJ7eilreL4BURKFZwp/AZpzDQ5YEVVqH8TNV9B1XX8KiC0w+PTpwZ/M1VZuc/z09kprvl6VbtuGT0h7luPB+GMIC8bl+iULFzy4uRztsvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=vashsqxB; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:From:Sender:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=MCwTNgmIFvfobjvhJBYW7voWM3a+ip/YtfYapTlN3Nk=; t=1761482552;
	x=1761914552; b=vashsqxBZFUm+HfTEbYOYjsDfL5o7wXov+/rwaX7X0JmOY9+/9nuK0OLVoPPV
	SSZt/4fz7wdwwFQXeKwppx+er6M8HTXrcsx0yUORhZtoruKc+zpjsMOpDHyKPK7fNtwRJ7PrGFUYK
	/TF3e+02Ms2d2agTpAg2aHgtcjnV6U1sbAPTA5UVZUSd9YmAwa3dpZMzPn9HP0bnJJlX0VULSyJW/
	XB9RlRnp6BHI0cgj+ii4AXlacDFBKk8AEFXv3HLaPLGwB9deaFn10XuQeZtJwTTguPeGsbd9cpZ2U
	E+iO9FqEtI723Frq5I0m3VHPXpoWEqp/h4pzdodB86WBraAQGg==;
Received: from [2a02:8108:8984:1d00:a8ad:ebd4:6fc6:160] (helo=luggage.fritz.box); authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	id 1vD04m-001mXP-22;
	Sun, 26 Oct 2025 13:42:24 +0100
From: Thorsten Leemhuis <linux@leemhuis.info>
To: Jonathan Corbet <corbet@lwn.net>
Cc: workflows@vger.kernel.org,
	linux-doc@vger.kernel.org,
	regressions@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 06/30] docs: reporting-issues: replace TLDR guide with more of an into
Date: Sun, 26 Oct 2025 13:41:57 +0100
Message-ID: <bffecd192c73909b8ceb58a123842c943e51200f.1761481839.git.linux@leemhuis.info>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1761481839.git.linux@leemhuis.info>
References: <cover.1761481839.git.linux@leemhuis.info>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1761482552;81a32109;
X-HE-SMSGID: 1vD04m-001mXP-22

Remove the TLDR guide and just describe the essence: a email is all that
is needed.

Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
---
---
 .../admin-guide/reporting-issues.rst          | 90 +++++++------------
 1 file changed, 32 insertions(+), 58 deletions(-)

diff --git a/Documentation/admin-guide/reporting-issues.rst b/Documentation/admin-guide/reporting-issues.rst
index 2629fde3aa4b8f..7dfb3ca4b3e322 100644
--- a/Documentation/admin-guide/reporting-issues.rst
+++ b/Documentation/admin-guide/reporting-issues.rst
@@ -4,49 +4,34 @@
 Reporting issues
 ++++++++++++++++
 
-
-The short guide (aka TL;DR)
-===========================
-
-Are you facing a regression with vanilla kernels from the same stable or
-longterm series? One still supported? Then search the `LKML
-<https://lore.kernel.org/lkml/>`_ and the `Linux stable mailing list
-<https://lore.kernel.org/stable/>`_ archives for matching reports to join. If
-you don't find any, install `the latest release from that series
-<https://kernel.org/>`_. If it still shows the issue, report it to the stable
-mailing list (stable@vger.kernel.org) and CC the regressions list
-(regressions@lists.linux.dev); ideally also CC the maintainer and the mailing
-list for the subsystem in question.
-
-In all other cases try your best guess which kernel part might be causing the
-issue. Check the :ref:`MAINTAINERS <maintainers>` file for how its developers
-expect to be told about problems, which most of the time will be by email with a
-mailing list in CC. Check the destination's archives for matching reports;
-search the `LKML <https://lore.kernel.org/lkml/>`_ and the web, too. If you
-don't find any to join, install `the latest mainline kernel
-<https://kernel.org/>`_. If the issue is present there, send a report.
-
-The issue was fixed there, but you would like to see it resolved in a still
-supported stable or longterm series as well? Then install its latest release.
-If it shows the problem, search for the change that fixed it in mainline and
-check if backporting is in the works or was discarded; if it's neither, ask
-those who handled the change for it.
-
-**General remarks**: When installing and testing a kernel as outlined above,
-ensure it's vanilla (IOW: not patched and not using add-on modules). Also make
-sure it's built and running in a healthy environment and not already tainted
-before the issue occurs.
-
-If you are facing multiple issues with the Linux kernel at once, report each
-separately. While writing your report, include all information relevant to the
-issue, like the kernel and the distro used. In case of a regression, CC the
-regressions mailing list (regressions@lists.linux.dev) to your report. Also try
-to pinpoint the culprit with a bisection; if you succeed, include its
-commit-id and CC everyone in the sign-off-by chain.
-
-Once the report is out, answer any questions that come up and help where you
-can. That includes keeping the ball rolling by occasionally retesting with newer
-releases and sending a status update afterwards.
+An email with a problem description sent to the appropriate developers and
+mailing lists -- that is all it takes to report a Linux kernel bug.
+
+This might sound easy, but be aware: Your bug reporting experience is likely to
+become tedious or fruitless unless you get a few implicit aspects right.
+
+The Linux kernel used, for example, must ideally be a recent mainline version;
+longterm kernels will rarely do the trick, unless for reporting series-specific
+regressions. That alone makes the vast majority of kernels shipped by hardware
+vendors and Linux distributors unsuitable for upstream reporting. But those
+almost always are inadequate anyway, as most are built from modified sources or
+use externally developed kernel modules. Both aspects can lead to issues that
+never occurred with the upstream Linux kernel, which is why most of its
+developers do not really care about bugs reported with such kernels.
+
+Identifying how to submit a report is also easier said than done. The file
+MAINTAINERS answers this and usually points to email addresses. But a small
+number of subsystems prefer reports through one of various bug trackers. Bugs
+with most graphics drivers have to go to https://gitlab.freedesktop.org/drm/;
+https://bugzilla.kernel.org seems like a universal place, but it is rarely the
+right destination, as submissions there often do not even reach the developers.
+
+The stable team, furthermore, is only the right point of contact for regressions
+within a particular stable or longterm kernel series that at the same time do
+not happen with latest mainline -- which you thus have to rule out first.
+
+To avoid an ineffective, frustrating, or fruitless bug reporting experience, it
+thus is in your best interest to follow the step-by-step guide below.
 
 ..
    Note: If you see this note, you are reading the text's source file. You
@@ -58,22 +43,11 @@ releases and sending a status update afterwards.
    https://docs.kernel.org/admin-guide/reporting-issues.html
 
 
-Step-by-step guide how to report issues to the kernel maintainers
-=================================================================
-
-The above TL;DR outlines roughly how to report issues to the Linux kernel
-developers. It might be all that's needed for people already familiar with
-reporting issues to Free/Libre & Open Source Software (FLOSS) projects. For
-everyone else there is this section. It is more detailed and uses a
-step-by-step approach. It still tries to be brief for readability and leaves
-out a lot of details; those are described below the step-by-step guide in a
-reference section, which explains each of the steps in more detail.
+Step-by-step guide on reporting Linux kernel issues
+===================================================
 
-Note: this section covers a few more aspects than the TL;DR and does things in
-a slightly different order. That's in your interest, to make sure you notice
-early if an issue that looks like a Linux kernel problem is actually caused by
-something else. These steps thus help to ensure the time you invest in this
-process won't feel wasted in the end:
+Note: Only the steps starting with '*you must*' are strictly required -- but
+following the others is usually in your own interest.
 
  * Are you facing an issue with a Linux kernel a hardware or software vendor
    provided? Then in almost all cases you are better off to stop reading this
-- 
2.51.0


