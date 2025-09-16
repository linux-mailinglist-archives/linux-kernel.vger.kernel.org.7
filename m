Return-Path: <linux-kernel+bounces-818186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AFD13B58DFF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 07:43:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 368CA1B26DDD
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 05:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B598C2DE71D;
	Tue, 16 Sep 2025 05:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bsNFmpGu"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA8D2DA76C
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 05:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758001347; cv=none; b=G4/m6AG5bZq26UTLYgSlAb0HmMvIRiF7jQb6sckW76Bw0uOSJryLdjA2BdkBMQ18iHno0ULfM545Vh0eCqvhOf+HIL6+kGjrJtNv++B17SMsgtYM3eWKOS+8U3S3oQOAiZWU0Gvqbc64pPJWTqO0TIjkrrItWkUfkwfcLjFo1uM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758001347; c=relaxed/simple;
	bh=iFycX2BAN7hX0KeER10Qq/N2vEd9PT/ZiaaR3gB9rS8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yt+bpsI1OIPjOSIf5+roC/jR2YIWbn7SYAPHis3GlXOQDdyGFJrPrYcxp9PJ4pS/Z6gBz1n2/BLQmMKXSBX2Y0vkDm6/KjQSCNIZSzxskQUpV/EWkJ7I01zA2JTg5/0RpEUGyMqT+USSHswYkJM8l46mMXWaF0PgelN6PCEu91k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bsNFmpGu; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-76e4f2e4c40so4319388b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 22:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758001345; x=1758606145; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dzt8jm8JhxQa9RfhdOFYy8EQflQhajk0iYv+kw4cn4Y=;
        b=bsNFmpGuhpveB8vqd07bVKPNvhXh0l2DosaqQLnTylV0S5jwdoTxpNkcSrzpFAUdMm
         5FiY7z4YHNNGjxtB8d/PjeYoSol3yYnW7OYDEV65Karn6shyE4xtTc9m6KRycE3cy3Ly
         w3m1Sx+qBkHuagV2Gzy/U33cfqw4aFzesuDhEYv3Dm6wHgGLDO8UKCIBx/qLAY0J8oLs
         G7kEHvdVhMhQO00jN6ZeIl4rl7uAbRMoyA2Pc5QnBfKeATzegTOTqxy+vMjOrehZEzIZ
         NzU3GEadBbTgS2fUm/uYLdHZQiHdCa3a+FZjrK6p5Pzytgr/DijgJwHkiW52XU66KSyY
         OnGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758001345; x=1758606145;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dzt8jm8JhxQa9RfhdOFYy8EQflQhajk0iYv+kw4cn4Y=;
        b=k6cYYXoU3+jYhSGoGH66XBuOqN8dpsSg6ASf6H96IUcYCX99rIGxb3bGzNfeuvd1Gp
         f8nAI6mGFO3iAtixykYC05hzunrCtgd13xML2g8fJTpsA53fFx6RuZfhoCFNmZ+DXpP2
         v0GgFhHaZL/ojSIaPbpGmdI4HwCApC7HOq3ztYEcYoQ8o3QExijrOrqKxxdYHkwl7sVd
         CaQ3TeNy9SO0bEjvu0UVmCj49J7VQWUx8/ag13VFtfX+x2Quw+ddGI2MGQYMnp89k5fe
         1T6w2oqZ6GzemmKDeWKKoEqsjcCc+/gGFLERn/ZOeKxRAFigGGWoQ31MA+sVmYPhc/bh
         LXlw==
X-Gm-Message-State: AOJu0YzNj7+wR0NVY/ovXJVOePKUFtFGgHpZEsh2KwFPhsofzruhJWpf
	vIxXdHANB/ZwhGyG+0rxBEgLUdNz2LqD8lJFEVmhAR4gyAOZ5TrvaejS
X-Gm-Gg: ASbGncuY+JtJ/g7Wdi7AM9Vr5KazCt0BCsv2XtE24iMbUiLgEDRmyzmimI59/ufFpF9
	Yghl+jKocm1Syj0QT1XY0QhWoC+qwSxfBkzjcXmLrxQsKpjtv0qMh2IHAONJRRG1w1YcBtHNBRy
	yT46xTEelYhB6OjiNi64x1YGuREXzbuuqqntfar7CgVOa4liyEgX24mk9VPpp+3ohViKtcCnNwj
	M33COBOwOtdZKZWhq1bajV/rPxe71exLrkXSzMchOraAGUXSHzjvrYIlJE4Eb0DIK6oLoNwFpgH
	ditPp+bQLYiQZLc442uTdkrfxN2ZUXPV0uEj7YlPKXhNjQYiqWsaiaS9bf+l0+cg2A9qtmpRPBs
	Vr0rs6Dws/o1K+B9o5NyxT0olPA==
X-Google-Smtp-Source: AGHT+IERvIDfQ9i3bIonnATiSRpxkSuZxnxy4IiIBGBcwTK6cxHQPmYWEwl6AsIZqqsEIp8yGjYcmQ==
X-Received: by 2002:a05:6a21:998e:b0:24a:b2eb:6675 with SMTP id adf61e73a8af0-2602a59332bmr18403353637.13.1758001345194;
        Mon, 15 Sep 2025 22:42:25 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b54dd63d5e5sm1155741a12.4.2025.09.15.22.42.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 22:42:23 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 27C9C41FA3A1; Tue, 16 Sep 2025 12:42:18 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Kernel Tracing <linux-trace-kernel@vger.kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Tom Zanussi <zanussi@kernel.org>,
	Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH v2 1/5] Documentation: trace: histogram: Fix histogram trigger subsection number order
