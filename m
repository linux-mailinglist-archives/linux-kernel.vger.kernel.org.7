Return-Path: <linux-kernel+bounces-753166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AF3F2B17F6F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 11:36:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 984977B537F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 09:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59E8622CBC6;
	Fri,  1 Aug 2025 09:34:41 +0000 (UTC)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1968322D786
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 09:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754040880; cv=none; b=eDhEM1Bz531/vjiPrSXqkV9EFbvp+oBwPeE+6Ke1nl5cnCv83/hDkJysjMZOa+ebs+8PyvqeuImCkfN//mGQyt9r5+2m6m2HHx1mlYDJJwJxwEXfmtx/mBeLQfOaoEoz/ZtfX13lRoH9WgSp4HOU2hJTI+62SIp5nlpMgOTVCfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754040880; c=relaxed/simple;
	bh=eLYoWgXyS7q+zymmSF2I97MJ8/BJFJ8m+MpuoftRZrc=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=fGgalg3ctjy7xUcpH0NB9zLsIJtkk/gYi/mlymWdktmSGsLH3B3IVUsq2dLz2KIX++wfEoBDSppvCiO25IqGZXvTOORC/Peyz4qwF6kjgeCWxpplte4QQ7Mmu1qxYYLleHzv54RJQvUbyYrwCtmDaDACjaEOwH1MdEbJb9o19Zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-454f428038eso12642175e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Aug 2025 02:34:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754040876; x=1754645676;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FILnsYkBqkvoKy9CR4yxwTy8MXJBPEpnT14mqZYoO8M=;
        b=WSJc/GgGvCczqz98e2k6Y+hlINp2JhBpgWvqiryG+qnvbqe7ntmyqHF/uZ8DtpyyLw
         8imZB9kxCnOdEw2rKfIBp4Z9EcCxyTBpugsmslerjh0VWO5Od3SpQik+eO5DFneBmUen
         cRnlRu/AH/uKIweL4zbq45E2xStlz6VW6HepNs2Cwst5EXhg6nZCFWQxYxhW8wylwuwR
         mcgkdLbpnHaaCCSBVJKL0vC/kjbGFAsVulytS5YZS2u/LA0q28/QA2V1h8RxopxNPp9C
         PNqZf+1RZwuGFZDRWFbIsPqDpQEdnncLKuQ/xT3rkKs+3ltSjdBVxAMcMXxerG8MnsvU
         60Ew==
X-Gm-Message-State: AOJu0YxASq5SBZL+LxzvAjUkHrI0tW470JdqIWECRyGi47Jor6nEm0ju
	6uJddkLlaehczapp9AS9kS0NnTlnhQyq+0IcF9xPkfX1ECjDejLmCfgaCHbBVQ==
X-Gm-Gg: ASbGncsMp9hmzfNNF5U13vxj82gExfX6R+oXZUyvMdHXhoSmgyvbJcEm4f1fE8HOdVL
	0EKMBwXM0Irkwaumiu8RDP72WK6Tnf95HwlG2Sk6hyC3kxXzcxDpOZJay4fjaKkvDrrd2/KamTv
	9j369Fc75iiumJNf9j/2qYQdjkRO4VoMTKKJd/qEXy4L1EjvkTe5x48vRvJ3rdTUKbEcHKsAmG3
	RBDbpAeje39NfCnwsMl5c67gCzT1AvBxhE+/777rowj6wwkKYWqEbWXH/sIDqIwFkaUEoFoZ6fN
	pDrdX3nlIkuVYfux6+8SUTDoBkX5XfZfe5SVXXNZNxCnWHEYlWRlyfMaetjmczoeyqSrTA/M5GS
	UeAsxk/SXSwLAeAFlENZyT1NtedA75Ibt0CFgxNkEC0mFIwyAAHJS2DIfWfvYpr73OhdE7g1gR2
	tn39awiorv
X-Google-Smtp-Source: AGHT+IEx26GTyTeV7UqTBTcD0yrUFM6lJfcf81YmMLBZZ2BTy+3czlzjK8pyCTLto081NB9eDog9pg==
X-Received: by 2002:a05:600c:310d:b0:450:d01f:de6f with SMTP id 5b1f17b1804b1-458aa32e7a4mr16743345e9.15.1754040875850;
        Fri, 01 Aug 2025 02:34:35 -0700 (PDT)
