Return-Path: <linux-kernel+bounces-867299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EF38C022BD
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 17:38:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 767173484A7
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 15:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E838833B96A;
	Thu, 23 Oct 2025 15:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="V5I0LgXA"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0852132F75C
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 15:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761233925; cv=none; b=leUUja8JL28q0gE9MXyOKQegK63ekJHUXC2+h7fV7GwF5/h4Ndn4jtIFMp/J9ntC3gO9yav2smWB2QavafUovchGUDkPH2Rm8HF22rWSkpCYoQrytsXS5ezwKg5hAxoupcacvjI1gXFfTh38v3UkwrDF/0hTGPoKb5ivqR5PIi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761233925; c=relaxed/simple;
	bh=o8n3TzFK8cwx6v1gouVIvRQfecLzb20I48OyGuF0+bU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mOJBu1y++dCmilTMWPCYtrWKGiQJ65EQhqX/N9YzKnvVkNnRNFCZFdfpLlRpLyj05e4i6IDoS9SZRS9bKnNByKntz1WCRhUguNgpcJaM1K3Put+6NiGxX4/OXU9gKbhzJfYPSJVK2YNvMQ4o0W5O+Uidrfc+HGt64aHkFRjyiiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=V5I0LgXA; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-46e6a689bd0so10096375e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 08:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1761233921; x=1761838721; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=emFjEGX/2ia/GgE92d7MkN/hP/ffrR//OmgTLbErZaU=;
        b=V5I0LgXAQDwxveZl4p/jb4FLMsMxWfKxnU9UYf73dhbIdior0/nyQwM8qfKm38OubK
         WQJfB8uK8EZCc7/hdWf0xm492AGXjFkNs5bqGPdXA6MRPyZ3eT70qEI02WW1RUDlQB2l
         G8MKdiGELoSI8NLlFLVUYp4xYZUjF36b6OBDMUTpeWY/B+0l5I3PwFOF8GOuKFyBZf+9
         kj32a1ev1WkPfMXmWfelfVhfwb6Hbd9Vfvep/JdJC/0LruUDPhWF2NTftYfjWF+8uFIo
         V/MdyDphcgRcWHHVgnkbxsAnbbB+loU2nUyr5cfte2BW0xD2a+/x8hBgz4ugWoSNz6ox
         slhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761233921; x=1761838721;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=emFjEGX/2ia/GgE92d7MkN/hP/ffrR//OmgTLbErZaU=;
        b=bYITkokRknuXT4n3DaO8wPVXmKNp7lZrb1dYl62P/NW9W5L6fRyMZw7k9A5ZQQqn58
         O9eE4U84/FOeaOBTQrz3oz1Nv1AmK+6yjXVazIfTn+nWmwHBPspI6SzgviPIqq7779IZ
         6w5MNsZCESO7iBeVUGWZY5vdmBJt4pL5icird/GkEhLvEh1a+/NFpUzj/j9O8E0XYLjM
         jhqI7/vBAIVublOXOxB5GXHkYSZkSOFyT6FofQ3kLlgn0aI7KvgOkNYG/W5JqCdZ9Lpf
         6Zzc07TmCXSjARFLpuHCxNc6RmVaDIYEe1ymCkq3V6KiZBmtNIbicqFpbrvKfz1oTQmQ
         D++w==
X-Forwarded-Encrypted: i=1; AJvYcCUs/iizhNoiVRzT8hC5yifJjbv1BBTDNV2os464mv7Kc4V5VrRjqVc3pnv602XvuIneflDJIgT+fdsgQJg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAICL80euI93wpDEzccRMl2oYsNqTXl6OLdMtrVJpqcULS0mxs
	92HHyew5As+tRJXbpyqkM4vaZWq84PjKxhqaj3+n7J+oEcmmKfNppO9vD5D76FPKfaY=
