Return-Path: <linux-kernel+bounces-799088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD778B426D1
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 18:24:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C6161BA7510
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 16:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9536F2EA740;
	Wed,  3 Sep 2025 16:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EitJZWkA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBCC02D060D;
	Wed,  3 Sep 2025 16:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756916671; cv=none; b=tMo9+TNVnOTTnIyHhK1O6JbiByFO8bkGd6Pr9aJumQwyfardI7IER987tdkiXKKmBlEOnHtZgKvyZDaHRAQk/miS0zouiZ9kYgMD7jfTKivYETMy1F+9USiZcUNqzLpps7qsTYmaqz3FvBvhKdcv+MuyTF+GWHc6kgH/s1UP8ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756916671; c=relaxed/simple;
	bh=EaJ0dQP0cmlVTMbegDoWFh6Vv8Q18+yi45fBF9P9/DY=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ir5ARxtRATwSo0qQeispjtKiZkB7OSrGFtx9imf41n+NqQxQxKUoSkthDqIxBi/sZaHDzTIFsxsuiYgIHGo5PtXjl9UMLXcXDRIsCEokbjB/pkAALh79q0Kg52rvI43rPvzVwymtfO+A6cYJ4QmDKyAV6777/arzH9hx4MISs+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EitJZWkA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91F72C4CEF0;
	Wed,  3 Sep 2025 16:24:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756916670;
	bh=EaJ0dQP0cmlVTMbegDoWFh6Vv8Q18+yi45fBF9P9/DY=;
	h=From:To:Cc:Subject:Date:From;
	b=EitJZWkAqycrA7/+0hrtFzuV4975eCsucaS38OP40o8Iq22ZzHLGvVNRhcYgL+xk4
	 oksLJyTxzgU5rz1QarLfGlyzEk6V5KxCwGujh6pUfBY2o5RxIErHjeeMvopfPmKsph
	 1964yRHYS9H5dyGGnQBeDuQ1ZeshTxgdTJl1AGoe0Nh9FRS9jQrTpjwqVMZjZQZ9KF
	 vBs7DOB4RKKJzBguTJ9F/LJGSVuAfABnWQjx75gX8U1sn+LHROXvk8/n3xeQlgf0o8
	 vz1/Echf/nU3pS47vJv0CHWQnNl9H2c+AKMBtjaRJjX9uCuUeUMZqbyZds1kq/8lIc
	 TsOdvC0h8xhtQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1utqHc-00000007Voj-3PIB;
	Wed, 03 Sep 2025 18:24:28 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] Break building docs on distros where python3==python3.6 or older
Date: Wed,  3 Sep 2025 18:24:13 +0200
Message-ID: <cover.1756916565.git.mchehab+huawei@kernel.org>
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

---

v2:
- I forgot to merge some hunks at the last patch;
- I ended modifying the logic: it now provides a hint at the broken
  distros, showing how to call sphinx-build-wrapper directly to
  override the python3 version.

Mauro Carvalho Chehab (3):
  tools/docs: python_version.py: drop a debug print
  tools/docs: python_version: allow check for alternatives and bail out
  tools/docs: sphinx-* break documentation bulds on openSUSE

 tools/docs/lib/python_version.py | 45 +++++++++++++++++++++++++-------
 tools/docs/sphinx-build-wrapper  |  3 ++-
 tools/docs/sphinx-pre-install    |  3 ++-
 3 files changed, 39 insertions(+), 12 deletions(-)

-- 
2.51.0


