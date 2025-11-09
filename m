Return-Path: <linux-kernel+bounces-891784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03B87C43750
	for <lists+linux-kernel@lfdr.de>; Sun, 09 Nov 2025 03:34:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD0D63B0B0A
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Nov 2025 02:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40A0F1CDFCA;
	Sun,  9 Nov 2025 02:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="Ec2w0w97"
Received: from mail-06.mail-europe.com (mail-06.mail-europe.com [85.9.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0BBC13B58C
	for <linux-kernel@vger.kernel.org>; Sun,  9 Nov 2025 02:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.9.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762655684; cv=none; b=fLlD6kRiDqTh2lisC+DAbicAr+9mvnKAh50tFcr/T1OEacK2AFMrXnx/7sn0SViEmrDSZaK1mU3VwsDJD/SBx8HLFuuMKMx+ro3UpDMxlY/eASQDYeNeUjHYEc/J0C57lWjXb38aVEeLXai0lrgoYH9klMnTYOa7l5k7rB90Dn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762655684; c=relaxed/simple;
	bh=NEGZUeoc1I7/yURwfguNi+vKBoYyzsfFjZmHFoz3HnM=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=KQQUMTXXJJUyYfWAi8V5iN2uKkH74OuwURWgThvSXTxet8dWQO9EVmYtyfJ+4vfXn1ht4MQZuxUcVdVdT2ZTquMf5wkt7b2OY5hVnaJboR4gJ/tk/Cn2dHdjlhP6MyQlE8WptlitDQWodcCGCs5+kcShWt0JEG8eIqWPsP7VtsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=Ec2w0w97; arc=none smtp.client-ip=85.9.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1762655667; x=1762914867;
	bh=m1ynGI2X+AbLJ9LU40R+pHG9Sqnj+G39AWPu5pNlDyA=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=Ec2w0w97K7XigU6rK+7r/Bc2V/vckhVtkeIQorwIMJJaGy74l/zxfR8o3I4zmDXT6
	 YZwKmczz116R6acHAN+OVeiDxkpNzrdqYsfJIajLmW345v8SQEdVqf/Q5Xvh8gLXTY
	 FFIeF2qDORmkoHoGvaJdwLPHjUpuOKiHQqKJfL8Dt+Qzj5bFh2fr0ib1sFNNRSKdag
	 +jjKzAysgYtoKZ4etDkIfTO06aUdQ/cxK4hQsHuQWZp7TNEX8tYXsQRL0irt7ooRG5
	 PqAyjs38jJjg9IoLa6Ti0FY1844Cm3h6bjp3MdGzuunvn7FsfYBO7OkHIIX1fnHdfD
	 oha1W0JM2PmWw==
Date: Sun, 09 Nov 2025 02:34:21 +0000
To: "tglx@linutronix.de" <tglx@linutronix.de>
From: pierwill <pierwill@protonmail.com>
Cc: "bp@alien8.de" <bp@alien8.de>, "peterz@infradead.org" <peterz@infradead.org>, "jpoimboe@kernel.org" <jpoimboe@kernel.org>, "pawan.kumar.gupta@linux.intel.com" <pawan.kumar.gupta@linux.intel.com>, "corbet@lwn.net" <corbet@lwn.net>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] docs: Fix missing word in spectre.rst
Message-ID: <Ru-d3ltJIyY4Oc6tzHwpSiDeFwSLHEzd7Utcr6iobgIy1B8wLRI4f6JiCb0a9n-0-r19d0dyLL3yS8KWVcyHfpkyDErWXYTkI3AJfUPTNCc=@protonmail.com>
Feedback-ID: 8154370:user:proton
X-Pm-Message-ID: 5db94a92c7c942c594a7393287e0d7cbd0ec549b
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Corrects a missing word in the hardware vulnerability docs.

Signed-off-by: Will Pierce <pierwill@protonmail.com>
---
 Documentation/admin-guide/hw-vuln/spectre.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/hw-vuln/spectre.rst b/Documentation/=
admin-guide/hw-vuln/spectre.rst
index 991f12adef8d..4bb8549bee82 100644
--- a/Documentation/admin-guide/hw-vuln/spectre.rst
+++ b/Documentation/admin-guide/hw-vuln/spectre.rst
@@ -406,7 +406,7 @@ The possible values in this file are:

   - Single threaded indirect branch prediction (STIBP) status for protecti=
on
     between different hyper threads. This feature can be controlled throug=
h
-    prctl per process, or through kernel command line options. This is x86
+    prctl per process, or through kernel command line options. This is an =
x86
     only feature. For more details see below.

   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
--
2.39.5 (Apple Git-154)

