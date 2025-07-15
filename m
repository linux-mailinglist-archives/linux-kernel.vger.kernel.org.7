Return-Path: <linux-kernel+bounces-731354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 725E9B05330
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 09:30:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7FD6F7A1FD2
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 07:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4925A26E710;
	Tue, 15 Jul 2025 07:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="N4y/hDES"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D75525E813
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 07:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752564161; cv=none; b=eYZpYFyvQv+2iaS6c7HFJ5YlioHfZhH1Haij0prNd2ezgYiScv15fSe3TlQC49ks9zObAQmCJ004DiZkkjbAjf8sLZDwutCTf7304TFRsT3lk/2o2bi/y2KmHHxZ0Jol7edBgYSTApq5w4VGofNdbYA7AOFHg/fd51pLvPbsy+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752564161; c=relaxed/simple;
	bh=9OHKks1tYHDu0M84E3pDg2s5fX4oG+ZAcZqnElV1ME0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y6uyaH4LWH27fQRsc+6CM8MeGT0kHR6vHlXdH2EMHwgZ/LvAxoNi4zfQmlk2+riA24lpN85cT1rjdnBMOq71hV2IudSQwWd8WOzn4PWHCY19mTIx0HU2gbVCjSPmoFAyasBQxSsxQfM1xSzPFRQO1pcOP5re0R6fM1MLJ617vKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=N4y/hDES; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7425bd5a83aso4335140b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 00:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1752564157; x=1753168957; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QoMlosN0pfoGTrSa0yltZrSMjbkFfVMdsv/yBkAd/nI=;
        b=N4y/hDESVIJlzmI6tyNmeT7skgf1KhsR1W2C7mn/9U4VxEcTlKIyz99vz+ug+MjFbJ
         9iXOP7xBpKE2fXdRI2li2wLYwgVeqfMGqM5CUZz3TKkskCdINkpNtNPXUvkoQ4XmjQ5e
         v4YK2rXiW1nJCnZlNCOEnK0oEtnsgHi5jWhAbXnHLRtJkCw6l0Grtre3GyQL9FZo6TYd
         w1bdbqypqiKc/5jpGwk7TUip9vs4POx2VczQlfoVb7iKmE6elinMi9hCVCUljG5JEDsl
         g5GZicqDA9TPn4hs4tlLAROhHuVeE8gxzuDoF7g4YHZyJL6oLaErAumplk6gMBOTM5m3
         BhZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752564157; x=1753168957;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QoMlosN0pfoGTrSa0yltZrSMjbkFfVMdsv/yBkAd/nI=;
        b=p8CsMjCSQE+svry2aipKAvP6QbiHoqS9E5sdecvg4D+VzWzFtS20JOJ6ZKeODQSTF4
         BAcP7Oe/nsNpqxBVihboLyRpBhqk6BUWhtd0Zvud9nIP9OohDdwoXDrbBptN/q3jlE66
         j45M7tuZTXKaVauHt1uILX1h2YqSNrBGWweblXkII3a0qRWL81ni2bbVazPFjDi3IOxL
         e9xBctxaS8vvS+YzyINFWyjtDnUclSZKl0H+dCUR2dPWCmWWlM+GYyOsxqe7QMABzXhn
         WSfCWBjVbVBePi/oz+1rWN3qC/vpFH8KD8keq69bMqP/7OViasyNBLLfWPR2Bm6TQWRN
         7ueg==
X-Gm-Message-State: AOJu0Yw+V0F2hp1w/bqEDtp619dEmF9+lo56WelsEFcotRf0KMBVlDwP
	R1aMLQoGDDVy0tdFkrsH8zEPMBFq0SLDuMBPxKbO6OuU9Q+tkun+PWyPQ58VoBxfNw==
X-Gm-Gg: ASbGncvuTHGnqPyhYoRBlZboSJiXb8qUCjKigTIzZl6ZONcPrgXUf6Z1AKg1e9oLoJL
	dCuJCF87YWV20aV5XIiU7FwXYwVCE1AQiGMsJgD5/IVYohEyNkW2wwnxVJ9IQLkxGtKyxuzyGh5
	2FdFdAFlctqralVh9P6Jg2ntBIzA5k+G75dAvk0tdVeRtagt+YkE22w4PLjWeqCsd7sdJAg2XRm
	59WYuZyYKPiZy08EyWJKxj+3S8VEot3UOlLGYPMyfNdKUbOaMJL0x5UAe7seierWxhTbzzjGO2v
	4TVzxOGyon9N9BXLt86NY5zKMrsC4dVCKJrDa7SB2bv87taIofo69MG/XK/TmTYx6V45teCDiNK
	+eF0X0M3jonUixH0yWHkBZIZyI5P1qcwa6IOj1RYBuzU=
