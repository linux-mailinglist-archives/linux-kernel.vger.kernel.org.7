Return-Path: <linux-kernel+bounces-895449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 80938C4DE6C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 13:54:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B3D6E4F2E2B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 12:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA18E324709;
	Tue, 11 Nov 2025 12:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="PsYvOGtK"
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C60D13AA18C
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 12:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762864889; cv=none; b=cNK7K/JedSP/g/2Ig+fkhH+0oOYNTCEx+KfSGzldS7qG+uPblUz+wx7nbwbcp/MbJcrkUELKHxw1P6fCZpHXtgajWw1at2vaMzlVG2dZvNFw0B5B0a9OIjdUMGfc6PdXkLe+eJ+RY1voLatu+4K9NdfhGhFQnDcgevA7edNdnLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762864889; c=relaxed/simple;
	bh=9xfPxgCLwxDWC5uci7Tam0tmDzUGxKMfBCJoi5gKe1Y=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:From:To:Cc:
	 References:In-Reply-To; b=LCj3j0ZGdr358CdGKLH2v7je3jDDofml2CEFHbKYg2XmN0lZoR1DGnedl7yj/XLd5kmOI4toiNEx2BDhQ8gmGRCNqy5JhTYPlwZhQaGAtdqn9tlWUwfmEoyI23K8mRCzqbG/xpKOcAuRGhnBY2LKsWfpMdZzYaVehXOPh3iKi0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=PsYvOGtK; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4d5R3k5z7Rz9tmC;
	Tue, 11 Nov 2025 13:41:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1762864882;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YaqLqGN9uEL7J+fQAaVt6gXOp13qBprJ55CUYxPRXWY=;
	b=PsYvOGtKywmYqU2YST64pri4JLscxq2SxIRuEHRw7c3GIlX+MY3LK2Ay1BP1SIblCZPU1f
	hWJHOVxY1E6mVCiBALDoHwg+5e+jJNFNmO+Os0Ai2o7Qg/4R7eMH+7YK6CtXVDp+r78vJL
	9hEdYtyBUkdanu6aK/HfWgd+fgp0ITe8XQ/xqVIvrMBx0Ir0usjqc1khtrlTJYj+01SMD+
	cDaC1113noCWYfVEk7KmyqIBlEHx6TxMTABmPLwLTK08L28Pt9GJWufHporvXfRtFTmHs0
	yPYVRC2MZIjHNmttVmZ7vRFeWrJF1SyL6clRZy8uhErXaf0sQMQCz7RUxhUVDw==
Content-Type: multipart/mixed; boundary="------------c8xoJb3xBtNTMKbm6r52N0KM"
Message-ID: <5145f071-c8bd-4b9d-94b1-2afe651cf25a@mailbox.org>
Date: Tue, 11 Nov 2025 13:41:21 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: BUG: spinlock bad magic on CPU#1, irq/39-firewire/245 (v6.18-rc4,
 ppc64)
From: Erhard Furtner <erhard_f@mailbox.org>
To: linux-kernel@vger.kernel.org
Cc: Takashi Sakamoto <o-takashi@sakamocchi.jp>,
 linux1394-devel@lists.sourceforge.net
References: <992eaf94-6fbb-4611-9a29-2db2e2148965@mailbox.org>
Content-Language: en-US, de-DE
In-Reply-To: <992eaf94-6fbb-4611-9a29-2db2e2148965@mailbox.org>
X-MBO-RS-ID: c205490f944b71ac2e7
X-MBO-RS-META: o94pfpre3ca4mjfaqwjri7ry1ojuarf1

