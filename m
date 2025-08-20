Return-Path: <linux-kernel+bounces-778661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AF4DCB2E898
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 01:21:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E94367A3803
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 23:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A8CD2DD5F7;
	Wed, 20 Aug 2025 23:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b2i41nOj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C96AF2BE64E
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 23:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755732093; cv=none; b=UFRtEKZGVpQrKuofzNuTJNkJ8LjqMyTn9o+HeBJ+vsvmY4rxCawbYvDXQ3Xpk1Q/1vURFlPed6oYZxNdy1k1/vVuEyzRU3sgzph0bpXqmA93c8bB5kuBVW1vroCJ7XUIm0+nM4xfV3q+5nGKprbvp8LcwyzfB0sx+PQ9Ildu764=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755732093; c=relaxed/simple;
	bh=ymsdJ6IK7r1hXd24EeDQLwhyl3ipQ58T0tvmvbbq60Y=;
	h=Date:From:To:Cc:Subject:Message-Id:Mime-Version:Content-Type; b=P3KHMavevdXBDLLpe07YoD/y+nQmdkuDf/UeL8AE7Xb/be8P+RAYsGoM4vJRufrxMlzifxNoqRydzPpDNOEPrDPfYOkM9QYVqnbAMsDKlAI/JDPqpup7Ko55pbITIejXtacuNFmHbaBazlcavev7yPIrJTk6wDgrtxTzWkRs9zA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b2i41nOj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1193FC4CEE7;
	Wed, 20 Aug 2025 23:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755732093;
	bh=ymsdJ6IK7r1hXd24EeDQLwhyl3ipQ58T0tvmvbbq60Y=;
	h=Date:From:To:Cc:Subject:From;
	b=b2i41nOjVt+e6ilRB/vpr/MEN+grmcLlNtfCWOIKWdS3oVJ2ueqwcCioPh0rQQapL
	 7mXEx8CUyC3FHMF8k/aNDyHfNFgpbR/2iSoRLjHpqgZoZd5PqktJ5osf1Jz0vL4991
	 2VfkJ/NjyKzG5a6bq5j8udfi/Xd/bt8NcKbONXgYMVD0n8hkq/Rej641jiOxw0dQHw
	 pn1uqVB2eobrIB12xL9TF4ETdrNT6lGjEnlu6wFKO/QwbjhPUy9Xwuq7IlGbKff9n3
	 OWR80Un+tc0PSxBPJpoHGGV1vqwdY80LfOeYB/pPWlS92Z4m7OJFVGR3fSB7SrQ+3t
	 19GBIDlofEZrg==
Date: Thu, 21 Aug 2025 08:21:29 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Masami Hiramatsu (Google) <mhiramat@kernel.org>, Steven Rostedt
 <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 linux-kernel@vger.kernel.org
Subject: [GIT PULL] probes: Fixes for v6.17-rc2
Message-Id: <20250821082129.f12b601c3263e2fd3324b618@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Linus,

Probes fixes for v6.17-rc2:

- tracing: fprobe-event: Sanitize wildcard for fprobe event name
  Fprobe event accepts wildcards for the target functions, but
  unless the user specifies its event name, it makes an event with
  the wildcards. Replace the wildcard '*' with the underscore '_'.


Please pull the latest probes-fixes-v6.17-rc2 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
probes-fixes-v6.17-rc2

Tag SHA1: 79f2c8d9a0956a85dadb6c8cd1c972e87777969b
Head SHA1: ec879e1a0be8007aa232ffedcf6a6445dfc1a3d7


Masami Hiramatsu (Google) (1):
      tracing: fprobe-event: Sanitize wildcard for fprobe event name

----
 kernel/trace/trace.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
---------------------------
commit ec879e1a0be8007aa232ffedcf6a6445dfc1a3d7
Author: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Date:   Sat Aug 16 23:10:51 2025 +0900

    tracing: fprobe-event: Sanitize wildcard for fprobe event name
    
    Fprobe event accepts wildcards for the target functions, but unless user
    specifies its event name, it makes an event with the wildcards.
    
      /sys/kernel/tracing # echo 'f mutex*' >> dynamic_events
      /sys/kernel/tracing # cat dynamic_events
      f:fprobes/mutex*__entry mutex*
      /sys/kernel/tracing # ls events/fprobes/
      enable         filter         mutex*__entry
    
    To fix this, replace the wildcard ('*') with an underscore.
    
    Link: https://lore.kernel.org/all/175535345114.282990.12294108192847938710.stgit@devnote2/
    
    Fixes: 334e5519c375 ("tracing/probes: Add fprobe events for tracing function entry and exit.")
    Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
    Cc: stable@vger.kernel.org

diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 1dbf1d3cf2f1..5a6688832da8 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -2204,7 +2204,7 @@ static inline bool is_good_system_name(const char *name)
 static inline void sanitize_event_name(char *name)
 {
 	while (*name++ != '\0')
-		if (*name == ':' || *name == '.')
+		if (*name == ':' || *name == '.' || *name == '*')
 			*name = '_';
 }
 
-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

