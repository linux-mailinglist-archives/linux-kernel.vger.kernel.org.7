Return-Path: <linux-kernel+bounces-799002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88F60B425BF
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 17:45:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3ADEF3AB5B1
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 15:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F7F0284884;
	Wed,  3 Sep 2025 15:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vAHRe4fo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7377C23D7E3;
	Wed,  3 Sep 2025 15:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756914298; cv=none; b=HspR/RRgm0Wtq9mHH1rypSzfTxiqwgjFgbSS6p/ECuDUItZLOxi+8Fb+BgE0rahDg8sYYTmGGc/CW9SU3gHMcW9oRNnKkRNChbutEITJ/ueauf06cGJWMbTko6sZcAec9+iN+eC0XqeZ98Qqta8+WINoWrlGCip0ypkkEu2NBCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756914298; c=relaxed/simple;
	bh=xO06wXRf41aCmpFe4aJ+1aeR28W2ul0MYKX0g34v4To=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=RmkbGY7eeFA54wrnxZ1ProfXygTtgV6dyxYX+TxelUeoxX7j53Rk+D/Dek+jbWXsH/iCkgTgsAuSOBOHQUh6UOHIJEDZUgvCZQiDW3OxtW0vQ5USCAoC5tEv9tbKNjQGqhmsTdc+4YYDgmGTmmSgHTD6F2uz7OB0z3Jn47ZMMIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vAHRe4fo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5A83C4CEE7;
	Wed,  3 Sep 2025 15:44:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756914298;
	bh=xO06wXRf41aCmpFe4aJ+1aeR28W2ul0MYKX0g34v4To=;
	h=From:To:Cc:Subject:Date:From;
	b=vAHRe4focy+UQZ74q8e4eEOFfPca/jj42MwFya3aUEDjJbqGB/vGoIqQl/ZrmictL
	 WFK9T4IYFV/deL/necvQ5Td5gr8XMI0tuZjYDS8b6xIjQvbrkqnrhZQai3x2yNbeVu
	 FTQ9JJxQd7/OoP6n0RddhS8PZUG503g+73JNx2i6SkGmmjJl6/sFZR+ZrH0HSDu8A3
	 o6F5uXup1hfFTkE0ccXPqUEXl4VaxeTKl/NXRkvzPxzwUyO20zPu2Gg0P/yDOjPNSP
	 j9UIEMujF3gNL241keOFb0RcV40ag5mBFhF1W8bCev/oV2cJzBbAy8ZD55WY2UFrvl
	 nI2pnISn3FVDw==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1utpfL-00000007N64-2cU0;
	Wed, 03 Sep 2025 17:44:55 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH RFC 0/3] Break building docs on distros where python3==python3.6 or older
Date: Wed,  3 Sep 2025 17:44:33 +0200
Message-ID: <cover.1756913837.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.51.0
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Add two patches improving python_version logic, adding two extra
optional arguments: show_alternatives and bail_out.

The third patch changes the build behavior in a way that distros
shipped with Python 3.6 like openSUSE Leap, RHEL8 and others will
break.

Personally, I'm against such patch, but based on some discussions at:

    https://lore.kernel.org/linux-doc/n4qixsp23dccgz6mtrmd2xumcngtphkbywjnxkrqpnuf2dbu2p@2sj44sbyga4j/T/#t

Several developers voiced that the best is to break the build.
So, I'll let up to the docs maintainer to decide weather or not
apply the final patch or replace by something that would avoid
such breakage.

This series is on top of the sphinx-build-wrapper patch:
    https://lore.kernel.org/linux-doc/cover.1756740314.git.mchehab+huawei@kernel.org/

Mauro Carvalho Chehab (3):
  tools/docs: python_version.py: drop a debug print
  tools/docs: python_version: allow check for alternatives and bail out
  tools/docs: sphinx-* break documentation bulds on openSUSE

 tools/docs/lib/python_version.py | 33 +++++++++++++++++++++++---------
 tools/docs/sphinx-pre-install    |  2 +-
 2 files changed, 25 insertions(+), 10 deletions(-)

-- 
2.51.0


