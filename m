Return-Path: <linux-kernel+bounces-755261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 11C2DB1A3C5
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 15:47:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7140D7AA4ED
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 13:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 309ED25A2A1;
	Mon,  4 Aug 2025 13:47:27 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2681EE7D5;
	Mon,  4 Aug 2025 13:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754315246; cv=none; b=HorgUDX0N97j/caSqMSVede8ZMOpLbFboWsg9qwYyRZ/lEGq6ICW+fP/6RG1ID0EnD50X0WDVh0byzF8LgLkKjR+qUOM58b30zMrX2CfoipRRkYiolwzEVVPZCEmK8SVYGBYWpnUuw0CDa6cnwEWAk8oBoVAJzuk/8iipaQ5uBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754315246; c=relaxed/simple;
	bh=gvn2x9hOtJ2VolVLuFcGrVA90rDghqIZVjCylDB+ofk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=k0b+x0zRKEp/rOfok527NhddLJV7UpJshs5gBmHrpBmq1WGcAb7MvPs0NgO4MX+vy590e2UHs7tAhOO/FDLJ6aGrMwsmiD2dxI3IiJ8XIX9qMYWYGSGIKX2niEPism9Ps2VBGnFD9+HWw1dsJZEVtrHt3v0ZTbgf+dXG5ar0n34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4bwdCY12tVzKHMml;
	Mon,  4 Aug 2025 21:47:21 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 2B3581A0B8F;
	Mon,  4 Aug 2025 21:47:20 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgAHgxPjuZBoXT8zCg--.8001S4;
	Mon, 04 Aug 2025 21:47:16 +0800 (CST)
From: Wang Zhaolong <wangzhaolong@huaweicloud.com>
To: sfrench@samba.org,
	pshilov@microsoft.com
Cc: linux-cifs@vger.kernel.org,
	samba-technical@lists.samba.org,
	linux-kernel@vger.kernel.org,
	chengzhihao1@huawei.com,
	wangzhaolong@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH 0/4] Fix mid_q_entry memory leaks in SMB client
Date: Mon,  4 Aug 2025 21:40:02 +0800
Message-Id: <20250804134006.3609555-1-wangzhaolong@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAHgxPjuZBoXT8zCg--.8001S4
X-Coremail-Antispam: 1UD129KBjvJXoWxAr1rGr48ur4kWFy8JF4fXwb_yoWrWw4UpF
	Waga43Gw18Jr93Zwn3Jay8Aa4rAwn5CF13GFW7Kw1Sy3W5uF1Fqrn7tr1FgFWxArWkXr1j
	qw4jyr4j93WDZFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkC14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_
	Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIY
	rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14
	v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWx
	JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUonmRUU
	UUU
X-CM-SenderInfo: pzdqw6xkdrz0tqj6x35dzhxuhorxvhhfrp/

I've been investigating a pretty nasty memory leak in the SMB client. When
compound requests get interrupted by signals, we end up with mid_q_entry
structures and server buffers that never get freed[1].

User foreground process                    cifsd
cifs_readdir
 open_cached_dir
  cifs_send_recv
   compound_send_recv
    smb2_setup_request
     smb2_mid_entry_alloc
      smb2_get_mid_entry
       smb2_mid_entry_alloc
        mempool_alloc // alloc mid
        kref_init(&temp->refcount); // refcount = 1
     mid[0]->callback = cifs_compound_callback;
     mid[1]->callback = cifs_compound_last_callback;
     smb_send_rqst
     rc = wait_for_response
      wait_event_state TASK_KILLABLE
                                  cifs_demultiplex_thread
                                    allocate_buffers
                                      server->bigbuf = cifs_buf_get()
                                    standard_receive3
                                      ->find_mid()
                                        smb2_find_mid
                                          __smb2_find_mid
                                           kref_get(&mid->refcount) // +1
                                      cifs_handle_standard
                                        handle_mid
                                         /* bigbuf will also leak */
                                         mid->resp_buf = server->bigbuf
                                         server->bigbuf = NULL;
                                         dequeue_mid
                                     /* in for loop */
                                    mids[0]->callback
                                      cifs_compound_callback
    /* Signal interrupts wait: rc = -ERESTARTSYS */
    /* if (... || midQ[i]->mid_state == MID_RESPONSE_RECEIVED) *?
    midQ[0]->callback = cifs_cancelled_callback;
    cancelled_mid[i] = true;
                                       /* The change comes too late */
                                       mid->mid_state = MID_RESPONSE_READY
                                    release_mid  // -1
    /* cancelled_mid[i] == true causes mid won't be released
       in compound_send_recv cleanup */
    /* cifs_cancelled_callback won't executed to release mid */

The core issue is a race condition where cifs_cancelled_callback never
gets a chance to run, so cleanup never happens. I've spent quite a bit
of time trying to understand how to fix this safely.

Honestly, my first instinct was to just patch the callback assignment
logic directly. But the more I dug into it, the more I realized that
the current locking scheme makes this really tricky to do safely. We
have one big lock protecting multiple different things, and trying to
fix the race condition directly felt like playing with fire.

I kept running into scenarios where a "simple" fix could introduce
deadlocks or new race conditions. After looking at this from different
angles, I came to the conclusion that I needed to refactor the locking
first to create a safe foundation for the actual fix.

Patches 1-3 are foundational refactoring. These three patches rename
locks for clarity, separate counter protection from queue operations,
and replace the confusing mid_flags bitmask with explicit boolean
fields. Basically, they untangle the current locking mess so I can
implement the real fix without breaking anything.

The 4th patch in the series is where the real fix happens. With
the previous refactoring in place, I could safely add a lock to each
mid_q_entry and implement atomic callback execution. This eliminates
the race condition that was causing the leaks.

In summary, my approach to the fix is to use smaller-grained locking to
avoid race conditions. However, during the implementation process,
this approach involves more changes than I initially hoped for. If
there's a simpler or more elegant way to fix this race condition that
I've missed, I'd love to hear about it. I've tried to be thorough in
my analysis, but I know there are folks with more experience in this
codebase who might see a better path.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=220404 [1]

Wang Zhaolong (4):
  smb: client: rename server mid_lock to mid_queue_lock
  smb: client: add mid_counter_lock to protect the mid counter counter
  smb: client: smb: client: eliminate mid_flags field
  smb: client: fix mid_q_entry memleak leak with per-mid locking

 fs/smb/client/cifs_debug.c    | 12 ++++--
 fs/smb/client/cifsglob.h      | 23 +++++++-----
 fs/smb/client/connect.c       | 57 +++++++++++++++++-----------
 fs/smb/client/smb1ops.c       | 23 ++++++++----
 fs/smb/client/smb2ops.c       | 69 ++++++++++++++++++----------------
 fs/smb/client/smb2transport.c |  5 ++-
 fs/smb/client/transport.c     | 71 +++++++++++++++++++----------------
 7 files changed, 150 insertions(+), 110 deletions(-)

-- 
2.39.2