Date: Tue, 16 Sep 2025 12:41:59 +0700
Message-ID: <20250916054202.582074-3-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250916054202.582074-2-bagasdotme@gmail.com>
References: <20250916054202.582074-2-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5050; i=bagasdotme@gmail.com; h=from:subject; bh=iFycX2BAN7hX0KeER10Qq/N2vEd9PT/ZiaaR3gB9rS8=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDBknfpglNjptrzyX3jn74zxGyanyl11lQifv9qu+If2Br +pY0t/cjlIWBjEuBlkxRZZJiXxNp3cZiVxoX+sIM4eVCWQIAxenAEzEyYCRYU76nXPz/mb+fH3F ++EcZvnZeaXh+YdVnUTyOjYsXJT8pJKR4YhJQHeT/mn5no+CkT8lPTPPnbbyWJvTt679SPPj8G0 lzAA=
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Section numbering in subsections of "Histogram Trigger Command" sections
is inconsistent in order. In particular, "'hist' trigger examples" is
erroneously numbered as 6.2, which is a leftover from  b8df4a3634e08a
("tracing: Move hist trigger Documentation to histogram.txt").

Fix the order.

Reviewed-by: Tom Zanussi <zanussi@kernel.org>
Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/trace/histogram.rst | 34 +++++++++++++++----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/Documentation/trace/histogram.rst b/Documentation/trace/histogram.rst
index af6d2e15568ebd..d158dadaa42447 100644
--- a/Documentation/trace/histogram.rst
+++ b/Documentation/trace/histogram.rst
@@ -186,8 +186,8 @@ Documentation written by Tom Zanussi
   The examples below provide a more concrete illustration of the
   concepts and typical usage patterns discussed above.
 
-'special' event fields
-------------------------
+2.1. 'special' event fields
+---------------------------
 
   There are a number of 'special event fields' available for use as
   keys or values in a hist trigger.  These look like and behave as if
@@ -204,16 +204,16 @@ Documentation written by Tom Zanussi
     common_cpu             int  the cpu on which the event occurred.
     ====================== ==== =======================================
 
-Extended error information
---------------------------
+2.2. Extended error information
+-------------------------------
 
   For some error conditions encountered when invoking a hist trigger
   command, extended error information is available via the
   tracing/error_log file.  See Error Conditions in
   :file:`Documentation/trace/ftrace.rst` for details.
 
-6.2 'hist' trigger examples
----------------------------
+2.3. 'hist' trigger examples
+----------------------------
 
   The first set of examples creates aggregations using the kmalloc
   event.  The fields that can be used for the hist trigger are listed
@@ -1608,8 +1608,8 @@ Extended error information
         Entries: 7
         Dropped: 0
 
-2.2 Inter-event hist triggers
------------------------------
+2.4. Inter-event hist triggers
+------------------------------
 
 Inter-event hist triggers are hist triggers that combine values from
 one or more other events and create a histogram using that data.  Data
@@ -1685,8 +1685,8 @@ pseudo-file.
 
 These features are described in more detail in the following sections.
 
-2.2.1 Histogram Variables
--------------------------
+2.5. Histogram Variables
+------------------------
 
 Variables are simply named locations used for saving and retrieving
 values between matching events.  A 'matching' event is defined as an
@@ -1789,8 +1789,8 @@ or assigned to a variable and referenced in a subsequent expression::
 
 Variables can even hold stacktraces, which are useful with synthetic events.
 
-2.2.2 Synthetic Events
-----------------------
+2.6. Synthetic Events
+---------------------
 
 Synthetic events are user-defined events generated from hist trigger
 variables or fields associated with one or more other events.  Their
@@ -1846,7 +1846,7 @@ the command that defined it with a '!'::
 At this point, there isn't yet an actual 'wakeup_latency' event
 instantiated in the event subsystem - for this to happen, a 'hist
 trigger action' needs to be instantiated and bound to actual fields
-and variables defined on other events (see Section 2.2.3 below on
+and variables defined on other events (see Section 2.7. below on
 how that is done using hist trigger 'onmatch' action). Once that is
 done, the 'wakeup_latency' synthetic event instance is created.
 
@@ -2094,8 +2094,8 @@ histogram::
     Entries: 7
     Dropped: 0
 
-2.2.3 Hist trigger 'handlers' and 'actions'
--------------------------------------------
+2.7. Hist trigger 'handlers' and 'actions'
+------------------------------------------
 
 A hist trigger 'action' is a function that's executed (in most cases
 conditionally) whenever a histogram entry is added or updated.
@@ -2526,8 +2526,8 @@ The following commonly-used handler.action pairs are available:
          kworker/3:2-135   [003] d..3    49.823123: sched_switch: prev_comm=kworker/3:2 prev_pid=135 prev_prio=120 prev_state=T ==> next_comm=swapper/3 next_pid=0 next_prio=120
               <idle>-0     [004] ..s7    49.823798: tcp_probe: src=10.0.0.10:54326 dest=23.215.104.193:80 mark=0x0 length=32 snd_nxt=0xe3ae2ff5 snd_una=0xe3ae2ecd snd_cwnd=10 ssthresh=2147483647 snd_wnd=28960 srtt=19604 rcv_wnd=29312
 
-3. User space creating a trigger
---------------------------------
+2.8. User space creating a trigger
+----------------------------------
 
 Writing into /sys/kernel/tracing/trace_marker writes into the ftrace
 ring buffer. This can also act like an event, by writing into the trigger
-- 
An old man doll... just what I always wanted! - Clara


