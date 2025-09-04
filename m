Return-Path: <linux-kernel+bounces-801073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 411F8B43F8A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 16:49:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BFA31884BD3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 14:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5390818DF80;
	Thu,  4 Sep 2025 14:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oo+IHaKk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB8119E7E2;
	Thu,  4 Sep 2025 14:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756997135; cv=none; b=baiKGV46JouT0cNpDLJZgwUVoB814xnO5jRXdFafplODI6icMy2iOwM2kpG+WwbsAonhAX56Qj0T0VhI2hgp5b/fhrhwegsLWWaKsSzhl9ctXnFZ5KdYSstjobDUQmMFsbopVU7CZfL8eGkePcoxczHFhzEnu+kGXCsi2nPAggg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756997135; c=relaxed/simple;
	bh=XHMmkTr7QqEdwjATp4KAb0FF4TPhUtb+qZ3rX6Y6yPA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OOPvOqkBCMC2b9LPdTXHc60gNRIFlsnGdGd52CjZ3IH8IeBJXgBuZyIXOC75Py8rK4VxZ7BMcro+oxe8yoWgukw8aKGoz51QsJd3h2yZ1Lf8scFQPdiejLYWtJC4z3VqJDSvnRhAnd++zT24aYlaCwTLwqobIVLNGiAxEPNpYQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oo+IHaKk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37833C4CEF0;
	Thu,  4 Sep 2025 14:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756997135;
	bh=XHMmkTr7QqEdwjATp4KAb0FF4TPhUtb+qZ3rX6Y6yPA=;
	h=From:To:Cc:Subject:Date:From;
	b=Oo+IHaKkQrJkUcg5Cx939qVCgMm9cAJyWMWcFIuJt4o8Mgh7TNnS9nG07iZNJAR05
	 dqElEkA7/go4s62ai04Jptd1b3y016cQ2OIZ/fbjZ11ARYHIVcnJuDcT3IfxKo8ChV
	 zRyJwzrUf3hZCeI3aKeEL1bjsh0XbhCnln9tKwUl944KlreuGe8OrF1ELYmKSuqA8O
	 F8Ag9sO9UdYvXZgHr+ciXP+ccbGdKG+A0kcXBwcUs8p4EsBfM8OThBdNhpncCmm/v7
	 N1e1QY7Icrsp9oaEqCu7A92XYiP7FHUo831BX5oETV/MXuqR88vhovz+HoAKQyycfy
	 dmnpp5U5P9Ksg==
From: Jakub Kicinski <kuba@kernel.org>
To: corbet@lwn.net
Cc: workflows@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH] docs: submitting-patches: adjust Fixes definition slightly
Date: Thu,  4 Sep 2025 07:45:33 -0700
Message-ID: <20250904144533.2146576-1-kuba@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Every now and then people send stylistic patches and use Fixes
purely to refer to a commit which added the ugly or unnecessary
code. Reword the docs about Fixes.

It should hopefully be enough to lead with the word "bug"
rather than "issue". We can add more verbiage later, tho, let's
try the word swap first. I always feel like the more words the
smaller the chance someone will actually read the docs.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 Documentation/process/submitting-patches.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/process/submitting-patches.rst b/Documentation/process/submitting-patches.rst
index cede4e7b29af..5778cb9701e1 100644
--- a/Documentation/process/submitting-patches.rst
+++ b/Documentation/process/submitting-patches.rst
@@ -602,8 +602,8 @@ future. Note, this is one of only three tags you might be able to use without
 explicit permission of the person named (see 'Tagging people requires
 permission' below for details).
 
-A Fixes: tag indicates that the patch fixes an issue in a previous commit. It
-is used to make it easy to determine where a bug originated, which can help
+A Fixes: tag indicates that the patch fixes a bug in a previous commit. It
+is used to make it easy to determine where an issue originated, which can help
 review a bug fix. This tag also assists the stable kernel team in determining
 which stable kernel versions should receive your fix. This is the preferred
 method for indicating a bug fixed by the patch. See :ref:`describe_changes`
-- 
2.51.0


