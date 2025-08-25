Return-Path: <linux-kernel+bounces-784018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 82B7BB3359A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 06:47:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EF501B24A8E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 04:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C17B259CA5;
	Mon, 25 Aug 2025 04:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DffJmzn2"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79EA279DCC
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 04:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756097181; cv=none; b=m8zlDBljW2fFOZEUTqA3vvFDqRo2HRrDJKnNqu+2picIJOrO1H8igDTcxfwo9JBqFg8sJqEdYHGrF4acblVFZ+7dkSUsE8c20rzQ5Cj9jnFMnKhxMvSQdLaWg4910uK1Z3Cc+MioY962ftsrBuqFiIPnJCUky7fm1s5QhP+gz+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756097181; c=relaxed/simple;
	bh=423MUFVcRV9v/r2rjR3wXlHRo43mh1gRRDAEnGrqceU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=oB8Rf3LOqfPOujgooHMePiqqAysaQK2gilF30C07+gICZ5W+Wzogd/ptB2mtzq6/+goXRfu7lbXF3h/sNo5D6zQ+17JoDcObcrlLmwOnUhJw4f+M8Dk9kPEeYecIZ1PVJx9yYIwR0k73rU6mBbu/Rz8L+3hn+rlfpt754VgliCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DffJmzn2; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756097178; x=1787633178;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=423MUFVcRV9v/r2rjR3wXlHRo43mh1gRRDAEnGrqceU=;
  b=DffJmzn2HAiPWaksGwVjFZM1eQ09pJzQ6cFz3Sv9wTghTo83JXdgvEq5
   kmaRWUkoM+OWOhLU8Q0nsK8X5mMw+MlgkD3fOagzBtKnuzQxn+ySKvBZv
   raZe5bayDjsFDb74LrdW4mz40wwPtVa6owiar1fEn6HS3KEmFdiY1pMHu
   RvhgtXOLy/scuvS4PLoJK/nHDKiH7SC2D0OUFUFXrmMAwztXb2E3tkb/+
   Xe/qtrCyD3Btx6BnBmVmkzdRhXttvAp4AQ+3EdwCxX4bGzwTVRBySzvyE
   Y6mu/gTPRFDIJHUXpFCD9e/tJYm6PIsLP8uQN3xjsmKym3OHXnDSbicea
   A==;
X-CSE-ConnectionGUID: M6KRNItTRlOpKZVz9+EN3A==
X-CSE-MsgGUID: JtsKAlfKRnCTS+IQ93tAvw==
X-IronPort-AV: E=McAfee;i="6800,10657,11532"; a="58401092"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="58401092"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2025 21:46:17 -0700
X-CSE-ConnectionGUID: vzbq/mrzTquqnph/9sk+rw==
X-CSE-MsgGUID: XAh0hwm6SA2wVO+O4jqfbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="168406385"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by orviesa006.jf.intel.com with ESMTP; 24 Aug 2025 21:46:15 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uqP5v-000NMh-0n;
	Mon, 25 Aug 2025 04:46:11 +0000
