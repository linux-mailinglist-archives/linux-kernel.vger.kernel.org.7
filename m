Return-Path: <linux-kernel+bounces-775332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F12CEB2BE07
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 11:51:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91A6D680AD7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 09:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4379A319864;
	Tue, 19 Aug 2025 09:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="eRa2u3kS"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8ED5131E2D
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 09:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755597104; cv=none; b=Tpn1lMe+8Wim+mGdv+7eCWfL/4fRUd8CqWHMRIB+7a94zCvlO/Iueaaa6HNNyqZGhCsBXTXYLWVHDSUGynNk4KlKNk7jEDTpou53QnppXLWYKoQOKorVY7rRnintkUD9mPel7uU7lXM8eAxLqxIHtH5L/LIynAub+Y55eMBkWn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755597104; c=relaxed/simple;
	bh=kV8MiKDjIo0i5XbSCzfHUQUqmAmJZoF4aIfBpBqUsyU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T/KVXHjuiIlQUFVjSVU8YQ1zEf5iEbGz7LTNwZ+6qk5THoQNiaFG5jZXmxn9ivUcecvwX65qu453DXNi6wUaPTwtFSiYZx/obS8FbCT95c/LAayK+gSzJNm1BgX828GeNJ1MTsNC4tujdJi1sXbL3x5iN8uLztyzMZSrevJUC6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=eRa2u3kS; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-afcb7a0442bso750343066b.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 02:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1755597100; x=1756201900; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qpb+PaLPuvJxAShaZZMU5rp6ga8uI33SULth7K0pEPs=;
        b=eRa2u3kSdyJ8xqKebd5BUp6NvMpssPyKcXN5lu0VOFqEQ5eu1M0vFbccs5dF9kga6t
         p0YmF/lMdymiHWxw33aNOGCJQ08y9bM26QXqPMEW0WjPSd/jEnIrczihLtZxI/n/2gkj
         kQFpvW/QAC6J+j5RQczrpzi3rV8UPDP5grCZFkU9as2eckzaZS+WkVqz16ullasB1eVA
         HORr9xXB5HQnm13OuIvpdeVEYgfvseSOGJD+3m08MbW6RMbW+Mmz1RhHUrYvjplWqcNM
         riNwfozr/0cXQmU1N8rq4YjM+nOXXmWknsKsC6sYa4kqgCax8jqDpBShS/kr2cLqtPNm
         FOGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755597100; x=1756201900;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qpb+PaLPuvJxAShaZZMU5rp6ga8uI33SULth7K0pEPs=;
        b=lYm9y4uWtfeB+w6wX82uI4zuC2uFqBRGgJDgoWEsbL5hxcy2729GqTgDnY8cDKOAuU
         FDxI0LZuPU17nKsaeH+bEIx6BYxy2t/a9blK8aE8AaGBCJ+BI6WBLHDDP/pg8JpJnGOW
         ScCbgUGBiDJRhYeZ7T6LNFk88wFU4bM/G/SBuB0RouLdQK9cubGkUVS5DOWA0jLOjkuE
         IuFYRNjhXZMZlFxJca6PFsVd/5TBeg3nCKd9rMwEjylzR/nfOqSO9Mhov4QPt/u5gzBD
         z3J1nUMe5SYTyiZHW6S334Zx+e5rki8WYKSOzZRSCwqvzJrXB+J6g25HqqDVJKEmxv+k
         JZ5g==
X-Forwarded-Encrypted: i=1; AJvYcCUyuLDlPiE0NI4Bf6jAfrT80aRJG2xBdaJcKZjag+R4FHuqRLKR81HlFxj0Fo0T88dh71oE3qDEdfB9+rM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFUCt9g26BOXLxPhZJ5SyiQJh/OOuT4VqwPnTEAAXq7WN9cWQk
	32MAMc6oNFk9d/kioBS7IZfbKxWy+rjDxWhxTbZshcM6Mq8GlRdx6kQjRoOfaN8JYLY=
