Return-Path: <linux-kernel+bounces-894277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11FA4C49A59
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 23:48:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8D98188908C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 22:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9312B2F531F;
	Mon, 10 Nov 2025 22:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="vFeoIFqT"
Received: from r3-23.sinamail.sina.com.cn (r3-23.sinamail.sina.com.cn [202.108.3.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D76213B58C
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 22:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762814879; cv=none; b=u627HvqeC7o50qd8cOgYpEENDLN2Z9KQ5vha9SbT3RqKP0VN3+yQk2ToXaTFOAJXFlfU0sjFmh0JNR409KIRGf3Wvz0G13YBCKjVZfAbvMVMSm/NmWMJCyqt6Ce0wBry6egowBEHE8q+loRIxe7lLAb7xN5Vx9eggVRfThrcatg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762814879; c=relaxed/simple;
	bh=OydZp37CSS1yBKAVmZYfbyg4vNiWGWOdrkM5hsTUXRA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OegXzoj48Q1g+3t1oWAeu17YzOvjSnJr4OmodxNqv1Up+X/yJPnHNLpsmTw8KJOYU26iVToPgHKiJzwfFdmPK62GSEQD2kqQ+8qeCIgEH52Uqbtflt2cbiOb+Jp732JN94FQImknNc9cNIWrVmWXcV3PiR5X4QhGfmdrgWDnb4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=vFeoIFqT; arc=none smtp.client-ip=202.108.3.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1762814875;
	bh=8wih+5IhT36X5XJTLFdUeBPvovcTWP/iP9SFEeosYgk=;
	h=From:Subject:Date:Message-ID;
	b=vFeoIFqTfdxXdL4UQ6dA5v1QImvTeqg2BVbInYqPFRtVogtnhSyeSG/18oMGmFFoY
	 kKCVbWDC9uOqB6TSEkek4Ucdz890h7kyhDAJUTsMrXyGi0ZtnWAGro/UI8Gl34Ievy
	 DRhPN5ECuZK5pRSi4UWa0LS60j80C+U/vjDjhAOo=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.57.85])
	by sina.com (10.54.253.31) with ESMTP
	id 69126B9000001A37; Mon, 11 Nov 2025 06:47:46 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 4443856816076
X-SMAIL-UIID: 08DCFD69D89C47D18758CA1CE2B1A955-20251111-064746-1
From: Hillf Danton <hdanton@sina.com>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org,
	Jann Horn <jannh@google.com>,
	Jan Kara <jack@suse.cz>,
	linux-kernel@vger.kernel.org,
	syzbot+1957b26299cf3ff7890c@syzkaller.appspotmail.com
Subject: Re: [PATCH 0/8] ns: fixes for namespace iteration and active reference counting
Date: Tue, 11 Nov 2025 06:47:34 +0800
Message-ID: <20251110224736.9086-1-hdanton@sina.com>
In-Reply-To: <20251110-elastisch-endeffekt-747abc5a614a@brauner>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 10 Nov 2025 09:41:56 +0100 Christian Brauner wrote:
> On Mon, Nov 10, 2025 at 06:55:26AM +0800, Hillf Danton wrote:
> > FYI namespace-6.19.fixes failed to survive the syzbot test [1].
> > 
> > [1] Subject: Re: [syzbot] [lsm?] WARNING in put_cred_rcu
> > https://lore.kernel.org/lkml/690eedba.a70a0220.22f260.0075.GAE@google.com/
> 
> This used a stale branch that existed for testing:
> 
> Tested on:
> 
> commit:         00f5a3b5 DO NOT MERGE - This is purely for testing a b..
>
Then feel free to show the commit id to be fed to syzbot.
	syz test https://github.com/brauner/linux.git ID-to-test