X-Gm-Gg: ASbGncvemwQNHgTvIsghNQSN9bBVt61shpZ70aEzxe8APfbR8P+Dsa0Cy7FHcPgWd0q
	khiRTp2iLKCpO8IFHCUwmnrimgEmEfTgxqd6iwhoz/KlB144eMrgWMrHtMUnPc/lmBusgcFA0Um
	9zXeIJ0cOgmZqx4Bf7D/0KojjwUSN9MIApB57+h0V6jUSuUst5j4eOyp5Ajk+4UHVVzpDi3FUru
	AwAdJvqnH5uzqYZxbT/A1h4d3ZQ/L0QWZ6wkuI9IT5r8W3CI6cf2PO+ejZk+mTNIbLaa+pv5YeO
	UPb/NvvxcwshB07J6RnulRBP6B3E1Q/Ry1+qNzgTiu69K9K4kRTEJ3wBdxVYruj6f67ufGuuCt0
	skzEYSVR1mddMm1lnRRazEMsxSd2eKvFlinJRY4y4RogWNr3BlIHepdOGyYBokx6P8AENu2c1rj
	Yxr63inXRG5qdJGT0y0XYE2hMc9eRJdZflLYXeAmg=
X-Google-Smtp-Source: AGHT+IFAU+uyVwYCthT+PpcimsZJwFjzQLeaBiDpaVM+6Ev4BxIiVF6aihH7eMImoAG7z42fuwRTGw==
X-Received: by 2002:a05:600c:820b:b0:46e:6d5f:f59 with SMTP id 5b1f17b1804b1-47117878465mr188702245e9.4.1761233921262;
        Thu, 23 Oct 2025 08:38:41 -0700 (PDT)
Received: from pathway.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475c4342860sm102033965e9.11.2025.10.23.08.38.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 08:38:40 -0700 (PDT)
Date: Thu, 23 Oct 2025 17:38:39 +0200
From: Petr Mladek <pmladek@suse.com>
To: Andrew Murray <amurray@thegoodpenguin.co.uk>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/3] printk: Release console_lock between printing
 records in legacy thread
Message-ID: <aPpL_9hyzLPIBYTQ@pathway.suse.cz>
References: <20251020-printk_legacy_thread_console_lock-v3-0-00f1f0ac055a@thegoodpenguin.co.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251020-printk_legacy_thread_console_lock-v3-0-00f1f0ac055a@thegoodpenguin.co.uk>

On Mon 2025-10-20 16:38:04, Andrew Murray wrote:
> The legacy printer kthread uses console_lock and
> __console_flush_and_unlock to flush records to the console which
> holds the console_lock being held for the entire flush. This
> results in large waiting times for console_lock waiters
> especially where there is a large volume of records or where the
> console is slow (e.g. serial). During boot, this contention causes
> delays in the filp_open call in console_on_rootfs.
>    
> Let's instead release and reacquire console_lock in between
> printing individual records.
> 
> Signed-off-by: Andrew Murray <amurray@thegoodpenguin.co.uk>
> ---
> Changes in v3:
> - Rebased on v6.18-rc2
> - Reordering of variables and minor tweak to comments in console_flush_one_record
>   in first patch
> - Improve semantics of console_flush_one_record in the second patch through different
>   use of return value and by replacing any_usable with try_again.
> - Update third patch to use newer version of console_flush_one_record
> - Link to v2: https://lore.kernel.org/r/20250927-printk_legacy_thread_console_lock-v2-0-cff9f063071a@thegoodpenguin.co.uk
> 
> Changes in v2:
> - Move any_usable=false to console_flush_all in the 'introduce
>   console_flush_one_record' patch to match original implementation.
> - Add Petr's console_flush_one_record() code cleanup patch
> - Open code flushing implementation in legacy_kthread_func instead
>   of introducing new console_flush functions.
> - Link to v1: https://lore.kernel.org/r/20250915-printk_legacy_thread_console_lock-v1-0-f34d42a9bcb3@thegoodpenguin.co.uk
> 
> ---
> Andrew Murray (2):
>       printk: Introduce console_flush_one_record
>       printk: Use console_flush_one_record for legacy printer kthread
> 
> Petr Mladek (1):
>       printk: console_flush_one_record() code cleanup
> 
>  kernel/printk/printk.c | 186 +++++++++++++++++++++++++++++++------------------
>  1 file changed, 119 insertions(+), 67 deletions(-)
> ---
> base-commit: 211ddde0823f1442e4ad052a2f30f050145ccada
> change-id: 20250914-printk_legacy_thread_console_lock-1c27f59bf990

JFYI, the patchset has been committed into printk/linux.git,
branch rework/preempt-legacy-kthread. It is intended for 6.19.

Best Regards,
Petr