This is a multi-part message in MIME format.
--------------c8xoJb3xBtNTMKbm6r52N0KM
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/9/25 15:17, Erhard Furtner wrote:
> [...]
> firewire_ohci 0001:03:0e.0: added OHCI v1.0 device as card 0, 8 IR + 8 
> IT contexts, quirks 0x0
> BUG: spinlock bad magic on CPU#1, irq/39-firewire/245
>   lock: 0xc00000001f672618, .magic: 00000000, .owner: irq/39- 
> firewire/245, .owner_cpu: 1
> CPU: 1 UID: 0 PID: 245 Comm: irq/39-firewire Tainted: G N  6.18.0-rc4- 
> PMacG5 #1 PREEMPTLAZY
> Tainted: [N]=TEST
> Hardware name: PowerMac11,2 PPC970MP 0x440101 PowerMac
> Call Trace:
> [c000000005dafb20] [c000000000bc054c] __dump_stack+0x30/0x54 (unreliable)
> [c000000005dafb50] [c000000000bc04e4] dump_stack_lvl+0x98/0xd0
> [c000000005dafb90] [c0000000000f22a8] spin_dump+0x88/0xb4
> [c000000005dafc10] [c0000000000f1d4c] do_raw_spin_unlock+0xdc/0x164
> [c000000005dafc50] [c000000000bf65d0] _raw_spin_unlock+0x18/0x68
> [c000000005dafc70] [c0003d0013ce1d5c] 
> fw_core_handle_bus_reset+0xa98/0xb64 [firewire_core]
> [c000000005dafdc0] [c0003d0013d19aec] 
> handle_selfid_complete_event+0x610/0x764 [firewire_ohci]
> [c000000005dafe80] [c000000000106050] irq_thread_fn+0x40/0x9c
> [c000000005dafec0] [c000000000105ecc] irq_thread+0x1c0/0x298
> [c000000005daff60] [c0000000000b5e54] kthread+0x250/0x280
> [c000000005daffe0] [c00000000000bd30] start_kernel_thread+0x14/0x18
I bisected the issue. First bad commit is:

  # git bisect good
7d138cb269dbd2fa9b0da89a9c10503d1cf269d5 is the first bad commit
commit 7d138cb269dbd2fa9b0da89a9c10503d1cf269d5
Author: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Date:   Tue Sep 16 08:47:44 2025 +0900

     firewire: core: use spin lock specific to topology map

     At present, the operation for read transaction to topology map 
register is
     not protected by any kind of lock primitives. This causes a potential
     problem to result in the mixed content of topology map.

     This commit adds and uses spin lock specific to topology map.

     Link: 
https://lore.kernel.org/r/20250915234747.915922-4-o-takashi@sakamocchi.jp
     Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>

  drivers/firewire/core-topology.c    | 22 ++++++++++++++--------
  drivers/firewire/core-transaction.c |  6 +++++-
  include/linux/firewire.h            |  6 +++++-
  3 files changed, 24 insertions(+), 10 deletions(-)


Bisect.log attached.

Regards,
Erhard F.
--------------c8xoJb3xBtNTMKbm6r52N0KM
Content-Type: text/x-log; charset=UTF-8; name="bisect.log"
Content-Disposition: attachment; filename="bisect.log"
Content-Transfer-Encoding: base64