X-Google-Smtp-Source: AGHT+IFm5qVCNXQtsiJ9VhxpQrQNrBXDXzTZNybDWeX2bPBvYqpzUKl/rmxMWqHBD2o4M1HrtEE62Q==
X-Received: by 2002:a05:6a21:c98:b0:220:2a63:732f with SMTP id adf61e73a8af0-231369572d4mr24618463637.19.1752564157158;
        Tue, 15 Jul 2025 00:22:37 -0700 (PDT)
Received: from bytedance ([61.213.176.56])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9e064a9sm11473323b3a.47.2025.07.15.00.22.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 00:22:36 -0700 (PDT)
Date: Tue, 15 Jul 2025 15:22:18 +0800
From: Aaron Lu <ziqianlu@bytedance.com>
To: Valentin Schneider <vschneid@redhat.com>,
	Ben Segall <bsegall@google.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Josh Don <joshdon@google.com>, Ingo Molnar <mingo@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Xi Wang <xii@google.com>
Cc: linux-kernel@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>, Mel Gorman <mgorman@suse.de>,
	Chuyi Zhou <zhouchuyi@bytedance.com>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Florian Bezdeka <florian.bezdeka@siemens.com>,
	Songtang Liu <liusongtang@bytedance.com>
Subject: Re: [PATCH v3 0/5] Defer throttle when task exits to user
Message-ID: <20250715072218.GA304@bytedance>
References: <20250715071658.267-1-ziqianlu@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="DfAmlKlPMWEzvqPH"
Content-Disposition: inline
In-Reply-To: <20250715071658.267-1-ziqianlu@bytedance.com>


--DfAmlKlPMWEzvqPH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 15, 2025 at 03:16:53PM +0800, Aaron Lu wrote:
> - A stress test that creates a lot of pressure on fork/exit path and
>   cgroup_threadgroup_rwsem. Without this series, the test will cause
>   task hung in about 5 minutes and with this series, no problem found
>   after several hours. Songtang wrote this test script and I've used it
>   to verify the patches, thanks Songtang.

Test scripts attached.

--DfAmlKlPMWEzvqPH
Content-Type: application/x-sh
Content-Disposition: attachment; filename="cg.sh"
Content-Transfer-Encoding: quoted-printable

#!/bin/bash=0A#=0A# Author: Songtang Liu <liusongtang@bytedance.com>=0A#=0A=
# This script moves tasks around different cgroups to create pressure on cg=
roup_threadgroup_rwsem.=0A# Run this script as root with two params represe=
nting two cgroup names, with each cgroup having=0A# a 16cpu quota so the VM=
 has to have more than 32 vCPUs. Run it like this:=0A# #./cg.sh s1 s2=0A=0A=
=2E/test.sh $1 &=0At1=3D$!=0A=0A./test.sh $2 &=0At2=3D$!=0A=0Acleanup() {=
=0A	echo "Cleaning up..."=0A	kill -s SIGINT $t1 $t2 $sleep_test $cat_test=
=0A	killall test.sh=0A	pids=3D$(pgrep stress-ng)=0A	kill $pids=0A	killall c=
g.sh=0A	exit=0A}=0Atrap cleanup SIGINT=0A=0ACG=3D/sys/fs/cgroup=0ACG1=3D${C=
G}/$1=0ACG2=3D${CG}/$2=0A=0A# move tasks around cgroups=0Awhile true; do=0A=
	list1=3D$(cat ${CG1}/cgroup.procs)=0A	list2=3D$(cat ${CG2}/cgroup.procs)=
=0A	for pid in $list1; do=0A		# echo $pid  ${CGROUP_PATH}/cgroup.procs ${CG=
ROUP_ROOT}/cgroup.procs=0A		echo "move $pid to CG2"=0A		echo $pid > ${CG2}/=
cgroup.procs 2>&1=0A	done=0A=0A	for pid in $list2; do=0A		# echo $pid  ${CG=
ROUP_PATH}/cgroup.procs ${CGROUP_ROOT}/cgroup.procs=0A		echo "move $pid to =
CG1"=0A		echo $pid > ${CG1}/cgroup.procs 2>&1=0A	done=0Adone=0A
--DfAmlKlPMWEzvqPH
Content-Type: application/x-sh
Content-Disposition: attachment; filename="test.sh"
Content-Transfer-Encoding: quoted-printable

