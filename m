Return-Path: <linux-kernel+bounces-892881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23661C46085
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 11:47:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FAD43A8C69
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 10:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E746D306B00;
	Mon, 10 Nov 2025 10:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mUE05jYQ"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADFAD2FD678
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 10:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762771563; cv=none; b=eaFSjozF93nGVwkE/RrZ5UywAtyeQPgy77ApKrwmfRWcB2rrB7/MWJMz/8JOuQ93lqz3F847weK9FqmurvOjNlYAKOFfirvuLQ+Eop6w6dWpHRAHiTRyE2ZIfBOvFZNwPKVukERHSTLrSZ0p8dZ0aUC8ZsVtCUUOAGKXW6yiFig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762771563; c=relaxed/simple;
	bh=tvzbIPQybGxRevZd/lkELx8xCrWaAmmqxhVZ9oJcRNY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=PhVzExWIte3ZXbioyPIxv85FZKGwqhNHkDvIK8H5MT0LgOp0VZR4pp7RZXD89+a4PyeMptX1bVFYtFdIrEOtqn2GGPg6mgKeS0CRlKEkeruY8mQQS2FbjJOD+YO8JD9M0C77LP1XS3Ou6vqEb0IiQ6ITgZi10jLwhgPoLPhQE2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mUE05jYQ; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-641977dc00fso1006033a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 02:46:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762771560; x=1763376360; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Nn52Dw6XeCJl+NQBFzDP3LiRsqOl+aDmOINpv2h5uqI=;
        b=mUE05jYQOt938KmBIMQlyu/Iq2fCeN3JHhM35hyF/RVHYQhTVbjH7nOgEzPLOu/gvc
         Xg17oI7mV2xLO/y7tmbIlbIgtl6P3slhNXDEHqJU8YgB9CiCGgTHu/s22MAk8snD73z+
         +CbvwpF7Z0e/8Q67wvIgrjlrIDeu1nZniC7KdefQ0sIeJIaB+FRIzUp06g1YEJdaK2ep
         yqQVRDe3jNKVa9c9kFQoWDArIi+h11LTpGe3JdbMBNpy16yRqhJKExZ5QJJ29OvjvPjJ
         dfHaegCBDbgMPBD4hVsMGdFtNyjzFuDOOA0uUUjiwz9qAYf0wFmrQIMxL4G23j9GGt9Y
         6Ukg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762771560; x=1763376360;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Nn52Dw6XeCJl+NQBFzDP3LiRsqOl+aDmOINpv2h5uqI=;
        b=XYCEUEJJUFBHibPFYJU+MHfptitLFucbhr+eHTc98ZxgxE0bc4ig3UI7HSl5Gpwsvy
         vVBu4JFxMPOaSOVfsov24Ev/Ot4q5Hz3sg88P5ujPfchZXbjd2NofP8xbujzz78997KG
         VtXM7t0UFQf2nuSHH3Y+9KW7JPAsX15WMwgoyUMF/I4iRf/ebY9rCYOU0IQDaNBxnEOU
         XuYzcTMWoUAQBx7r3zp/oe1CUGmcOz+eWP9vZlXXtXh5AAray7hqjHGjxgp2AJ/ByyYT
         eJN+/RI9WW6OFbN6NK+nPfy7GvJLn9jQunwoQlRq/alq1vLHdgHLo7iOD/YztXtXfMxf
         MbPg==
X-Forwarded-Encrypted: i=1; AJvYcCVCvnshgaibWl9q/OiyyPjzOYYZM1l0rsW5hropyLURjG2EyrEJ54OmvXC/Kmr682VCesa0lCQdxjKQCVg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzrc9FRNeeLorg0Zw8t6Ip5Zwi6XaI6CnfIDC7pvjSF34uieCe7
	TBSYXZjGP6aBTYIHut4VQFWMKXiG2EY/lUnygQ9OO9slLKkCDu8HiYVVxEV4x2tBCIZi92dn4Ut
	QOANhZiLj91e7qI/0JdTH1scdsXMBFTk=