Received: from [192.168.1.101] (croy-25-b2-v4wan-169464-cust2304.vm24.cable.virginm.net. [92.236.41.1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-458a7c91c0esm36150775e9.11.2025.08.01.02.34.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Aug 2025 02:34:35 -0700 (PDT)
Message-ID: <6dec5463-3ef5-4085-ad4f-6c2792f85ace@linux.com>
Date: Fri, 1 Aug 2025 10:34:34 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 kernelnewbies@kernelnewbies.org
From: Lucas Tanure <tanure@linux.com>
Subject: Linux Device Performance Analyses - Where are my cylces?
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hey there,

I'm a kernel developer working on an Android device with a 5.10 kernel. 
I'm trying to improve performance, and to do that, I need to figure out 
exactly where the CPU is spending its time.

Our vendor provides a generic Android BSP, so the system is likely 
running many unnecessary processes for things like GPS and phone calls 
that my device doesn't even need. Since I don't have a good handle on 
all these processes, I want to create a detailed breakdown of all the 
tasks, workqueues, IRQs, kernel threads, softIRQs, and tasklets running 
and measure the CPU time each one is using.

To do this, I've been using kernel traces with the following events:

task:task_newtask sched:sched_process_fork
sched:sched_process_exec sched:sched_process_exit sched:sched_switch 
irq:irq_handler_entry irq:irq_handler_exit irq:softirq_entry 
irq:softirq_exit workqueue:workqueue_execute_start 
workqueue:workqueue_execute_end syscalls:sys_enter_execve 
syscalls:sys_exit_execve syscalls:sys_enter_execveat 
syscalls:sys_exit_execveat

However, the trace logs don't provide the full picture. For example, 
when a new process is executed, the logs don't specify the script being 
run. The sched_switch event tells me which PID is being executed, but 
multiple processes can originate from the same binary, so it's hard to 
distinguish them.

To solve this, I've developed a patch for the do_execveat_common 
function to log all new processes along with their full command lines. I 
plan to use this patch with a Python script to parse the logs and 
generate a report on CPU usage.

My main questions are:

- Is my patch correct? When I log the new process, do current->pid and 
argv refer to the same new process?
- It feels like logging new processes with their command lines is a 
fundamental requirement for this kind of analysis. Am I missing a better 
or more standard way of doing this?
- I don't want to reinvent the wheel, so if there's a better way to 
analyze kernel performance on a device, I'd love to hear about it.

After looking into other methods like eBPF and kprobes, I found that 
this patch is the most straightforward way to get the information I need.

Any insights would be greatly appreciated!

Thanks
Lucas Tanure

diff --git a/fs/exec.c b/fs/exec.c
index 6e1f8628ab9c..ab797ba0571c 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -513,6 +513,49 @@ static int bprm_stack_limits(struct linux_binprm *bprm)
  	return 0;
  }

+static char* str_cmdline(int argc, struct user_arg_ptr argv, struct 
linux_binprm *bprm)
+{
+	char *buf = (char *)get_zeroed_page(GFP_KERNEL);
+	ssize_t pos = 0;
+	int arg;
+
+	for (arg = 0; arg < argc; arg++) {
+		const char __user *str;
+		int len;
+
+		str = get_user_arg_ptr(argv, arg);
+		if (IS_ERR(str))
+			goto free_page;
+
+		// this includes a final null.
+		len = strnlen_user(str, MAX_ARG_STRLEN);
+		if (!len)
+			goto free_page;
+
+		if (!valid_arg_len(bprm, len))
+			goto free_page;
+
+		if (pos + len >= PAGE_SIZE)
+			break; // Return the command line up to a page
+
+		len -= 1; // Don't copy the final null.
+		if (copy_from_user(buf+pos, str, len))
+			goto free_page;
+
+		pos += len;
+
+		if (arg < argc - 1)
+			buf[pos++] = ' ';
+	}
+
+	return buf;
+
+free_page:
+	free_page((unsigned long)buf);
+
+	return NULL;
+}
+
  /*
   * 'copy_strings()' copies argument/environment strings from the old
   * processes's memory to the new process's stack.  The call to 
get_user_pages()
@@ -1874,6 +1917,7 @@ static int do_execveat_common(int fd, struct 
filename *filename,
  {
  	struct linux_binprm *bprm;
  	int retval;
+	char *cmdline;

  	if (IS_ERR(filename))
  		return PTR_ERR(filename);
@@ -1943,6 +1987,15 @@ static int do_execveat_common(int fd, struct 
filename *filename,
  		bprm->argc = 1;
  	}

+	cmdline = str_cmdline(bprm->argc, argv, bprm);
+	pr_info("%s pid: %d, comm: %s # filename: %s # cmdline: %s\n", __func__,
+								       current->pid,
+								       current->comm,
+								       bprm->filename,
+								       cmdline ? cmdline : "NULL");
+	if (cmdline)
+		free_page((unsigned long)cmdline);
+
  	retval = bprm_execve(bprm, fd, filename, flags);
  out_free:
  	free_bprm(bprm);