#!/bin/bash=0A=0A# Author: Songtang Liu <liusongtang@bytedance.com>=0A#=0A#=
 This script creates a lot of pressure in fork/exit path as well as some ot=
her paths in kernel mode.=0A# Called by cg.sh, see cg.sh's comments.=0A=0AC=
GROUP_ROOT=3D"/sys/fs/cgroup"=0ACGROUP_NAME=3D$1=0ACGROUP_PATH=3D"${CGROUP_=
ROOT}/${CGROUP_NAME}"=0Acleanup() {=0A	echo "Cleaning up..."=0A	kill $sleep=
_pid $WRITE_PID $CPU_PID $FORK_PID $NETLINK_PID $READ_PID $MOVE_PID $TEST_P=
ID  2>/dev/null=0A	pids=3D$(cat "${CGROUP_PATH}/cgroup.procs")=0A	for pid i=
n $pids; do=0A		kill $pid 2>/dev/null=0A	done=0A	pids=3D$(pgrep stress-ng)=
=0A	kill $pids=0A	rmdir $CGROUP_PATH=0A	exit=0A}=0Atrap cleanup SIGINT=0A=
=0Amkdir -p $CGROUP_PATH=0Aecho "+cpu +memory +pids" > $CGROUP_ROOT/cgroup.=
subtree_control=0Aecho "1600000 100000" > ${CGROUP_PATH}/cpu.max=0Aecho "34=
G" > ${CGROUP_PATH}/memory.max=0Aecho $$ > ${CGROUP_PATH}/cgroup.procs=0A=
=0Awhile true; do=0A	echo $$ > ${CGROUP_PATH}/cgroup.procs=0A	stress-ng --v=
m 16 -t 60h --vm-bytes 2G --aggressive >/dev/null 2>&1=0Adone &=0AMEM_PID=
=3D$!=0A=0Asleep 1000000000 &=0Asleep_pid=3D$!=0Awhile true; do=0A	echo $sl=
eep_pid > ${CGROUP_PATH}/cgroup.procs &=0A	echo $sleep_pid > ${CGROUP_ROOT}=
/cgroup.procs &=0Adone &=0AWRITE_PID=3D$!=0A=0Aclass=3Dnetwork=0A# class=3D=
os=0Awhile true; do=0A	echo $$ > ${CGROUP_PATH}/cgroup.procs=0A	stress-ng -=
-class $class --all 0 -t 1 --aggressive  &>/dev/null=0Adone &=0A=0Awhile tr=
ue; do=0A	echo $$ > ${CGROUP_PATH}/cgroup.procs=0A	stress-ng --class $class=
 --all 0 -t 1 --aggressive  &>/dev/null=0Adone &=0A=0Awhile true; do=0A	ech=
o $$ > ${CGROUP_PATH}/cgroup.procs=0A	stress-ng --class $class --all 0 -t 1=
 --aggressive  &>/dev/null=0Adone &=0A=0Awhile true; do=0A	echo $$ > ${CGRO=
UP_PATH}/cgroup.procs=0A	stress-ng --class $class --all 0 -t 1 --aggressive=
  &>/dev/null=0Adone &=0A=0Astress-ng --class $class --all 0 -t 1 --aggress=
ive  &>/dev/null=0A=0A# stress-ng --class $class --all 0 -t 60m --aggressiv=
e  &>/dev/null=0ANETLINK_PID=3D$!=0Awhile true; do=0A	echo $$ > ${CGROUP_PA=
TH}/cgroup.procs=0A	stress-ng --fork 1000 -t 1 --aggressive &>/dev/null=0Ad=
one &=0ATEST_PID=3D$!=0A=0Astress-ng --fork 1000 -t 60h --aggressive &>/dev=
/null=0A=0A# while true; do=0A#   echo $$ > ${CGROUP_PATH}/cgroup.procs=0A#=
   ssh -t root@10.37.89.113 "cat /proc/cgroups"  > /dev/null=0A# done &=0A=
=0Await=0A
--DfAmlKlPMWEzvqPH--

