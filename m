Return-Path: <linux-kernel+bounces-645140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DD35AB4976
	for <lists+linux-kernel@lfdr.de>; Tue, 13 May 2025 04:22:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C88AA46497A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 May 2025 02:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BF5A1C3BFC;
	Tue, 13 May 2025 02:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sJrTGS1+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD57186295;
	Tue, 13 May 2025 02:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747102924; cv=none; b=VtbbEw0inlSfsgdioj20s6eMFHX6oRmoE5W+yvhpkc5h763YSPLvHGFDOcImmgegVof1adGGjQTG9crqb+HuG2VOzstT6pzM7WYL2M1dbfnp+nrSkWhTBJ9chBIp3yFvhwcLVHQGSPWnnzRd3pESEWPoDulz+EJnJIhZy8VTOxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747102924; c=relaxed/simple;
	bh=OvvDRRMFCxKSwydz4/Ws9K33Q9ka0Cl51MMbVyD9k6s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sLO84fS4ww9yZlpJtXf4LtOhYi4ezFXFydPZWV/IaCqpL0h7//45Qzu94RDwJhtjE9NhSF0LUsyjjOLyKZndoDjMHM18TyC4M7d/WU5Y78fxwKrO8FG8shrZeAxZtaRBqfySAufXqVUNiABBFYu/aqLWZegxvF+jsfv76B8nSio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sJrTGS1+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF405C4CEE7;
	Tue, 13 May 2025 02:22:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747102924;
	bh=OvvDRRMFCxKSwydz4/Ws9K33Q9ka0Cl51MMbVyD9k6s=;
	h=From:To:Cc:Subject:Date:From;
	b=sJrTGS1+T7CrtWYQCS8Q9iNKDBMudlSeenaw9XRUwq5fBtBJSs/lUkBYliRvE0v7x
	 ik1317DICw/2aAhtviM5O953+a4JUPbmebLf1KScdAOwLRwYAj8RnnwJUZzSjVLjef
	 g27J4Si+urkPMpH3w1R2MDMrbVtnL/6+tgveBFn0ucGWITPCkAIvGM8gPxP9KbDH6G
	 FgJ16jxmRJRf2Q86xT6Gd+4BgYGf0+YyqBwtz8HqsN6eFr6cVL4vlgtuqdIBY83MjN
	 LTuhOK5J8H0uIvzlpIUtDuIyBYpU8o6U8ggGCMNGavIHK6hkjvBRPEPpIAwJmpTQiV
	 i0iw8KC914hXw==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-crypto@vger.kernel.org,
	Ard Biesheuvel <ardb@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 0/2] lib/crc16: unexport crc16_table and crc16_byte()
Date: Mon, 12 May 2025 19:21:13 -0700
Message-ID: <20250513022115.39109-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series removes the only caller of crc16_byte() outside lib/crc16.c,
then folds crc16_table and crc16_byte() into lib/crc16.c.  I'm planning
to apply this to the crc tree.

Eric Biggers (2):
  w1: ds2406: use crc16() instead of crc16_byte() loop
  lib/crc16: unexport crc16_table and crc16_byte()

 drivers/w1/slaves/w1_ds2406.c | 12 ++----------
 include/linux/crc16.h         |  9 +--------
 lib/crc16.c                   |  9 ++++-----
 3 files changed, 7 insertions(+), 23 deletions(-)


base-commit: e8d72b766adcde14188e68968f3cd05f4321691d
-- 
2.49.0


