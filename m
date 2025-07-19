Return-Path: <linux-kernel+bounces-737928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D8AB9B0B200
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 23:46:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66EB1189D44D
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 21:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C19312327A3;
	Sat, 19 Jul 2025 21:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="Ouou7b5A"
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D07232367
	for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 21:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752961601; cv=none; b=uIsuCkPf+EOAgowpknn7ODum8EyB2jSMH0xMtjBaRyYmGz2AL+QQmCeFXokg271kR6vaNpoDDvjdE9zmDz5YbtrOiDznvHyIBCuPYn6/QflEDwVk00eSww3GHqStFPzSz+pcporT+K22ovWaE+V3GFjCJg6bMiWy+vrNT1M5rJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752961601; c=relaxed/simple;
	bh=KBnZTKpAFdd67qAqMoY3OB60zh3FBkzllkJnxWcEl0I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bTRIRvPvuqQXEgpVRzv7wTz/01YvGxmOaqry6PzJ8UXXWCXXRQNCqWRUWoAfqU4nMVzfPxQLagIOLIiaWB5xO8ZlVer6fsQwhZtVcqYzRbuPGnPmtNEG0z/F2caP29+fHUcAiHjTJmhddZRjPikhForqJctaMWFR7ZAIuecjcY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=Ouou7b5A; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-117-186.bstnma.fios.verizon.net [173.48.117.186])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 56JLk1GD009672
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 19 Jul 2025 17:46:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1752961565; bh=jEqgwQT80mZbMs7VwpZADbFPk2IZ5EbhjKTF03eh1IQ=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=Ouou7b5AvNXqW9nrIQrk7s6bGuCbAmN+pahxZpCMgJEBshGDwhG43XDmfzpjTmgZJ
	 F+RMcv4fY/mdL68co6kO+nLBHaGqGDijOG278K9aybmm9wCg0nRDIFSXVuM3pmbUAO
	 jHB1J2PyVvNrX44Q1OlSs2KtB++BX+HAcNhH2tW8gGa/69n3y/d4JD6SZXNWzzxwAt
	 37Kug2G50XNFCqE3d4QDPPtnkd2dqv+zyh4pLyJGjk071atH7G3y7jr+LgFyP9ADEE
	 UObattzQ/Jd6iPNWM6Pp7Tm2rDdCk01wa8NuhrcJYHHWWy3mTOY5gYyYUaKRWbcxpc
	 1ui7D2nWHKhQg==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 1FF3B2E00D1; Sat, 19 Jul 2025 17:46:01 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: linux-ext4@vger.kernel.org, Baokun Li <libaokun1@huawei.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, adilger.kernel@dilger.ca, jack@suse.cz,
        linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com,
        julia.lawall@inria.fr, yi.zhang@huawei.com, yangerkun@huawei.com,
        libaokun@huaweicloud.com
Subject: Re: [PATCH v3 00/17] ext4: better scalability for ext4 block allocation
Date: Sat, 19 Jul 2025 17:45:53 -0400
Message-ID: <175296153002.397842.8557190355040548244.b4-ty@mit.edu>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250714130327.1830534-1-libaokun1@huawei.com>
References: <20250714130327.1830534-1-libaokun1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Mon, 14 Jul 2025 21:03:10 +0800, Baokun Li wrote:
> Changes since v2:
>  * Collect RVB from Jan Kara. (Thanks for your review!)
>  * Add patch 2.
>  * Patch 4: Switching to READ_ONCE/WRITE_ONCE (great for single-process)
>         over smp_load_acquire/smp_store_release (only slight multi-process
>         gain). (Suggested by Jan Kara)
>  * Patch 5: The number of global goals is now set to the lesser of the CPU
>         count or one-fourth of the group count. This prevents setting too
>         many goals for small filesystems, which lead to file dispersion.
>         (Suggested by Jan Kara)
>  * Patch 5: Directly use kfree() to release s_mb_last_groups instead of
>         kvfree(). (Suggested by Julia Lawall)
>  * Patch 11: Even without mb_optimize_scan enabled, we now always attempt
>         to remove the group from the old order list.(Suggested by Jan Kara)
>  * Patch 14-16: Added comments for clarity, refined logic, and removed
>         obsolete variables.
>  * Update performance test results and indicate raw disk write bandwidth.
> 
> [...]

Applied, thanks!

[01/17] ext4: add ext4_try_lock_group() to skip busy groups
        commit: 68f9a4d4f74ac2f6b8a836600caedb17b1f417e0
[02/17] ext4: separate stream goal hits from s_bal_goals for better tracking
        commit: c6a98dbdff75a960a8976294a56b3366305b4fed
[03/17] ext4: remove unnecessary s_mb_last_start
        commit: 8eb252a81b311d6b2a59176c9ef7e17d731e17e6
[04/17] ext4: remove unnecessary s_md_lock on update s_mb_last_group
        commit: ea906991a494eeaf8b6a4ac82c568071a6b6b52c
[05/17] ext4: utilize multiple global goals to reduce contention
        commit: 174688d2e06ef9e03d5b93ce2386e2e9a5af6e7b
[06/17] ext4: get rid of some obsolete EXT4_MB_HINT flags
        commit: d82c95e546dc57b3cd2d46e38ac216cd08dfab3c
[07/17] ext4: fix typo in CR_GOAL_LEN_SLOW comment
        commit: 1930d818c5ecfd557eae0f581cc9b6392debf9c6
[08/17] ext4: convert sbi->s_mb_free_pending to atomic_t
        commit: 3772fe7b4225f21a1bfe63e4a338702cc3c153de
[09/17] ext4: merge freed extent with existing extents before insertion
        commit: 92ba7b95ef0743c76688fd3d4c644e8ba4fd4cc4
[10/17] ext4: fix zombie groups in average fragment size lists
        commit: 84521ebf83028c0321050b8665e05d5cdef5d0d8
[11/17] ext4: fix largest free orders lists corruption on mb_optimize_scan switch
        commit: bbe11dd13a3ff78ed256b8c66356624284c66f99
[12/17] ext4: factor out __ext4_mb_scan_group()
        commit: 47fb751bf947da35f6669ddf5ab9869f58f991e2
[13/17] ext4: factor out ext4_mb_might_prefetch()
        commit: 12a5b877c314778ddf9a5c603eeb1803a514ab58
[14/17] ext4: factor out ext4_mb_scan_group()
        commit: 6e0275f6e713f55dd3fc23be317ec11f8db1766d
[15/17] ext4: convert free groups order lists to xarrays
        commit: bffe0d5051626a3e6ce4b03e247814af2d595ee2
[16/17] ext4: refactor choose group to scan group
        commit: 56b493f9ac002ee7963eed22eb4131d120d60fd3
[17/17] ext4: implement linear-like traversal across order xarrays
        commit: feffac547fb53d7a3fedd47a50fa91bd2d804d41

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