X-Gm-Gg: ASbGnctj6jS1ujAkjz9vrbbPorpkb+wDs3uLFdZKGQL274AUdyqJiAyioO2F+P76hx1
	L3ZAuUiXfB67Fb0jIpEgiappcNDofvNDhAMHiBIEq62DzKLbLuAvhHYsYcI7G7CWgdXEwaYSe9X
	DEfNs5boVwywpxbLAPFStVzP/dbrBMIELvnmovCuK59ZaTa6UDroiCMpH60VsMynpKLoSCwWnPW
	MpZzYd/vD+KJd0HtX/ycpwS3ZtFzbpLMj61jQeKRgtT6MAXTYzVKOArdjDdjDMp8xXJoUuET5Ld
	n3tS6xVUGz2fVW4=
X-Google-Smtp-Source: AGHT+IGkoy/0j46/WLChtAUGIN7JNBEidrsqsvOzQtIh2cpB5cRvP+8lyKmALxxpr6r5Vg3eegc2aDtr2Y/2Vs/0IUk=
X-Received: by 2002:a17:907:2d10:b0:b72:6ace:e5b6 with SMTP id
 a640c23a62f3a-b72e027299cmr791842066b.10.1762771560015; Mon, 10 Nov 2025
 02:46:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Mon, 10 Nov 2025 11:45:48 +0100
X-Gm-Features: AWmQ_bnMyII6oMhBw6mRswleCyHCRs7w1zcZv-khLfM5wJauHckbJZ0-6ztixIk
Message-ID: <CAGudoHEi7b0aO4GZLXgY=AOBYjfCs7NWkOi_46Rv1cj_mooX6A@mail.gmail.com>
Subject: on synthetic filesystems like tmpfs path lookups for non-existent
 files create transient entries
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

As in, a dentry is allocated solely to return -ENOENT, it gets freed
immediately after. That's a lot of overhead for nothing.

One could argue tmpfs could benefit from caching these anyway or that
there is no point trying to cache these for such a fs. I'm not going
to go there.

Given that there is no time pressure to fix this and seeing how not
creating them for no reason can be implemented in different
taste-dependent ways, I think it will be most time-efficient if you
fix it at your own leisure. ;) I'm not posting patches for this one.

As for a testcase, you can plop this into will-it-scale:
# cat tests/statneg.c
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <assert.h>
#include <string.h>

char *testcase_description = "non-existent file stat";

void testcase(unsigned long long *iterations, unsigned long nr)
{
    struct stat sb;

    while (1) {
        int error = stat("/tmp/nonexistent", &sb);
        assert(error != 0);

        (*iterations)++;
    }
}

Then running ./statneg_processes showcases the problem, being super
slow single-threaded. Hitting these in parallel does not scale at all
either:

# ./statneg_processes -t 10
testcase:non-existent file stat
warmup
min:261181 max:285570 total:2780930
min:311086 max:352403 total:3348461
min:310552 max:349138 total:3277166
min:308172 max:321618 total:3134878
min:310914 max:332300 total:3185394
min:355424 max:385750 total:3702454
measurement
min:311937 max:348949 total:3289838
min:293611 max:323888 total:3070839
min:296091 max:313330 total:3036069
min:288423 max:303650 total:2981185
min:287714 max:317808 total:3023488

this is contending on a spinlock:

@[
    __pv_queued_spin_lock_slowpath+5
    _raw_spin_lock+41
    d_alloc_parallel+126
    __lookup_slow+94
    walk_component+219
    path_lookupat+85
    filename_lookup+224
    vfs_statx+108
    vfs_fstatat+107
    __do_sys_newfstatat+36
    do_syscall_64+85
    entry_SYSCALL_64_after_hwframe+118
]: 1115404
@[
    __pv_queued_spin_lock_slowpath+5
    _raw_spin_lock+41
    dput+321
    terminate_walk+89
    path_lookupat+120
    filename_lookup+224
    vfs_statx+108
    vfs_fstatat+107
    __do_sys_newfstatat+36
    do_syscall_64+85
    entry_SYSCALL_64_after_hwframe+118
]: 1118216

things scale fine on ext4:
min:5945177 max:6203067 total:60466641
min:6350640 max:6630364 total:64641156
min:6352730 max:6644954 total:64719190
min:6358623 max:6659048 total:64768382