Date: Mon, 25 Aug 2025 12:45:25 +0800
From: kernel test robot <lkp@intel.com>
To: Eric Dumazet <edumazet@google.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Maciej =?utf-8?Q?=C5=BBenczykowski?= <maze@google.com>
Subject: include/net/sock.h:2100:16: sparse: sparse: cast to non-scalar
Message-ID: <202508251226.ArERUcGn-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   1b237f190eb3d36f52dffe07a40b5eb210280e00
commit: e84a4927a404f369c842c19de93b216627fcc690 net: annotate races around sk->sk_uid
date:   9 weeks ago
config: alpha-randconfig-r131-20250824 (https://download.01.org/0day-ci/archive/20250825/202508251226.ArERUcGn-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 9.5.0
reproduce: (https://download.01.org/0day-ci/archive/20250825/202508251226.ArERUcGn-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508251226.ArERUcGn-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   net/core/lwt_bpf.c: note: in included file (through include/linux/tcp.h, include/linux/ipv6.h, include/net/ipv6.h, include/net/inetpeer.h, ...):
>> include/net/sock.h:2100:16: sparse: sparse: cast to non-scalar
>> include/net/sock.h:2100:16: sparse: sparse: cast from non-scalar
>> include/net/sock.h:2100:16: sparse: sparse: cast to non-scalar
>> include/net/sock.h:2100:16: sparse: sparse: cast from non-scalar
--
   net/ipv4/route.c: note: in included file (through include/linux/mroute_base.h, include/linux/mroute.h):
>> include/net/sock.h:2100:16: sparse: sparse: cast to non-scalar
>> include/net/sock.h:2100:16: sparse: sparse: cast from non-scalar
>> include/net/sock.h:2100:16: sparse: sparse: cast to non-scalar
>> include/net/sock.h:2100:16: sparse: sparse: cast from non-scalar
   net/ipv4/route.c: note: in included file (through include/linux/mroute_base.h, include/linux/mroute.h):
   include/net/ip_fib.h:562:19: sparse: sparse: cast to non-scalar
   include/net/ip_fib.h:562:19: sparse: sparse: cast from non-scalar
   include/net/ip_fib.h:562:19: sparse: sparse: cast to non-scalar
   include/net/ip_fib.h:562:19: sparse: sparse: cast from non-scalar
   include/net/ip_fib.h:562:19: sparse: sparse: cast to non-scalar
   include/net/ip_fib.h:562:19: sparse: sparse: cast from non-scalar
   include/net/ip_fib.h:562:19: sparse: sparse: cast to non-scalar
   include/net/ip_fib.h:562:19: sparse: sparse: cast from non-scalar
   include/net/ip_fib.h:562:19: sparse: sparse: cast to non-scalar
   include/net/ip_fib.h:562:19: sparse: sparse: cast from non-scalar
   include/net/ip_fib.h:562:19: sparse: sparse: cast to non-scalar
   include/net/ip_fib.h:562:19: sparse: sparse: cast from non-scalar
--
   net/ipv4/ip_output.c: note: in included file (through include/net/inet_sock.h, include/net/ip.h):
>> include/net/sock.h:2100:16: sparse: sparse: cast to non-scalar
>> include/net/sock.h:2100:16: sparse: sparse: cast from non-scalar
--
   net/ipv4/inet_connection_sock.c:328:36: sparse: sparse: context imbalance in 'inet_csk_find_open_port' - wrong count at exit
   net/ipv4/inet_connection_sock.c:605:23: sparse: sparse: context imbalance in 'inet_csk_get_port' - unexpected unlock
   net/ipv4/inet_connection_sock.c: note: in included file (through include/net/inet_sock.h, include/net/inet_connection_sock.h):
>> include/net/sock.h:2100:16: sparse: sparse: cast to non-scalar
>> include/net/sock.h:2100:16: sparse: sparse: cast from non-scalar
>> include/net/sock.h:2100:16: sparse: sparse: cast to non-scalar
>> include/net/sock.h:2100:16: sparse: sparse: cast from non-scalar
   net/ipv4/inet_connection_sock.c:1467:9: sparse: sparse: context imbalance in 'inet_csk_complete_hashdance' - unexpected unlock
>> include/net/sock.h:2100:16: sparse: sparse: cast to non-scalar
>> include/net/sock.h:2100:16: sparse: sparse: cast from non-scalar
--
   net/ipv4/tcp_ipv4.c:3415:41: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const *data @@     got struct tcp_congestion_ops const [noderef] __rcu *tcp_congestion_control @@
   net/ipv4/tcp_ipv4.c:3415:41: sparse:     expected void const *data
   net/ipv4/tcp_ipv4.c:3415:41: sparse:     got struct tcp_congestion_ops const [noderef] __rcu *tcp_congestion_control
   net/ipv4/tcp_ipv4.c:3537:45: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const *data @@     got struct tcp_congestion_ops const [noderef] __rcu *extern [addressable] [toplevel] tcp_congestion_control @@
   net/ipv4/tcp_ipv4.c:3537:45: sparse:     expected void const *data
   net/ipv4/tcp_ipv4.c:3537:45: sparse:     got struct tcp_congestion_ops const [noderef] __rcu *extern [addressable] [toplevel] tcp_congestion_control
   net/ipv4/tcp_ipv4.c:3541:50: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct tcp_congestion_ops const [noderef] __rcu *tcp_congestion_control @@     got struct tcp_congestion_ops * @@
   net/ipv4/tcp_ipv4.c:3541:50: sparse:     expected struct tcp_congestion_ops const [noderef] __rcu *tcp_congestion_control
   net/ipv4/tcp_ipv4.c:3541:50: sparse:     got struct tcp_congestion_ops *
   net/ipv4/tcp_ipv4.c: note: in included file (through include/net/inet_sock.h, include/net/icmp.h):
>> include/net/sock.h:2100:16: sparse: sparse: cast to non-scalar
>> include/net/sock.h:2100:16: sparse: sparse: cast from non-scalar
>> include/net/sock.h:2100:16: sparse: sparse: cast to non-scalar
>> include/net/sock.h:2100:16: sparse: sparse: cast from non-scalar
>> include/net/sock.h:2100:16: sparse: sparse: cast to non-scalar
>> include/net/sock.h:2100:16: sparse: sparse: cast from non-scalar
   net/ipv4/tcp_ipv4.c:1846:25: sparse: sparse: context imbalance in 'tcp_v4_syn_recv_sock' - unexpected unlock
   net/ipv4/tcp_ipv4.c:2139:17: sparse: sparse: context imbalance in 'tcp_add_backlog' - unexpected unlock
   net/ipv4/tcp_ipv4.c:2401:21: sparse: sparse: context imbalance in 'tcp_v4_rcv' - different lock contexts for basic block
   net/ipv4/tcp_ipv4.c:2612:13: sparse: sparse: context imbalance in 'listening_get_first' - wrong count at exit
   net/ipv4/tcp_ipv4.c:2660:29: sparse: sparse: context imbalance in 'listening_get_next' - unexpected unlock
   net/ipv4/tcp_ipv4.c:2693:13: sparse: sparse: context imbalance in 'established_get_first' - wrong count at exit
   net/ipv4/tcp_ipv4.c:2738:40: sparse: sparse: context imbalance in 'established_get_next' - unexpected unlock
   net/ipv4/tcp_ipv4.c:2870:36: sparse: sparse: context imbalance in 'tcp_seq_stop' - unexpected unlock
   net/ipv4/tcp_ipv4.c:3091:20: sparse: sparse: context imbalance in 'bpf_iter_tcp_listening_batch' - unexpected unlock
   net/ipv4/tcp_ipv4.c:3119:40: sparse: sparse: context imbalance in 'bpf_iter_tcp_established_batch' - unexpected unlock
   net/ipv4/tcp_ipv4.c:3416:41: sparse: sparse: dereference of noderef expression
   net/ipv4/tcp_ipv4.c:3416:41: sparse: sparse: dereference of noderef expression
   net/ipv4/tcp_ipv4.c:3538:45: sparse: sparse: dereference of noderef expression
   net/ipv4/tcp_ipv4.c:3538:45: sparse: sparse: dereference of noderef expression
--
   net/ipv4/datagram.c: note: in included file (through include/net/inet_sock.h, include/net/ip.h):
>> include/net/sock.h:2100:16: sparse: sparse: cast to non-scalar
>> include/net/sock.h:2100:16: sparse: sparse: cast from non-scalar
>> include/net/sock.h:2100:16: sparse: sparse: cast to non-scalar
>> include/net/sock.h:2100:16: sparse: sparse: cast from non-scalar
--
   net/ipv4/raw.c: note: in included file (through include/linux/mroute_base.h, include/linux/mroute.h):
>> include/net/sock.h:2100:16: sparse: sparse: cast to non-scalar
>> include/net/sock.h:2100:16: sparse: sparse: cast from non-scalar
--
   net/ipv4/udp.c: note: in included file (through include/linux/bpf-cgroup.h):
>> include/net/sock.h:2100:16: sparse: sparse: cast to non-scalar
>> include/net/sock.h:2100:16: sparse: sparse: cast from non-scalar
   net/ipv4/udp.c:1668:28: sparse: sparse: context imbalance in 'udp_rmem_release' - unexpected unlock
   net/ipv4/udp.c:1700:19: sparse: sparse: context imbalance in 'busylock_acquire' - wrong count at exit
   net/ipv4/udp.c:1712:28: sparse: sparse: context imbalance in 'busylock_release' - unexpected unlock
   net/ipv4/udp.c:3305:9: sparse: sparse: context imbalance in 'udp_get_first' - wrong count at exit
   net/ipv4/udp.c:3322:39: sparse: sparse: context imbalance in 'udp_get_next' - unexpected unlock
   net/ipv4/udp.c:3370:31: sparse: sparse: context imbalance in 'udp_seq_stop' - unexpected unlock
--
   net/ipv4/af_inet.c: note: in included file (through include/net/inet_sock.h, include/net/ip.h):
>> include/net/sock.h:2100:16: sparse: sparse: cast to non-scalar
>> include/net/sock.h:2100:16: sparse: sparse: cast from non-scalar
>> include/net/sock.h:2100:16: sparse: sparse: cast to non-scalar
>> include/net/sock.h:2100:16: sparse: sparse: cast from non-scalar
--
   net/ipv4/ping.c: note: in included file (through include/net/inet_sock.h, include/net/ip.h):
>> include/net/sock.h:2100:16: sparse: sparse: cast to non-scalar
>> include/net/sock.h:2100:16: sparse: sparse: cast from non-scalar
--
   net/ipv6/af_inet6.c: note: in included file (through include/linux/tcp.h, include/linux/ipv6.h, include/linux/icmpv6.h):
>> include/net/sock.h:2100:16: sparse: sparse: cast to non-scalar
>> include/net/sock.h:2100:16: sparse: sparse: cast from non-scalar
--
   net/ipv6/route.c:2382:39: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] flow_label @@     got restricted __be32 @@
   net/ipv6/route.c:2382:39: sparse:     expected unsigned int [usertype] flow_label
   net/ipv6/route.c:2382:39: sparse:     got restricted __be32
   net/ipv6/route.c: note: in included file (through include/linux/mroute_base.h, include/linux/mroute6.h):
   include/net/ip_fib.h:562:19: sparse: sparse: cast to non-scalar
   include/net/ip_fib.h:562:19: sparse: sparse: cast from non-scalar
   include/net/ip_fib.h:562:19: sparse: sparse: cast to non-scalar
   include/net/ip_fib.h:562:19: sparse: sparse: cast from non-scalar
   include/net/ip_fib.h:562:19: sparse: sparse: cast to non-scalar
   include/net/ip_fib.h:562:19: sparse: sparse: cast from non-scalar
   include/net/ip_fib.h:562:19: sparse: sparse: cast to non-scalar
   include/net/ip_fib.h:562:19: sparse: sparse: cast from non-scalar
   include/net/ip_fib.h:562:19: sparse: sparse: cast to non-scalar
   include/net/ip_fib.h:562:19: sparse: sparse: cast from non-scalar
   include/net/ip_fib.h:562:19: sparse: sparse: cast to non-scalar
   include/net/ip_fib.h:562:19: sparse: sparse: cast from non-scalar
   net/ipv6/route.c: note: in included file (through include/linux/mroute_base.h, include/linux/mroute6.h):
>> include/net/sock.h:2100:16: sparse: sparse: cast to non-scalar
>> include/net/sock.h:2100:16: sparse: sparse: cast from non-scalar
>> include/net/sock.h:2100:16: sparse: sparse: cast to non-scalar
>> include/net/sock.h:2100:16: sparse: sparse: cast from non-scalar
--
   net/ipv6/udp.c: note: in included file (through include/linux/bpf-cgroup.h):
>> include/net/sock.h:2100:16: sparse: sparse: cast to non-scalar
>> include/net/sock.h:2100:16: sparse: sparse: cast from non-scalar
>> include/net/sock.h:2100:16: sparse: sparse: cast to non-scalar
>> include/net/sock.h:2100:16: sparse: sparse: cast from non-scalar
--
   net/ipv6/raw.c: note: in included file (through include/linux/tcp.h, include/linux/ipv6.h, include/linux/icmpv6.h):
>> include/net/sock.h:2100:16: sparse: sparse: cast to non-scalar
>> include/net/sock.h:2100:16: sparse: sparse: cast from non-scalar
--
   net/ipv6/ping.c: note: in included file (through include/linux/tcp.h, include/linux/ipv6.h, include/net/addrconf.h):
>> include/net/sock.h:2100:16: sparse: sparse: cast to non-scalar
>> include/net/sock.h:2100:16: sparse: sparse: cast from non-scalar
--
   net/ipv6/datagram.c: note: in included file (through include/linux/tcp.h, include/linux/ipv6.h):
>> include/net/sock.h:2100:16: sparse: sparse: cast to non-scalar
>> include/net/sock.h:2100:16: sparse: sparse: cast from non-scalar
--
   net/ipv6/tcp_ipv6.c: note: in included file (through include/linux/tcp.h, include/linux/ipv6.h):
>> include/net/sock.h:2100:16: sparse: sparse: cast to non-scalar
>> include/net/sock.h:2100:16: sparse: sparse: cast from non-scalar
>> include/net/sock.h:2100:16: sparse: sparse: cast to non-scalar
>> include/net/sock.h:2100:16: sparse: sparse: cast from non-scalar
   net/ipv6/tcp_ipv6.c:1565:25: sparse: sparse: context imbalance in 'tcp_v6_syn_recv_sock' - unexpected unlock
   net/ipv6/tcp_ipv6.c:1956:21: sparse: sparse: context imbalance in 'tcp_v6_rcv' - different lock contexts for basic block
--
   net/ipv6/inet6_connection_sock.c: note: in included file (through include/linux/tcp.h, include/linux/ipv6.h):
>> include/net/sock.h:2100:16: sparse: sparse: cast to non-scalar
>> include/net/sock.h:2100:16: sparse: sparse: cast from non-scalar
>> include/net/sock.h:2100:16: sparse: sparse: cast to non-scalar
>> include/net/sock.h:2100:16: sparse: sparse: cast from non-scalar
--
   net/ipv6/netfilter.c: note: in included file (through include/linux/tcp.h, include/linux/ipv6.h):
>> include/net/sock.h:2100:16: sparse: sparse: cast to non-scalar
>> include/net/sock.h:2100:16: sparse: sparse: cast from non-scalar

vim +2100 include/net/sock.h

  2096	
  2097	static inline kuid_t sk_uid(const struct sock *sk)
  2098	{
  2099		/* Paired with WRITE_ONCE() in sockfs_setattr() */
> 2100		return READ_ONCE(sk->sk_uid);
  2101	}
  2102	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

