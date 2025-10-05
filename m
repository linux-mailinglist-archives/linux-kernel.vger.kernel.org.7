Return-Path: <linux-kernel+bounces-842269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63BE8BB961D
	for <lists+linux-kernel@lfdr.de>; Sun, 05 Oct 2025 13:55:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21FE03B9373
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Oct 2025 11:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED3FE280CC8;
	Sun,  5 Oct 2025 11:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="aO/Izd9C"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD360191493
	for <linux-kernel@vger.kernel.org>; Sun,  5 Oct 2025 11:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759665304; cv=none; b=MtBJx0Ryx8CxQYMnbP4TWHlT2w2fQ0j4nIClOaNOBqMdd+djwJttAZT3tVj3dLSvawzjFG2K5fDXCyinL7QiRgxyRsjOCN+migfZvFdIEDqdJEZh2D+AXQGTzskJvvBnkVqTrl3k+62wKtNtCZladOzZrGDaRiuLbDNVRv4nGSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759665304; c=relaxed/simple;
	bh=Wtyt1KzFariMlIeI+zEEMW0g/K5OklBCf8gbMrkr97g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TJJhx87aah+1xZ1b1E9E0gpkXz/qHfnF08eGBIC4JC8S0o+tqGOp48xvEZjcwbooHr2Tr8kfyC5raoqO3a5cijq6GgcAz6KaiE6r/F0jMGB3N0njpeOEFdsWBXc73fYCCuZYzeuuX3fy4QVbnRoGrAPgr/9bjyYpw7G7uk5h3JA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=aO/Izd9C; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-781db5068b8so3190503b3a.0
        for <linux-kernel@vger.kernel.org>; Sun, 05 Oct 2025 04:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1759665302; x=1760270102; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=er8GqX660tZxnm8yI7a7bHZtQ/sKKbb/5edfsYblxJI=;
        b=aO/Izd9Cm/ZGC3X5xOU5tFTzId9Re6hJdwHBU4kgov4ZX6NkMa9qOr9z6sMAHMfIER
         3ap5RnUWFJuGdMvpNJg5yhUp8bA3Ol9+Nu42RCW5GEZPGm6ixfQN9qjao/dhZmQm1uQz
         DXvOunQpJrwctf0sO7AWGIbaFYPKuuDa7z9gAKlkSWqaDdMRYianEdqV1AybyILglAI1
         HsrAerPxfDXiM1PU7rJduP1eDQnYGIb5DByef98c+l76Sidpw8iiM/bOh2cHV9xJXqIq
         BTJa+6OjVvQAwscodgddkB/wVEa0uKJrKg7YOZpP3f+AIckB8S+dWurzP3wsKsWCahyX
         aH/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759665302; x=1760270102;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=er8GqX660tZxnm8yI7a7bHZtQ/sKKbb/5edfsYblxJI=;
        b=qdvW9mjxqdsvxvEYbFxskNXKWlMvNa0r34WKtuGz+3gbXK5yRfTul0odsGuknwviyy
         w/fC/1nJYJbblIR3z8LBWcA3yTDld9J83dNP0J4lmyncwyEmwAfaToPPDpJQVDLZ5Xf8
         tQ8har7dko/dXvzsCDTaOG++lojGIhmeyKQYi6MsKfTUDS+jAFsRoYcD/xhjK7HjTU/z
         rxD6NPdKm0AnW5sxTkxoJZeUMwedYp1t6q2VT2CTCNyCS2L8I2y0EVwEyGUsUcHQdHm1
         KmrFNTZnn3SQnyjdmhuTB0kBiLfNqPVsh2q/QGMgbD5TQ7jA00OVwnnk58VoQEwjU26H
         9IUw==
X-Forwarded-Encrypted: i=1; AJvYcCVIiescyNlmWWMdf5kfN65+FzBnIKTrJoZD3ezxx9wLxV6yLwjcmTA58oJwzGZuXJ3dgO6PFl/EEsssONo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCbEych9eyMGLGWtyIyNtDDSB7KQJCj2lCeb42aa56BcVkrbTr
	D43nPUm1aoVSEy6DLicNf1EKyHGFgLXo5BPU4+YNf/dlpBb+B7UvBEkscUO/n5Lkycg=
