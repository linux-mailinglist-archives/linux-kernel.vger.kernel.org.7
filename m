Return-Path: <linux-kernel+bounces-794812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8C91B3E793
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 16:44:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4928200422
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 14:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42382346A05;
	Mon,  1 Sep 2025 14:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mC+6MG6M"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 093C234167B;
	Mon,  1 Sep 2025 14:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756737758; cv=none; b=fQUO0hsuTkiIDpxm9aCTaLyma92vbpVW2k86cFD1n48ppYvtsgt4JeE8lkAbuy0veLarwu3K44fll3RenMQhvfNhyR24wK5oTlIfaCS86uhI0kYx/qAILqE+l4gIv8eEE1Mz+G2qv6rHb/9EzgusR7CIededpUCY89kKB5qqc/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756737758; c=relaxed/simple;
	bh=pFn4aXuekiJ4nWHYjOpMDGZDzWz9r/tmySbqoG1yg7I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TIG14Tfwvo2GuH3QsPiznWvtekwtXudP9QIN6FMT7swdC/oN4x3xDY7sx3etj3MD+xtox38im0DLMQ3Z1YxN5MU0qZQXI+8AfnHnjVIJZe7O61GTkWq2mP1xjxQUfcG61arTJSd7AtrDlN5BnE57xHXu2B4eB99C4Ttf2M0nHfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mC+6MG6M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7582FC116B1;
	Mon,  1 Sep 2025 14:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756737757;
	bh=pFn4aXuekiJ4nWHYjOpMDGZDzWz9r/tmySbqoG1yg7I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mC+6MG6MKObG3pHB3gNSKWuOXcHXP6+k4/P0zIYAesII+OB7A8GDc5Q77tzWfGfot
	 9SkC2lpRH6iqSmWoS6uehrohSPxbRXWiw1HqTn9oHz5NtpBdWfzlUFvCxXqzUvE5We
	 qHSIrzpC7s7Jm3KEhT/oTPtSaR5JpV4jetieNTiXginLkq90k9gIQe6BnySQr6OraZ
	 +SmnlRJo+SqU4fRSPKHEZTqC3+lbsItDveQ4M6/2DOyU6iJVp9EfNt6iSNnYzYzanv
	 jq66eQBZOJxrlnHKbmhVvt2Unq3wftH4RKRrkQDqO8E0XyMVNi9gaMD4Syz4AryMze
	 F6zweMMewWKzg==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1ut5jv-00000003G3k-36Mb;
	Mon, 01 Sep 2025 16:42:35 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 10/15] docs: Makefile: document latex/PDF PAPER= parameter
Date: Mon,  1 Sep 2025 16:42:26 +0200
Message-ID: <bbe7cdefaf969c14762359b2f96b312c33a7960b.1756737440.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1756737440.git.mchehab+huawei@kernel.org>
References: <cover.1756737440.git.mchehab+huawei@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

While the build system supports this for a long time, this was=0D
never documented. Add a documentation for it.=0D
=0D
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>=0D
---=0D
 Documentation/Makefile | 2 ++=0D
 1 file changed, 2 insertions(+)=0D
=0D
diff --git a/Documentation/Makefile b/Documentation/Makefile=0D
index 2b0ed8cd5ea8..3e1cb44a5fbb 100644=0D
--- a/Documentation/Makefile=0D
+++ b/Documentation/Makefile=0D
@@ -124,4 +124,6 @@ dochelp:=0D
 	@echo=0D
 	@echo  '  make DOCS_CSS=3D{a .css file} adds a DOCS_CSS override file for=
 html/epub output.'=0D
 	@echo=0D
+	@echo  '  make PAPER=3D{a4|letter} Specifies the paper size used for LaTe=
X/PDF output.'=0D
+	@echo=0D
 	@echo  '  Default location for the generated documents is Documentation/o=
utput'=0D
-- =0D
2.51.0=0D
=0D

