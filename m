Return-Path: <linux-kernel+bounces-856729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1539BE4ED2
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 19:55:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69EBB405572
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 17:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 265E6217722;
	Thu, 16 Oct 2025 17:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iDj03Bnq"
Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137EB334697
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 17:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760637305; cv=none; b=ANvAi7wQ3fdYqaTDKzagS5Yz2HvgoEb+SuNAyXQDI+2RUEXNJO7xWlFxSGSeTjB5FbLF8nZyA+aflo5vsoQLFMaLY7amEEa+6erTqKujN+6o6jtKxlXSxHrQlU5XAS1uv4nm65F3AIYzQG5q3wCQHhZ4ZOy/vIOFSWNNv9sNv7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760637305; c=relaxed/simple;
	bh=h5aLjrxgWTpMEhoeUPHka+pmn3lvf4M7nflbv+VTOAE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=uY+E1RWwQJFHF+3+FV8HFSzadeBacPenV2uIpwjK5F+yDxKgP+aHDTk9KS22/OCjwBCPUwhAawmPWA11sHUh+atMKeKJKdcAp0Fd3PuQmSyXyxebesh684sFSWPOX9lhYd2Z8ZsQtnkxfx3RSoXjXuj3uI7d2EnFepEirfgz3Ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iDj03Bnq; arc=none smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-633be3be1e6so1666572d50.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 10:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760637303; x=1761242103; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=h5aLjrxgWTpMEhoeUPHka+pmn3lvf4M7nflbv+VTOAE=;
        b=iDj03Bnq6+UeIZLdVevbacI7pw4G4Jbd8uuzgkZvbGfPPHlNUfHor+db4/BqTVcAtK
         6u1cwrp8ufwFkYHu0RciZAV7+mckvgUWCzbHtTx/boSZsLjjP4jrYNLpQ+DyUA88JqUD
         DIf1SI1lYCEUkuWopvWAX/SaUWaKFA/JAGxUnx0X01oU87ta65RimFLoBUK8g20hLdAI
         zaoBGRaFYzyvlCvkipKLCQjB4U4Ty5hmedlZt716ikriu2O+2H3fwVr4OpaNfRE1Ml9s
         EkI0fjA5J2kRxrF6iGYfQdoXnc8Go4eUpRWHVLaxih/cJVA7bQfEvEpbTa7HF9INyl9Y
         kt2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760637303; x=1761242103;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h5aLjrxgWTpMEhoeUPHka+pmn3lvf4M7nflbv+VTOAE=;
        b=pD2FGK79oAPAhPTnvQzCxWlijPrQuJ4nRDLlxVIJAWxSYlRzAISLaLGkyfzpnI67lS
         4Aae8CjJAXicOg/XW8Zhk86oZutAfTqep1VCz+vJKT+mhPTT6eM6v+igPokK8/VXjCOW
         ekUcJ4rRzi0ALnJFcCx9IB65amKTFdLndhTV/lGhEHVBan+/roGiqYmm9CbvA1l6ojrD
         sDI3Lji0qve0ztyVhDf4MtfHfTKNTeSESCRBmn0fPxTAsZJsVUwH+evYw/r3Pnsgq3lY
         rl6rWYPrRMiPdQYk/3fX6HG7Jxzn7I8GOarRRs5rkdz35Ves7oEQR86VZIJtJ5HDslFR
         IRCA==
X-Gm-Message-State: AOJu0YxIGjnG/35ttXxgkQEykB7F7A2I7TFWkSGVf18O/WLRD9RLbWo6
	hiJdeGAi7VNlQjjlkST+WllQK1VYsDNDxaEfIZ3+/v5kpjqCweOn8LIxD3l/osMPlPouqeN7qG2
	eWlO8n+khvW5gkugBAfQXX3zRMNz2SpGyLw==
X-Gm-Gg: ASbGnctlz9ZxFR7Y0iR+AhKM7ydQWNOisH60Nj7XSqiqdk4IpgzLcxyz21qO+xTx2UH
	JN80J1AkM42lRY7NYiIsTV4cxH2kiDWctkK1QVkKdmPUTm4is3wJ+WwKJVS0HCoOWMAj+AWlrBw
	YziPauWEmHiz+rbAHTFjItFcM4xad2HiyWgb3fFx3VZIZ7rrXtYurc75/aTyzd0j5xH2K74M0w6
	Q2rLBt7fupsxcx8u958dKa2yGITY/X4RN8g8/Ak3E3x0/6Mc2Cjdr2o6ksYGn/qUYj8FATolPI+
	aXBHW0Ev07s=
X-Google-Smtp-Source: AGHT+IF+2NZFf4J32TSY/XIprqs2WiN4ox1SeeZs8P6BnGTHWtFja5A1abi21C1tD6ZnSCJOt0bGx//U0iNOdSEPG0k=
X-Received: by 2002:a05:690e:108e:b0:636:2079:1879 with SMTP id
 956f58d0204a3-63e08e4c1e9mr3085523d50.10.1760637302712; Thu, 16 Oct 2025
 10:55:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Abraham Wieland <abe.wieland@gmail.com>
Date: Thu, 16 Oct 2025 10:54:51 -0700
X-Gm-Features: AS18NWDnu2YJSlj5YnAHcBeOc5CcAga0e5rokOSu1P8eBY1vx_y_tSUt3mtIYrA
Message-ID: <CAJcU4VTXw-vfRoq1VVfy7qW+zGUZxTaaXCQrRfeNuVUx30XtMw@mail.gmail.com>
Subject: mm, shm: Question about hugetlb_shm_group sysctl
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

I apologize if this is not the right place to ask this; please point
me in the right direction if so.

I understand the intention of /proc/sys/vm/hugetlb_shm_group is to
only allow users of that group to create shared memory segments backed
by hugepages. However, I found that users not in that group can still
share a region (albeit not a SysV segment) backed by hugepages,
through at least two means:
1. They can make an fd with memfd_create and the MFD_HUGETLB flag,
then pass the fd (via SCM_RIGHTS or pidfd_getfd). According to the
manpage for memfd_create, MFD_HUGETLB is supposed to also honor
hugetlb_shm_group, but it doesn't; it calls hugetlb_file_setup with
HUGETLB_ANONHUGE_INODE (just like mmap does), so sidesteps that check
(which only occurs for HUGETLB_SHMFS_INODE).
2. They can mmap a region with MAP_SHARED | MAP_ANONYMOUS |
MAP_HUGETLB, then fork. Naturally this is more restrictive than
memfd_create or shmget, but it still allows for shared mappings backed
by hugepages (depending on your definition of shared).
3. Of course they could open a file in a hugetlbfs mount or a tmpfs
mount with the huge option, though these also require administrative
support.

Neither of the first two options have the persistence of a SysV
segment, but otherwise they still allow shared hugepages without a
separate mount. With this in mind, I wonder why we have the additional
restriction on SysV segments backed by hugepages; it seems like a very
specific case (as it doesn't affect the above options, nor segments
backed by normal pages).

Thanks in advance for any insights!
Abe Wieland

