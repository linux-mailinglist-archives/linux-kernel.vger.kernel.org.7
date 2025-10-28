Return-Path: <linux-kernel+bounces-873145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8455BC13378
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 07:58:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 67D964EF1B6
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 06:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1360D27144A;
	Tue, 28 Oct 2025 06:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tNNYeW9U"
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C8E225D202
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 06:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761634658; cv=none; b=Wnmosu+l2wu8u0ArNVdMuDfruPipvLIbbMCAQ+OP7sdUEsg3iuVZ53BWLah1twqSfnOr6j9ZFWvbJvPbky4taFDmXJ2Oc4eAXnbaYN0ybClMv1x9W1FCbq8A7Hu7uilcRozuJX6BlyH7UHxxVRH1unrAqqwu4o+9dubIbFSfY9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761634658; c=relaxed/simple;
	bh=egFegoFxFgg5Sw4VSUUZPrUVlzntXds7uE6Yh6w9/90=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cIkGe7YqlrhL826nXezyTFi3NEIAtwgZbGhFy0My1Ars9hO2EmUbHJZKRyOcSn9tAGbJ6HnXpjT60VKsdtCMVY5XxYBCMgeD56C4fmX+B56QLcxL6GeTZT3TYE6l1gwCOlB/uWI0GpY3H9ZFhFrTXwXNFUj7XnCiD52/cie829o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tNNYeW9U; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4ed0c162789so3404891cf.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 23:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761634655; x=1762239455; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5QYPr4bjBJI9GO+PU0MvM2o4J4FgN+dzYX5vn20vmcw=;
        b=tNNYeW9UbYLAUV4dTMR8SVW1RWjqieRpnDJi+LmjUwzt0JVuVB2Ex9RlwE8VIZl75P
         gG08wq/nomgQIasMNH2jH7E3vs2ivdA3WOs5hIBsr1pzyTmTm3rbnQGir3BkONigfmAy
         wrfvGPjp8ZvDDwy5NELs3qkNHrE3Y1Yg2KyUNkSW3GARfN00GjeowIKu9/rYBLZwQLCV
         e/l3m1OgrvynqdfivKNoFlW0DWSVVwGS2D5+f1rG1zdD4hi0XMu+uZ5qKlJph2W5jm9n
         ocmH2WoT54LP3uAPWb2zN5nf9EkXiqaU9VTLu4z+d4BNL6hgMsmjxLGSY5Wl57D4OIRJ
         RINQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761634655; x=1762239455;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5QYPr4bjBJI9GO+PU0MvM2o4J4FgN+dzYX5vn20vmcw=;
        b=CdwnCYzPUjo498Lahw71U9zQlG84ajwSmS5UoQ2s7Ho443G+I1jNNfx/PQLcSSKlV1
         boHJycjbXKRdBAlnR/D72xmw6PyD4ztXh6gc7bIBGkHjz2VkatN5Cwu8cGOvPeaJuKfz
         GbK3hYaCOn7611em/06s/mD6FQy7uAZdJmjBbUxjoGB2u9JiQD76ex2mQhtbvkROfXLr
         hiIfD7hoqjyewy+PMaKoQ0BLeMdwim9JRlYA9wIK40yEpL28DFDX4llgW6CPM4w9nwsF
         lCEqWOCc5vQ/7T0bIAdSS/sfzo1ChYu+FLA/KOCtxAcu863g5zoimqMoW6vs5tQOdBT8
         pBGA==
X-Forwarded-Encrypted: i=1; AJvYcCXe7a66vWGVnnNED5HyjLXibn/xGy9p0zcf/eSChRdPT8qkTZOAhvDgER+125oK0qOZEFWdlLg4TcyinM8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzP6UFLYy/6w2LV9nFvN1EKuFDX7T6WyxHIsM1vMK9BwT9jbY5Z
	rysLbwupTUFjBbnbS1yfKOcxDETwCV6RwY0pqzgpwC6QNR2mVrwTsq3yNF+9nAXWvOllyC8qRzD
	OThPFdniQIZNQ2+hL51gdXsmNPybSkqjPBSwu6lPa
X-Gm-Gg: ASbGncuqHfBsKYlEJpV/oq/4NOvfchUrWI4qjsWpTfeatHHtyu3QojUqqMd8LqS7U+d
	j82/hDwZR/Y/tH1p6+D8DjZFNj0tnLZb89LtSYiXIxfDr3MzEEtcPPxhdu5CZkXROyU5f/noQFx
	q7lbFJXtyFOpozoe0MN3xJmnkEPSNPD7ElDSfbflnUnENraNCNVso6zFIUaqB+qol6NQDX/w0vM
	LynU1SG5wHM2AbvP0U93tCtTSy7fnMn/ePqepdWQ1FkJSOj+KePnVB31fRj6UdpuuIa2aU=
X-Google-Smtp-Source: AGHT+IF3TVpt8m/3GTeruhsZYMkhmQI8kiXJq/ogBfkE96q6mWjTjrIbrTtCT8WkBJlq51AAuGo6kY1VhwLbdWiL9+s=
X-Received: by 2002:ac8:7c4b:0:b0:4d9:1d03:83c9 with SMTP id
 d75a77b69052e-4ed074b618emr33738431cf.25.1761634654970; Mon, 27 Oct 2025
 23:57:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202510281337.398a9aa9-lkp@intel.com>
