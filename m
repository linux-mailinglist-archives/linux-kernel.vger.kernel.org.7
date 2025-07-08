Return-Path: <linux-kernel+bounces-720746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3D49AFBFF5
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 03:27:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E2F44A7381
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 01:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 137C3201006;
	Tue,  8 Jul 2025 01:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="FZCX1bX8"
Received: from smtp153-171.sina.com.cn (smtp153-171.sina.com.cn [61.135.153.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EEA61C861A
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 01:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=61.135.153.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751937919; cv=none; b=KczPJKzygopzqEUgROvbUEVN/x/c3sIDLLK2oIrhNi+FYF8UsWF2DnSxgTgdgPcyRghUM2hiCTB414D5O/BpFaAlfq+HA+xLefk7i6im1ISC9PRhqr57rhzyMnf5hVUL8J4LBp6cSxFu8Xc/IRDvoXwcGp+QN7iSbkrqYj1Borc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751937919; c=relaxed/simple;
	bh=Aoxy5zHDYhuOjLXy/uAfYcRZossxBVN9vBXDcu4IAgo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZPza4qteVWI/Rok5acDuQInJqc4Olb7w+8dr5P6+2qg0dXiggjg3RxXNWojNE/4qM5+8I5hm2CyVTVeWnWepCVj126DQlr2nsrkbGuyHdQSeziZT94yfII4c3Tfkun9hw9sEQlZCSNiqXiDY642t07tak71MZvNN9kbbkqbyias=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=FZCX1bX8; arc=none smtp.client-ip=61.135.153.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1751937911;
	bh=cwQOjk547Zv2ATJFdaw5csYgtoidNunSGL/zW6G3ct0=;
	h=From:Subject:Date:Message-ID;
	b=FZCX1bX87MDFT3FCbXcpj3Izs0N3gdK2TYTFct2oc1TKjfLNy1THHQBl+AVIaa3os
	 FVRSdurcp4RuXdMEzpork3Z7uuN5Nxw17Y8ZcB11zF2s2egqCXP748cz/4MuSp4qV2
	 KyBoD8hdlR48YP1LWB9fM0BKT3lWyu1t3Ycbp4/g=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.34) with ESMTP
	id 686C736C00007618; Tue, 8 Jul 2025 09:25:02 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 2721056291940
X-SMAIL-UIID: 95D3E90001004F7D881C813250BA6C25-20250708-092502-1
From: Hillf Danton <hdanton@sina.com>
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: Bart Van Assche <bvanassche@acm.org>,
	axboe@kernel.dk,
	josef@toxicpanda.com,
	linux-block@vger.kernel.org,
	syzbot <syzbot+3dbc6142c85cc77eaf04@syzkaller.appspotmail.com>,
	Ming Lei <ming.lei@redhat.com>,
	linux-kernel@vger.kernel.org,
	nbd@other.debian.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [nbd?] possible deadlock in nbd_queue_rq
Date: Tue,  8 Jul 2025 09:24:49 +0800
Message-ID: <20250708012450.2858-1-hdanton@sina.com>
In-Reply-To: <b8769d22-fa19-4374-bbcc-be3f06f420bf@I-love.SAKURA.ne.jp>
References: <20250707005946.2669-1-hdanton@sina.com> <20250708001848.2775-1-hdanton@sina.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 8 Jul 2025 09:52:18 +0900 Tetsuo Handa wrote:
> On 2025/07/08 9:18, Hillf Danton wrote:
> > On Mon, 7 Jul 2025 10:39:44 -0700 Bart Van Assche wrote:
> >> On 7/6/25 5:59 PM, Hillf Danton wrote:
> >>> and given the second one, the report is false positive.
> >>
> >> Whether or not this report is a false positive, the root cause should be
> >> fixed because lockdep disables itself after the first circular locking
> >> complaint. From print_usage_bug() in kernel/locking/lockdep.c:
> >>
> >> 	if (!debug_locks_off() || debug_locks_silent)
> >> 		return;
> >>
> > The root cause could be walked around for example by trying not to init
> > nbd more than once.
> 
> How did you come to think so?
> 
Based on that nbd_init appears twice in the lock chain syzbot reported.

> nbd_init() is already called only once because of module_init(nbd_init).
> 
Ok Bart is misguiding.

