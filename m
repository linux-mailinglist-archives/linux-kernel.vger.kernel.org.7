Return-Path: <linux-kernel+bounces-771583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 887CFB28915
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 02:09:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FEB21C26A48
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 00:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 906AE1EB36;
	Sat, 16 Aug 2025 00:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jsInXGsL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7FDEBA34;
	Sat, 16 Aug 2025 00:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755302920; cv=none; b=Bw8y+3qupvOVKs57OWDIwZ/yxJAyIHU5C7yuWtLgh+7pqygpBa2fIyTu48jIQPmGohusxKYd4jI47IZ1OyylfXA+DU6hPBkvq4X0GbiYaCRJfcErJ/NVXndz2LeU23VruULLmZO1UR4n/COP4wnMFQr1jo0FFGZd3fAbC2sDiVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755302920; c=relaxed/simple;
	bh=Cz/f8Ty/4zEpoYFihblKVOHBZS+Lk96uBujFwo+m+CE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tF/D4iHWkN7Suo81jfhLpoz6dTI++YsMQtpzIhckxJxv15jrzyXlHCDdugqpCnnqtc8jPD6i3YPFwoqK4yEKEOgCP33eEOYfxJjlwQ/ZGflI9uuP6M+B4Cqw55dDKOVLkcsSZOqSNNV+SE7TQvtQ5h6OWV7Ggv/77dDS4Y7h/b8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jsInXGsL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C45D5C4CEF4;
	Sat, 16 Aug 2025 00:08:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755302919;
	bh=Cz/f8Ty/4zEpoYFihblKVOHBZS+Lk96uBujFwo+m+CE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jsInXGsLds1XZgK9YBZhDhWGF4mWsIneIeS/iJc0bc0KldbayRMjl+Q7lHj7H8JkD
	 EKC7wGB8/CZYZpdtdfoQWYWamtiZs6IeGMj4AURiwAJYiQyZuZCw/bWO3qXO7U+4iy
	 9VPN5YM4ScEalZxQH5eJQJ77vPxBugPRvgGjK7Ec5mIZnKblAigyR+U/SziI6RmIap
	 R4OL4m1H/lPB5iYcrFVNBxXUHhIyONtLDG9o2Kt18jK/R0EOQpo2CugCd9OFfU3Pgm
	 xMkQefspbkPweRq4TGTnsebPUIw8/Z7vPjzsuvdImUtjb8OyIZ/eDgfIf7+dQKkhDt
	 g0xVXScL917ig==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 1573FCE0B30; Fri, 15 Aug 2025 17:08:39 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH 2/7] torture: Add --do-normal parameter to torture.sh help text
Date: Fri, 15 Aug 2025 17:08:32 -0700
Message-Id: <20250816000837.2622858-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <8758bcc6-901f-4828-b2fc-aa9f90e85451@paulmck-laptop>
References: <8758bcc6-901f-4828-b2fc-aa9f90e85451@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The --do-normal parameter was missing from the torture.sh script's help
text, so this commit adds it.  Hopefully better late than never!

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/torture.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/rcutorture/bin/torture.sh b/tools/testing/selftests/rcutorture/bin/torture.sh
index 611bc03a8dc705..a33ba109ef0b7f 100755
--- a/tools/testing/selftests/rcutorture/bin/torture.sh
+++ b/tools/testing/selftests/rcutorture/bin/torture.sh
@@ -94,6 +94,7 @@ usage () {
 	echo "       --do-kvfree / --do-no-kvfree / --no-kvfree"
 	echo "       --do-locktorture / --do-no-locktorture / --no-locktorture"
 	echo "       --do-none"
+	echo "       --do-normal / --do-no-normal / --no-normal"
 	echo "       --do-rcuscale / --do-no-rcuscale / --no-rcuscale"
 	echo "       --do-rcutasksflavors / --do-no-rcutasksflavors / --no-rcutasksflavors"
 	echo "       --do-rcutorture / --do-no-rcutorture / --no-rcutorture"
-- 
2.40.1