X-Gm-Gg: ASbGncud6TUNpc6AVoMqOIk2lMjYxrdeF0GurPxVW96WetAIaY58md6IA9wuiYvn9d/
	eCHJy8IYhiveSNZU/H34vCn5U3HL89Fsm2FCrfOXYB4lSplzZK8sfQZD6eeUACeI1q4yTD1FeNY
	BQ1L8qMbwgqqAv2nsQ0FuqgSNAWrfAUJVHYkMt12RSEVuLZNKbaWCxwid/QpjRR5yvG4uruMrRZ
	CnGhQyA3wRrmEv6VtwNWL/QijrvFog8jufct9pz/Md3BcGIFCwU63+4+18xtqHQJcGtb3pV5UjN
	9fVOkcRvcPRY1FPRpg1zj+lSF2FuQypNnAqW0bNYK3XPPd1r80VPpxcFXqGE5DSesY04GGwqt/W
	7gUi9bNqvAiVqhYzCHsCn22bg5g==
X-Google-Smtp-Source: AGHT+IHZRwFrrAbq1jt158Uor2ug2BrkxZjZgkOG4U84WIS+uPiwrXUARGkxE6OZq3PDaTyeCuWg9Q==
X-Received: by 2002:a17:907:7e9b:b0:af9:479b:8caf with SMTP id a640c23a62f3a-afddd1e974emr166668666b.51.1755597099900;
        Tue, 19 Aug 2025 02:51:39 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afcdcfcce69sm958756766b.82.2025.08.19.02.51.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 02:51:39 -0700 (PDT)
Date: Tue, 19 Aug 2025 11:51:37 +0200
From: Petr Mladek <pmladek@suse.com>
To: Feng Tang <feng.tang@linux.alibaba.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Lance Yang <lance.yang@linux.dev>, Jonathan Corbet <corbet@lwn.net>,
	linux-kernel@vger.kernel.org, paulmck@kernel.org,
	john.ogness@linutronix.de
Subject: [PATCH] panic: Clean up message about deprecated 'panic_print'
 parameter
Message-ID: <aKRJKZHgcxyNF3y7@pathway.suse.cz>
References: <20250815071428.98041-1-feng.tang@linux.alibaba.com>
 <20250815071428.98041-4-feng.tang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250815071428.98041-4-feng.tang@linux.alibaba.com>

Remove duplication of the message about the deprecated 'panic_print'
parameter.

Also make the wording more direct. Make it clear that the new
parameters already exist and should be used instead.

Signed-off-by: Petr Mladek <pmladek@suse.com>
---
This can be used as a follow up patch.
Or feel free to squash it into the 3rd patch.

kernel/panic.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/kernel/panic.c b/kernel/panic.c
index 12a10e17ab4a..d3907fd95d72 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -122,10 +122,15 @@ static int proc_taint(const struct ctl_table *table, int write,
 	return err;
 }
 
+static void panic_print_deprecated(void)
+{
+	pr_info_once("Kernel: The 'panic_print' parameter is now deprecated. Please use 'panic_sys_info' and 'panic_console_replay' instead.\n");
+}
+
 static int sysctl_panic_print_handler(const struct ctl_table *table, int write,
 			   void *buffer, size_t *lenp, loff_t *ppos)
 {
-	pr_info_once("Kernel: 'panic_print' sysctl interface will be obsoleted by both 'panic_sys_info' and 'panic_console_replay'\n");
+	panic_print_deprecated();
 	return proc_doulongvec_minmax(table, write, buffer, lenp, ppos);
 }
 
@@ -944,13 +949,13 @@ core_param(panic_console_replay, panic_console_replay, bool, 0644);
 
 static int panic_print_set(const char *val, const struct kernel_param *kp)
 {
-	pr_info_once("Kernel: 'panic_print' parameter will be obsoleted by both 'panic_sys_info' and 'panic_console_replay'\n");
+	panic_print_deprecated();
 	return  param_set_ulong(val, kp);
 }
 
 static int panic_print_get(char *val, const struct kernel_param *kp)
 {
-	pr_info_once("Kernel: 'panic_print' parameter will be obsoleted by both 'panic_sys_info' and 'panic_console_replay'\n");
+	panic_print_deprecated();
 	return  param_get_ulong(val, kp);
 }
 
-- 
2.50.1


