Return-Path: <linux-kernel+bounces-793533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44104B3D4DE
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 21:18:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BCFD17135E
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 19:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCB462773C2;
	Sun, 31 Aug 2025 19:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="unknown key version" (0-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b="IKTf13Sl";
	dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b="dRDYDlND"
Received: from e2i440.smtp2go.com (e2i440.smtp2go.com [103.2.141.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD8C2765DB
	for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 19:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.2.141.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756667893; cv=none; b=Ne/HOrn82bkAhz1SaDvoaZSB1NIDNSfEG2dkDslRTvYSvmeQbTnff0o5FKWa+NK+rldXS8ApcVjo3tJw0l0aNJKlPtn1S0R09Gcce4EgIRDCM7eWd0pMx1I5Nax9xp5mQ7Jy921xg4uYDCaby3pxGkruAa1T7wQzNdQY/FwY+NM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756667893; c=relaxed/simple;
	bh=KneoWpxXGFhvxupsexdJXwJWsXpS5UsqWVZ1XconUfo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=is1ltHfKtN1yA9pS09589teAhXbc5nC4G/UyylKZ/UwhyILDNKvZhGoYcXJwjN+h0yRfpOEoqUOHlLr0jE8TcaRBghZFQ04oqsCI3sgGE7lQcz8YuGHL+gotF3NP9//02ImCuROfcOn5CuqIMpH3sMzKhNDBug6aOpB2U5DPh7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt; spf=pass smtp.mailfrom=em510616.triplefau.lt; dkim=fail (0-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b=IKTf13Sl reason="unknown key version"; dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b=dRDYDlND; arc=none smtp.client-ip=103.2.141.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em510616.triplefau.lt
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=smtpservice.net; s=maxzs0.a1-4.dyn; x=1756668791; h=Feedback-ID:
	X-Smtpcorp-Track:Message-ID:Date:Subject:To:From:Reply-To:Sender:
	List-Unsubscribe:List-Unsubscribe-Post;
	bh=fjKbadbZ2hBFy0VfkFE4ZYB0g9U3OWHoNFKBHGHXGes=; b=IKTf13SlpAGajML6v3ZiBhWyQE
	k+QPmfr9hOHpg2fEjRclORAsEIDJMD2f3SpW6pkr9wMlB1LAI6V679A6i/W6vJxTE/AjiE1qZOXt7
	Rbas4g5Vtg8ixCml4qW9iOD1OyabjawK98AUCxhE+IKZl7VxEejktAJAshwhLZ0IWJid8XHUBPAzN
	fdWySfZjBVTtc36mkXsUpNPbpA4MM0uheo/S9yy5UfDrUB+lkgjiUItKptgg6eF8GnqUdIvFPwD6W
	Licr2i5lMGFH49mhpyIfoz65GMyzSxg8SYt7ikzIU08R++1yHFKcnyqG6HjwRKIJtuyPCjwI24mtC
	Z1uMhI8Q==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=triplefau.lt;
 i=@triplefau.lt; q=dns/txt; s=s510616; t=1756667891; h=from : subject
 : to : message-id : date;
 bh=fjKbadbZ2hBFy0VfkFE4ZYB0g9U3OWHoNFKBHGHXGes=;
 b=dRDYDlNDHsLr0aBO5hZeW/VCevO/3+4Y1LEtFm9I4o4HzF053mgRT9fPwGSbBAo8mUhUN
 748lmzpe0MtXNIURTDiEPbFM5AR6XRMwU1xWfNv9Yq8rfmmW+clZ+siowJ6v4txOeB1UiwH
 R7ZDCuz00WWgD523XQ7qwR3RarosQYqS6i3nluanWyv25797lA1znei6Etg/Q2QMEywUnX4
 k3QaWUVN+JBSItdoe7MtrT/Y6y2IVulZojcjsjiH7n1L21J/A5HDayixqItu3S4GF75BxeK
 oSXyEweO4eiMMhQ8QUx3IJbLM6pFdQUDoWMGfOZGROKEbGb3/VtG0677bwNw==
Received: from [10.139.162.187] (helo=SmtpCorp) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.94.2-S2G) (envelope-from <repk@triplefau.lt>)
 id 1usnYp-TRk4DY-U4; Sun, 31 Aug 2025 19:17:55 +0000
Received: from [10.12.239.196] (helo=localhost) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.98.1-S2G) (envelope-from <repk@triplefau.lt>)
 id 1usnYp-4o5NDgrhYew-mlAi; Sun, 31 Aug 2025 19:17:55 +0000
From: Remi Pommarel <repk@triplefau.lt>
To: v9fs@lists.linux.dev
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 Eric Van Hensbergen <ericvh@kernel.org>,
 Latchesar Ionkov <lucho@ionkov.net>,
 Dominique Martinet <asmadeus@codewreck.org>,
 Christian Schoenebeck <linux_oss@crudebyte.com>,
 Remi Pommarel <repk@triplefau.lt>
Subject: [RFC PATCH 0/5] 9p: Performance improvements for build workloads
Date: Sun, 31 Aug 2025 21:03:38 +0200
Message-ID: <cover.1756635044.git.repk@triplefau.lt>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Smtpcorp-Track: BLPO7xv6l29y.l29Ip2tx12K7.PlbgGw6WjlD
Feedback-ID: 510616m:510616apGKSTK:510616sDeqWC-WNQ
X-Report-Abuse: Please forward a copy of this message, including all headers,
 to <abuse-report@smtp2go.com>

This patchset introduces several performance optimizations for the 9p
filesystem when used with cache=loose option (exclusive or read only
mounts). These improvements particularly target workloads with frequent
lookups of non-existent paths and repeated symlink resolutions.

The very state of the art benchmark consisting of cloning a fresh
hostap repository and building hostapd and wpa_supplicant for hwsim
tests (cd tests/hwsim; time ./build.sh) in a VM running on a 9pfs rootfs
(with trans=virtio,cache=loose options) has been used to test those
optimizations impact.

For reference, the build takes 0m56.492s on my laptop natively while it
completes in 2m18.702sec on the VM. This represents a significant
performance penalty considering running the same build on a VM using a
virtiofs rootfs (with "--cache always" virtiofsd option) takes around
1m32.141s. This patchset aims to bring the 9pfs build time close to
that of virtiofs, rather than the native host time, as a realistic
expectation.

This first two patches in this series focus on keeping negative dentries
in the cache, ensuring that subsequent lookups for paths known to not
exist do not require redundant 9P RPC calls. This optimization reduces
the time needed for the compiler to search for header files across known
locations. These two patches introduce a new mount option, ndentrytmo,
which specifies the number of ms to keep the dentry in the cache. Using
ndentrytmo=-1 (keeping the negative dentry indifinetly) shrunk build
time to 1m46.198s.

The third patch extends page cache usage to symlinks by allowing
p9_client_readlink() results to be cached. Resolving symlink is
apparently something done quite frequently during the build process and
avoiding the cost of a 9P RPC call round trip for already known symlinks
helps reduce the build time to 1m26.602s, outperforming the virtiofs
setup.

The last two patches are only here to attribute time spent waiting
for server responses during a 9P RPC call to I/0 wait time in system
metrics.

Here is summary of the different hostapd/wpa_supplicant build times:

  - Baseline (no patch): 2m18.702s
  - negative dentry caching (patches 1-2): 1m46.198s (23% improvement)
  - Above + symlink caching (patches 1-3): 1m26.302s (an additional 18%
    improvement, 37% in total)

With this ~37% performance gain, 9pfs with cache=loose can compete with
virtiofs for (at least) this specific scenario. Although this benchmark
is not the most typical, I do think that these caching optimizations
could benefit a wide range of other workflows as well.

Further investigation may be needed to address the remaining gap with
native build performance. Using the last two patches it appears there is
still a fair amount of time spent waiting for I/O, though. This could be
related to the two systematic RPC calls made when opening a file (one to
clone the fid and another one to open the file). Maybe reusing fids or
openned files could potentially reduce client/server transactions and
bring performance even closer to native levels ? But that are just
random thoughs I haven't dig enough yet.

Any feedbacks on this approach would be welcomed,

Thanks.

Best regards,

-- 
Remi

Remi Pommarel (5):
  9p: Cache negative dentries for lookup performance
  9p: Introduce option for negative dentry cache retention time
  9p: Enable symlink caching in page cache
  wait: Introduce io_wait_event_killable()
  9p: Track 9P RPC waiting time as IO

 fs/9p/fid.c            |  11 +++--
 fs/9p/v9fs.c           |  16 +++++-
 fs/9p/v9fs.h           |   3 ++
 fs/9p/v9fs_vfs.h       |  15 ++++++
 fs/9p/vfs_dentry.c     | 109 +++++++++++++++++++++++++++++++++++------
 fs/9p/vfs_inode.c      |  14 ++++--
 fs/9p/vfs_inode_dotl.c |  94 +++++++++++++++++++++++++++++++----
 include/linux/wait.h   |  15 ++++++
 net/9p/client.c        |   4 +-
 9 files changed, 244 insertions(+), 37 deletions(-)

-- 
2.50.1