In-Reply-To: <202510281337.398a9aa9-lkp@intel.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 27 Oct 2025 23:57:24 -0700
X-Gm-Features: AWmQ_bmYXPufvQIaY0cpTew1tIm58K--VeCxV36sQymZlOWS-VZuO0hYIQ9G1Vo
Message-ID: <CANn89i+bQ6xM7QU86hJ-J3dLih-QsTkXgP4r_iAuVhGTX8gsDQ@mail.gmail.com>
Subject: Re: [linus:master] [net] 16c610162d: netperf.Throughput_tps 17.2% regression
To: kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org, 
	Jakub Kicinski <kuba@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 27, 2025 at 11:26=E2=80=AFPM kernel test robot
<oliver.sang@intel.com> wrote:
>
>
>
> Hello,
>
> kernel test robot noticed a 17.2% regression of netperf.Throughput_tps on=
:
>
>
> commit: 16c610162d1f1c332209de1c91ffb09b659bb65d ("net: call cond_resched=
() less often in __release_sock()")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
>
> [still regression on      linus/master dcb6fa37fd7bc9c3d2b066329b0d27dedf=
8becaa]
> [still regression on linux-next/master 8fec172c82c2b5f6f8e47ab837c1dc91ee=
3d1b87]
>
> testcase: netperf
> config: x86_64-rhel-9.4
> compiler: gcc-14
> test machine: 192 threads 2 sockets Intel(R) Xeon(R) 6740E  CPU @ 2.4GHz =
(Sierra Forest) with 256G memory
> parameters:
>
>         ip: ipv4
>         runtime: 300s
>         nr_threads: 200%
>         cluster: cs-localhost
>         test: TCP_CRR
>         cpufreq_governor: performance
>
>
>

I will not consider this as a regression.

If anyone is interested, they would have to investigate if TCP_CRR on
localhost is
a really interesting metric, and why this would depend  on
cond_resched() in __release_sock()

Thank you.

>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202510281337.398a9aa9-lkp@intel.=
com
>
>
> Details are as below:
> -------------------------------------------------------------------------=
------------------------->
>
>
> The kernel config and materials to reproduce are available at:
> https://download.01.org/0day-ci/archive/20251028/202510281337.398a9aa9-lk=
p@intel.com
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> cluster/compiler/cpufreq_governor/ip/kconfig/nr_threads/rootfs/runtime/tb=
ox_group/test/testcase:
>   cs-localhost/gcc-14/performance/ipv4/x86_64-rhel-9.4/200%/debian-13-x86=
_64-20250902.cgz/300s/lkp-srf-2sp3/TCP_CRR/netperf
>
> commit:
>   abfa70b380 ("Merge branch 'tcp-__tcp_close-changes'")
>   16c610162d ("net: call cond_resched() less often in __release_sock()")
>
> abfa70b380348cf4 16c610162d1f1c332209de1c91f
> ---------------- ---------------------------
>          %stddev     %change         %stddev
>              \          |                \
>       2.80            -0.4        2.43 =C4=85  3%  mpstat.cpu.all.usr%
>     199581 =C4=85 96%     -75.4%      49072 =C4=85 64%  numa-meminfo.node=
0.Mapped
>    6583442 =C4=85  6%     -30.2%    4594175 =C4=85  5%  numa-numastat.nod=
e0.local_node
>    6709344 =C4=85  6%     -30.4%    4672973 =C4=85  5%  numa-numastat.nod=
e0.numa_hit
>      50277 =C4=85 96%     -75.4%      12383 =C4=85 63%  numa-vmstat.node0=
.nr_mapped
>    6708267 =C4=85  6%     -30.3%    4672365 =C4=85  5%  numa-vmstat.node0=
.numa_hit
>    6582364 =C4=85  6%     -30.2%    4593568 =C4=85  5%  numa-vmstat.node0=
.numa_local
>     224.83 =C4=85100%    +224.8%     730.17 =C4=85 36%  perf-c2c.DRAM.loc=
al
>       1438 =C4=85100%    +132.4%       3343 =C4=85 11%  perf-c2c.DRAM.rem=
ote
>       1569 =C4=85100%    +115.5%       3383 =C4=85 10%  perf-c2c.HITM.loc=
al
>       1089 =C4=85100%    +121.1%       2408 =C4=85 10%  perf-c2c.HITM.rem=
ote
>   14776381 =C4=85  9%     -21.6%   11587148 =C4=85  8%  proc-vmstat.numa_=
hit
>   14576750 =C4=85  9%     -21.9%   11387471 =C4=85  8%  proc-vmstat.numa_=
local
>   51492399 =C4=85  6%     -26.1%   38054262 =C4=85  5%  proc-vmstat.pgall=
oc_normal
>   48277971 =C4=85  5%     -26.9%   35310227 =C4=85  5%  proc-vmstat.pgfre=
e
>    2874230           -17.2%    2379822        netperf.ThroughputBoth_tota=
l_tps
>       7484           -17.2%       6197        netperf.ThroughputBoth_tps
>    2874230           -17.2%    2379822        netperf.Throughput_total_tp=
s
>       7484           -17.2%       6197        netperf.Throughput_tps
>  1.351e+09           -13.7%  1.165e+09        netperf.time.involuntary_co=
ntext_switches
>       9145            +7.8%       9855        netperf.time.percent_of_cpu=
_this_job_got
>      27055            +8.4%      29322        netperf.time.system_time
>     927.87           -11.1%     824.49        netperf.time.user_time
>  1.975e+08 =C4=85  5%     -28.2%  1.418e+08 =C4=85  6%  netperf.time.volu=
ntary_context_switches
>  8.623e+08           -17.2%  7.139e+08        netperf.workload
>    7908218 =C4=85  8%     +33.3%   10540980 =C4=85  7%  sched_debug.cfs_r=
q:/.avg_vruntime.stddev
>       2.27           -10.2%       2.04        sched_debug.cfs_rq:/.h_nr_q=
ueued.avg
>      11.92 =C4=85  7%     -18.9%       9.67 =C4=85  8%  sched_debug.cfs_r=
q:/.h_nr_queued.max
>       2.33 =C4=85  5%     -13.6%       2.02 =C4=85  4%  sched_debug.cfs_r=
q:/.h_nr_queued.stddev
>       5.14 =C4=85 27%     -50.8%       2.53 =C4=85 51%  sched_debug.cfs_r=
q:/.load_avg.min
>    7908224 =C4=85  8%     +33.3%   10540996 =C4=85  7%  sched_debug.cfs_r=
q:/.min_vruntime.stddev
>     245718 =C4=85  4%     -10.4%     220184 =C4=85  8%  sched_debug.cpu.m=
ax_idle_balance_cost.stddev
>       2.26           -10.2%       2.03        sched_debug.cpu.nr_running.=
avg
>       2.33 =C4=85  5%     -13.8%       2.01 =C4=85  4%  sched_debug.cpu.n=
r_running.stddev
>    8021905           -16.0%    6738879        sched_debug.cpu.nr_switches=
.avg
>   10163286           -20.5%    8082726 =C4=85  2%  sched_debug.cpu.nr_swi=
tches.max
>    1494738 =C4=85 14%     -50.1%     745542 =C4=85  9%  sched_debug.cpu.n=
r_switches.stddev
>  6.417e+10           -16.1%  5.383e+10        perf-stat.i.branch-instruct=
ions
>       0.52            -0.0        0.49        perf-stat.i.branch-miss-rat=
e%
>  3.329e+08           -21.1%  2.628e+08        perf-stat.i.branch-misses
>   49601635 =C4=85  8%     -15.1%   42090142 =C4=85  6%  perf-stat.i.cache=
-misses
>  2.238e+08           -11.6%  1.979e+08 =C4=85  2%  perf-stat.i.cache-refe=
rences
>   10160912           -15.7%    8567209        perf-stat.i.context-switche=
s
>       1.74           +20.0%       2.09        perf-stat.i.cpi
>       2679 =C4=85  7%     -22.9%       2067 =C4=85  3%  perf-stat.i.cpu-m=
igrations
>      12544 =C4=85  7%     +17.2%      14707 =C4=85  5%  perf-stat.i.cycle=
s-between-cache-misses
>  3.464e+11           -16.3%  2.898e+11        perf-stat.i.instructions
>       0.58           -16.4%       0.49        perf-stat.i.ipc
>      52.92           -15.7%      44.62        perf-stat.i.metric.K/sec
>       0.52            -0.0        0.49        perf-stat.overall.branch-mi=
ss-rate%
>       1.74           +19.4%       2.07        perf-stat.overall.cpi
>      12209 =C4=85  8%     +17.3%      14320 =C4=85  6%  perf-stat.overall=
.cycles-between-cache-misses
>       0.58           -16.3%       0.48        perf-stat.overall.ipc
>     122980            +1.1%     124361        perf-stat.overall.path-leng=
th
>  6.398e+10           -16.1%  5.367e+10        perf-stat.ps.branch-instruc=
tions
>  3.319e+08           -21.1%   2.62e+08        perf-stat.ps.branch-misses
>   49465671 =C4=85  8%     -15.1%   41971976 =C4=85  6%  perf-stat.ps.cach=
e-misses
>  2.231e+08           -11.6%  1.973e+08 =C4=85  2%  perf-stat.ps.cache-ref=
erences
>   10129507           -15.7%    8540638        perf-stat.ps.context-switch=
es
>       2669 =C4=85  7%     -22.8%       2061 =C4=85  3%  perf-stat.ps.cpu-=
migrations
>  3.454e+11           -16.3%   2.89e+11        perf-stat.ps.instructions
>   1.06e+14           -16.3%  8.879e+13        perf-stat.total.instruction=
s
>
>
>
>
> Disclaimer:
> Results have been estimated based on internal Intel analysis and are prov=
ided
> for informational purposes only. Any difference in system hardware or sof=
tware
> design or configuration may affect actual performance.
>
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
>