X-Gm-Gg: ASbGncvzYLIT9cn5+IoYk4gUtU3hNBUphD5BBYusHoZRqj39El4lq40Q/aCIWfRMCq+
	1REDVUKjAF4lDPT7ONMye0eWkWRNHoIlSDNwQYTZjhFRprOEvEjXZAiMBy6NxxQ4UDxlgA4U2JA
	8dcEeyM/nepir9itgVuGcTV8nGtkNYEH3aDESZrfF+BbbiK2WUgu80k9soBdOanDALEVnoEJzdL
	hWkG30u/k7jtE9b7RIZxhg7d0B25/5ZrzP8HolxQXwgwYlFMsvJAk1/EKMbICZM67TlmiyLjfK9
	Rt1axMWX4Gw5rG7UjfqA42Affei9pwgIPx3AkpaUgNhxN3t8mmNzod1Q81gXNFNyF4+IQdw8ysP
	Z3jdgL99dBVJQAmQdkuds+1qRN4cOwrP0yfV7g26KNw9W1Uh+bY/+c/bdpyEPgoK0yrNfFpRqBS
	kU38c3S0777H25Yb1bjYctLg==
X-Google-Smtp-Source: AGHT+IFJenQ6xCL2kkGn0U9jKhBNcjWIfEAKLRN1RcMC27u89D+ljxfEAw22GmeKD+TuSCTAFauMxA==
X-Received: by 2002:a05:6a00:2e04:b0:77f:1ef8:8acb with SMTP id d2e1a72fcca58-78c98d45544mr11521737b3a.13.1759665301391;
        Sun, 05 Oct 2025 04:55:01 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-91-142.pa.nsw.optusnet.com.au. [49.180.91.142])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78b02053a3asm9874688b3a.48.2025.10.05.04.55.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Oct 2025 04:55:00 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.98.2)
	(envelope-from <david@fromorbit.com>)
	id 1v5NKL-0000000Aote-3xSr;
	Sun, 05 Oct 2025 22:54:57 +1100
Date: Sun, 5 Oct 2025 22:54:57 +1100
From: Dave Chinner <david@fromorbit.com>
To: Christoph Hellwig <hch@lst.de>
Cc: kernel test robot <oliver.sang@intel.com>,
	Dave Chinner <dchinner@redhat.com>, oe-lkp@lists.linux.dev,
	lkp@intel.com, linux-kernel@vger.kernel.org,
	Carlos Maiolino <cem@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-xfs@vger.kernel.org
Subject: Re: [linus:master] [xfs]  c91d38b57f:  stress-ng.chown.ops_per_sec
 70.2% improvement
Message-ID: <aOJckY5NnB2MaOqj@dread.disaster.area>
References: <202510020917.2ead7cfe-lkp@intel.com>
 <20251003075615.GA13238@lst.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251003075615.GA13238@lst.de>

On Fri, Oct 03, 2025 at 09:56:15AM +0200, Christoph Hellwig wrote:
> On Thu, Oct 02, 2025 at 04:11:29PM +0800, kernel test robot wrote:
> > 
> > 
> > Hello,
> > 
> > kernel test robot noticed a 70.2% improvement of stress-ng.chown.ops_per_sec on:
> 
> I wonder what stress-ng shown is doing, because unless it is mixing fsync
> and ilock-heavy operations on the same node this would be highly
> unexpected.

stress-ng puts a fsync() at the end of every ops loop:

	do {
		int ret;

		ret = do_fchown(fd, bad_fd, cap_chown, uid, gid);
		if ((ret < 0) && (ret != -EPERM)) {
			pr_fail("%s: fchown failed, errno=%d (%s)%s\n",
				args->name, errno, strerror(errno),
				stress_get_fs_type(filename));
			rc = EXIT_FAILURE;
			break;
		}

		ret = do_chown(chown, filename, cap_chown, uid, gid);
		if ((ret < 0) && (ret != -EPERM)) {
			pr_fail("%s: chown %s failed, errno=%d (%s)%s\n",
				args->name, filename, errno, strerror(errno),
				stress_get_fs_type(filename));
			rc = EXIT_FAILURE;
			break;
		}
		ret = do_chown(lchown, filename, cap_chown, uid, gid);
		if ((ret < 0) && (ret != -EPERM)) {
			pr_fail("%s: lchown %s failed, errno=%d (%s)%s\n",
				args->name, filename, errno, strerror(errno),
				stress_get_fs_type(filename));
			rc = EXIT_FAILURE;
			break;
		}
>>>>>>>>	(void)shim_fsync(fd);
		stress_bogo_inc(args);
	} while (stress_continue(args));

It's also triggering a change in rwsem contention behaviour on the
inode->i_rwsem in chown_common(), from sleeping to spinning, because
fsync() no longer causes ILOCK_EXCL lock contention and causes the
task currently doing a chown operation to wait on the ILOCK_EXCL
whilst holding the inode->i_rwsem.

Hence all the chown() operations now trigger the spin-on-waiter
heuristic on the inode->i_rwsem as the lock holder never releases
the CPU during the modification. That explains why the CPU usage
increase (from ~2 CPUs to ~50 CPUs) is way out of proportion with
the actual increase in performance.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