Z2l0IGJpc2VjdCBzdGFydAojIFN0YXR1czogd2FydGUgYXVmIGd1dGVuIHVuZCBzY2hsZWNo
dGVuIENvbW1pdAojIGdvb2Q6IFtlNWYwYTY5OGIzNGVkNzYwMDJkYzVjZmYzODA0YTYxYzgw
MjMzYTdhXSBMaW51eCA2LjE3CmdpdCBiaXNlY3QgZ29vZCBlNWYwYTY5OGIzNGVkNzYwMDJk
YzVjZmYzODA0YTYxYzgwMjMzYTdhCiMgU3RhdHVzOiB3YXJ0ZSBhdWYgc2NobGVjaHRlbiBD
b21taXQsIDEgZ3V0ZXIgQ29tbWl0IGJla2FubnQKIyBiYWQ6IFtlOWE2ZmIwYmNkZDc2MDli
ZTY5NjkxMTJmM2ZiZmNjZTNiMWQ0YTdjXSBMaW51eCA2LjE4LXJjNQpnaXQgYmlzZWN0IGJh
ZCBlOWE2ZmIwYmNkZDc2MDliZTY5NjkxMTJmM2ZiZmNjZTNiMWQ0YTdjCiMgYmFkOiBbZjc5
ZTc3MjI1OGRmMzExYzJjYjIxNTk0Y2EwOTk2MzE4ZTcyMGQyOF0gTWVyZ2UgdGFnICdtZWRp
YS92Ni4xOC0xJyBvZiBnaXQ6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5l
bC9naXQvbWNoZWhhYi9saW51eC1tZWRpYQpnaXQgYmlzZWN0IGJhZCBmNzllNzcyMjU4ZGYz
MTFjMmNiMjE1OTRjYTA5OTYzMThlNzIwZDI4CiMgYmFkOiBbMGYwNDhjODc4ZWUzMmE0MjU5
ZGJmMjhlMGFkOGZkMGI3MWVlMDA4NV0gTWVyZ2UgdGFnICdzb2MtZHQtNi4xOCcgb2YgZ2l0
Oi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3NvYy9zb2MKZ2l0
IGJpc2VjdCBiYWQgMGYwNDhjODc4ZWUzMmE0MjU5ZGJmMjhlMGFkOGZkMGI3MWVlMDA4NQoj
IGdvb2Q6IFtjMDUwZGFmNjlmM2VkZjcyZTI3NGVhYTMyMWY2NjNiMTc3OWM0MzkxXSBNZXJn
ZSB0YWcgJ3B3bS9mb3ItNi4xOC1yYzEnIG9mIGdpdDovL2dpdC5rZXJuZWwub3JnL3B1Yi9z
Y20vbGludXgva2VybmVsL2dpdC91a2xlaW5lay9saW51eApnaXQgYmlzZWN0IGdvb2QgYzA1
MGRhZjY5ZjNlZGY3MmUyNzRlYWEzMjFmNjYzYjE3NzljNDM5MQojIGJhZDogWzk3OTJkNjYw
YTRlOTFkMzFhNmIxYWYxMDVhZTNmMWMyOTEwN2U5NGJdIE1lcmdlIHRhZyAnZGV2aWNldHJl
ZS1mb3ItNi4xOCcgb2YgZ2l0Oi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJu
ZWwvZ2l0L3JvYmgvbGludXgKZ2l0IGJpc2VjdCBiYWQgOTc5MmQ2NjBhNGU5MWQzMWE2YjFh
ZjEwNWFlM2YxYzI5MTA3ZTk0YgojIGJhZDogW2YwN2MzNjk1YmY2NTIyMGE2OWE4NDg0Nzhi
ZDkwOTliZGVhYWZhNzhdIE1lcmdlIHRhZyAnZmlyZXdpcmUtdXBkYXRlcy02LjE4JyBvZiBn
aXQ6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvaWVlZTEzOTQv
bGludXgxMzk0CmdpdCBiaXNlY3QgYmFkIGYwN2MzNjk1YmY2NTIyMGE2OWE4NDg0NzhiZDkw
OTliZGVhYWZhNzgKIyBnb29kOiBbZWExYzZjNTkyNTIyMjA4ZGYxZGNhYzllOGYxZGViN2Nj
NTZhNTFiN10gTWVyZ2UgdGFnICdzcGktdjYuMTgnIG9mIGdpdDovL2dpdC5rZXJuZWwub3Jn
L3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9icm9vbmllL3NwaQpnaXQgYmlzZWN0IGdvb2Qg
ZWExYzZjNTkyNTIyMjA4ZGYxZGNhYzllOGYxZGViN2NjNTZhNTFiNwojIGdvb2Q6IFsyZDI3
NDUzNjI0NWI1OGE0Mzc1M2EyM2Q4NGRmYWRjOWRmMWRmNDg5XSBNZXJnZSB0YWcgJ21tYy12
Ni4xOCcgb2YgZ2l0Oi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0
L3VsZmgvbW1jCmdpdCBiaXNlY3QgZ29vZCAyZDI3NDUzNjI0NWI1OGE0Mzc1M2EyM2Q4NGRm
YWRjOWRmMWRmNDg5CiMgZ29vZDogW2I0OTE4MDAzY2Y1NGY5OTAwNGMxMzZjMjZmOTZiNmRm
N2FiNDlmYWNdIE1lcmdlIHRhZyAnbWZkLW5leHQtNi4xOCcgb2YgZ2l0Oi8vZ2l0Lmtlcm5l
bC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L2xlZS9tZmQKZ2l0IGJpc2VjdCBnb29k
IGI0OTE4MDAzY2Y1NGY5OTAwNGMxMzZjMjZmOTZiNmRmN2FiNDlmYWMKIyBiYWQ6IFtlMzFi
OTkwY2FmZDQ5YThjNTZlYWM1NTA5NGMxYTc4M2Y1ODI2YjQ3XSBmaXJld2lyZTogY29yZTog
Y29kZSByZWZhY3RvcmluZyBmb3IgdGhlIGNhc2Ugb2YgZ2VuZXJhdGlvbiBtaXNtYXRjaApn
aXQgYmlzZWN0IGJhZCBlMzFiOTkwY2FmZDQ5YThjNTZlYWM1NTA5NGMxYTc4M2Y1ODI2YjQ3
CiMgZ29vZDogW2E0YmFjNTVkOTlkMzc5NzYyMDllMmZjMmMzMmJkM2RmYzg2YjA0NDddIGZp
cmV3aXJlOiBjb3JlOiBjb2RlIHJlZmFjdG9yaW5nIHdoZXRoZXIgcm9vdCBub2RlIGlzIGN5
Y2xlIG1hc3RlciBjYXBhYmxlCmdpdCBiaXNlY3QgZ29vZCBhNGJhYzU1ZDk5ZDM3OTc2MjA5
ZTJmYzJjMzJiZDNkZmM4NmIwNDQ3CiMgYmFkOiBbNDIwYmQ3MDY4Y2JmYWVhMGE4NTc0NzJk
ZDYzMWRjNDgzMTFlMmE4Zl0gZmlyZXdpcmU6IGNvcmU6IHVzZSBzcGluIGxvY2sgc3BlY2lm
aWMgdG8gdHJhbnNhY3Rpb24KZ2l0IGJpc2VjdCBiYWQgNDIwYmQ3MDY4Y2JmYWVhMGE4NTc0
NzJkZDYzMWRjNDgzMTFlMmE4ZgojIGdvb2Q6IFszNzliODcwYzI4YzZhNjE1YTEwMWRmNzk4
NmViYTcwZmVhOTllZmY3XSBmaXJld2lyZTogY29yZTogdXNlIGhlbHBlciBtYWNyb3MgaW5z
dGVhZCBvZiBkaXJlY3QgYWNjZXNzIHRvIEhaCmdpdCBiaXNlY3QgZ29vZCAzNzliODcwYzI4
YzZhNjE1YTEwMWRmNzk4NmViYTcwZmVhOTllZmY3CiMgZ29vZDogWzgwYzViMDIzYTdkNmFl
NDFiZDc5YWFkZWNlNGNiMWZjNjJlOTVhMDhdIGZpcmV3aXJlOiBjb3JlOiB1c2Ugc2NvcGVk
X2d1YXJkKCkgdG8gbWFuYWdlIGNyaXRpY2FsIHNlY3Rpb24gdG8gdXBkYXRlIHRvcG9sb2d5
CmdpdCBiaXNlY3QgZ29vZCA4MGM1YjAyM2E3ZDZhZTQxYmQ3OWFhZGVjZTRjYjFmYzYyZTk1
YTA4CiMgYmFkOiBbN2QxMzhjYjI2OWRiZDJmYTliMGRhODlhOWMxMDUwM2QxY2YyNjlkNV0g
ZmlyZXdpcmU6IGNvcmU6IHVzZSBzcGluIGxvY2sgc3BlY2lmaWMgdG8gdG9wb2xvZ3kgbWFw
CmdpdCBiaXNlY3QgYmFkIDdkMTM4Y2IyNjlkYmQyZmE5YjBkYTg5YTljMTA1MDNkMWNmMjY5
ZDUKIyBnb29kOiBbMDdjNDQ2ZTM1Yjg5YmM4Nzc0NzkyZjgwMzZlNTk1Y2ZmZGY1YjE2Ml0g
ZmlyZXdpcmU6IGNvcmU6IG1haW50YWluIHBoeSBwYWNrZXQgcmVjZWl2ZXJzIGxvY2FsbHkg
aW4gY2RldiBsYXllcgpnaXQgYmlzZWN0IGdvb2QgMDdjNDQ2ZTM1Yjg5YmM4Nzc0NzkyZjgw
MzZlNTk1Y2ZmZGY1YjE2MgojIGZpcnN0IGJhZCBjb21taXQ6IFs3ZDEzOGNiMjY5ZGJkMmZh
OWIwZGE4OWE5YzEwNTAzZDFjZjI2OWQ1XSBmaXJld2lyZTogY29yZTogdXNlIHNwaW4gbG9j
ayBzcGVjaWZpYyB0byB0b3BvbG9neSBtYXAK

--------------c8xoJb3xBtNTMKbm6r52N0KM--

