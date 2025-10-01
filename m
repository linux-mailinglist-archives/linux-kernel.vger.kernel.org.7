Return-Path: <linux-kernel+bounces-839077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C98DBB0C2F
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 16:45:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06E1717C81D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 14:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDC1F264FB5;
	Wed,  1 Oct 2025 14:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lLPRAWme"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447A7258EFB
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 14:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759329887; cv=none; b=jRalFUeoJthEX/ADTo/ZPtEsqJnamZaS5CyV/IdNPuClHqB6My6wQUJqKKp8dH80tmDf5eg39ke0w3PT4xqC6cOFlCXrlwtEw8iJLpKdKeUqXBFZsRBJTmmUc/tRm1H2wWnvbaIZhlwIxJEQxrQos4WAvvjGZOef/GEsdZ6lCa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759329887; c=relaxed/simple;
	bh=XKgCqZSvIYQgNJ5rq66ADbyY0CMrNzf0QFZZC/1zHjk=;
	h=Message-ID:Date:From:To:Cc:Subject; b=cB9Tf1EgQy3Q//6dfFM6xHIGtcc95gseeiZeJ0xLLuQfQvmLt5DIHxD7BA1+q2nvxYX0r4noQRMP0/T0euf2uh0BrYjW0s3fWzEMUu9t5RSD8tjCt7066pSgNGsY9CMgoyJQPwLLpOaYHhe43uEnY2JAdSwMl+4/sJhC89LuTnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lLPRAWme; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF0E6C4CEF1;
	Wed,  1 Oct 2025 14:44:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759329886;
	bh=XKgCqZSvIYQgNJ5rq66ADbyY0CMrNzf0QFZZC/1zHjk=;
	h=Date:From:To:Cc:Subject:From;
	b=lLPRAWme7zGFpNd0rLnPR7bphi6RMT5ANP4odtT/Vh0WvppDklHc3vtnAsbOYZvyS
	 fxVHxVXtN+teVoSyJ7TT9EVePbGNT7JFNMl/ra2/n/QcmOcySXHS0KqpB1FQWY/CRZ
	 eEEqaa656UBbcQ584Df7WPIbB52aijPQqjRcAw/nO0DtPDp1CU433+MayR5aLx5C6/
	 B6lo7+XklPwH4310SbcHPyT7S/0G8weEjwG3YRXj1qsvgGr2tY8E4fI0106UiqlSBr
	 5Ub5uOqBgPDMArwKE0PYE8pG83ybBqa7/OSyM6c+9Y5cK3uuOtDL2u+EOkr0SFpep8
	 V5U7qgNEv92Ew==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1v3y64-0000000Eb0J-3Xdy;
	Wed, 01 Oct 2025 10:46:24 -0400
Message-ID: <20251001144605.585204794@kernel.org>
User-Agent: quilt/0.68
Date: Wed, 01 Oct 2025 10:46:05 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 0/4] tracing: Removed unused tracepoints for v6.18
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
unused-tracepoints/for-next

Head SHA1: 7b4321deeaabdc97f39da7fcdd6e61767e1cd29c


Steven Rostedt (4):
      cdns2: Remove unused tracepoints
      cdns3: Remove unused tracepoints
      cdnsp: Remove unused tracepoints
      cfg80211: Remove unused tracepoints

----
 drivers/usb/cdns3/cdns3-trace.h            | 61 --------------------------
 drivers/usb/cdns3/cdnsp-trace.h            | 25 -----------
 drivers/usb/gadget/udc/cdns2/cdns2-trace.h | 69 ------------------------------
 net/wireless/trace.h                       | 56 ------------------------
 4 files changed, 211 deletions(-)

